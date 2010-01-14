From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 2/9] gitweb: change die_error to take "extra" argument for extended die information
Date: Wed, 13 Jan 2010 17:22:58 -0800
Message-ID: <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 02:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVERH-0002pa-VW
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352Ab0ANBXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189Ab0ANBXM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:23:12 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:56016 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab0ANBXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:23:11 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0E1N5Lo009231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:23:11 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 17:23:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136911>

This is a small change that just adds a 3rd, optional, parameter to die_error
that allows for extended error information to be output along with what the
error was.
---
 gitweb/gitweb.perl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0a07d3a..8298de5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3391,6 +3391,7 @@ sub git_footer_html {
 sub die_error {
 	my $status = shift || 500;
 	my $error = shift || "Internal server error";
+	my $extra = shift;
 
 	my %http_responses = (
 		400 => '400 Bad Request',
@@ -3405,8 +3406,13 @@ sub die_error {
 <br /><br />
 $status - $error
 <br />
-</div>
 EOF
+	if (defined $extra) {
+		print "<hr />\n" .
+			"$extra\n";
+	}
+	print "</div>\n";
+
 	git_footer_html();
 	exit;
 }
-- 
1.6.5.2
