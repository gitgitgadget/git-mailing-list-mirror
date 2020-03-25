Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA856C2D0E8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1F820740
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAnphPqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgCYTcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:32:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46457 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgCYTcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 15:32:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id cf14so4016638edb.13
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xkC+IVvzcmDAOU11a56Rp9tRjmkMcpKNCWI68pKm8dU=;
        b=IAnphPqFCDuBd8pu+Jf7JR5bxhg8cC4Uwu4Zvj/Al5qDU6U1QdxgfLiFkslVV3tN04
         rWqptwuvPfvxnG5unM7+xfed2PwRrAhxh7xjcPUgMzCCmkb4h2QIpGaM8ko5p4UdvWKm
         22hGANos11vYF6toQALMSQXzpVEIzN0ZA1wOGnou5ThJYRgzZWFcqN8F0wbikCy1oRzY
         Kxv8PVhGjf+gSrsocRqQJgbFaSbI7O41IMUCvlReymN93DendJLzypb86rfPEr09obwZ
         SBiAwR32H5iIWM32w37tbLnhFmlqF+0ijcFb6o8ZHt52PE6iotmjw3sfByhc0/NOcAdC
         t4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xkC+IVvzcmDAOU11a56Rp9tRjmkMcpKNCWI68pKm8dU=;
        b=l3vYaKOAeiygHNX6IS1l1NOWM5jAnHK8ggYFHktZOQLOJ42DOKxWTKdFm5uq3oFPs3
         Y75Hp7Hfl5VqVWO28D6io6DkOKi0O1fy8RZ0fpNlPzS4c+IghT3MlK/J3bJNKBlOmI3t
         RRApRN7lU+OZ2bqzctZOq24Ol9P/jx9+Q9MA2KOJ69fWkMr4x/k0J55uOFwTQsLrM/jk
         wvvIPGuViDWrOqgGeHwW1+aKaKdzIMxEYnrW2cfmpJbpn1z4/PguwG9KjzzpGgShShzE
         /pSGw5lQJ4ddXqsBItDqXDW9TzrxgY9H9WNPgT9tTGLRorT/M4HJzC8KxyFYnn9Fi3tv
         prcA==
X-Gm-Message-State: ANhLgQ3avujl5aMlFJaxp9l7KP4ZGutIu6n11+hui8b7iMktyu2/uxVk
        c+HV0Y1Wu3h+hz4peokw+xCep+Oo
X-Google-Smtp-Source: ADFU+vtfFED51TDtcpRl4pWuWFSoy5o7seARfVHuXXKJQ89qBVRXtW1n+JTjyNDjZnEL6ZenctZuhw==
X-Received: by 2002:a17:906:5045:: with SMTP id e5mr4665025ejk.325.1585164724163;
        Wed, 25 Mar 2020 12:32:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id rl28sm1424323ejb.28.2020.03.25.12.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:32:03 -0700 (PDT)
Message-Id: <f5d69102946e65506406a06a2206aefe05007275.1585164718.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
References: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
        <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 19:31:56 +0000
Subject: [PATCH v3 6/7] dir: refactor treat_directory to clarify control flow
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
index 8074e651e6f..d9bcb7e19b6 100644
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

