From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Put project README in div.readme, fix its padding
Date: Mon, 19 Nov 2007 14:16:12 +0100
Message-ID: <1195478172-17226-3-git-send-email-jnareb@gmail.com>
References: <1195478172-17226-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 14:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6Ux-00074K-Tz
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbXKSNQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbXKSNQz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:16:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:50007 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbXKSNQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:16:54 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1406693nfb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 05:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2+iYNvW6IMOOQysb6v1rYuGfaNPXz52ZU0vM7LZ7Mrg=;
        b=dfiMZiEr1ZrGrwO5UieRvqMNcXWYswSZEPgKdbA7/rZhvAMH9u/BWuaYCapj+9Vicg32oxM4FhOPeQiRGalnwF1JHMFiIdmQvzYuSpcr70hOS13vkuEdSMOyKGq5ZGQ8XtCmR71ByuQreVCvtyU+OZNRbsmNZyGr0INQdCnlfFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KSJBtdVjVj7Tjnl306HXJxinTFaneVdbs8ZiZZR6BLINjpRWvs7Rns5f1gwJHlm4GzwgM7LkrfOSj6N1dVd+JOjB/f0VLRY0a2vnmHXjYRpFmr0WIX9se3j0unUUg6cZ4+2RRZU3oI26GTq4ISeZh32XduTpfyL2jiTFOHNTkAI=
Received: by 10.86.60.7 with SMTP id i7mr5065491fga.1195478213465;
        Mon, 19 Nov 2007 05:16:53 -0800 (PST)
Received: from roke.D-201 ( [83.8.241.246])
        by mx.google.com with ESMTPS id 31sm8802213fkt.2007.11.19.05.16.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Nov 2007 05:16:52 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lAJDGopQ017270;
	Mon, 19 Nov 2007 14:16:50 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lAJDGa1c017268;
	Mon, 19 Nov 2007 14:16:36 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1195478172-17226-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65439>

Put (optional) projects README on "summary" page in <div> element
using "readme" class.  This allow to style it using CSS.

Add padding to project's README to make it line out with the rest
of the page.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 17c60e4..446a1c3 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -85,6 +85,10 @@ div.title, a.title {
 	color: #000000;
 }
 
+div.readme {
+	padding: 8px;
+}
+
 a.title:hover {
 	background-color: #d9d8d1;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d532dc..491a3f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3912,8 +3912,10 @@ sub git_summary {
 
 	if (-s "$projectroot/$project/README.html") {
 		if (open my $fd, "$projectroot/$project/README.html") {
-			print "<div class=\"title\">readme</div>\n";
+			print "<div class=\"title\">readme</div>\n" .
+			      "<div class=\"readme\">\n";
 			print $_ while (<$fd>);
+			print "\n</div>\n"; # class="readme"
 			close $fd;
 		}
 	}
-- 
1.5.3.5
