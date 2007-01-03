From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: There can be empty patches (in git_patchset_body)
Date: Wed,  3 Jan 2007 20:47:25 +0100
Message-ID: <11678536473286-git-send-email-jnareb@gmail.com>
References: <11678536452473-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 03 20:44:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2C2J-0003HW-9u
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 20:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbXACToY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 14:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbXACToY
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 14:44:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:48135 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbXACToY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 14:44:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5256587uga
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 11:44:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YQrRS/BlQr4B3dZ4x8GseTcsRG9vOyZfvqHNHRjyaSAOGRnk5vxF52702LLyMBrn9/5TB+NehrE2UBheFUbEhuWVNRw4xN6mkgGFid8K7k29w10r0Z6hTYcqRiBVCZ+xvRSXPthf6vhmsIs9doyIBfU1B9bE0SbYSBQfTtTHE0M=
Received: by 10.67.20.3 with SMTP id x3mr15666022ugi.1167853463080;
        Wed, 03 Jan 2007 11:44:23 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.195])
        by mx.google.com with ESMTP id q1sm32791171uge.2007.01.03.11.44.22;
        Wed, 03 Jan 2007 11:44:22 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l03JlRgC016404;
	Wed, 3 Jan 2007 20:47:27 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l03JlRJh016403;
	Wed, 3 Jan 2007 20:47:27 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <11678536452473-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35883>

We now do not skip over empty patches in git_patchset_body
(where empty means that they consist only of git diff header,
and of extended diff header), so uncomment branch of code dealing
with empty patches (patches which do not have even two-line
from/to header)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05b3876..2ead917 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2527,7 +2527,7 @@ sub git_patchset_body {
 		print "<div class=\"diff from_file\">$patch_line</div>\n";
 
 		$patch_line = <$fd>;
-		#last PATCH unless $patch_line;
+		last PATCH unless $patch_line;
 		chomp $patch_line;
 
 		#assert($patch_line =~ m/^+++/) if DEBUG;
-- 
1.4.4.3
