From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] fix the installation path for html documentation
Date: Tue, 10 Feb 2009 16:14:13 +0100
Message-ID: <1234278853-25452-1-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Sixt <j6t@kdbg.org>, Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 16:16:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWuKx-0002q8-G0
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 16:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbZBJPOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbZBJPOU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:14:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43490 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753452AbZBJPOU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 10:14:20 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 149F1290EF8;
	Tue, 10 Feb 2009 10:14:19 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 10 Feb 2009 10:14:19 -0500
X-Sasl-enc: jaXtaSg8yYcIL1+SZrAxkBH5au7YexUur61NqHmrN13z 1234278858
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 713512B89D;
	Tue, 10 Feb 2009 10:14:18 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109253>

Since 026fa0d5ad9538ca76838070861531c037d7b9ba (Move computation of
absolute paths from Makefile to runtime (in preparation for
RUNTIME_PREFIX) the installation of html doc was broken:
Documentation/Makefile does not know how to resolve relative dirs, which
results in html doc being installed in
$(git-build-root)/Documentation/share/doc/git-doc.

Fix this by not exporting htmldir from Makefile since this allows
Documentation/Makefile to compute htmldir from prefix.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
An alternative would be to teach Documentation/Makefile to take the
relative htmldir and make it into an absolute path. But the approach I'm
taking with this patch as analogous to how mandir is handled, with the
same draw back. But all is well as long as the build monkey messes with
prefix only.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 27b9569..862b96c 100644
--- a/Makefile
+++ b/Makefile
@@ -228,7 +228,7 @@ GITWEB_FAVICON = git-favicon.png
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
-export prefix bindir sharedir htmldir sysconfdir
+export prefix bindir sharedir sysconfdir
 
 CC = gcc
 AR = ar
-- 
1.6.1.2.253.ga34a
