Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2029FC2D0E7
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34172077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyCPKE/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbgDAESA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:18:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37950 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgDAER7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id f6so5558509wmj.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xkC+IVvzcmDAOU11a56Rp9tRjmkMcpKNCWI68pKm8dU=;
        b=nyCPKE/Fd+5rxkVwmxINGxS1QozSiWc6Wv8SfnTGRr5GB0yknrmvRLbz+wrCSRIZSp
         /MtH8CpiU7Mdf7vst31hbSA9+sP2DY/JxzyzduOLpNn4v0fr76Q3H23EQIH4KajwDrc0
         1k/OFglnKEeIG3r6NqzSiqu5rgklC1dOIrEs1sawLW3Rf3PAPXib9eZ7Vb+3aY/NhAxo
         HeDx7lfSnkDyFSt7qC0HLtSkR2GxMpAjfN+h/H14X0ElnSoRMvmuPbutDiuXwmz92vne
         OH59990U94yRJrOVSW6Gs9GZ4mLud0oo5+7giawLGFPiCmZjNpGneGkuZjgYlV/JnlE0
         gI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xkC+IVvzcmDAOU11a56Rp9tRjmkMcpKNCWI68pKm8dU=;
        b=VmRNkLHnkFJ5X1T7eTvSgrI0huzkBES+uO/BC61AwwNJjayy6jvOy+hNBEw6n/+m+6
         mGy9Oti/x9Xij5kVCsr/BBeGQrM/bpqNxUriWFKph4Uo34WjsQYXO79e8qQ7cXesUk5Q
         2I6QESOq3caEijFyqCrhiQrcbIEcF7d6z053J5Z4sySUu86wn4oTu31eCJcgdoCDogdU
         YgoKMQIje2KYFwuIRlm0OMYw663q6keIfrOH74/IRaiA6EvFCN6+Cn/Sc3esDhzK6TUC
         63MjZgwDdarPfeYSoOBRKPz6fF5NGFO5V0Dx4crGVAG9c8+TKpl7LPxSZlNKXHOJbgqQ
         Q5pg==
X-Gm-Message-State: AGi0PubZ5cHjfn1Cnw8JbDnWsu+sgDlNNtRlz4MhwGaXDWaTvR7l5Xrn
        NKw3r9PNQIY8UteYxLqMvcbU4X72
X-Google-Smtp-Source: APiQypI8zsL8qdnT3l7zIPGk1roWNBm2R5ex/KfeAczJr+CEgp+kgKEmn+rr14YJEQAsj6TXcIEt/Q==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr2036499wmi.37.1585714674018;
        Tue, 31 Mar 2020 21:17:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 98sm1215736wrk.52.2020.03.31.21.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:53 -0700 (PDT)
Message-Id: <25921cb792eaeece5a20b8e2ff684b25951dc1d5.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:41 +0000
Subject: [PATCH v5 07/12] dir: refactor treat_directory to clarify control
 flow
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

