From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] avoid gitweb uninitialized value warning
Date: Fri, 5 Sep 2008 14:26:29 -0400
Message-ID: <20080905182629.GA22030@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 20:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbgBN-0001Z0-VQ
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 20:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbYIESgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 14:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbYIESgL
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 14:36:11 -0400
Received: from wren.kitenet.net ([80.68.85.49]:38375 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbYIESgK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 14:36:10 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Sep 2008 14:36:10 EDT
Received: from kodama.kitenet.net (tn-76-5-154-10.dhcp.embarqhsd.net [76.5.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id C0753314322
	for <git@vger.kernel.org>; Fri,  5 Sep 2008 14:26:38 -0400 (EDT)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 85D60114086; Fri,  5 Sep 2008 14:26:29 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV version 0.93.3, clamav-milter version 0.93.3 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95028>

In the ususual case when there is no commit message, gitweb would
output an uninitialized value warning.

Signed-off-by: Joey Hess <joey@kitenet.net>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 29e2156..da474d0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2123,7 +2123,7 @@ sub parse_commit_text {
 			last;
 		}
 	}
-	if ($co{'title'} eq "") {
+	if (! defined $co{'title'} || $co{'title'} eq "") {
 		$co{'title'} = $co{'title_short'} = '(no commit message)';
 	}
 	# remove added spaces
-- 
1.5.6.5

-- 
see shy jo
