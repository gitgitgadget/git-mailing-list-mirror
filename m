From: Erik van Konijnenburg <ekonijn@xs4all.nl>
Subject: [PATCH] link in gitweb rss feed
Date: Wed, 15 Jun 2005 17:41:48 +0200
Message-ID: <20050615174148.C3099@banaan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 17:37:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiZwf-0006ou-5m
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 17:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVFOPlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 11:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFOPlv
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 11:41:51 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:15120 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S261181AbVFOPlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 11:41:49 -0400
Received: from banaan.xs4all.nl (banaan.xs4all.nl [80.126.2.237])
	by smtp-vbr10.xs4all.nl (8.13.3/8.13.3) with ESMTP id j5FFfmks062681;
	Wed, 15 Jun 2005 17:41:48 +0200 (CEST)
	(envelope-from konijn@banaan.xs4all.nl)
Received: (from konijn@localhost)
	by banaan.xs4all.nl (8.11.6/8.11.6) id j5FFfm403837;
	Wed, 15 Jun 2005 17:41:48 +0200
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The following patch makes the site name in an RSS
feedreader for a gitweb project refer to the summary
page for the the project, the same place where you picked
up the feed in the first place.  This seems more consistent
than linking to the overview of all projects where the
link used to up.  Changed the link in OPML feed accordingly;
this used to end up in the full log rather than the summary.

Patch was made against version 220 as shipped in Debian,
and applies (with offset) to your version 221.

Regards,
Erik

--- gitorg.cgi	2005-06-15 17:11:51.000000000 +0200
+++ gitweb.cgi	2005-06-15 17:16:42.000000000 +0200
@@ -1227,7 +1227,7 @@
 	      "<rss version=\"2.0\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\">\n";
 	print "<channel>\n";
 	print "<title>$project</title>\n".
-	      "<link>" . escapeHTML("$my_url/$project/log") . "</link>\n".
+	      "<link>" . escapeHTML("$my_url?p=$project;a=summary") . "</link>\n".
 	      "<description>$project log</description>\n".
 	      "<language>en</language>\n";
 
@@ -1280,7 +1280,7 @@
 
 		my $path = escapeHTML(chop_str($proj{'path'}, 25, 5));
 		my $rss =  "$my_url?p=$proj{'path'};a=rss";
-		my $html =  "$my_url?p=$proj{'path'};a=log";
+		my $html =  "$my_url?p=$proj{'path'};a=summary";
 		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
 	}
 	print "</outline>\n".
