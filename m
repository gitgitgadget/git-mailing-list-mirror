From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: [PATCH] gitk: Added support for OS X mouse wheel
Date: Sun, 29 Jul 2007 09:38:34 +0300
Message-ID: <35284D1E-B5B6-435B-91C3-539395882B95@pp.inet.fi>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 08:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF2bQ-0004kb-AZ
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 08:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759700AbXG2GuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 29 Jul 2007 02:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759705AbXG2GuE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 02:50:04 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:54856 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759672AbXG2GuD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 02:50:03 -0400
X-Greylist: delayed 650 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jul 2007 02:50:03 EDT
Received: from [10.0.1.3] (GYKMMMCCXVII.dsl.saunalahti.fi [85.77.38.118])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 9DE7F13951B
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 09:39:09 +0300 (EEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54083>

MacBook doesn't seem to recognize MouseRelease-4 and -5 events, at all.
So i added a support for the MouseWheel event, which i limited to Tcl/t=
k
aqua, as i couldn't test it neither on Linux or Windows. Tcl/tk needs t=
o
be updated from the version that is shipped with OS X 10.4 Tiger, for
this patch to work.

Signed-off-by: V=E4in=F6 J=E4rvel=E4 <v@pp.inet.fi>
---
gitk |    6 ++++++
1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index f74ce51..985c30a 100755
--- a/gitk
+++ b/gitk
@@ -825,6 +825,12 @@ proc makewindow {} {
      #bindall <B1-Motion> {selcanvline %W %x %y}
      bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
      bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
+    if {[tk windowingsystem] eq "aqua"} {
+        bindall <MouseWheel> {
+                set delta [expr {- (%D)}]
+                allcanvs yview scroll $delta units
+        }
+    }
      bindall <2> "canvscan mark %W %x %y"
      bindall <B2-Motion> "canvscan dragto %W %x %y"
      bindkey <Home> selfirstline
--
1.5.2
