From: Thomas Schwinge <thomas@schwinge.name>
Subject: [PATCH] README: Sketch out what tg rename OLD NEW would do.
Date: Sat, 27 Feb 2010 23:39:49 +0100
Message-ID: <1267310389-11984-1-git-send-email-thomas@schwinge.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Schwinge <thomas@schwinge.name>
To: u.kleine-koenig@pengutronix.de
X-From: git-owner@vger.kernel.org Sat Feb 27 23:40:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlVKr-0004AX-P8
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 23:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936354Ab0B0WkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 17:40:14 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:34124 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936345Ab0B0WkN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 17:40:13 -0500
Received: from [79.210.78.144] (helo=stokes.schwinge.homeip.net)
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <thomas@dirichlet.schwinge.homeip.net>)
	id 1NlVKV-00033R-Mi
	for git@vger.kernel.org; Sat, 27 Feb 2010 23:40:11 +0100
Received: (qmail 23694 invoked from network); 27 Feb 2010 22:39:49 -0000
Received: from dslb-084-057-191-223.pools.arcor-ip.net (84.57.191.223)
  by stokes.schwinge.homeip.net with QMQP; 27 Feb 2010 22:39:49 -0000
Received: (nullmailer pid 12007 invoked by uid 1000);
	Sat, 27 Feb 2010 22:39:49 -0000
X-Mailer: git-send-email 1.6.0.4
X-Df-Sender: thomas@schwinge.name
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141236>

=2E.. as proposed by me and acknowledged by David Bremner and Uwe Klein=
e-K=C3=B6nig on
2010-01-27 in #topgit (freenode).
---
 README |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/README b/README
index 495c70b..eab6fcd 100644
--- a/README
+++ b/README
@@ -486,7 +486,22 @@ tg push
 	repository.  By default the remote gets all dependencies
 	(both tgish and non-tgish) and bases pushed to.
=20
-TODO: tg rename
+tg rename
+~~~~~~~~~
+	There is no such command yet, but here's a receipe what ``tg rename O=
LD
+	NEW'' would do:
+
+	  - Have a clean state before beginning.
+	  - git banch -r OLD NEW
+	  - git update-ref refs/top-bases/NEW refs/top-bases/OLD ''
+	  - for BRANCH in (all branches that depend on OLD,
+			   i.e. reference OLD in .topdeps); do
+	      git checkout BRANCH
+	      sed -i 's%^OLD$%NEW$' .topdeps
+	      git commit -m 'OLD -> NEW' .topdeps
+	    done
+	  - tg summary
+	  - tg update as appropriate
=20
=20
 IMPLEMENTATION
--=20
1.6.0.4
