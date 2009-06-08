From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] Documentation: mention 'git stash pop --index' option
	explicitly
Date: Mon,  8 Jun 2009 18:27:52 +0200
Message-ID: <27f7124b574aa6ac4391b9bd029242ceb5874447.1244475542.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDhiD-0001Lc-VW
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 18:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbZFHQ2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 12:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbZFHQ2R
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 12:28:17 -0400
Received: from francis.fzi.de ([141.21.7.5]:59187 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754860AbZFHQ2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 12:28:17 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 18:28:14 +0200
X-Mailer: git-send-email 1.6.3.2.247.gc361f.dirty
X-OriginalArrivalTime: 08 Jun 2009 16:28:15.0004 (UTC) FILETIME=[1F7F55C0:01C9E856]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121083>

'git stash pop' supports the '--index' option since its initial
implementation (bd56ff54, git-stash: add new 'pop' subcommand,
2008-02-22), but its documentation does not mention it explicitly.
Moreover, both the usage shown by 'git stash -h' and the synopsis
section in the man page imply that 'git stash pop' does not have any
options besides the stash to pop.

=46irst, this patch corrects the usage and the synopsis section by list=
ing
the '--index' option for the 'pop' subcommand explicitly.

Second, the patch moves the description of the '--index' option to the
'git stash pop' section in the documentation, and refers to it from
the 'git stash apply' section.  This way it follows the intentions of
commit d1836637 (Documentation: teach stash/pop workflow instead of
stash/apply, 2009-05-28), as all 'git stash pop'-related documentation
will be in one place without references to 'git stash apply'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-stash.txt |   15 ++++++++-------
 git-stash.sh                |    3 ++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1cc24cc..de90550 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
-'git stash' (show | drop | pop ) [<stash>]
+'git stash' (show | drop ) [<stash>]
+'git stash' pop [--index] [<stash>]
 'git stash' apply [--index] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [--keep-index] [<message>]]
@@ -86,16 +87,16 @@ Applying the state can fail with conflicts; in this=
 case, it is not
 removed from the stash list. You need to resolve the conflicts by hand
 and call `git stash drop` manually afterwards.
 +
-When no `<stash>` is given, `stash@\{0}` is assumed. See also `apply`.
-
-apply [--index] [<stash>]::
-
-	Like `pop`, but do not remove the state from the stash list.
-+
 If the `--index` option is used, then tries to reinstate not only the =
working
 tree's changes, but also the index's ones. However, this can fail, whe=
n you
 have conflicts (which are stored in the index, where you therefore can=
 no
 longer apply the changes as they were originally).
++
+When no `<stash>` is given, `stash@\{0}` is assumed.
+
+apply [--index] [<stash>]::
+
+	Like `pop`, but do not remove the state from the stash list.
=20
 branch <branchname> [<stash>]::
=20
diff --git a/git-stash.sh b/git-stash.sh
index b9ace99..94f1d3a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -3,7 +3,8 @@
=20
 dashless=3D$(basename "$0" | sed -e 's/-/ /')
 USAGE=3D"list [<options>]
-   or: $dashless (show | drop | pop ) [<stash>]
+   or: $dashless (show | drop ) [<stash>]
+   or: $dashless pop [--index] [<stash>]
    or: $dashless apply [--index] [<stash>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--keep-index] [<message>]]
--=20
1.6.3.2.247.gc361f.dirty
