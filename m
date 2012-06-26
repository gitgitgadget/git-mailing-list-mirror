From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/5] git-remote-mediawiki: don't compute the diff when getting commit message
Date: Tue, 26 Jun 2012 18:04:29 +0200
Message-ID: <1340726673-25496-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Pavel.Volek@ensimag.imag.fr, Kim-Thuat.Nguyen@ensimag.imag.fr,
	roucherj@ensimag.imag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 26 18:07:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjYIH-0000QO-VN
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 18:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758674Ab2FZQHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 12:07:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35680 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757866Ab2FZQHC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 12:07:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5QG4A86002820
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2012 18:04:10 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjYG3-0008Jz-O5; Tue, 26 Jun 2012 18:04:51 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjYG3-0006eH-MN; Tue, 26 Jun 2012 18:04:51 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 26 Jun 2012 18:04:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5QG4A86002820
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341331454.81422@Q1xEvD7LuPydLUZfPXQntw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200658>

---
 contrib/mw-to-git/git-remote-mediawiki | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index a34f53f..a8e6287 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -874,8 +874,7 @@ sub mw_push_revision {
 		# TODO: for now, it's just a delete+add
 		my @diff_info_list = split(/\0/, $diff_infos);
 		# Keep the first line of the commit message as mediawiki comment for the revision
-		my $commit_msg = (split(/\n/, run_git("show --pretty=format:\"%s\" $sha1_commit")))[0];
+		my $commit_msg = (split(/\n/, run_git("log -1 --format=\"%s\" $sha1_commit")))[0];
 		chomp($commit_msg);
 		# Push every blob
 		while (@diff_info_list) {
-- 
1.7.11.5.g0c7e058.dirty
