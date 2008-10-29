From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 29 Oct 2008 09:15:36 -0700
Message-ID: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
Cc: David Symonds <dsymonds@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 17:17:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvDjp-0002nz-8t
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 17:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbYJ2QQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 12:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYJ2QQ0
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 12:16:26 -0400
Received: from smtp-out.google.com ([216.239.33.17]:42673 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbYJ2QQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 12:16:26 -0400
Received: from spaceape7.eur.corp.google.com (spaceape7.eur.corp.google.com [172.28.16.141])
	by smtp-out.google.com with ESMTP id m9TGFgv2022782;
	Wed, 29 Oct 2008 16:15:42 GMT
Received: from localhost.localdomain (dhcp-172-19-79-244.mtv.corp.google.com [172.19.79.244])
	by spaceape7.eur.corp.google.com with ESMTP id m9TGFbxB022241;
	Wed, 29 Oct 2008 09:15:38 -0700
X-Mailer: git-send-email 1.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99376>

---
 Consider this as a replacement to the previous git-staged series.

 Documentation/git-diff.txt |    1 +
 builtin-diff.c             |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index c53eba5..a2f192f 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -33,6 +33,7 @@ forced by --no-index.
 	commit relative to the named <commit>.  Typically you
 	would want comparison with the latest commit, so if you
 	do not give <commit>, it defaults to HEAD.
+	--staged is a synonym of --cached.
 
 'git diff' [--options] <commit> [--] [<path>...]::
 
diff --git a/builtin-diff.c b/builtin-diff.c
index 2de5834..7ceceeb 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -118,7 +118,7 @@ static int builtin_diff_index(struct rev_info *revs,
 	int cached = 0;
 	while (1 < argc) {
 		const char *arg = argv[1];
-		if (!strcmp(arg, "--cached"))
+		if (!strcmp(arg, "--cached") || !strcmp(arg, "--staged"))
 			cached = 1;
 		else
 			usage(builtin_diff_usage);
@@ -320,7 +320,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			const char *arg = argv[i];
 			if (!strcmp(arg, "--"))
 				break;
-			else if (!strcmp(arg, "--cached")) {
+			else if (!strcmp(arg, "--cached") ||
+				 !strcmp(arg, "--staged")) {
 				add_head_to_pending(&rev);
 				if (!rev.pending.nr)
 					die("No HEAD commit to compare with (yet)");
-- 
1.6.0
