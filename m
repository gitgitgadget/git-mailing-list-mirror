From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: cvs2git with modules?
Date: Tue, 17 Jun 2008 11:02:32 -0700
Message-ID: <7f9d599f0806171102w561ae5bfw594a3bc46eb9c8c1@mail.gmail.com>
References: <63BEA5E623E09F4D92233FB12A9F794302389A59@emailmn.mqsoftware.com>
	 <4857DC0C.8060902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kelly F. Hickel" <kfh@mqsoftware.com>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 17 20:03:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8fWk-0005Og-3I
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 20:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbYFQSCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755535AbYFQSCe
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 14:02:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:19768 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbYFQSCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 14:02:33 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3495708wri.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=M5Q3O9qT3yzsQ/slGrM0LeziT4pKEpJzEk4MlG2T33U=;
        b=Ypr0MmUBgJZARxnsgFHFGDC+Eo+oM2v2JQI2JT3Fx84eaFUf6p8hodMlfj10+GvLCO
         VfuC9EaJj0psxilJNiTNVxo0pVeoAp0FBn/nLEdqNnuzC819IVmXgWFnYWYM9OeIQlf7
         /sBY80Yo+jikyM1RanKQSRwUb4xnjt0q0uBIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=OIyN/tPClMca6s7x/vlmp95ooHowZxWMzm5PXY3ypH4h0U1BvcRHZzqRNYu/5X8gGN
         JMnPey2O7Ghm/3Tqad+wAO0QgVbVL0Gk1qmzJV8bZAqTwS1v3Fc2NYtEfYn6GOhDiLfI
         0PGczslCmfRdhg09rr11nY7yDdU2+Ffe43QN8=
Received: by 10.90.54.11 with SMTP id c11mr4882329aga.82.1213725752382;
        Tue, 17 Jun 2008 11:02:32 -0700 (PDT)
Received: by 10.90.97.4 with HTTP; Tue, 17 Jun 2008 11:02:32 -0700 (PDT)
In-Reply-To: <4857DC0C.8060902@alum.mit.edu>
Content-Disposition: inline
X-Google-Sender-Auth: 0c7eaf4fe764dbd9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85315>

On Tue, Jun 17, 2008 at 8:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> [I see you sent essentially the same question to both the git and the
> cvs2svn mailing lists.  I am replying on the git list with bcc to the
> cvs2svn list.  Followups please to git@vger.kernel.org.]
>
> Kelly F. Hickel wrote:
>> I'm trying to use cvs2svn in cvs2git mode to convert a repo with a
>> number of modules.  Can anyone tell me how to keep that module
>> structure in the new git repo? So, if in cvs there are two modules,
>> ModA and ModB, I want to see those two as top level directories in
>> the git repo.
>>
>> I've tried putting adding the projects in my options file as below,
>> but it puts the files ModA/* and ModB/* at the top level in the git repo.
>>
>> run_options.add_project(
>>     r'/home/foo/cvsrepo/ModA,
>>     trunk_path=ModA',
>>     [...]
>>     )
>>
>> run_options.add_project(
>>     r'/home/foo/cvsrepo/ModB,
>>     trunk_path=ModB',
>>     [...]
>>     )
>
> I assume that what you mean is that the CVS repository contains
> directories like ModA/a, ModA/b, ModB/c, and ModB/d, but the resulting
> git repository has only /a, /b, /c, and /d.  That is because cvs2git
> completely ignores the trunk_path argument to add_project().
>
> It is strange that the code allows you to add multiple projects,
> considering that the cvs2git documentation[1] states that cvs2git only
> supports converting single projects at a time.  I guess I forgot to
> build that check in.
>
> You can get the result you want by treating ModA and ModB not as two
> separate projects, but simply as two separate subdirectories within a
> bigger project; i.e.,
>
> run_options.add_project(
>    r'/home/foo/cvsrepo,
>    [...]
>    )
>
> .  This is assuming that ModA and ModB are the only subdirectories
> within /home/foo/cvsrepo/; otherwise, make a copy of your CVS repo and
> remove the other subdirectories from the copy before the conversion.
>
> Please note that when cvs2git is run this way, it treats tags and
> branches as being global.  If you tagged your projects simultaneously,
> then this is probably what you want.  But if you tagged your projects
> separately, then tag names that happen to be the same across projects
> will be considered the same.
>
> It would be possible to add cvs2git support for multiproject
> conversions, but I was under the impression that it doesn't make much
> sense to put multiple projects into a single git repository.  But I'm a
> novice git user, so I could very well be wrong about that.
>
> Michael

I haven't touched cvs2git, but I did modify git-cvsimport to handle
submodules.  The patch is below.  The idea is that you first convert
the submodule parts from cvs to git, and then when you convert the
parent project the submodules are continuously updated based on a
submodule description file and the dates.

To use it, write a file in the same format as .gitmodules and pass it
to cvs-import via -E.

I eventually decided that submodules were getting in the way far more
than they were helping, so I stopped using this.  Perhaps someone else
will find it useful.

Geoffrey

>From 653fe2e8440893da06fa0eba9fd5c2c275435897 Mon Sep 17 00:00:00 2001
From: Geoffrey Irving <irving@naml.us>
Date: Thu, 12 Jun 2008 07:38:49 -0700
Subject: [PATCH] cvsimport: add support for generating submodules

Add an -E <submodules> option to cvsimport to generate submodule links to
other git repositories and to update them after each commit based on date.
This is useful when one is splitting up a cvs repository into separate git
modules which are strongly related to each other.
---
 git-cvsimport.perl |   71 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index cacbfc0..9b0285a 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,8 +29,9 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";

-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P,
$opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r);
+our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P,
$opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_E,$opt_L, $opt_a, $opt_r);
 my (%conv_author_name, %conv_author_email);
+my (%submodule_path, %submodule_url);

 sub usage(;$) {
        my $msg = shift;
@@ -40,7 +41,7 @@ Usage: ${\basename $0}     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
        [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
-       [-r remote] [CVS_module]
+       [-E gitmodules-file] [-r remote] [CVS_module]
 END
        exit(1);
 }
@@ -88,6 +89,23 @@ sub write_author_info($) {
        close ($f);
 }

+sub read_submodule_info($) {
+       my ($file) = @_;
+       open(my $f, '-|', 'git-config', '--file', $file, '--list')
+               or die "Failed to read: $!\n";
+
+       while (<$f>) {
+               /^submodule\.(\w+)\.(path|url)=(.*)$/
+                       or die "Unknown submodule config line: $_\n";
+               if ($2 eq 'path') {
+                       $submodule_path{$1} = $3;
+               } else {
+                       $submodule_url{$1} = $3;
+               }
+       }
+       close $f;
+}
+
 # convert getopts specs for use by git config
 sub read_repo_config {
     # Split the string between characters, unless there is a ':'
@@ -110,7 +128,7 @@ sub read_repo_config {
        }
 }

-my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:";
+my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:E:";
 read_repo_config($opts);
 Getopt::Long::Configure( 'no_ignore_case', 'bundling' );

@@ -610,6 +628,10 @@ if ($opt_A) {
        write_author_info("$git_dir/cvs-authors");
 }

+# read submodule info
+if ($opt_E) {
+       read_submodule_info($opt_E);
+}

 #
 # run cvsps into a file unless we are getting
@@ -664,16 +686,19 @@ open(CVS, "<$cvspsfile") or die $!;

 my $state = 0;

-sub update_index (\@\@) {
+sub update_index (\@\@\@) {
        my $old = shift;
        my $new = shift;
+       my $submodules = shift;
        open(my $fh, '|-', qw(git-update-index -z --index-info))
                or die "unable to open git-update-index: $!";
        print $fh
                (map { "0 0000000000000000000000000000000000000000\t$_\0" }
                        @$old),
                (map { '100' . sprintf('%o', $_->[0]) . " $_->[1]\t$_->[2]\0" }
-                       @$new)
+                       @$new),
+               (map { "160000 commit $_->[0]\t$_->[1]\0" }
+                       @$submodules)
                or die "unable to write to git-update-index: $!";
        close $fh
                or die "unable to write to git-update-index: $!";
@@ -721,7 +746,41 @@ sub commit {
        }
         $ENV{GIT_INDEX_FILE} = $index{$branch};

-       update_index(@old, @new);
+       # add .gitmodules and find submodule commits
+       my @submodules;
+       if ($opt_E) {
+               print "Update .gitmodules\n" if $opt_v;
+               my $pid = open(my $F, '-|');
+               die $! unless defined $pid;
+               if (!$pid) {
+                   exec("git-hash-object", "-w", $opt_E)
+                               or die "Cannot create object: $!\n";
+               }
+               my $sha = <$F>;
+               chomp $sha;
+               close $F;
+               push(@new,[0644, $sha, ".gitmodules"]);
+
+               for my $m (keys %submodule_path) {
+                       my $search_date = $date + (defined $opt_z ?
$opt_z : 300);
+                       $ENV{"GIT_DIR"} = $submodule_url{$m};
+                       open(my $f, '-|', 'git-log',
"--before=$search_date", '-1', '--pretty=format:%H %ct')
+                               or die "Failed to extract submodule
commit id: $!\n";
+                       $ENV{"GIT_DIR"} = $git_dir;
+                       my $line = <$f>;
+                       close $f;
+                       if (defined $line) {
+                               $line =~ /^([\da-f]{40}) (\d+)$/ or
die "Failed to parse submodule log: $line\n";
+                               push @submodules, [$1, $submodule_path{$m}];
+                               if ($opt_v) {
+                                       my $subdate = strftime("+0000
%Y-%m-%d %H:%M:%S",gmtime($2));
+                                       print "Updating submodule $m
to $subdate\n";
+                               }
+                       }
+               }
+       }
+
+       update_index(@old, @new, @submodules);
        @old = @new = ();
        my $tree = write_tree();
        my $parent = get_headref("$remote/$last_branch");
-- 
1.5.5.1.508.ga00f3
