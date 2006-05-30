From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: t0001: workaround a heredoc bug in old versions of dash
Date: Mon, 29 May 2006 19:03:45 -0700
Message-ID: <11489546262736-git-send-email-normalperson@yhbt.net>
References: <20060529063543.GA8128@localdomain>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 30 04:03:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FktaP-00070A-Hz
	for gcvg-git@gmane.org; Tue, 30 May 2006 04:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWE3CDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 22:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWE3CDr
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 22:03:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:21940 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750771AbWE3CDr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 22:03:47 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 75CE67DC020; Mon, 29 May 2006 19:03:46 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <20060529063543.GA8128@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21006>

The dash installed on my Debian Sarge boxes don't seem to like
<<'' as a heredoc starter.  Recent versions of dash do not need
this fix.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/t/t0001-contrib-git-svn-props.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

edbca3e1b96747330a4b1459e914b07105b3bc44
diff --git a/contrib/git-svn/t/t0001-contrib-git-svn-props.sh b/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
index 6fa7889..23a5a2a 100644
--- a/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
+++ b/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
@@ -20,9 +20,10 @@ a_empty_cr=
 a_empty_crlf=
 
 cd import
-	cat >> kw.c <<''
+	cat >> kw.c <<\EOF
 /* Make it look like somebody copied a file from CVS into SVN: */
 /* $Id: kw.c,v 1.1.1.1 1994/03/06 00:00:00 eric Exp $ */
+EOF
 
 	printf "Hello\r\nWorld\r\n" > crlf
 	a_crlf=`git-hash-object -w crlf`
-- 
1.3.2.g7d11
