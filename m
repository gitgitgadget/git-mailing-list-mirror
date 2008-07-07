From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Avoid apache complaining about lack of server's FQDN
Date: Mon,  7 Jul 2008 22:22:15 +0200
Message-ID: <1215462135-3222-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 07 22:23:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFxF1-0008J8-KP
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 22:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbYGGUWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 16:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbYGGUWW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 16:22:22 -0400
Received: from vuizook.err.no ([194.24.252.247]:53846 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbYGGUWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 16:22:21 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KFxDx-0007WK-71; Mon, 07 Jul 2008 22:22:19 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KFxDz-0000qR-Q5; Mon, 07 Jul 2008 22:22:15 +0200
X-Mailer: git-send-email 1.5.6.GIT
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87649>

On some setups, apache will say:
apache2: Could not reliably determine the server's fully qualified
domain name, using $(IP_address) for ServerName

Avoid this message polluting tests output by setting a ServerName in
apache configuration.
---
 t/lib-httpd/apache.conf |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index a447346..4717c2d 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -1,3 +1,4 @@
+ServerName dummy
 PidFile httpd.pid
 DocumentRoot www
 ErrorLog error.log
-- 
1.5.6.GIT
