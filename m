From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 1/2] Make more commands work in subdirectory
Date: Thu, 14 Sep 2006 05:03:59 +0400
Message-ID: <20060914010359.GA20593@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 03:04:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNfeL-0004X4-M0
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 03:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWINBEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 21:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWINBEE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 21:04:04 -0400
Received: from mh.altlinux.org ([217.16.24.5]:17352 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S1751298AbWINBEC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 21:04:02 -0400
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP
	id 30BCB2F3000D; Thu, 14 Sep 2006 05:04:00 +0400 (MSD)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id A3C3817103; Thu, 14 Sep 2006 05:03:59 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26969>

count-objects, describe, merge-tree:
	Call setup_git_directory() to make these commands work in subdirectory.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 describe.c   |    2 ++
 git.c        |    2 +-
 merge-tree.c |    2 ++
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/describe.c b/describe.c
index 5dd8b2e..5ed052d 100644
--- a/describe.c
+++ b/describe.c
@@ -161,6 +161,8 @@ int main(int argc, char **argv)
 			usage(describe_usage);
 	}
 
+	setup_git_directory();
+
 	if (i == argc)
 		describe("HEAD", 1);
 	else
diff --git a/git.c b/git.c
index 335f405..47c85e1 100644
--- a/git.c
+++ b/git.c
@@ -224,7 +224,7 @@ static void handle_internal_command(int 
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-		{ "count-objects", cmd_count_objects },
+		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "diff", cmd_diff, RUN_SETUP },
 		{ "diff-files", cmd_diff_files, RUN_SETUP },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
diff --git a/merge-tree.c b/merge-tree.c
index 60df758..c154dcf 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -340,6 +340,8 @@ int main(int argc, char **argv)
 	if (argc < 4)
 		usage(merge_tree_usage);
 
+	setup_git_directory();
+
 	buf1 = get_tree_descriptor(t+0, argv[1]);
 	buf2 = get_tree_descriptor(t+1, argv[2]);
 	buf3 = get_tree_descriptor(t+2, argv[3]);


-- 
ldv
