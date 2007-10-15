From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH 1/2] gitk: Added support for OS X mouse wheel
Date: Mon, 15 Oct 2007 10:33:07 +0100
Message-ID: <1192440788347-git-send-email-maillist@steelskies.com>
References: <8c5c35580710141727k4bbd2bgc2292cfcc6f97c4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 11:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhMKD-0002gp-V4
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 11:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbXJOJdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2007 05:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756469AbXJOJdN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 05:33:13 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:49466 "EHLO
	gir.office.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472AbXJOJdL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 05:33:11 -0400
Received: by gir.office.bestbefore.tv (Postfix, from userid 501)
	id BB3B5270100; Mon, 15 Oct 2007 10:33:08 +0100 (BST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <8c5c35580710141727k4bbd2bgc2292cfcc6f97c4a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60972>

=46rom: Jonathan del Strother <jon.delStrother@bestbefore.tv>

(V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 supplied this patch a while ago for =
1.5.2.  It no longer
applied cleanly, so I'm reposting it.)

MacBook doesn't seem to recognize MouseRelease-4 and -5 events, at all.
So i added a support for the MouseWheel event, which i limited to Tcl/t=
k
aqua, as i couldn't test it neither on Linux or Windows. Tcl/tk needs t=
o
be updated from the version that is shipped with OS X 10.4 Tiger, for
this patch to work.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
 gitk |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..ee2a6f5 100755
--- a/gitk
+++ b/gitk
@@ -843,6 +843,12 @@ proc makewindow {} {
     } else {
 	bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
 	bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
+        if {[tk windowingsystem] eq "aqua"} {
+            bindall <MouseWheel> {
+                set delta [expr {- (%D)}]
+                allcanvs yview scroll $delta units
+            }
+        }
     }
     bindall <2> "canvscan mark %W %x %y"
     bindall <B2-Motion> "canvscan dragto %W %x %y"
--=20
1.5.3.1
