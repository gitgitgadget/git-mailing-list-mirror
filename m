From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Convert git-* invocations to "git *" in the svnimport example.
Date: Wed, 25 Feb 2009 08:33:14 +0530
Message-ID: <1235530994-30880-1-git-send-email-ams@toroid.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 04:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcAbD-0005Ow-2J
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 04:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbZBYDgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 22:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbZBYDgv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 22:36:51 -0500
Received: from fugue.toroid.org ([85.10.196.113]:44047 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbZBYDgv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 22:36:51 -0500
X-Greylist: delayed 2026 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Feb 2009 22:36:50 EST
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 6E9865584DF;
	Wed, 25 Feb 2009 04:03:00 +0100 (CET)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 54D1D3880CB; Wed, 25 Feb 2009 08:33:14 +0530 (IST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111369>

After these changes, git-svnimport worked fine for me.

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
 contrib/examples/git-svnimport.perl |   36 +++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git-svnimport.perl
index a13bb6a..4576c4a 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -287,9 +287,9 @@ my $last_rev = "";
 my $last_branch;
 my $current_rev = $opt_s || 1;
 unless(-d $git_dir) {
-	system("git-init");
+	system("git init");
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
-	system("git-read-tree");
+	system("git read-tree");
 	die "Cannot init an empty tree: $?\n" if $?;
 
 	$last_branch = $opt_o;
@@ -303,7 +303,7 @@ unless(-d $git_dir) {
 	-f "$git_dir/svn2git"
 		or die "'$git_dir/svn2git' does not exist.\n".
 		       "You need that file for incremental imports.\n";
-	open(F, "git-symbolic-ref HEAD |") or
+	open(F, "git symbolic-ref HEAD |") or
 		die "Cannot run git-symbolic-ref: $!\n";
 	chomp ($last_branch = <F>);
 	$last_branch = basename($last_branch);
@@ -331,7 +331,7 @@ EOM
 				"$git_dir/refs/heads/$opt_o") == 0;
 
 	# populate index
-	system('git-read-tree', $last_rev);
+	system('git', 'read-tree', $last_rev);
 	die "read-tree failed: $?\n" if $?;
 
 	# Get the last import timestamps
@@ -399,7 +399,7 @@ sub get_file($$$) {
 	my $pid = open(my $F, '-|');
 	die $! unless defined $pid;
 	if (!$pid) {
-	    exec("git-hash-object", "-w", $name)
+	    exec("git", "hash-object", "-w", $name)
 		or die "Cannot create object: $!\n";
 	}
 	my $sha = <$F>;
@@ -423,7 +423,7 @@ sub get_ignore($$$$$) {
 		my $pid = open(my $F, '-|');
 		die $! unless defined $pid;
 		if (!$pid) {
-			exec("git-hash-object", "-w", $name)
+			exec("git", "hash-object", "-w", $name)
 			    or die "Cannot create object: $!\n";
 		}
 		my $sha = <$F>;
@@ -547,7 +547,7 @@ sub copy_path($$$$$$$$) {
 	my $pid = open my $f,'-|';
 	die $! unless defined $pid;
 	if (!$pid) {
-		exec("git-ls-tree","-r","-z",$gitrev,$srcpath)
+		exec("git","ls-tree","-r","-z",$gitrev,$srcpath)
 			or die $!;
 	}
 	local $/ = "\0";
@@ -634,7 +634,7 @@ sub commit {
 
 	my $rev;
 	if($revision > $opt_s and defined $parent) {
-		open(H,'-|',"git-rev-parse","--verify",$parent);
+		open(H,'-|',"git","rev-parse","--verify",$parent);
 		$rev = <H>;
 		close(H) or do {
 			print STDERR "$revision: cannot find commit '$parent'!\n";
@@ -671,7 +671,7 @@ sub commit {
 		unlink($git_index);
 	} elsif ($rev ne $last_rev) {
 		print "Switching from $last_rev to $rev ($branch)\n" if $opt_v;
-		system("git-read-tree", $rev);
+		system("git", "read-tree", $rev);
 		die "read-tree failed for $rev: $?\n" if $?;
 		$last_rev = $rev;
 	}
@@ -740,7 +740,7 @@ sub commit {
 			my $pid = open my $F, "-|";
 			die "$!" unless defined $pid;
 			if (!$pid) {
-				exec("git-ls-files", "-z", @o1) or die $!;
+				exec("git", "ls-files", "-z", @o1) or die $!;
 			}
 			@o1 = ();
 			local $/ = "\0";
@@ -758,7 +758,7 @@ sub commit {
 					@o2 = @o1;
 					@o1 = ();
 				}
-				system("git-update-index","--force-remove","--",@o2);
+				system("git","update-index","--force-remove","--",@o2);
 				die "Cannot remove files: $?\n" if $?;
 			}
 		}
@@ -770,7 +770,7 @@ sub commit {
 				@n2 = @new;
 				@new = ();
 			}
-			system("git-update-index","--add",
+			system("git","update-index","--add",
 				(map { ('--cacheinfo', @$_) } @n2));
 			die "Cannot add files: $?\n" if $?;
 		}
@@ -778,7 +778,7 @@ sub commit {
 		my $pid = open(C,"-|");
 		die "Cannot fork: $!" unless defined $pid;
 		unless($pid) {
-			exec("git-write-tree");
+			exec("git","write-tree");
 			die "Cannot exec git-write-tree: $!\n";
 		}
 		chomp(my $tree = <C>);
@@ -830,7 +830,7 @@ sub commit {
 				"GIT_COMMITTER_NAME=$committer_name",
 				"GIT_COMMITTER_EMAIL=$committer_email",
 				"GIT_COMMITTER_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
-				"git-commit-tree", $tree,@par);
+				"git", "commit-tree", $tree,@par);
 			die "Cannot exec git-commit-tree: $!\n";
 		}
 		$pw->writer();
@@ -874,7 +874,7 @@ sub commit {
 
 		$dest =~ tr/_/\./ if $opt_u;
 
-		system('git-tag', '-f', $dest, $cid) == 0
+		system('git', 'tag', '-f', $dest, $cid) == 0
 			or die "Cannot create tag $dest: $!\n";
 
 		print "Created tag '$dest' on '$branch'\n" if $opt_v;
@@ -937,7 +937,7 @@ while ($to_rev < $opt_l) {
 	my $pid = fork();
 	die "Fork: $!\n" unless defined $pid;
 	unless($pid) {
-		exec("git-repack", "-d")
+		exec("git", "repack", "-d")
 			or die "Cannot repack: $!\n";
 	}
 	waitpid($pid, 0);
@@ -958,7 +958,7 @@ if($orig_branch) {
 	system("cp","$git_dir/refs/heads/$opt_o","$git_dir/refs/heads/master")
 		if $forward_master;
 	unless ($opt_i) {
-		system('git-read-tree', '-m', '-u', 'SVN2GIT_HEAD', 'HEAD');
+		system('git', 'read-tree', '-m', '-u', 'SVN2GIT_HEAD', 'HEAD');
 		die "read-tree failed: $?\n" if $?;
 	}
 } else {
@@ -966,7 +966,7 @@ if($orig_branch) {
 	print "DONE; creating $orig_branch branch\n" if $opt_v and (not defined $opt_l or $opt_l > 0);
 	system("cp","$git_dir/refs/heads/$opt_o","$git_dir/refs/heads/master")
 		unless -f "$git_dir/refs/heads/master";
-	system('git-update-ref', 'HEAD', "$orig_branch");
+	system('git', 'update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
 		system('git checkout');
 		die "checkout failed: $?\n" if $?;
-- 
1.6.1.2.253.ga34a
