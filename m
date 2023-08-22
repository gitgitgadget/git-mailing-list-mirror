Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59393EE49A3
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 17:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjHVRY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 13:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjHVRYX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 13:24:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F482110
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 10:24:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso45703315e9.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692725058; x=1693329858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkGNJDaF8vJXluvjuim2aANAoEC6C77HB2fk9qwSEzc=;
        b=IdNg4dYa+9iVWCDZpg05hDsclPhUJ+NulvsfWyBbCDbNXnpcUAmE29MnqZIqdfUMxi
         lKAkacvqZbX0HfQC/BT4YcIkW2UiK8OmlnzJ4XG1Y+Z0OCvgYqXx6MBfK6UYQ5xA5BY+
         1O+LIpXzu0KOQsba26utGcwjOr9KrMwkQVgkWe5uNnEad7UAFOFyioHdIg4ceToBf+ht
         DDNc5EKdyMKmJPHgOGHF1BiPzKP69TfHS21kIlyiTl34vFz7g9HYFkC9QFKP2eQtDxLC
         MO/k9KxJ95xo3166MpnBkl2Mq4tJjtQ9hr8JVjqqRuEWnqvEl0Rq/RjwaB1WuuWr6qlF
         LCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725058; x=1693329858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkGNJDaF8vJXluvjuim2aANAoEC6C77HB2fk9qwSEzc=;
        b=BTIEsWO0MgpDdy3pZnhumeav1AswJ83PuvktO9XL7DpYhalhcntclyfTZ+jId5YTpe
         2ROrb/G0Z/x9XGvGeD5HgKCwSlYkyZR2bZM+qz9333dimbeGL/cBskrO29e4jzywrb2g
         NK9zq4/Q7AAygeOsB2isyf1p8et8vIac0t1LUvcjYfZe1fHDjBhnrkoS1fO1Y5wCgwPK
         1xBbK79dRUihl9cAIN71qeQ59FoqsHh6aVnhD6dBJ3yMu3wM/DNf3BPztj/WyoT0yeIp
         pOcU+3McEOcsnYGorSAOE1RxyvakhUdK8H0Lpi5Q01b4a1mfAaQPJ0+2Sng0tqwrC4yL
         ALyA==
X-Gm-Message-State: AOJu0YyPe+6P/zUqosigOl747YQ9sXUPS4a1bOZIZo7iyLuq9vWEyBge
        GY2+b9iwKcmOeGoVsVR9t7KSUvBQYXs=
X-Google-Smtp-Source: AGHT+IHY7oFYsSeAMbEYo1EBV+apH6UfFAR8lX432TrZSjgxdbOydGl6QwGbeSFMC5uVlxrqKq2U1w==
X-Received: by 2002:a05:600c:b42:b0:3fe:2b76:3d7 with SMTP id k2-20020a05600c0b4200b003fe2b7603d7mr7194977wmr.10.1692725058430;
        Tue, 22 Aug 2023 10:24:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d6304000000b0031431fb40fasm16422195wru.89.2023.08.22.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:24:18 -0700 (PDT)
Message-ID: <787af0f9744e2f18c9ab680886650278a9d2f8d0.1692725056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Aug 2023 17:24:14 +0000
Subject: [PATCH v2 2/3] setup: add discover_git_directory_reason()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
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
discovery_result from within setup.c and into cache.h where
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
Further, a use in scalar.c was previously impossible, so it is removed.

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
 scalar.c |  3 ---
 setup.c  | 34 ++++++++++++----------------------
 setup.h  | 35 ++++++++++++++++++++++++++++++++---
 3 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/scalar.c b/scalar.c
index 938bb73f3ce..02a38e845e1 100644
--- a/scalar.c
+++ b/scalar.c
@@ -686,9 +686,6 @@ static int cmd_reconfigure(int argc, const char **argv)
 				warning(_("removing stale scalar.repo '%s'"),
 					dir);
 			strbuf_release(&buf);
-		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
-			warning_errno(_("git repository gone in '%s'"), dir);
-			res = -1;
 		} else {
 			git_config_clear();
 
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

