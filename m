From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH 1/2] Add 'git rev-parse --show-toplevel' option.
Date: Tue, 12 Jan 2010 11:33:48 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001121133080.10158@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1001102011420.2560@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:40:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUSvi-0005Th-FC
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 23:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab0AKWkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 17:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692Ab0AKWkE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 17:40:04 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:54465 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621Ab0AKWkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 17:40:04 -0500
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id 782CD170B48;
	Tue, 12 Jan 2010 11:40:01 +1300 (NZDT)
In-Reply-To: <alpine.LNX.2.00.1001102011420.2560@vqena.qenxr.bet.am>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136674>

Shows the absolute path of the top-level working directory.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 Documentation/git-rev-parse.txt |    3 +++
 builtin-rev-parse.c             |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 82045a2..dc829b3 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -112,6 +112,9 @@ OPTIONS
 --remotes::
 	Show tag refs found in `$GIT_DIR/refs/remotes`.
 
+--show-toplevel::
+	Show the absolute path of the top-level directory.
+
 --show-prefix::
 	When the command is invoked from a subdirectory, show the
 	path of the current directory relative to the top-level
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37d0233..96ab8bb 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -581,6 +581,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_remote_ref(show_reference, NULL);
 				continue;
 			}
+			if (!strcmp(arg, "--show-toplevel")) {
+				const char *work_tree = get_git_work_tree();
+				if (work_tree)
+					printf("%s\n", work_tree);
+				continue;
+			}
 			if (!strcmp(arg, "--show-prefix")) {
 				if (prefix)
 					puts(prefix);
-- 
1.6.4
