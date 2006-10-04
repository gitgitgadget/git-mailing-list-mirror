From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 1/3] gitweb: blame: print commit-8 on the leading row of a commit-block
Date: Wed, 4 Oct 2006 00:12:17 -0700 (PDT)
Message-ID: <20061004071217.36209.qmail@web31804.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1401265296-1159945937=:35914"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Oct 04 09:12:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV0w4-0006QK-Dx
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 09:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512AbWJDHMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 03:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWJDHMT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 03:12:19 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:26460 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030413AbWJDHMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 03:12:17 -0400
Received: (qmail 36211 invoked by uid 60001); 4 Oct 2006 07:12:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vYX0CsBMKhlfmm9myRb4WgM4+exG4L2SWN7CEGYPfL051qWMPBoqbZkfE3gCxHt9V+GTwVp1VGhI1EtxYn0WWeCh45fsBkV9sEH/L7ICiPCxBXSUW6m/v3nbx/mCHjpDz/v9n1adCc4cnyXxevD0h6EpEfzctowVldthFUr3w6U=  ;
Received: from [71.80.233.118] by web31804.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 00:12:17 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28317>

--0-1401265296-1159945937=:35914
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Print commit-8 only on the first, leading row of
a commit block, to complement the per-commit block coloring.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

--0-1401265296-1159945937=:35914
Content-Type: text/inline; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: name="p1.txt"; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a9e95c9..9518086 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2501,17 +2501,23 @@ HTML
 		my $rev = substr($full_rev, 0, 8);
 		my $lineno = $2;
 		my $data = $3;
+		my $print_c8 = 0;
 
 		if (!defined $last_rev) {
 			$last_rev = $full_rev;
+			$print_c8 = 1;
 		} elsif ($last_rev ne $full_rev) {
 			$last_rev = $full_rev;
 			$current_color = ++$current_color % $num_colors;
+			$print_c8 = 1;
 		}
 		print "<tr class=\"$rev_color[$current_color]\">\n";
-		print "<td class=\"sha1\">" .
-			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
-			        esc_html($rev)) . "</td>\n";
+		print "<td class=\"sha1\">";
+		if ($print_c8 == 1) {
+			print $cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
+				      esc_html($rev));
+		}
+		print "</td>\n";
 		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
 		      esc_html($lineno) . "</a></td>\n";
 		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
-- 
1.4.2.1.ga68d6


--0-1401265296-1159945937=:35914--
