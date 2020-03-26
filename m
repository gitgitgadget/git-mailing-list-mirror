Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2E4C2D0E9
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010E920714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQELjf/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgCZV1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:27:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41407 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgCZV1u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:27:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id v1so8687961edq.8
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xkC+IVvzcmDAOU11a56Rp9tRjmkMcpKNCWI68pKm8dU=;
        b=OQELjf/fI/F/pWrhhYfCYHfJzMBxMWd1FCifO0ReICThHc/+FhGOawdD306WqGxCDg
         MDBthWXtBo8gQ0PjATz7GmBwcSTPidQN3XvK6bzm4jbw+V6VJq1NFlOgU/aqN0XATBay
         aTqdZUo7TA3aNm2UYtqea7aoHSI2aS/2OiYZ8UUF4oZgdYtoHK/rGFUsgCXTOgjV4jkc
         nwBPZr+y/ZPH50MejGqwJsqMVCqRPudhJVq1eiQLBwwyeYLuBT2WxCOMxuahj+IAcGAN
         mXB0BN2MiavjbtjCQJdygkivlM+7Nrv03PcMYrvACbTqP6Ixv9+HWLb1vn/8grFtOYDZ
         qb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xkC+IVvzcmDAOU11a56Rp9tRjmkMcpKNCWI68pKm8dU=;
        b=OYA7ohNkKqkMFPj090oTQKh5vMKfDcCXJdv5aNzPzgmrwlzHShSOgy6Q/KO6zAx18q
         WEtrL6D4pnvRSsMDnIGfuXH/5VdILtDltuYThjIk1gkNM9gkaymP6k7ZiV8se+9MBrxH
         uOHI+p2gGtsHcxYGnanueK0KEAuJdSyKUt1JuEoFlO/iEV411BvN9wmOel7IpfMwM6c1
         a6vcoLxH8Oy8ybcREv0grYnJOGvtAAJcIo0oYaMLGrsUz5LTz5omIeuyeryEJeWptXWd
         htKCv1yWaDhbamhUPRqMbr50oAaaZFZVbjRCX8cNJCVdfEMHVo73uOp8u+6Byxv8LcIz
         LrPg==
X-Gm-Message-State: ANhLgQ3J4zwgWWbqIUuPnedwxvc0uk6TnKRgAjQY6g3nv1uqdmoVQGNr
        c/lmGgZdNoDXZLqV7DXIkYGAYROf
X-Google-Smtp-Source: ADFU+vuIyyLKesib/YlGqimPo212SjNgc5I6AYFeH+g56fLbtha3aZP7ARTKBVen8dadKdfBB1WxLQ==
X-Received: by 2002:aa7:c559:: with SMTP id s25mr3830303edr.2.1585258067899;
        Thu, 26 Mar 2020 14:27:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm330843ejx.28.2020.03.26.14.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:27:47 -0700 (PDT)
Message-Id: <576f364329dba507e9976b775a4b48dd1257b077.1585258061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
        <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 21:27:39 +0000
Subject: [PATCH v4 6/7] dir: refactor treat_directory to clarify control flow
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

