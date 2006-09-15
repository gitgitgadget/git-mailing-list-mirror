From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Add link to "project_index" view to "project_list" page
Date: Fri, 15 Sep 2006 04:59:27 +0200
Message-ID: <200609150459.27708.jnareb@gmail.com>
References: <200609150453.42231.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 04:59:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO3vk-0007mF-II
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 04:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWIOC7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 22:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWIOC7R
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 22:59:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:28540 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751470AbWIOC7P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 22:59:15 -0400
Received: by ug-out-1314.google.com with SMTP id o38so121425ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 19:59:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S1vavpdEbLd6LU3Ngv5J7ERd3BXBWqPaBaFxDA7wCKw8UteVh+6aNvTf4bLHJnno1DN482rLJM8hIgNj26fatfkabhkQYGtpnTDnB0Q8o3E7CQKqpPSyuxePLzyGtC43AIbZ7/DTaopI1WYNXEBQfjLhEdb593kOZAEZ21s0isk=
Received: by 10.66.220.17 with SMTP id s17mr5197924ugg;
        Thu, 14 Sep 2006 19:59:14 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id b23sm1017606ugd.2006.09.14.19.59.14;
        Thu, 14 Sep 2006 19:59:14 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609150453.42231.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27057>

Add link to "project_index" view as [TXT] beside link to "opml" view,
(which is marked by [OPML]) to "project_list" page.

While at it add alternate links for "opml" and "project_list" to HTML
header for "project_list" view.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
In the future we might want to change appereance of [TXT] link
to "project_index" view (e.g. green background instead of orange,
smaller width).

 gitweb/gitweb.perl |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e900713..1f26365 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1255,6 +1255,13 @@ EOF
 		printf('<link rel="alternate" title="%s log" '.
 		       'href="%s" type="application/rss+xml"/>'."\n",
 		       esc_param($project), href(action=>"rss"));
+	} else {
+		printf('<link rel="alternate" title="%s" '.
+		       'href="%s" type="text/plain; charset=utf-8"/>'."\n",
+		       esc_param($project), href(project=>undef, action=>"project_index"));
+		printf('<link rel="alternate" title="%s" '.
+		       'href="%s" type="text/x-opml"/>'."\n",
+		       esc_param($project), href(project=>undef, action=>"opml"));
 	}
 	if (defined $favicon) {
 		print qq(<link rel="shortcut icon" href="$favicon" type="image/png"/>\n);
@@ -1309,7 +1316,9 @@ sub git_footer_html {
 		              -class => "rss_logo"}, "RSS") . "\n";
 	} else {
 		print $cgi->a({-href => href(project=>undef, action=>"opml"),
-		              -class => "rss_logo"}, "OPML") . "\n";
+		              -class => "rss_logo"}, "OPML") . " ";
+		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
+		              -class => "rss_logo"}, "TXT") . "\n";
 	}
 	print "</div>\n" .
 	      "</body>\n" .
-- 
1.4.2
