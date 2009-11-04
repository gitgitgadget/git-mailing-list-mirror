From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 3/3] bisect: simplify calling visualizer using
	'--bisect-refs'
Date: Wed, 04 Nov 2009 05:00:03 +0100
Message-ID: <20091104040004.4545.72084.chriscool@tuxfamily.org>
References: <20091104034312.4545.2176.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 04:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5X1B-0003dl-UG
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 04:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbZKDD6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 22:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754374AbZKDD6d
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 22:58:33 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55897 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbZKDD6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 22:58:31 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6C93681805A;
	Wed,  4 Nov 2009 04:58:30 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 48CFD818054;
	Wed,  4 Nov 2009 04:58:28 +0100 (CET)
X-git-sha1: 6456c50419a1e688dc6eed874e7378879cb2b809 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091104034312.4545.2176.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132032>

It is now shorter and safer to use the new '--bisect-refs' revision
machinery option, than to compute the refs that we must pass.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 8b3c585..41b9118 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -300,8 +300,7 @@ bisect_visualize() {
 		esac
 	fi
 
-	not=$(git for-each-ref --format='%(refname)' "refs/bisect/good-*")
-	eval '"$@"' refs/bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
+	eval '"$@"' --bisect-refs -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
 bisect_reset() {
-- 
1.6.5.1.gaf97d
