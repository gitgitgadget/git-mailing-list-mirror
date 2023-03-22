Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B64C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 09:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCVJmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCVJmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 05:42:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD4E28228
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:42:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j24so7408364wrd.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679478128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpsJ4lyQsLNU4LZU9CqJU2KEbYl1q5mdM0u2a7s8TMs=;
        b=ApL6HG3nYpXjBP1GZTu+dptoN07Pmz4DCwYl2IkTc5AQJrlv4QbH6v9JS+heTvkuE+
         YZA7I5fCAuBGwxz4J9ScZn7Dxyfu5eeKrpEjpO5v0JwKmwHLxOaGw1soyN1ZGxr4D1us
         sccyn71dc2F2LvcCi5CJf2medv9WjYauum4SPKsr/U9ZcJ/uT3qE01jPp7cvXup6pbJD
         wx032SOVBrRsUkTGAGR9S/0xuQbkF+v9EgnQPdff/RaTVzfkUr3rtvWOQfMHDxwxjOZh
         CTFSEbWFrHixEkFvOqya3uLM35RsGR2ymL6xD0/cTC0UcGC5zf//y8sS0cHOs2WEzVdh
         l7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679478128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpsJ4lyQsLNU4LZU9CqJU2KEbYl1q5mdM0u2a7s8TMs=;
        b=EMlMcfgNpQit/6pFGLzzXu2rsT6GxJYwBuP3aCZ8VKA3QK+DleUklm5TYbg2+CC9Zd
         T7tkuKPgIDoROkm7Nv12b/Y8PwxvS4+Q5r9HetiNwHtSxSYKNiUqXDiROphOjWtyPhiB
         R8yYPpHmMaYPKgRuswhDDseVoPXBSr5U/LM9iMktV3cHJNUL82/ngzid8mvRUAYMgCvb
         n0KjD+MGtN80qJU2o+tTGTCjrqw0/V3LFfKe2XtotlbMx14S/K5GhX7PJW1bmETALTaZ
         OJBVbH/W0ykmhldv8/4SaRYTxBos+ZfnRb0HR/r5DfRPuX4abOikLu9iZu8E8jCXFvrj
         Drww==
X-Gm-Message-State: AO0yUKWzka5j1vZGPoWvbbVI4w3ht8DPlM1dY8Zszq1ziKXbtl9vGLdT
        NZYlYj677D8npJK+G7lMLqWB101iuzE=
X-Google-Smtp-Source: AK7set9X+9p3ooZORwjeJm7lJS3vw7UyT3Q+yQgcsdDhgqLW2yQGxTSpfwqouDfqneKT9RJKzSeVIw==
X-Received: by 2002:a5d:6ac8:0:b0:2d7:e4a2:4b3d with SMTP id u8-20020a5d6ac8000000b002d7e4a24b3dmr4710426wrw.26.1679478127918;
        Wed, 22 Mar 2023 02:42:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d5102000000b002c71b4d476asm13344041wrt.106.2023.03.22.02.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:42:07 -0700 (PDT)
Message-Id: <91cb506968a11fbceba856a40b14bed0c4e647bc.1679478126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
From:   "ctmbl via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:42:05 +0000
Subject: [PATCH 1/2] branch: improve error log on branch not found by checking
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
 builtin/branch.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb9..8e768761b9b 100644
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
@@ -263,9 +265,25 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
+				if (virtual_target)
+					error(_(MISSING_BRANCH_HINT_MSG), bname.buf);
+				else
+					error(_(MISSING_BRANCH_ERROR_MSG), bname.buf);
+			}
 			ret = 1;
 			continue;
 		}
-- 
gitgitgadget

