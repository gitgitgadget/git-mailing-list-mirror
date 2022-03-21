Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20430C433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiCUUg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346553AbiCUUgV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:36:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5E689095
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so205771wmp.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gi4JjWZexXHHxh78V+mPSCA2sBHMdK6G+amZTKC2cfA=;
        b=GFj/kP9FMM2rWc6vHjnnmHCYpykXJ2oPVmR8vPGS1H9zEcOl+FdfDIjhDhQgmb28RI
         DTYHHX7LL7nhAEo6cvkn7iK03MlsTkPzgSVKP3Tig0s2IH0EBYFrJA8LyFyKuxasDnl6
         K6hCFavsRNzsrfREMUIoeYcgg2Bo6YcQCxdMLNXWEMY42GD5yf/SqWDV8/VLgaacMTDJ
         6SF5xLzpCYwb7hgHkN4SowYx8Id3T7f4eUCqaGRyobShId4bNQapLvoIsUKBblp4O7Tu
         KehacOVUPBtOfnWxvK1M2qm2ch1/lbzJAkDXC1hRabn9MJM9weBgb9vcjnrcSdE+8p/c
         PXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gi4JjWZexXHHxh78V+mPSCA2sBHMdK6G+amZTKC2cfA=;
        b=gxQD/Ea9zj/mFp/2/doFqPdlnjU7Qn3tVYU/EDpAD/Znna54jQsvIhMNYDVlInUdIm
         uxY5X+fbf2XUqKE/sk84vFaGJlb8r3YK7KCp7gGR6f6ykQRLDyCmuxpxT6SdEoVNI1BY
         DEPSstxLpkqme2e3xXhA2ZY7BDyV+pWQYcSSxcezawYV1T+A9uSe74myoPbFs88vBHTA
         2uNvBD1CnzcUGTZYzKV7IysNfyhZaxXzaBLKFdqWJvbXb4NP+DHRh5exzY5yonagkVXJ
         XWRTlKMIiSeBybDYAiYh068VzTH1UYim1tAq4D+altnlDAqeAjslc9TlUAdZ7gfMzpAz
         KPug==
X-Gm-Message-State: AOAM5329HSFXk03J6yum0F//Mg47fhY7wszCUbghqBep1pCmI8KrKGiI
        +v0HJhxjS5KXyoOSpoeq1ckKh3R66v0=
X-Google-Smtp-Source: ABdhPJzczAIaerW+JK3m+L+DWLfPeMG//biOtdNHeWt05StIMZ2K2lY2is73TlGSSLa0cEOD8usesg==
X-Received: by 2002:a1c:e908:0:b0:38c:782c:2a62 with SMTP id q8-20020a1ce908000000b0038c782c2a62mr723434wmc.135.1647894893786;
        Mon, 21 Mar 2022 13:34:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020adfbd8d000000b002040daf5dffsm6906631wrh.18.2022.03.21.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:34:53 -0700 (PDT)
Message-Id: <d9bebd4b4e0000850e076ee642b20b09f71db700.1647894889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 20:34:47 +0000
Subject: [PATCH 2/4] reset: deprecate 'reset.quiet' config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Remove the 'reset.quiet' config option, remove '--no-quiet' documentation in
'Documentation/git-reset.txt'. In 4c3abd0551 (reset: add new reset.quiet
config setting, 2018-10-23), 'reset.quiet' was introduced as a way to
globally change the default behavior of 'git reset --mixed' to skip index
refresh.

However, now that '--quiet' does not affect index refresh, 'reset.quiet'
would only serve to globally silence logging. This was not the original
intention of the config setting, and there's no precedent for such a setting
in other commands with a '--quiet' option, so it appears to be obsolete.

In addition to the options & its documentation, remove 'reset.quiet' from
the recommended config for 'scalar'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/config.txt       | 2 --
 Documentation/config/reset.txt | 2 --
 Documentation/git-reset.txt    | 5 +----
 builtin/reset.c                | 1 -
 contrib/scalar/scalar.c        | 1 -
 t/t7102-reset.sh               | 3 +--
 6 files changed, 2 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/config/reset.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f0fb25a371c..43f5e6fd6d3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -495,8 +495,6 @@ include::config/repack.txt[]
 
 include::config/rerere.txt[]
 
-include::config/reset.txt[]
-
 include::config/sendemail.txt[]
 
 include::config/sequencer.txt[]
diff --git a/Documentation/config/reset.txt b/Documentation/config/reset.txt
deleted file mode 100644
index 63b7c45aac2..00000000000
--- a/Documentation/config/reset.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-reset.quiet::
-	When set to true, 'git reset' will default to the '--quiet' option.
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index bc1646c3016..f4aca9dd35c 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -105,10 +105,7 @@ OPTIONS
 
 -q::
 --quiet::
---no-quiet::
-	Be quiet, only report errors. The default behavior is set by the
-	`reset.quiet` config option. `--quiet` and `--no-quiet` will
-	override the default behavior.
+	Be quiet, only report errors.
 
 --refresh::
 --no-refresh::
diff --git a/builtin/reset.c b/builtin/reset.c
index 7c3828f6fc5..e824aad3604 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -423,7 +423,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_reset_config, NULL);
-	git_config_get_bool("reset.quiet", &quiet);
 	git_config_get_bool("reset.refresh", &refresh);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 7db2a97416e..58ca0e56f14 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -152,7 +152,6 @@ static int set_recommended_config(int reconfigure)
 		{ "pack.useBitmaps", "false", 1 },
 		{ "pack.useSparse", "true", 1 },
 		{ "receive.autoGC", "false", 1 },
-		{ "reset.quiet", "true", 1 },
 		{ "feature.manyFiles", "false", 1 },
 		{ "feature.experimental", "false", 1 },
 		{ "fetch.unpackLimit", "1", 1 },
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 8b62bb39b3d..9e4c4deee35 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -488,8 +488,7 @@ test_expect_success '--mixed refreshes the index' '
 	# Verify default behavior (without --[no-]refresh or reset.refresh)
 	test_reset_refreshes_index &&
 
-	# With --quiet & reset.quiet
-	test_reset_refreshes_index "-c reset.quiet=true" &&
+	# With --quiet
 	test_reset_refreshes_index "" --quiet
 '
 
-- 
gitgitgadget

