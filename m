Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF49C433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC576102A
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhEAPmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 11:42:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:42118 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhEAPme (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 11:42:34 -0400
Received: (qmail 26632 invoked by uid 109); 1 May 2021 15:41:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 15:41:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10799 invoked by uid 111); 1 May 2021 15:41:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 11:41:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 11:41:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/9] fsck_tree(): wrap some long lines
Message-ID: <YI12t5gzfzIxvZs3@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many calls to report() in fsck_tree() are kept on a single line and are
quite long. Most were pretty big to begin with, but have gotten even
longer over the years as we've added more parameters. Let's accept the
churn of wrapping them in order to conform to our usual line limits.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index dd31ed1413..db94817898 100644
--- a/fsck.c
+++ b/fsck.c
@@ -579,7 +579,9 @@ static int fsck_tree(const struct object_id *tree_oid,
 	struct name_stack df_dup_candidates = { NULL };
 
 	if (init_tree_desc_gently(&desc, buffer, size)) {
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_BAD_TREE,
+				 "cannot be parsed as a tree");
 		return retval;
 	}
 
@@ -630,7 +632,9 @@ static int fsck_tree(const struct object_id *tree_oid,
 		}
 
 		if (update_tree_entry_gently(&desc)) {
-			retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+			retval += report(options, tree_oid, OBJ_TREE,
+					 FSCK_MSG_BAD_TREE,
+					 "cannot be parsed as a tree");
 			break;
 		}
 
@@ -678,25 +682,45 @@ static int fsck_tree(const struct object_id *tree_oid,
 	name_stack_clear(&df_dup_candidates);
 
 	if (has_null_sha1)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_NULL_SHA1,
+				 "contains entries pointing to null sha1");
 	if (has_full_path)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_FULL_PATHNAME,
+				 "contains full pathnames");
 	if (has_empty_name)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_EMPTY_NAME,
+				 "contains empty pathname");
 	if (has_dot)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_HAS_DOT, "contains '.'");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_HAS_DOT,
+				 "contains '.'");
 	if (has_dotdot)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_HAS_DOTDOT, "contains '..'");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_HAS_DOTDOT,
+				 "contains '..'");
 	if (has_dotgit)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_HAS_DOTGIT,
+				 "contains '.git'");
 	if (has_zero_pad)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_ZERO_PADDED_FILEMODE,
+				 "contains zero-padded file modes");
 	if (has_bad_modes)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_BAD_FILEMODE,
+				 "contains bad file modes");
 	if (has_dup_entries)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_DUPLICATE_ENTRIES,
+				 "contains duplicate file entries");
 	if (not_properly_sorted)
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_TREE_NOT_SORTED,
+				 "not properly sorted");
 	return retval;
 }
 
-- 
2.31.1.875.g5dccece0aa

