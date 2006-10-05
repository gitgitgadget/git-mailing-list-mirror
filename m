From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 2/2] gitweb: blame: All rows have title; print 8 SP when no leading commit-8
Date: Wed, 4 Oct 2006 18:02:15 -0700 (PDT)
Message-ID: <20061005010215.63402.qmail@web31811.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-47453824-1160010135=:63235"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Oct 05 03:09:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVHcx-0001Xx-7o
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 03:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWJEBCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 21:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWJEBCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 21:02:16 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:35497 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751291AbWJEBCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 21:02:16 -0400
Received: (qmail 63404 invoked by uid 60001); 5 Oct 2006 01:02:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=q8mjqJUssnn48IYuPDEsxS39EJszaKDQDB7ZsteOf+yVOCviJkzVLhDkCTfrwA2EKRu1Ptwr1qlW2fEfGBQORM7DARp3iqj61oz1COW13Bh5RvLZwEr91uVqFaCrTd61t6nCP16eW3vwe1MQVa1vHQ7opTzP27unfnfyAfgAjhg=  ;
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 18:02:15 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28338>

--0-47453824-1160010135=:63235
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Print eight spaces when no leading commit is being printed.
I.e. on all rows of a commit-block, but the first.  This fixes
alignment in the destination buffer when blame data lines
are cut and pasted.

Also, now all rows have title.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

--0-47453824-1160010135=:63235
Content-Type: text/plain; name="p2.txt"
Content-Description: 1908141687-p2.txt
Content-Disposition: inline; filename="p2.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 451bf5d..2949fa4 100644
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2510,15 +2510,12 @@ HTML
 			$print_c8 = 1;
 		}
 		print "<tr class=\"$rev_color[$current_color]\">";
-		print "<td class=\"sha1\"";
-		if ($print_c8 == 1) {
-			print " title=\"$author, $date\"";
-		}
-		print ">";
-		if ($print_c8 == 1) {
-			print $cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
-				      esc_html($rev));
+		print "<td class=\"sha1\" title=\"$author, $date\">";
+		if ($print_c8 == 0) {
+			$rev = "        ";
 		}
+		print $cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
+			      esc_html($rev));
 		print "</td>";
 		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
 		      esc_html($lineno) . "</a></td>";
-- 
1.4.2.3.g7d77


--0-47453824-1160010135=:63235--
