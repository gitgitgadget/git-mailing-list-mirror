From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] post-receive-email hook: handle order of arguments consistently
Date: Thu, 14 Jun 2007 09:09:29 +0000
Message-ID: <20070614090929.31616.qmail@c76df6d65db410.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 428413@bugs.debian.org
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 11:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HylKQ-0001OX-6s
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 11:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbXFNJJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 05:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbXFNJJQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 05:09:16 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:49192 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751188AbXFNJJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 05:09:15 -0400
Received: (qmail 31617 invoked by uid 1000); 14 Jun 2007 09:09:29 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	428413@bugs.debian.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50184>

The post-receive-email hook usually gets its arguments through stdin, but
also supports them to be specified at the command line.  The order of the
arguments should consistently follow the documentation no matter how they
are passed to the script.

This was noticed and suggested by martin f krafft through
 http://bugs.debian.org/428413

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index c589a39..f84532f 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -605,7 +605,7 @@ envelopesender=$(git-repo-config hooks.envelopesender)
 if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 	# Output to the terminal in command line mode - if someone wanted to
 	# resend an email; they could redirect the output to sendmail themselves
-	PAGER= generate_email $2 $3 $1
+	PAGER= generate_email $1 $2 $3
 else
 	if [ -n "$envelopesender" ]; then
 		envelopesender="-f '$envelopesender'"
-- 
1.5.2.1
