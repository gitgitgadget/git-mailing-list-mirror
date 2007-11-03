From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-cvsimport: really convert underscores in branch names to dots with -u
Date: Sat, 3 Nov 2007 11:55:02 +0000
Message-ID: <20071103115502.14532.qmail@d121e5a37ec172.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 12:55:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHaf-0000yN-Q3
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbXKCLym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbXKCLym
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:54:42 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:49494 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752279AbXKCLym (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:54:42 -0400
Received: (qmail 14533 invoked by uid 1000); 3 Nov 2007 11:55:02 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63239>

The documentation states for the -u option that underscores in tag and
branch names are converted to dots, but this was actually implemented
for the tag names only.

Kurt Roeckx reported this through
 http://bugs.debian.org/446495

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-cvsimport.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 2954fb8..e4bc2b5 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -818,6 +818,7 @@ while (<CVS>) {
 		$state = 4;
 	} elsif ($state == 4 and s/^Branch:\s+//) {
 		s/\s+$//;
+		tr/_/\./ if ( $opt_u );
 		s/[\/]/$opt_s/g;
 		$branch = $_;
 		$state = 5;
-- 
1.5.3.5
