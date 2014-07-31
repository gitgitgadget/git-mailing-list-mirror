From: Tony Finch <dot@dotat.at>
Subject: [PATCH 3/5] gitweb: add a link under the search box to clear a
 project filter
Date: Thu, 31 Jul 2014 13:53:45 +0100
Message-ID: <alpine.LSU.2.00.1407311353440.23775@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 14:53:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCprm-00077B-QZ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbaGaMxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:53:47 -0400
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:38932 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaGaMxr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:53:47 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:45695)
	by ppsw-41.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XCprd-0007Ta-Rr (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:45 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XCprd-0005k4-Gq (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:45 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254567>

Previously when a project filter was active, the only simple way
to clear it was by clicking the home link in the breadcrumbs, which
is not very obvious.

This change adds another home link under the search box which clears
both project filter and search, next to the existing link that
clears the search and keeps the project filter.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/gitweb.perl | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 12aba8f..d1e6b79 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5545,10 +5545,13 @@ sub git_project_search_form {
 	      "</span>\n" .
 	      $cgi->submit(-name => 'btnS', -value => 'Search') .
 	      $cgi->end_form() . "\n" .
-	      $cgi->a({-href => href(project => undef, searchtext => undef,
-	                             project_filter => $project_filter)},
-	              esc_html("List all projects$limit")) . "<br />\n";
-	print "</div>\n";
+	      $cgi->a({-href => $my_uri}, esc_html("List all projects"));
+	print " / " .
+	      $cgi->a({-href => href(project => undef, action => "project_list",
+				     project_filter => $project_filter)},
+	              esc_html("List projects$limit"))
+	    if $project_filter;
+	print "<br />\n</div>\n";
 }

 # entry for given @keys needs filling if at least one of keys in list
-- 
2.1.0.rc0.229.gaee38de
