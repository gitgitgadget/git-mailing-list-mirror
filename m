From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] Git.pm: let a false Directory parameter (such as 0) be used correctly by the constructor
Date: Fri,  2 Jan 2009 09:47:37 +0100
Message-ID: <1230886057-23994-1-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 09:49:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIfiI-0005N3-Fj
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 09:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbZABIrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 03:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbZABIrl
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 03:47:41 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:40552 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbZABIrl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 03:47:41 -0500
Received: from localhost ([127.0.0.1] helo=plop)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1LIfcU-0006nE-BB; Fri, 02 Jan 2009 09:43:02 +0100
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1LIfgv-0006FY-7T; Fri, 02 Jan 2009 09:47:37 +0100
X-Mailer: git-send-email 1.6.0.3.517.g759a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104366>

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
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
