From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 9/9] fix a in new changeset applyer addition
Date: Wed, 23 Nov 2005 23:58:16 -0800
Message-ID: <20051124075816.GJ4789@mail.yhbt.net>
References: <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net> <20051124075133.GE4789@mail.yhbt.net> <20051124075243.GF4789@mail.yhbt.net> <20051124075355.GG4789@mail.yhbt.net> <20051124075504.GH4789@mail.yhbt.net> <20051124075631.GI4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 09:00:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBzo-0000rR-O7
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbVKXH6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbVKXH6S
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:58:18 -0500
Received: from hand.yhbt.net ([66.150.188.102]:5354 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030571AbVKXH6R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:58:17 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id C109C2DC033; Wed, 23 Nov 2005 23:58:16 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051124075631.GI4789@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12690>

Fix a stupid bug I introduced when splitting the 
accurate and fast changeset appliers.

Also, remove an old debugging statement I added

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

applies-to: 6dfed0cb7c209cf47902d6dfcd02a974d252041b
b081cb1e0f79f1a290bcf1f2161d63415ec5e2a9
diff --git a/git-archimport.perl b/git-archimport.perl
index 0080850..aab4e38 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -499,7 +499,7 @@ foreach my $ps (@psets) {
     #
     if (ptag($ps->{id})) {
       $opt_v && print " * Skipping already imported: $ps->{id}\n";
-      return 0;
+      next;
     }
 
     print " * Starting to work on $ps->{id}\n";
@@ -578,10 +578,6 @@ foreach my $ps (@psets) {
     print "   + commit $commitid\n";
     $opt_v && print "   + commit date is  $ps->{date} \n";
     $opt_v && print "   + parents:  ",join(' ',@par),"\n";
-    if (my $dirty = `git-diff-files`) {
-        die "22 Unclean tree when about to process $ps->{id} " .
-            " - did we fail to commit cleanly before?\n$dirty";
-    }
 }
 
 if ($opt_v) {
---
0.99.9.GIT
