From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 2/9] Prefix Dry- to the message status to denote dry-runs.
Date: Wed, 25 Apr 2007 19:37:16 -0700
Message-ID: <1177555043272-git-send-email-robbat2@gentoo.org>
References: <1177555043986-git-send-email-robbat2@gentoo.org>
 <11775550432104-git-send-email-robbat2@gentoo.org>
Cc: Junio C Hamano <junkio@cox.net>,
	"Robin H\. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 04:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgtrT-00071Z-O5
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbXDZChb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbXDZChb
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:37:31 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:56919 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752960AbXDZCh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:37:28 -0400
Received: (qmail 15765 invoked from network); 26 Apr 2007 02:37:27 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 02:37:27 +0000
Received: (qmail 18804 invoked from network); 25 Apr 2007 19:37:41 -0700
Received: from grubbs-int-e1000.local.orbis-terrarum.net (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 25 Apr 2007 19:37:41 -0700
Received: (nullmailer pid 32446 invoked by uid 0);
	Thu, 26 Apr 2007 02:37:23 -0000
X-Mailer: git-send-email 1.5.2.rc0.43.g2f4c7
In-Reply-To: <11775550432104-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45598>

From: Robin H. Johnson <robbat2@gentoo.org>

While doing testing, it's useful to see that a dry run was actually done,
instead of a real one.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 604168e..00f8181 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -491,9 +491,9 @@ X-Mailer: git-send-email $gitversion
 		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
 	}
 	if ($quiet) {
-		printf "Sent %s\n", $subject;
+		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
-		print "OK. Log says:\nDate: $date\n";
+		print (($dry_run ? "Dry-" : "")."OK. Log says:\nDate: $date\n");
 		if ($smtp) {
 			print "Server: $smtp_server\n";
 		} else {
-- 
1.5.2.rc0.43.g2f4c7
