From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] pack-protocol: fix first-want separator in the examples
Date: Sat, 12 May 2012 01:44:53 +0200
Message-ID: <1336779893-23636-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 01:52:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSzda-0002ow-GS
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 01:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761319Ab2EKXwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 May 2012 19:52:33 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:59728 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761157Ab2EKXw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 19:52:29 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 May 2012 19:52:29 EDT
Received: from centaur.lab.cmartin.tk (brln-4d0c2fce.pool.mediaWays.net [77.12.47.206])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 07C5446051
	for <git@vger.kernel.org>; Sat, 12 May 2012 01:44:39 +0200 (CEST)
Received: (nullmailer pid 23671 invoked by uid 1000);
	Fri, 11 May 2012 23:44:53 -0000
X-Mailer: git-send-email 1.7.10.2.1.g8c77c3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197707>

When sending the "want" list, the capabilities list is separated from
the obj-id by a SP instead of NUL as in the ref advertisement. The
text is correct, but the examples wrongly show the separator as
NUL. Fix the example so it uses SP.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

Just after this, in the push section, it separates by NUL
again. Running git-receive-pack locally looks like it's actually NUL
SP, but I'm guessing that the SP comes from a printf that doesn't take
being first into account, so I left it alone.

Why no, I didn't just spend way too long trying to figure out why the
git server wasn't reacting to my capabilites list, why do you ask?

 Documentation/technical/pack-protocol.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index 546980c..49cdc57 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -351,7 +351,7 @@ Then the server will start sending its packfile dat=
a.
 A simple clone may look like this (with no 'have' lines):
=20
 ----
-   C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d\0multi_ack \
+   C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d multi_ack \
      side-band-64k ofs-delta\n
    C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
    C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
@@ -367,7 +367,7 @@ A simple clone may look like this (with no 'have' l=
ines):
 An incremental update (fetch) response might look like this:
=20
 ----
-   C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d\0multi_ack \
+   C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d multi_ack \
      side-band-64k ofs-delta\n
    C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
    C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
--=20
1.7.10
