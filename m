From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: simplify calling visualizer using '--bisect' option
Date: Mon, 23 Nov 2009 05:16:14 +0100
Message-ID: <20091123041615.4361.52673.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 05:18:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCQNp-0002KQ-4d
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 05:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306AbZKWESO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 23:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756301AbZKWESN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 23:18:13 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:58105 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756292AbZKWESN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 23:18:13 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8E661818052;
	Mon, 23 Nov 2009 05:18:12 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3FF56818023;
	Mon, 23 Nov 2009 05:18:10 +0100 (CET)
X-git-sha1: aa20dc57b7cb30d556f1201128e2e7c71df12245 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133480>

In commit ad3f9a7 (Add '--bisect' revision machinery argument) the
'--bisect' option was added to easily pass bisection refs to
commands using the revision machinery.

So it is now shorter and safer to use the new '--bisect' revision
machinery option, than to compute the refs that we must pass.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

	This patch was previously sent in an RFC series aimed at
	using '--bisect-refs' instead of '--bisect' as the revision
	machinery bisect option.

diff --git a/git-bisect.sh b/git-bisect.sh
index 8b3c585..a5ea843 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -300,8 +300,7 @@ bisect_visualize() {
 		esac
 	fi
 
-	not=$(git for-each-ref --format='%(refname)' "refs/bisect/good-*")
-	eval '"$@"' refs/bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
+	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
 bisect_reset() {
-- 
1.6.5.1.gaf97d
