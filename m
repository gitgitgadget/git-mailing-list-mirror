From: apw@us.ibm.com (Amos Waterland)
Subject: [PATCH] wcwidth redeclaration
Date: Tue, 8 May 2007 00:46:08 -0400
Message-ID: <20070508044608.GA32223@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 06:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlHh9-0002Ra-QP
	for gcvg-git@gmane.org; Tue, 08 May 2007 06:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967753AbXEHEw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 00:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967776AbXEHEw7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 00:52:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:52633 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967753AbXEHEw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 00:52:58 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l484qwWq000814
	for <git@vger.kernel.org>; Tue, 8 May 2007 00:52:58 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l484qv93200272
	for <git@vger.kernel.org>; Mon, 7 May 2007 22:52:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l484qvM1023483
	for <git@vger.kernel.org>; Mon, 7 May 2007 22:52:57 -0600
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l484qvup023126;
	Mon, 7 May 2007 22:52:57 -0600
Received: by kvasir.watson.ibm.com (Postfix, from userid 1000)
	id 32AECB151F1; Tue,  8 May 2007 00:46:08 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46538>

Build fails for git 1.5.1.3 on AIX, with the message: 

utf8.c:66: error: conflicting types for 'wcwidth'
/.../lib/gcc/powerpc-ibm-aix5.3.0.0/4.0.3/include/string.h:266: error: previous declaration of 'wcwidth' was here

Here is a patch that fixes it for me.  If there is a different way that
is preferred, please let me know.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 utf8.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- utf8.c.orig	Tue May  8 00:40:18 2007
+++ utf8.c	Tue May  8 00:45:00 2007
@@ -62,7 +62,7 @@
  * in ISO 10646.
  */
 
-static int wcwidth(ucs_char_t ch)
+static int git_wcwidth(ucs_char_t ch)
 {
 	/*
 	 * Sorted list of non-overlapping intervals of non-spacing characters,
@@ -207,7 +207,7 @@
 		return 0;
 	}
 
-	return wcwidth(ch);
+	return git_wcwidth(ch);
 }
 
 int is_utf8(const char *text)
