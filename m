From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] Git.pm: better error message
Date: Mon, 14 Jun 2010 03:00:22 +0200
Message-ID: <1276477222-21465-1-git-send-email-book@cpan.org>
Cc: "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 03:35:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONyaf-0001xl-Kr
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 03:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180Ab0FNBfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 21:35:48 -0400
Received: from zlonk.bruhat.net ([91.121.102.217]:51492 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab0FNBfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 21:35:47 -0400
X-Greylist: delayed 2087 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Jun 2010 21:35:47 EDT
Received: from localhost ([127.0.0.1] helo=swoosh)
	by ks354402.kimsufi.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1ONy2p-0004EI-AO; Mon, 14 Jun 2010 03:00:55 +0200
Received: from book by swoosh with local (Exim 4.71)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1ONy2o-0005ap-Iq; Mon, 14 Jun 2010 03:00:54 +0200
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149062>

-d doesn't set $! if the directory doesn't exist

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 perl/Git.pm |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 1926dc9..2a3920b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -172,7 +172,7 @@ sub repository {
 	}
 
 	if (defined $opts{Directory}) {
-		-d $opts{Directory} or throw Error::Simple("Directory not found: $!");
+		-d $opts{Directory} or throw Error::Simple("Directory not found: $opts{Directory}");
 
 		my $search = Git->repository(WorkingCopy => $opts{Directory});
 		my $dir;
@@ -545,7 +545,7 @@ sub wc_chdir {
 		or throw Error::Simple("bare repository");
 
 	-d $self->wc_path().'/'.$subdir
-		or throw Error::Simple("subdir not found: $!");
+		or throw Error::Simple("subdir not found: $subdir");
 	# Of course we will not "hold" the subdirectory so anyone
 	# can delete it now and we will never know. But at least we tried.
 
-- 
1.7.0.4
