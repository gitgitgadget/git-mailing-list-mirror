Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD09C77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjEGDqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEGDp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:45:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA54237
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:45:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so33125895e9.3
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431156; x=1686023156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23POyN50mMtPiNhr5wHAWUh3BdqMwhvqKK5DxxJ9nM4=;
        b=Kg+f/oT7OPUXgtFLOnVf0ofFlwKK/luagHlUUQqLmweARfA5TMJ92T+T61xMs9CVpH
         37XcsN5ARSpbw4YQKNPFgpW4wLcPPAwDvG1KRPdDUqcZQL4lldGWWLJlMB6oBDrk4VWP
         iQKleoBpHFElBrEscEF1VjWpU3lTw6++ZUaS+XRbaJZ6JIYqM+968n0Hwn97sHHHCVHR
         Y6ZiaNsECZMqgUkZdcaQeUoIa6FseXrDbG2oPGiCWfAt1/GY5EO+yCwMPpNj5qc3D45A
         bjCUgerwO3NKuVvGaXGFwOrJ5rDZ8cS0eqCwlnWwZ4TOI+0r3b5TGuvglHygHKaKVOPz
         5xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431156; x=1686023156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23POyN50mMtPiNhr5wHAWUh3BdqMwhvqKK5DxxJ9nM4=;
        b=Yx1T4PUnVA5RHWjIfFCqfzlTCmYwE6OPYB8D2lOaa8zt/9FPWdvF8Qe0zKtUf8wvYW
         56eyNSJctybsKI+n992YeAC84YIVQ7OHauPYUBYg5leqEEA1Jpq5VJdo2wHgpA2rxg7l
         2qocylnbT3yY4pDffU8n3mrQPuF1ik5zQGIiYM01hYhj6bALq3lITBu607Ia5fhKeqHT
         enR1ElF5wiginmHjL2Osy4hTiy5i8PqZIzpw/pUeuOLcwJC28TIuXKPDV98FCmuirRDO
         cKnh/vcIEkOM3SMM2q48Pn23zkR1f1e9bfKYeO971HwE3vBNqbCfnPYGOz54Ad9jdYyW
         pZqg==
X-Gm-Message-State: AC+VfDw7tGl8yNrC1Vo7BD2E0CaNEQgThWs2ThqXxUZ8+FIdIqlYm8Ih
        6558DBdUYubSqECF87e0jyC+zIz/8cY=
X-Google-Smtp-Source: ACHHUZ6ENceQW9Nj+Qp+MdLwtfskV+TM1JZriOD+e+R/IXk/BXDh+XlE/y2zbGKzAULCCadCZCDi1g==
X-Received: by 2002:a7b:c404:0:b0:3f1:6942:e024 with SMTP id k4-20020a7bc404000000b003f16942e024mr4371440wmi.27.1683431155887;
        Sat, 06 May 2023 20:45:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bc8d0000000b003f17e79d74asm12502052wml.7.2023.05.06.20.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:45:55 -0700 (PDT)
Message-Id: <e3cc7eb145e0b13dfb3dded198b12905ecab27c1.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:27 +0000
Subject: [PATCH 02/24] init-db, clone: change unnecessary global into passed
 parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Much like the former commit, this commit was prompted by a desire to
move the functions which builtin/init-db.c and builtin/clone.c share out
of the former file and into setup.c.  A secondary issue that made it
difficult was the init_shared_repository global variable; replace it
with a simple parameter that is passed to the relevant functions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clone.c   | 3 ++-
 builtin/init-db.c | 9 +++++----
 cache.h           | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 15f9912b4ca..cc34c194f5e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -930,6 +930,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int submodule_progress;
 	int filter_submodules = 0;
 	int hash_algo;
+	const int do_not_override_repo_unix_permissions = -1;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1097,7 +1098,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
-		INIT_DB_QUIET);
+		do_not_override_repo_unix_permissions, INIT_DB_QUIET);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 18733ef05aa..0b30ea2d9ed 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -31,8 +31,6 @@
 
 #define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
 
-static int init_shared_repository = -1;
-
 static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 			     DIR *dir)
 {
@@ -198,6 +196,7 @@ static int create_default_files(const char *template_path,
 				const char *original_git_dir,
 				const char *initial_branch,
 				const struct repository_format *fmt,
+				int init_shared_repository,
 				int quiet)
 {
 	struct stat st1;
@@ -405,7 +404,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash, const char *initial_branch,
-	    unsigned int flags)
+	    int init_shared_repository, unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -447,6 +446,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	reinit = create_default_files(template_dir, original_git_dir,
 				      initial_branch, &repo_fmt,
+				      init_shared_repository,
 				      flags & INIT_DB_QUIET);
 	if (reinit && initial_branch)
 		warning(_("re-init: ignored --initial-branch=%s"),
@@ -558,6 +558,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *object_format = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
+	int init_shared_repository = -1;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
@@ -715,5 +716,5 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 
 	flags |= INIT_DB_EXIST_OK;
 	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
-		       initial_branch, flags);
+		       initial_branch, init_shared_repository, flags);
 }
diff --git a/cache.h b/cache.h
index bdedb87e83b..2bc1cd77d9b 100644
--- a/cache.h
+++ b/cache.h
@@ -327,7 +327,8 @@ extern struct index_state the_index;
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
-	    const char *initial_branch, unsigned int flags);
+	    const char *initial_branch, int init_shared_repository,
+	    unsigned int flags);
 void initialize_repository_version(int hash_algo, int reinit);
 
 /* Initialize and use the cache information */
-- 
gitgitgadget

