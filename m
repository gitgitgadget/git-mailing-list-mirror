From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] gitweb: escape tag comments
Date: Mon, 24 Jul 2006 23:07:23 +0100 (BST)
Message-ID: <20060724220723.B5B6C7E3E43@zog.reactivated.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 00:06:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G58ZP-0002s1-Ps
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 00:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWGXWG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWGXWG1
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 18:06:27 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:13856 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932274AbWGXWG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 18:06:26 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060724220624.MIJV15018.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Mon, 24 Jul 2006 23:06:24 +0100
Received: from zog.reactivated.net ([86.14.216.162])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20060724220624.CRKX23938.aamtaout02-winn.ispmail.ntl.com@zog.reactivated.net>;
          Mon, 24 Jul 2006 23:06:24 +0100
Received: by zog.reactivated.net (Postfix, from userid 1000)
	id B5B6C7E3E43; Mon, 24 Jul 2006 23:07:23 +0100 (BST)
To: junkio@cox.net
Cc: kay.sievers@vrfy.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24152>

I have a tag with a comment which includes an & character. Firefox wouldn't
display my gitweb summary page due to malformed XML. This solves the problem.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 2fd1e5f..5acd66d 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1138,7 +1138,7 @@ sub git_summary {
 				      "</td>\n" .
 				      "<td>";
 				if (defined($comment)) {
-				      print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
+				      print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, esc_html($comment));
 				}
 				print "</td>\n" .
 				      "<td class=\"link\">";
