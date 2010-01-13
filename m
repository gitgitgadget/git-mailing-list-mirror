From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 6/7] gitweb: add a get function to compliment print_local_time
Date: Wed, 13 Jan 2010 01:34:41 -0800
Message-ID: <1263375282-15508-7-git-send-email-warthog9@eaglescrag.net>
References: <1263375282-15508-1-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-2-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-3-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-4-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-5-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-6-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 10:35:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUzdQ-0004Yv-Ok
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 10:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab0AMJfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 04:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188Ab0AMJfF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 04:35:05 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:57270 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab0AMJes (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 04:34:48 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0D9Yg1X018510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 01:34:47 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263375282-15508-6-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 01:34:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136800>

This adds a get function for print_local_time so that the basic
function can be used outside of their straight printing operation.
---
 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3b6bc06..3010fe3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3548,14 +3548,21 @@ sub git_print_header_div {
 }
 
 sub print_local_time {
+	print {$output_handler} get_local_time(@_);
+}
+
+sub get_local_time {
+	my $localtime = "";
 	my %date = @_;
 	if ($date{'hour_local'} < 6) {
-		printf({$output_handler} " (<span class=\"atnight\">%02d:%02d</span> %s)",
+		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
 			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
 	} else {
-		printf({$output_handler} " (%02d:%02d %s)",
+		$localtime .= sprintf(" (%02d:%02d %s)",
 			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
 	}
+
+	return $localtime
 }
 
 # Outputs the author name and date in long form
-- 
1.6.5.2
