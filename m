Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C14C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiGACMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiGACMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:12:24 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0435C9F5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id jg5-20020a17090326c500b0016a020648bcso591548plb.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=JZx8jZJDz2rNmvvwjsJHtZPhT7Qj+ZSMSQlTgAKxanw=;
        b=Ix8yHpl11hocEdVwKGVr/kVHwfxViXVOlqFtm1hv3OEPFXvCI5M9e7Tm5+J+b2GDT0
         ZEr8FgHSN2om056NlsEg/Qv6KCkilk/Cl5vgxBUMYYnULF+SAhq5a7TrZ3KNstoa45Ar
         Zge8jyylrK85fyvXVUygbt78KtARhMmUZMfZBfrleTRTK1uSwvUJuzWJh79OQQJrwQsg
         +DKbxtQ8FhUYqgP6txMAXp38k9xhWi6or+PvvMvKVC8HXZMifZZcyo3u2dBXvCkadAB/
         bR0+s5LjxYSkGhzxhw3x6m+dmwGgWwlcFEjL6JIZp9kK3ieBAWxYvRk5lzN2/MSIud6u
         kx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=JZx8jZJDz2rNmvvwjsJHtZPhT7Qj+ZSMSQlTgAKxanw=;
        b=k/N7vZdEqvVQrLcd3AGdBmM2QLKkVGw4qdmmtd3BYdwviX/i8Wez01cijlOdJhLK81
         wkkWsmP2b4zPubw4TBp59TjAI7fRZvt0y8qfYAXd+5U/K3zomIayoTy4VqZf1IUMIVuo
         juRidKJY3eJVA2Bb8IpJfNnE/BCHNWBJoVBbUxU3XQHvhJQhdgYOvM/1oXbBmScBVyah
         +SjT4DZ33+Fzn2Q2K37mGvBRFSiLuIdM+cD2TB0JH6x6kA9w+f9hu7ezoZHdEIxDVvh5
         mAdDqeSYRCMr8RWbszumLAriRbFh2y131gVDE1WZx/7Do6u/6+usUpq199Ep5i74wh1C
         e/kA==
X-Gm-Message-State: AJIora9IMP8umNkdylkTz15+9wdz21ABxM7BhhkqTLSHUrdtYLF9aGaO
        E13XqXy3o26WBMzsCgzOjpB9zthxpgIbFH93lhrg2kZMq7BQFwzPxYDZIDWBUCtKyJhBcfCBXE8
        Ol18lB19xjQvsOH0CaxtGF8+4N1CkZN4Pc0V9LAmUMtblY8HafjfE1utR45JieN4=
X-Google-Smtp-Source: AGRyM1uo9Nz5EHbzl7YUO9VQAkufK4vPhtdLn+qc6NR4mXzUnMF3NBBVg/CVopNn9RiD7fsB5fSBvj3Uleaa5A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1908:b0:525:5dad:cb1c with SMTP
 id y8-20020a056a00190800b005255dadcb1cmr18544493pfi.47.1656641538070; Thu, 30
 Jun 2022 19:12:18 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:11:55 -0700
In-Reply-To: <20220701021157.88858-1-chooglen@google.com>
Message-Id: <20220701021157.88858-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220630221147.45689-1-chooglen@google.com> <20220701021157.88858-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 5/7] submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Remove the SUPPORT_SUPER_PREFIX flag from "add", "init" and
"summary". For the "add" command it hasn't been used since [1],
likewise for "init" and "summary" since [2] and [3], respectively.

As implemented in 74866d75793 (git: make super-prefix option,
2016-10-07) the SUPPORT_SUPER_PREFIX flag in git.c applies for the
entire command, but as implemented in 89c86265576 (submodule helper:
support super prefix, 2016-12-08) we assert here in
cmd_submodule__helper() that we're not getting the flag unexpectedly.

1. 8c8195e9c3e (submodule--helper: introduce add-clone subcommand,
   2021-07-10)
2. 6e7c14e65c8 (submodule update --init: display correct path from
   submodule, 2017-01-06)
3. 1cf823d8f00 (submodule: remove unnecessary `prefix` based option
   logic, 2021-06-22)

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 65350bde4b..a7b40482b8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3378,15 +3378,15 @@ static struct cmd_struct commands[] =3D {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
-	{"add", module_add, SUPPORT_SUPER_PREFIX},
+	{"add", module_add, 0},
 	{"update", module_update, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
-	{"init", module_init, SUPPORT_SUPER_PREFIX},
+	{"init", module_init, 0},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
-	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
+	{"summary", module_summary, 0},
 	{"push-check", push_check, 0},
 	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
--=20
2.37.0.rc0.161.g10f37bed90-goog

