From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] Re:gitweb: add readme to overview page
Date: Sun, 11 Nov 2012 17:40:39 +0100
Message-ID: <1352652039-31453-1-git-send-email-xypron.glpk@gmx.de>
References: <74707c20a5448989963314a02858c304017b02e3>
Cc: xypron.glpk@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 17:41:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaam-0005yB-FC
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab2KKQkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:40:51 -0500
Received: from mailout-eu.gmx.com ([213.165.64.43]:38640 "HELO
	mailout-eu.gmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751358Ab2KKQkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:40:51 -0500
Received: (qmail invoked by alias); 11 Nov 2012 16:40:49 -0000
Received: from xdsl-78-35-188-85.netcologne.de (EHLO family2.heinrich-schuchardt.de) [78.35.188.85]
  by mail.gmx.com (mp-eu003) with SMTP; 11 Nov 2012 17:40:49 +0100
X-Authenticated: #41704822
X-Provags-ID: V01U2FsdGVkX1/LYfkx5EjLkQ+Wo7uWyT0RmEJP6c1WKSjxLbUZHT
	nzztcJlvamc1Fq
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <74707c20a5448989963314a02858c304017b02e3>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209398>

In this version of the patch the formatting has been corrected.

Warnings for double / in filenames are avoided.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

---
 gitweb/gitweb.perl |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10ed9e5..699ffac 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6369,6 +6369,18 @@ sub git_project_list {
 	}
 
 	git_project_search_form($searchtext, $search_use_regexp);
+	# If XSS prevention is on, we don't include README.html.
+	# TODO: Allow a readme in some safe format.
+	my $path = "";
+	if (defined $project_filter) {
+		$path = "/$project_filter";
+	}
+	if (!$prevent_xss && -s "$projectroot$path/README.html") {
+		print "<div class=\"title\">readme</div>\n" .
+			"<div class=\"readme\">\n";
+		insert_file("$projectroot$path/README.html");
+		print "\n</div>\n"; # class="readme"
+	}
 	git_project_list_body(\@list, $order);
 	git_footer_html();
 }
-- 
1.7.10.4
