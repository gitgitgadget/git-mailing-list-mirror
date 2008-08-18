From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH 2/3 v2] add new Perl API: Git::Repo, Git::Commit, Git::Tag, and Git::RepoRoot
Date: Mon, 18 Aug 2008 21:39:48 +0200
Message-ID: <1219088389-14828-2-git-send-email-LeWiemann@gmail.com>
References: <1219088389-14828-1-git-send-email-LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 21:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVAbm-0000ee-Ga
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 21:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762644AbYHRTj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 15:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758346AbYHRTj5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 15:39:57 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:18266 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbYHRTjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 15:39:49 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2238162fkq.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :from;
        bh=ANXXUxmY6A1g5vEWEYh1Gq/8lcEt11Y6rzLS04PVA/Y=;
        b=mRMdVFYkvOB5801X2KLd+BqEynZz7U/l6u8H18xpLsmBmydu/F4Bnn9TccBPZ7YEva
         i9aT3pcObh/tGDUIGUr+wF/T2ETV/y3OlbVgJwOrBWUzu/2xxwqj7agSqRWoo5AOOpd/
         HZuSS+hQfTd4vkcUY4YpLiYciCFF5mWysvZMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=aJIm971ItZkwacalVtCCbX4P2i8EAUfcUEdvpzJaOu1n7SjdWMWmWkBLDO7G7Xhi/E
         jr/AtGznUcNA8ZSBaqwyHyUK2AY5XAyWSxTDy5qxiqu8VHSXkfLDCFlMSJAx7Eb5+7tM
         2aSxGHsarQufp/N65ai30crRX8yjBm+/f9skc=
Received: by 10.180.213.14 with SMTP id l14mr3495353bkg.55.1219088387216;
        Mon, 18 Aug 2008 12:39:47 -0700 (PDT)
Received: from fly ( [91.33.194.4])
        by mx.google.com with ESMTPS id z10sm7122966fka.15.2008.08.18.12.39.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 12:39:45 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KVAZx-0003sC-KV; Mon, 18 Aug 2008 21:39:49 +0200
X-Mailer: git-send-email 1.6.0.90.gf3f7b
In-Reply-To: <1219088389-14828-1-git-send-email-LeWiemann@gmail.com>
In-Reply-To: <48A9CEC0.2020100@gmail.com>
References: <48A9CEC0.2020100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92730>

The Git::Repo class provides low-level access to Git repositories.
The Git::Commit and Git::Tag classes represent commit and tag objects
and allow for accessing their respective properties (like 'author',
'tagger', etc.); Git::Object serves as a common base class for them.
Git::RepoRoot is a helper factory class to instantiate Git::Repo
objects with common properties for repositories under a common root
directory.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 perl/Git/Commit.pm       |  179 ++++++++++++++++++++++++++++++
 perl/Git/Object.pm       |   94 ++++++++++++++++
 perl/Git/Repo.pm         |  274 ++++++++++++++++++++++++++++++++++++++++++++++
 perl/Git/RepoRoot.pm     |  103 +++++++++++++++++
 perl/Git/Tag.pm          |  169 ++++++++++++++++++++++++++++
 perl/Makefile            |    1 +
 perl/Makefile.PL         |   10 ++-
 t/t9710-perl-git-repo.sh |   49 ++++++++
 t/t9710/test.pl          |  136 +++++++++++++++++++++++
 9 files changed, 1014 insertions(+), 1 deletions(-)
 create mode 100644 perl/Git/Commit.pm
 create mode 100644 perl/Git/Object.pm
 create mode 100644 perl/Git/Repo.pm
 create mode 100644 perl/Git/RepoRoot.pm
 create mode 100644 perl/Git/Tag.pm
 create mode 100755 t/t9710-perl-git-repo.sh
 create mode 100755 t/t9710/test.pl

diff --git a/perl/Git/Commit.pm b/perl/Git/Commit.pm
new file mode 100644
index 0000000..58e502f
--- /dev/null
+++ b/perl/Git/Commit.pm
@@ -0,0 +1,179 @@
+=head1 NAME
+
+Git::Commit - Object-oriented interface to Git commit objects.
+
+=head1 DESCRIPTION
+
+Git::Commit is a class representing a commit object in a Git
+repository.  It stringifies to the commit object's SHA1.
+
+=cut
+
+use strict;
+use warnings;
+
+
+package Git::Commit;
+
+use base qw(Git::Object);
+
+
+# Keep documentation in one place to save space.
+
+=head1 METHODS
+
+=head2 General Methods
+
+=over
+
+=item $commit = Git::Commit->new($repo, $sha1)
+
+Return a new Git::Commit instance for a commit object with $sha1 in
+repository $repo.
+
+The commit object is loaded lazily.  Hence, calls to this method are
+free, and it does not check whether $sha1 exists and has the right
+type.  However, accessing any of the commit object's properties will
+fail if $sha1 is not a valid commit object.
+
+Note that $sha1 must be the SHA1 of a commit object; tag objects are
+not dereferenced.
+
+The author, committer and message methods return Unicoded strings,
+decoded according to the "encoding" header, with UTF-8 and then
+Latin-1 as fallbacks.  (These Unicode strings can contain code points
+greater than 256 and are *not* UTF-8 strings; see man perlunitut on
+how Perl handles Unicode.)
+
+You will usually want to call $repo->get_commit($sha1) instead of
+instantiating this class directly; see L<Git::Repo>.
+
+=item $obj->repo
+
+Return the Git::Repo instance this object was instantiated with.
+
+=item $obj->sha1
+
+Return the SHA1 of this commit object, as provided at instantiation time.
+
+=back
+
+=head2 Property Methods
+
+Calling any of these methods will cause the commit object to be loaded
+from the repository, if it hasn't been loaded already.
+
+=over
+
+=item $commit->tree
+
+Return an object that stringifies to the SHA1 of the tree that this
+commit object refers to.  (Currently this returns an actual string,
+but don't rely on it.)
+
+=item $commit->parents
+
+Return an array of zero or more parent commit objects.  Note that
+commit objects stringify to their respective SHA1s, so you can
+alternatively treat this as an array of SHA1 strings.
+
+=item $commit->author
+
+Return the author of this commit object as a Unicode string.
+
+=item $commit->committer
+
+Return the committer of this commit object as a Unicode string.
+
+=item $commit->message
+
+Return the commit message of this commit object as a Unicode string.
+
+=item $commit->encoding
+
+Return the encoding header of the commit object, or undef if no
+encoding header is present; note that Git::Commit does the necessary
+decoding for you, so you should not normally need this method.
+
+=back
+
+=cut
+
+
+sub tree {
+	my $self = shift;
+	$self->_load;
+	return $self->{tree};
+}
+
+sub parents {
+	my $self = shift;
+	$self->_load;
+	return map { ref($self)->new($self->repo, $_) } @{$self->{parents}};
+}
+
+sub author {
+	my $self = shift;
+	$self->_load;
+	return $self->_decode($self->{author});
+}
+
+sub committer {
+	my $self = shift;
+	$self->_load;
+	return $self->_decode($self->{committer});
+}
+
+sub message {
+	my $self = shift;
+	$self->_load;
+	return $self->_decode($self->{message});
+}
+
+sub encoding {
+	my $self = shift;
+	$self->_load;
+	return $self->{encoding};
+}
+
+# Auxiliary method to load (and parse) the commit object from the
+# repository if it hasn't already been loaded.  Optional parameter:
+# The raw contents of the commit object; the commit object will be
+# retrieved from the repository if that parameter is not given.
+sub _load {
+	my ($self, $raw_text) = shift;
+	return if exists $self->{message};  # already loaded
+
+	my $sha1 = $self->sha1;
+	if (!defined $raw_text) {
+		# Retrieve from the repository.
+		(my $type, $raw_text) = $self->repo->get_object($sha1);
+		die "$sha1 is a $type object (expected a commit object)"
+		    unless $type eq 'commit';
+	}
+
+	(my $header, $self->{message}) = split "\n\n", $raw_text, 2;
+	# Parse header.
+	for my $line (split "\n", $header) {
+		local $/ = "\n"; # for chomp
+		chomp($line);
+		my ($key, $value) = split ' ', $line, 2;
+		if ($key eq 'tree') {
+			$self->{tree} = $value;
+		} elsif ($key eq 'parent') {
+			push @{$self->{parents}}, $value;
+		} elsif ($key eq 'author') {
+			$self->{author} = $value;
+		} elsif ($key eq 'committer') {
+			$self->{committer} = $value;
+		} elsif ($key eq 'encoding') {
+			$self->{encoding} = $value;
+		} else {
+			# Ignore unrecognized header lines.
+		}
+	}
+	undef;
+}
+
+
+1;
diff --git a/perl/Git/Object.pm b/perl/Git/Object.pm
new file mode 100644
index 0000000..8a158b2
--- /dev/null
+++ b/perl/Git/Object.pm
@@ -0,0 +1,94 @@
+=head1 NAME
+
+Git::Object - Object-oriented interface to Git objects (base class).
+
+=head1 DESCRIPTION
+
+Git::Object is a base class that provides access to commit, tag and
+(unimplemented) tree objects.  See L<Git::Commit> and L<Git::Tag>.
+
+Objects are loaded lazily, and hence instantiation is free.
+Git::Object instances stringify to their SHA1s.
+
+=cut
+
+
+use strict;
+use warnings;
+
+
+package Git::Object;
+
+use Encode qw(decode);
+
+use base qw(Exporter);
+
+our @EXPORT = qw();
+our @EXPORT_OK = qw();
+
+use overload
+    '""' => \&sha1;
+
+=head1 METHODS
+
+=over
+
+=item Git::Object->new($repo, $sha1)
+
+Return a new Git::Object instance for the object with $sha1 in the
+repository $repo (a Git::Repo instance).
+
+Note that this method does not check whether the object exists in the
+repository.  Trying to accessing its properties through a subclass
+will fail if the object doesn't exist, however.
+
+=cut
+
+sub new {
+	my ($class, $repo, $sha1) = @_;
+	die "$repo is not a Git::Repo instance" unless $repo->isa('Git::Repo');
+	my $self = {repo => $repo, sha1 => $sha1};
+	return bless $self, $class;
+}
+
+=item $obj->repo
+
+Return the Git::Repo instance this object was instantiated with.
+
+=cut
+
+sub repo {
+	shift->{repo}
+}
+
+=item $obj->sha1
+
+Return the SHA1 of this object.
+
+=cut
+
+sub sha1 {
+	shift->{sha1}
+}
+
+# Helper method: Decode the given octets into a Unicode string, trying
+# the $self->{encoding} encoding first, if defined, then trying UTF-8,
+# then falling back to Latin 1.
+
+sub _decode {
+	my ($self, $octets) = @_;
+	my $string;
+	# Try $self->{encoding}:
+	eval { $string = decode($self->{encoding}, $octets, Encode::FB_CROAK) }
+	    if $self->{encoding};
+	# ... else try UTF-8:
+	eval { $string = decode('utf-8', $octets, Encode::FB_CROAK) }
+	    unless defined $string;
+	# ... else fall back to Latin 1 (the first 256 Unicode code
+	# points coincide with Latin 1):
+	$string = $octets unless defined $string;
+	return $string;
+}
+
+
+1;
diff --git a/perl/Git/Repo.pm b/perl/Git/Repo.pm
new file mode 100644
index 0000000..2224c88
--- /dev/null
+++ b/perl/Git/Repo.pm
@@ -0,0 +1,274 @@
+=head1 NAME
+
+Git::Repo - Read-only access to the Git repositories.
+
+=head1 DESCRIPTION
+
+Git::Repo aims to provide low-level access to Git repositories.  For
+instance, you can resolve object names (like 'HEAD~2') to SHA1s, and
+inspect objects.  It does not attempt to be a wrapper around the git
+plumbing or porcelain commands.
+
+Error handling is simple: On a consistent repository, the Perl
+interface will never die.  You can use the get_sha1 method to resolve
+arbitrary object names or check the existence of SHA1 hashes; get_sha1
+will return undef if the object does not exist in the repository.  Any
+SHA1 that is returned by get_sha1 can be safely passed to the other
+Git::Repo methods.
+
+=head1 SYNOPSIS
+
+  use Git::Repo;
+
+  my $repo = Git::Repo->new(
+      repo_dir => '/path/to/repository.git',
+      git_binary => '/usr/bin/git');
+  my $sha1 = $repo->get_sha1('HEAD');
+  print "Last log message:\n\n" . $repo->get_commit($sha1)->message;
+
+=cut
+
+
+use strict;
+use warnings;
+# We could be compatible to Perl 5.6, but it doesn't provide sane pipe
+# handling (sane meaning does not go through shell, and allows for
+# accessing the exit code), so we require 5.8 until someone decides to
+# implement fork/exec-based pipe handling, plus possibly workarounds
+# for Windows brokenness.
+use 5.008;
+
+
+package Git::Repo;
+
+use Git::Tag;
+use Git::Commit;
+
+use IPC::Open2 qw(open2);
+use IO::Handle;
+
+use base qw(Exporter);
+
+our @EXPORT = qw();
+our @EXPORT_OK = qw();
+
+# Auxiliary subroutines
+
+sub _assert_opts {
+	die "must have an even number of arguments for named options"
+	    unless $#_ % 2;
+}
+
+sub _assert_sha1 {
+	my $sha1 = shift;
+	die "'$sha1' is not a SHA1 (need to use get_sha1?)"
+	    unless $sha1 && $sha1 =~ /^[a-f0-9]{40}$/;
+}
+
+
+=head1 METHODS
+
+=head2 General methods
+
+=over
+
+=item $repo = Git::Repo->new(%opts)
+
+Return a new Git::Repo object.  The following options are supported:
+
+=over
+
+=item 'repo_dir'
+
+The directory of the repository (mandatory).
+
+Note that this option is working-copy agnostic; you need to
+instantiate it with the working copy's .git directory as the
+'repo_dir' option.
+
+=item 'git_binary'
+
+The name or full path of the git binary (default: 'git').
+
+=back
+
+Calling this method is free, since it does not check whether the
+repository exists.  Trying to access the repository through one of the
+instance methods will fail if it doesn't exist though.
+
+Examples:
+
+    $repo = Git::Repo->new(repo_dir => '/path/to/repository.git');
+    $repo = Git::Repo->new(repo_dir => '/path/to/working_copy/.git');
+
+=cut
+
+sub new {
+	my $class = shift;
+	_assert_opts @_;
+	my $self = {@_};
+	bless $self, $class;
+	die 'no repo_dir given' unless $self->{repo_dir};
+	return $self;
+}
+
+=item $repo->repo_dir
+
+Return the directory of the repository (.../.git in case of a working
+copy).
+
+=cut
+
+sub repo_dir {
+	shift->{repo_dir}
+}
+
+=item $repo->git_binary
+
+Return the name of or path to the git binary (used with exec).
+
+=cut
+
+sub git_binary {
+	shift->{git_binary}
+}
+
+# Return the first items of the git command line, for instance
+# qw(/usr/bin/git --git-dir=/path/to/repo.git).
+sub _git_cmd {
+	my $self = shift;
+	return ($self->git_binary || 'git', '--git-dir=' . $self->repo_dir);
+}
+
+
+=back
+
+=head2 Inspecting the repository
+
+=over
+
+=item $repo->get_sha1($extended_object_identifier)
+
+Look up the object identified by $extended_object_identifier and
+return its SHA1 hash in scalar context or its ($sha1, $type, $size) in
+list context, or undef or () if the lookup failed, where $type is one
+of 'tag', 'commit', 'tree', or 'blob'.
+
+See L<git-rev-parse(1)>, section "Specifying Revisions", for the
+syntax of the $extended_object_identifier string.
+
+Note that even if you pass a SHA1 hash, its existence is still
+checked, and this method returns undef or () if it doesn't exist in
+the repository.
+
+=cut
+
+sub get_sha1 {
+	my ($self, $object_id) = @_;
+	die 'no object identifier given' unless $object_id;
+	die 'object identifier must not contain newlines' if $object_id =~ /\n/;
+	unless ($self->{sha1_stdout}) {
+		# Open bidi pipe the first time get_sha1 is called.
+		# open2 raises an exception on error, no need to 'or die'.
+		open2($self->{sha1_stdout}, $self->{sha1_stdin},
+		      $self->_git_cmd, 'cat-file', '--batch-check');
+	}
+	$self->{sha1_stdin}->print("$object_id\n")
+	    or die 'cannot write to pipe';
+	my $output = $self->{sha1_stdout}->getline
+	    or die 'cannot read from pipe';
+	chomp $output;
+	return if $output =~ /missing$/;
+	my ($sha1, $type, $size) =
+	    ($output =~ /^([0-9a-f]{40}) ([a-z]+) ([0-9]+)$/)
+	    or die "invalid response: $output";
+	return wantarray ? ($sha1, $type, $size) : $sha1;
+}
+
+=item $repo->get_object($sha1)
+
+Return the content (as a string) of the object identified by $sha1, or
+die if no such object exists in the repository.  In list context,
+return the ($type, $content) of the object.
+
+Note that you may want to use the higher-level methods get_commit and
+get_tag instead.
+
+=cut
+
+# Possible to-do items: Add optional $file_handle parameter.  Guard
+# against getting huge blobs back when we don't expect it (for
+# instance, we could limit the size and send SIGPIPE to git if we get
+# a blob that is too large).
+
+sub get_object {
+	my ($self, $sha1) = @_;
+	_assert_sha1($sha1);
+
+	unless ($self->{object_stdout}) {
+		# Open bidi pipe the first time get_object is called.
+		# open2 raises an exception on error, no need to 'or die'.
+		open2($self->{object_stdout}, $self->{object_stdin},
+		      $self->_git_cmd, 'cat-file', '--batch');
+	}
+	$self->{object_stdin}->print("$sha1\n") or die 'cannot write to pipe';
+	my ($ret_sha1, $type, $size) =
+	    split ' ', $self->{object_stdout}->getline
+	    or die 'cannot read from pipe';
+	die "'$sha1' not found in repository" if $type eq 'missing';
+	$self->{object_stdout}->read(my $content, $size);
+	$self->{object_stdout}->getline;  # eat trailing newline
+	return wantarray ? ($type, $content) : $content;
+}
+
+=item $repo->get_commit($commit_sha1)
+
+Return a new L<Git::Commit> instance referring to the commit object
+with SHA1 $commit_sha1.
+
+=cut
+
+sub get_commit {
+	my ($self, $sha1) = @_;
+	_assert_sha1($sha1);
+	return Git::Commit->new($self, $sha1);
+}
+
+=item $repo->get_tag($tag_sha1)
+
+Return a new L<Git::Tag> instance referring to the tag object with SHA1
+$tag_sha1.
+
+=cut
+
+sub get_tag {
+	my ($self, $sha1) = @_;
+	_assert_sha1($sha1);
+	return Git::Tag->new($self, $sha1);
+}
+
+=item $repo->name_rev($committish_sha1, $tags_only = 0)
+
+Return a symbolic name for the commit identified by $committish_sha1,
+or undef if no name can be found; see L<git-name-rev(1)> for details.
+If $tags_only is true, no branch names are used to name the commit.
+
+=cut
+
+sub name_rev {
+	my ($self, $sha1, $tags_only) = @_;
+	_assert_sha1($sha1);
+
+	# Note that we cannot use a bidi pipe here since name git
+	# name-rev --stdin has an excessively high start-up time.
+	# http://thread.gmane.org/gmane.comp.version-control.git/85531
+	open my $fh, '-|', $self->_git_cmd, 'name-rev',
+		$tags_only ? '--tags' : (), '--name-only', $sha1
+	    or die 'error calling git binary';
+	chomp(my $name = <$fh>);
+	close $fh or die 'git name-rev returned an unexpected error';
+	return $name eq 'undefined' ? undef : $name;
+}
+
+
+1;
diff --git a/perl/Git/RepoRoot.pm b/perl/Git/RepoRoot.pm
new file mode 100644
index 0000000..6c8e749
--- /dev/null
+++ b/perl/Git/RepoRoot.pm
@@ -0,0 +1,103 @@
+=head1 NAME
+
+Git::RepoRoot - A factory class representing a root directory
+containing Git repositories.
+
+=head1 DESCRIPTION
+
+Git::RepoRoot is a factory class to create L<Git::Repo> instances that
+are located under a common root directory.  It also allows for
+specifying options that all Git::Repo instances will be created with.
+
+Using Git::RepoRoot to create Git::Repo instances is entirely
+optional, but can be more convenient than instantiating them directly.
+
+=cut
+
+
+use strict;
+use warnings;
+
+
+package Git::RepoRoot;
+
+use File::Spec;
+
+use Git::Repo;
+
+use base qw(Exporter);
+
+our @EXPORT = qw();
+our @EXPORT_OK = qw();
+
+=head1 METHODS
+
+=over
+
+=item $repo_root = Git::RepoRoot->new(%opts)
+
+Return a new Git::RepoRoot object.  The following options are
+supported:
+
+=over
+
+=item 'root_dir'
+
+The directory holding all repositories.
+
+=back
+
+All other options will be passed through to Git::Repo->new.
+
+Example:
+
+    $repo_root = Git::RepoRoot->new(root_dir => '/pub/git',
+                                    git_binary => '/usr/bin/git');
+
+=cut
+
+sub new {
+	my $class = shift;
+	Git::Repo::_assert_opts(@_);
+	my $self = {@_};
+	bless $self, $class;
+	die 'no root_dir given' unless $self->{root_dir};
+	return $self;
+}
+
+=item $repo_root->repo(%opts)
+
+Return a new L<Git::Repo> object.  The following options are
+supported:
+
+=over
+
+=item 'root_dir'
+
+The path of the repository relative to the repository root.
+
+=item 'repo_class'
+
+The Repo class to instantiate (default: 'Git::Repo').
+
+=back
+
+All other options are passed through to Git::Repo.
+
+=cut
+
+sub repo {
+	my $self = shift;
+	Git::Repo::_assert_opts(@_);
+	my %opts = (%$self, @_);
+	die 'no repo_dir given' unless $opts{repo_dir};
+	# not technically necessary, but to guard against errors in the caller:
+	die "you passed an absolute path ($opts{repo_dir})"
+	    if $opts{repo_dir} =~ m!^/!;
+	my $repo_class = delete $opts{repo_class} || 'Git::Repo';
+	$opts{repo_dir} = File::Spec->catfile($self->{root_dir}, $opts{repo_dir});
+	return $repo_class->new(%opts);
+}
+
+
+1;
diff --git a/perl/Git/Tag.pm b/perl/Git/Tag.pm
new file mode 100644
index 0000000..07559a4
--- /dev/null
+++ b/perl/Git/Tag.pm
@@ -0,0 +1,169 @@
+=head1 NAME
+
+Git::Tag - Object-oriented interface to Git tag objects.
+
+=head1 DESCRIPTION
+
+Git::Tag is a class representing a tag object in a Git repository.  It
+stringifies to the tag object's SHA1.
+
+=cut
+
+use strict;
+use warnings;
+
+
+package Git::Tag;
+
+use base qw(Git::Object);
+
+
+# Keep documentation in one place to save space.
+
+=head1 METHODS
+
+=head2 General Methods
+
+=over
+
+=item $tag = Git::Tag->new($repo, $sha1)
+
+Return a new Git::Tag instance for a tag object with $sha1 in
+repository $repo.
+
+The tag object is loaded lazily.  Hence, calls to this method are
+free, and it does not check whether $sha1 exists and has the right
+type.  However, accessing any of the tag object's properties will fail
+if $sha1 is not a valid tag object.
+
+The tagger and message methods return Unicoded strings, decoded
+according to the "encoding" header, with UTF-8 and then Latin-1 as
+fallbacks.  (These Unicode strings can contain code points greater
+than 256 and are *not* UTF-8 strings; see man perlunitut on how Perl
+handles Unicode.)
+
+You will usually want to call $repo->get_tag($sha1) instead of
+instantiating this class directly; see L<Git::Repo>.
+
+=item $obj->repo
+
+Return the Git::Repo instance this object was instantiated with.
+
+=item $obj->sha1
+
+Return the SHA1 of this tag object, as provided at instantiation time.
+
+=back
+
+=head2 Property Methods
+
+Calling any of these methods will cause the commit object to be loaded
+from the repository, if it hasn't been loaded already.
+
+=over
+
+=item $tag->object
+
+Return the SHA1 string of the object referenced by this tag.
+
+=item $tag->type
+
+Return the type of the referenced object, as claimed by the tag
+object.  This is usually 'commit', but can be any of 'tag', 'commit',
+'tree', or 'blob'.
+
+=item $tag->tagger
+
+Return the tagger string of this tag object.
+
+=item $tag->message
+
+Return the undecoded tag message of this tag object.
+
+=item $tag->encoding
+
+Return the encoding header of the tag object, or undef if no encoding
+header is present; note that Git::Tag does the necessary decoding for
+you, so you should not normally need this method.
+
+=back
+
+=cut
+
+
+sub object {
+	my $self = shift;
+	$self->_load;
+	return $self->{object};
+}
+
+sub type {
+	my $self = shift;
+	$self->_load;
+	return $self->{type};
+}
+
+sub tag {
+	my $self = shift;
+	$self->_load;
+	return $self->_decode($self->{tag});
+}
+
+sub tagger {
+	my $self = shift;
+	$self->_load;
+	return $self->_decode($self->{tagger});
+}
+
+sub message {
+	my $self = shift;
+	$self->_load;
+	return $self->_decode($self->{message});
+}
+
+sub encoding {
+	my $self = shift;
+	$self->_load;
+	return $self->{encoding};
+}
+
+# Auxiliary method to load (and parse) the tag object from the
+# repository if it hasn't already been loaded.  Optional parameter:
+# The raw contents of the tag object; the tag object will be retrieved
+# from the repository if that parameter is not given.
+sub _load {
+	my ($self, $raw_text) = shift;
+	return if exists $self->{message};  # already loaded
+
+	my $sha1 = $self->sha1;
+	if (!defined $raw_text) {
+		(my $type, $raw_text) = $self->repo->get_object($sha1);
+		die "$sha1 is a $type object (expected a tag object)"
+		    unless $type eq 'tag';
+	}
+
+	(my $header, $self->{message}) = split "\n\n", $raw_text, 2;
+	# Parse header.
+	for my $line (split "\n", $header) {
+		local $/ = "\n"; # for chomp
+		chomp($line);
+		my ($key, $value) = split ' ', $line, 2;
+		if ($key eq 'object') {
+			$self->{object} = $value;
+		} elsif ($key eq 'type') {
+			$self->{type} = $value;
+		} elsif ($key eq 'tag') {
+			$self->{tag} = $value;
+		} elsif ($key eq 'tagger') {
+			$self->{tagger} = $value;
+		} elsif ($key eq 'encoding') {
+			$self->{encoding} = $value;
+		} else {
+			# Ignore unrecognized header lines.
+		}
+	}
+	undef;
+}
+
+
+1;
diff --git a/perl/Makefile b/perl/Makefile
index e3dd1a5..4572dc5 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -31,6 +31,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo install: >> $@
 	echo '	mkdir -p "$(instdir_SQ)"' >> $@
 	echo '	$(RM) "$(instdir_SQ)/Git.pm"; cp Git.pm "$(instdir_SQ)"' >> $@
+	echo '	mkdir -p "$(instdir_SQ)/Git"; $(RM) "$(instdir_SQ)"/Git/*.pm; cp Git/*.pm "$(instdir_SQ)/Git"' >> $@
 	echo '	$(RM) "$(instdir_SQ)/Error.pm"' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
 	echo '	cp private-Error.pm "$(instdir_SQ)/Error.pm"' >> $@
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 320253e..6c62160 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -8,7 +8,15 @@ instlibdir:
 MAKE_FRAG
 }
 
-my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm');
+# Note that when changing %pm, you'll have to remove pm_to_blib rather
+# than the blib directory to .force the .pm files to be re-installed
+# to blib/lib.
+my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm',
+	  'Git/Repo.pm' => '$(INST_LIBDIR)/Git/Repo.pm',
+	  'Git/RepoRoot.pm' => '$(INST_LIBDIR)/Git/RepoRoot.pm',
+	  'Git/Commit.pm' => '$(INST_LIBDIR)/Git/Commit.pm',
+	  'Git/Tag.pm' => '$(INST_LIBDIR)/Git/Tag.pm',
+	  'Git/Object.pm' => '$(INST_LIBDIR)/Git/Object.pm');
 
 # We come with our own bundled Error.pm. It's not in the set of default
 # Perl modules so install it if it's not available on the system yet.
diff --git a/t/t9710-perl-git-repo.sh b/t/t9710-perl-git-repo.sh
new file mode 100755
index 0000000..eca283d
--- /dev/null
+++ b/t/t9710-perl-git-repo.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Lea Wiemann
+#
+
+test_description='perl interface (Git/*.pm)'
+. ./test-lib.sh
+
+"$PERL_PATH" -e 'use 5.008' 2>/dev/null || {
+	say_color skip "Perl version older than 5.8, skipping test"
+	test_done
+}
+
+# Set up test repository.  Tagging/branching is a little tricky
+# because it needs to stay unambiguous for the name_rev tests.
+
+test_expect_success \
+    'set up test repository' \
+    'echo "test file 1" > file1 &&
+     echo "test file 2" > file2 &&
+     mkdir directory1 &&
+     echo "in directory1" >> directory1/file &&
+     mkdir directory2 &&
+     echo "in directory2" >> directory2/file &&
+     git add . &&
+     git commit -m "first commit" &&
+
+     git tag -a -m "tag message 1" tag-object-1 &&
+
+     echo "changed file 1" > file1 &&
+     git commit -a -m "second commit" &&
+
+     git branch branch-2 &&
+
+     echo "changed file 2" > file2 &&
+     git commit -a -m "third commit" &&
+
+     git tag -a -m "tag message 3" tag-object-3 &&
+     git tag -a -m "indirect tag message 3" indirect-tag-3 tag-object-3 &&
+
+     echo "changed file 1 again" > file1 &&
+     git commit -a -m "fourth commit"
+     '
+
+test_external_without_stderr \
+    'Git::Repo API' \
+    "$PERL_PATH" ../t9710/test.pl
+
+test_done
diff --git a/t/t9710/test.pl b/t/t9710/test.pl
new file mode 100755
index 0000000..8fca725
--- /dev/null
+++ b/t/t9710/test.pl
@@ -0,0 +1,136 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Test::More qw(no_plan);
+use Cwd;
+use File::Basename;
+use File::Temp;
+
+BEGIN { use_ok('Git::Repo') }
+
+sub dies_ok (&;$) {
+	my ($coderef, $descr) = @_;
+	eval { $coderef->(); };
+	ok($@, $descr);
+}
+
+sub lives_ok (&;$) {
+	my ($coderef, $descr) = @_;
+	eval { $coderef->(); };
+	ok(!$@, $descr);
+}
+
+our $old_stderr;
+sub discard_stderr {
+	open our $old_stderr, ">&", STDERR or die "cannot save STDERR";
+	close STDERR;
+}
+sub restore_stderr {
+	open STDERR, ">&", $old_stderr or die "cannot restore STDERR";
+}
+
+# set up
+our $abs_wc_dir = Cwd->cwd;
+ok(our $r = Git::Repo->new(repo_dir => "./.git"), 'open repository');
+sub rev_parse {
+	my $name = shift;
+	chomp(my $sha1 = `git rev-parse $name 2> /dev/null`);
+	$sha1 or undef;
+}
+
+my @revisions = split /\s/, `git-rev-list --first-parent HEAD`;
+my $head = $revisions[0];
+
+# get_sha1
+is($r->get_sha1('HEAD'), $head, 'get_sha1: scalar');
+is($r->get_sha1('HEAD'), $head, 'get_sha1: scalar, repeated');
+my($sha1, $type, $head_size) = $r->get_sha1('HEAD');
+is($sha1, $head, 'get_sha1: array (SHA1)');
+is($type, 'commit', 'get_sha1: array (commit)');
+ok($head_size > 0, 'get_sha1: array (size)');
+
+# get_object
+is_deeply([$r->get_object($r->get_sha1("$revisions[-1]:file1"))], ['blob', "test file 1\n"], 'get_object: blob');
+is_deeply([$r->get_object($r->get_sha1("$revisions[-1]:file1"))], ['blob', "test file 1\n"], 'get_object: blob, repeated');
+dies_ok { $r->get_object('0' x 40) } 'get_object: non-existent sha1';
+
+# get_commit
+isa_ok($r->get_commit($revisions[-1]), 'Git::Commit',
+       'get_commit: returns Git::Commit object');
+
+# get_tag
+isa_ok($r->get_tag($r->get_sha1('tag-object-1')), 'Git::Tag',
+       'get_tag: returns Git::Tag object');
+
+# name_rev
+is($r->name_rev($revisions[-2]), 'branch-2', 'name_rev: branch');
+is($r->name_rev($head, 1), undef, 'name_rev: branch, tags only');
+is($r->name_rev($revisions[-1]), 'tags/tag-object-1^0', 'name_rev: tag object');
+is($r->name_rev($revisions[-1], 1), 'tag-object-1^0', 'name_rev: tag object, tags only');
+
+
+
+# Git::Commmit
+print "# Git::Commit:\n";
+
+BEGIN { use_ok('Git::Commit') }
+
+my $invalid_commit = Git::Commit->new($r, '0' x 40);
+is($invalid_commit->sha1, '0' x 40, 'new, sha1: accept invalid SHA1');
+dies_ok { $invalid_commit->tree } 'die on accessing properties of invalid SHA1s';
+
+$invalid_commit = Git::Commit->new($r, $r->get_sha1('HEAD:')); # tree, not commit
+dies_ok { $invalid_commit->tree } 'die on accessing properties of non-commit objects';
+
+my $c = Git::Commit->new($r, $revisions[-2]);
+is($c->repo, $r, 'repo: basic');
+is($c->sha1, $revisions[-2], 'sha1: basic');
+is($c->{parents}, undef, 'lazy loading: not loaded after reading SHA1');
+is($c->tree, $r->get_sha1("$revisions[-2]:"), 'tree: basic');
+ok($c->{parents}, 'lazy loading: loaded after reading tree');
+is_deeply([$c->parents], [$revisions[-1]], 'parents: basic');
+like($c->author, qr/A U Thor <author\@example.com> [0-9]+ \+0000/, 'author: basic');
+like($c->committer, qr/C O Mitter <committer\@example.com> [0-9]+ \+0000/, 'committer: basic');
+is($c->encoding, undef, 'encoding: undef');
+is($c->message, "second commit\n", 'message: basic');
+is($c, $c->sha1, 'stringify: basic');
+
+# error handling
+dies_ok { Git::Commit->new($r, $r->get_sha1('tag-object-3'))->_load }
+    'new: pass tag SHA1 (dies)';
+dies_ok { Git::Commit->new($r, '0' x 40)->_load }
+    'new: pass invalid SHA1 (dies)';
+
+
+# Git::Tag
+print "# Git::Tag:\n";
+
+BEGIN { use_ok('Git::Tag') }
+
+# We don't test functionality inherited from Git::Object that we
+# already tested in the Git::Commit tests.
+
+my $t = Git::Tag->new($r, $r->get_sha1('tag-object-1'));
+is($t->tag, 'tag-object-1', 'tag: basic');
+is($t->object, $revisions[-1], 'object: basic');
+is($t->type, 'commit', 'tag: type');
+like($t->tagger, qr/C O Mitter <committer\@example.com> [0-9]+ \+0000/, 'tagger: basic');
+is($t->encoding, undef, 'encoding: undef');
+is($t->message, "tag message 1\n", 'message: basic');
+
+# error handling
+dies_ok { Git::Tag->new($r, $head)->_load } 'new: pass commit SHA1 (dies)';
+dies_ok { Git::Tag->new($r, '0' x 40)->_load } 'new: pass invalid SHA1 (dies)';
+
+
+# Git::RepoRoot
+print "# Git::RepoRoot:\n";
+
+BEGIN { use_ok('Git::RepoRoot'); }
+
+my $reporoot = Git::RepoRoot->new(root_dir => $abs_wc_dir);
+is($reporoot->repo(repo_dir => '.git')->get_sha1('HEAD'), $head,
+   'repo: basic');
-- 
1.6.0.90.gf3f7b
