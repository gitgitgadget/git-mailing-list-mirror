Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB07C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiF3WMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiF3WMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:12:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F557229
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:12:04 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e18-20020a656492000000b003fa4033f9a7so260144pgv.17
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=qsjN5JsYUk4jDp207ShRF9SzkxXAqzbyDp1tK0cnssk=;
        b=tjFB+5Q0jKDjHKRfKPn3bJ0jp8HiTI0bJcklKhqBJcsY7ecAKuDD9EB901OsYEz1Ss
         CNZFRX6G7hgLqJCfP7rrdvmEaDs8yf3gCh5Tb+gSWm3bUYmRlqzwxz29nbuLODdCtVui
         4P+k3Hlc3w0r24rfv7Wv9lgpkh8pSEfQHsT5iFhu2ZK0ls2s0YKuQ/ObpN0hun1lMX73
         jzzDHdc52DHiToTRfCjL9UHONIVrxqkwIyqtLPjLuR3D3cToHh952f6aBfygI0t0vNco
         ylA+w94BJCA2eM+V2FJU/64xQRNMuLJ4wQvJiwxY2PF8/jlCHzys2fR5VyWwxArZli7L
         ZQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=qsjN5JsYUk4jDp207ShRF9SzkxXAqzbyDp1tK0cnssk=;
        b=E4ldWzNG2pVvkrzfaGOBz/4EAOSNzfNaJxtUTWiS3CyQWBQcgZMij+8pokQDctgl4q
         su/IscBoptkoML7DMTQG4hYpBYJ2Ajcge7NSs72E3LaorxxngoQZ6GTFE+pjkOs5onee
         iZGLGLhamabzUeC9Nq01XYGf9W0jIBPRi+tdl/1vHn6UqO3xXki1i14C1GIkF1xLPCFR
         i1a7q6gYOcxyq6bh5SY2EEJMvT876dkMigZ05GMBAAeELwZHMFswPqzEEc0LCMVYl25H
         h/On+ZxMo2mdOjVePHlKr1WH6tIRm72KpYhRELUUFMWcEv8/PPHQpNkp1qeDmoAXz6OV
         6UGg==
X-Gm-Message-State: AJIora/rmMCOqeTqWcWP7ICp9KzhZJyGRYjBkviOGIev+B7Afdx0F2mo
        D+eq0q6HY8O3q6ZGFiNLhIStyjb7ep/eo6Gi5Sum1T/VE1JxtuGP6Hl8ue8/eoYt+grkwksKP7Z
        0Jgqsdy3gM4MwHSv/NrXlyHCD+2UXjVKfM9oExEd/7HuDeljFhhIjOzkBo9hXZVw=
X-Google-Smtp-Source: AGRyM1uKS1w8kfVCqShiaSP7QXwDa3ZzJpRdc0DTkhvdUKOfRxxXruQdaCm8tW/liMueaLRIia3LaU7MqAogUw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:bf49:b0:168:d855:883b with SMTP
 id u9-20020a170902bf4900b00168d855883bmr17630919pls.79.1656627123712; Thu, 30
 Jun 2022 15:12:03 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:11:45 -0700
In-Reply-To: <20220630221147.45689-1-chooglen@google.com>
Message-Id: <20220630221147.45689-5-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com> <20220630221147.45689-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 4/6] submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags
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
index aad431f898..360309195f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3379,15 +3379,15 @@ static struct cmd_struct commands[] =3D {
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

