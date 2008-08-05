From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-cvsimport.perl: Print "UNKNOWN LINE..." on stderr, not stdout.
Date: Tue, 05 Aug 2008 16:54:42 +0200
Message-ID: <87zlnro6kt.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 16:55:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQNww-0003Fx-K1
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 16:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYHEOyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 10:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbYHEOyo
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 10:54:44 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:43800 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbYHEOyn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 10:54:43 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id D10AE32A815
	for <git@vger.kernel.org>; Tue,  5 Aug 2008 16:54:42 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp8-g19.free.fr (Postfix) with ESMTP id C025232A7AB
	for <git@vger.kernel.org>; Tue,  5 Aug 2008 16:54:42 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A64C16A82B; Tue,  5 Aug 2008 16:54:42 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91442>


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
I'm used to filtering git-cvsimport's noisy stderr, but this
diagnostic appears on stdout.  Looks like an oversight.
Now that I'm using cvsps-2.2b1, I see tons of these.

 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e2664ef..e439202 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -952,7 +952,7 @@ while (<CVS>) {
 	} elsif (/^-+$/) { # end of unknown-line processing
 		$state = 1;
 	} elsif ($state != 11) { # ignore stuff when skipping
-		print "* UNKNOWN LINE * $_\n";
+		print STDERR "* UNKNOWN LINE * $_\n";
 	}
 }
 commit() if $branch and $state != 11;
--
1.6.0.rc1.36.g5ff70
