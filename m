From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 14:47:54 +0200
Message-ID: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit Mailinglist <msysgit@googlegroups.com>, 
	Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: msysgit+bncBDZMLEGXWQLBB67IWCHAKGQEJLXYHOY@googlegroups.com Thu Jun 27 14:47:57 2013
Return-path: <msysgit+bncBDZMLEGXWQLBB67IWCHAKGQEJLXYHOY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBB67IWCHAKGQEJLXYHOY@googlegroups.com>)
	id 1UsBcC-0002p4-Q0
	for gcvm-msysgit@m.gmane.org; Thu, 27 Jun 2013 14:47:56 +0200
Received: by mail-wi0-f183.google.com with SMTP id en1sf132319wid.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Jun 2013 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:mime-version:date:message-id:subject:from:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=RX8cUY7rPa3DDhqwPd5v+hPd0qxdYmdKYoIRkjxeI14=;
        b=YMhjCbsb5lGI5RTt1JuGE78iJJVpG1xxCFVULgyhDIZSWmWT0rZVmYUcdmQPM1IU6C
         YD6yafagE+Y+GlZFXk9Dos5KD3TADZ2u5xDNerHXeRREp4vy0ktdzMm+ZC5Icwm+HlVh
         N1+p6i8j2EcSTrsd9oOwNhNUgYd8QvnyvsHJ1/dPR+PWg5Z0VpA38vlcooQ2ZvMr1LEx
         PqfmJeW5H33u3ETPmfQ1cjdF+RYZLy59u4iB/0Dav4P+cAUu9l1gRQtgAbny8QA671Oy
         mvpiSgMFqvdhNGZM2Z60vQBWth1IuKXCtS+N7rGsKNd/apFcyX1ZfqMaVcSIyZlq8xh0
         slVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:mime-version:date:message-id:subject:from:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=RX8cUY7rPa3DDhqwPd5v+hPd0qxdYmdKYoIRkjxeI14=;
        b=ND5dInkm/LeQj8PN/BH/5djvl/PTBTotWYAAUMMUiSMrVbdoEBTZs4lSVAZINdb+DB
         uOhvFyKGxnpxnCLf18Eyp72bQHzxeFw5H6IbhPUB/g6i/4sTTxzTpdPI3qKdfPnsvYtr
         v//ZlEeYjmyO3zMpMHUH/XQ2szU4B3I3V3GZtlLw0H/p0YG9OGbIxDuG/80iMgqFjekz
         c4sQXI6VNAuJHBlA41GPqyBiFa0AEShgrcGxlFP+943tMl/eJeVnwJi1ugDroc2g0V0G
         cG5RBuyR2PEYemFYb8DN3Q+nOBinwLHamrroB6A3iSWfoxbnglBJeLlviBt1AZ0J4OYx
         n1CQ==
X-Received: by 10.180.76.110 with SMTP id j14mr744010wiw.20.1372337276533;
        Thu, 27 Jun 2013 05:47:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.20.197 with SMTP id p5ls1584401wie.52.canary; Thu, 27 Jun
 2013 05:47:55 -0700 (PDT)
X-Received: by 10.204.240.14 with SMTP id ky14mr228848bkb.0.1372337275277;
        Thu, 27 Jun 2013 05:47:55 -0700 (PDT)
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com [209.85.215.48])
        by gmr-mx.google.com with ESMTPS id cx8si117355bkb.0.2013.06.27.05.47.55
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 05:47:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 209.85.215.48 as permitted sender) client-ip=209.85.215.48;
Received: by mail-la0-f48.google.com with SMTP id lx15so752880lab.21
        for <msysgit@googlegroups.com>; Thu, 27 Jun 2013 05:47:55 -0700 (PDT)
X-Received: by 10.152.27.195 with SMTP id v3mr4104997lag.73.1372337274963;
 Thu, 27 Jun 2013 05:47:54 -0700 (PDT)
Received: by 10.114.16.161 with HTTP; Thu, 27 Jun 2013 05:47:54 -0700 (PDT)
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 209.85.215.48 as
 permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229097>

Call built-in commands via the main executable (non-dashed form) without
relying on the aliases (dashed form) to be present. On some platforms,
e.g. those that do not properly support file system links, it is
inconvenient to ship the built-in aliases, so do not depend on their
presence.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-am.sh                |  6 ++---
 git-archimport.perl      | 68 ++++++++++++++++++++++++------------------------
 git-cvsexportcommit.perl | 18 ++++++-------
 git-cvsserver.perl       | 50 +++++++++++++++++------------------
 git-merge-octopus.sh     |  2 +-
 git-merge-one-file.sh    |  8 +++---
 git-merge-resolve.sh     |  2 +-
 git-parse-remote.sh      |  2 +-
 git-pull.sh              |  2 +-
 git-stash.sh             |  2 +-
 git-submodule.sh         |  8 +++---
 11 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 9f44509..ad67194 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,8 +16,8 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 keep-non-patch  pass -b flag to git-mailinfo
-keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
-no-keep-cr      do not pass --keep-cr flag to git-mailsplit
independent of am.keepcr
+keep-cr         pass --keep-cr flag to git mailsplit for mbox format
+no-keep-cr      do not pass --keep-cr flag to git mailsplit
independent of am.keepcr
 c,scissors      strip everything before a scissors line
 whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
@@ -174,7 +174,7 @@ It does not apply to blobs recorded in its index.")"
     then
 	    GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
     fi
-    git-merge-recursive $orig_tree -- HEAD $his_tree || {
+    git merge-recursive $orig_tree -- HEAD $his_tree || {
 	    git rerere $allow_rerere_autoupdate
 	    die "$(gettext "Failed to merge in the changes.")"
     }
diff --git a/git-archimport.perl b/git-archimport.perl
index 9cb123a..ed2c741 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -343,10 +343,10 @@ sub process_patchset_accurate {

     # switch to that branch if we're not already in that branch:
     if (-e "$git_dir/refs/heads/$ps->{branch}") {
-       system('git-checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
+       system('git','checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";

        # remove any old stuff that got leftover:
-       my $rm = safe_pipe_capture('git-ls-files','--others','-z');
+       my $rm = safe_pipe_capture('git','ls-files','--others','-z');
        rmtree(split(/\0/,$rm)) if $rm;
     }

@@ -367,7 +367,7 @@ sub process_patchset_accurate {

             # find where we are supposed to branch from
 	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
-		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
+		system('git','branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";

 		# We trust Arch with the fact that this is just a tag,
 		# and it does not affect the state of the tree, so
@@ -378,10 +378,10 @@ sub process_patchset_accurate {
 		ptag($ps->{id}, $branchpoint);
 		print " * Tagged $ps->{id} at $branchpoint\n";
 	    }
-	    system('git-checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
+	    system('git','checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";

             # remove any old stuff that got leftover:
-            my $rm = safe_pipe_capture('git-ls-files','--others','-z');
+            my $rm = safe_pipe_capture('git','ls-files','--others','-z');
             rmtree(split(/\0/,$rm)) if $rm;
             return 0;
         } else {
@@ -392,10 +392,10 @@ sub process_patchset_accurate {
     }

     # update the index with all the changes we got
-    system('git-diff-files --name-only -z | '.
-            'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
-    system('git-ls-files --others -z | '.
-            'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
+    system('git diff-files --name-only -z | '.
+            'git update-index --remove -z --stdin') == 0 or die "$! $?\n";
+    system('git ls-files --others -z | '.
+            'git update-index --add -z --stdin') == 0 or die "$! $?\n";
     return 1;
 }

@@ -413,7 +413,7 @@ sub process_patchset_fast {
     unless ($import) { # skip for import
         if ( -e "$git_dir/refs/heads/$ps->{branch}") {
             # we know about this branch
-            system('git-checkout',$ps->{branch});
+            system('git','checkout',$ps->{branch});
         } else {
             # new branch! we need to verify a few things
             die "Branch on a non-tag!" unless $ps->{type} eq 't';
@@ -423,7 +423,7 @@ sub process_patchset_fast {

             # find where we are supposed to branch from
 	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
-		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
+		system('git','branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";

 		# We trust Arch with the fact that this is just a tag,
 		# and it does not affect the state of the tree, so
@@ -434,7 +434,7 @@ sub process_patchset_fast {
 		ptag($ps->{id}, $branchpoint);
 		print " * Tagged $ps->{id} at $branchpoint\n";
             }
-            system('git-checkout',$ps->{branch}) == 0 or die "$! $?\n";
+            system('git','checkout',$ps->{branch}) == 0 or die "$! $?\n";
             return 0;
         }
         die $! if $?;
@@ -465,10 +465,10 @@ sub process_patchset_fast {
     # imports don't give us good info
     # on added files. Shame on them
     if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
-        system('git-ls-files --deleted -z | '.
-                'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
-        system('git-ls-files --others -z | '.
-                'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
+        system('git ls-files --deleted -z | '.
+                'git update-index --remove -z --stdin') == 0 or die "$! $?\n";
+        system('git ls-files --others -z | '.
+                'git update-index --add -z --stdin') == 0 or die "$! $?\n";
     }

     # TODO: handle removed_directories and renamed_directories:
@@ -477,8 +477,8 @@ sub process_patchset_fast {
         unlink @$del;
         while (@$del) {
             my @slice = splice(@$del, 0, 100);
-            system('git-update-index','--remove','--',@slice) == 0 or
-                            die "Error in git-update-index --remove: $! $?\n";
+            system('git update-index','--remove','--',@slice) == 0 or
+                            die "Error in git update-index --remove: $! $?\n";
         }
     }

@@ -496,25 +496,25 @@ sub process_patchset_fast {
             }
             # print "moving $from $to";
             rename($from, $to) or die "Error renaming '$from' '$to': $!\n";
-            system('git-update-index','--remove','--',$from) == 0 or
-                            die "Error in git-update-index --remove: $! $?\n";
-            system('git-update-index','--add','--',$to) == 0 or
-                            die "Error in git-update-index --add: $! $?\n";
+            system('git update-index','--remove','--',$from) == 0 or
+                            die "Error in git update-index --remove: $! $?\n";
+            system('git update-index','--add','--',$to) == 0 or
+                            die "Error in git update-index --add: $! $?\n";
         }
     }

     if (my $add = $ps->{new_files}) {
         while (@$add) {
             my @slice = splice(@$add, 0, 100);
-            system('git-update-index','--add','--',@slice) == 0 or
-                            die "Error in git-update-index --add: $! $?\n";
+            system('git update-index','--add','--',@slice) == 0 or
+                            die "Error in git update-index --add: $! $?\n";
         }
     }

     if (my $mod = $ps->{modified_files}) {
         while (@$mod) {
             my @slice = splice(@$mod, 0, 100);
-            system('git-update-index','--',@slice) == 0 or
+            system('git update-index','--',@slice) == 0 or
                             die "Error in git-update-index: $! $?\n";
         }
     }
@@ -593,7 +593,7 @@ foreach my $ps (@psets) {
     $ENV{GIT_COMMITTER_EMAIL} = $ps->{email};
     $ENV{GIT_COMMITTER_DATE}  = $ps->{date};

-    my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par)
+    my $pid = open2(*READER, *WRITER,'git','commit-tree',$tree,@par)
         or die $!;
     print WRITER $ps->{summary},"\n\n";

@@ -620,7 +620,7 @@ foreach my $ps (@psets) {
     open  HEAD, ">","$git_dir/refs/heads/$ps->{branch}";
     print HEAD $commitid;
     close HEAD;
-    system('git-update-ref', 'HEAD', "$ps->{branch}");
+    system('git', 'update-ref', 'HEAD', "$ps->{branch}");

     # tag accordingly
     ptag($ps->{id}, $commitid); # private tag
@@ -945,7 +945,7 @@ sub find_parents {
     #
     # Identify what branches are merging into me
     # and whether we are fully merged
-    # git-merge-base <headsha> <headsha> should tell
+    # git merge-base <headsha> <headsha> should tell
     # me what the base of the merge should be
     #
     my $ps = shift;
@@ -983,7 +983,7 @@ sub find_parents {
 	# check that we actually know about the branch
 	next unless -e "$git_dir/refs/heads/$branch";

-	my $mergebase = `git-merge-base $branch $ps->{branch}`;
+	my $mergebase = `git merge-base $branch $ps->{branch}`;
 	if ($?) {
 	    # Don't die here, Arch supports one-way cherry-picking
 	    # between branches with no common base (or any relationship
@@ -995,7 +995,7 @@ sub find_parents {

 	# now walk up to the mergepoint collecting what patches we have
 	my $branchtip = git_rev_parse($ps->{branch});
-	my @ancestors = `git-rev-list --topo-order $branchtip ^$mergebase`;
+	my @ancestors = `git rev-list --topo-order $branchtip ^$mergebase`;
 	my %have; # collected merges this branch has
 	foreach my $merge (@{$ps->{merges}}) {
 	    $have{$merge} = 1;
@@ -1018,11 +1018,11 @@ sub find_parents {
 	# see what the remote branch has - these are the merges we
 	# will want to have in a consecutive series from the mergebase
 	my $otherbranchtip = git_rev_parse($branch);
-	my @needraw = `git-rev-list --topo-order $otherbranchtip ^$mergebase`;
+	my @needraw = `git rev-list --topo-order $otherbranchtip ^$mergebase`;
 	my @need;
 	foreach my $needps (@needraw) { 	# get the psets
 	    $needps = commitid2pset($needps);
-	    # git-rev-list will also
+	    # git rev-list will also
 	    # list commits merged in via earlier
 	    # merges. we are only interested in commits
 	    # from the branch we're looking at
@@ -1074,8 +1074,8 @@ sub find_parents {

 sub git_rev_parse {
     my $name = shift;
-    my $val  = `git-rev-parse $name`;
-    die "Error: git-rev-parse $name" if $?;
+    my $val  = `git rev-parse $name`;
+    die "Error: git rev-parse $name" if $?;
     chomp $val;
     return $val;
 }
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d13f02d..6718bad 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -18,7 +18,7 @@ $opt_h && usage();

 die "Need at least one commit identifier!" unless @ARGV;

-# Get git-config settings
+# Get git config settings
 my $repo = Git->repository();
 $opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;

@@ -26,7 +26,7 @@ if ($opt_w || $opt_W) {
 	# Remember where GIT_DIR is before changing to CVS checkout
 	unless ($ENV{GIT_DIR}) {
 		# No GIT_DIR set. Figure it out for ourselves
-		my $gd =`git-rev-parse --git-dir`;
+		my $gd =`git rev-parse --git-dir`;
 		chomp($gd);
 		$ENV{GIT_DIR} = $gd;
 	}
@@ -62,7 +62,7 @@ if ($opt_d) {
 # resolve target commit
 my $commit;
 $commit = pop @ARGV;
-$commit = safe_pipe_capture('git-rev-parse', '--verify', "$commit^0");
+$commit = safe_pipe_capture('git', 'rev-parse', '--verify', "$commit^0");
 chomp $commit;
 if ($?) {
     die "The commit reference $commit did not resolve!";
@@ -72,7 +72,7 @@ if ($?) {
 my $parent;
 if (@ARGV) {
     $parent = pop @ARGV;
-    $parent =  safe_pipe_capture('git-rev-parse', '--verify', "$parent^0");
+    $parent =  safe_pipe_capture('git', 'rev-parse', '--verify', "$parent^0");
     chomp $parent;
     if ($?) {
 	die "The parent reference did not resolve!";
@@ -80,7 +80,7 @@ if (@ARGV) {
 }

 # find parents from the commit itself
-my @commit  = safe_pipe_capture('git-cat-file', 'commit', $commit);
+my @commit  = safe_pipe_capture('git', 'cat-file', 'commit', $commit);
 my @parents;
 my $committer;
 my $author;
@@ -158,9 +158,9 @@ if ($opt_a) {
 close MSG;

 if ($parent eq $noparent) {
-    `git-diff-tree --binary -p --root $commit
>.cvsexportcommit.diff`;# || die "Cannot diff";
+    `git diff-tree --binary -p --root $commit
>.cvsexportcommit.diff`;# || die "Cannot diff";
 } else {
-    `git-diff-tree --binary -p $parent $commit
>.cvsexportcommit.diff`;# || die "Cannot diff";
+    `git diff-tree --binary -p $parent $commit
>.cvsexportcommit.diff`;# || die "Cannot diff";
 }

 ## apply non-binary changes
@@ -174,7 +174,7 @@ my $context = $opt_p ? '' : '-C1';
 print "Checking if patch will apply\n";

 my @stat;
-open APPLY, "GIT_DIR= git-apply $context --summary
--numstat<.cvsexportcommit.diff|" || die "cannot patch";
+open APPLY, "GIT_DIR= git apply $context --summary
--numstat<.cvsexportcommit.diff|" || die "cannot patch";
 @stat=<APPLY>;
 close APPLY || die "Cannot patch";
 my (@bfiles,@files,@afiles,@dfiles);
@@ -329,7 +329,7 @@ print "Applying\n";
 if ($opt_W) {
     system("git checkout -q $commit^0") && die "cannot patch";
 } else {
-    `GIT_DIR= git-apply $context --summary --numstat --apply
<.cvsexportcommit.diff` || die "cannot patch";
+    `GIT_DIR= git apply $context --summary --numstat --apply
<.cvsexportcommit.diff` || die "cannot patch";
 }

 print "Patch applied successfully. Adding new files and directories to CVS\n";
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a0d796e..53c136f 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -358,10 +358,10 @@ sub req_Root

     my @gitvars = `git config -l`;
     if ($?) {
-       print "E problems executing git-config on the server -- this
is not a git repository or the PATH is not set correctly.\n";
+        print "E problems executing git config on the server -- this
is not a git repository or the PATH is not set correctly.\n";
         print "E \n";
         print "error 1 - problem executing git-config\n";
-       return 0;
+        return 0;
     }
     foreach my $line ( @gitvars )
     {
@@ -1626,7 +1626,7 @@ sub req_ci
         if ($wrev) {
             system('git', 'checkout-index', '-f', '-u', $filename);
             unless ($? == 0) {
-                die "Error running git-checkout-index -f -u $filename : $!";
+                die "Error running git checkout-index -f -u $filename : $!";
             }
         }

@@ -1716,7 +1716,7 @@ sub req_ci
         exit;
     }

-	### Emulate git-receive-pack by running hooks/update
+	### Emulate git receive-pack by running hooks/update
 	my @hook = ( $ENV{GIT_DIR}.'hooks/update', $branchRef,
 			$parenthash, $commithash );
 	if( -x $hook[0] ) {
@@ -1738,7 +1738,7 @@ sub req_ci
 		exit;
 	}

-	### Emulate git-receive-pack by running hooks/post-receive
+	### Emulate git receive-pack by running hooks/post-receive
 	my $hook = $ENV{GIT_DIR}.'hooks/post-receive';
 	if( -x $hook ) {
 		open(my $pipe, "| $hook") || die "can't fork $!";
@@ -2328,7 +2328,7 @@ sub req_annotate
 	system("git", "read-tree", $lastseenin);
 	unless ($? == 0)
 	{
-	    print "E error running git-read-tree $lastseenin
$ENV{GIT_INDEX_FILE} $!\n";
+	    print "E error running git read-tree $lastseenin
$ENV{GIT_INDEX_FILE} $!\n";
 	    return;
 	}
 	$log->info("Created index '$ENV{GIT_INDEX_FILE}' with commit
$lastseenin - exit status $?");
@@ -2336,7 +2336,7 @@ sub req_annotate
         # do a checkout of the file
         system('git', 'checkout-index', '-f', '-u', $filename);
         unless ($? == 0) {
-            print "E error running git-checkout-index -f -u $filename : $!\n";
+            print "E error running git checkout-index -f -u $filename : $!\n";
             return;
         }

@@ -2886,7 +2886,7 @@ sub transmitfile
         }
         close $fh or die ("Couldn't close filehandle for transmitfile(): $!");
     } else {
-        die("Couldn't execute git-cat-file");
+        die("Couldn't execute git cat-file");
     }
 }

@@ -3008,8 +3008,8 @@ sub setupWorkTree
         system("git","read-tree",$ver);
         unless ($? == 0)
         {
-            $log->warn("Error running git-read-tree");
-            die "Error running git-read-tree $ver in $work->{workDir} $!\n";
+            $log->warn("Error running git read-tree");
+            die "Error running git read-tree $ver in $work->{workDir} $!\n";
         }
     }
     # else # req_annotate reads tree for each file
@@ -3062,7 +3062,7 @@ sub ensureWorkTree
     system("git","read-tree",$ver);
     unless ($? == 0)
     {
-        die "Error running git-read-tree $ver $!\n";
+        die "Error running git read-tree $ver $!\n";
     }
 }

@@ -3829,7 +3829,7 @@ sub update
     } else {
         push @git_log_params, $self->{module};
     }
-    # git-rev-list is the backend / plumbing version of git-log
+    # git rev-list is the backend / plumbing version of git-log
     open(my $gitLogPipe, '-|', 'git', 'rev-list', @git_log_params)
                 or die "Cannot call git-rev-list: $!";
     my @commits=readCommits($gitLogPipe);
@@ -3878,7 +3878,7 @@ sub update
                     if ($parent eq $lastpicked) {
                         next;
                     }
-                    # git-merge-base can potentially (but rarely) throw
+                    # git merge-base can potentially (but rarely) throw
                     # several candidate merge bases. let's assume
                     # that the first one is the best one.
 		    my $base = eval {
@@ -3936,14 +3936,14 @@ sub update

         if ( defined ( $lastpicked ) )
         {
-            my $filepipe = open(FILELIST, '-|', 'git', 'diff-tree',
'-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call
git-diff-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git', 'diff-tree',
'-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git
diff-tree : $!");
 	    local ($/) = "\0";
             while ( <FILELIST> )
             {
 		chomp;
                 unless (
/^:\d{6}\s+([0-7]{6})\s+[a-f0-9]{40}\s+([a-f0-9]{40})\s+(\w)$/o )
                 {
-                    die("Couldn't process git-diff-tree line : $_");
+                    die("Couldn't process git diff-tree line : $_");
                 }
 		my ($mode, $hash, $change) = ($1, $2, $3);
 		my $name = <FILELIST>;
@@ -4006,14 +4006,14 @@ sub update
             # this is used to detect files removed from the repo
             my $seen_files = {};

-            my $filepipe = open(FILELIST, '-|', 'git', 'ls-tree',
'-z', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git', 'ls-tree',
'-z', '-r', $commit->{hash}) or die("Cannot call git ls-tree : $!");
 	    local $/ = "\0";
             while ( <FILELIST> )
             {
 		chomp;
                 unless ( /^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
                 {
-                    die("Couldn't process git-ls-tree line : $_");
+                    die("Couldn't process git ls-tree line : $_");
                 }

                 my ( $mode, $git_type, $git_hash, $git_filename ) = (
$1, $2, $3, $4 );
@@ -4312,7 +4312,7 @@ sub getAnyHead
     my @files;
     {
         open(my $filePipe, '-|', 'git', 'ls-tree', '-z', '-r', $hash)
-                or die("Cannot call git-ls-tree : $!");
+                or die("Cannot call git ls-tree : $!");
         local $/ = "\0";
         @files=<$filePipe>;
         close $filePipe;
@@ -4325,7 +4325,7 @@ sub getAnyHead
         $line=~s/\0$//;
         unless ( $line=~/^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
         {
-            die("Couldn't process git-ls-tree line : $_");
+            die("Couldn't process git ls-tree line : $_");
         }

         my($mode, $git_type, $git_hash, $git_filename) = ($1, $2, $3, $4);
@@ -4391,14 +4391,14 @@ sub getRevisionDirMap
         }

         open(my $filePipe, '-|', 'git', 'ls-tree', '-z', '-r', $hash)
-                or die("Cannot call git-ls-tree : $!");
+                or die("Cannot call git ls-tree : $!");
         local $/ = "\0";
         while ( <$filePipe> )
         {
             chomp;
             unless ( /^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
             {
-                die("Couldn't process git-ls-tree line : $_");
+                die("Couldn't process git ls-tree line : $_");
             }

             my($mode, $git_type, $git_hash, $git_filename) = ($1, $2, $3, $4);
@@ -4692,7 +4692,7 @@ sub getMetaFromCommithash

     # NOTE: This function doesn't scale well (lots of forks), especially
     #   if you have many files that have not been modified for many commits
-    #   (each git-rev-parse redoes a lot of work for each file
+    #   (each git rev-parse redoes a lot of work for each file
     #   that theoretically could be done in parallel by smarter
     #   graph traversal).
     #
@@ -4796,20 +4796,20 @@ sub getMetaFromCommithash
     # meta data about $filename:
     open(my $filePipe, '-|', 'git', 'ls-tree', '-z',
                 $commit->{hash}, '--', $filename)
-            or die("Cannot call git-ls-tree : $!");
+            or die("Cannot call git ls-tree : $!");
     local $/ = "\0";
     my $line;
     $line=<$filePipe>;
     if(defined(<$filePipe>))
     {
-        die "Expected only a single file for git-ls-tree $filename\n";
+        die "Expected only a single file for git ls-tree $filename\n";
     }
     close $filePipe;

     chomp $line;
     unless ( $line=~m/^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
     {
-        die("Couldn't process git-ls-tree line : $line\n");
+        die("Couldn't process git ls-tree line : $line\n");
     }
     my ( $mode, $git_type, $git_hash, $git_filename ) = ( $1, $2, $3, $4 );

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 8643f74..ec1d65b 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -97,7 +97,7 @@ do
 	if test $? -ne 0
 	then
 		echo "Simple merge did not work, trying automatic merge."
-		git-merge-index -o git-merge-one-file -a ||
+		git merge-index -o git-merge-one-file -a ||
 		OCTOPUS_FAILURE=1
 		next=$(git write-tree 2>/dev/null)
 	fi
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 07dfeb8..b6d6297 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -107,17 +107,17 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac

-	src1=$(git-unpack-file $2)
-	src2=$(git-unpack-file $3)
+	src1=$(git unpack-file $2)
+	src2=$(git unpack-file $3)
 	case "$1" in
 	'')
 		echo "Added $4 in both, but differently."
-		orig=$(git-unpack-file $2)
+		orig=$(git unpack-file $2)
 		create_virtual_base "$orig" "$src2"
 		;;
 	*)
 		echo "Auto-merging $4"
-		orig=$(git-unpack-file $1)
+		orig=$(git unpack-file $1)
 		;;
 	esac

diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
index c9da747..343fe7b 100755
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -45,7 +45,7 @@ then
 	exit 0
 else
 	echo "Simple merge failed, trying Automatic merge."
-	if git-merge-index -o git-merge-one-file -a
+	if git merge-index -o git-merge-one-file -a
 	then
 		exit 0
 	else
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 0e87e09..baf3041 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -1,6 +1,6 @@
 #!/bin/sh

-# git-ls-remote could be called from outside a git managed repository;
+# git ls-remote could be called from outside a git managed repository;
 # this would fail in that case and would issue an error message.
 GIT_DIR=$(git rev-parse -q --git-dir) || :;

diff --git a/git-pull.sh b/git-pull.sh
index 638aabb..a7c837b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -289,7 +289,7 @@ true)
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
-	eval="git-merge $diffstat $no_commit $verify_signatures $edit
$squash $no_ff $ff_only"
+	eval="git merge $diffstat $no_commit $verify_signatures $edit
$squash $no_ff $ff_only"
 	eval="$eval  $log_arg $strategy_args $merge_args $verbosity $progress"
 	eval="$eval \"\$merge_name\" HEAD $merge_head"
 	;;
diff --git a/git-stash.sh b/git-stash.sh
index bbefdf6..26a699b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -429,7 +429,7 @@ apply_stash () {

 	if test -n "$u_tree"
 	then
-		GIT_INDEX_FILE="$TMPindex" git-read-tree "$u_tree" &&
+		GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
 		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
 		rm -f "$TMPindex" ||
 		die 'Could not restore untracked files from stash'
diff --git a/git-submodule.sh b/git-submodule.sh
index eb58c8e..a9392cf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -162,7 +162,7 @@ die_if_unmatched ()
 # $2 = option name
 # $3 = default value
 #
-# Checks in the usual git-config places first (for overrides),
+# Checks in the usual git config places first (for overrides),
 # otherwise it falls back on .gitmodules.  This allows you to
 # distribute project-wide defaults in .gitmodules, while still
 # customizing individual repositories if necessary.  If the option is
@@ -951,7 +951,7 @@ cmd_summary() {
 			# Always show modules deleted or type-changed (blob<->module)
 			test $status = D -o $status = T && echo "$name" && continue
 			# Also show added or modified modules which are checked out
-			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
+			GIT_DIR="$name/.git" git rev-parse --git-dir >/dev/null 2>&1 &&
 			echo "$name"
 		done
 	)
@@ -985,11 +985,11 @@ cmd_summary() {
 		missing_dst=

 		test $mod_src = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
+		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_src^0 >/dev/null &&
 		missing_src=t

 		test $mod_dst = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
+		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_dst^0 >/dev/null &&
 		missing_dst=t

 		total_commits=
-- 
1.8.3.msysgit.1

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
