From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 6/9] gitweb: add a get function to compliment print_sort_th
Date: Wed, 13 Jan 2010 17:23:02 -0800
Message-ID: <1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 02:23:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVEQi-0002dw-I6
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab0ANBXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189Ab0ANBXP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:23:15 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:56020 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab0ANBXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:23:13 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0E1N5Ls009231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:23:12 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 17:23:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136909>

This adds a get function for print_sort_th so that the basic
function can be used outside of their straight printing operation.
---
 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d38aad6..07fdeb5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4375,17 +4375,24 @@ sub fill_project_list_info {
 # print 'sort by' <th> element, generating 'sort by $name' replay link
 # if that order is not selected
 sub print_sort_th {
+	print get_sort_th(@_);
+}
+
+sub get_sort_th {
 	my ($name, $order, $header) = @_;
+	my $sortth = "";
 	$header ||= ucfirst($name);
 
 	if ($order eq $name) {
-		print "<th>$header</th>\n";
+		$sortth .= "<th>$header</th>\n";
 	} else {
-		print "<th>" .
+		$sortth .= "<th>" .
 		      $cgi->a({-href => href(-replay=>1, order=>$name),
 		               -class => "header"}, $header) .
 		      "</th>\n";
 	}
+
+	return $sortth;
 }
 
 sub git_project_list_body {
-- 
1.6.5.2
