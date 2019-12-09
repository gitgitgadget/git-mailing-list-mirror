Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163A5C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2E2206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwuweCja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfLIUr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:47:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52621 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfLIUry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:47:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so815696wmc.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 12:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zze0uH3Nj4ZOmvZ1O0g/xeKVlrddGGSxpyF/tpjrz40=;
        b=kwuweCjaJkU3vII5kt60YqdqslKQlYH09Nih/cp/dAK1ziyO/bTwMkbRSB8KV9exCo
         Nkg9l5kUG7sFNNdzzyk4WiQnEUVYMvkcE2iMPVHJqrIU40FY5x4ZiEHdlLOhCdAA/z8q
         cq6KtBB9ZU91AVbYJnr4SjsuYOy8GqO6ls7hqJGm6zhJULiPFWzOl0R8iteO+3WCq46Y
         Y15nbkyNarKdcOerJPYGeZOHQXxuTENSRNY+duTNx69S4GaoY6xr7LOfw2R7ZAYYYHIX
         e/pG3rHxKt/H5WFCNOx4pTg5x4F9hjciOfL7WmwRsvSIUzI5iqyCvb80K7tqB9hrCtCQ
         KHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zze0uH3Nj4ZOmvZ1O0g/xeKVlrddGGSxpyF/tpjrz40=;
        b=JZ8O2c7TO/T+YqbFjRzU1vBkSAK7Mr3UrobionNWb/HqWBR/pnqDchLrHkkGzLbo0y
         cWEvPkBEu3iqsGl70ovRvpXEgq9ec2BeOzJM8qxtFqJj5O2Axp3DjKdONEzB2gq25YMU
         QD1WecY0WLLp5kEdmBE0dZYd8lQZzsbNLSOWVA8CkiYELMvXWDOWgCDeHhIcmVGhoDwe
         M05AnzS0fFXVT0NOye9vOqSLwzQ4MaiXCOI3SZo5SsAFibgjJP6Oty2sHYCgpwNubmtE
         lH4+peFXrJP+MvoxptHPqB7pXXX6TNxMHok81jQvf9sfnO3UGyBS5V55cuxomjPybDiq
         LwTA==
X-Gm-Message-State: APjAAAXnjsFOS5OK69Y/uJ/K+moSz2LYZxO42zdowH/QWX4U8sZLTI2m
        zb3B7SERlRPfnuIO4ypC3xXkw6o8
X-Google-Smtp-Source: APXvYqyn2t3MO0Pqy1G+0werV4PDGYwBlpCR2yqEdWND7eNL2rmgmqIGpJEeJUwlE7/H6FJLA+tc7g==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr1024901wmh.21.1575924472683;
        Mon, 09 Dec 2019 12:47:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm538002wmg.46.2019.12.09.12.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:47:52 -0800 (PST)
Message-Id: <2200bf144af2eab98919dd6ed6313d408b1cba1e.1575924466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 20:47:45 +0000
Subject: [PATCH 8/8] dir: consolidate similar code in treat_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Both the DIR_SKIP_NESTED_GIT and DIR_NO_GITLINKS cases were checking for
whether a path was actually a nonbare repository.  That code could be
shared, with just the result of how to act differing between the two
cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index bb6e481909..04541b798b 100644
--- a/dir.c
+++ b/dir.c
@@ -1461,6 +1461,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	const char *dirname, int len, int baselen, int exclude,
 	const struct pathspec *pathspec)
 {
+	int nested_repo = 0;
+
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(istate, dirname, len-1)) {
 	case index_directory:
@@ -1470,15 +1472,16 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_none;
 
 	case index_nonexistent:
-		if (dir->flags & DIR_SKIP_NESTED_GIT) {
-			int nested_repo;
+		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+		    !(dir->flags & DIR_NO_GITLINKS)) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addstr(&sb, dirname);
 			nested_repo = is_nonbare_repository_dir(&sb);
 			strbuf_release(&sb);
-			if (nested_repo)
-				return path_none;
 		}
+		if (nested_repo)
+			return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
+				(exclude ? path_excluded : path_untracked));
 
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
@@ -1506,13 +1509,6 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 			return path_none;
 		}
-		if (!(dir->flags & DIR_NO_GITLINKS)) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, dirname);
-			if (is_nonbare_repository_dir(&sb))
-				return exclude ? path_excluded : path_untracked;
-			strbuf_release(&sb);
-		}
 		return path_recurse;
 	}
 
-- 
gitgitgadget
