Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59734C33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E68C206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXbtRgKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgAaSbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:31:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53674 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAaSbd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:31:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so9028668wmh.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CD2nWjyINby06PiyB0ujdlMyGH5W3E4THLyyGQ1G8Do=;
        b=DXbtRgKj3azjv7d1gnMRLGo9ezO6TID+Sl06bm10+vdHDCl2DOt2jCDHq2Tfy3wG2Y
         dOKdwIdQ+3APWNGMlAHkoAgdAGRDH/tiPYC6FbxQiW6VIBlAT4kRu5YmJ56KbZ1GIqA4
         SZlgQGr0JskaR6vhzr8kMfQD5yiiFmkD0Q8y/bkfuohRR8pk2oyuGE70q/ZgByvw1aQ7
         i+P1+pjd+0jig8aS0vZwOX4qEwWO3RNul+dY1sCLluwcN6VsNeXlFiSMmQs2WvOKK4mr
         5Ju7gQpAJO/41mrPmx45MsaA5+ne6l0mauukD4U9Jc59XGKlZb869iKsAImoL7Cx52JF
         dZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CD2nWjyINby06PiyB0ujdlMyGH5W3E4THLyyGQ1G8Do=;
        b=CJbCWSWcHolJQ/1obA1L8bkzETcM/igK320z4JC9t8TkqFlpb6qK5IgdWTsOwkDXhu
         QxBco31O26Wgobu511KlVo6wUaiCJ6M5H0zzHCxkUQIbjK0Egh1I/YZGzLrrRkVpWSCd
         qCmVADVILmlSb4i4CqGQ/CK1lSewBalsGwUWtdJqgzrgO2xtgApRf2HhytmSgoIO+/5e
         QpGAEbBkZp9ItFfwkEieK6wiTERecVXHaeVRWZQL8UAmcoo0KGT202kArO8FEIdGBCFL
         Sqnmkeq7RtjQ/2G5pprVTy1Z0jsiybNgywAD4DG/7Hi4iIXXqi3x8J+D0iiv8/krE8iS
         QRqw==
X-Gm-Message-State: APjAAAUDdsCh9Fx8eBaUem/we9mf3HRvoMIOz4KZRyzBnj5YZmlKoWol
        S0izyHqbbfb8N3Pfe+rRU/J6jiBG
X-Google-Smtp-Source: APXvYqyDhI+mpTzK8bTP8hLDQ/ZxgqOUkui26/F7ENeLb1z+eCMEA8hFS/Q22dqIgtjUa8C+XWEZ2w==
X-Received: by 2002:a1c:e2c3:: with SMTP id z186mr13475885wmg.70.1580495490786;
        Fri, 31 Jan 2020 10:31:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm11676662wmm.15.2020.01.31.10.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 10:31:30 -0800 (PST)
Message-Id: <f73f0d66d14f50bbe7a9b14f0932fa4045644e2e.1580495486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
        <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 18:31:24 +0000
Subject: [PATCH v2 4/6] dir: refactor treat_directory to clarify control flow
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
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The logic in treat_directory() is handled by a multi-case
switch statement, but this switch is very asymmetrical, as
the first two cases are simple but the third is more
complicated than the rest of the method. In fact, the third
case includes a "break" statement that leads to the block
of code outside the switch statement. That is the only way
to reach that block, as the switch handles all possible
values from directory_exists_in_index();

Extract the switch statement into a series of "if" statements.
This simplifies the trivial cases, while clarifying how to
reach the "show_other_directories" case. This is particularly
important as the "show_other_directories" case will expand
in a later change.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/dir.c b/dir.c
index 225f0bc082..6867356a31 100644
--- a/dir.c
+++ b/dir.c
@@ -1660,29 +1660,28 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	const struct pathspec *pathspec)
 {
 	int nested_repo = 0;
-
 	/* The "len-1" is to strip the final '/' */
-	switch (directory_exists_in_index(istate, dirname, len-1)) {
-	case index_directory:
-		return path_recurse;
+	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
 
-	case index_gitdir:
+	if (status == index_directory)
+		return path_recurse;
+	if (status == index_gitdir)
 		return path_none;
+	if (status != index_nonexistent)
+		BUG("Unhandled value for directory_exists_in_index: %d\n", status);
 
-	case index_nonexistent:
-		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
-		    !(dir->flags & DIR_NO_GITLINKS)) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, dirname);
-			nested_repo = is_nonbare_repository_dir(&sb);
-			strbuf_release(&sb);
-		}
-		if (nested_repo)
-			return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
-				(excluded ? path_excluded : path_untracked));
+	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+		!(dir->flags & DIR_NO_GITLINKS)) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, dirname);
+		nested_repo = is_nonbare_repository_dir(&sb);
+		strbuf_release(&sb);
+	}
+	if (nested_repo)
+		return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
+			(excluded ? path_excluded : path_untracked));
 
-		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
-			break;
+	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
 		if (excluded &&
 		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
 		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
-- 
gitgitgadget

