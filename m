Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D098C71153
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 13:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjH1NxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjH1Nwe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 09:52:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8918CC1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 06:52:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fefe898f76so31611485e9.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693230750; x=1693835550;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzoQNktzoSnHfC4+dATV7Vz0Easvz/lR5+PwLDO0idE=;
        b=mKx4dL0/KdGSKXrTeWAO6VxbwlDzf/re+s5BP8R8U9rGoU3zMVwTLiMGmGHjgbxbl6
         vlMhar7a6V1t9CS2LhD7pVwZh59tkh5vPNKVwN+wh5VkaubeV9WAgz3gDkMV5/VHJRmU
         rRvkdr9ZKLk40IkpfqQtsIigQelOx+uBnXS9ouWtl6MJa38KkIKl21bM5owHLW903XKN
         274uE/1ZDiNoepBVUv+4TORM9lI1arekSkFRxpqBPFUFarA0/l8ourXtEXRyxwTRuMWA
         RcBCA1RyJek+j2zSTmpCPpa3X3LcxFv/Pu3MgBEsTvrYNNatuSWJVx6Vd+OebfgnzGnK
         CVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230750; x=1693835550;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzoQNktzoSnHfC4+dATV7Vz0Easvz/lR5+PwLDO0idE=;
        b=QcBOVSFz71sJk0hslbgC38d2UX16DNn4eGXFQ/7yvR8uHHoJaaC+zU4gKfClv0XZGQ
         9jS1aT+vMznL1QSTU3a+Egh6E9vmyeG4jVayu1KU4Qe9oGRLzkyM0n+d4x5xY4/aiJrE
         1Yb991hBcNn2SUmECWYctLE3Y1inj2Pv4IE6+eO5y+hw4afMIvWD2ZiZL6VXSteUZ5++
         vGtJ4WZPabHWCwRZMaTajJ2hIMQhYkLgJXxjxyQgzrFhjfyyCBDrpQ4+9e47bEQMquA4
         zminjAhu+SzJd8fFbvGQ1IrjBUuX/CaJC4Us8HTaSzm6fakrxFSpevxwd2pfrevYAFqz
         /e2w==
X-Gm-Message-State: AOJu0YyVhGwPCceEUPKndqZo80rrbjbyknxlwQv6hOdM62ZCGqxU4BMK
        HJs5l2RiUMuCTcCtBKlkP9FuSeU3nZ0=
X-Google-Smtp-Source: AGHT+IECR6tVQdR9q96KWUbo0jikSjmM7U8AI1T1fy4ZeundAzxI/VNVWdKeRPBRhhjQDDK2+V83nQ==
X-Received: by 2002:a7b:c4c9:0:b0:3f6:9634:c8d6 with SMTP id g9-20020a7bc4c9000000b003f69634c8d6mr19647394wmk.18.1693230749480;
        Mon, 28 Aug 2023 06:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q20-20020a7bce94000000b003fedcd02e2asm10840392wmj.35.2023.08.28.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:52:29 -0700 (PDT)
Message-ID: <3c16fa6897f9138fe25ad8c0d4fead333668f9fc.1693230746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com>
References: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
        <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Aug 2023 13:52:25 +0000
Subject: [PATCH v3 2/3] setup: add discover_git_directory_reason()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

There are many reasons why discovering a Git directory may fail. In
particular, 8959555cee7 (setup_git_directory(): add an owner check for
the top-level directory, 2022-03-02) added ownership checks as a
security precaution.

Callers attempting to set up a Git directory may want to inform the user
about the reason for the failure. For that, expose the enum
discovery_result from within setup.c and move it into cache.h where
discover_git_directory() is defined.

I initially wanted to change the return type of discover_git_directory()
to be this enum, but several callers rely upon the "zero means success".
The two problems with this are:

1. The zero value of the enum is actually GIT_DIR_NONE, so nonpositive
   results are errors.

2. There are multiple successful states; positive results are
   successful.

It is worth noting that GIT_DIR_NONE is not returned, so we remove this
option from the enum. We must be careful to keep the successful reasons
as positive values, so they are given explicit positive values.

Instead of updating all callers immediately, add a new method,
discover_git_directory_reason(), and convert discover_git_directory() to
be a thin shim on top of it.

One thing that is important to note is that discover_git_directory()
previously returned -1 on error, so let's continue that into the future.
There is only one caller (in scalar.c) that depends on that signedness
instead of a non-zero check, so clean that up, too.

Because there are extra checks that discover_git_directory_reason() does
after setup_git_directory_gently_1(), there are other modes that can be
returned for failure states. Add these modes to the enum, but be sure to
explicitly add them as BUG() states in the switch of
setup_git_directory_gently().

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 setup.c | 34 ++++++++++++----------------------
 setup.h | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/setup.c b/setup.c
index 18927a847b8..2e607632dbd 100644
--- a/setup.c
+++ b/setup.c
@@ -1221,19 +1221,6 @@ static const char *allowed_bare_repo_to_string(
 	return NULL;
 }
 
-enum discovery_result {
-	GIT_DIR_NONE = 0,
-	GIT_DIR_EXPLICIT,
-	GIT_DIR_DISCOVERED,
-	GIT_DIR_BARE,
-	/* these are errors */
-	GIT_DIR_HIT_CEILING = -1,
-	GIT_DIR_HIT_MOUNT_POINT = -2,
-	GIT_DIR_INVALID_GITFILE = -3,
-	GIT_DIR_INVALID_OWNERSHIP = -4,
-	GIT_DIR_DISALLOWED_BARE = -5,
-};
-
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
@@ -1385,21 +1372,23 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	}
 }
 
-int discover_git_directory(struct strbuf *commondir,
-			   struct strbuf *gitdir)
+enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
+						    struct strbuf *gitdir)
 {
 	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 	size_t gitdir_offset = gitdir->len, cwd_len;
 	size_t commondir_offset = commondir->len;
 	struct repository_format candidate = REPOSITORY_FORMAT_INIT;
+	enum discovery_result result;
 
 	if (strbuf_getcwd(&dir))
-		return -1;
+		return GIT_DIR_CWD_FAILURE;
 
 	cwd_len = dir.len;
-	if (setup_git_directory_gently_1(&dir, gitdir, NULL, 0) <= 0) {
+	result = setup_git_directory_gently_1(&dir, gitdir, NULL, 0);
+	if (result <= 0) {
 		strbuf_release(&dir);
-		return -1;
+		return result;
 	}
 
 	/*
@@ -1429,11 +1418,11 @@ int discover_git_directory(struct strbuf *commondir,
 		strbuf_setlen(commondir, commondir_offset);
 		strbuf_setlen(gitdir, gitdir_offset);
 		clear_repository_format(&candidate);
-		return -1;
+		return GIT_DIR_INVALID_FORMAT;
 	}
 
 	clear_repository_format(&candidate);
-	return 0;
+	return result;
 }
 
 const char *setup_git_directory_gently(int *nongit_ok)
@@ -1515,10 +1504,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		*nongit_ok = 1;
 		break;
-	case GIT_DIR_NONE:
+	case GIT_DIR_CWD_FAILURE:
+	case GIT_DIR_INVALID_FORMAT:
 		/*
 		 * As a safeguard against setup_git_directory_gently_1 returning
-		 * this value, fallthrough to BUG. Otherwise it is possible to
+		 * these values, fallthrough to BUG. Otherwise it is possible to
 		 * set startup_info->have_repository to 1 when we did nothing to
 		 * find a repository.
 		 */
diff --git a/setup.h b/setup.h
index 58fd2605dd2..b48cf1c43b5 100644
--- a/setup.h
+++ b/setup.h
@@ -42,16 +42,45 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
 #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
 
 void setup_work_tree(void);
+
+/*
+ * discover_git_directory_reason() is similar to discover_git_directory(),
+ * except it returns an enum value instead. It is important to note that
+ * a zero-valued return here is actually GIT_DIR_NONE, which is different
+ * from discover_git_directory.
+ */
+enum discovery_result {
+	GIT_DIR_EXPLICIT = 1,
+	GIT_DIR_DISCOVERED = 2,
+	GIT_DIR_BARE = 3,
+	/* these are errors */
+	GIT_DIR_HIT_CEILING = -1,
+	GIT_DIR_HIT_MOUNT_POINT = -2,
+	GIT_DIR_INVALID_GITFILE = -3,
+	GIT_DIR_INVALID_OWNERSHIP = -4,
+	GIT_DIR_DISALLOWED_BARE = -5,
+	GIT_DIR_INVALID_FORMAT = -6,
+	GIT_DIR_CWD_FAILURE = -7,
+};
+enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
+						    struct strbuf *gitdir);
+
 /*
  * Find the commondir and gitdir of the repository that contains the current
  * working directory, without changing the working directory or other global
  * state. The result is appended to commondir and gitdir.  If the discovered
  * gitdir does not correspond to a worktree, then 'commondir' and 'gitdir' will
  * both have the same result appended to the buffer.  The return value is
- * either 0 upon success and non-zero if no repository was found.
+ * either 0 upon success and -1 if no repository was found.
  */
-int discover_git_directory(struct strbuf *commondir,
-			   struct strbuf *gitdir);
+static inline int discover_git_directory(struct strbuf *commondir,
+					 struct strbuf *gitdir)
+{
+	if (discover_git_directory_reason(commondir, gitdir) <= 0)
+		return -1;
+	return 0;
+}
+
 const char *setup_git_directory_gently(int *);
 const char *setup_git_directory(void);
 char *prefix_path(const char *prefix, int len, const char *path);
-- 
gitgitgadget

