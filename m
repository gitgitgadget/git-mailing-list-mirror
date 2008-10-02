Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 27453 invoked by uid 111); 2 Oct 2008 14:25:36 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 02 Oct 2008 10:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbYJBOZX (ORCPT <rfc822;peff@peff.net>);
	Thu, 2 Oct 2008 10:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYJBOZW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:25:22 -0400
Received: from [212.249.11.140] ([212.249.11.140]:29132 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753056AbYJBOZW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:25:22 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 946072AC954; Thu,  2 Oct 2008 16:25:05 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	Petr Baudis <petr.baudis@novartis.com>
Subject: [PATCH] gitweb: Identify all summary metadata table rows
Date:	Thu,  2 Oct 2008 16:25:05 +0200
Message-Id: <1222957505-5150-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the metadata table of the summary page, all rows have their
id (or class in case of URL) set now. This for example lets sites
easily disable fields they do not want to show in their custom
stylesheet (e.g. they are overly technical or irrelevant for the site).

Many of my other patches depend on this, so I would appreciate to hear
as soon as possible if someone has an issue with this patch.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---
 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index da474d0..bd8124a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4070,10 +4070,10 @@ sub git_summary {
 
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table class=\"projects_list\">\n" .
-	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
-	      "<tr><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
+	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
+	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
 	if (defined $cd{'rfc2822'}) {
-		print "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
 	}
 
 	# use per project git URL list in $projectroot/$project/cloneurl
@@ -4083,7 +4083,7 @@ sub git_summary {
 	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
 	foreach my $git_url (@url_list) {
 		next unless $git_url;
-		print "<tr><td>$url_tag</td><td>$git_url</td></tr>\n";
+		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
 		$url_tag = "";
 	}
 	print "</table>\n";
-- 
tg: (c427559..) t/summary/css-metadata (depends on: vanilla/master)
