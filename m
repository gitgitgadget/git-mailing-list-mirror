From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Do not automatically append " git" to custom site name
Date: Tue, 24 Oct 2006 05:18:39 +0200
Message-ID: <20061024031838.3323.14282.stgit@rover>
References: <20061011220621.GA4041@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 24 05:18:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcCoO-0004Z8-9f
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 05:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWJXDSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 23:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWJXDSl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 23:18:41 -0400
Received: from rover.dkm.cz ([62.24.64.27]:4254 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932392AbWJXDSk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 23:18:40 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 16B1A8BC3C;
	Tue, 24 Oct 2006 05:18:39 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061011220621.GA4041@coredump.intra.peff.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29916>

If you customized the site name, you probably do not want the " git"
appended so that the page title is not bastardized; I want repo.or.cz pages
titled "Public Git Hosting", not "Public Git Hosting git" (what's hosting
what?).

This slightly changes the $site_name semantics but only very
insignificantly.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e77fc11..1e80f43 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -39,7 +39,8 @@ our $home_link_str = "++GITWEB_HOME_LINK
 
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
-our $site_name = "++GITWEB_SITENAME++" || $ENV{'SERVER_NAME'} || "Untitled";
+our $site_name = "++GITWEB_SITENAME++"
+                 || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";
 
 # filename of html text to include at top of each page
 our $site_header = "++GITWEB_SITE_HEADER++";
@@ -1433,7 +1434,7 @@ sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
 
-	my $title = "$site_name git";
+	my $title = "$site_name";
 	if (defined $project) {
 		$title .= " - $project";
 		if (defined $action) {
@@ -3847,7 +3848,7 @@ sub git_opml {
 <?xml version="1.0" encoding="utf-8"?>
 <opml version="1.0">
 <head>
-  <title>$site_name Git OPML Export</title>
+  <title>$site_name OPML Export</title>
 </head>
 <body>
 <outline text="git RSS feeds">
