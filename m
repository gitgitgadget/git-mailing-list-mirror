From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix show_date() for positive timezones
Date: Wed, 18 May 2005 17:11:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505181709150.20274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 23:14:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYVqZ-00084w-2g
	for gcvg-git@gmane.org; Wed, 18 May 2005 23:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVERVM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 17:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVERVM5
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 17:12:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27870 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262379AbVERVMm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 17:12:42 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGP0008PEUJ77@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 May 2005 17:11:07 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Nicolas Pitre <nico@cam.org>

--- a/date.c
+++ b/date.c
@@ -51,9 +51,9 @@ const char *show_date(unsigned long time
 	int minutes;
 
 	minutes = tz < 0 ? -tz : tz;
-	minutes = (tz / 100)*60 + (tz % 100);
+	minutes = (minutes / 100)*60 + (minutes % 100);
 	minutes = tz < 0 ? -minutes : minutes;
-	t = time - minutes * 60;
+	t = time + minutes * 60;
 	tm = gmtime(&t);
 	if (!tm)
 		return NULL;
