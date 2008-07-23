From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] git-completion.bash: provide completion for 'show-branch'
Date: Wed, 23 Jul 2008 23:36:15 +0200
Message-ID: <1216848975-30447-1-git-send-email-trast@student.ethz.ch>
Cc: gitster@pobox.com, "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1e-00026o-El
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbYGWVgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755026AbYGWVgO
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:36:14 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:25733 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754764AbYGWVgE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:36:04 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jul 2008 23:36:02 +0200
Received: from localhost.localdomain ([84.75.148.145]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jul 2008 23:36:01 +0200
X-Mailer: git-send-email 1.6.0.rc0.16.g0680f
X-OriginalArrivalTime: 23 Jul 2008 21:36:01.0928 (UTC) FILETIME=[1A745080:01C8ED0C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89773>

It previously used the same as 'log', but the options are quite
different and the arguments must be single refs (or globs).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/completion/git-completion.bash |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5d260e2..4cfe927 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1210,6 +1210,22 @@ _git_show ()
 	__git_complete_file
 }
 
+_git_show_branch ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--all --remotes --topo-order --current --more=
+			--list --independent --merge-base --no-name
+			--sha1-name --topics --reflog
+			"
+		return
+		;;
+	esac
+	__git_complete_revlist
+}
+
 _git_stash ()
 {
 	local subcommands='save list show apply clear drop pop create'
@@ -1428,7 +1444,7 @@ _git ()
 	send-email)  _git_send_email ;;
 	shortlog)    _git_shortlog ;;
 	show)        _git_show ;;
-	show-branch) _git_log ;;
+	show-branch) _git_show_branch ;;
 	stash)       _git_stash ;;
 	submodule)   _git_submodule ;;
 	svn)         _git_svn ;;
-- 
1.6.0.rc0.16.g0680f
