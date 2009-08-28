From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 03/15] rebase -i: use "git sequencer--helper --make-patch"
Date: Fri, 28 Aug 2009 06:47:33 +0200
Message-ID: <20090828044746.4307.95146.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtZn-0006Ec-VB
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbZH1E7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZH1E7M
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:12 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49717 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbZH1E7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:08 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A3F4D8180D5;
	Fri, 28 Aug 2009 06:59:02 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 661D08180AC;
	Fri, 28 Aug 2009 06:58:59 +0200 (CEST)
X-git-sha1: e4a110c742d2c3e1b3770c66afa3d74eedb78847 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127268>

to simplify the "make_patch" function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..c9c75c0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -117,18 +117,7 @@ mark_action_done () {
 }
 
 make_patch () {
-	sha1_and_parents="$(git rev-list --parents -1 "$1")"
-	case "$sha1_and_parents" in
-	?*' '?*' '?*)
-		git diff --cc $sha1_and_parents
-		;;
-	?*' '?*)
-		git diff-tree -p "$1^!"
-		;;
-	*)
-		echo "Root commit"
-		;;
-	esac > "$DOTEST"/patch
+	git sequencer--helper --make-patch "$1"
 	test -f "$DOTEST"/message ||
 		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
 	test -f "$DOTEST"/author-script ||
-- 
1.6.4.271.ge010d
