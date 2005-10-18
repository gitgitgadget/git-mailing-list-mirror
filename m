From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix cvsimport warning when called without --no-cvs-direct
Date: Tue, 18 Oct 2005 16:30:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510181630040.31297@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 18 16:32:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERsU4-0000D1-7i
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 16:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVJROa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 10:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVJROa3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 10:30:29 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48094 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750765AbVJROa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 10:30:29 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3E83E13EFEC; Tue, 18 Oct 2005 16:30:28 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2265AB4DC5; Tue, 18 Oct 2005 16:30:28 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F2F86B12DA; Tue, 18 Oct 2005 16:30:27 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CF00C13EFEC; Tue, 18 Oct 2005 16:30:27 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10214>

Perl was warning that $opt_p was undefined in that case.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: ba55da41e2670b8728cf911ac7424bc1afeb6ce4
8d4a03322860fcc79cd20b76cb91b2f549cf14fd
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 0621dc3..bbb83fb 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -487,7 +487,7 @@ unless($pid) {
 	my @opt;
 	@opt = split(/,/,$opt_p) if defined $opt_p;
 	unshift @opt, '-z', $opt_z if defined $opt_z;
-	unless ($opt_p =~ m/--no-cvs-direct/) {
+	unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
 		push @opt, '--cvs-direct';
 	}
 	exec("cvsps",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
---
0.99.8.GIT
