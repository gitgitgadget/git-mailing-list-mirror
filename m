Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA2BC77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 13:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbjFFNZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjFFNYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 09:24:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81FD12F
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 06:24:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso22235985e9.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686057881; x=1688649881;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MayvrP6sDntOc16gKfpQTpiT3XHbFLVzH9NGXnviD4=;
        b=EZzGUOcq5zEW5aSpIKApaWEGJ2sRHh9hSnC93m/9Yfa0QXfxZvjoStE3Hk6zS+JzgI
         tOJ1+M0e2McY2yxT8g4MN1Gl8Bl5+3iwP6mdr+ivA3LPRyVitws/argZYIO8epZimesQ
         008quxf6ZcK2h56JrTgPROdCUvIr3bV+k11XSwXtQ04+CW0Oo/aitjZWdpfreLDBXdD2
         lrHZNtS/BiXj+WR4HV4SSAnaEZJDFEGvRVHX1yuDh+82w10LPT6rxKiwnCyuSJT0SKu+
         Dxg28uGQbH1KJwLTDM50mlZjVbDw8CE6xJ+hdB0fKibYW/xd8qrVKW4QYQWhrR/rHQHH
         F/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686057881; x=1688649881;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MayvrP6sDntOc16gKfpQTpiT3XHbFLVzH9NGXnviD4=;
        b=B32763FyazWNIAo6PjMp3heSiv4KB7oy220ESI7LGUqjEssUq21HSf6uor14EYvm+j
         jeVp8XHthK7YLhFiC3MzyDgaY5fzirspk5WxJZHXyF3HXHe2x6rdUqUI7ol2kGlJxNNR
         LGK23O+HsQtQxqsOBla8iuXdfz9++mqVqRv2gbhpjtYunya/53HWNDjedQocy5GTuqdP
         3JHPT3Og/LbJTf6LJA2nLTFvTp/XA1qMrGigV3k7Zzo5if+qQRUsjXcGoo/Z4WNP7z+B
         GcopDkudT4GL8QwemZeJhDswlp43v94+2F+ulzs8iF4nXnyuowSWoTFHtjQf0ETrtG6R
         kKUw==
X-Gm-Message-State: AC+VfDxxk7Y7DDFvNH2SguDzVT6cOOSzE5dOFlPI1Hgc6bWIiPeWsEJY
        gSYV+MgJk86WuEyKyuQzJxuuJHbvKxs=
X-Google-Smtp-Source: ACHHUZ5b8t/M0R+Bqizrl+w3ghF4SqwJJM9Lf65XUgPFB+yBkDxRhODkVWMRfi8YrPat/bieSCyLgA==
X-Received: by 2002:a1c:6a14:0:b0:3f6:7e6:44ea with SMTP id f20-20020a1c6a14000000b003f607e644eamr2303742wmc.18.1686057881000;
        Tue, 06 Jun 2023 06:24:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d50d2000000b0030497b3224bsm12540866wrt.64.2023.06.06.06.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:24:40 -0700 (PDT)
Message-Id: <8b7c7714c8cd4af01538b3e5d88fae09d3c70dad.1686057877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
References: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
        <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 13:24:37 +0000
Subject: [PATCH v3 3/3] repository: create read_replace_refs setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'read_replace_refs' global specifies whether or not we should
respect the references of the form 'refs/replace/<oid>' to replace which
object we look up when asking for '<oid>'. This global has caused issues
when it is not initialized properly, such as in b6551feadfd (merge-tree:
load default git config, 2023-05-10).

To make this more robust, move its config-based initialization out of
git_default_config and into prepare_repo_settings(). This provides a
repository-scoped version of the 'read_replace_refs' global.

The global still has its purpose: it is disabled process-wide by the
GIT_NO_REPLACE_OBJECTS environment variable or by a call to
disable_replace_refs() in some specific Git commands.

Since we already encapsulated the use of the constant inside
replace_refs_enabled(), we can perform the initialization inside that
method, if necessary. This solves the problem of forgetting to check the
config, as we will check it before returning this value.

Due to this encapsulation, the global can move to be static within
replace-object.c.

There is an interesting behavior change possible here: we now have a
repository-scoped understanding of this config value. Thus, if there was
a command that recurses into submodules and might follow replace refs,
then it would now respect the core.useReplaceRefs config value in each
repository.

'git grep --recurse-submodules' is such a command that recurses into
submodules in-process. We can demonstrate the granularity of this config
value via a test in t7814.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 config.c                           |  5 ----
 environment.c                      |  1 -
 replace-object.c                   | 20 +++++++++++++--
 replace-object.h                   |  8 ------
 repo-settings.c                    |  1 +
 repository.h                       |  9 +++++++
 t/t7814-grep-recurse-submodules.sh | 40 ++++++++++++++++++++++++++++++
 7 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/config.c b/config.c
index 43b0d3fb573..d0ce902af39 100644
--- a/config.c
+++ b/config.c
@@ -1838,11 +1838,6 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.usereplacerefs")) {
-		read_replace_refs = git_config_bool(var, value);
-		return 0;
-	}
-
 	/* Add other config variables here and to Documentation/config.txt. */
 	return platform_core_config(var, value, cb);
 }
diff --git a/environment.c b/environment.c
index 3b4d87c322f..e198b48081a 100644
--- a/environment.c
+++ b/environment.c
@@ -63,7 +63,6 @@ const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
-int read_replace_refs = 1;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding = "SHIFT-JIS";
diff --git a/replace-object.c b/replace-object.c
index 07cfedd6df4..ae2d55b0147 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -64,7 +64,7 @@ void prepare_replace_object(struct repository *r)
  * replacement object's name (replaced recursively, if necessary).
  * The return value is either oid or a pointer to a
  * permanently-allocated value.  This function always respects replace
- * references, regardless of the value of read_replace_refs.
+ * references, regardless of the value of r->settings.read_replace_refs.
  */
 const struct object_id *do_lookup_replace_object(struct repository *r,
 						 const struct object_id *oid)
@@ -85,6 +85,13 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 	die(_("replace depth too high for object %s"), oid_to_hex(oid));
 }
 
+/*
+ * This indicator determines whether replace references should be
+ * respected process-wide, regardless of which repository is being
+ * using at the time.
+ */
+static int read_replace_refs = 1;
+
 void disable_replace_refs(void)
 {
 	read_replace_refs = 0;
@@ -92,5 +99,14 @@ void disable_replace_refs(void)
 
 int replace_refs_enabled(struct repository *r)
 {
-	return read_replace_refs;
+	if (!read_replace_refs)
+		return 0;
+
+	if (r->gitdir) {
+		prepare_repo_settings(r);
+		return r->settings.read_replace_refs;
+	}
+
+	/* repository has no objects or refs. */
+	return 0;
 }
diff --git a/replace-object.h b/replace-object.h
index 3e9c3516c3c..ba478eb30c4 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -5,14 +5,6 @@
 #include "repository.h"
 #include "object-store.h"
 
-/*
- * Do replace refs need to be checked this run?  This variable is
- * initialized to true unless --no-replace-object is used or
- * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
- * commands that do not want replace references to be active.
- */
-extern int read_replace_refs;
-
 struct replace_object {
 	struct oidmap_entry original;
 	struct object_id replacement;
diff --git a/repo-settings.c b/repo-settings.c
index 7b566d729d0..525f69c0c77 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -67,6 +67,7 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "pack.usebitmapboundarytraversal",
 		      &r->settings.pack_use_bitmap_boundary_traversal,
 		      r->settings.pack_use_bitmap_boundary_traversal);
+	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repository.h b/repository.h
index c42f7ab6bdc..a8ba87cbe0e 100644
--- a/repository.h
+++ b/repository.h
@@ -39,6 +39,15 @@ struct repo_settings {
 	int pack_read_reverse_index;
 	int pack_use_bitmap_boundary_traversal;
 
+	/*
+	 * Does this repository have core.useReplaceRefs=true (on by
+	 * default)? This provides a repository-scoped version of this
+	 * config, though it could be disabled process-wide via some Git
+	 * builtins or the --no-replace-objects option. See
+	 * replace_refs_enabled() for more details.
+	 */
+	int read_replace_refs;
+
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
 	int index_version;
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 8143817b19e..d37c83b4640 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -594,4 +594,44 @@ test_expect_success 'grep partially-cloned submodule' '
 	)
 '
 
+test_expect_success 'check scope of core.useReplaceRefs' '
+	git init base &&
+	git init base/sub &&
+
+	echo A >base/a &&
+	echo B >base/b &&
+	echo C >base/sub/c &&
+	echo D >base/sub/d &&
+
+	git -C base/sub add c d &&
+	git -C base/sub commit -m "Add files" &&
+
+	git -C base submodule add ./sub &&
+	git -C base add a b sub &&
+	git -C base commit -m "Add files and submodule" &&
+
+	A=$(git -C base rev-parse HEAD:a) &&
+	B=$(git -C base rev-parse HEAD:b) &&
+	C=$(git -C base/sub rev-parse HEAD:c) &&
+	D=$(git -C base/sub rev-parse HEAD:d) &&
+
+	git -C base replace $A $B &&
+	git -C base/sub replace $C $D &&
+
+	test_must_fail git -C base grep --cached --recurse-submodules A &&
+	test_must_fail git -C base grep --cached --recurse-submodules C &&
+
+	git -C base config core.useReplaceRefs false &&
+	git -C base grep --recurse-submodules A &&
+	test_must_fail git -C base grep --cached --recurse-submodules C &&
+
+	git -C base/sub config core.useReplaceRefs false &&
+	git -C base grep --cached --recurse-submodules A &&
+	git -C base grep --cached --recurse-submodules C &&
+
+	git -C base config --unset core.useReplaceRefs &&
+	test_must_fail git -C base grep --cached --recurse-submodules A &&
+	git -C base grep --cached --recurse-submodules C
+'
+
 test_done
-- 
gitgitgadget
