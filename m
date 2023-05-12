Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E33C7EE24
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbjELHEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbjELHEn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932767685
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso27916865e9.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875080; x=1686467080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z2lcHQ57o4LuELbC2cpJT5fArOtusDI2yqn80OyHns=;
        b=OMuk/+xskk2dW/nUtoXEqCr/f578mA8ikle2gPUTeH2h1HuFS5bfyFDXalS6OGcpKh
         scRR00dIIORsaj6f/O3koQcemBzwNRtNOezedg2cmmFE8Hq7JN/XhuDhjBVCJhViM4Xg
         LQTu3IsB5G+mWHL4TD5SdSWM6nTiJsuh8BsLJTe9YMnlWNT5vN7qDEbfqksqUUDZ2qhM
         8uFvSgbG5MqUfVMvShjbofuOlpcjgnVH/UMPoZs53XKOYBpUANcW2piHpKL5DzDiEMbw
         TVWwDoEvz0wNahHWbHGzxn4xgOsBkMAZ4nKlrsPaAoqIkL0YWpFulFfBcbDtSP1SpFZ1
         Lkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875080; x=1686467080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z2lcHQ57o4LuELbC2cpJT5fArOtusDI2yqn80OyHns=;
        b=iUkdcPpifBo/+KYlrGwKEdG88dpZhkWdCeWLfIhkyGMKveenGbxp9uTjNP850LOCC0
         m1YUA4dJ6oK8GXfJ3S4dIM4EPcCtAr7drwgnN9FMK/VXLUxWlxjkG4PoT6b349sIzxV5
         mVHsUbetuS+Hpk+gaesb4UZ0UE4D/sHPOeGQMAnNsqoG/QOy7IrJqlvU2R/PrczdIl6N
         DHCR1SxGHKgfnLT2ufsi8oTE44l0XyEUBTEiM9S3x+W5kD+kxvY9RDS05uNn+Nzupa0O
         0IL6bOz2FgWh7VT380POi9H/XZ6IfQOEyUSTuSj+33EYEr+gpjitX1kGyoCY/qbAMy0a
         Vc0g==
X-Gm-Message-State: AC+VfDz5hXnrNMH27+Tj5V96TxXnG3VsyopaD6l0EM1Kjo95W3KlQeW1
        PH3JYHoZjoa2QRh3z9knYeAoisNRNUw=
X-Google-Smtp-Source: ACHHUZ5/jgY9YiSu5FINuPlMawqfKCazYaB8T7ngPaqwg1TC/CL4VKelX1k9g7N9buRwdomyGV5ZTw==
X-Received: by 2002:a1c:4c08:0:b0:3f4:2737:a016 with SMTP id z8-20020a1c4c08000000b003f42737a016mr9653253wmf.29.1683875079588;
        Fri, 12 May 2023 00:04:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d65cd000000b0030789698eebsm18894008wrw.89.2023.05.12.00.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:39 -0700 (PDT)
Message-Id: <5ba9d6e68ad255a64eb7e5ad6ca53bc55c771ff4.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:03 +0000
Subject: [PATCH v2 02/27] init-db: remove unnecessary global variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
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
index 715e94befa0..381801b9637 100644
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
 	 * expanding the right hande side:
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

