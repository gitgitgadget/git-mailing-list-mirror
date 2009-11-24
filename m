From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: update descriptions of revision options
	related to '--bisect'
Date: Tue, 24 Nov 2009 07:54:44 +0100
Message-ID: <20091124065445.4002.9082.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 08:08:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCpVW-0006Ov-Jk
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 08:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbZKXHIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 02:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758006AbZKXHIB
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 02:08:01 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:34522 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757957AbZKXHIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 02:08:00 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 026908180CC;
	Tue, 24 Nov 2009 08:08:00 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6E6B781811B;
	Tue, 24 Nov 2009 08:07:57 +0100 (CET)
X-git-sha1: cf5d5541012bac0a1b9b2082e3ea0c15559b0d69 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133561>

In commit ad3f9a7 (Add '--bisect' revision machinery argument) the
'--bisect' option was added to easily pass bisection refs to commands
using the revision machinery.

This patch updates the documentation of the related options to describe
the new behavior.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/rev-list-options.txt |   39 ++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b44fdd9..1f57aed 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -243,6 +243,15 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `$GIT_DIR/refs/remotes` are listed
 	on the command line as '<commit>'.
 
+ifndef::git-rev-list[]
+--bisect::
+
+	Pretend as if the bad bisection ref `$GIT_DIR/refs/bisect/bad`
+	was listed and as if it was followed by `--not` and the good
+	bisection refs `$GIT_DIR/refs/bisect/good-*` on the command
+	line.
+endif::git-rev-list[]
+
 --stdin::
 
 	In addition to the '<commit>' listed on the command
@@ -538,7 +547,11 @@ Bisection Helpers
 --bisect::
 
 Limit output to the one commit object which is roughly halfway between
-the included and excluded commits. Thus, if
+included and excluded commits. Note that the bad bisection ref
+`$GIT_DIR/refs/bisect/bad` is added to the included commits (if it
+exists) and the good bisection refs `$GIT_DIR/refs/bisect/good-*` are
+added to the excluded commits (if they exist). Thus, supposing there
+are no refs in `$GIT_DIR/refs/bisect/`, if
 
 -----------------------------------------------------------------------
 	$ git rev-list --bisect foo ^bar ^baz
@@ -558,22 +571,24 @@ one.
 
 --bisect-vars::
 
-This calculates the same as `--bisect`, but outputs text ready
-to be eval'ed by the shell. These lines will assign the name of
-the midpoint revision to the variable `bisect_rev`, and the
-expected number of commits to be tested after `bisect_rev` is
-tested to `bisect_nr`, the expected number of commits to be
-tested if `bisect_rev` turns out to be good to `bisect_good`,
-the expected number of commits to be tested if `bisect_rev`
-turns out to be bad to `bisect_bad`, and the number of commits
-we are bisecting right now to `bisect_all`.
+This calculates the same as `--bisect`, except that refs in
+`$GIT_DIR/refs/bisect/` are not used, and except that this outputs
+text ready to be eval'ed by the shell. These lines will assign the
+name of the midpoint revision to the variable `bisect_rev`, and the
+expected number of commits to be tested after `bisect_rev` is tested
+to `bisect_nr`, the expected number of commits to be tested if
+`bisect_rev` turns out to be good to `bisect_good`, the expected
+number of commits to be tested if `bisect_rev` turns out to be bad to
+`bisect_bad`, and the number of commits we are bisecting right now to
+`bisect_all`.
 
 --bisect-all::
 
 This outputs all the commit objects between the included and excluded
 commits, ordered by their distance to the included and excluded
-commits. The farthest from them is displayed first. (This is the only
-one displayed by `--bisect`.)
+commits. Refs in `$GIT_DIR/refs/bisect/` are not used. The farthest
+from them is displayed first. (This is the only one displayed by
+`--bisect`.)
 +
 This is useful because it makes it easy to choose a good commit to
 test when you want to avoid to test some of them for some reason (they
-- 
1.6.5.1.gaf97d
