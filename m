Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34755C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjEPGeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjEPGeX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0BF2102
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so12347635e9.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218860; x=1686810860;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Msoc2dH40kuA1vxMYoTp6gkv7yU7rfpHxcxQzFGN/Po=;
        b=DVZaVLVu9o8HDptEbQYHGDeyCeHC+d4r1I+NDeljQcerC7QgrVqDkNuiKfj7+u3uWY
         cuw9rS2UJFDfQg+GB5AxRcPWtBSDm5i1b8nbqVre2LStvsm4yV9tZ4TvyyroEeBCvAk8
         p7LfYdM9U+ib4kO9S1o1QKgZcVRgibnY5S8+2Y1yVgzbMeCQN58vl5bBRMQXdcxDeUxd
         4Dct5PghdqoF5hmXHUQloTPWtbvZz9tXM7Ig8sMyJrGImF6LrCwk4jD1sxcVmtPAPk8G
         uo6xkmM9yrEGF9OGIpTWgw0A9jtD1zIxAcMUwKYb/GUVh+1x/l31T+lZzes+5A169JSb
         VWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218860; x=1686810860;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Msoc2dH40kuA1vxMYoTp6gkv7yU7rfpHxcxQzFGN/Po=;
        b=EXZsyRddRfllGazMqqEV89+IOXRkkLql0M7uRD2GPB3GuKkc0vPsb18Hbaat7aTXM/
         iANrA6IMLSaWStF7ILYwC62GWMPQeKfJw75lkNIICD/7RtQoN0Q46mQCso5meQ2lg5JG
         Ohwl9QJfcclZ+eFlKQ6uuaqZca8m30g8qky5wPV4D+j+NQqE3MzwtczR7A7euWFwHo+C
         3ModhE5elRqLYqBDlGsikrrxYQH1s0ULOBZ700BjaOXOdmX/6eFJmlGYHn9xRFEynprZ
         91+oJHFHRzb90oI64MmDs4SLMD9adjeXQq9XEiyCh1PmOgomGROAfPeC5qHi1GYS8d5H
         7C8w==
X-Gm-Message-State: AC+VfDwYuR5XXE3uwIWfhuU1tUETL3LEWXmhy1hQAWqYouIyreA7t4Bj
        q/svxV01TypDr/PxG0p2DEM/ottvXjk=
X-Google-Smtp-Source: ACHHUZ5CikjbrQ5vYhH45K5cDHXzqtAp/zKv74cpyoGBNWqydWA1eZFszrbo4NLYsTspZrh8yeBceA==
X-Received: by 2002:adf:e681:0:b0:2f6:661:c03c with SMTP id r1-20020adfe681000000b002f60661c03cmr24536972wrm.28.1684218860088;
        Mon, 15 May 2023 23:34:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9-20020a056000104900b00306c5900c10sm1421020wrx.9.2023.05.15.23.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:19 -0700 (PDT)
Message-Id: <93067838fb20c0f28e5951643c16f101491b4512.1684218851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:42 +0000
Subject: [PATCH v3 02/28] init-db: remove unnecessary global variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This commit was prompted by a desire to move the functions which
builtin/init-db.c and builtin/clone.c share out of the former file and
into setup.c.  One issue that made it difficult was the
init_is_bare_repository global variable.

init_is_bare_repository's sole use in life it to cache a value in
init_db(), and then be used in create_default_files().  This is a bit
odd since init_db() directly calls create_default_files(), and is the
only caller of that function.  Convert the global to a simple function
parameter instead.

(Of course, this doesn't fix the fact that this value is then ignored by
create_default_files(), as noted in a big TODO comment in that function,
but it at least includes no behavioral change other than getting rid of
a very questionable global variable.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/init-db.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 87a7021c3ca..32ab0a13e09 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -31,7 +31,6 @@
 
 #define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
 
-static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
 
 static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
@@ -199,6 +198,7 @@ static int create_default_files(const char *template_path,
 				const char *original_git_dir,
 				const char *initial_branch,
 				const struct repository_format *fmt,
+				int prev_bare_repository,
 				int quiet)
 {
 	struct stat st1;
@@ -237,7 +237,7 @@ static int create_default_files(const char *template_path,
 	 * TODO: heed core.bare from config file in templates if no
 	 *       command-line override given
 	 */
-	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
+	is_bare_repository_cfg = prev_bare_repository || !work_tree;
 	/* TODO (continued):
 	 *
 	 * Unfortunately, the line above is equivalent to
@@ -246,7 +246,7 @@ static int create_default_files(const char *template_path,
 	 * command line option was present.
 	 *
 	 * To see why, note that before this function, there was this call:
-	 *    init_is_bare_repository = is_bare_repository()
+	 *    prev_bare_repository = is_bare_repository()
 	 * expanding the right hand side:
 	 *                 = is_bare_repository_cfg && !get_git_work_tree()
 	 *                 = is_bare_repository_cfg && !work_tree
@@ -256,7 +256,7 @@ static int create_default_files(const char *template_path,
 	 * calls will return the same result each time.  So, what we are
 	 * interested in computing is the right hand side of the line of
 	 * code just above this comment:
-	 *     init_is_bare_repository || !work_tree
+	 *     prev_bare_repository || !work_tree
 	 *        = is_bare_repository_cfg && !work_tree || !work_tree
 	 *        = !work_tree
 	 * because "A && !B || !B == !B" for all boolean values of A & B.
@@ -424,6 +424,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	int prev_bare_repository;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -449,7 +450,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	safe_create_dir(git_dir, 0);
 
-	init_is_bare_repository = is_bare_repository();
+	prev_bare_repository = is_bare_repository();
 
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
@@ -462,6 +463,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	reinit = create_default_files(template_dir, original_git_dir,
 				      initial_branch, &repo_fmt,
+				      prev_bare_repository,
 				      flags & INIT_DB_QUIET);
 	if (reinit && initial_branch)
 		warning(_("re-init: ignored --initial-branch=%s"),
-- 
gitgitgadget

