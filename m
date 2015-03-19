From: Tony Finch <dot@dotat.at>
Subject: [PATCH 3/5] gitweb: add a link under the search box to clear a
 project filter
Date: Thu, 19 Mar 2015 15:40:10 +0000
Message-ID: <alpine.LSU.2.00.1503191540090.23307@hermes-1.csi.cam.ac.uk>
References: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 16:50:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYchy-0001E6-B5
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 16:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbbCSPt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 11:49:56 -0400
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:48651 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbCSPty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 11:49:54 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:38233)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1YYcYM-0004Ib-ZG (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:40:10 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1YYcYM-0007xp-SN (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:40:10 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265809>

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
index 073f324..9abc5bc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5549,10 +5549,13 @@ sub git_project_search_form {
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
2.2.1.68.g56d9796
