From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: gitk accepts common log-shortlog options
Date: Tue, 21 Jul 2009 17:20:02 -0500
Message-ID: <1248214802-2996-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 00:20:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTNhF-0003Ey-GD
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 00:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbZGUWUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2009 18:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756081AbZGUWUU
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 18:20:20 -0400
Received: from francis.fzi.de ([141.21.7.5]:8470 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756029AbZGUWUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 18:20:19 -0400
Received: from localhost.localdomain ([141.21.16.17]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Jul 2009 00:20:14 +0200
X-Mailer: git-send-email 1.6.4.rc1.73.ga0daf
X-OriginalArrivalTime: 21 Jul 2009 22:20:14.0797 (UTC) FILETIME=[6BA33FD0:01CA0A51]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123723>

Commit a393777e (bash completion: refactor common log, shortlog and git=
k
options, 2009-02-16) introduced a list of command line options that go
well with 'git log' and 'git shortlog' but not with gitk.  However,
these options are all 'git rev-list' options, and, therefore, are
accepted by gitk, too.

This patch moves these options to the list of common options, making
them available for gitk option completion, too.  Since the list of
log-shortlog options becomes empty with this move, this patch deletes
it.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index bc2d8b4..f0cd5e3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1118,6 +1118,8 @@ __git_log_common_options=3D"
 	--max-count=3D
 	--max-age=3D --since=3D --after=3D
 	--min-age=3D --until=3D --before=3D
+	--author=3D --committer=3D --grep=3D
+	--all-match
 "
 # Options that go well for log and gitk (not shortlog)
 __git_log_gitk_options=3D"
@@ -1125,11 +1127,6 @@ __git_log_gitk_options=3D"
 	--simplify-merges --simplify-by-decoration
 	--left-right
 "
-# Options that go well for log and shortlog (not gitk)
-__git_log_shortlog_options=3D"
-	--author=3D --committer=3D --grep=3D
-	--all-match
-"
=20
 __git_log_pretty_formats=3D"oneline short medium full fuller email raw=
 format:"
 __git_log_date_formats=3D"relative iso8601 rfc2822 short local default=
 raw"
@@ -1162,7 +1159,6 @@ _git_log ()
 	--*)
 		__gitcomp "
 			$__git_log_common_options
-			$__git_log_shortlog_options
 			$__git_log_gitk_options
 			--root --topo-order --date-order --reverse
 			--follow --full-diff
@@ -1822,7 +1818,6 @@ _git_shortlog ()
 	--*)
 		__gitcomp "
 			$__git_log_common_options
-			$__git_log_shortlog_options
 			--numbered --summary
 			"
 		return
--=20
1.6.4.rc1.73.ga0daf
