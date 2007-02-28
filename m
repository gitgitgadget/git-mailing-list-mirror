From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Memory overrun in http-push.c
Date: Wed, 28 Feb 2007 18:15:17 +0300
Message-ID: <20070228151516.GC57456@codelabs.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JYK4vJDZwFMowpUq"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 16:28:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQjN-0007gO-TO
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbXB1P2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbXB1P2e
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:28:34 -0500
Received: from pobox.codelabs.ru ([144.206.177.45]:51041 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbXB1P2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:28:34 -0500
X-Greylist: delayed 792 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Feb 2007 10:28:34 EST
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HMQWX-000Ez0-GF for git@vger.kernel.org; Wed, 28 Feb 2007 18:15:21 +0300
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=4.0 tests=ALL_TRUSTED,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40939>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Good day!

Spotted the memory overrun in the http-push.c. Exists at least in
1.5.0.x, not sure about latest development branch. The patch is
attached.
-- 
Eygene

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="http-push.c.patch"

--- http-push.c.orig	Wed Feb 28 15:15:01 2007
+++ http-push.c	Wed Feb 28 15:15:21 2007
@@ -1295,7 +1295,7 @@
 	sprintf(url, "%s%s", remote->url, path);
 
 	/* Make sure leading directories exist for the remote ref */
-	ep = strchr(url + strlen(remote->url) + 11, '/');
+	ep = strchr(url + strlen(remote->url) + 1, '/');
 	while (ep) {
 		*ep = 0;
 		slot = get_active_slot();

--JYK4vJDZwFMowpUq--
