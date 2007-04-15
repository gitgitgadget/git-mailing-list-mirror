From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 02/02] ident.c: Use size_t (instead of int) to store sizes
Date: Sun, 15 Apr 2007 15:51:29 -0300
Organization: Mandriva
Message-ID: <20070415155129.162caa17@gnut>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 20:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd9p9-00055o-4w
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 20:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbXDOSvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 14:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbXDOSvk
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 14:51:40 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:47179 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbXDOSvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 14:51:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5169018AA6;
	Sun, 15 Apr 2007 15:51:36 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id VK9qh6k78Q8m; Sun, 15 Apr 2007 15:51:32 -0300 (BRT)
Received: from gnut (unknown [201.21.180.171])
	by perninha.conectiva.com.br (Postfix) with ESMTP id E9E2318A94;
	Sun, 15 Apr 2007 15:51:31 -0300 (BRT)
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44502>


Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 ident.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/ident.c b/ident.c
index 454aace..fa267ef 100644
--- a/ident.c
+++ b/ident.c
@@ -9,10 +9,10 @@
 
 static char git_default_date[50];
 
-static void copy_gecos(const struct passwd *w, char *name, int sz)
+static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 {
 	char *src, *dst;
-	int len, nlen;
+	size_t len, nlen;
 
 	nlen = strlen(w->pw_name);
 
@@ -49,7 +49,7 @@ static void copy_email(const struct passwd *pw)
 	 * Make up a fake email address
 	 * (name + '@' + hostname [+ '.' + domainname])
 	 */
-	int len = strlen(pw->pw_name);
+	size_t len = strlen(pw->pw_name);
 	if (len > sizeof(git_default_email)/2)
 		die("Your sysadmin must hate you!");
 	memcpy(git_default_email, pw->pw_name, len);
@@ -95,9 +95,9 @@ static void setup_ident(void)
 		datestamp(git_default_date, sizeof(git_default_date));
 }
 
-static int add_raw(char *buf, int size, int offset, const char *str)
+static int add_raw(char *buf, size_t size, int offset, const char *str)
 {
-	int len = strlen(str);
+	size_t len = strlen(str);
 	if (offset + len > size)
 		return size;
 	memcpy(buf + offset, str, len);
@@ -131,9 +131,9 @@ static int crud(unsigned char c)
  * Copy over a string to the destination, but avoid special
  * characters ('\n', '<' and '>') and remove crud at the end
  */
-static int copy(char *buf, int size, int offset, const char *src)
+static int copy(char *buf, size_t size, int offset, const char *src)
 {
-	int i, len;
+	size_t i, len;
 	unsigned char c;
 
 	/* Remove crud from the beginning.. */
-- 
1.5.1.1.86.gfd56-dirty
