From: Richard Braun <rbraun@sceen.net>
Subject: [PATCH] gitweb: fix link to parent diff with pathinfo
Date: Fri,  6 May 2016 12:19:38 +0200
Message-ID: <1462529978-31322-1-git-send-email-rbraun@sceen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 12:27:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayczG-0003i7-6l
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 12:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979AbcEFK1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 06:27:54 -0400
Received: from shattrath.sceen.net ([151.80.19.218]:34024 "EHLO mail.sceen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750AbcEFK1x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 06:27:53 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 May 2016 06:27:53 EDT
Received: by mail.sceen.net (Postfix, from userid 1000)
	id 0B7B04034E; Fri,  6 May 2016 12:19:38 +0200 (CEST)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293757>

Signed-off-by: Richard Braun <rbraun@sceen.net>
---
 gitweb/gitweb.perl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05d7910..f7f7936 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1423,7 +1423,12 @@ sub href {
 			delete $params{'hash'};
 			delete $params{'hash_base'};
 		} elsif (defined $params{'hash'}) {
-			$href .= esc_path_info($params{'hash'});
+			if (defined $params{'hash_parent'}) {
+				$href .= esc_path_info($params{'hash_parent'});
+				delete $params{'hash_parent'};
+			} else {
+				$href .= esc_path_info($params{'hash'});
+			}
 			delete $params{'hash'};
 		}
 
-- 
2.1.4
