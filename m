From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/6] merge-recur: Cleanup last mixedCase variables...
Date: Thu, 27 Jul 2006 19:13:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271913300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 27 19:14:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69R0-0002V4-B0
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWG0RNt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWG0RNt
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:13:49 -0400
Received: from mail.gmx.net ([213.165.64.21]:60892 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751863AbWG0RNs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:13:48 -0400
Received: (qmail invoked by alias); 27 Jul 2006 17:13:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 27 Jul 2006 19:13:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24313>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 645ef8c..b0f2ecc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -609,7 +609,7 @@ static char *git_unpack_file(const unsig
 
 static struct merge_file_info merge_file(struct diff_filespec *o,
 		struct diff_filespec *a, struct diff_filespec *b,
-		const char *branch1Name, const char *branch2Name)
+		const char *branch1, const char *branch2)
 {
 	struct merge_file_info result;
 	result.merge = 0;
@@ -651,8 +651,8 @@ static struct merge_file_info merge_file
 			git_unpack_file(a->sha1, src1);
 			git_unpack_file(b->sha1, src2);
 
-			argv[2] = la = strdup(mkpath("%s/%s", branch1Name, a->path));
-			argv[6] = lb = strdup(mkpath("%s/%s", branch2Name, b->path));
+			argv[2] = la = strdup(mkpath("%s/%s", branch1, a->path));
+			argv[6] = lb = strdup(mkpath("%s/%s", branch2, b->path));
 			argv[4] = lo = strdup(mkpath("orig/%s", o->path));
 			argv[7] = src1;
 			argv[8] = orig;
@@ -966,8 +966,8 @@ static unsigned char *has_sha(const unsi
 
 /* Per entry merge function */
 static int process_entry(const char *path, struct stage_data *entry,
-			 const char *branch1Name,
-			 const char *branch2Name)
+			 const char *branch1,
+			 const char *branch2)
 {
 	/*
 	printf("processing entry, clean cache: %s\n", index_only ? "yes": "no");
@@ -997,14 +997,14 @@ static int process_entry(const char *pat
 			if (!a_sha) {
 				output("CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
-				       path, branch1Name,
-				       branch2Name, branch2Name, path);
+				       path, branch1,
+				       branch2, branch2, path);
 				update_file(0, b_sha, b_mode, path);
 			} else {
 				output("CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
-				       path, branch2Name,
-				       branch1Name, branch1Name, path);
+				       path, branch2,
+				       branch1, branch1, path);
 				update_file(0, a_sha, a_mode, path);
 			}
 		}
@@ -1019,14 +1019,14 @@ static int process_entry(const char *pat
 		const char *conf;
 
 		if (a_sha) {
-			add_branch = branch1Name;
-			other_branch = branch2Name;
+			add_branch = branch1;
+			other_branch = branch2;
 			mode = a_mode;
 			sha = a_sha;
 			conf = "file/directory";
 		} else {
-			add_branch = branch2Name;
-			other_branch = branch1Name;
+			add_branch = branch2;
+			other_branch = branch1;
 			mode = b_mode;
 			sha = b_sha;
 			conf = "directory/file";
@@ -1060,8 +1060,8 @@ static int process_entry(const char *pat
 		} else {
 			const char *new_path1, *new_path2;
 			clean_merge = 0;
-			new_path1 = unique_path(path, branch1Name);
-			new_path2 = unique_path(path, branch2Name);
+			new_path1 = unique_path(path, branch1);
+			new_path2 = unique_path(path, branch2);
 			output("CONFLICT (add/add): File %s added non-identically "
 			       "in both branches. Adding as %s and %s instead.",
 			       path, new_path1, new_path2);
@@ -1085,7 +1085,7 @@ static int process_entry(const char *pat
 		b.mode = b_mode;
 		
 		mfi = merge_file(&o, &a, &b,
-				 branch1Name, branch2Name);
+				 branch1, branch2);
 
 		if (mfi.clean)
 			update_file(1, mfi.sha, mfi.mode, path);
@@ -1111,8 +1111,8 @@ static int process_entry(const char *pat
 static int merge_trees(struct tree *head,
 		       struct tree *merge,
 		       struct tree *common,
-		       const char *branch1Name,
-		       const char *branch2Name,
+		       const char *branch1,
+		       const char *branch2,
 		       struct tree **result)
 {
 	int code, clean;
@@ -1143,13 +1143,13 @@ static int merge_trees(struct tree *head
 		re_head  = get_renames(head, common, head, merge, entries);
 		re_merge = get_renames(merge, common, head, merge, entries);
 		clean = process_renames(re_head, re_merge,
-				branch1Name, branch2Name);
+				branch1, branch2);
 		for (i = 0; i < entries->nr; i++) {
 			const char *path = entries->items[i].path;
 			struct stage_data *e = entries->items[i].util;
 			if (e->processed)
 				continue;
-			if (!process_entry(path, e, branch1Name, branch2Name))
+			if (!process_entry(path, e, branch1, branch2))
 				clean = 0;
 		}
 
@@ -1179,8 +1179,8 @@ static int merge_trees(struct tree *head
 static
 int merge(struct commit *h1,
 			  struct commit *h2,
-			  const char *branch1Name,
-			  const char *branch2Name,
+			  const char *branch1,
+			  const char *branch2,
 			  int call_depth /* =0 */,
 			  struct commit *ancestor /* =None */,
 			  struct commit **result)
@@ -1236,7 +1236,7 @@ int merge(struct commit *h1,
 	}
 
 	clean = merge_trees(h1->tree, h2->tree, merged_common_ancestors->tree,
-			    branch1Name, branch2Name, &mrtree);
+			    branch1, branch2, &mrtree);
 
 	if (!ancestor && (clean || index_only)) {
 		*result = make_virtual_commit(mrtree, "merged tree");
-- 
1.4.2.rc2.g6a4e
