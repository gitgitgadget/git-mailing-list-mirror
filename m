Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C0CC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAAB610A5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhJGVRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhJGVRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:17:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166D9C061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 14:15:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t8so23257907wri.1
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=49LzXIoxEJ8FYGTP5PwYzcjg+epu0jj2WCce6da3r9c=;
        b=SN6+U3CsyDe+rzqZpCOo8H7Q/fM0YtzIUDDUd+B0+shAHwSPWwp3ckJkvXtY3B3VHX
         KS6UJmMxo2F6+Y9vHwXY5cqRdSVxfqQ9vytH3EkhW3lqweOdcK5rHi2PXxTX2chQHonP
         13kYxXueNmklbfXNZfw7X076PxfnYkiqGG+KW4N8JHBdNLdaMwSE8SF7Qv71aURoKs82
         dx8L1g+4VhIFfmwnpeL41NdRJpxzzd5Y/nLLuoKKFKY0zGCRbMguE8o0iBkxm0prYRlQ
         bW6IstoBg89yg5Hdbu6oSraYJNuTHR0NIVbYsDwn0Bb0zItU2VrLtAgztQbqvZZz/Uwl
         birA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=49LzXIoxEJ8FYGTP5PwYzcjg+epu0jj2WCce6da3r9c=;
        b=Dd+L0IAYIJQQ/Mgc6yFIKGPysQ5dSV0fmWbvvyL3tE/Xda5KjCqaz3fB3/lxCmE6Tf
         +u6bIkH/EOnHr3VwvBZHfyY8iPYc7mw6l9CFyEgRZLiP8nzp9h9iCdDeHHzIdz8uB3/J
         YVrGTRoMvzvAZki6xWX1W2Jup6CYBNaNvWmwIu7uhlXWY6uDVhBKMCKB3hcPL7SerfDZ
         t6jRXmwnPofMlMc1PWJxPCy1m5d6e+Mne2LFmStw6fPmjCTr7bdyMX/UUptNBb4ihQB1
         YODlqwxxoQybf7t1FvT5zIOObPxoh4EwACFT5VhQmrAVs1yZlfzKN5dZq5xLFOXVvWHB
         VoTg==
X-Gm-Message-State: AOAM530SGYHd/XLheodZ1MHMUUCa/SGlMWVtax85t3lt7EKGDJIoIJ5S
        o85QrL585AQnfb4Qh6c0SC3PYndoOd0=
X-Google-Smtp-Source: ABdhPJy7XM31ruM3ZRNP7FnR7yAdMqBqYX/rZ7KO1akCEH0FhLoITEbtwNhhiBr2UcOP2FHkO2OzFg==
X-Received: by 2002:adf:a390:: with SMTP id l16mr8163218wrb.72.1633641342721;
        Thu, 07 Oct 2021 14:15:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i92sm436285wri.28.2021.10.07.14.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:15:42 -0700 (PDT)
Message-Id: <014a408ea5d9894197c60f8d712749ea3cc39c9d.1633641339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 21:15:33 +0000
Subject: [PATCH v3 3/8] update-index: add --force-full-index option for
 expand/collapse test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a new `--force-full-index` option to `git update-index`, which skips
explicitly setting `command_requires_full_index`. This option, intended for
use in internal testing purposes only, lets `git update-index` run as a
command without sparse index compatibility implemented, even after it
receives updates to otherwise use the sparse index.

The specific test `--force-full-index` is intended for - `t1092 -
sparse-index is expanded and converted back` - verifies index compatibility
in commands that do not change the default (enabled)
`command_requires_full_index` repo setting. In the past, the test used `git
reset`. However, as `reset` and other commands are integrated with the
sparse index, the command used in the test would need to keep changing.
Conversely, the `--force-full-index` option makes `git update-index` behave
like a not-yet-sparse-aware command, and can be used in the test
indefinitely without interfering with future sparse index integrations.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-update-index.txt       |  5 +++++
 builtin/update-index.c                   | 11 +++++++++++
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d97..06255e321a3 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -24,6 +24,7 @@ SYNOPSIS
 	     [--[no-]fsmonitor]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
+	     [--force-full-index]
 	     [-z] [--stdin] [--index-version <n>]
 	     [--verbose]
 	     [--] [<file>...]
@@ -170,6 +171,10 @@ time. Version 4 is relatively young (first released in 1.8.0 in
 October 2012). Other Git implementations such as JGit and libgit2
 may not support it yet.
 
+--force-full-index::
+	Force the command to operate on a full index, expanding a sparse
+	index if necessary.
+
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
 	separated with NUL character instead of LF.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..32ada3ead77 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -964,6 +964,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int split_index = -1;
 	int force_write = 0;
 	int fsmonitor = -1;
+	int use_default_full_index = 0;
 	struct lock_file lock_file = LOCK_INIT;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
@@ -1069,6 +1070,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		{OPTION_SET_INT, 0, "no-fsmonitor-valid", &mark_fsmonitor_only, NULL,
 			N_("clear fsmonitor valid bit"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
+		OPT_SET_INT(0, "force-full-index", &use_default_full_index,
+			N_("run with full index explicitly required"), 1),
 		OPT_END()
 	};
 
@@ -1082,6 +1085,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (newfd < 0)
 		lock_error = errno;
 
+	/*
+	 * If --force-full-index is set, the command should skip manually
+	 * setting `command_requires_full_index`.
+	 */
+	prepare_repo_settings(r);
+	if (!use_default_full_index)
+		r->settings.command_requires_full_index = 1;
+
 	entries = read_cache();
 	if (entries < 0)
 		die("cache corrupted");
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 889079f55b8..4aa4fef7b4f 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -635,7 +635,7 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	init_repos &&
 
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		git -C sparse-index -c core.fsmonitor="" update-index --force-full-index &&
 	test_region index convert_to_sparse trace2.txt &&
 	test_region index ensure_full_index trace2.txt
 '
-- 
gitgitgadget

