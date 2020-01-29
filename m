Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9FCC33CB7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5ED206D5
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPxU3cX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgA2WDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:03:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39873 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2WDv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 17:03:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so1392669wrt.6
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 14:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eOW7ZR7XOpzw/b1ufbziIWWepfolUPPVh6H8feOJQDQ=;
        b=CPxU3cX1jmCGf1Z0Gchka/UuMGBoaziIhhWbjPfqiXzDBdIvJOnaCisj1EN23zMrkN
         FNvBsLti64KfnvD0Cw6d+opyDMdYNITCOlaAHNf11Ake+B79XMBa0zoSht9V8qfOZ/R9
         dwh3N9mVlhKYqtTyvmaW27hGzrVI3RasJfgCmHiz9YNK68Shky3TUMJ/DeTslF5Ji2xZ
         duByQjnsUZjNALjGAHER0UrvWoQwqbNrdoOxf8y2HXZGDXgJKtq0ZPR15IRWNMWwlfFy
         8V+5rRsbK+MKnok+pMStrXmgYLge2QBBX0qmS/3bWZE96pDeijvSOfEqnf2638xPM3qM
         ju5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eOW7ZR7XOpzw/b1ufbziIWWepfolUPPVh6H8feOJQDQ=;
        b=AN6xiLelOWPkGY4o8PyQMHmy5d0ONY0ImaBG16s08xpt6My4qzDOixtWPkkPJazfW+
         Ub8anitjNPUFBNr9UV3nPs0B/qdZEIj53OZlxngeGV6k4YwOPPyd+dLjVSnLmxC6r6up
         zxAmyzQc4wv4Rbtcu1YuVAr87bxknrxYgAAssyzvH7ikP5wjAbCTB+Pr39uzsk8P+2if
         HucA7p08x8PXYQO/Rcd+KTg9lvzMKWD9mR/NoT6mhI9vE/P+oQWXIcpgEGgIG4UO6eGI
         WSexSkvmjSVIsIxRQqh5Ur4kkxHdmotDrfFsF1KnUQAc/e4mTs9m4z1GsdZODZR7+npH
         ybGg==
X-Gm-Message-State: APjAAAX96/Uvh6qjADXJAWo8IJMk8rzNtMrfZj9j+Ch942vWmISzoXNT
        WSOByDM6y5gooFYfi4ndyiLMySTq
X-Google-Smtp-Source: APXvYqy99gdkyuUmZ4Q1sRnE7n94pFZhYLGAEcPwuL1tCp72d4iN8HEf8dNG+5cUDm/pZHkn6LphVA==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr1058650wrw.271.1580335427936;
        Wed, 29 Jan 2020 14:03:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x132sm9251436wmg.0.2020.01.29.14.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 14:03:47 -0800 (PST)
Message-Id: <e6d21228d126d62fafdde185c180f9f5ba64c458.1580335424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 22:03:40 +0000
Subject: [PATCH 3/6] dir: fix confusion based on variable tense
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Despite having contributed several fixes in this area, I have for months
(years?) assumed that the "exclude" variable was a directive; this
caused me to think of it as a different mode we operate in and left me
confused as I tried to build up a mental model around why we'd need such
a directive.  I mostly tried to ignore it while focusing on the pieces I
was trying to understand.

Then I finally traced this variable all back to a call to is_excluded(),
meaning it was actually functioning as an adjective.  In particular, it
was a checked property ("Does this path match a rule in .gitignore?"),
rather than a mode passed in from the caller.  Change the variable name
to match the part of speech used by the function called to define it,
which will hopefully make these bits of code slightly clearer to the
next reader.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index c358158f55..225f0bc082 100644
--- a/dir.c
+++ b/dir.c
@@ -1656,7 +1656,7 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
 static enum path_treatment treat_directory(struct dir_struct *dir,
 	struct index_state *istate,
 	struct untracked_cache_dir *untracked,
-	const char *dirname, int len, int baselen, int exclude,
+	const char *dirname, int len, int baselen, int excluded,
 	const struct pathspec *pathspec)
 {
 	int nested_repo = 0;
@@ -1679,13 +1679,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		}
 		if (nested_repo)
 			return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
-				(exclude ? path_excluded : path_untracked));
+				(excluded ? path_excluded : path_untracked));
 
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
-		if (exclude &&
-			(dir->flags & DIR_SHOW_IGNORED_TOO) &&
-			(dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
+		if (excluded &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
 
 			/*
 			 * This is an excluded directory and we are
@@ -1713,7 +1713,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	/* This is the "show_other_directories" case */
 
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
-		return exclude ? path_excluded : path_untracked;
+		return excluded ? path_excluded : path_untracked;
 
 	untracked = lookup_untracked(dir->untracked, untracked,
 				     dirname + baselen, len - baselen);
@@ -1723,7 +1723,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 * the directory contains any files.
 	 */
 	return read_directory_recursive(dir, istate, dirname, len,
-					untracked, 1, exclude, pathspec);
+					untracked, 1, excluded, pathspec);
 }
 
 /*
@@ -1904,7 +1904,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				      int baselen,
 				      const struct pathspec *pathspec)
 {
-	int has_path_in_index, dtype, exclude;
+	int has_path_in_index, dtype, excluded;
 	enum path_treatment path_treatment;
 
 	if (!cdir->d_name)
@@ -1949,13 +1949,13 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	    (directory_exists_in_index(istate, path->buf, path->len) == index_nonexistent))
 		return path_none;
 
-	exclude = is_excluded(dir, istate, path->buf, &dtype);
+	excluded = is_excluded(dir, istate, path->buf, &dtype);
 
 	/*
 	 * Excluded? If we don't explicitly want to show
 	 * ignored files, ignore it
 	 */
-	if (exclude && !(dir->flags & (DIR_SHOW_IGNORED|DIR_SHOW_IGNORED_TOO)))
+	if (excluded && !(dir->flags & (DIR_SHOW_IGNORED|DIR_SHOW_IGNORED_TOO)))
 		return path_excluded;
 
 	switch (dtype) {
@@ -1965,7 +1965,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		strbuf_addch(path, '/');
 		path_treatment = treat_directory(dir, istate, untracked,
 						 path->buf, path->len,
-						 baselen, exclude, pathspec);
+						 baselen, excluded, pathspec);
 		/*
 		 * If 1) we only want to return directories that
 		 * match an exclude pattern and 2) this directory does
@@ -1974,7 +1974,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		 * recurse into this directory (instead of marking the
 		 * directory itself as an ignored path).
 		 */
-		if (!exclude &&
+		if (!excluded &&
 		    path_treatment == path_excluded &&
 		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
 		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
@@ -1982,7 +1982,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		return path_treatment;
 	case DT_REG:
 	case DT_LNK:
-		return exclude ? path_excluded : path_untracked;
+		return excluded ? path_excluded : path_untracked;
 	}
 }
 
-- 
gitgitgadget

