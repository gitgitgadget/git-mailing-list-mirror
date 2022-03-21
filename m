Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9584DC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352859AbiCUUg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348507AbiCUUgW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:36:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA43F30D
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h23so21689250wrb.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SMZx8dMbZJ+kgfSdPd4xnWcYXhFv65RwZsTARc7yZck=;
        b=hi5T//F0A4vqdLr3DiWFvT+MnXcQXtqU0gL5nRTf2k32ymnYUKxFuSxue5u28Zu7CG
         yHPKXBS0FkX8q26JusR2Kxw0BdMXy6claGQk8XNh+R4pf5KBMI7zKsLuEfx4RFRE0NzC
         ilLfntTFZWe8BlYdgD4khdN7xX9KTiy1aPbXCZHkv7cQs85inyf5cKG1l7SBgMAovm83
         UL+ch3ZtmKLTwicFBxgEWxtEdkYO/i172V/I9j1kqbbVMM/4zA9CNLwMsXAntTCfNU9L
         lf6OsDtIG7HEly1BlTZlH0KINsJcFZTPXM7KCtllT+Uw9rlICdnLjqhSaOIbSg3WBAYh
         X9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SMZx8dMbZJ+kgfSdPd4xnWcYXhFv65RwZsTARc7yZck=;
        b=LE498KqKxSahuQ8YeEWgZQI3Buslx69WNcV0R2/Fl4tkhIo1zGvZBQa5FjgA1K6dpK
         MAhmy4uLaFvJeOtCB4iZua7lay4RNCo1zT3x5Uxwp36tl3bMnr3EhmJnIyGS66IKIXHJ
         xm4D6Al0rCQOuazgCsJqAc7Q5PhFS/arZ6TLpwnDnALcQmTiICOIM85nr5q9o90PzIW+
         2tjJsRR1v5uVgSOf4neunLsqnvZTzDxH+Vg5eTiAHLISTNVvxG/uY/r/KatXtxkKc1/r
         GN4OWfB58ZvhoCbKxBvl+oX5xBBws/0+EPQ4Kig4vUevrajJBPFwjULtbL2xds3Q5rNj
         jrpw==
X-Gm-Message-State: AOAM533Hlm7dWeDu6tfjTjQw5YiXOwclY0+/GPDVEkW5Dtsh0TAJv460
        EnvD0UDkzG7DiqsmqyTh6esamTDlvs8=
X-Google-Smtp-Source: ABdhPJy47dbhpRiHer+p+rShjy7gi3cKIEY/TwmYTFJgtOteOa04VYmq0IcEn7DBFheJRQNOdJFP/w==
X-Received: by 2002:a5d:668e:0:b0:203:d9c5:f475 with SMTP id l14-20020a5d668e000000b00203d9c5f475mr19174665wru.98.1647894894682;
        Mon, 21 Mar 2022 13:34:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c410700b0038c72ef3f15sm388084wmi.38.2022.03.21.13.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:34:54 -0700 (PDT)
Message-Id: <ecd3296fd25cc936aeb2f8ae160352a2326441c5.1647894889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 20:34:48 +0000
Subject: [PATCH 3/4] reset: deprecate 'reset.refresh' config option
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

Remove the 'reset.refresh' option, requiring that users explicitly specify
'--no-refresh' if they want to skip refreshing the index.

The 'reset.refresh' option was introduced in 101cee42dd (reset: introduce
--[no-]refresh option to --mixed, 2022-03-11) as a replacement for the
refresh-skipping behavior originally controlled by 'reset.quiet'.

Although 'reset.refresh=false' functionally served the same purpose as
'reset.quiet=true', it exposed [1] the fact that the existence of a global
"skip refresh" option could potentially cause problems for users. Allowing a
global config option to avoid refreshing the index forces scripts using 'git
reset --mixed' to defensively use '--refresh' if index refresh is expected;
if that option is missing, behavior of a script could vary from user-to-user
without explanation.

Furthermore, globally disabling index refresh in 'reset --mixed' was
initially devised as a passive performance improvement; since the
introduction of the option, other changes have been made to Git (e.g., the
sparse index) with a greater potential performance impact without
sacrificing index correctness. Therefore, we can more aggressively err on
the side of correctness and limit the cases of skipping index refresh to
only when a user specifies the '--no-refresh' option.

[1] https://lore.kernel.org/git/xmqqy2179o3c.fsf@gitster.g/

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-reset.txt |  4 +---
 builtin/reset.c             |  4 +---
 t/t7102-reset.sh            | 14 ++------------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f4aca9dd35c..df167eaa766 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -109,9 +109,7 @@ OPTIONS
 
 --refresh::
 --no-refresh::
-	Proactively refresh the index after a mixed reset. If unspecified, the
-	behavior falls back on the `reset.refresh` config option. If neither
-	`--[no-]refresh` nor `reset.refresh` are set, refresh is enabled.
+	Proactively refresh the index after a mixed reset. Enabled by default.
 
 --pathspec-from-file=<file>::
 	Pathspec is passed in `<file>` instead of commandline args. If
diff --git a/builtin/reset.c b/builtin/reset.c
index e824aad3604..54324217f93 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -423,7 +423,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_reset_config, NULL);
-	git_config_get_bool("reset.refresh", &refresh);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
@@ -529,8 +528,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
 				if (!quiet && advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
 					advise(_("It took %.2f seconds to refresh the index after reset.  You can use\n"
-						 "'--no-refresh' to avoid this.  Set the config setting reset.refresh to false\n"
-						 "to make this the default."), t_delta_in_ms / 1000.0);
+						 "'--no-refresh' to avoid this."), t_delta_in_ms / 1000.0);
 				}
 			}
 		} else {
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 9e4c4deee35..22477f3a312 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -493,19 +493,9 @@ test_expect_success '--mixed refreshes the index' '
 '
 
 test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
-	# Verify that --[no-]refresh and `reset.refresh` control index refresh
-
-	# Config setting
-	test_reset_refreshes_index "-c reset.refresh=true" &&
-	! test_reset_refreshes_index "-c reset.refresh=false" &&
-
-	# Command line option
+	# Verify that --[no-]refresh controls index refresh
 	test_reset_refreshes_index "" --refresh &&
-	! test_reset_refreshes_index "" --no-refresh &&
-
-	# Command line option overrides config setting
-	test_reset_refreshes_index "-c reset.refresh=false" --refresh &&
-	! test_reset_refreshes_index "-c reset.refresh=true" --no-refresh
+	! test_reset_refreshes_index "" --no-refresh
 '
 
 test_expect_success '--mixed preserves skip-worktree' '
-- 
gitgitgadget

