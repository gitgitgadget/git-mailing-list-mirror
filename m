From: Jakub Narebski <jnareb@git.vger.kernel.org>
Subject: [PATCH] gitweb: Replace some presentational HTML by CSS
Date: Tue, 22 Aug 2006 12:38:59 +0200
Message-ID: <11562431392439-git-send-email-jnareb@git.vger.kernel.org>
References: <20060822085739.75519.qmail@web31810.mail.mud.yahoo.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 22 12:39:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFTfL-0002IM-2C
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 12:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWHVKjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 06:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWHVKjK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 06:39:10 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:34718 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932159AbWHVKjI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 06:39:08 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7MAbpOv026528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Aug 2006 12:37:51 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7MAd0xi012004;
	Tue, 22 Aug 2006 12:39:00 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7MAcxHD012003;
	Tue, 22 Aug 2006 12:38:59 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <20060822085739.75519.qmail@web31810.mail.mud.yahoo.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25850>

From: Jakub Narebski <jnareb@gmail.com>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Follows "gitweb: bugfix: a.list formatting regression" patch.

 gitweb/gitweb.css  |    3 ++-
 gitweb/gitweb.perl |   19 ++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 6c13d9e..4821022 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -42,6 +42,7 @@ div.page_nav a:visited {
 
 div.page_path {
 	padding: 8px;
+	font-weight: bold;
 	border: solid #d9d8d1;
 	border-width: 0px 0px 1px;
 }
@@ -120,7 +121,7 @@ a.list {
 	color: #000000;
 }
 
-a.subject {
+a.subject, a.name {
 	font-weight: bold;
 }
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 40c5177..607b8b7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1267,17 +1267,17 @@ sub git_print_page_path {
 	my $hb = shift;
 
 	if (!defined $name) {
-		print "<div class=\"page_path\"><b>/</b></div>\n";
+		print "<div class=\"page_path\">/</div>\n";
 	} elsif (defined $type && $type eq 'blob') {
-		print "<div class=\"page_path\"><b>";
+		print "<div class=\"page_path\">";
 		if (defined $hb) {
 			print $cgi->a({-href => href(action=>"blob_plain", hash_base=>$hb, file_name=>$file_name)}, esc_html($name));
 		} else {
 			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name)}, esc_html($name));
 		}
-		print "</b><br/></div>\n";
+		print "<br/></div>\n";
 	} else {
-		print "<div class=\"page_path\"><b>" . esc_html($name) . "</b><br/></div>\n";
+		print "<div class=\"page_path\">" . esc_html($name) . "<br/></div>\n";
 	}
 }
 
@@ -1630,7 +1630,7 @@ sub git_tags_body {
 		print "<td><i>$tag{'age'}</i></td>\n" .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'}),
-		               -class => "list"}, "<b>" . esc_html($tag{'name'}) . "</b>") .
+		               -class => "list name"}, esc_html($tag{'name'})) .
 		      "</td>\n" .
 		      "<td>";
 		if (defined $comment) {
@@ -1684,7 +1684,7 @@ sub git_heads_body {
 		print "<td><i>$tag{'age'}</i></td>\n" .
 		      ($tag{'id'} eq $head ? "<td class=\"current_head\">" : "<td>") .
 		      $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'}),
-		               -class => "list"}, "<b>" . esc_html($tag{'name'}) . "</b>") .
+		               -class => "list name"},esc_html($tag{'name'})) .
 		      "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'})}, "shortlog") . " | " .
@@ -2774,7 +2774,8 @@ sub git_search {
 			print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
 			      "<td>" .
-			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}) -class => "list"}, "<b>" . esc_html(chop_str($co{'title'}, 50)) . "</b><br/>");
+			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list subject"},
+			               esc_html(chop_str($co{'title'}, 50)) . "<br/>");
 			my $comment = $co{'comment'};
 			foreach my $line (@$comment) {
 				if ($line =~ m/^(.*)($searchtext)(.*)$/i) {
@@ -2827,8 +2828,8 @@ sub git_search {
 					print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 					      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
 					      "<td>" .
-					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list"}, "<b>" .
-					      esc_html(chop_str($co{'title'}, 50)) . "</b><br/>");
+					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list subject"},
+					              esc_html(chop_str($co{'title'}, 50)) . "<br/>");
 					while (my $setref = shift @files) {
 						my %set = %$setref;
 						print $cgi->a({-href => href(action=>"blob", hash=>$set{'id'}, hash_base=>$co{'id'}, file_name=>$set{'file'}), class => "list"},
-- 
1.4.1.1
