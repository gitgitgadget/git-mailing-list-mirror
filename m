From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix error in git_project_index subroutine
Date: Wed,  3 Jan 2007 16:03:01 +0100
Message-ID: <1167836581326-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 03 16:00:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H27ay-0005eA-SZ
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 16:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbXACO76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 09:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbXACO75
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 09:59:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:47548 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbXACO75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 09:59:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5190692uga
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 06:59:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=lHaAwRaaXQpBnCpYiIY6LAMgaQa7csFWefrisvns/6qFPhrIZbC2uwRXjc198pWh20A6oYJuTrnhC3doISx/siapnMiqe8xnk8QMoABJngmCnlcMXb+bDLSdzfjHZgRrcS6Ra9vTub4BUPO4cvkDcs802BNzDqNGFwyaLEh4eTY=
Received: by 10.66.221.6 with SMTP id t6mr27096671ugg.1167836395200;
        Wed, 03 Jan 2007 06:59:55 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.195])
        by mx.google.com with ESMTP id 72sm27322757ugb.2007.01.03.06.59.54;
        Wed, 03 Jan 2007 06:59:54 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l03F32Kn005384;
	Wed, 3 Jan 2007 16:03:03 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l03F329c005383;
	Wed, 3 Jan 2007 16:03:02 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35871>

Instead of "$projectroot/$pr->{'path'}" to get the path to project
GIT_DIR, it was used "$projectroot/$project" which is valid only
for actions where project parameter is set, and 'project_index' is not
one of them.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d845e91..7f54834 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2995,7 +2995,7 @@ sub git_project_index {
 
 	foreach my $pr (@projects) {
 		if (!exists $pr->{'owner'}) {
-			$pr->{'owner'} = get_file_owner("$projectroot/$project");
+			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}");
 		}
 
 		my ($path, $owner) = ($pr->{'path'}, $pr->{'owner'});
-- 
1.4.4.3
