Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE22350D42
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840288; cv=none; b=DcOzA6bYFHAUSv2OdAAb+ouSyLv5xe5/m7jUdyPVzR3D1O2LCV/dGt8CpuGMQDHkVnbxPQd//afxec9eMDVwI2BIhRwp3sHYjr7omBgu3ZJSE4nY34yu98kx6HSE7uelfXL5UAXB57DOOJc8JuRvaTGamAUZTFGuRvRGQKvmoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840288; c=relaxed/simple;
	bh=ddem7/+J37dg2VVlLjwNDM5jgASJvsOshMW96oB4KZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i9a40eY/DcS1qpEWDEFVoAZFzSpg2bFSqkyfa0bOekMgjkWMoVZqJk6DLBQKv2RPCzRU1fbTD4vqNEqFbpfiSfcN/PQ7QPDx/vvLK6yOBxY370+Yq4YcuAM6ejV6EpJj7EFrku1IEj0VUlabzqVcevysjUkR7uW/tXNDfDEDXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=b5UUfmrF; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="b5UUfmrF"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88432efaf45so51692539f.3
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 12:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756840285; x=1757445085; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NO3KcUJ8oI/lqUcaW74OayK4V6JHH9qv4uh5haWklc=;
        b=b5UUfmrFQM5y37ClDCtnDKI4cimF19+TpuHQpnCWu22MlK8mumwLZuA4Y5HgnVDGZu
         BlkpN22hSBxZIkqG7usknBSEHzVQ7AP2EwgwhxyVcHRZJnJCTKT7MkhPRqKR2Y3ZwFhM
         HQ9BseZN7Dq2ok6/k7yZm9x+DcC9Qz6LsM6pdMY9vhyL1QIhthTgFp8KwDvXKDr533Ke
         pGH25BtWTmrlqFnpVDpKuPckm6Ga/F5e0JzEYlpBEVmSrMbSmT8XzVWBzAm7bKZDmxo0
         ky2XYXCLEKFhfZr7gYHa/dxA85nGF5EQ8JbE+B7X/DL/MNEAPaAxS+mLVJQfg0liQGvx
         LbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756840285; x=1757445085;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NO3KcUJ8oI/lqUcaW74OayK4V6JHH9qv4uh5haWklc=;
        b=gpe/FobP3IEIYdV1DMTkJodf3OZb31UcG1USn9Y9+pScatTv7roqXw465qDm5UVPIN
         6p6dVh9WeljSnO3f2W8aAsjqCkmpBLqkGVp5CpgUdOBXHXXwE9oyBjWqf6iM6xI3OALr
         8lkCuWKxcwVDh9D8+HB50vhvXxUAYoZ6DwY09ahu0f67S9pA1lX5KnYB7LiEws7K6uIi
         GHPRdPChp2k2MervtcoqQg5/slCcWzUsn/MrxESrBehaDd1VWZ69zTejZdZxbtE7fXN8
         mEShwq4EfF0UVyYmUYCGVu9WDrXmv3FkyiYpHxAXVFntFgyVj0t5q6lkV10Iq5gjLD6w
         dC0g==
X-Gm-Message-State: AOJu0YyMy5XCUP7KpvlEaJFfiywSWFQyPwOBoOwtAk+j3lKhEBKq5qjY
	b+piobisor0MALtgLhyGlUXOIMxb48s269HFs/SBCzqRyv0ABsWvwky5VU8dYV1muGzVvpQmzZQ
	wKDRJ
X-Gm-Gg: ASbGncvRvUEUVuqnLmAFxx+pgqFXjLnS49cnPwYGh3GC546VlnnMyzYf21QVZVnBSMR
	ZZtmoqZ/HaF933G9MtMYfNhVPfFr4cASXiptqrdX9qTaAU9hzlM3LqjcWIpVoeW5ozc8v6kCt+f
	VwprW/eHd9AUBPYPqXPWOvuX8MTuyGGyQWrKcLg8btm1B4Yca/Bs4MEW2ASl6y1ycCyfEjgPh4m
	Bma/zNmh4oRzNF6p506BwyryMaJ1i8ocT279HE9f211zs83rsey/VjbwR8x2PzCHRzld48KthG8
	W1NlLrN14Pf3Zq2iNjwiNHfaHAiqkQWZEQvUAQdRh4sE33tutGJpiu/IvsXu8n+zN6wFMLl+oce
	+EnfBczhfoeADY8BmoukOXbiOl4ybopIUMbXyCdC07le7bnlNCqT7pFiTRhID0y6ua1JEzUeyg4
	zczYJdSJcn1s+aNtlowIHcO28zJg==
X-Google-Smtp-Source: AGHT+IHEFtgjMFUlkE7wS5jQp/VUHX0eRjJ5jOMp3UYA6gWHc0yx+lc7jqzAQCHJ/425cz0EDhCxHQ==
X-Received: by 2002:a05:6e02:214e:b0:3f0:f22:53df with SMTP id e9e14a558f8ab-3f4026c2d34mr188283065ab.31.1756840284471;
        Tue, 02 Sep 2025 12:11:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50d8f0d56d2sm3379023173.30.2025.09.02.12.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 12:11:24 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:11:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Moritz Sanft <moritz.sanft@outlook.de>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] gitweb: plug various command-line option injection holes
Message-ID: <22c8463a5eebc609b4848f6db1db231fcce7d839.1756840261.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When running Gitweb and loading a blobdiff with the "hpb" ("hash parent
base") query parameter set to a valid diff-tree option, say,
"--output=/tmp/pwned", Gitweb will faithfully execute "diff-tree"
internally (via "sub git_blobdiff") and blindly pass in the "hpb" query
parameter.

In other words, visiting a URL like:

    http://127.0.0.1:1234/?p=<PROJECT_NAME>;a=blobdiff;f=*;hpb=--output=/tmp/pwned;hb=HEAD

will result in the file "/tmp/pwned" being created. This happens as a
result of gitweb executing something like:

    git diff-tree -r -M --output=/tmp/pwned HEAD --

, where "--output=/tmp/pwned" is substituted in as the value of
"$hash_parent_base".

There are various other spots in Gitweb which are too eager to pass
untrusted query parameter values as command-line arguments, leading to
at least the above option-injection attack, and likely many others.

Since 51b4594b40 (parse-options: allow --end-of-options as a synonym for
"--", 2019-08-06), we have the "--end-of-options" command-line flag as
a standard mechanism to indicate that any further argument should not be
interpreted as command-line options.

Guard agains this and other option-injection attacks by placing the
"--end-of-options" flag before any untrusted user-input in any place
that gitweb spawns Git as a sub-process.

Reported-by: Moritz Sanft <moritz.sanft@outlook.de>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 gitweb/gitweb.perl | 77 +++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b5490dfecf2..a0f2c981e33 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2722,7 +2722,7 @@ sub git_get_hash {
 	my $retval = undef;
 	$git_dir = "$projectroot/$project";
 	if (open my $fd, '-|', git_cmd(), 'rev-parse',
-	    '--verify', '-q', @options, $hash) {
+	    '--verify', '-q', @options, '--end-of-options', $hash) {
 		$retval = <$fd>;
 		chomp $retval if defined $retval;
 		close $fd;
@@ -2737,7 +2737,9 @@ sub git_get_hash {
 sub git_get_type {
 	my $hash = shift;
 
-	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
+	open my $fd, "-|", git_cmd(), "cat-file", '-t', '--end-of-options',
+		$hash
+		or return;
 	my $type = <$fd>;
 	close $fd or return;
 	chomp $type;
@@ -2885,7 +2887,8 @@ sub git_get_hash_by_path {
 
 	$path =~ s,/+$,,;
 
-	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
+	open my $fd, "-|", git_cmd(), "ls-tree", "--end-of-options", $base,
+		"--", $path
 		or die_error(500, "Open git-ls-tree failed");
 	my $line = <$fd>;
 	close $fd or return undef;
@@ -2912,7 +2915,8 @@ sub git_get_path_by_hash {
 
 	local $/ = "\0";
 
-	open my $fd, "-|", git_cmd(), "ls-tree", '-r', '-t', '-z', $base
+	open my $fd, "-|", git_cmd(), "ls-tree", '-r', '-t', '-z',
+		'--end-of-options', $base
 		or return undef;
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -3334,6 +3338,7 @@ sub git_get_last_activity {
 	     '--format=%(committer)',
 	     '--sort=-committerdate',
 	     '--count=1',
+	     '--end-of-options',
 	     map { "refs/$_" } get_branch_refs ()) or return;
 	my $most_recent = <$fd>;
 	close $fd or return;
@@ -3390,6 +3395,7 @@ sub git_get_references {
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
 	open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
+		"--end-of-options",
 		($type ? ("--", "refs/$type") : ()) # use -- <pattern> if $type
 		or return;
 
@@ -3410,7 +3416,8 @@ sub git_get_references {
 sub git_get_rev_name_tags {
 	my $hash = shift || return undef;
 
-	open my $fd, "-|", git_cmd(), "name-rev", "--tags", $hash
+	open my $fd, "-|", git_cmd(), "name-rev", "--tags", "--end-of-options",
+		$hash
 		or return;
 	my $name_rev = <$fd>;
 	close $fd;
@@ -3472,7 +3479,9 @@ sub parse_tag {
 	my %tag;
 	my @comment;
 
-	open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;
+	open my $fd, "-|", git_cmd(), "cat-file", "tag", "--end-of-options",
+		$tag_id
+		or return;
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -3600,6 +3609,7 @@ sub parse_commit {
 		"--parents",
 		"--header",
 		"--max-count=1",
+		"--end-of-options",
 		$commit_id,
 		"--",
 		or die_error(500, "Open git-rev-list failed");
@@ -3624,6 +3634,7 @@ sub parse_commits {
 		("--max-count=" . $maxcount),
 		("--skip=" . $skip),
 		@extra_options,
+		"--end-of-options",
 		$commit_id,
 		"--",
 		($filename ? ($filename) : ())
@@ -3784,6 +3795,7 @@ sub git_get_heads_list {
 		($limit ? '--count='.($limit+1) : ()),
 		'--sort=-HEAD', '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
+		'--end-of-options',
 		@patterns
 		or return;
 	while (my $line = <$fd>) {
@@ -3998,7 +4010,8 @@ sub run_highlighter {
 
 	close $fd;
 	my $syntax_arg = (defined $syntax) ? "--syntax $syntax" : "--force";
-	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
+	open $fd, quote_command(git_cmd(), "cat-file", "blob",
+		    "--end-of-options", $hash)." | ".
 	          quote_command($^X, '-CO', '-MEncode=decode,FB_DEFAULT', '-pse',
 	            '$_ = decode($fe, $_, FB_DEFAULT) if !utf8::decode($_);',
 	            '--', "-fe=$fallback_encoding")." | ".
@@ -4687,7 +4700,8 @@ sub git_get_link_target {
 	my $link_target;
 
 	# read link
-	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
+	open my $fd, "-|", git_cmd(), "cat-file", "blob", "--end-of-options",
+		$hash
 		or return;
 	{
 		local $/ = undef;
@@ -6377,7 +6391,7 @@ sub git_search_files {
 
 	local $/ = "\n";
 	open my $fd, "-|", git_cmd(), 'grep', '-n', '-z',
-		$search_use_regexp ? ('-E', '-i') : '-F',
+		$search_use_regexp ? ('-E', '-i') : '-F', '--end-of-options',
 		$searchtext, $co{'tree'}
 			or die_error(500, "Open git-grep failed");
 
@@ -6768,17 +6782,18 @@ sub git_blame_common {
 	my $fd;
 	if ($format eq 'incremental') {
 		# get file contents (as base)
-		open $fd, "-|", git_cmd(), 'cat-file', 'blob', $hash
+		open $fd, "-|", git_cmd(), 'cat-file', 'blob',
+			'--end-of-options', $hash
 			or die_error(500, "Open git-cat-file failed");
 	} elsif ($format eq 'data') {
 		# run git-blame --incremental
 		open $fd, "-|", git_cmd(), "blame", "--incremental",
-			$hash_base, "--", $file_name
+			"--end-of-options", $hash_base, "--", $file_name
 			or die_error(500, "Open git-blame --incremental failed");
 	} else {
 		# run git-blame --porcelain
 		open $fd, "-|", git_cmd(), "blame", '-p',
-			$hash_base, '--', $file_name
+			"--end-of-options", $hash_base, '--', $file_name
 			or die_error(500, "Open git-blame --porcelain failed");
 	}
 	binmode $fd, ':utf8';
@@ -7058,7 +7073,8 @@ sub git_blob_plain {
 		$expires = "+1d";
 	}
 
-	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
+	open my $fd, "-|", git_cmd(), "cat-file", "blob", "--end-of-options",
+		$hash
 		or die_error(500, "Open git-cat-file blob '$hash' failed");
 
 	# content-type (can include charset)
@@ -7121,7 +7137,8 @@ sub git_blob {
 	}
 
 	my $have_blame = gitweb_check_feature('blame');
-	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
+	open my $fd, "-|", git_cmd(), "cat-file", "blob", "--end-of-options",
+		$hash
 		or die_error(500, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
 	# use 'blob_plain' (aka 'raw') view for files that cannot be displayed
@@ -7216,7 +7233,8 @@ sub git_tree {
 	{
 		local $/ = "\0";
 		open my $fd, "-|", git_cmd(), "ls-tree", '-z',
-			($show_sizes ? '-l' : ()), @extra_options, $hash
+			($show_sizes ? '-l' : ()), @extra_options,
+			"--end-of-options", $hash
 			or die_error(500, "Open git-ls-tree failed");
 		@entries = map { chomp; $_ } <$fd>;
 		close $fd
@@ -7417,7 +7435,7 @@ sub git_snapshot {
 	my $cmd = quote_command(
 		git_cmd(), 'archive',
 		"--format=$known_snapshot_formats{$format}{'format'}",
-		"--prefix=$prefix/", $hash);
+		"--prefix=$prefix/", "--end-of-options", $hash);
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
 		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
 	}
@@ -7569,6 +7587,7 @@ sub git_commit {
 	open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
 		@diff_opts,
 		(@$parents <= 1 ? $parent : '-c'),
+		"--end-of-options",
 		$hash, "--"
 		or die_error(500, "Open git-diff-tree failed");
 	@difftree = map { chomp; $_ } <$fd>;
@@ -7649,7 +7668,8 @@ sub git_object {
 		my $object_id = $hash || $hash_base;
 
 		open my $fd, "-|", quote_command(
-			git_cmd(), 'cat-file', '-t', $object_id) . ' 2> /dev/null'
+			git_cmd(), 'cat-file', '-t', '--end-of-options',
+			$object_id) . ' 2> /dev/null'
 			or die_error(404, "Object does not exist");
 		$type = <$fd>;
 		defined $type && chomp $type;
@@ -7660,11 +7680,13 @@ sub git_object {
 	} elsif ($hash_base && defined $file_name) {
 		$file_name =~ s,/+$,,;
 
-		system(git_cmd(), "cat-file", '-e', $hash_base) == 0
+		system(git_cmd(), "cat-file", '-e', '--end-of-options',
+			$hash_base) == 0
 			or die_error(404, "Base object does not exist");
 
 		# here errors should not happen
-		open my $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $file_name
+		open my $fd, "-|", git_cmd(), "ls-tree", "--end-of-options",
+			$hash_base, "--", $file_name
 			or die_error(500, "Open git-ls-tree failed");
 		my $line = <$fd>;
 		close $fd;
@@ -7700,7 +7722,7 @@ sub git_blobdiff {
 		if (defined $file_name) {
 			# read raw output
 			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-				$hash_parent_base, $hash_base,
+				"--end-of-options", $hash_parent_base, $hash_base,
 				"--", (defined $file_parent ? $file_parent : ()), $file_name
 				or die_error(500, "Open git-diff-tree failed");
 			@difftree = map { chomp; $_ } <$fd>;
@@ -7715,7 +7737,8 @@ sub git_blobdiff {
 
 			# read filtered raw output
 			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-				$hash_parent_base, $hash_base, "--"
+				"--end-of-options", $hash_parent_base, $hash_base,
+				"--"
 				or die_error(500, "Open git-diff-tree failed");
 			@difftree =
 				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
@@ -7751,6 +7774,7 @@ sub git_blobdiff {
 		# open patch output
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', ($format eq 'html' ? "--full-index" : ()),
+			"--end-of-options",
 			$hash_parent_base, $hash_base,
 			"--", (defined $file_parent ? $file_parent : ()), $file_name
 			or die_error(500, "Open git-diff-tree failed");
@@ -7945,7 +7969,7 @@ sub git_commitdiff {
 	if ($format eq 'html') {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			"--no-commit-id", "--patch-with-raw", "--full-index",
-			$hash_parent_param, $hash, "--"
+			"--end-of-options", $hash_parent_param, $hash, "--",
 			or die_error(500, "Open git-diff-tree failed");
 
 		while (my $line = <$fd>) {
@@ -7957,7 +7981,8 @@ sub git_commitdiff {
 
 	} elsif ($format eq 'plain') {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			'-p', $hash_parent_param, $hash, "--"
+			'-p', '--end-of-options', $hash_parent_param, $hash,
+			"--"
 			or die_error(500, "Open git-diff-tree failed");
 	} elsif ($format eq 'patch') {
 		# For commit ranges, we limit the output to the number of
@@ -7982,7 +8007,8 @@ sub git_commitdiff {
 			push @commit_spec, '--root', $hash;
 		}
 		open $fd, "-|", git_cmd(), "format-patch", @diff_opts,
-			'--encoding=utf8', '--stdout', @commit_spec
+			'--encoding=utf8', '--stdout', '--end-of-options',
+			@commit_spec
 			or die_error(500, "Open git-format-patch failed");
 	} else {
 		die_error(400, "Unknown commitdiff format");
@@ -8334,7 +8360,8 @@ sub git_feed {
 		# get list of changed files
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			$co{'parent'} || "--root",
-			$co{'id'}, "--", (defined $file_name ? $file_name : ())
+			$co{'id'}, "--end-of-options", "--",
+			(defined $file_name ? $file_name : ())
 			or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd

base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
-- 
2.51.0.179.g22c8463a5ee
