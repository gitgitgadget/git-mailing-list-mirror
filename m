Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1ABC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F6D206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7jBvZNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgAaSbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:31:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38812 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgAaSbc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:31:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so9824129wmj.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eOW7ZR7XOpzw/b1ufbziIWWepfolUPPVh6H8feOJQDQ=;
        b=l7jBvZNmXA5vEhBPIVmeL0RwdJwFdYvCdias7dyE9dZJhXoBRWeZ/wwGBfi9rcGECa
         OBo+Hb1atko4YLijEZm+jPCLgyO2UfDCvjPcW5gKjif+uQ5oS+Qu4ed6Iy9NmXONNfLA
         EMRESnOqdJn275KLvEv7ZJa4vk+qLNdPXjwyNNCmY8K1ipV/nx2CphI8LDH7RLSbq1Gz
         O1SSeZk/Yltfu23g6Sa0cc9B8yt72CvS/Ylr5S264Oj1sXnRGxivz8nN1kvD0HQDritm
         iRiqQ6EtY4O9DIBVKMyjf6kRqyZ+Eqe1XFmmdBo507PJdqBIV4ZMEsgTISpvZUpmAm6A
         P1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eOW7ZR7XOpzw/b1ufbziIWWepfolUPPVh6H8feOJQDQ=;
        b=YPVyGGPh6ryZF9mG60S9gruIlfkGNeQpcznmeTigObJgm0FycJTuhKcA4m5D0U+uja
         Yr8v2P4w56FMQC3IO0G1cclAjKvaMpsmV5cw73GQvCyhzCGjjl5RbTmOUjKGKcF9WS9X
         Jey3E8P8qSq176Wg9NhuAuQ8W1UdZ0o57eSjr6YdCQGir1pOWzlBcXnlt7FcgR44ge5h
         uJFwxsbftwihJChjURRIBbyAE1m3pBj3F0HbKwDqYUZBtCf4tfqaeGmfayBKapSNjd8c
         AIXb4reIjUT2xUagi4Q4gdOCYW7lltD7jXjnrt11UKkXmt2dfEtAoB/Izxzm3L3Qde5Y
         jmuw==
X-Gm-Message-State: APjAAAXD9nZ1k9qHKDtlRI9Ap0YL1OC7pWSCmch0NGsE5YlTSzTNGR56
        ZLJqpgvVumiXY56FwjlxkyN1WYjP
X-Google-Smtp-Source: APXvYqz/ljopzkOUmFN/XF5fqTugGVCdL7D3sis6XpCF1ipPqqFdMQ6eH355PjKCwaWJt0Fu4GjVPQ==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr14206310wma.177.1580495490015;
        Fri, 31 Jan 2020 10:31:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm12064888wmf.29.2020.01.31.10.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 10:31:29 -0800 (PST)
Message-Id: <e6d21228d126d62fafdde185c180f9f5ba64c458.1580495486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
        <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 18:31:23 +0000
Subject: [PATCH v2 3/6] dir: fix confusion based on variable tense
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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

