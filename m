From: Li Yang <leoli@freescale.com>
Subject: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 06 Mar 2007 11:58:56 +0800
Message-ID: <45ECE700.8090205@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 06 04:58:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOQoe-00033I-8V
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 04:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933927AbXCFD6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 22:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933929AbXCFD6S
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 22:58:18 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:51806 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933928AbXCFD6R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 22:58:17 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l263veqX011823
	for <git@vger.kernel.org>; Mon, 5 Mar 2007 20:57:47 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net [10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l263vdc6017183
	for <git@vger.kernel.org>; Mon, 5 Mar 2007 21:57:39 -0600 (CST)
Received: from [127.0.0.1] ([10.193.20.126]) by zch01exm20.fsl.freescale.net with Microsoft SMTPSVC(6.0.3790.2709);
	 Tue, 6 Mar 2007 11:57:38 +0800
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
X-OriginalArrivalTime: 06 Mar 2007 03:57:38.0397 (UTC) FILETIME=[94CAB8D0:01C75FA3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41535>

Change to use explicitly function call cgi->escapHTML().
This fix the problem on some systems that escapeHTML() is not
functioning, as default CGI is not setting 'escape' parameter.

Signed-off-by: Li Yang <leoli@freescale.com>

---
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 653ca3c..3a564d1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -591,7 +591,7 @@ sub esc_html ($;%) {
 	my %opts = @_;
 
 	$str = to_utf8($str);
-	$str = escapeHTML($str);
+	$str = $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =~ s/ /&nbsp;/g;
 	}
@@ -605,7 +605,7 @@ sub esc_path {
 	my %opts = @_;
 
 	$str = to_utf8($str);
-	$str = escapeHTML($str);
+	$str = $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =~ s/ /&nbsp;/g;
 	}
