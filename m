From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] GUI: Add a progressbar to visualize the time that is left
Date: Wed, 1 Oct 2008 23:09:01 +0200
Message-ID: <20081001210901.GA5731@atjola.homenet>
References: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 23:10:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl8xd-00073M-TO
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 23:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbYJAVJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 17:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754053AbYJAVJG
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 17:09:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:41493 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754009AbYJAVJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 17:09:04 -0400
Received: (qmail invoked by alias); 01 Oct 2008 21:09:02 -0000
Received: from i577BAFAB.versanet.de (EHLO atjola.local) [87.123.175.171]
  by mail.gmx.net (mp020) with SMTP; 01 Oct 2008 23:09:02 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/zc6M3JTbzT+GY9YM8I8hxW5aNsAT9giqd+EI99D
	WVbzhxGVUSAms1
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97270>

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
OK, this bar doesn't fill up as you requested, but instead gets empty,
that's just how I feel it should be ;-)

Might require Tcl/Tk 8.5...

 tracker-ui.tcl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/tracker-ui.tcl b/tracker-ui.tcl
index 16d00d7..5314c57 100755
--- a/tracker-ui.tcl
+++ b/tracker-ui.tcl
@@ -8,6 +8,7 @@ proc every {ms body} {
 set user $env(USER)
=20
 pack [label .tracker -textvariable time]
+pack [ttk::progressbar .bar]
=20
 every 1000 {
 	global user
@@ -17,4 +18,9 @@ every 1000 {
 	gets $f l3
 	close $f
 	set ::time "$l3"
+	set times [split "$l1" " "]
+	set max [lindex $times 0]
+	set cur [lindex $times 1]
+	set left [expr $max - $cur]
+	.bar configure -max $max -value $left
 }
--=20
1.6.0.2.307.gc427
