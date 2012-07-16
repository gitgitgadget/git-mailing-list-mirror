From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 6/8] git-remote-mediawiki: show progress information when listing pages
Date: Mon, 16 Jul 2012 21:46:40 +0200
Message-ID: <1342468002-31818-7-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 21:47:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqrGt-0000SE-FO
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab2GPTrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:47:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37293 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835Ab2GPTrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:47:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6GJjapb014907
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 21:45:38 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGP-0001Sj-J6; Mon, 16 Jul 2012 21:47:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGP-0008IZ-Hk; Mon, 16 Jul 2012 21:47:25 +0200
X-Mailer: git-send-email 1.7.11.2.258.g5ff3cdf.dirty
In-Reply-To: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Jul 2012 21:45:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GJjapb014907
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343072740.06645@Y9WMu1O5t9FsMXhNWmVwcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201557>

Initial phases of push and pull with git-remote-mediawiki can be long on
a large wiki. Let the user know what's going on.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 517a4db..729a0bc 100755
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
1.7.11.2.258.g5ff3cdf.dirty
