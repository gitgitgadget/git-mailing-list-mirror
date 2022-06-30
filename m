Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA9C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiF3VTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiF3VTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0B45785
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so354055wmb.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=LMV5iBRuQpxuSPV5ejxnm51NvHv5s4keL7wq/0RwQ5I=;
        b=TCpLHbmcboFc3wUup5UmoasA/PfOiyGZXCXiCmyiXvbBu2Yw7Xnz9wILuNv1SFgZ/Z
         PU/YDvlScDtn+a5r7IR7FIWjaDDZ+K6uWP9YxRCNRxzeRcD05WibyRDQZjcmB0jfMo16
         j1fmtO7AVKnU8OuhP7fXeBbGqRvPAhZ41YlBytcm5wrfskyyMMOUR716xN2Nw6ZZTNua
         6iZtlmdCZlDarOhqjBdwisuGyUL2+akFY833LgizXxmQLeYk+UxWW9CxUEgyueYR0fEt
         +94Fmh1SMyaQ5oYp6zyMlmtCkmz0nGD4L+Ddqj+AJ/nQO53vzB3Fqrzj4uok1PYKwPj7
         4fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=LMV5iBRuQpxuSPV5ejxnm51NvHv5s4keL7wq/0RwQ5I=;
        b=7iesbuydmDRO5Ow8bmNRp4PdGfu1K893a2b+1yk1VaemKrgcSwtousL7ChjmrDX4JK
         gvdKv5WRLWULJvih43S815HU+GmfkbGeut6IV5Vh43OXlqR4Vz5tJk+7GMTrvp57DmU3
         XhkgdHFuJS/Gzge41LInyK2/IpfwFk33q/9+Z4YcP514GSFFAq8a4dgC3zzvnZvfp38N
         oN/r4e1DMYZg8S/5n/VWmEiIhwoQW8iZUhDlh3NOdlVKtLwncVmMjVyTY6UkhoAY1zKG
         Kx2bN2Ya1heJULWayrR5gjGnbcT6LdSJDq6QW7Z1gpS/uy8zmDVBusEgRks/PSd29HeO
         55BQ==
X-Gm-Message-State: AJIora/pSsggBeArrEzYOoOBVU5Iplkf4BxaeB4DLLgzH3smidWEUlub
        VHcIugxZ3ZdJEZCnHcTcIDVAgUxVxx8=
X-Google-Smtp-Source: AGRyM1vFmyWBL4br6olRQgzIgkIr5GAzFagi5n0Iy12vu/WLO86XdmCQPAFx0bql/K6M4AJ335PMzQ==
X-Received: by 2002:a05:600c:4ecc:b0:3a1:68bf:d17a with SMTP id g12-20020a05600c4ecc00b003a168bfd17amr12069361wmq.154.1656623981652;
        Thu, 30 Jun 2022 14:19:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q13-20020adfdfcd000000b0021b8cd8a068sm20217777wrn.49.2022.06.30.14.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:40 -0700 (PDT)
Message-Id: <85775255f18e0a6a6b2e65394bc18ec440dba99d.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:21 +0000
Subject: [PATCH v2 01/18] git-submodule.sh: remove unused
 sanitize_submodule_env()
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

The sanitize_submodule_env() function was last used before
b3c5f5cb048 (submodule: move core cmd_update() logic to C,
2022-03-15), let's remove it.

This also allows us to remove clear_local_git_env() from
git-sh-setup.sh. That function hasn't been documented in
Documentation/git-sh-setup.sh, and since 14111fc4927 (git: submodule
honor -c credential.* from command line, 2016-02-29) it had only been
used in the sanitize_submodule_env() function being removed here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-sh-setup.sh  |  7 -------
 git-submodule.sh | 11 -----------
 2 files changed, 18 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d92df37e992..ecb60d9e3cb 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -285,13 +285,6 @@ get_author_ident_from_commit () {
 	parse_ident_from_commit author AUTHOR
 }
 
-# Clear repo-local GIT_* environment variables. Useful when switching to
-# another repository (e.g. when entering a submodule). See also the env
-# list in git_connect()
-clear_local_git_env() {
-	unset $(git rev-parse --local-env-vars)
-}
-
 # Generate a virtual base file for a two-file merge. Uses git apply to
 # remove lines from $1 that are not in $2, leaving only common lines.
 create_virtual_base() {
diff --git a/git-submodule.sh b/git-submodule.sh
index fd0b4a2c947..bc436c4ca47 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -56,17 +56,6 @@ isnumber()
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
 }
 
-# Sanitize the local git environment for use within a submodule. We
-# can't simply use clear_local_git_env since we want to preserve some
-# of the settings from GIT_CONFIG_PARAMETERS.
-sanitize_submodule_env()
-{
-	save_config=$GIT_CONFIG_PARAMETERS
-	clear_local_git_env
-	GIT_CONFIG_PARAMETERS=$save_config
-	export GIT_CONFIG_PARAMETERS
-}
-
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
-- 
gitgitgadget

