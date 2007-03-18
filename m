From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-remote: allow 'git-remote fetch' as a synonym for 'git fetch'
Date: Sun, 18 Mar 2007 22:03:45 +1200
Message-ID: <20070318101311.E296213A382@magnus.utsl.gen.nz>
References: <20070318094910.7985613A382@magnus.utsl.gen.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 11:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSsO4-0001ju-EI
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 11:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbXCRKNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 06:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753758AbXCRKNO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 06:13:14 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53837 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbXCRKNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 06:13:14 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id E296213A382; Sun, 18 Mar 2007 22:13:11 +1200 (NZST)
In-Reply-To: <20070318094910.7985613A382@magnus.utsl.gen.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42487>

And here it is again, this time with documentation and based against
maint.

From: Sam Vilain <sam@vilain.net>
Subject: git-remote: allow 'git-remote fetch' as a synonym for 'git fetch'

I found myself typing this when doing remote-like things.  Perhaps
other people will find this useful

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/git-remote.txt |    4 ++++
 git-remote.perl              |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index de2658c..ab04b86 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -64,6 +64,10 @@ With `-n` option, the remote heads are not confirmed first with `git
 ls-remote <name>`; cached information is used instead.  Use with
 caution.
 
+'fetch'::
+
+Synonym for `git fetch <name>`, and accepts all the same options.
+
 'update'::
 
 Fetch updates for a named set of remotes in the repository as defined by
diff --git a/git-remote.perl b/git-remote.perl
index bd70bf1..20f9f54 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -389,11 +389,15 @@ elsif ($ARGV[0] eq 'add') {
 	}
 	add_remote($ARGV[1], $ARGV[2], \%opts);
 }
+elsif ($ARGV[0] eq 'fetch') {
+	exec("git-fetch", @ARGV[1..$#ARGV]);
+}
 else {
 	print STDERR "Usage: git remote\n";
 	print STDERR "       git remote add <name> <url>\n";
 	print STDERR "       git remote show <name>\n";
 	print STDERR "       git remote prune <name>\n";
 	print STDERR "       git remote update [group]\n";
+	print STDERR "       git remote fetch <fetch-options> <repository> <refspec>...\n";
 	exit(1);
 }
-- 
1.5.0.2.gdcde2
