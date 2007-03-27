From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add padding to project's README on "summary" page
Date: Wed, 28 Mar 2007 01:20:27 +0200
Message-ID: <11750376272105-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 01:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWKv6-00037m-Ce
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318AbXC0XR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933364AbXC0XR1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:17:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:24116 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933318AbXC0XR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:17:26 -0400
Received: by ug-out-1314.google.com with SMTP id 44so43464uga
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 16:17:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=OKN+x2xoPDhe9ZHuN5skx4WhdzKKm5BG6bIu93QfULX2NHkAANmFuQhxSmNoDgJS/pV/RbYKRD7+CyzjQlI+PVsBGyACut4PDdGKyGyqy6I+XMR8bM8lQJKjggaE93IYRuYuFEZRIJNoNWbOpdI7pOFWMZGElYdxZba9lMlG+CY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=TbWMgEL0rB6t90Qi0YEzVEWCzX+8VjdPRkgHAzFl1X2GH1meI4jzB/YwnjGJTCGiM5zf+rkmj7gE6/GYXsiWXWNdTjQWbN5i+iTp+OyTDFv5ITaNr2erweOw6flFjB4mzJ6w2xQl09u6/17vSmQMsvGdOLDCb2yiTCnnNlHuMvg=
Received: by 10.67.98.9 with SMTP id a9mr126571ugm.1175037444818;
        Tue, 27 Mar 2007 16:17:24 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id w5sm26399414mue.2007.03.27.16.17.21;
        Tue, 27 Mar 2007 16:17:23 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l2RNKTMl012542;
	Wed, 28 Mar 2007 01:20:29 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l2RNKROu012540;
	Wed, 28 Mar 2007 01:20:27 +0200
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43318>

Add padding to (optional) project's README on "summary" page (taken
from README.html in project's GIT_DIR), to make it line out with the
rest of the page.

It is done by adding a wrapper div element around README contents,
with "readme" class, and CSS rule for div.readme; it fixes layout,
but probably should be refactored during gitweb CSS cleanup.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 5e40292..cbe8c11 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -76,6 +76,10 @@ div.page_body {
 	font-family: monospace;
 }
 
+div.readme {
+	padding: 8px;
+}
+
 div.title, a.title {
 	display: block;
 	padding: 6px 8px;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3786955..4f34c29 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3063,7 +3063,9 @@ sub git_summary {
 	if (-s "$projectroot/$project/README.html") {
 		if (open my $fd, "$projectroot/$project/README.html") {
 			print "<div class=\"title\">readme</div>\n";
+			print "<div class=\"readme\">\n";
 			print $_ while (<$fd>);
+			print "</div>\n"; # class="readme"
 			close $fd;
 		}
 	}
-- 
1.5.0.5
