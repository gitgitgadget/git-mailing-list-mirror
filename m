Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDDAC47420
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E243620848
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgJEMQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:16:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:49574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgJEMQb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:16:31 -0400
Received: (qmail 32233 invoked by uid 109); 5 Oct 2020 12:16:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 12:16:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19024 invoked by uid 111); 5 Oct 2020 12:16:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 08:16:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 08:16:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 2/8] fsck_tree(): wrap some long lines
Message-ID: <20201005121630.GB2907394@coredump.intra.peff.net>
References: <20201005121609.GA2907272@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005121609.GA2907272@coredump.intra.peff.net>
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
index 46a108839f..024810139b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -654,7 +654,9 @@ static int fsck_tree(const struct object_id *tree_oid,
 	struct name_stack df_dup_candidates = { NULL };
 
 	if (init_tree_desc_gently(&desc, buffer, size)) {
-		retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_BAD_TREE,
+				 "cannot be parsed as a tree");
 		return retval;
 	}
 
@@ -703,7 +705,9 @@ static int fsck_tree(const struct object_id *tree_oid,
 		}
 
 		if (update_tree_entry_gently(&desc)) {
-			retval += report(options, tree_oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+			retval += report(options, tree_oid, OBJ_TREE,
+					 FSCK_MSG_BAD_TREE,
+					 "cannot be parsed as a tree");
 			break;
 		}
 
@@ -751,25 +755,45 @@ static int fsck_tree(const struct object_id *tree_oid,
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
2.28.0.1295.gf70bcb366f

