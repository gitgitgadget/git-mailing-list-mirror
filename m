From: Michael Smith <msmith@cbnco.com>
Subject: [PATCH] (cvs|svn)import: Ask git-tag to overwrite old tags.
Date: Fri, 7 Sep 2007 17:35:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709071733500.6203@juice.ott.cti.com>
References: <Pine.LNX.4.64.0709071125090.6203@juice.ott.cti.com>
 <7vzlzy2o46.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:35:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITlTw-0007Hp-4i
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 23:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758575AbXIGVfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 17:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbXIGVfJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 17:35:09 -0400
Received: from mail1.cbnco.com ([207.164.182.72]:43480 "EHLO smtp.cbnco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbXIGVfI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 17:35:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.cbnco.com (Postfix) with ESMTP id 68B751DDAD4;
	Fri,  7 Sep 2007 17:35:07 -0400 (EDT)
Received: from smtp.cbnco.com ([127.0.0.1])
 by localhost (mail.cbnco.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14623-09; Fri,  7 Sep 2007 17:35:07 -0400 (EDT)
Received: from juice.ott.cti.com (auriga-dmzgw.cbnco.com [207.164.182.65])
	by smtp.cbnco.com (Postfix) with ESMTP id 4AA7A16AE47;
	Fri,  7 Sep 2007 17:35:07 -0400 (EDT)
X-X-Sender: michael@juice.ott.cti.com
In-Reply-To: <7vzlzy2o46.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: amavisd-new at cbnco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58079>

If the tag was moved in CVS or SVN history, it will be moved in the
imported history as well. Tag history is not tracked.
---
 git-cvsimport.perl |    2 +-
 git-svnimport.perl |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index ba23eb8..2954fb8 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -779,7 +779,7 @@ sub commit {
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
 
-		system('git-tag', $xtag, $cid) == 0
+		system('git-tag', '-f', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 8c17fb5..d3ad5b9 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -873,7 +873,7 @@ sub commit {
 
 		$dest =~ tr/_/\./ if $opt_u;
 
-		system('git-tag', $dest, $cid) == 0
+		system('git-tag', '-f', $dest, $cid) == 0
 			or die "Cannot create tag $dest: $!\n";
 
 		print "Created tag '$dest' on '$branch'\n" if $opt_v;
-- 
1.5.3.1.20.gb860
