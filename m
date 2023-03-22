Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14A0C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 20:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjCVUMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjCVUMA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 16:12:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19F13C
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:04:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y14so18316080wrq.4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679515403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN2DaZHiYuprJ75BnkU7yBhqfVOrv8/NB3NMdaV0vRs=;
        b=JMXvWXDP5hY+D0NjC4llBs3Z2mS6EolTfo6/WCufz4xwKY1XEyKPw2Kult6M0Y7sju
         twdOVjA9YtIAKtUpxHKpBKBQRdxUNLhSzsHyUpkn633SGrXiJpcAJFiRjYfa7X0EkD66
         BvzrAmDoCE2XrtnGzmZcJMU9tpQ63rEa5em+eHQA1Gpmbg2adc2CJMI8KPfWzWue6KIw
         h8tktF5KaNx3ENam/v4IVGkMJ/LQCk3pSi3lKi0FZMh/9Mfms8Tfebb3kxGoO92RmDO8
         YzMNdDVzLTMfeBh0h/7KDQvwRBw8vOP8gm+oqDLk9I2DsMwKdmn11duTVWvWIU8LeSDt
         R80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN2DaZHiYuprJ75BnkU7yBhqfVOrv8/NB3NMdaV0vRs=;
        b=aup8rHbP1taIvwO9Nl/qk6oUjVagJ8H6MbEOik39JFXIR5n/AJp1F39Htb9PaW0CJF
         ah5ZHC3Csnvj7iGhe8vhwFE80oXbKyuPfF7gOjfV632y4h6jYMFbSsr1fb0dXv+2tH22
         bk2vsRdMLIhLYh+BjwfXiBW39zJq+xeaOhfR/4DfsIlgugNx68DG4LTcj7HWKEPjOKLW
         yk/ANfywNVRIIkeAZI345Z/9i1G8dvQaYSuvu2wcfBLJkxFt8sMWYe8rxD19I8CGG4WZ
         VEWiWpz5u562eVX2LDLc5ovpkrqTQ8KJ84Bg/5FY7kEUC1hE7LmfxJKmYEAO1MT0fz2J
         6XbA==
X-Gm-Message-State: AAQBX9fKEUI67jt0EmoNWpSTSr+PDIxD+FUztpgXERhqqhgadEG+o8Xf
        OzDUL5FZr3L3GfmHcDCaiDWJi5LuaZI=
X-Google-Smtp-Source: AKy350ZV2muFOS8r563DuNkqjLNOxxm9tkc3PisoEyD0CagvARsYp9z75Xn/PyIQrPtpvK5r3PmELA==
X-Received: by 2002:a5d:5690:0:b0:2d5:a170:839d with SMTP id f16-20020a5d5690000000b002d5a170839dmr770483wrv.25.1679515403322;
        Wed, 22 Mar 2023 13:03:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d6b0d000000b002daf0b52598sm1426458wrw.18.2023.03.22.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:03:23 -0700 (PDT)
Message-Id: <pull.1476.v2.git.git.1679515402379.gitgitgadget@gmail.com>
In-Reply-To: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
From:   "ClementMabileau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 20:03:22 +0000
Subject: [PATCH v2] branch: improve error log on branch not found by checking
 remotes refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ClementMabileau <mabileau.clement@gmail.com>,
        ctmbl <mabileau.clement@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ctmbl <mabileau.clement@gmail.com>

when failing to delete a branch with `git branch -d <branch>` because
of branch not found, try to find a remote refs matching `<branch>`
and if so add an hint:
`Did you forget --remote?` to the error message

Signed-off-by: Clement Mabileau <mabileau.clement@gmail.com>
---
    branch: improve error log on branch not found by checking remotes refs
    
    when failing to delete a branch with git branch -d <branch> because of
    branch not found, try to find a remote refs matching <branch> and if so
    add an hint: Did you forget --remote? to the error message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1476%2Fctmbl%2Fbranch%2Fdeletion%2Fimprove-error-msg-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1476/ctmbl/branch/deletion/improve-error-msg-v2
Pull-Request: https://github.com/git/git/pull/1476

Range-diff vs v1:

 1:  91cb506968a ! 1:  eb95695ace2 branch: improve error log on branch not found by checking remotes refs
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      +							| RESOLVE_REF_NO_RECURSE
      +							| RESOLVE_REF_ALLOW_BAD_NAME,
      +							&oid, &flags);
     ++				FREE_AND_NULL(virtual_name);
      +				if (virtual_target)
      +					error(_(MISSING_BRANCH_HINT_MSG), bname.buf);
      +				else
 2:  27f27f3afd7 < -:  ----------- Fix mem leak in branch.c due to not-free newly added virtual_name variable


 builtin/branch.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb9..697636e2874 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -216,10 +216,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	int branch_name_pos;
+	char* FMT_REMOTES = "refs/remotes/%s";
+	char* FMT_BRANCHES = "refs/heads/%s";
 
 	switch (kinds) {
 	case FILTER_REFS_REMOTES:
-		fmt = "refs/remotes/%s";
+		fmt = FMT_REMOTES;
 		/* For subsequent UI messages */
 		remote_branch = 1;
 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
@@ -227,7 +229,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		force = 1;
 		break;
 	case FILTER_REFS_BRANCHES:
-		fmt = "refs/heads/%s";
+		fmt = FMT_BRANCHES;
 		allowed_interpret = INTERPRET_BRANCH_LOCAL;
 		break;
 	default:
@@ -263,9 +265,26 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					| RESOLVE_REF_ALLOW_BAD_NAME,
 					&oid, &flags);
 		if (!target) {
-			error(remote_branch
-			      ? _("remote-tracking branch '%s' not found.")
-			      : _("branch '%s' not found."), bname.buf);
+			char* MISSING_REMOTE_REF_ERROR_MSG = "remote-tracking branch '%s' not found.";
+			char* MISSING_BRANCH_ERROR_MSG = "branch '%s' not found.";
+			char* MISSING_BRANCH_HINT_MSG = "branch '%s' not found.\n"
+											"Did you forget --remote?";
+
+			if (remote_branch) {
+				error(_(MISSING_REMOTE_REF_ERROR_MSG), bname.buf);
+			} else {
+				char* virtual_name = mkpathdup(FMT_REMOTES, bname.buf);
+				char* virtual_target = resolve_refdup(virtual_name,
+							RESOLVE_REF_READING
+							| RESOLVE_REF_NO_RECURSE
+							| RESOLVE_REF_ALLOW_BAD_NAME,
+							&oid, &flags);
+				FREE_AND_NULL(virtual_name);
+				if (virtual_target)
+					error(_(MISSING_BRANCH_HINT_MSG), bname.buf);
+				else
+					error(_(MISSING_BRANCH_ERROR_MSG), bname.buf);
+			}
 			ret = 1;
 			continue;
 		}

base-commit: 950264636c68591989456e3ba0a5442f93152c1a
-- 
gitgitgadget
