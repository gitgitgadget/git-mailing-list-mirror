From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 1/2] Documentation: mention 'git stash pop --index' option
	explicitly
Date: Tue,  9 Jun 2009 00:57:06 +0200
Message-ID: <d07a10275620808bc378340cc8450d3e8de8cf7e.1244501726.git.szeder@ira.uka.de>
References: <20090608214243.GK13773@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDnmM-0001gC-DR
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 00:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbZFHW5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 18:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755762AbZFHW5M
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 18:57:12 -0400
Received: from francis.fzi.de ([141.21.7.5]:47112 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755482AbZFHW5L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 18:57:11 -0400
Received: from [127.0.1.1] ([91.19.66.149]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Jun 2009 00:57:09 +0200
X-Mailer: git-send-email 1.6.3.2.252.g5b6b0
In-Reply-To: <20090608214243.GK13773@neumann>
X-OriginalArrivalTime: 08 Jun 2009 22:57:09.0848 (UTC) FILETIME=[7425F580:01C9E88C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121126>

'git stash pop' supports the '--index' option since its initial
implementation (bd56ff54, git-stash: add new 'pop' subcommand,
2008-02-22), but its documentation does not mention it explicitly.
Moreover, both the usage shown by 'git stash -h' and the synopsis
section in the man page imply that 'git stash pop' does not have an
'--index' option.

=46irst, this patch corrects the usage and the synopsis section.

Second, the patch moves the description of the '--index' option to the
'git stash pop' section in the documentation, and refers to it from
the 'git stash apply' section.  This way it follows the intentions of
commit d1836637 (Documentation: teach stash/pop workflow instead of
stash/apply, 2009-05-28), as all 'git stash pop'-related documentation
will be in one place without references to 'git stash apply'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-stash.txt |   16 ++++++++--------
 git-stash.sh                |    4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1cc24cc..a42d4c8 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
-'git stash' (show | drop | pop ) [<stash>]
-'git stash' apply [--index] [<stash>]
+'git stash' ( show | drop ) [<stash>]
+'git stash' ( pop | apply ) [--index] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [--keep-index] [<message>]]
 'git stash' clear
@@ -86,16 +86,16 @@ Applying the state can fail with conflicts; in this=
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
index b9ace99..e6a5867 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -3,8 +3,8 @@
=20
 dashless=3D$(basename "$0" | sed -e 's/-/ /')
 USAGE=3D"list [<options>]
-   or: $dashless (show | drop | pop ) [<stash>]
-   or: $dashless apply [--index] [<stash>]
+   or: $dashless ( show | drop ) [<stash>]
+   or: $dashless ( pop | apply ) [--index] [<stash>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--keep-index] [<message>]]
    or: $dashless clear"
--=20
1.6.3.2.252.g5b6b0
