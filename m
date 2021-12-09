Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6446CC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhLIFMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhLIFMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:19 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E2C061B38
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so3229187wmd.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=LtJ2Ytja7XxoTFS8hA7vlNEy0D9a7lKx3y0L/XUYfpM=;
        b=hB2DiCicWCoQpqxTTKHXtoaq3YjeylDJvwTS2i+1xNDY7P2Z/CSwRQculmsLeJ98a1
         FnAJJOC1eGIVR7ooozDc5LKjc9D1zJiMvWV+ElJ0kL4m8UnCRyLzRG2xy423XWPCjFOU
         xrV9V9Q+FkE/M73fLdotstcx5PeTZ/yOiIswJ+gzt7pgXUb8IWFstMM1NJbP0qJ8Dtb4
         /+kIThg3SST7m/rKRywkiUQyb8SidOXAqAe/RePQ2IOMWfykQnA7Tb4voKj1V9mxSgwy
         TA1BTkQTg4GwcBcKB2p8ZIVQWH4po29VPugia8PDjQ/MQ8aGb8UmFP6DYM+SMIXa83yG
         wL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=LtJ2Ytja7XxoTFS8hA7vlNEy0D9a7lKx3y0L/XUYfpM=;
        b=fOJ1AEGyO/VoZlGYPDE4UGHLVoQBl6z38//zyGryputmlVO0bGFhl8oXHM5nT/I9y2
         ZOvWUd+Nal0Wy4SPNsVrPWHgx59y1ydlk/VUuDdlmLRFT9c+/8zp7H6Maw7qcrcSsTls
         n3t3GLgSWKThVYR5oSIhuvBNrqit5rN1V10Ju+SOE6V7Qa18e1YFE2cVdzJ5IOR/ZRdw
         qrWHW+BARbkLBeAPdb+v+GsgLJ9FH8zDkihaxQqcLhl7m/w2foFnSCDZDWd4W5KRN98s
         7yKOGUAx0W/ZjEmdk8+zej32y40FyJSh/OTxSGBoHAsLLa82CuJERZcjLCpaSLz7ntZV
         /xbw==
X-Gm-Message-State: AOAM5318EIFhzbO3YPmlo1u/jmeP+EqqVw3+o/RrmhvFywmZH77YxKw3
        eBPKfB6tjPdHqCKSk0WIxNBw78jyrRE=
X-Google-Smtp-Source: ABdhPJweocQh8EXjFncIR3edHLve1P3o9oDeZcEhuPBT1eo8U/P5y0jfeA/FE456+vZZNBPfHxInow==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr4282485wmj.9.1639026522608;
        Wed, 08 Dec 2021 21:08:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm4733461wrr.47.2021.12.08.21.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:42 -0800 (PST)
Message-Id: <d4f8784a6e4e7d9439660871d5d41fd4fe54664c.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:30 +0000
Subject: [PATCH v6 06/11] clean: do not attempt to remove
 startup_info->original_cwd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c      | 44 +++++++++++++++++++++++++++++++++++---------
 t/t2501-cwd-empty.sh |  5 +++--
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98a2860409b..3ff02bbbffe 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -36,6 +36,8 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
+static const char *msg_skip_cwd = N_("Refusing to remove current working directory\n");
+static const char *msg_would_skip_cwd = N_("Would refuse to remove current working directory\n");
 
 enum color_clean {
 	CLEAN_COLOR_RESET = 0,
@@ -153,6 +155,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 {
 	DIR *dir;
 	struct strbuf quoted = STRBUF_INIT;
+	struct strbuf realpath = STRBUF_INIT;
+	struct strbuf real_ocwd = STRBUF_INIT;
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	struct string_list dels = STRING_LIST_INIT_DUP;
@@ -231,16 +235,36 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	strbuf_setlen(path, original_len);
 
 	if (*dir_gone) {
-		res = dry_run ? 0 : rmdir(path->buf);
-		if (!res)
-			*dir_gone = 1;
-		else {
-			int saved_errno = errno;
-			quote_path(path->buf, prefix, &quoted, 0);
-			errno = saved_errno;
-			warning_errno(_(msg_warn_remove_failed), quoted.buf);
+		/*
+		 * Normalize path components in path->buf, e.g. change '\' to
+		 * '/' on Windows.
+		 */
+		strbuf_realpath(&realpath, path->buf, 1);
+
+		/*
+		 * path and realpath are absolute; for comparison, we would
+		 * like to transform startup_info->original_cwd to an absolute
+		 * path too.
+		 */
+		 if (startup_info->original_cwd)
+			 strbuf_realpath(&real_ocwd,
+					 startup_info->original_cwd, 1);
+
+		if (!strbuf_cmp(&realpath, &real_ocwd)) {
+			printf("%s", dry_run ? _(msg_would_skip_cwd) : _(msg_skip_cwd));
 			*dir_gone = 0;
-			ret = 1;
+		} else {
+			res = dry_run ? 0 : rmdir(path->buf);
+			if (!res)
+				*dir_gone = 1;
+			else {
+				int saved_errno = errno;
+				quote_path(path->buf, prefix, &quoted, 0);
+				errno = saved_errno;
+				warning_errno(_(msg_warn_remove_failed), quoted.buf);
+				*dir_gone = 0;
+				ret = 1;
+			}
 		}
 	}
 
@@ -250,6 +274,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
 	}
 out:
+	strbuf_release(&realpath);
+	strbuf_release(&real_ocwd);
 	strbuf_release(&quoted);
 	string_list_clear(&dels, 0);
 	return ret;
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index e4502d24d57..b1182390ba3 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -230,8 +230,9 @@ test_incidental_untracked_dir_removal () {
 }
 
 test_expect_success 'clean does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal failure \
-		git -C .. clean -fd -e warnings . >warnings
+	test_incidental_untracked_dir_removal success \
+		git -C .. clean -fd -e warnings . >warnings &&
+	grep "Refusing to remove current working directory" warnings
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
-- 
gitgitgadget

