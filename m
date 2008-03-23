From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH 3/4] Add a function for get the parents of a commit
Date: Sun, 23 Mar 2008 22:42:41 +0100
Message-ID: <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, B.Steinbrink@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 22:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdY2T-0007dT-AK
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 22:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbYCWVqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 17:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755098AbYCWVqs
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 17:46:48 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4009 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167AbYCWVqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 17:46:47 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 73A6F48802D; Sun, 23 Mar 2008 22:46:45 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdXxk-0004pD-CS; Sun, 23 Mar 2008 22:42:48 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdXxi-0008CS-Mg; Sun, 23 Mar 2008 22:42:42 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77962>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ffd4823..94c6827 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -131,6 +131,10 @@ redo_merge() {
 	fi
 }
=20
+parents_of_commit() {
+	git rev-list --parents -1 "$1" | cut -d' ' -f2-
+}
+
 pick_one () {
 	no_ff=3D
 	case "$1" in -n) sha1=3D$2; no_ff=3Dt ;; *) sha1=3D$1 ;; esac
@@ -166,7 +170,7 @@ pick_one_preserving_merges () {
 	fast_forward=3Dt
 	preserve=3Dt
 	new_parents=3D
-	for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
+	for p in $(parents_of_commit $sha1)
 	do
 		if test -f "$REWRITTEN"/$p
 		then
--=20
1.5.4.4
