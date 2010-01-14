From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 5/9] gitweb: add a get function to compliment print_local_time
Date: Wed, 13 Jan 2010 17:23:01 -0800
Message-ID: <1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 02:24:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVERI-0002pa-II
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab0ANBXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724Ab0ANBXP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:23:15 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:56019 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab0ANBXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:23:12 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0E1N5Lr009231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:23:12 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 17:23:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136916>

This adds a get function for print_local_time so that the basic
function can be used outside of their straight printing operation.
---
 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b41bc33..d38aad6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3537,14 +3537,21 @@ sub git_print_header_div {
 }
 
 sub print_local_time {
+	print get_local_time(@_);
+}
+
+sub get_local_time {
+	my $localtime = "";
 	my %date = @_;
 	if ($date{'hour_local'} < 6) {
-		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
+		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
 			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
 	} else {
-		printf(" (%02d:%02d %s)",
+		$localtime .= sprintf(" (%02d:%02d %s)",
 			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
 	}
+
+	return $localtime
 }
 
 # Outputs the author name and date in long form
-- 
1.6.5.2
