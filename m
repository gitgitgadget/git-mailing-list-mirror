From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: check if HTTP_ACCEPT is really set
Date: Sun, 6 Aug 2006 15:55:02 +0200
Message-ID: <20060806135502.GA13840@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 06 15:55:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9j66-0003Cj-JJ
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 15:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWHFNzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 09:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWHFNzG
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 09:55:06 -0400
Received: from moooo.ath.cx ([85.116.203.178]:60894 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751128AbWHFNzF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 09:55:05 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24977>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
If the client does not send Accept: HTTP_ACCEPT is undefined and there
is a warning:
Use of uninitialized value in pattern match (m//) at line 862.
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f85dc7d..1f4b0f5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -859,7 +859,7 @@ sub git_header_html {
 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
 	# we have to do this because MSIE sometimes globs '*/*', pretending to
 	# support xhtml+xml but choking when it gets what it asked for.
-	if ($cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ && $cgi->Accept('application/xhtml+xml') != 0) {
+	if (defined $cgi->http('HTTP_ACCEPT') && $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ && $cgi->Accept('application/xhtml+xml') != 0) {
 		$content_type = 'application/xhtml+xml';
 	} else {
 		$content_type = 'text/html';
-- 
1.4.2.rc3.g2f52
