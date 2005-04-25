From: Andreas Gal <gal@uci.edu>
Subject: [PATCH] Don't fail in http-pull if URL is missing a '/' at the end
Date: Mon, 25 Apr 2005 09:21:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504250917110.9176@sam.ics.uci.edu>
References: <3WtO4-5GW-5@gated-at.bofh.it> <3WtXG-5Nh-9@gated-at.bofh.it>
 <3WtXG-5Nh-7@gated-at.bofh.it> <3WwLT-848-13@gated-at.bofh.it>
 <3WxeV-5S-9@gated-at.bofh.it> <3WxHT-pv-1@gated-at.bofh.it>
 <3Wyb3-Sj-33@gated-at.bofh.it> <3WyDZ-1a6-7@gated-at.bofh.it>
 <3WYRN-5lJ-9@gated-at.bofh.it> <3X0gU-6u6-5@gated-at.bofh.it>
 <3X1G1-7ug-9@gated-at.bofh.it> <E1DQ5nn-0003au-QN@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Apr 25 18:24:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ6Le-0006ei-QL
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 18:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVDYQ0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 12:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVDYQZO
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 12:25:14 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:64183 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262647AbVDYQVR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 12:21:17 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3PGLFrR009191
	for <git@vger.kernel.org>; Mon, 25 Apr 2005 09:21:15 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3PGLFdC009187
	for <git@vger.kernel.org>; Mon, 25 Apr 2005 09:21:15 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <E1DQ5nn-0003au-QN@be1.7eggert.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


http-pull fails if the URL doesn't end with a '/'. This patch adds one if 
needed.

Signed-off-by: Andreas Gal <gal@uci.edu>

--- http-pull.c	2005-04-25 09:15:45.000000000 -0700
+++ /home/gal/src/git/git-bit/http-pull.c	2005-04-25 09:09:54.000000000 -0700
@@ -76,6 +76,8 @@
 	url = malloc(strlen(base) + 50);
 	strcpy(url, base);
 	posn = url + strlen(base);
+	if (posn[-1] != '/')
+		*posn++ = '/';
 	strcpy(posn, "objects/");
 	posn += 8;
 	memcpy(posn, hex, 2);

