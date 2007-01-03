From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Fix bug in git_difftree_body (was '!=' instead of 'ne')
Date: Wed,  3 Jan 2007 20:47:24 +0100
Message-ID: <11678536452473-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 03 20:44:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2C2B-0003F6-Jy
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 20:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbXACToU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbXACToU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 14:44:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:48135 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbXACToT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 14:44:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5256587uga
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 11:44:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=daUjFj2XGE6Wy3wPrP/GBF7V5Qz8nBnURWUKGtpSJAksgGqr/8lFL1n2wXRpjQfYAzBu2jJf7jgqQ+gd7CqUyURWZFyiQJfdVFzZGbInATqOzdaDlzkox3sRzzfNf4AECcD/mmhWaizpuyPBg+lAK8nL2u5irCMrWO+eTUppPw0=
Received: by 10.66.232.9 with SMTP id e9mr27362452ugh.1167853457943;
        Wed, 03 Jan 2007 11:44:17 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.195])
        by mx.google.com with ESMTP id m1sm32775415uge.2007.01.03.11.44.17;
        Wed, 03 Jan 2007 11:44:17 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l03JlQw8016400;
	Wed, 3 Jan 2007 20:47:26 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l03JlP1f016399;
	Wed, 3 Jan 2007 20:47:25 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35882>

Fix bug in git_difftree_body subroutine; it was used '!=' comparison
operator for strings (file type) instead of correct 'ne'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7f54834..05b3876 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2274,7 +2274,7 @@ sub git_difftree_body {
 			my $mode_chnge = "";
 			if ($diff{'from_mode'} != $diff{'to_mode'}) {
 				$mode_chnge = "<span class=\"file_status mode_chnge\">[changed";
-				if ($from_file_type != $to_file_type) {
+				if ($from_file_type ne $to_file_type) {
 					$mode_chnge .= " from $from_file_type to $to_file_type";
 				}
 				if (($from_mode_oct & 0777) != ($to_mode_oct & 0777)) {
-- 
1.4.4.3
