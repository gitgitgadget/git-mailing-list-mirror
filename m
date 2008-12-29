From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] Git.pm: let a "false" Directory parameter (such as "0") be used correctly by the constructor"
Date: Mon, 29 Dec 2008 01:25:00 +0100
Message-ID: <1230510300-7854-1-git-send-email-book@cpan.org>
Cc: "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 01:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH6NH-0006lS-Hx
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 01:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYL2Avb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 19:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYL2Ava
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 19:51:30 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:48314 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbYL2Av3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 19:51:29 -0500
X-Greylist: delayed 1587 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Dec 2008 19:51:29 EST
Received: from localhost ([127.0.0.1] helo=plop)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1LH5ry-0007ln-SO; Mon, 29 Dec 2008 01:20:30 +0100
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1LH5wK-00023f-AQ; Mon, 29 Dec 2008 01:25:00 +0100
X-Mailer: git-send-email 1.6.0.3.517.g759a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104065>

---
 perl/Git.pm |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 8392a68..ad0f530 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -166,11 +166,12 @@ sub repository {
 		}
 	}
 
-	if (not defined $opts{Repository} and not defined $opts{WorkingCopy}) {
-		$opts{Directory} ||= '.';
+	if (not defined $opts{Repository} and not defined $opts{WorkingCopy}
+		and not defined $opts{Directory}) {
+		$opts{Directory} = '.';
 	}
 
-	if ($opts{Directory}) {
+	if (defined $opts{Directory}) {
 		-d $opts{Directory} or throw Error::Simple("Directory not found: $!");
 
 		my $search = Git->repository(WorkingCopy => $opts{Directory});
-- 
1.6.0.3.517.g759a
