Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112F3C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 11:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbjDELn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbjDELnz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 07:43:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5E192
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 04:43:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p34so20703814wms.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680695001;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/y+FqAY0o78oSFXeoakT4Dlf42oxqoO3lUmNiXXcgw=;
        b=kPfc2az+IQeaLVqSv4+YF8MChojL/qqfxpl2pwtxrRHNfoHtZD0U0hV1sFVLBIJLd0
         /R7B+JCKincM5YnFtFdVIlEU64Pb1lOxF6+UIR73OV7jc+PjGq8izOnI7QQUDk3Bxtjs
         oowPRvDEOzH8/PBx5SuOKdiMhfJ693Sy5psMQeBVilu4ekHkqeNw6T6XHRhNgr0CT6pL
         hTpi8wpR9o/msyHhPLNGppPuc69siD+4x4m3AU34ki5uADx1O5QYY5Z2NJho24RzOmLX
         dUW/hQixhY5/aMwJzfdZoFSOMwFO5s+T5+71lcu1fSBfSa7pGpXul15VHvhKPs1ggm0P
         ZwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680695001;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/y+FqAY0o78oSFXeoakT4Dlf42oxqoO3lUmNiXXcgw=;
        b=v2OcZLzH6wchWzFk9IiKjLCbFosT+LjQMm33a4cC94oTPN9kCTEge5f9MCBMQ9rOe4
         rnwzqOKZ5Nfslnym5NMlmro1mJ27XG1UEWWOfsAojugTnncAeptYu4dDejOboOLRHxNc
         M3F112zFjncMCqd7eQN8eLXsepR29nesOTP2kzKD3VfNN+wXb39kxuLPgciBT9x4awvm
         mKNIBz+wuMR6wAe1nYNxi24HXcykCpngtQu3qaAEOipABMRrHbh9vRsGKrs6GatSJxzL
         gyH/JpsqPuzzWOCl+drK4TgfgW+6JqJZuWZXqgxX1awLzaY/mQfqeN2E94f3WRk5Ns3w
         v9Bw==
X-Gm-Message-State: AAQBX9c1rPKX2UIoojPXLRktS5fAdKVhs5r5wEFOOaQikdvMOhgIqwbX
        Eo2Svsraq72TsZcfcA5c1lwjDSv91tA=
X-Google-Smtp-Source: AKy350Ydx9zdSSehhiZvXoNYwbemrTV/VZcJPoHz3OMa3yLe354MLTZY5iy8oYMo8H7fodXRo8jCiQ==
X-Received: by 2002:a7b:ce16:0:b0:3ed:4b0f:5378 with SMTP id m22-20020a7bce16000000b003ed4b0f5378mr4567798wmc.27.1680695001436;
        Wed, 05 Apr 2023 04:43:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d21-20020a1c7315000000b003ed1f6878a5sm1997540wmb.5.2023.04.05.04.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:43:21 -0700 (PDT)
Message-Id: <pull.1476.v3.git.git.1680695000257.gitgitgadget@gmail.com>
In-Reply-To: <pull.1476.v2.git.git.1679515402379.gitgitgadget@gmail.com>
References: <pull.1476.v2.git.git.1679515402379.gitgitgadget@gmail.com>
From:   "ClementMabileau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Apr 2023 11:43:20 +0000
Subject: [PATCH v3] branch: improve error log on branch not found by checking
 remotes refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Clement Mabileau <mabileau.clement@gmail.com>,
        ClementMabileau <mabileau.clement@gmail.com>,
        Clement Mabileau <mabileau.clement@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Clement Mabileau <mabileau.clement@gmail.com>

New git users may want to locally delete remote-tracking branches but
don't really understand how they are distinguished from branches by git.
Then one may naively try:
`git branch -d foo/bar` and get a correct error `branch foo/bar not
found` but hard to understand for a newbie, this patch aims to guide one
in such case.

when failing to delete a branch with `git branch -d <branch>` because
of branch not found, try to find a **remote refs** matching `<branch>`
and if so, add an hint:
`Did you forget --remote?` to the error message

Signed-off-by: Clement Mabileau <mabileau.clement@gmail.com>
---
    branch: improve error log on branch not found by checking remotes refs
    
    when failing to delete a branch with git branch -d <branch> because of
    branch not found, try to find a remote refs matching <branch> and if so
    add an hint: Did you forget --remote? to the error message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1476%2Fctmbl%2Fbranch%2Fdeletion%2Fimprove-error-msg-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1476/ctmbl/branch/deletion/improve-error-msg-v3
Pull-Request: https://github.com/git/git/pull/1476

Range-diff vs v2:

 1:  eb95695ace2 ! 1:  0774f182b50 branch: improve error log on branch not found by checking remotes refs
     @@
       ## Metadata ##
     -Author: ctmbl <mabileau.clement@gmail.com>
     +Author: Clement Mabileau <mabileau.clement@gmail.com>
      
       ## Commit message ##
          branch: improve error log on branch not found by checking remotes refs
      
     +    New git users may want to locally delete remote-tracking branches but
     +    don't really understand how they are distinguished from branches by git.
     +    Then one may naively try:
     +    `git branch -d foo/bar` and get a correct error `branch foo/bar not
     +    found` but hard to understand for a newbie, this patch aims to guide one
     +    in such case.
     +
          when failing to delete a branch with `git branch -d <branch>` because
     -    of branch not found, try to find a remote refs matching `<branch>`
     -    and if so add an hint:
     +    of branch not found, try to find a **remote refs** matching `<branch>`
     +    and if so, add an hint:
          `Did you forget --remote?` to the error message
      
          Signed-off-by: Clement Mabileau <mabileau.clement@gmail.com>
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
       	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
       	struct string_list_item *item;
       	int branch_name_pos;
     -+	char* FMT_REMOTES = "refs/remotes/%s";
     -+	char* FMT_BRANCHES = "refs/heads/%s";
     ++	const char *fmt_remotes = "refs/remotes/%s";
       
       	switch (kinds) {
       	case FILTER_REFS_REMOTES:
      -		fmt = "refs/remotes/%s";
     -+		fmt = FMT_REMOTES;
     ++		fmt = fmt_remotes;
       		/* For subsequent UI messages */
       		remote_branch = 1;
       		allowed_interpret = INTERPRET_BRANCH_REMOTE;
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     - 		force = 1;
     - 		break;
     - 	case FILTER_REFS_BRANCHES:
     --		fmt = "refs/heads/%s";
     -+		fmt = FMT_BRANCHES;
     - 		allowed_interpret = INTERPRET_BRANCH_LOCAL;
     - 		break;
     - 	default:
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
       					| RESOLVE_REF_ALLOW_BAD_NAME,
       					&oid, &flags);
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      -			error(remote_branch
      -			      ? _("remote-tracking branch '%s' not found.")
      -			      : _("branch '%s' not found."), bname.buf);
     -+			char* MISSING_REMOTE_REF_ERROR_MSG = "remote-tracking branch '%s' not found.";
     -+			char* MISSING_BRANCH_ERROR_MSG = "branch '%s' not found.";
     -+			char* MISSING_BRANCH_HINT_MSG = "branch '%s' not found.\n"
     -+											"Did you forget --remote?";
     -+
      +			if (remote_branch) {
     -+				error(_(MISSING_REMOTE_REF_ERROR_MSG), bname.buf);
     ++				error(_("remote-tracking branch '%s' not found."), bname.buf);
      +			} else {
     -+				char* virtual_name = mkpathdup(FMT_REMOTES, bname.buf);
     -+				char* virtual_target = resolve_refdup(virtual_name,
     ++				char *virtual_name = mkpathdup(fmt_remotes, bname.buf);
     ++				char *virtual_target = resolve_refdup(virtual_name,
      +							RESOLVE_REF_READING
      +							| RESOLVE_REF_NO_RECURSE
      +							| RESOLVE_REF_ALLOW_BAD_NAME,
      +							&oid, &flags);
      +				FREE_AND_NULL(virtual_name);
     ++
      +				if (virtual_target)
     -+					error(_(MISSING_BRANCH_HINT_MSG), bname.buf);
     ++					error(_("branch '%s' not found.\n"
     ++						"Did you forget --remote?"),
     ++						bname.buf);
      +				else
     -+					error(_(MISSING_BRANCH_ERROR_MSG), bname.buf);
     ++					error(_("branch '%s' not found."), bname.buf);
     ++				FREE_AND_NULL(virtual_target);
      +			}
       			ret = 1;
       			continue;


 builtin/branch.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb9..5f035dd5969 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -216,10 +216,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	int branch_name_pos;
+	const char *fmt_remotes = "refs/remotes/%s";
 
 	switch (kinds) {
 	case FILTER_REFS_REMOTES:
-		fmt = "refs/remotes/%s";
+		fmt = fmt_remotes;
 		/* For subsequent UI messages */
 		remote_branch = 1;
 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
@@ -263,9 +264,25 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					| RESOLVE_REF_ALLOW_BAD_NAME,
 					&oid, &flags);
 		if (!target) {
-			error(remote_branch
-			      ? _("remote-tracking branch '%s' not found.")
-			      : _("branch '%s' not found."), bname.buf);
+			if (remote_branch) {
+				error(_("remote-tracking branch '%s' not found."), bname.buf);
+			} else {
+				char *virtual_name = mkpathdup(fmt_remotes, bname.buf);
+				char *virtual_target = resolve_refdup(virtual_name,
+							RESOLVE_REF_READING
+							| RESOLVE_REF_NO_RECURSE
+							| RESOLVE_REF_ALLOW_BAD_NAME,
+							&oid, &flags);
+				FREE_AND_NULL(virtual_name);
+
+				if (virtual_target)
+					error(_("branch '%s' not found.\n"
+						"Did you forget --remote?"),
+						bname.buf);
+				else
+					error(_("branch '%s' not found."), bname.buf);
+				FREE_AND_NULL(virtual_target);
+			}
 			ret = 1;
 			continue;
 		}

base-commit: ae73b2c8f1da39c39335ee76a0f95857712c22a7
-- 
gitgitgadget
