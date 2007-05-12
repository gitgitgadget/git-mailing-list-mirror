From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 3/3] Fix assorted white space damage in script files
Date: Sat, 12 May 2007 13:13:36 +0200
Message-ID: <e5bfff550705120413y2aaf5a91n4f428b1480e97320@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 13:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmpXn-0004Ut-WF
	for gcvg-git@gmane.org; Sat, 12 May 2007 13:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131AbXELLNl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 07:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756301AbXELLNl
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 07:13:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:5826 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249AbXELLNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 07:13:39 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1262158wra
        for <git@vger.kernel.org>; Sat, 12 May 2007 04:13:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YfzbguP+FIeErJ0d1H2TZvBjs5SkRbmNyi2UDhfEZSUNr9jAXLKIH9Nywyh6COb2+AjolcO679kOMDnzvDMKJXi7aqjx/MPA9gTiGOaVxiyEX6qlFSIMr+XkvZfN7k5+S8Ek0IaVNLBMivp4xspsUQSEtJcKID+cMkVwUXYtILs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PoO9pE6kVgHlR40fzOxHaxF4BC56p+FIimIXJxJYEBF3BbILlU/4aUL5TgdDBzz+2aZAg+lhbHtwVxSOhNBFYL8HXAJZchi8tHri6F0UFTC/Bl98fSEUU+nrOLNeSuFEc+gQLtHPX6URPW0+vkJUA9j0mJg5mr50rkjDU4AzIEE=
Received: by 10.114.157.1 with SMTP id f1mr207914wae.1178968416932;
        Sat, 12 May 2007 04:13:36 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 12 May 2007 04:13:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47039>

Used the new 'cleanfile' script by H. Peter Anvin, just merged
in Linux tree.

This script cleans up various classes of stealth whitespace.  In
particular, it cleans up:

  - Whitespace (spaces or tabs)before newline;
  - DOS line endings (CR before LF);
  - Space before tab (spaces are deleted or converted to tabs);
  - Empty lines at end of file.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 git-applymbox.sh         |    4 +-
 git-archimport.perl      |  177 +++++++++++++++++++++++-----------------------
 git-checkout.sh          |    4 +-
 git-clean.sh             |    2 +-
 git-clone.sh             |    5 +-
 git-commit.sh            |    2 +-
 git-cvsexportcommit.perl |    2 +-
 git-cvsimport.perl       |   12 ++--
 git-fetch.sh             |    2 +-
 git-merge-one-file.sh    |    2 +-
 git-p4import.py          |    1 -
 git-svn.perl             |    2 +-
 git-svnimport.perl       |    4 +-
 git-tag.sh               |    5 +-
 git-verify-tag.sh        |    1 -
 gitk                     |    2 +-
 16 files changed, 111 insertions(+), 116 deletions(-)

diff --git a/git-applymbox.sh b/git-applymbox.sh
index c18e80f..c51b2ff 100755
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -69,7 +69,7 @@ set x .dotest/0*
 shift
 while case "$#" in 0) break;; esac
 do
-    i="$1"
+    i="$1"
     case "$resume,$continue" in
     f,$i)	resume=t;;
     f,*)	shift
@@ -94,7 +94,7 @@ do
 		;;
 	2)
 		# 2 is a special exit code from applypatch to indicate that
-	    	# the patch wasn't applied, but continue anyway
+		# the patch wasn't applied, but continue anyway
 		;;
 	*)
 		ret=$?
diff --git a/git-archimport.perl b/git-archimport.perl
index c1e7c1d..fee785f 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -3,19 +3,19 @@
 # This tool is copyright (c) 2005, Martin Langhoff.
 # It is released under the Gnu Public License, version 2.
 #
-# The basic idea is to walk the output of tla abrowse,
-# fetch the changesets and apply them.
+# The basic idea is to walk the output of tla abrowse,
+# fetch the changesets and apply them.
 #

 =head1 Invocation

-    git-archimport [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ]
-    	[ -D depth] [ -t tempdir ] <archive>/<branch> [ <archive>/<branch> ]
+    git-archimport [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ]
+	[ -D depth] [ -t tempdir ] <archive>/<branch> [ <archive>/<branch> ]

 Imports a project from one or more Arch repositories. It will follow branches
 and repositories within the namespaces defined by the <archive/branch>
 parameters supplied. If it cannot find the remote branch a merge comes from
-it will just import it as a regular commit. If it can find it, it will mark it
+it will just import it as a regular commit. If it can find it, it will mark it
 as a merge whenever possible.

 See man (1) git-archimport for more details.
@@ -25,14 +25,14 @@ See man (1) git-archimport for more details.
  - create tag objects instead of ref tags
  - audit shell-escaping of filenames
  - hide our private tags somewhere smarter
- - find a way to make "cat *patches | patch" safe even when
patchfiles are missing newlines
+ - find a way to make "cat *patches | patch" safe even when
patchfiles are missing newlines
  - sort and apply patches by graphing ancestry relations instead of just
    relying in dates supplied in the changeset itself.
    tla ancestry-graph -m could be helpful here...

 =head1 Devel tricks

-Add print in front of the shell commands invoked via backticks.
+Add print in front of the shell commands invoked via backticks.

 =head1 Devel Notes

@@ -126,16 +126,16 @@ sub do_abrowse {
     my $stage = shift;
     while (my ($limit, $level) = each %arch_branches) {
         next unless $level == $stage;
-
-	open ABROWSE, "$TLA abrowse -fkD --merges $limit |"
+
+	open ABROWSE, "$TLA abrowse -fkD --merges $limit |"
                                 or die "Problems with tla abrowse: $!";
-
+
         my %ps        = ();         # the current one
         my $lastseen  = '';
-
+
         while (<ABROWSE>) {
             chomp;
-
+
             # first record padded w 8 spaces
             if (s/^\s{8}\b//) {
                 my ($id, $type) = split(m/\s+/, $_, 2);
@@ -147,13 +147,13 @@ sub do_abrowse {
                     push (@psets, \%last_ps);
                     $psets{ $last_ps{id} } = \%last_ps;
                 }
-
+
                 my $branch = extract_versionname($id);
                 %ps = ( id => $id, branch => $branch );
                 if (%last_ps && ($last_ps{branch} eq $branch)) {
                     $ps{parent_id} = $last_ps{id};
                 }
-
+
                 $arch_branches{$branch} = 1;
                 $lastseen = 'id';

@@ -166,16 +166,16 @@ sub do_abrowse {
                     $ps{type} = 't';
                     # read which revision we've tagged when we parse the log
                     $ps{tag}  = $1;
-                } else {
+                } else {
                     warn "Unknown type $type";
                 }

                 $arch_branches{$branch} = 1;
                 $lastseen = 'id';
-            } elsif (s/^\s{10}//) {
-                # 10 leading spaces or more
+            } elsif (s/^\s{10}//) {
+                # 10 leading spaces or more
                 # indicate commit metadata
-
+
                 # date
                 if ($lastseen eq 'id' && m/^(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d)/){
                     $ps{date}   = $1;
@@ -186,12 +186,12 @@ sub do_abrowse {
                 } elsif ($lastseen eq 'merges' && s/^\s{2}//) {
                     my $id = $_;
                     push (@{$ps{merges}}, $id);
-
+
                     # aggressive branch finding:
                     if ($opt_D) {
                         my $branch = extract_versionname($id);
                         my $repo = extract_reponame($branch);
-
+
                         if (archive_reachable($repo) &&
                                 !defined $arch_branches{$branch}) {
                             $arch_branches{$branch} = $stage + 1;
@@ -208,10 +208,10 @@ sub do_abrowse {
             if (@psets && $psets[$#psets]{branch} eq $ps{branch}) {
                 $temp{parent_id} = $psets[$#psets]{id};
             }
-            push (@psets, \%temp);
+            push (@psets, \%temp);
             $psets{ $temp{id} } = \%temp;
-        }
-
+        }
+
         close ABROWSE or die "$TLA abrowse failed on $limit\n";
     }
 }                               # end foreach $root
@@ -253,7 +253,7 @@ unless (-d $git_dir) { # initial import
     while (my $file = readdir(DIR)) {
         # skip non-interesting-files
         next unless -f "$ptag_dir/$file";
-
+
         # convert first '--' to '/' from old git-archimport to use
         # as an archivename/c--b--v private tag
         if ($file !~ m!,!) {
@@ -275,7 +275,7 @@ sub extract_reponame {
     my $fq_cvbr = shift; # archivename/[[[[category]branch]version]revision]
     return (split(/\//, $fq_cvbr))[0];
 }
-
+
 sub extract_versionname {
     my $name = shift;
     $name =~ s/--(?:patch|version(?:fix)?|base)-\d+$//;
@@ -283,7 +283,7 @@ sub extract_versionname {
 }

 # convert a fully-qualified revision or version to a unique dirname:
-#   normalperson@yhbt.net-05/mpd--uclinux--1--patch-2
+#   normalperson@yhbt.net-05/mpd--uclinux--1--patch-2
 # becomes: normalperson@yhbt.net-05,mpd--uclinux--1
 #
 # the git notion of a branch is closer to
@@ -339,7 +339,7 @@ sub git_branchname {

 sub process_patchset_accurate {
     my $ps = shift;
-
+
     # switch to that branch if we're not already in that branch:
     if (-e "$git_dir/refs/heads/$ps->{branch}") {
        system('git-checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
@@ -348,7 +348,7 @@ sub process_patchset_accurate {
        my $rm = safe_pipe_capture('git-ls-files','--others','-z');
        rmtree(split(/\0/,$rm)) if $rm;
     }
-
+
     # Apply the import/changeset/merge into the working tree
     my $dir = sync_to_ps($ps);
     # read the new log entry:
@@ -361,9 +361,9 @@ sub process_patchset_accurate {
     parselog($ps, \@commitlog);

     if ($ps->{id} =~ /--base-0$/ && $ps->{id} ne $psets[0]{id}) {
-        # this should work when importing continuations
+        # this should work when importing continuations
         if ($ps->{tag} && (my $branchpoint = eval { ptag($ps->{tag}) })) {
-
+
             # find where we are supposed to branch from
 	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
 		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
@@ -388,8 +388,8 @@ sub process_patchset_accurate {
         }
         # allow multiple bases/imports here since Arch supports cherry-picks
         # from unrelated trees
-    }
-
+    }
+
     # update the index with all the changes we got
     system('git-diff-files --name-only -z | '.
             'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
@@ -402,7 +402,7 @@ sub process_patchset_accurate {
 # does not handle permissions or any renames involving directories
 sub process_patchset_fast {
     my $ps = shift;
-    #
+    #
     # create the branch if needed
     #
     if ($ps->{type} eq 'i' && !$import) {
@@ -417,9 +417,9 @@ sub process_patchset_fast {
             # new branch! we need to verify a few things
             die "Branch on a non-tag!" unless $ps->{type} eq 't';
             my $branchpoint = ptag($ps->{tag});
-            die "Tagging from unknown id unsupported: $ps->{tag}"
+            die "Tagging from unknown id unsupported: $ps->{tag}"
                 unless $branchpoint;
-
+
             # find where we are supposed to branch from
 	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
 		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
@@ -435,13 +435,13 @@ sub process_patchset_fast {
             }
             system('git-checkout',$ps->{branch}) == 0 or die "$! $?\n";
             return 0;
-        }
+        }
         die $! if $?;
-    }
+    }

     #
     # Apply the import/changeset/merge into the working tree
-    #
+    #
     if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
         apply_import($ps) or die $!;
         $stats{import_or_tag}++;
@@ -455,10 +455,10 @@ sub process_patchset_fast {
     # prepare update git's index, based on what arch knows
     # about the pset, resolve parents, etc
     #
-
-    my @commitlog = safe_pipe_capture($TLA,'cat-archive-log',$ps->{id});
+
+    my @commitlog = safe_pipe_capture($TLA,'cat-archive-log',$ps->{id});
     die "Error in cat-archive-log: $!" if $?;
-
+
     parselog($ps,\@commitlog);

     # imports don't give us good info
@@ -485,10 +485,10 @@ sub process_patchset_fast {
         if (@$ren % 2) {
             die "Odd number of entries in rename!?";
         }
-
+
         while (@$ren) {
             my $from = shift @$ren;
-            my $to   = shift @$ren;
+            my $to   = shift @$ren;

             unless (-d dirname($to)) {
                 mkpath(dirname($to)); # will die on err
@@ -529,20 +529,20 @@ if ($opt_f) {
             "Things may be a bit slow\n";
     *process_patchset = *process_patchset_accurate;
 }
-
+
 foreach my $ps (@psets) {
     # process patchsets
     $ps->{branch} = git_branchname($ps->{id});

     #
-    # ensure we have a clean state
-    #
+    # ensure we have a clean state
+    #
     if (my $dirty = `git-diff-files`) {
         die "Unclean tree when about to process $ps->{id} " .
             " - did we fail to commit cleanly before?\n$dirty";
     }
     die $! if $?;
-
+
     #
     # skip commits already in repo
     #
@@ -559,7 +559,7 @@ foreach my $ps (@psets) {
     my $tree = `git-write-tree`;
     die "cannot write tree $!" if $?;
     chomp $tree;
-
+
     #
     # Who's your daddy?
     #
@@ -570,18 +570,18 @@ foreach my $ps (@psets) {
             close HEAD;
             chomp $p;
             push @par, '-p', $p;
-        } else {
+        } else {
             if ($ps->{type} eq 's') {
                 warn "Could not find the right head for the branch
$ps->{branch}";
             }
         }
     }
-
+
     if ($ps->{merges}) {
         push @par, find_parents($ps);
     }

-    #
+    #
     # Commit, tag and clean state
     #
     $ENV{TZ}                  = 'GMT';
@@ -592,14 +592,14 @@ foreach my $ps (@psets) {
     $ENV{GIT_COMMITTER_EMAIL} = $ps->{email};
     $ENV{GIT_COMMITTER_DATE}  = $ps->{date};

-    my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par)
+    my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par)
         or die $!;
     print WRITER $ps->{summary},"\n\n";
     print WRITER $ps->{message},"\n";
-
+
     # make it easy to backtrack and figure out which Arch revision this was:
     print WRITER 'git-archimport-id: ',$ps->{id},"\n";
-
+
     close WRITER;
     my $commitid = <READER>;    # read
     chomp $commitid;
@@ -611,7 +611,7 @@ foreach my $ps (@psets) {
     }
     #
     # Update the branch
-    #
+    #
     open  HEAD, ">","$git_dir/refs/heads/$ps->{branch}";
     print HEAD $commitid;
     close HEAD;
@@ -640,7 +640,7 @@ exit 0;
 sub sync_to_ps {
     my $ps = shift;
     my $tree_dir = $tmp.'/'.tree_dirname($ps->{id});
-
+
     $opt_v && print "sync_to_ps($ps->{id}) method: ";

     if (-d $tree_dir) {
@@ -674,7 +674,7 @@ sub sync_to_ps {
         safe_pipe_capture($TLA,'get','--no-pristine',$ps->{id},$tree_dir);
         $stats{get_new}++;
     }
-
+
     # added -I flag to rsync since we're going to fast! AIEEEEE!!!!
     system('rsync','-aI','--delete','--exclude',$git_dir,
 #               '--exclude','.arch-inventory',
@@ -691,15 +691,15 @@ sub apply_import {
     mkpath($tmp);

     safe_pipe_capture($TLA,'get','-s','--no-pristine',$ps->{id},"$tmp/import");
-    die "Cannot get import: $!" if $?;
+    die "Cannot get import: $!" if $?;
     system('rsync','-aI','--delete', '--exclude',$git_dir,
 		'--exclude','.arch-ids','--exclude','{arch}',
 		"$tmp/import/", './');
     die "Cannot rsync import:$!" if $?;
-
+
     rmtree("$tmp/import");
     die "Cannot remove tempdir: $!" if $?;
-
+

     return 1;
 }
@@ -712,13 +712,13 @@ sub apply_cset {
     # get the changeset
     safe_pipe_capture($TLA,'get-changeset',$ps->{id},"$tmp/changeset");
     die "Cannot get changeset: $!" if $?;
-
+
     # apply patches
     if (`find $tmp/changeset/patches -type f -name '*.patch'`) {
         # this can be sped up considerably by doing
         #    (find | xargs cat) | patch
         # but that can get mucked up by patches
-        # with missing trailing newlines or the standard
+        # with missing trailing newlines or the standard
         # 'missing newline' flag in the patch - possibly
         # produced with an old/buggy diff.
         # slow and safe, we invoke patch once per patchfile
@@ -741,7 +741,7 @@ sub apply_cset {

     # bring in new files
     system('rsync','-aI','--exclude',$git_dir,
-    		'--exclude','.arch-ids',
+		'--exclude','.arch-ids',
 		'--exclude', '{arch}',
 		"$tmp/changeset/new-files-archive/",'./');

@@ -789,7 +789,7 @@ sub parselog {
         removed_files => 1,
         removed_directories => 1,
     );
-
+
     chomp (@$log);
     while ($_ = shift @$log) {
         if (/^Continuation-of:\s*(.*)/) {
@@ -828,7 +828,7 @@ sub parselog {
             }
         }
     }
-
+
     # drop leading empty lines from the log message
     while (@$log && $log->[0] eq '') {
 	shift @$log;
@@ -842,7 +842,7 @@ sub parselog {
 	$ps->{summary} = $log->[0] . '...';
     }
     $ps->{message} = join("\n",@$log);
-
+
     # skip Arch control files, unescape pika-escaped files
     foreach my $k (keys %want_headers) {
         next unless (defined $ps->{$k});
@@ -867,7 +867,7 @@ sub parselog {
 # write/read a tag
 sub tag {
     my ($tag, $commit) = @_;
-
+
     if ($opt_o) {
         $tag =~ s|/|--|g;
     } else {
@@ -875,7 +875,7 @@ sub tag {
 	$patchname =~ s/.*--//;
         $tag = git_branchname ($tag) . '--' . $patchname;
     }
-
+
     if ($commit) {
         open(C,">","$git_dir/refs/tags/$tag")
             or die "Cannot create tag $tag: $!\n";
@@ -902,8 +902,8 @@ sub ptag {
     my ($tag, $commit) = @_;

     # don't use subdirs for tags yet, it could screw up other porcelains
-    $tag =~ s|/|,|g;
-
+    $tag =~ s|/|,|g;
+
     my $tag_file = "$ptag_dir/$tag";
     my $tag_branch_dir = dirname($tag_file);
     mkpath($tag_branch_dir) unless (-d $tag_branch_dir);
@@ -915,7 +915,7 @@ sub ptag {
             or die "Cannot write tag $tag: $!\n";
         close(C)
             or die "Cannot write tag $tag: $!\n";
-	$rptags{$commit} = $tag
+	$rptags{$commit} = $tag
 	    unless $tag =~ m/--base-0$/;
     } else {                    # read
         # if the tag isn't there, return 0
@@ -941,7 +941,7 @@ sub find_parents {
     # Identify what branches are merging into me
     # and whether we are fully merged
     # git-merge-base <headsha> <headsha> should tell
-    # me what the base of the merge should be
+    # me what the base of the merge should be
     #
     my $ps = shift;

@@ -963,14 +963,14 @@ sub find_parents {
     }

     #
-    # foreach branch find a merge base and walk it to the
+    # foreach branch find a merge base and walk it to the
     # head where we are, collecting the merged patchsets that
     # Arch has recorded. Keep that in @have
     # Compare that with the commits on the other branch
     # between merge-base and the tip of the branch (@need)
     # and see if we have a series of consecutive patches
     # starting from the merge base. The tip of the series
-    # of consecutive patches merged is our new parent for
+    # of consecutive patches merged is our new parent for
     # that branch.
     #
     foreach my $branch (keys %branches) {
@@ -979,13 +979,13 @@ sub find_parents {
 	next unless -e "$git_dir/refs/heads/$branch";

 	my $mergebase = `git-merge-base $branch $ps->{branch}`;
- 	if ($?) {
- 	    # Don't die here, Arch supports one-way cherry-picking
- 	    # between branches with no common base (or any relationship
- 	    # at all beforehand)
- 	    warn "Cannot find merge base for $branch and $ps->{branch}";
- 	    next;
- 	}
+	if ($?) {
+	    # Don't die here, Arch supports one-way cherry-picking
+	    # between branches with no common base (or any relationship
+	    # at all beforehand)
+	    warn "Cannot find merge base for $branch and $ps->{branch}";
+	    next;
+	}
 	chomp $mergebase;

 	# now walk up to the mergepoint collecting what patches we have
@@ -1010,15 +1010,15 @@ sub find_parents {
 	# merge what we have with what ancestors have
 	%have = (%have, %ancestorshave);

-	# see what the remote branch has - these are the merges we
+	# see what the remote branch has - these are the merges we
 	# will want to have in a consecutive series from the mergebase
 	my $otherbranchtip = git_rev_parse($branch);
 	my @needraw = `git-rev-list --topo-order $otherbranchtip ^$mergebase`;
 	my @need;
-	foreach my $needps (@needraw) { 	# get the psets
+	foreach my $needps (@needraw) {		# get the psets
 	    $needps = commitid2pset($needps);
 	    # git-rev-list will also
-	    # list commits merged in via earlier
+	    # list commits merged in via earlier
 	    # merges. we are only interested in commits
 	    # from the branch we're looking at
 	    if ($branch eq $needps->{branch}) {
@@ -1054,7 +1054,7 @@ sub find_parents {
 	next unless ref    $psets{$p}{merges};
 	my @merges = @{$psets{$p}{merges}};
 	foreach my $merge (@merges) {
-	    if ($parents{$merge}) {
+	    if ($parents{$merge}) {
 		delete $parents{$merge};
 	    }
 	}
@@ -1079,10 +1079,10 @@ sub git_rev_parse {
 sub commitid2pset {
     my $commitid = shift;
     chomp $commitid;
-    my $name = $rptags{$commitid}
+    my $name = $rptags{$commitid}
 	|| die "Cannot find reverse tag mapping for $commitid";
     $name =~ s|,|/|;
-    my $ps   = $psets{$name}
+    my $ps   = $psets{$name}
 	|| (print Dumper(sort keys %psets)) && die "Cannot find patchset for $name";
     return $ps;
 }
@@ -1112,7 +1112,7 @@ sub archive_reachable {
     my $archive = shift;
     return 1 if $reachable{$archive};
     return 0 if $unreachable{$archive};
-
+
     if (system "$TLA whereis-archive $archive >/dev/null") {
         if ($opt_a && (system($TLA,'register-archive',
                       "http://mirrors.sourcecontrol.net/$archive") == 0)) {
@@ -1127,4 +1127,3 @@ sub archive_reachable {
         return 1;
     }
 }
-
diff --git a/git-checkout.sh b/git-checkout.sh
index ed7c2c5..1ea4226 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -210,7 +210,7 @@ else
 	esac

 	# Match the index to the working tree, and do a three-way.
-    	git diff-files --name-only | git update-index --remove --stdin &&
+	git diff-files --name-only | git update-index --remove --stdin &&
 	work=`git write-tree` &&
 	git read-tree $v --reset -u $new || exit

@@ -245,7 +245,7 @@ else
     (exit $saved_err)
 fi

-#
+#
 # Switch the HEAD pointer to the new branch if we
 # checked out a branch head, and remove any potential
 # old MERGE_HEAD's (subsequent commits will clearly not
diff --git a/git-clean.sh b/git-clean.sh
index 299309d..538d2f6 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -7,7 +7,7 @@ USAGE="[-d] [-f] [-n] [-q] [-x | -X] [--] <paths>..."
 LONG_USAGE='Clean untracked files from the working directory
 	-d	remove directories as well
 	-f	override clean.requireForce and clean anyway
-	-n 	don'\''t remove anything, just show what would be done
+	-n	don'\''t remove anything, just show what would be done
 	-q	be quiet, only report errors
 	-x	remove ignored files as well
 	-X	remove only ignored files
diff --git a/git-clone.sh b/git-clone.sh
index 70374aa..69ccd38 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2005, Linus Torvalds
 # Copyright (c) 2005, Junio C Hamano
-#
+#
 # Clone a repository into a different directory that does not yet exist.

 # See git-sh-setup why.
@@ -98,7 +98,7 @@ while
 	*,--na|*,--nak|*,--nake|*,--naked|\
 	*,-b|*,--b|*,--ba|*,--bar|*,--bare) bare=yes ;;
 	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
-        *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared)
+        *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared)
           local_shared=yes; use_local=yes ;;
 	1,--template) usage ;;
 	*,--template)
@@ -410,4 +410,3 @@ fi
 rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"

 trap - 0
-
diff --git a/git-commit.sh b/git-commit.sh
index f28fc24..5b560f9 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -557,7 +557,7 @@ then
 	} >>"$GIT_DIR"/COMMIT_EDITMSG
 else
 	# we need to check if there is anything to commit
-	run_status >/dev/null
+	run_status >/dev/null
 fi
 if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
 then
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 6ed4719..272a435 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -176,7 +176,7 @@ foreach my $f (@afiles) {
     if (@status > 1) { warn 'Strange! cvs status returned more than
one line?'};
     if (-d dirname $f and $status[0] !~ m/Status: Unknown$/
 	and $status[0] !~ m/^File: no file /) {
- 	$dirty = 1;
+	$dirty = 1;
 	warn "File $f is already known in your CVS checkout -- perhaps it
has been added by another user. Or this may indicate that it exists on
a different branch. If this is the case, use -f to force the
merge.\n";
 	warn "Status was: $status[0]\n";
     }
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index ac74bc5..d41eace 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -145,7 +145,7 @@ my $cvs_tree;
 if ($#ARGV == 0) {
 	$cvs_tree = $ARGV[0];
 } elsif (-f 'CVS/Repository') {
-	open my $f, '<', 'CVS/Repository' or
+	open my $f, '<', 'CVS/Repository' or
 	    die 'Failed to open CVS/Repository';
 	$cvs_tree = <$f>;
 	chomp $cvs_tree;
@@ -434,7 +434,7 @@ sub file {
 	my ($self,$fn,$rev) = @_;
 	my $res;

-	my ($fh, $name) = tempfile('gitcvs.XXXXXX',
+	my ($fh, $name) = tempfile('gitcvs.XXXXXX',
 		    DIR => File::Spec->tmpdir(), UNLINK => 1);

 	$self->_file($fn,$rev) and $res = $self->_line($fh);
@@ -520,8 +520,8 @@ sub is_sha1 {

 sub get_headref ($$) {
     my $name    = shift;
-    my $git_dir = shift;
-
+    my $git_dir = shift;
+
     my $f = "$git_dir/refs/heads/$name";
     if (open(my $fh, $f)) {
 	    chomp(my $r = <$fh>);
@@ -771,7 +771,7 @@ sub commit {
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
-		
+
 		my $pid = open2($in, $out, 'git-mktag');
 		print $out "object $cid\n".
 		    "type commit\n".
@@ -788,7 +788,7 @@ sub commit {
 		     $? != 0 or $tagobj !~ /^[0123456789abcdef]{40}$/ ) {
 		    die "Cannot create tag object $xtag: $!\n";
 	        }
-		
+

 		open(C,">$git_dir/refs/tags/$xtag")
 			or die "Cannot create tag $xtag: $!\n";
diff --git a/git-fetch.sh b/git-fetch.sh
index 0e05cf1..85145ad 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -167,7 +167,7 @@ fetch_all_at_once () {
   eval "$eval"

     ( : subshell because we muck with IFS
-      IFS=" 	$LF"
+      IFS="	$LF"
       (
 	if test "$remote" = . ; then
 	    git-show-ref $rref || echo failed "$remote"
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 7d62d79..254d210 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -88,7 +88,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		# remove lines that are unique to ours.
 		orig=`git-unpack-file $2`
 		sz0=`wc -c <"$orig"`
-		diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add
+		diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add
 		sz1=`wc -c <"$orig"`

 		# If we do not have enough common material, it is not
diff --git a/git-p4import.py b/git-p4import.py
index 60a758b..0f3d97b 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -358,4 +358,3 @@ for id in changes:
     if stitch == 1:
         git.clean_directories()
         stitch = 0
-
diff --git a/git-svn.perl b/git-svn.perl
index 3c4f490..bb2d400 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3985,7 +3985,7 @@ diff-index line ($m hash)
 $l_map = {
 	# repository root url
 	'https://svn.musicpd.org' => {
-		# repository path 		# GIT_SVN_ID
+		# repository path		# GIT_SVN_ID
 		'mpd/trunk'		=>	'trunk',
 		'mpd/tags/0.11.5'	=>	'tags/0.11.5',
 	},
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 3af8c7e..f459762 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -542,7 +542,7 @@ sub copy_path($$$$$$$$) {
 	if ($node_kind eq $SVN::Node::dir) {
 		$srcpath =~ s#/*$#/#;
 	}
-	
+
 	my $pid = open my $f,'-|';
 	die $! unless defined $pid;
 	if (!$pid) {
@@ -560,7 +560,7 @@ sub copy_path($$$$$$$$) {
 		} else {
 			$p = $path;
 		}
-		push(@$new,[$mode,$sha1,$p]);	
+		push(@$new,[$mode,$sha1,$p]);
 	}
 	close($f) or
 		print STDERR "$newrev:$newbranch: could not list files in $oldpath
\@ $rev\n";
diff --git a/git-tag.sh b/git-tag.sh
index 4a0a7b6..3f080bf 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -36,7 +36,7 @@ do
 	exit $?
 	;;
     -m)
-    	annotate=1
+	annotate=1
 	shift
 	message="$1"
 	if test "$#" = "0"; then
@@ -62,7 +62,7 @@ do
 	username="$1"
 	;;
     -d)
-    	shift
+	shift
 	had_error=0
 	for tag
 	do
@@ -150,4 +150,3 @@ if [ "$annotate" ]; then
 fi

 git update-ref "refs/tags/$name" "$object" "$prev"
-
diff --git a/git-verify-tag.sh b/git-verify-tag.sh
index 8db7dd0..f2d5597 100755
--- a/git-verify-tag.sh
+++ b/git-verify-tag.sh
@@ -42,4 +42,3 @@ cat "$GIT_DIR/.tmp-vtag" |
 sed '/-----BEGIN PGP/Q' |
 gpg --verify "$GIT_DIR/.tmp-vtag" - || exit 1
 rm -f "$GIT_DIR/.tmp-vtag"
-
diff --git a/gitk b/gitk
index a57e84c..87c3690 100755
--- a/gitk
+++ b/gitk
@@ -337,7 +337,7 @@ proc readrefs {} {
 		    set tagids($name) $commit
 		    lappend idtags($commit) $name
 		}
-	    }		
+	    }
 	    catch {
 	        set tagcontents($name) [exec git cat-file tag $id]
 	    }
-- 
1.5.2.rc3
