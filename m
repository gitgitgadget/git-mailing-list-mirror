From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] gitweb: show no difference message
Date: Sun, 25 Mar 2007 22:34:17 +0200
Message-ID: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZQ4-0003Ft-MQ
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbXCYUeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbXCYUeY
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:34:24 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60099 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbXCYUeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:34:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 8A107735D74C;
	Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdEzx0HJTtiE; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 4E3E7735D743; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43063>

Currently, gitweb shows only header and footer, if no differences are
found. This patch adds a "No differences are found" message for the html
output.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5214050..fbadab4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2376,6 +2376,7 @@ sub git_patchset_body {
 
 	my $patch_idx = 0;
 	my $patch_line;
+	my $empty = 0;
 	my $diffinfo;
 	my (%from, %to);
 
@@ -2396,6 +2397,7 @@ sub git_patchset_body {
 		# git diff header
 		#assert($patch_line =~ m/^diff /) if DEBUG;
 		#assert($patch_line !~ m!$/$!) if DEBUG; # is chomp-ed
+		$empty++;
 		push @diff_header, $patch_line;
 
 		# extended diff header
@@ -2559,6 +2561,8 @@ sub git_patchset_body {
 		print "</div>\n"; # class="patch"
 	}
 
+	print "<div class=\"diff header\">No differences found</div>\n" if (!$empty);
+
 	print "</div>\n"; # class="patchset"
 }
 
-- 
1.5.1.rc1.51.gb08b-dirty
