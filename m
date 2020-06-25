Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014FBC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91B720781
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 21:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyd9C1vL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406455AbgFYVdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406260AbgFYVdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 17:33:19 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260E3C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 14:33:19 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n24so4464398otr.13
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
         :content-transfer-encoding;
        bh=X9cFnvlpfXeoU+EbQ+bqirwjvxaaQpx4q/WWXKjFCQg=;
        b=uyd9C1vLry7b1FvX+sUkSYU/7ltFMjW/ahbhWjGaOyeAR0xCGRthKRW4ehKfxtKcB8
         DwBkGDSqhe/4YqVShcyfda3X+yMwkGN1psFpFGSKk39eRFRYOfkn2u6yIFb+Bwk0lc2K
         DEvmjxEemRUoTLX9cKXWZwzIRbfSEQvD6DfPVznZ3MExwNO5h2o8ZN32S4hwnbvq+M5B
         SoKBLSJ9jW7V5Mx6xBMdY+0LtZqPGe8Iu9QYkOYiiOL+LbWoILceugKPAMMS65Yjnu9o
         Gq3tcXvlcQ4IhBS1MC+c9brJIzK6rB8p31Uw25u/yLSEWXdSZhRqYheGsbvzhc0c0K6u
         UeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:reply-to:user-agent
         :mime-version:to:subject:content-transfer-encoding;
        bh=X9cFnvlpfXeoU+EbQ+bqirwjvxaaQpx4q/WWXKjFCQg=;
        b=cI5NigGAcs/zPV3MFmxqlyTJBwuQSCgG6sxOVFrpLy1f9x35Gv4GGFDt1axxAmksdj
         znP3z9RGpRYB5O/Y5Ux1dxGCrB0so+U+EDldYlvE0hHacyJzNJt+SOIO5R9iFkCEAuK/
         Bv0FR6gaNwpOJGqXGvoc3Ca40AehD1tY72XTbJuPsqJL4DBXqCQQC0CtbLuPMm7yZoSU
         vQVf9aSunw/7Na2mpVsu7RiIVGr2C5cTH5bLl9uMeZS6JvlEX+tM0hqnYoe280jn+n9G
         G4K48yUsEby4n8SaIiD/+XQ8eOgdUn/MVXBazfP73Vf5vj+Tk//oKcfOAkDhN0a2XnJO
         ZboA==
X-Gm-Message-State: AOAM53071bcSnv/rrSnUKcDkndPENVRNUqgCA7x+3xSyp6MrenmzWN9r
        olr4zpSQbTk5PA7pDbjDnMLmCp32
X-Google-Smtp-Source: ABdhPJxamp9caIJnx4wd30o/fNJPZOVKZvGo0ikfACBvq6E8RmsCFqCZ6gp/gP8xrQC07qE6g0QhYg==
X-Received: by 2002:a4a:e702:: with SMTP id y2mr19195961oou.36.1593120798027;
        Thu, 25 Jun 2020 14:33:18 -0700 (PDT)
Received: from [192.168.2.42] (adsl-70-133-144-251.dsl.ablntx.sbcglobal.net. [70.133.144.251])
        by smtp.gmail.com with ESMTPSA id y31sm5745080otb.41.2020.06.25.14.33.16
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2020 14:33:17 -0700 (PDT)
Message-ID: <5EF5181B.6060208@gmail.com>
Date:   Thu, 25 Jun 2020 16:33:15 -0500
From:   Jacob Bachmeyer <jcb62281@gmail.com>
Reply-To: jcb62281@gmail.com
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.22) Gecko/20090807 MultiZilla/1.8.3.4e SeaMonkey/1.1.17 Mnenhy/0.7.6.0
MIME-Version: 1.0
To:     git@vger.kernel.org
Subject: [RFC] Perl script git-squash-merge to combine merge commits
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have written a small Perl script, included below under the same terms 
as Perl itself, that combines a group of stepwise 2-input merge commits 
into a single N-input merge commit, with the long explanation in the 
included POD.

-- Jacob

--- 8< ---

#!/usr/bin/perl
# -*- CPerl -*-

use strict;
use warnings;

use File::Spec;
use Getopt::Long;
use Pod::Usage;

use IPC::Open2;

my $Help = 0;
my $Verbose = 0;

GetOptions('help'	=> \$Help,
	   'verbose|v'	=> \$Verbose) or pod2usage(2);
pod2usage(1) if $Help;

my $GIT_DIR = `git rev-parse --git-dir`; chomp $GIT_DIR;
die "could not find Git directory" unless $GIT_DIR;

# read a commit; return hashref with keys:
#  id		-- Git commit id
#  tree		-- tree object id for this commit
#  parents	-- array of parents of this commit
#  author	-- commit author line (name, timestamp)
#  committer	-- commit committer line (name, timestamp)
#  files	-- filenames mentioned in commit diff
sub read_commit ($) {
  my $commit_id = shift;

  my $commit = {};

  open my $git_show, '-|', qw/git show --format=raw/, $commit_id
    or die "git show $commit_id: $!";
  while (<$git_show>) {
    chomp;
    my @fields = split /[[:space:]]+/, $_;
    if (@fields) {
      if ($fields[0] eq 'parent') {
	push @{$commit->{parents}}, $fields[1];
      } elsif ($fields[0] eq 'diff' && $fields[1] eq '--cc') {
	push @{$commit->{files}}, $fields[2];
      } elsif ($fields[0] eq 'tree') {
	die "extra tree in commit $commit_id" if $commit->{tree};
	$commit->{tree} = $fields[1];
      } elsif ($fields[0] eq 'commit') {
	die "extra commit id in commit $commit_id" if $commit->{id};
	$commit->{id} = $fields[1];
      }
    }
  }
  close $git_show;

  return $commit
}

# commits indexed by id
my %Commits = ();

sub intern_commit ($) {
  my $id = shift;
  return $Commits{$id} if $Commits{$id};
  my $commit = read_commit $id;
  $Commits{$id} = $Commits{$commit->{id}} = $commit;
  return $commit;
}

# branch names indexed by id
my %Branches = ();
# [id, branch name] pairs
my @Branches = ();

#
# Read available branches
#
{
  open my $git_refs, '-|', qw/git show-ref --heads/;
  while (<$git_refs>) {
    chomp;
    if (m[^([[:xdigit:]]{40,})[[:space:]]+refs/heads/(.*)$])
      { push @Branches, [$1, $2] }
    else { die "could not parse ref line: $_" }
  }
  close $git_refs;

  foreach my $cell (@Branches)
    { $Branches{$cell->[0]} = $cell->[1]
	unless $cell->[1] =~ m/^local/ && $Branches{$cell->[0]} }
}

# tip of merge tree (set once at runtime)
my $STARTING_COMMIT = intern_commit('HEAD');

# tree object id of merged tree (set once at runtime)
my $FINAL_TREE = $STARTING_COMMIT->{tree};

# array of branches involved in merge tree
my @Merged_Branches = ();

# hash of conflicts resolved in merge tree; file name => count
my %Conflicts_Resolved = ();

#
# Read needed commits
#
{
  # array of commit ids to read
  my @Queue = ($STARTING_COMMIT->{id});

  while (@Queue) {
    my $id = shift @Queue;
    my $commit = intern_commit $id;

    if ($Verbose) {
      print "read commit $commit->{id}";
    }

    if (scalar @{$commit->{parents}} == 2) {
      # commit is a simple 2-input merge
      if ($Verbose) {
	print "; merge; resolving conflicts:\n";
	print "    $_\n" for @{$commit->{files}};
      }
      unshift @Merged_Branches, grep $Branches{$_}, @{$commit->{parents}};
      push @Queue, grep !$Branches{$_}, @{$commit->{parents}};
    } else {
      # commit was an input to the merge tree, but not a branch tip
      if ($Verbose) {
	print "; surprise merge input\n";
      }
      unshift @Merged_Branches, $commit->{id};
    }

    $Conflicts_Resolved{$_}++ for @{$commit->{files}};
  }
}

#
# Prepare new commit message
#
my $Commit_Message_File = File::Spec->catfile($GIT_DIR, 'COMMIT_EDITMSG');
open EDITMSG, '>', $Commit_Message_File
  or die "cannot open $Commit_Message_File for write: $!";

print EDITMSG 'Merge ',(scalar @Merged_Branches), " branches\n\n";
for my $tip_id (@Merged_Branches) {
  print EDITMSG '* ', $Branches{$tip_id}, ":\n",
    '   merged at commit ', $tip_id, "\n";
}

print EDITMSG <<'END';

# Please edit the commit message for the combined merge commit.  Lines
# starting with '#' will be ignored, along with initial or trailing blank
# lines.  Lines containing only whitespace will become empty.  An empty
# message aborts the commit.
END

close EDITMSG;

#
# Give the user a change to edit the message or abort
#
{
  my $EDITOR = `git var GIT_EDITOR`; chomp $EDITOR;

  system "$EDITOR $Commit_Message_File";

  open EDITMSG, '<', $Commit_Message_File
    or die "cannot open $Commit_Message_File for read: $!";
  my $linecnt = 0;
  while (<EDITMSG>)
    { next if m/^#/ || m/^[[:space:]]*$/; $linecnt++ }
  close EDITMSG;

  if ($linecnt == 0) {
    print "commit aborted due to empty message\n";
    exit 0;
  }
}

#
# Write the new commit
#

# new commit id
my $Merge_Commit_ID = undef;

{
  my $get_commit_id; my $put_commit_msg;

  open my $commit_msg, '<', $Commit_Message_File
    or die "cannot open $Commit_Message_File for read: $!";
  my $collapse_blanks = 1; my $prev_blank = '';
  my $pid =
    open2($get_commit_id, $put_commit_msg,
	  qw/git commit-tree/, $FINAL_TREE, map {+'-p' => $_} @Merged_Branches);
  while (<$commit_msg>) {
    next if m/^#/;
    next if $collapse_blanks && m/^[[:space:]]*$/;
    if ($prev_blank) { print $put_commit_msg $prev_blank; $prev_blank = '' }
    $prev_blank = "\n" if s/^[[:space:]]*$//;
    print $put_commit_msg $_;
    $collapse_blanks = m/^[[:space:]]*$/;
  }
  close $commit_msg;
  close $put_commit_msg;

  $Merge_Commit_ID = <$get_commit_id>; chomp $Merge_Commit_ID;
  die "could not get merge commit ID" unless $Merge_Commit_ID;
}

#
# Fail if Git reports conflicts in the combined merge that had not been
# resolved in the previous merges.
#
{
  my $merge_commit = read_commit $Merge_Commit_ID;
  my @new_conflicts = ();

  foreach my $file (@{$merge_commit->{files}}) {
    push @new_conflicts, $file unless $Conflicts_Resolved{$file};
  }

  if (@new_conflicts) {
    print <<'END';
ERROR:  False conflict introduced in combined merge!

The following files were not listed as conflicts in any input merge commit,
 but Git reports a conflict resolved in the combined merge:
END

    print '    ', $_, "\n" for sort @new_conflicts;

    print "\ncombined merge failed with commit $Merge_Commit_ID\n";
  } else {
    # The combined merge looks good.  Save it.
    system {'git'} qw/git update-ref HEAD/, $Merge_Commit_ID;
  }
}

__END__

=head1 NAME

    git-squash-merge - combine merges into one merge commit

=head1 SYNOPSIS

    git-squash-merge [options]

=head1 DESCRIPTION

Rewrites history to collect a combined merge after a series of manual
merges.  This command does B<not> produce a new tree or change the contents
of the tree in any way; it only creates an octopus merge commmit to carry
the results of a group of 2-input merges.

Assume that development has diverged in several directions, all of which
merge readily, but administrivia such as ChangeLog entries or Emacs
LocalWords lists in documentation present merge conflicts and prevent a
direct octopus merge.

     B---D---F topic1
    /
   +---C---E topic2
  /
 A master
  \
   +---H---K topic3
    \
     G---I---J topic4

All of these branches should be merged into master, but a direct octopus
merge fails because they all have different ChangeLog updates.  So they
must be merged one at a time, resolving the conflicts manually along the
way.

     B---D----F topic1
    /	       \
   +---C---E    \ topic2
  /	    \    \
 A           L---MN master
  \	    /   /
   +---H---K   / topic3
    \	      /
     G---I---J topic4

Now master has a correct merged tree (and testing has validated that the
merged result is good) but history is a bit of a mess.  This tool replaces
the merge commits LMN with single octopus merge O using the tree object
from commit N.

     B---D---F topic1
    /	      \
   +---C---E---+ topic2
  /		\
 A               O master
  \		/
   +---H---K---+ topic3
    \	      /
     G---I---J topic4

Because the tree from commit N is reused for commit O, commit O contains
the end product of the manual stepwise merge reconciliation, but is a
single commit with all four branches as its parents.

=head1 OPTIONS

=over

=item B<-v>, B<--verbose>

Emit messages as the merge tree is traced.

=back

=head1 SEE ALSO

git-merge(1)

git-commit-tree(1), git-rev-parse(1), git-show(1),
git-show-ref(1), git-update-ref(1), git-var(1)

=head1 AUTHOR

Written by Jacob Bachmeyer <jcb62281+dev@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020 by Jacob Bachmeyer

This tool is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


