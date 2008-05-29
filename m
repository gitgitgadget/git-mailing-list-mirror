From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] gitweb: fix "next" link on bottom of commit log page
Date: Thu, 29 May 2008 18:10:03 +0000
Message-ID: <20080529181003.1249.qmail@b35f4f9e60eb05.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 20:10:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1maY-0000ya-AL
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 20:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbYE2SKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 14:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbYE2SKG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 14:10:06 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:42488 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752839AbYE2SKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 14:10:05 -0400
Received: (qmail 1250 invoked by uid 1000); 29 May 2008 18:10:03 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83229>

When viewing a gitweb repository commit log, the "next" link at the top
of the page works as expected, the "next" link on the bottom of the page
has a=search instead of a=log and thus fails to get you to the next
page.  This commit replaces the bottom "next" link with the same links
as shown at the top of the page.

The bad link was reported by Kai Blin through
 http://bugs.debian.org/481902

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 gitweb/gitweb.perl |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57a1905..f7b9ac2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4703,12 +4703,7 @@ sub git_log {
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
 		print "</div>\n";
 	}
-	if ($#commitlist >= 100) {
-		print "<div class=\"page_nav\">\n";
-		print $cgi->a({-href => href(-replay=>1, page=>$page+1),
-			       -accesskey => "n", -title => "Alt-n"}, "next");
-		print "</div>\n";
-	}
+	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
 	git_footer_html();
 }
 
-- 
1.5.5.2
