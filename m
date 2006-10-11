From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Do not automatically append " git" to custom site name
Date: Wed, 11 Oct 2006 22:22:28 +0200
Message-ID: <20061011202228.27279.97423.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 11 22:22:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXkb4-0001h2-BP
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 22:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbWJKUWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 16:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWJKUWa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 16:22:30 -0400
Received: from rover.dkm.cz ([62.24.64.27]:19853 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1161234AbWJKUW3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 16:22:29 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id A88B18BBD8;
	Wed, 11 Oct 2006 22:22:28 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28742>

If you customized the site name, you probably do not want the " git"
appended so that the page title is not bastardized; I want repo.or.cz pages
titled "Public Git Hosting", not "Public Git Hosting git" (what's hosting
what?).

This slightly changes the $site_name semantics but only very
insignificantly.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c2dfdab..d165fdc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -39,7 +39,7 @@ our $home_link_str = "++GITWEB_HOME_LINK
 
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
-our $site_name = "++GITWEB_SITENAME++" || $ENV{'SERVER_NAME'} || "Untitled";
+our $site_name = "++GITWEB_SITENAME++" || "$ENV{'SERVER_NAME'} Git" || "Untitled Git";
 
 # filename of html text to include at top of each page
 our $site_header = "++GITWEB_SITE_HEADER++";
@@ -1455,7 +1455,7 @@ sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
 
-	my $title = "$site_name git";
+	my $title = "$site_name";
 	if (defined $project) {
 		$title .= " - $project";
 		if (defined $action) {
@@ -3842,7 +3842,7 @@ sub git_opml {
 <?xml version="1.0" encoding="utf-8"?>
 <opml version="1.0">
 <head>
-  <title>$site_name Git OPML Export</title>
+  <title>$site_name OPML Export</title>
 </head>
 <body>
 <outline text="git RSS feeds">
