Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05BBC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbiF3VU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiF3VUC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:20:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7530B4F192
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:20:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i25so339616wrc.13
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SVX8g/qQwXmjyZ9syayLZhneY1k1gLJJ1yvEoBqxXMU=;
        b=fMRVlOBJ4H6pk6L4R4/Ar7IjtQerkh9zIHDzQAFjntOVyne/j9niL7Kb7potkpmqYO
         JaR3PnNwALd3s8SpChdmuXb1MIDDuDxN/0An2TKRrFnPhTCGniD7oysbTyeA8gBJgXIw
         /yGunpxm3murLtKu53DUSW2I1tmKAnxKq3KI1ZoETMI3MG2OEsd/sPDXtHuW7fWq9rk2
         JzdpXiQfJkyurPxsNej7MhX+PSQTat28FvZWvj8gQeiNluSbxFgc1cEb6YGkm8ukZey4
         ZiIoG28qjdCRanF+q75/7r+xAf+xE8Zy44mEAYdiihL75PI4Q/tTSMTFsyU7i9F7kpL6
         5/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SVX8g/qQwXmjyZ9syayLZhneY1k1gLJJ1yvEoBqxXMU=;
        b=nm8P7Jt1WIQ+sqz8KqVQeOemLk4ejJNtGYmUxQKnIBDMt/gimnxtFfoy4muNus641T
         DKOk/eLuImwHWWB81iT7I6Gp6WRP5/jrMxpTQjQpw+OUUngJ4pkKv0twwNvZ6FBF2TJK
         32IccmXoqA2sU2RNLtlriRenzICl8fDK2n+mD8LQQk+poKgZ3Dx/ZLbsYS23bjFmG3Ld
         PdFIi7/70DAqm4iRpA/+OnYJIwBNxHnEDiblM571B4FSLCytt/6XxBFfmDr5i9Vr/O6S
         Cwk/5Nv/pMhNi5cPpMrrGzFqvtgAMLZ0f3oRRSvIRmNYyCpbL5g+3Et2EjKW5YiBizqq
         xp0A==
X-Gm-Message-State: AJIora++2xm7/bhbyF61jjFrR8O3VHMKTue3orQp53jwejpPKigxdA+z
        4q6SOAfCj6vuMYvf8fhl7tHyIBY/Mp4=
X-Google-Smtp-Source: AGRyM1vrBKwaK/89YFmN0gwBiU7ZebHzaPl5hbhUaVinebfQI3tj2N2l/Ax4v1mk6CTD20WWb9Azmw==
X-Received: by 2002:a5d:6da8:0:b0:21d:2598:4e28 with SMTP id u8-20020a5d6da8000000b0021d25984e28mr10937487wrs.373.1656623998798;
        Thu, 30 Jun 2022 14:19:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm19533295wrb.70.2022.06.30.14.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:58 -0700 (PDT)
Message-Id: <85e65f143b602be28c7551729c5e3357118a755b.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:36 +0000
Subject: [PATCH v2 16/18] submodule--helper: remove unused
 SUPPORT_SUPER_PREFIX flags
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index aad431f898e..360309195fb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3379,15 +3379,15 @@ static struct cmd_struct commands[] = {
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
-- 
gitgitgadget

