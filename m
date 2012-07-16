From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 6/8] git-remote-mediawiki: show progress information when listing pages
Date: Mon, 16 Jul 2012 14:00:51 +0200
Message-ID: <1342440053-3058-7-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 14:01:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqjzi-0006YA-77
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2GPMB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:01:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54826 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab2GPMBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 08:01:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6GBxcN1021757
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 13:59:38 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqjzF-0002W8-Qs; Mon, 16 Jul 2012 14:01:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqjzF-0000oT-PR; Mon, 16 Jul 2012 14:01:13 +0200
X-Mailer: git-send-email 1.7.11.1.30.g7e1baf9.dirty
In-Reply-To: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 13:59:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GBxcN1021757
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343044783.00239@Tz0XxgVKJFZHfWR905NTFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201505>

Initial phases of push and pull with git-remote-mediawiki can be long on
a large wiki. Let the user know what's going on.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index f56f9b0..755c9d0 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -371,6 +371,8 @@ sub get_mw_first_pages {
 sub get_mw_pages {
 	mw_connect_maybe();
 
+	print STDERR "Listing pages on remote wiki...\n";
+
 	my %pages; # hash on page titles to avoid duplicates
 	my $user_defined;
 	if (@tracked_pages) {
@@ -394,6 +396,7 @@ sub get_mw_pages {
 			get_all_mediafiles(\%pages);
 		}
 	}
+	print STDERR (scalar keys %pages) . " pages found.\n";
 	return %pages;
 }
 
-- 
1.7.11.1.30.g7e1baf9.dirty
