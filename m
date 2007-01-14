From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Convert output messages in merge-recursive to past tense.
Date: Sun, 14 Jan 2007 03:11:28 -0500
Message-ID: <20070114081128.GB19566@spearce.org>
References: <9ea4596ac973e294eee5eeda441589d3d8b28133.1168762240.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 09:11:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H60Sq-0004Y1-8l
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 09:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbXANILd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 03:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXANILc
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 03:11:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50531 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbXANILc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 03:11:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H60Se-000438-I7; Sun, 14 Jan 2007 03:11:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C261820FBAE; Sun, 14 Jan 2007 03:11:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <9ea4596ac973e294eee5eeda441589d3d8b28133.1168762240.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36797>

Now that we are showing the output messages for verbosity levels
<5 after all actions have been performed (due to the progress meter
running during the actions) it can be confusing to see messages in
the present tense when the user is looking at a '100% done' message
right above them.  Converting the messages to past tense will appear
more correct in this case, and shouldn't affect a developer who is
debugging the application and running it at a verbosity level >=5.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-recursive.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2a89461..c9f0d81 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -724,13 +724,13 @@ static void conflict_rename_rename(struct rename *ren1,
 	const char *dst_name2 = ren2_dst;
 	if (path_list_has_path(&current_directory_set, ren1_dst)) {
 		dst_name1 = del[delp++] = unique_path(ren1_dst, branch1);
-		output(1, "%s is a directory in %s adding as %s instead",
+		output(1, "%s is a directory in %s added as %s instead",
 		       ren1_dst, branch2, dst_name1);
 		remove_file(0, ren1_dst, 0);
 	}
 	if (path_list_has_path(&current_directory_set, ren2_dst)) {
 		dst_name2 = del[delp++] = unique_path(ren2_dst, branch2);
-		output(1, "%s is a directory in %s adding as %s instead",
+		output(1, "%s is a directory in %s added as %s instead",
 		       ren2_dst, branch1, dst_name2);
 		remove_file(0, ren2_dst, 0);
 	}
@@ -744,7 +744,7 @@ static void conflict_rename_dir(struct rename *ren1,
 				const char *branch1)
 {
 	char *new_path = unique_path(ren1->pair->two->path, branch1);
-	output(1, "Renaming %s to %s instead", ren1->pair->one->path, new_path);
+	output(1, "Renamed %s to %s instead", ren1->pair->one->path, new_path);
 	remove_file(0, ren1->pair->two->path, 0);
 	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
 	free(new_path);
@@ -757,7 +757,7 @@ static void conflict_rename_rename_2(struct rename *ren1,
 {
 	char *new_path1 = unique_path(ren1->pair->two->path, branch1);
 	char *new_path2 = unique_path(ren2->pair->two->path, branch2);
-	output(1, "Renaming %s to %s and %s to %s instead",
+	output(1, "Renamed %s to %s and %s to %s instead",
 	       ren1->pair->one->path, new_path1,
 	       ren2->pair->one->path, new_path2);
 	remove_file(0, ren1->pair->two->path, 0);
@@ -865,10 +865,10 @@ static int process_renames(struct path_list *a_renames,
 						 branch1,
 						 branch2);
 				if (mfi.merge || !mfi.clean)
-					output(2, "Renaming %s->%s", src, ren1_dst);
+					output(2, "Renamed %s->%s", src, ren1_dst);
 
 				if (mfi.merge)
-					output(2, "Auto-merging %s", ren1_dst);
+					output(2, "Auto-merged %s", ren1_dst);
 
 				if (!mfi.clean) {
 					output(1, "CONFLICT (content): merge conflict in %s",
@@ -902,14 +902,14 @@ static int process_renames(struct path_list *a_renames,
 
 			if (path_list_has_path(&current_directory_set, ren1_dst)) {
 				clean_merge = 0;
-				output(1, "CONFLICT (rename/directory): Rename %s->%s in %s "
+				output(1, "CONFLICT (rename/directory): Renamed %s->%s in %s "
 				       " directory %s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				conflict_rename_dir(ren1, branch1);
 			} else if (sha_eq(src_other.sha1, null_sha1)) {
 				clean_merge = 0;
-				output(1, "CONFLICT (rename/delete): Rename %s->%s in %s "
+				output(1, "CONFLICT (rename/delete): Renamed %s->%s in %s "
 				       "and deleted in %s",
 				       ren1_src, ren1_dst, branch1,
 				       branch2);
@@ -918,19 +918,19 @@ static int process_renames(struct path_list *a_renames,
 				const char *new_path;
 				clean_merge = 0;
 				try_merge = 1;
-				output(1, "CONFLICT (rename/add): Rename %s->%s in %s. "
+				output(1, "CONFLICT (rename/add): Renamed %s->%s in %s. "
 				       "%s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				new_path = unique_path(ren1_dst, branch2);
-				output(1, "Adding as %s instead", new_path);
+				output(1, "Added as %s instead", new_path);
 				update_file(0, dst_other.sha1, dst_other.mode, new_path);
 			} else if ((item = path_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
 				ren2->processed = 1;
-				output(1, "CONFLICT (rename/rename): Rename %s->%s in %s. "
-				       "Rename %s->%s in %s",
+				output(1, "CONFLICT (rename/rename): Renamed %s->%s in %s. "
+				       "Renamed %s->%s in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren2->pair->one->path, ren2->pair->two->path, branch2);
 				conflict_rename_rename_2(ren1, branch1, ren2, branch2);
@@ -954,9 +954,9 @@ static int process_renames(struct path_list *a_renames,
 						a_branch, b_branch);
 
 				if (mfi.merge || !mfi.clean)
-					output(2, "Renaming %s => %s", ren1_src, ren1_dst);
+					output(2, "Renamed %s => %s", ren1_src, ren1_dst);
 				if (mfi.merge)
-					output(2, "Auto-merging %s", ren1_dst);
+					output(2, "Auto-merged %s", ren1_dst);
 				if (!mfi.clean) {
 					output(1, "CONFLICT (rename/modify): Merge conflict in %s",
 					       ren1_dst);
@@ -1006,7 +1006,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
-				output(2, "Removing %s", path);
+				output(2, "Removed %s", path);
 			/* do not touch working file if it did not exist */
 			remove_file(1, path, !a_sha);
 		} else {
@@ -1053,12 +1053,12 @@ static int process_entry(const char *path, struct stage_data *entry,
 			const char *new_path = unique_path(path, add_branch);
 			clean_merge = 0;
 			output(1, "CONFLICT (%s): There is a directory with name %s in %s. "
-			       "Adding %s as %s",
+			       "Added %s as %s",
 			       conf, path, other_branch, path, new_path);
 			remove_file(0, path, 0);
 			update_file(0, sha, mode, new_path);
 		} else {
-			output(2, "Adding %s", path);
+			output(2, "Added %s", path);
 			update_file(1, sha, mode, path);
 		}
 	} else if (a_sha && b_sha) {
@@ -1072,7 +1072,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			reason = "add/add";
 			o_sha = (unsigned char *)null_sha1;
 		}
-		output(2, "Auto-merging %s", path);
+		output(2, "Auto-merged %s", path);
 		o.path = a.path = b.path = (char *)path;
 		hashcpy(o.sha1, o_sha);
 		o.mode = o_mode;
-- 
1.5.0.rc1.g4494
