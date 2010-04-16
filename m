From: jari.aalto@cante.net
Subject: [PATCH] git-cvsserver.perl: encourage use of English module and qx() operator
Date: Fri, 16 Apr 2010 19:32:45 +0300
Organization: Private
Message-ID: <1271435565-32370-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 18:33:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2oTU-0006k4-Ag
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab0DPQcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 12:32:53 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:44846 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab0DPQcv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:32:51 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 69EFD8C592
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 19:32:50 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0126165F1C; Fri, 16 Apr 2010 19:32:50 +0300
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id D9A5A4046
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 19:32:48 +0300 (EEST)
Received: from mx2.cante.net ([192.168.1.7] helo=jondo.cante.net)
	by picasso.cante.net with esmtp (Exim 4.71)
	(envelope-from <jari.aalto@cante.net>)
	id 1O2oTF-00069X-UW; Fri, 16 Apr 2010 19:32:45 +0300
X-Mailer: git-send-email 1.7.0
X-SA-Exim-Connect-IP: 192.168.1.7
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145071>

From: Jari Aalto <jari.aalto@cante.net>

Substitute magic variables $<puctuation> with the English.pm
equivalents for readability. Likewise substitute backtics with the
alternative qx() for system calls.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-cvsserver.perl |  151 ++++++++++++++++++++++++++--------------------=
------
 1 files changed, 76 insertions(+), 75 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13751db..0efe8bc 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -19,6 +19,7 @@ use strict;
 use warnings;
 use bytes;
=20
+use English qw( -no_match_vars );
 use Fcntl;
 use File::Temp qw/tempdir tempfile/;
 use File::Path qw/rmtree/;
@@ -46,7 +47,7 @@ my $DATE_LIST =3D {
 };
=20
 # Enable autoflush for STDOUT (otherwise the whole thing falls apart)
-$| =3D 1;
+$OUTPUT_AUTOFLUSH =3D 1;
=20
 #### Definition and mappings of functions ####
=20
@@ -214,8 +215,8 @@ while (<STDIN>)
         # we're fairly screwed because we don't know if the client is ex=
pecting
         # a response. If it is, the client will hang, we'll hang, and th=
e whole
         # thing will be custard.
-        $log->fatal("Don't understand command $_\n");
-        die("Unknown command $_");
+        $log->fatal("Don't understand command $ARG\n");
+        die("Unknown command $ARG");
     }
 }
=20
@@ -305,8 +306,8 @@ sub req_Root
        return 0;
     }
=20
-    my @gitvars =3D `git config -l`;
-    if ($?) {
+    my @gitvars =3D qx( git config -l );
+    if ($CHILD_ERROR) {
        print "E problems executing git-config on the server -- this is n=
ot a git repository or the PATH is not set correctly.\n";
         print "E \n";
         print "error 1 - problem executing git-config\n";
@@ -538,19 +539,19 @@ sub req_add
=20
         unless ( defined ( $state->{entries}{$filename}{modified_filenam=
e} ) )
         {
-            print "E cvs add: nothing known about `$filename'\n";
+            print "E cvs add: nothing known about '$filename'\n";
             next;
         }
         # TODO : check we're not squashing an already existing file
         if ( defined ( $state->{entries}{$filename}{revision} ) )
         {
-            print "E cvs add: `$filename' has already been entered\n";
+            print "E cvs add: '$filename' has already been entered\n";
             next;
         }
=20
         my ( $filepart, $dirpart ) =3D filenamesplit($filename, 1);
=20
-        print "E cvs add: scheduling file `$filename' for addition\n";
+        print "E cvs add: scheduling file '$filename' for addition\n";
=20
         print "Checked-in $dirpart\n";
         print "$filename\n";
@@ -579,11 +580,11 @@ sub req_add
=20
     if ( $addcount =3D=3D 1 )
     {
-        print "E cvs add: use `cvs commit' to add this file permanently\=
n";
+        print "E cvs add: use 'cvs commit' to add this file permanently\=
n";
     }
     elsif ( $addcount > 1 )
     {
-        print "E cvs add: use `cvs commit' to add these files permanentl=
y\n";
+        print "E cvs add: use 'cvs commit' to add these files permanentl=
y\n";
     }
=20
     print "ok\n";
@@ -620,7 +621,7 @@ sub req_remove
=20
         if ( defined ( $state->{entries}{$filename}{unchanged} ) or defi=
ned ( $state->{entries}{$filename}{modified_filename} ) )
         {
-            print "E cvs remove: file `$filename' still in working direc=
tory\n";
+            print "E cvs remove: file '$filename' still in working direc=
tory\n";
             next;
         }
=20
@@ -629,27 +630,27 @@ sub req_remove
=20
         unless ( defined ( $wrev ) )
         {
-            print "E cvs remove: nothing known about `$filename'\n";
+            print "E cvs remove: nothing known about '$filename'\n";
             next;
         }
=20
         if ( defined($wrev) and $wrev < 0 )
         {
-            print "E cvs remove: file `$filename' already scheduled for =
removal\n";
+            print "E cvs remove: file '$filename' already scheduled for =
removal\n";
             next;
         }
=20
         unless ( $wrev =3D=3D $meta->{revision} )
         {
             # TODO : not sure if the format of this message is quite cor=
rect.
-            print "E cvs remove: Up to date check failed for `$filename'=
\n";
+            print "E cvs remove: Up to date check failed for '$filename'=
\n";
             next;
         }
=20
=20
         my ( $filepart, $dirpart ) =3D filenamesplit($filename, 1);
=20
-        print "E cvs remove: scheduling `$filename' for removal\n";
+        print "E cvs remove: scheduling '$filename' for removal\n";
=20
         print "Checked-in $dirpart\n";
         print "$filename\n";
@@ -661,11 +662,11 @@ sub req_remove
=20
     if ( $rmcount =3D=3D 1 )
     {
-        print "E cvs remove: use `cvs commit' to remove this file perman=
ently\n";
+        print "E cvs remove: use 'cvs commit' to remove this file perman=
ently\n";
     }
     elsif ( $rmcount > 1 )
     {
-        print "E cvs remove: use `cvs commit' to remove these files perm=
anently\n";
+        print "E cvs remove: use 'cvs commit' to remove these files perm=
anently\n";
     }
=20
     print "ok\n";
@@ -709,7 +710,7 @@ sub req_Modified
     }
=20
     close $fh
-        or (print "E failed to write temporary, $filename: $!\n"), retur=
n;
+        or (print "E failed to write temporary, $filename: $ERRNO\n"), r=
eturn;
=20
     # Ensure we have something sensible for the file mode
     if ( $mode =3D~ /u=3D(\w+)/ )
@@ -722,7 +723,7 @@ sub req_Modified
     # Save the file data in $state
     $state->{entries}{$state->{directory}.$data}{modified_filename} =3D =
$filename;
     $state->{entries}{$state->{directory}.$data}{modified_mode} =3D $mod=
e;
-    $state->{entries}{$state->{directory}.$data}{modified_hash} =3D `git=
 hash-object $filename`;
+    $state->{entries}{$state->{directory}.$data}{modified_hash} =3D qx( =
git hash-object $filename );
     $state->{entries}{$state->{directory}.$data}{modified_hash} =3D~ s/\=
s.*$//s;
=20
     #$log->debug("req_Modified : file=3D$data mode=3D$mode size=3D$size"=
);
@@ -824,7 +825,7 @@ sub req_co
=20
     # Provide list of modules, if -c was used.
     if (exists $state->{opt}{c}) {
-        my $showref =3D `git show-ref --heads`;
+        my $showref =3D qx( git show-ref --heads );
         for my $line (split '\n', $showref) {
             if ( $line =3D~ m% refs/heads/(.*)$% ) {
                 print "M $1\t$1\n";
@@ -980,11 +981,11 @@ sub req_update
     # projects (heads in this case) to checkout.
     #
     if ($state->{module} eq '') {
-        my $showref =3D `git show-ref --heads`;
+        my $showref =3D qx( git show-ref --heads );
         print "E cvs update: Updating .\n";
         for my $line (split '\n', $showref) {
             if ( $line =3D~ m% refs/heads/(.*)$% ) {
-                print "E cvs update: New directory `$1'\n";
+                print "E cvs update: New directory '$1'\n";
             }
         }
         print "ok\n";
@@ -1101,7 +1102,7 @@ sub req_update
=20
             $log->info("Removing '$filename' from working copy (no longe=
r in the repo)");
=20
-            print "E cvs update: `$filename' is no longer in the reposit=
ory\n";
+            print "E cvs update: '$filename' is no longer in the reposit=
ory\n";
             # Don't want to actually _DO_ the update if -n specified
             unless ( $state->{globaloptions}{-n} ) {
 		print "Removed $dirpart\n";
@@ -1249,7 +1250,7 @@ sub req_update
                 # transmit file, format is single integer on a line by i=
tself (file
                 # size) followed by the file contents
                 # TODO : we should copy files in blocks
-                my $data =3D `cat $mergedFile`;
+                my $data =3D qx( cat $mergedFile );
                 $log->debug("File size : " . length($data));
                 print length($data) . "\n";
                 print $data;
@@ -1291,7 +1292,7 @@ sub req_ci
     $updater->update();
=20
     # Remember where the head was at the beginning.
-    my $parenthash =3D `git show-ref -s refs/heads/$state->{module}`;
+    my $parenthash =3D qx( git show-ref -s refs/heads/$state->{module} )=
;
     chomp $parenthash;
     if ($parenthash !~ /^[0-9a-f]{40}$/) {
 	    print "error 1 pserver cannot find the current HEAD of module";
@@ -1303,7 +1304,7 @@ sub req_ci
=20
     $log->info("Lockless commit start, basing commit on '$work->{workDir=
}', index file is '$work->{index}'");
=20
-    $log->info("Created index '$work->{index}' for head $state->{module}=
 - exit status $?");
+    $log->info("Created index '$work->{index}' for head $state->{module}=
 - exit status $CHILD_ERROR");
=20
     my @committedfiles =3D ();
     my %oldmeta;
@@ -1326,8 +1327,8 @@ sub req_ci
 	# do a checkout of the file if it is part of this tree
         if ($wrev) {
             system('git', 'checkout-index', '-f', '-u', $filename);
-            unless ($? =3D=3D 0) {
-                die "Error running git-checkout-index -f -u $filename : =
$!";
+            unless ($CHILD_ERROR =3D=3D 0) {
+                die "Error running git-checkout-index -f -u $filename : =
$ERRNO";
             }
         }
=20
@@ -1357,7 +1358,7 @@ sub req_ci
=20
             # Calculate modes to remove
             my $invmode =3D "";
-            foreach ( qw (r w x) ) { $invmode .=3D $_ unless ( $state->{=
entries}{$filename}{modified_mode} =3D~ /$_/ ); }
+            foreach ( qw (r w x) ) { $invmode .=3D $ARG unless ( $state-=
>{entries}{$filename}{modified_mode} =3D~ /$ARG/ ); }
=20
             $log->debug("chmod u+" . $state->{entries}{$filename}{modifi=
ed_mode} . "-" . $invmode . " $filename");
             system("chmod","u+" .  $state->{entries}{$filename}{modified=
_mode} . "-" . $invmode, $filename);
@@ -1387,7 +1388,7 @@ sub req_ci
         return;
     }
=20
-    my $treehash =3D `git write-tree`;
+    my $treehash =3D qx( git write-tree );
     chomp $treehash;
=20
     $log->debug("Treehash : $treehash, Parenthash : $parenthash");
@@ -1404,7 +1405,7 @@ sub req_ci
     }
     close $msg_fh;
=20
-    my $commithash =3D `git commit-tree $treehash -p $parenthash < $msg_=
filename`;
+    my $commithash =3D qx( git commit-tree $treehash -p $parenthash < $m=
sg_filename );
     chomp($commithash);
     $log->info("Commit hash : $commithash");
=20
@@ -1441,13 +1442,13 @@ sub req_ci
 	### Emulate git-receive-pack by running hooks/post-receive
 	my $hook =3D $ENV{GIT_DIR}.'hooks/post-receive';
 	if( -x $hook ) {
-		open(my $pipe, "| $hook") || die "can't fork $!";
+		open(my $pipe, "| $hook") || die "can't fork $ERRNO";
=20
 		local $SIG{PIPE} =3D sub { die 'pipe broke' };
=20
 		print $pipe "$parenthash $commithash refs/heads/$state->{module}\n";
=20
-		close $pipe || die "bad pipe: $! $?";
+		close $pipe || die "bad pipe: $ERRNO $CHILD_ERROR";
 	}
=20
     $updater->update();
@@ -1723,7 +1724,7 @@ sub req_diff
=20
         while ( <$fh> )
         {
-            print "M $_";
+            print "M $ARG";
         }
         close $fh;
     }
@@ -1858,17 +1859,17 @@ sub req_annotate
 	# to look up the commithash in sqlite (still good to default to
 	# the current head as we do now)
 	system("git", "read-tree", $lastseenin);
-	unless ($? =3D=3D 0)
+	unless ($CHILD_ERROR =3D=3D 0)
 	{
-	    print "E error running git-read-tree $lastseenin $ENV{GIT_INDEX_FIL=
E} $!\n";
+	    print "E error running git-read-tree $lastseenin $ENV{GIT_INDEX_FIL=
E} $ERRNO\n";
 	    return;
 	}
-	$log->info("Created index '$ENV{GIT_INDEX_FILE}' with commit $lastseeni=
n - exit status $?");
+	$log->info("Created index '$ENV{GIT_INDEX_FILE}' with commit $lastseeni=
n - exit status $CHILD_ERROR");
=20
         # do a checkout of the file
         system('git', 'checkout-index', '-f', '-u', $filename);
-        unless ($? =3D=3D 0) {
-            print "E error running git-checkout-index -f -u $filename : =
$!\n";
+        unless ($CHILD_ERROR =3D=3D 0) {
+            print "E error running git-checkout-index -f -u $filename : =
$ERRNO\n";
             return;
         }
=20
@@ -1881,7 +1882,7 @@ sub req_annotate
=20
         my $a_hints =3D "$work->{workDir}/.annotate_hints";
         if (!open(ANNOTATEHINTS, '>', $a_hints)) {
-            print "E failed to open '$a_hints' for writing: $!\n";
+            print "E failed to open '$a_hints' for writing: $ERRNO\n";
             return;
         }
         for (my $i=3D0; $i < @$revisions; $i++)
@@ -1895,11 +1896,11 @@ sub req_annotate
=20
         print ANNOTATEHINTS "\n";
         close ANNOTATEHINTS
-            or (print "E failed to write $a_hints: $!\n"), return;
+            or (print "E failed to write $a_hints: $ERRNO\n"), return;
=20
         my @cmd =3D (qw(git annotate -l -S), $a_hints, $filename);
         if (!open(ANNOTATE, "-|", @cmd)) {
-            print "E error invoking ". join(' ',@cmd) .": $!\n";
+            print "E error invoking ". join(' ',@cmd) .": $ERRNO\n";
             return;
         }
         my $metadata =3D {};
@@ -1924,7 +1925,7 @@ sub req_annotate
                     $data
                 );
             } else {
-                $log->warn("Error in annotate output! LINE: $_");
+                $log->warn("Error in annotate output! LINE: $ARG");
                 print "E Annotate error \n";
                 next;
             }
@@ -2114,12 +2115,12 @@ sub transmitfile
=20
     die "Need filehash" unless ( defined ( $filehash ) and $filehash =3D=
~ /^[a-zA-Z0-9]{40}$/ );
=20
-    my $type =3D `git cat-file -t $filehash`;
+    my $type =3D qx( git cat-file -t $filehash );
     chomp $type;
=20
     die ( "Invalid type '$type' (expected 'blob')" ) unless ( defined ( =
$type ) and $type eq "blob" );
=20
-    my $size =3D `git cat-file -s $filehash`;
+    my $size =3D qx( git cat-file -s $filehash );
     chomp $size;
=20
     $log->debug("transmitfile($filehash) size=3D$size, type=3D$type");
@@ -2129,22 +2130,22 @@ sub transmitfile
         if ( defined ( $options->{targetfile} ) )
         {
             my $targetfile =3D $options->{targetfile};
-            open NEWFILE, ">", $targetfile or die("Couldn't open '$targe=
tfile' for writing : $!");
-            print NEWFILE $_ while ( <$fh> );
-            close NEWFILE or die("Failed to write '$targetfile': $!");
+            open NEWFILE, ">", $targetfile or die("Couldn't open '$targe=
tfile' for writing : $ERRNO");
+            print NEWFILE $ARG while ( <$fh> );
+            close NEWFILE or die("Failed to write '$targetfile': $ERRNO"=
);
         } elsif ( defined ( $options->{print} ) && $options->{print} ) {
             while ( <$fh> ) {
                 if( /\n\z/ ) {
-                    print 'M ', $_;
+                    print 'M ', $ARG;
                 } else {
-                    print 'MT text ', $_, "\n";
+                    print 'MT text ', $ARG, "\n";
                 }
             }
         } else {
             print "$size\n";
             print while ( <$fh> );
         }
-        close $fh or die ("Couldn't close filehandle for transmitfile():=
 $!");
+        close $fh or die ("Couldn't close filehandle for transmitfile():=
 $ERRNO");
     } else {
         die("Couldn't execute git-cat-file");
     }
@@ -2238,10 +2239,10 @@ sub setupWorkTree
     if($ver)
     {
         system("git","read-tree",$ver);
-        unless ($? =3D=3D 0)
+        unless ($CHILD_ERROR =3D=3D 0)
         {
             $log->warn("Error running git-read-tree");
-            die "Error running git-read-tree $ver in $work->{workDir} $!=
\n";
+            die "Error running git-read-tree $ver in $work->{workDir} $E=
RRNO\n";
         }
     }
     # else # req_annotate reads tree for each file
@@ -2272,7 +2273,7 @@ sub ensureWorkTree
     chdir $work->{emptyDir} or
         die "Unable to chdir to $work->{emptyDir}\n";
=20
-    my $ver =3D `git show-ref -s refs/heads/$state->{module}`;
+    my $ver =3D qx( git show-ref -s refs/heads/$state->{module} );
     chomp $ver;
     if ($ver !~ /^[0-9a-f]{40}$/)
     {
@@ -2292,9 +2293,9 @@ sub ensureWorkTree
     $work->{state} =3D 1;
=20
     system("git","read-tree",$ver);
-    unless ($? =3D=3D 0)
+    unless ($CHILD_ERROR =3D=3D 0)
     {
-        die "Error running git-read-tree $ver $!\n";
+        die "Error running git-read-tree $ver $ERRNO\n";
     }
 }
=20
@@ -2530,8 +2531,8 @@ sub open_blob_or_die
     {
         if( !open $fh,"<",$name )
         {
-            $log->warn("Unable to open file $name: $!");
-            die "Unable to open file $name: $!\n";
+            $log->warn("Unable to open file $name: $ERRNO");
+            die "Unable to open file $name: $ERRNO\n";
         }
     }
     elsif( $srcType eq "sha1" || $srcType eq "sha1Or-k" )
@@ -2542,7 +2543,7 @@ sub open_blob_or_die
             die "Need filehash\n";
         }
=20
-        my $type =3D `git cat-file -t $name`;
+        my $type =3D qx( git cat-file -t $name );
         chomp $type;
=20
         unless ( defined ( $type ) and $type eq "blob" )
@@ -2551,7 +2552,7 @@ sub open_blob_or_die
             die ( "Invalid type '$type' (expected 'blob')" )
         }
=20
-        my $size =3D `git cat-file -s $name`;
+        my $size =3D qx( git cat-file -s $name );
         chomp $size;
=20
         $log->debug("open_blob_or_die($name) size=3D$size, type=3D$type"=
);
@@ -2634,7 +2635,7 @@ sub new
=20
     if ( defined ( $filename ) )
     {
-        open $self->{fh}, ">>", $filename or die("Couldn't open '$filena=
me' for writing : $!");
+        open $self->{fh}, ">>", $filename or die("Couldn't open '$filena=
me' for writing : $ERRNO");
     }
=20
     return $self;
@@ -2654,7 +2655,7 @@ sub setfile
=20
     if ( defined ( $filename ) )
     {
-        open $self->{fh}, ">>", $filename or die("Couldn't open '$filena=
me' for writing : $!");
+        open $self->{fh}, ">>", $filename or die("Couldn't open '$filena=
me' for writing : $ERRNO");
     }
=20
     return unless ( defined ( $self->{buffer} ) and ref $self->{buffer} =
eq "ARRAY" );
@@ -2940,10 +2941,10 @@ sub update
     # first lets get the commit list
     $ENV{GIT_DIR} =3D $self->{git_path};
=20
-    my $commitsha1 =3D `git rev-parse $self->{module}`;
+    my $commitsha1 =3D qx( git rev-parse $self->{module} );
     chomp $commitsha1;
=20
-    my $commitinfo =3D `git cat-file commit $self->{module} 2>&1`;
+    my $commitinfo =3D qx( git cat-file commit $self->{module} 2>&1 );
     unless ( $commitinfo =3D~ /tree\s+[a-zA-Z0-9]{40}/ )
     {
         die("Invalid module '$self->{module}'");
@@ -2971,7 +2972,7 @@ sub update
         push @git_log_params, $self->{module};
     }
     # git-rev-list is the backend / plumbing version of git-log
-    open(GITLOG, '-|', 'git', 'rev-list', @git_log_params) or die "Canno=
t call git-rev-list: $!";
+    open(GITLOG, '-|', 'git', 'rev-list', @git_log_params) or die "Canno=
t call git-rev-list: $ERRNO";
=20
     my @commits;
=20
@@ -3004,7 +3005,7 @@ sub update
                 next;
             }
             s/^\s+//; s/\s+$//; # trim ws
-            $commit{message} .=3D $_ . "\n";
+            $commit{message} .=3D $ARG . "\n";
         }
     }
     close GITLOG;
@@ -3063,14 +3064,14 @@ sub update
 		    # The two branches may not be related at all,
 		    # in which case merge base simply fails to find
 		    # any, but that's Ok.
-		    next if ($@);
+		    next if ($EVAL_ERROR);
=20
                     chomp $base;
                     if ($base) {
                         my @merged;
                         # print "want to log between  $base $parent \n";
                         open(GITLOG, '-|', 'git', 'log', '--pretty=3Dmed=
ium', "$base..$parent")
-			  or die "Cannot call git-log: $!";
+			  or die "Cannot call git-log: $ERRNO";
                         my $mergedhash;
                         while (<GITLOG>) {
                             chomp;
@@ -3111,14 +3112,14 @@ sub update
=20
         if ( defined ( $lastpicked ) )
         {
-            my $filepipe =3D open(FILELIST, '-|', 'git', 'diff-tree', '-=
z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree=
 : $!");
+            my $filepipe =3D open(FILELIST, '-|', 'git', 'diff-tree', '-=
z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree=
 : $ERRNO");
 	    local ($/) =3D "\0";
             while ( <FILELIST> )
             {
 		chomp;
                 unless ( /^:\d{6}\s+\d{3}(\d)\d{2}\s+[a-zA-Z0-9]{40}\s+(=
[a-zA-Z0-9]{40})\s+(\w)$/o )
                 {
-                    die("Couldn't process git-diff-tree line : $_");
+                    die("Couldn't process git-diff-tree line : $ARG");
                 }
 		my ($mode, $hash, $change) =3D ($1, $2, $3);
 		my $name =3D <FILELIST>;
@@ -3185,14 +3186,14 @@ sub update
             # this is used to detect files removed from the repo
             my $seen_files =3D {};
=20
-            my $filepipe =3D open(FILELIST, '-|', 'git', 'ls-tree', '-z'=
, '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
+            my $filepipe =3D open(FILELIST, '-|', 'git', 'ls-tree', '-z'=
, '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $ERRNO");
 	    local $/ =3D "\0";
             while ( <FILELIST> )
             {
 		chomp;
                 unless ( /^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
                 {
-                    die("Couldn't process git-ls-tree line : $_");
+                    die("Couldn't process git-ls-tree line : $ARG");
                 }
=20
                 my ( $git_perms, $git_type, $git_hash, $git_filename ) =3D=
 ( $1, $2, $3, $4 );
@@ -3556,7 +3557,7 @@ sub in_array
=20
 =3Dhead2 safe_pipe_capture
=20
-an alternative to `command` that allows input to be passed as an array
+an alternative to qx(command) that allows input to be passed as an array
 to work around shell problems with weird characters in arguments
=20
 =3Dcut
@@ -3566,9 +3567,9 @@ sub safe_pipe_capture {
=20
     if (my $pid =3D open my $child, '-|') {
         @output =3D (<$child>);
-        close $child or die join(' ',@_).": $! $?";
+        close $child or die join(' ',@_).": $ERRNO $CHILD_ERROR";
     } else {
-        exec(@_) or die "$! $?"; # exec() can fail the executable can't =
be found
+        exec(@_) or die "$ERRNO $CHILD_ERROR"; # exec() can fail the exe=
cutable can't be found
     }
     return wantarray ? @output : join('',@output);
 }
--=20
1.7.0
