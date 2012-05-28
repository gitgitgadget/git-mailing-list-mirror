From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] git-svn: rename SVN::Git::* packages to Git::SVN::*
Date: Mon, 28 May 2012 02:00:46 -0500
Message-ID: <20120528070046.GD10976@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
 <20120528003901.GA11103@burratino>
 <20120528065723.GC10976@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 28 09:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYtwm-0006I6-CN
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 09:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab2E1HAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 03:00:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33243 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab2E1HAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 03:00:50 -0400
Received: by yenm10 with SMTP id m10so1188765yen.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FfXQoaeaEmeJiaQeLUPm0ky7+VqRW45WqoA2+fHMIyo=;
        b=rOzvu5e8laV0KsTTgFsU5NjTpS36aRaiWNUYEIg8dsbH7UbApqqjuBi0B4I7SUdySb
         3lvvXkVgnaMBU7GTYmd2FrAN9ezMKeQqlmIm8we3hJw44BMc76Vp4eOCbX558p+nmMI1
         G4Ldogrg0D+nLZqSJNpYNiBQW4+LTXfwWstjvTelWH4WMaumYlz1ReTpbv/SjMJyoeUZ
         gXsuSadumPjqLmhy26Ut1ebWJY14i8gDDmSS61BsB0E4xrTY0WJl78iX404Mb3Rjd3pu
         6cZZzuWVh8yCoPcN5Q7pYcb5gVGDW7KtJ6ySzNi087VD+4gnh5OUWXGZBe9vQcY9uL/A
         sFQg==
Received: by 10.50.36.200 with SMTP id s8mr3809838igj.27.1338188450066;
        Mon, 28 May 2012 00:00:50 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vi7sm9841956igb.10.2012.05.28.00.00.48
        (version=SSLv3 cipher=OTHER);
        Mon, 28 May 2012 00:00:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120528065723.GC10976@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198630>

Using names in the Git:: namespace means these cannot conflict with a
hypothetical binding teaching Subversion to interact with git
repositories.

Currently the packages are private to git-svn.perl so the choice of
name isn't likely to make much difference.  This change is mainly
meant as preparation for splitting out the packages in question as
modules on the public search path.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-svn.perl |   50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef60b874..d0bcf3f1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -68,8 +68,8 @@ sub _req_svn {
 }
 my $can_compress = eval { require Compress::Zlib; 1};
 push @Git::SVN::Ra::ISA, 'SVN::Ra';
-push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
-push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
+push @Git::SVN::Editor::ISA, 'SVN::Delta::Editor';
+push @Git::SVN::Fetcher::ISA, 'SVN::Delta::Editor';
 use Carp qw/croak/;
 use Digest::MD5;
 use IO::File qw//;
@@ -89,7 +89,7 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe
 	            command_bidi_pipe command_close_bidi_pipe/) {
-		for my $package ( qw(SVN::Git::Editor SVN::Git::Fetcher
+		for my $package ( qw(Git::SVN::Editor Git::SVN::Fetcher
 			Git::SVN::Migration Git::SVN::Log Git::SVN),
 			__PACKAGE__) {
 			*{"${package}::$_"} = \&{"Git::$_"};
@@ -111,12 +111,12 @@ my ($_stdin, $_help, $_edit,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_git_format, $_commit_url, $_tag, $_merge_info, $_interactive);
 $Git::SVN::_follow_parent = 1;
-$SVN::Git::Fetcher::_placeholder_filename = ".gitignore";
+$Git::SVN::Fetcher::_placeholder_filename = ".gitignore";
 $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
-                    'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex,
+                    'ignore-paths=s' => \$Git::SVN::Fetcher::_ignore_regex,
                     'ignore-refs=s' => \$Git::SVN::Ra::_ignore_refs_regex );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
@@ -149,10 +149,10 @@ my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
 		  'rewrite-uuid=s' => sub { $icv{rewriteUUID} = $_[1] },
                   %remote_opts );
 my %cmt_opts = ( 'edit|e' => \$_edit,
-		'rmdir' => \$SVN::Git::Editor::_rmdir,
-		'find-copies-harder' => \$SVN::Git::Editor::_find_copies_harder,
-		'l=i' => \$SVN::Git::Editor::_rename_limit,
-		'copy-similarity|C=i'=> \$SVN::Git::Editor::_cp_similarity
+		'rmdir' => \$Git::SVN::Editor::_rmdir,
+		'find-copies-harder' => \$Git::SVN::Editor::_find_copies_harder,
+		'l=i' => \$Git::SVN::Editor::_rename_limit,
+		'copy-similarity|C=i'=> \$Git::SVN::Editor::_cp_similarity
 );
 
 my %cmd = (
@@ -164,9 +164,9 @@ my %cmd = (
 	clone => [ \&cmd_clone, "Initialize and fetch revisions",
 			{ 'revision|r=s' => \$_revision,
 			  'preserve-empty-dirs' =>
-				\$SVN::Git::Fetcher::_preserve_empty_dirs,
+				\$Git::SVN::Fetcher::_preserve_empty_dirs,
 			  'placeholder-filename=s' =>
-				\$SVN::Git::Fetcher::_placeholder_filename,
+				\$Git::SVN::Fetcher::_placeholder_filename,
 			   %fc_opts, %init_opts } ],
 	init => [ \&cmd_init, "Initialize a repo for tracking" .
 			  " (requires URL argument)",
@@ -464,15 +464,15 @@ sub do_git_init_db {
 		command_noisy('config', "$pfx.$i", $icv{$i});
 		$set = $i;
 	}
-	my $ignore_paths_regex = \$SVN::Git::Fetcher::_ignore_regex;
+	my $ignore_paths_regex = \$Git::SVN::Fetcher::_ignore_regex;
 	command_noisy('config', "$pfx.ignore-paths", $$ignore_paths_regex)
 		if defined $$ignore_paths_regex;
 	my $ignore_refs_regex = \$Git::SVN::Ra::_ignore_refs_regex;
 	command_noisy('config', "$pfx.ignore-refs", $$ignore_refs_regex)
 		if defined $$ignore_refs_regex;
 
-	if (defined $SVN::Git::Fetcher::_preserve_empty_dirs) {
-		my $fname = \$SVN::Git::Fetcher::_placeholder_filename;
+	if (defined $Git::SVN::Fetcher::_preserve_empty_dirs) {
+		my $fname = \$Git::SVN::Fetcher::_placeholder_filename;
 		command_noisy('config', "$pfx.preserve-empty-dirs", 'true');
 		command_noisy('config', "$pfx.placeholder-filename", $$fname);
 	}
@@ -942,7 +942,7 @@ sub cmd_dcommit {
 			                },
 					mergeinfo => $_merge_info,
 			                svn_path => '');
-			if (!SVN::Git::Editor->new(\%ed_opts)->apply_diff) {
+			if (!Git::SVN::Editor->new(\%ed_opts)->apply_diff) {
 				print "No changes\n$d~1 == $d\n";
 			} elsif ($parents->{$d} && @{$parents->{$d}}) {
 				$gs->{inject_parents_dcommit}->{$cmt_rev} =
@@ -1066,8 +1066,8 @@ sub cmd_branch {
 		            " with the --destination argument.\n";
 		}
 		foreach my $g (@{$allglobs}) {
-			# SVN::Git::Editor could probably be moved to Git.pm..
-			my $re = SVN::Git::Editor::glob2pat($g->{path}->{left});
+			# Git::SVN::Editor could probably be moved to Git.pm..
+			my $re = Git::SVN::Editor::glob2pat($g->{path}->{left});
 			if ($_branch_dest =~ /$re/) {
 				$glob = $g;
 				last;
@@ -1425,7 +1425,7 @@ sub cmd_commit_diff {
 	                tree_b => $tb,
 	                editor_cb => sub { print "Committed r$_[0]\n" },
 	                svn_path => $svn_path );
-	if (!SVN::Git::Editor->new(\%ed_opts)->apply_diff) {
+	if (!Git::SVN::Editor->new(\%ed_opts)->apply_diff) {
 		print "No changes\n$ta == $tb\n";
 	}
 }
@@ -3256,7 +3256,7 @@ sub find_parent_branch {
 			# at the moment), so we can't rely on it
 			$self->{last_rev} = $r0;
 			$self->{last_commit} = $parent;
-			$ed = SVN::Git::Fetcher->new($self, $gs->{path});
+			$ed = Git::SVN::Fetcher->new($self, $gs->{path});
 			$gs->ra->gs_do_switch($r0, $rev, $gs,
 					      $self->full_url, $ed)
 			  or die "SVN connection failed somewhere...\n";
@@ -3274,7 +3274,7 @@ sub find_parent_branch {
 		} else {
 			print STDERR "Following parent with do_update\n"
 			             unless $::_q > 1;
-			$ed = SVN::Git::Fetcher->new($self);
+			$ed = Git::SVN::Fetcher->new($self);
 			$self->ra->gs_do_update($rev, $rev, $self, $ed)
 			  or die "SVN connection failed somewhere...\n";
 		}
@@ -3297,7 +3297,7 @@ sub do_fetch {
 			push @{$log_entry->{parents}}, $lc;
 			return $log_entry;
 		}
-		$ed = SVN::Git::Fetcher->new($self);
+		$ed = Git::SVN::Fetcher->new($self);
 		$last_rev = $self->{last_rev};
 		$ed->{c} = $lc;
 		@parents = ($lc);
@@ -3306,7 +3306,7 @@ sub do_fetch {
 		if (my $log_entry = $self->find_parent_branch($paths, $rev)) {
 			return $log_entry;
 		}
-		$ed = SVN::Git::Fetcher->new($self);
+		$ed = Git::SVN::Fetcher->new($self);
 	}
 	unless ($self->ra->gs_do_update($last_rev, $rev, $self, $ed)) {
 		die "SVN connection failed somewhere...\n";
@@ -4026,7 +4026,7 @@ sub set_tree {
 	                editor_cb => sub {
 			       $self->set_tree_cb($log_entry, $tree, @_) },
 	                svn_path => $self->{path} );
-	if (!SVN::Git::Editor->new(\%ed_opts)->apply_diff) {
+	if (!Git::SVN::Editor->new(\%ed_opts)->apply_diff) {
 		print "No changes\nr$self->{last_rev} = $tree\n";
 	}
 }
@@ -4442,7 +4442,7 @@ sub remove_username {
 	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
 }
 
-package SVN::Git::Fetcher;
+package Git::SVN::Fetcher;
 use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
             @deleted_gpath %added_placeholder $repo_id/;
 use strict;
@@ -4945,7 +4945,7 @@ sub stash_placeholder_list {
 	}
 }
 
-package SVN::Git::Editor;
+package Git::SVN::Editor;
 use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit/;
 use strict;
 use warnings;
-- 
1.7.10
