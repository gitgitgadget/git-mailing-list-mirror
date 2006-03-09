From: Linus Torvalds <torvalds@osdl.org>
Subject: git-fmt-merge-msg cleanup
Date: Wed, 8 Mar 2006 17:56:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603081753270.32577@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Mar 09 02:56:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHAOA-0002fN-An
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 02:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWCIB4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 20:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWCIB4O
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 20:56:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47071 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750843AbWCIB4O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 20:56:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k291u9DZ007196
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Mar 2006 17:56:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k291u76P008913;
	Wed, 8 Mar 2006 17:56:08 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17393>


Since I've started using the "merge.summary" flag in my repo, my merge 
messages look nicer, but I dislike how I get notifications of merges 
within merges.

So I'd suggest this trivial change..

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index dae383f..afe80e6 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -47,7 +47,7 @@ sub current_branch {
 sub shortlog {
 	my ($tip) = @_;
 	my @result;
-	foreach ( qx{git-log --topo-order --pretty=oneline $tip ^HEAD} ) {
+	foreach ( qx{git-log --no-merges --topo-order --pretty=oneline $tip ^HEAD} ) {
 		s/^[0-9a-f]{40}\s+//;
 		push @result, $_;
 	}
