From: Thomas Rast <trast@student.ethz.ch>
Subject: [GITK PATCH] gitk: fix direction of --left-right triangles
Date: Sat, 1 Aug 2009 14:47:47 +0200
Message-ID: <0fd5fc0f09779bb04c02b54d6ec8f43087a51bca.1249130587.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	<git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Aug 01 14:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXE0Q-0005fe-Fj
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 14:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZHAMr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 08:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbZHAMr6
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 08:47:58 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:22521 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbZHAMr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 08:47:58 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 1 Aug
 2009 14:47:56 +0200
Received: from localhost.localdomain (129.132.210.111) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 1 Aug
 2009 14:47:54 +0200
X-Mailer: git-send-email 1.6.4.239.gc2c75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124620>

c961b22 (gitk: Use git log and add support for --left-right,
2007-07-09) introduced --left-right support to gitk, but right from
the start, 'gitk --left-right A...B' oriented the triangles the wrong
way: commits coming from A had a triangle to the right, and vice
versa.  To fix this, we simply swap the triangles.  (Note that git-log
does it right.)

Noticed-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Sorry for the double mail, I forgot to Cc the list in the first mail.

 gitk |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 4604c83..5be2a76 100755
--- a/gitk
+++ b/gitk
@@ -5689,16 +5689,16 @@ proc drawcmittext {id row col} {
     } elseif {$listed =3D=3D 3} {
 	# triangle pointing left for left-side commits
 	set t [$canv create polygon \
-		   [expr {$x - $orad}] $y \
-		   [expr {$x + $orad - 1}] [expr {$y - $orad}] \
-		   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
+		   [expr {$x + $orad - 1}] $y \
+		   [expr {$x - $orad}] [expr {$y - $orad}] \
+		   [expr {$x - $orad}] [expr {$y + $orad - 1}] \
 		   -fill $ofill -outline $fgcolor -width 1 -tags circle]
     } else {
 	# triangle pointing right for right-side commits
 	set t [$canv create polygon \
-		   [expr {$x + $orad - 1}] $y \
-		   [expr {$x - $orad}] [expr {$y - $orad}] \
-		   [expr {$x - $orad}] [expr {$y + $orad - 1}] \
+		   [expr {$x - $orad}] $y \
+		   [expr {$x + $orad - 1}] [expr {$y - $orad}] \
+		   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
 		   -fill $ofill -outline $fgcolor -width 1 -tags circle]
     }
     set circleitem($row) $t
--=20
1.6.4.214.gb5b94
