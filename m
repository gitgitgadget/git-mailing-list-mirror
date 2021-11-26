Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9B2C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbhKZWsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245258AbhKZWqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290EFC06174A
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s13so21598038wrb.3
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pMR9zuQsJAszk2oL5wtiWy1FvVXCWJmEGTYfzT+/YRQ=;
        b=C1zCktmnlm3WjkDlkMzV6vbuLe1/e/lz3OPUYTGlMDrGo0mX9PcEUeTli4mBs+NZYW
         3T3eDDc93ZvCQuaGrTtENxzOX/Kn24dlmLh7f7zViip/OJ227ISf4Jgt6c82u6MKvGCz
         OSNayIMuGEQOnfOia9orA2U2yGX9GmBdn8YZjACVan+wMW9lYP2Hf/o1mjQomFgWGMNu
         P5jc1oJDnycLMMmnOdAwrcQobNNrv4CSWcMToTSUk1kghLLsKztOPk5qauKBRS4ptiWI
         ridFUV1/BW+Snq9qXQcWfT7y7duZDpHiioaAHhAndYMBTrltRC/AIEZbPnGmWWecseN3
         N5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pMR9zuQsJAszk2oL5wtiWy1FvVXCWJmEGTYfzT+/YRQ=;
        b=6L2i6wsiUCqpTqCNcoTXtbxQ+g5TnLDbN55DOdrE37jBmOH3Lirfz0nHKk51e2rqR9
         izqyf/RvamqtJjWz8pP8lHgfgHSzWJKEubAHrxdu/8Md6o5u1sNu9feKFXZPi648BcMt
         weLMEfq7kJsNbeDInLMVrSjaHEp3DQJqdwE43kPxRPhm603durw0TI383yR3hTC7vz1u
         kvAqvZQka0ddiTuJ3Vpvno2OAUEQxoUaD4JO0RtYs3hXdzcGYpxYlY2tO3C9gvg9UENg
         2R8/zM4GTCMf2hZWd6lyrPaYRz0hh4fMPC2zEEAZ84b0Ui7WzGqR5QoN/zf1c+KS2UvJ
         uO0Q==
X-Gm-Message-State: AOAM532bhUPaQ0wMprcSYcx54vl5bCeAMYwEpfz+SccyMvMtF3Pfr9wg
        DVpK/sIKj/OlhpNm/BeXPiR0JvikZIc=
X-Google-Smtp-Source: ABdhPJwXc4Lw6bgg6TTtZc18CCNgAWJtlMf5umwqEWwb5sKwTnmjQ7B65QeDKWNbOaleVTCtvJ3xZA==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr8693909wro.395.1637966471599;
        Fri, 26 Nov 2021 14:41:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m34sm16145486wms.25.2021.11.26.14.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:11 -0800 (PST)
Message-Id: <d4e50b4053d37a1a57ba552ae42bbd6921a719f9.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:41:01 +0000
Subject: [PATCH v3 10/11] dir: new flag to remove_dir_recurse() to spare the
 original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

remove_dir_recurse(), and its non-static wrapper called
remove_dir_recursively(), both take flags for modifying its behavior.
As with the previous commits, we would generally like to protect
the original_cwd, but we want to forced user commands (e.g. 'git rm -rf
...') or other special cases to remove it.  Add a flag for this purpose.
After reading through every caller of remove_dir_recursively() in the
current codebase, there was only one that should be adjusted and that
one only in a very unusual circumstance.  Add a pair of new testcases to
highlight that very specific case involving submodules && --git-dir &&
--work-tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rm.c         |  3 ++-
 dir.c                | 12 +++++++++---
 dir.h                |  3 +++
 t/t2501-cwd-empty.sh |  5 -----
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 3d0967cdc11..b4132e5d8ee 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -399,12 +399,13 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only) {
 		int removed = 0, gitmodules_modified = 0;
 		struct strbuf buf = STRBUF_INIT;
+		int flag = force ? REMOVE_DIR_PURGE_ORIGINAL_CWD : 0;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.entry[i].name;
 			if (list.entry[i].is_submodule) {
 				strbuf_reset(&buf);
 				strbuf_addstr(&buf, path);
-				if (remove_dir_recursively(&buf, 0))
+				if (remove_dir_recursively(&buf, flag))
 					die(_("could not remove '%s'"), path);
 
 				removed = 1;
diff --git a/dir.c b/dir.c
index 97d6b71c872..52064345a6b 100644
--- a/dir.c
+++ b/dir.c
@@ -3204,6 +3204,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	int ret = 0, original_len = path->len, len, kept_down = 0;
 	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
 	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
+	int purge_original_cwd = (flag & REMOVE_DIR_PURGE_ORIGINAL_CWD);
 	struct object_id submodule_head;
 
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
@@ -3259,9 +3260,14 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	closedir(dir);
 
 	strbuf_setlen(path, original_len);
-	if (!ret && !keep_toplevel && !kept_down)
-		ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
-	else if (kept_up)
+	if (!ret && !keep_toplevel && !kept_down) {
+		if (!purge_original_cwd &&
+		    startup_info->original_cwd &&
+		    !strcmp(startup_info->original_cwd, path->buf))
+			ret = -1; /* Do not remove current working directory */
+		else
+			ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
+	} else if (kept_up)
 		/*
 		 * report the uplevel that it is not an error that we
 		 * did not rmdir() our directory.
diff --git a/dir.h b/dir.h
index d6a5d03bec2..8e02dfb505d 100644
--- a/dir.h
+++ b/dir.h
@@ -495,6 +495,9 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
 /* Remove the contents of path, but leave path itself. */
 #define REMOVE_DIR_KEEP_TOPLEVEL 04
 
+/* Remove the_original_cwd too */
+#define REMOVE_DIR_PURGE_ORIGINAL_CWD 0x08
+
 /*
  * Remove path and its contents, recursively. flags is a combination
  * of the above REMOVE_DIR_* constants. Return 0 on success.
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index cba817ff734..8f299fd3b19 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -282,11 +282,6 @@ test_submodule_removal () {
 	test_status=
 	test $path_status = dir && test_status=test_must_fail
 
-	# Actually, while path_status == dir && test_status=test_must_fail
-	# reflect our desired behavior, current behavior is:
-	path_status=missing
-	test_status=
-
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf .git/modules/my_submodule" &&
 
-- 
gitgitgadget

