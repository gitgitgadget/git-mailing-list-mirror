Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A720B1F4
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373799; cv=none; b=IQRFK6eRD04mn6SmKl2G0Gpaa2ds2eI2TTkC+wXkTx3puOQTO3dwytE8ZhL0X1YveJuBlXhTRbqyvaKELA26xBb8oGNsf/oip26ECs9/Vq/hVGYlLffUx7kwtAfu+WTnmnWrBUsbyIKEo//s7BOqNrX5VmwTKmPfXjfJdB9iLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373799; c=relaxed/simple;
	bh=kWuaNQi+y+LTZXTZk8NBDHj1F3vsdbh33gMSDYt0JTk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=X3zIZ94uz31XGmMrl7FeqekZDQjHGzegXBlwZryUD9Etcud3yraIllLaExbOUOoc8J4V5hEV9js6sRl+9++XxqwLI5rEcmv7X97FRga30fsqB6khqjJ2fbC0iI0/exC1mce0zj6zWaHh6NnbCRH/FlFdnKwxu5+aGGZR2AnRb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RorbmIko; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RorbmIko"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a365a6804eso2099148f8f.3
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373794; x=1749978594; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFq8XdZUfP/UyrFeVzJzb0UTJwlafu1Zd7mPdwzggKY=;
        b=RorbmIkoaACEt4ozgwSTGoURuIo4iQr+hkOlt6vSbnuyi2FG8WAdHd28m+Osk63eff
         MAVUC4iKIcUCiOIelo5Z/T00QZDQywH9GC2wWs06MC5kUTZTzV5rzouqdOx4TK62yQZR
         /2K640Vqo912VYG6r6Br+Oeb/GHjMU//hQmQeXqtpBXpiukDV0Hz+aJk7Scj2BOgIwGX
         /ITY5SJithenCUMJ0J5KtZiiiTWq2BMxPkkifhASgWWylH4eVN1gun+qzJ5H781u7BPW
         pcYvW4faU+Xt8LkMMoI5g4ZlFS9Gkv0XSlZRaKGCupH6OieN4Y5KqDgFfzsrgE8Xyxrr
         4/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373794; x=1749978594;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFq8XdZUfP/UyrFeVzJzb0UTJwlafu1Zd7mPdwzggKY=;
        b=K5sMKJk8d9JnO/IYremPeJlybmXivicGXHIF8bxSKZfmHLETAyioGLy++IBvBKbasK
         s8E5jrrXwpM2nKeZYS/AQkqjp1O6EXq0N7tE6yaS7AQtNE+RF4V6+pxXRdA4jf1miOmn
         4vXsf4472QW5O+IHuKGIeIwu/GZMXX+PW+2g/eNe7XUk2EqbZ2PWaeFLYFsH0I2E317s
         aTYjUFKXkQh4WxHmXrX/wcvNkcVXAlzRIpk2LJRGcb9x4ek+WDniEKFi115D6EuwkcJ1
         HJVs+jHHFNds2YaQYOUYk4laMi70+PaZM7SqIEg6L1ko/SGmYG1+OzMbAqtQBXVAqbNR
         lpaw==
X-Gm-Message-State: AOJu0YyMwSQ1tz5/dvcmguv8CPLnXUO9dlmZDU1DSBZdKK55Dcft7Jvh
	H85iAuPcMvhllrlE6NKHqC7IXN7Gawzy+NZ4NxQSI3c5wknRMetOxDNTHujhtQ==
X-Gm-Gg: ASbGncuqOMkO5RjPTne58HmUyT64tchcTlntFoSsl5Bkdmoy4iXD7INVuq0to79cS73
	Qs2rhb4qbjlgT3N+8w3nVapMNtpdnMwRgfUlpefk0BUlKlihtXJ+Y9VTyUQm1wx8BITQqHW3bbv
	lWou4d2Rn358FFzUW285NHr2LgKnYtSpGNaGXIKMCTDDiT7ugPH4wuXLU2Nh/DM+2noJG6JxhDw
	F55/DgcECipyIFzQrYZvp0a270XOIAfnkcI3L+dzJsDSWNssRBkrZMETVoPyhRmc6ICxeueLYfF
	iVxIfPUOY0gigjYgEuGRTii4t6yVanfcUDr9CaFX6INBOT9gLRmgIQqJ/qJsenOoVhpw3JS1wA=
	=
X-Google-Smtp-Source: AGHT+IEYvpRjZx4W4WE8JRXpRF4p+Zu8QwI57XWokQHYq5zwiHyJBf9w05MByBdIFQZIHTP/OB3Bfg==
X-Received: by 2002:a05:6000:40d9:b0:3a4:ea40:4d3f with SMTP id ffacd0b85a97d-3a531cf54d1mr7382902f8f.53.1749373792598;
        Sun, 08 Jun 2025 02:09:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f02asm6640239f8f.83.2025.06.08.02.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:52 -0700 (PDT)
Message-Id: <71d9a37410265a8295f8516421135ee372c8ca7e.1749373787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:42 +0000
Subject: [PATCH 5/9] doc: git-log: convert rev list options to new doc format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Fix some malformed synopis of options
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.
- Add the '%' sign to the characters of keywords.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/asciidoc.conf.in             |   2 +-
 Documentation/asciidoctor-extensions.rb.in |   4 +-
 Documentation/rev-list-options.adoc        | 390 ++++++++++-----------
 3 files changed, 198 insertions(+), 198 deletions(-)

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index 9d9139306e6f..ff9ea0a29445 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -43,7 +43,7 @@ ifdef::doctype-book[]
 endif::doctype-book[]
 
 [literal-inlinemacro]
-{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@\\\*\/_^\$]+\.?)+|,)',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@\\\*\/_^\$%]+\.?)+|,)',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
 
 endif::backend-docbook[]
 
diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
index 8b7b16134967..fe64a62d9683 100644
--- a/Documentation/asciidoctor-extensions.rb.in
+++ b/Documentation/asciidoctor-extensions.rb.in
@@ -73,7 +73,7 @@ module Git
         elsif type == :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$\.])/, '<literal>\1</literal>\2')
               .gsub(/^\.\.\.?$/, '<literal>\0</literal>')
-              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@/_^\$\\\*]+\.{0,2})+|,)}, '\1<literal>\2</literal>')
+              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@/_^\$\\\*%]+\.{0,2})+|,)}, '\1<literal>\2</literal>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
         else
           open, close, supports_phrase = QUOTE_TAGS[type]
@@ -102,7 +102,7 @@ module Git
         if node.type == :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
               .gsub(/^\.\.\.?$/, '<code>\0</code>')
-              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$\\\*]+\.{0,2})+)}, '\1<code>\2</code>')
+              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$\\\*%]+\.{0,2})+)}, '\1<code>\2</code>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
 
         else
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index d38875efdada..e4214035815d 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -6,60 +6,60 @@ special notations explained in the description, additional commit
 limiting may be applied.
 
 Using more options generally further limits the output (e.g.
-`--since=<date1>` limits to commits newer than `<date1>`, and using it
+`--since=<date1>` limits to commits newer than _<date1>_, and using it
 with `--grep=<pattern>` further limits to commits whose log message
-has a line that matches `<pattern>`), unless otherwise noted.
+has a line that matches _<pattern>_), unless otherwise noted.
 
 Note that these are applied before commit
 ordering and formatting options, such as `--reverse`.
 
--<number>::
--n <number>::
---max-count=<number>::
-	Limit the number of commits to output.
+`-<number>`::
+`-n <number>`::
+`--max-count=<number>`::
+	Limit the output to _<number>_ commits.
 
---skip=<number>::
-	Skip 'number' commits before starting to show the commit output.
+`--skip=<number>`::
+	Skip _<number>_ commits before starting to show the commit output.
 
---since=<date>::
---after=<date>::
-	Show commits more recent than a specific date.
+`--since=<date>`::
+`--after=<date>`::
+	Show commits more recent than _<date>_.
 
---since-as-filter=<date>::
-	Show all commits more recent than a specific date. This visits
+`--since-as-filter=<date>`::
+	Show all commits more recent than _<date>_. This visits
 	all commits in the range, rather than stopping at the first commit which
-	is older than a specific date.
+	is older than _<date>_.
 
---until=<date>::
---before=<date>::
-	Show commits older than a specific date.
+`--until=<date>`::
+`--before=<date>`::
+	Show commits older than _<date>_.
 
 ifdef::git-rev-list[]
---max-age=<timestamp>::
---min-age=<timestamp>::
+`--max-age=<timestamp>`::
+`--min-age=<timestamp>`::
 	Limit the commits output to specified time range.
 endif::git-rev-list[]
 
---author=<pattern>::
---committer=<pattern>::
+`--author=<pattern>`::
+`--committer=<pattern>`::
 	Limit the commits output to ones with author/committer
-	header lines that match the specified pattern (regular
-	expression).  With more than one `--author=<pattern>`,
-	commits whose author matches any of the given patterns are
+	header lines that match the _<pattern>_ regular
+	expression.  With more than one `--author=<pattern>`,
+	commits whose author matches any of the _<pattern>_ are
 	chosen (similarly for multiple `--committer=<pattern>`).
 
---grep-reflog=<pattern>::
+`--grep-reflog=<pattern>`::
 	Limit the commits output to ones with reflog entries that
-	match the specified pattern (regular expression). With
+	match the _<pattern>_ regular expression. With
 	more than one `--grep-reflog`, commits whose reflog message
 	matches any of the given patterns are chosen.  It is an
 	error to use this option unless `--walk-reflogs` is in use.
 
---grep=<pattern>::
+`--grep=<pattern>`::
 	Limit the commits output to ones with a log message that
-	matches the specified pattern (regular expression).  With
+	matches the _<pattern>_ regular expression.  With
 	more than one `--grep=<pattern>`, commits whose message
-	matches any of the given patterns are chosen (but see
+	matches any of the _<pattern>_ are chosen (but see
 	`--all-match`).
 ifndef::git-rev-list[]
 +
@@ -67,35 +67,35 @@ When `--notes` is in effect, the message from the notes is
 matched as if it were part of the log message.
 endif::git-rev-list[]
 
---all-match::
+`--all-match`::
 	Limit the commits output to ones that match all given `--grep`,
 	instead of ones that match at least one.
 
---invert-grep::
+`--invert-grep`::
 	Limit the commits output to ones with a log message that do not
-	match the pattern specified with `--grep=<pattern>`.
+	match the _<pattern>_ specified with `--grep=<pattern>`.
 
--i::
---regexp-ignore-case::
+`-i`::
+`--regexp-ignore-case`::
 	Match the regular expression limiting patterns without regard to letter
 	case.
 
---basic-regexp::
+`--basic-regexp`::
 	Consider the limiting patterns to be basic regular expressions;
 	this is the default.
 
--E::
---extended-regexp::
+`-E`::
+`--extended-regexp`::
 	Consider the limiting patterns to be extended regular expressions
 	instead of the default basic regular expressions.
 
--F::
---fixed-strings::
+`-F`::
+`--fixed-strings`::
 	Consider the limiting patterns to be fixed strings (don't interpret
 	pattern as a regular expression).
 
--P::
---perl-regexp::
+`-P`::
+`--perl-regexp`::
 	Consider the limiting patterns to be Perl-compatible regular
 	expressions.
 +
@@ -103,20 +103,20 @@ Support for these types of regular expressions is an optional
 compile-time dependency. If Git wasn't compiled with support for them
 providing this option will cause it to die.
 
---remove-empty::
+`--remove-empty`::
 	Stop when a given path disappears from the tree.
 
---merges::
+`--merges`::
 	Print only merge commits. This is exactly the same as `--min-parents=2`.
 
---no-merges::
+`--no-merges`::
 	Do not print commits with more than one parent. This is
 	exactly the same as `--max-parents=1`.
 
---min-parents=<number>::
---max-parents=<number>::
---no-min-parents::
---no-max-parents::
+`--min-parents=<number>`::
+`--max-parents=<number>`::
+`--no-min-parents`::
+`--no-max-parents`::
 	Show only commits which have at least (or at most) that many parent
 	commits. In particular, `--max-parents=1` is the same as `--no-merges`,
 	`--min-parents=2` is the same as `--merges`.  `--max-parents=0`
@@ -126,7 +126,7 @@ providing this option will cause it to die.
 again.  Equivalent forms are `--min-parents=0` (any commit has 0 or more
 parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 
---first-parent::
+`--first-parent`::
 	When finding commits to include, follow only the first
 	parent commit upon seeing a merge commit.  This option
 	can give a better overview when viewing the evolution of
@@ -141,14 +141,14 @@ This option also changes default diff format for merge commits
 to `first-parent`, see `--diff-merges=first-parent` for details.
 endif::git-log[]
 
---exclude-first-parent-only::
+`--exclude-first-parent-only`::
 	When finding commits to exclude (with a '{caret}'), follow only
 	the first parent commit upon seeing a merge commit.
 	This can be used to find the set of changes in a topic branch
 	from the point where it diverged from the remote branch, given
 	that arbitrary merges can be valid topic branch changes.
 
---not::
+`--not`::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
 	for all following revision specifiers, up to the next `--not`.
 	When used on the command line before --stdin, the revisions passed
@@ -156,37 +156,37 @@ endif::git-log[]
 	via standard input, the revisions passed on the command line will
 	not be affected by it.
 
---all::
+`--all`::
 	Pretend as if all the refs in `refs/`, along with `HEAD`, are
-	listed on the command line as '<commit>'.
+	listed on the command line as _<commit>_.
 
---branches[=<pattern>]::
+`--branches[=<pattern>]`::
 	Pretend as if all the refs in `refs/heads` are listed
-	on the command line as '<commit>'. If '<pattern>' is given, limit
-	branches to ones matching given shell glob. If pattern lacks '?',
+	on the command line as _<commit>_. If _<pattern>_ is given, limit
+	branches to ones matching given shell glob. If _<pattern>_ lacks '?',
 	'{asterisk}', or '[', '/{asterisk}' at the end is implied.
 
---tags[=<pattern>]::
+`--tags[=<pattern>]`::
 	Pretend as if all the refs in `refs/tags` are listed
-	on the command line as '<commit>'. If '<pattern>' is given, limit
+	on the command line as _<commit>_. If _<pattern>_ is given, limit
 	tags to ones matching given shell glob. If pattern lacks '?', '{asterisk}',
 	or '[', '/{asterisk}' at the end is implied.
 
---remotes[=<pattern>]::
+`--remotes[=<pattern>]`::
 	Pretend as if all the refs in `refs/remotes` are listed
-	on the command line as '<commit>'. If '<pattern>' is given, limit
+	on the command line as _<commit>_. If _<pattern>_ is given, limit
 	remote-tracking branches to ones matching given shell glob.
 	If pattern lacks '?', '{asterisk}', or '[', '/{asterisk}' at the end is implied.
 
---glob=<glob-pattern>::
-	Pretend as if all the refs matching shell glob '<glob-pattern>'
-	are listed on the command line as '<commit>'. Leading 'refs/',
+`--glob=<glob-pattern>`::
+	Pretend as if all the refs matching shell glob _<glob-pattern>_
+	are listed on the command line as _<commit>_. Leading 'refs/',
 	is automatically prepended if missing. If pattern lacks '?', '{asterisk}',
 	or '[', '/{asterisk}' at the end is implied.
 
---exclude=<glob-pattern>::
+`--exclude=<glob-pattern>`::
 
-	Do not include refs matching '<glob-pattern>' that the next `--all`,
+	Do not include refs matching _<glob-pattern>_ that the next `--all`,
 	`--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
 	consider. Repetitions of this option accumulate exclusion patterns
 	up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
@@ -199,7 +199,7 @@ respectively, and they must begin with `refs/` when applied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
 
---exclude-hidden=[fetch|receive|uploadpack]::
+`--exclude-hidden=(fetch|receive|uploadpack)`::
 	Do not include refs that would be hidden by `git-fetch`,
 	`git-receive-pack` or `git-upload-pack` by consulting the appropriate
 	`fetch.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs`
@@ -207,11 +207,11 @@ explicitly.
 	linkgit:git-config[1]). This option affects the next pseudo-ref option
 	`--all` or `--glob` and is cleared after processing them.
 
---reflog::
+`--reflog`::
 	Pretend as if all objects mentioned by reflogs are listed on the
-	command line as `<commit>`.
+	command line as _<commit>_.
 
---alternate-refs::
+`--alternate-refs`::
 	Pretend as if all objects mentioned as ref tips of alternate
 	repositories were listed on the command line. An alternate
 	repository is any repository whose object directory is specified
@@ -219,7 +219,7 @@ explicitly.
 	be modified by `core.alternateRefsCommand`, etc. See
 	linkgit:git-config[1].
 
---single-worktree::
+`--single-worktree`::
 	By default, all working trees will be examined by the
 	following options when there are more than one (see
 	linkgit:git-worktree[1]): `--all`, `--reflog` and
@@ -227,19 +227,19 @@ explicitly.
 	This option forces them to examine the current working tree
 	only.
 
---ignore-missing::
+`--ignore-missing`::
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
 
 ifndef::git-rev-list[]
---bisect::
+`--bisect`::
 	Pretend as if the bad bisection ref `refs/bisect/bad`
 	was listed and as if it was followed by `--not` and the good
 	bisection refs `refs/bisect/good-*` on the command
 	line.
 endif::git-rev-list[]
 
---stdin::
+`--stdin`::
 	In addition to getting arguments from the command line, read
 	them from standard input as well. This accepts commits and
 	pseudo-options like `--all` and `--glob=`. When a `--` separator
@@ -249,15 +249,15 @@ endif::git-rev-list[]
 	influence any subsequent command line arguments.
 
 ifdef::git-rev-list[]
---quiet::
+`--quiet`::
 	Don't print anything to standard output.  This form
 	is primarily meant to allow the caller to
 	test the exit status to see if a range of objects is fully
 	connected (or not).  It is faster than redirecting stdout
 	to `/dev/null` as the output does not have to be formatted.
 
---disk-usage::
---disk-usage=human::
+`--disk-usage`::
+`--disk-usage=human`::
 	Suppress normal output; instead, print the sum of the bytes used
 	for on-disk storage by the selected commits or objects. This is
 	equivalent to piping the output into `git cat-file
@@ -269,11 +269,11 @@ ifdef::git-rev-list[]
 	in human-readable string(e.g. 12.24 Kib, 3.50 Mib).
 endif::git-rev-list[]
 
---cherry-mark::
+`--cherry-mark`::
 	Like `--cherry-pick` (see below) but mark equivalent commits
 	with `=` rather than omitting them, and inequivalent ones with `+`.
 
---cherry-pick::
+`--cherry-pick`::
 	Omit any commit that introduces the same change as
 	another commit on the ``other side'' when the set of
 	commits are limited with symmetric difference.
@@ -286,8 +286,8 @@ cherry-picked from the other branch (for example, ``3rd on b'' may be
 cherry-picked from branch A). With this option, such pairs of commits are
 excluded from the output.
 
---left-only::
---right-only::
+`--left-only`::
+`--right-only`::
 	List only commits on the respective side of a symmetric difference,
 	i.e. only those which would be marked `<` resp. `>` by
 	`--left-right`.
@@ -298,20 +298,20 @@ commits from `B` which are in `A` or are patch-equivalent to a commit in
 More precisely, `--cherry-pick --right-only --no-merges` gives the exact
 list.
 
---cherry::
+`--cherry`::
 	A synonym for `--right-only --cherry-mark --no-merges`; useful to
 	limit the output to the commits on our side and mark those that
 	have been applied to the other side of a forked history with
 	`git log --cherry upstream...mybranch`, similar to
 	`git cherry upstream mybranch`.
 
--g::
---walk-reflogs::
+`-g`::
+`--walk-reflogs`::
 	Instead of walking the commit ancestry chain, walk
 	reflog entries from the most recent one to older ones.
 	When this option is used you cannot specify commits to
-	exclude (that is, '{caret}commit', 'commit1..commit2',
-	and 'commit1\...commit2' notations cannot be used).
+	exclude (that is, `^<commit>`, `<commit1>..<commit2>`,
+	and `<commit1>...<commit2>` notations cannot be used).
 +
 With `--pretty` format other than `oneline` and `reference` (for obvious reasons),
 this causes the output to have two extra lines of information
@@ -340,29 +340,29 @@ See also linkgit:git-reflog[1].
 +
 Under `--pretty=reference`, this information will not be shown at all.
 
---merge::
+`--merge`::
 	Show commits touching conflicted paths in the range `HEAD...<other>`,
 	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
 	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
 	when the index has unmerged entries. This option can be used to show
 	relevant commits when resolving conflicts from a 3-way merge.
 
---boundary::
+`--boundary`::
 	Output excluded boundary commits. Boundary commits are
 	prefixed with `-`.
 
 ifdef::git-rev-list[]
---use-bitmap-index::
+`--use-bitmap-index`::
 
 	Try to speed up the traversal using the pack bitmap index (if
 	one is available). Note that when traversing with `--objects`,
 	trees and blobs will not have their associated path printed.
 
---progress=<header>::
+`--progress=<header>`::
 	Show progress reports on stderr as objects are considered. The
 	`<header>` text will be printed with each progress update.
 
--z::
+`-z`::
 	Instead of being newline-delimited, each outputted object and its
 	accompanying metadata is delimited using NUL bytes. Output is printed
 	in the following form:
@@ -397,56 +397,56 @@ is how to do it, as there are various strategies to simplify the history.
 
 The following options select the commits to be shown:
 
-<paths>::
+`<paths>`::
 	Commits modifying the given <paths> are selected.
 
---simplify-by-decoration::
+`--simplify-by-decoration`::
 	Commits that are referred by some branch or tag are selected.
 
 Note that extra commits can be shown to give a meaningful history.
 
 The following options affect the way the simplification is performed:
 
-Default mode::
+`Default mode`::
 	Simplifies the history to the simplest history explaining the
 	final state of the tree. Simplest because it prunes some side
 	branches if the end result is the same (i.e. merging branches
 	with the same content)
 
---show-pulls::
+`--show-pulls`::
 	Include all commits from the default mode, but also any merge
 	commits that are not TREESAME to the first parent but are
 	TREESAME to a later parent. This mode is helpful for showing
 	the merge commits that "first introduced" a change to a branch.
 
---full-history::
+`--full-history`::
 	Same as the default mode, but does not prune some history.
 
---dense::
+`--dense`::
 	Only the selected commits are shown, plus some to have a
 	meaningful history.
 
---sparse::
+`--sparse`::
 	All commits in the simplified history are shown.
 
---simplify-merges::
+`--simplify-merges`::
 	Additional option to `--full-history` to remove some needless
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.
 
---ancestry-path[=<commit>]::
-	When given a range of commits to display (e.g. 'commit1..commit2'
-	or 'commit2 {caret}commit1'), and a commit <commit> in that range,
+`--ancestry-path[=<commit>]`::
+	When given a range of commits to display (e.g. `<commit1>..<commit2>`
+	or `<commit2> ^<commit1>`), and a commit _<commit>_ in that range,
 	only display commits in that range
-	that are ancestors of <commit>, descendants of <commit>, or
-	<commit> itself.  If no commit is specified, use 'commit1' (the
-	excluded part of the range) as <commit>.  Can be passed multiple
+	that are ancestors of _<commit>_, descendants of _<commit>_, or
+	_<commit>_ itself.  If no commit is specified, use _<commit1>_ (the
+	excluded part of the range) as _<commit>_.  Can be passed multiple
 	times; if so, a commit is included if it is any of the commits
 	given or if it is an ancestor or descendant of one of them.
 
 A more detailed explanation follows.
 
-Suppose you specified `foo` as the <paths>.  We shall call commits
+Suppose you specified `foo` as the _<paths>_.  We shall call commits
 that modify `foo` !TREESAME, and the rest TREESAME.  (In a diff
 filtered for `foo`, they look different and equal, respectively.)
 
@@ -466,22 +466,22 @@ The horizontal line of history A---Q is taken to be the first parent of
 each merge.  The commits are:
 
 * `I` is the initial commit, in which `foo` exists with contents
-  ``asdf'', and a file `quux` exists with contents ``quux''. Initial
+  `asdf`, and a file `quux` exists with contents `quux`. Initial
   commits are compared to an empty tree, so `I` is !TREESAME.
 
-* In `A`, `foo` contains just ``foo''.
+* In `A`, `foo` contains just `foo`.
 
 * `B` contains the same change as `A`.  Its merge `M` is trivial and
   hence TREESAME to all parents.
 
-* `C` does not change `foo`, but its merge `N` changes it to ``foobar'',
+* `C` does not change `foo`, but its merge `N` changes it to `foobar`,
   so it is not TREESAME to any parent.
 
-* `D` sets `foo` to ``baz''. Its merge `O` combines the strings from
-  `N` and `D` to ``foobarbaz''; i.e., it is not TREESAME to any parent.
+* `D` sets `foo` to `baz`. Its merge `O` combines the strings from
+  `N` and `D` to `foobarbaz`; i.e., it is not TREESAME to any parent.
 
-* `E` changes `quux` to ``xyzzy'', and its merge `P` combines the
-  strings to ``quux xyzzy''. `P` is TREESAME to `O`, but not to `E`.
+* `E` changes `quux` to `xyzzy`, and its merge `P` combines the
+  strings to `quux xyzzy`. `P` is TREESAME to `O`, but not to `E`.
 
 * `X` is an independent root commit that added a new file `side`, and `Y`
   modified it. `Y` is TREESAME to `X`. Its merge `Q` added `side` to `P`, and
@@ -517,7 +517,7 @@ Parent/child relations are only visible with `--parents`, but that does
 not affect the commits selected in default mode, so we have shown the
 parent lines.
 
---full-history without parent rewriting::
+`--full-history` without parent rewriting::
 	This mode differs from the default in one point: always follow
 	all parents of a merge, even if it is TREESAME to one of them.
 	Even if more than one side of the merge has commits that are
@@ -536,7 +536,7 @@ Note that without parent rewriting, it is not really possible to talk
 about the parent/child relationships between the commits, so we show
 them disconnected.
 
---full-history with parent rewriting::
+`--full-history` with parent rewriting::
 	Ordinary commits are only included if they are !TREESAME
 	(though this can be changed, see `--sparse` below).
 +
@@ -560,18 +560,18 @@ rewritten to contain `E`'s parent `I`.  The same happened for `C` and
 In addition to the above settings, you can change whether TREESAME
 affects inclusion:
 
---dense::
+`--dense`::
 	Commits that are walked are included if they are not TREESAME
 	to any parent.
 
---sparse::
+`--sparse`::
 	All commits that are walked are included.
 +
 Note that without `--full-history`, this still simplifies merges: if
 one of the parents is TREESAME, we follow only that one, so the other
 sides of the merge are never walked.
 
---simplify-merges::
+`--simplify-merges`::
 	First, build a history graph in the same way that
 	`--full-history` with parent rewriting does (see above).
 +
@@ -618,9 +618,9 @@ Note the major differences in `N`, `P`, and `Q` over `--full-history`:
 
 There is another simplification mode available:
 
---ancestry-path[=<commit>]::
+`--ancestry-path[=<commit>]`::
 	Limit the displayed commits to those which are an ancestor of
-	<commit>, or which are a descendant of <commit>, or are <commit>
+	_<commit>_, or which are a descendant of _<commit>_, or are _<commit>_
 	itself.
 +
 As an example use case, consider the following commit history:
@@ -636,15 +636,15 @@ As an example use case, consider the following commit history:
 A regular 'D..M' computes the set of commits that are ancestors of `M`,
 but excludes the ones that are ancestors of `D`. This is useful to see
 what happened to the history leading to `M` since `D`, in the sense
-that ``what does `M` have that did not exist in `D`''. The result in this
+that "what does `M` have that did not exist in `D`". The result in this
 example would be all the commits, except `A` and `B` (and `D` itself,
 of course).
 +
 When we want to find out what commits in `M` are contaminated with the
 bug introduced by `D` and need fixing, however, we might want to view
-only the subset of 'D..M' that are actually descendants of `D`, i.e.
+only the subset of `D..M` that are actually descendants of `D`, i.e.
 excluding `C` and `K`. This is exactly what the `--ancestry-path`
-option does. Applied to the 'D..M' range, it results in:
+option does. Applied to the `D..M` range, it results in:
 +
 -----------------------------------------------------------------------
 		E-------F
@@ -655,7 +655,7 @@ option does. Applied to the 'D..M' range, it results in:
 -----------------------------------------------------------------------
 +
 We can also use `--ancestry-path=D` instead of `--ancestry-path` which
-means the same thing when applied to the 'D..M' range but is just more
+means the same thing when applied to the `D..M` range but is just more
 explicit.
 +
 If we instead are interested in a given topic within this range, and all
@@ -770,7 +770,7 @@ into the important branch. This commit may have information about why
 the change `X` came to override the changes from `A` and `B` in its
 commit message.
 
---show-pulls::
+`--show-pulls`::
 	In addition to the commits shown in the default history, show
 	each merge commit that is not TREESAME to its first parent but
 	is TREESAME to a later parent.
@@ -819,7 +819,7 @@ ifdef::git-rev-list[]
 Bisection Helpers
 ~~~~~~~~~~~~~~~~~
 
---bisect::
+`--bisect`::
 	Limit output to the one commit object which is roughly halfway between
 	included and excluded commits. Note that the bad bisection ref
 	`refs/bisect/bad` is added to the included commits (if it
@@ -843,7 +843,7 @@ introduces a regression is thus reduced to a binary search: repeatedly
 generate and test new 'midpoint's until the commit chain is of length
 one.
 
---bisect-vars::
+`--bisect-vars`::
 	This calculates the same as `--bisect`, except that refs in
 	`refs/bisect/` are not used, and except that this outputs
 	text ready to be eval'ed by the shell. These lines will assign the
@@ -855,7 +855,7 @@ one.
 	`bisect_bad`, and the number of commits we are bisecting right now to
 	`bisect_all`.
 
---bisect-all::
+`--bisect-all`::
 	This outputs all the commit objects between the included and excluded
 	commits, ordered by their distance to the included and excluded
 	commits. Refs in `refs/bisect/` are not used. The farthest
@@ -878,15 +878,15 @@ Commit Ordering
 
 By default, the commits are shown in reverse chronological order.
 
---date-order::
+`--date-order`::
 	Show no parents before all of its children are shown, but
 	otherwise show commits in the commit timestamp order.
 
---author-date-order::
+`--author-date-order`::
 	Show no parents before all of its children are shown, but
 	otherwise show commits in the author timestamp order.
 
---topo-order::
+`--topo-order`::
 	Show no parents before all of its children are shown, and
 	avoid showing commits on multiple lines of history
 	intermixed.
@@ -910,8 +910,8 @@ With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
 avoid showing the commits from two parallel development track mixed
 together.
 
---reverse::
-	Output the commits chosen to be shown (see Commit Limiting
+`--reverse`::
+	Output the commits chosen to be shown (see 'Commit Limiting'
 	section above) in reverse order. Cannot be combined with
 	`--walk-reflogs`.
 endif::git-shortlog[]
@@ -923,39 +923,39 @@ Object Traversal
 These options are mostly targeted for packing of Git repositories.
 
 ifdef::git-rev-list[]
---objects::
+`--objects`::
 	Print the object IDs of any object referenced by the listed
-	commits.  `--objects foo ^bar` thus means ``send me
+	commits.  `--objects foo ^bar` thus means "send me
 	all object IDs which I need to download if I have the commit
-	object _bar_ but not _foo_''. See also `--object-names` below.
+	object `bar` but not `foo`". See also `--object-names` below.
 
---in-commit-order::
+`--in-commit-order`::
 	Print tree and blob ids in order of the commits. The tree
 	and blob ids are printed after they are first referenced
 	by a commit.
 
---objects-edge::
+`--objects-edge`::
 	Similar to `--objects`, but also print the IDs of excluded
-	commits prefixed with a ``-'' character.  This is used by
+	commits prefixed with a "`-`" character.  This is used by
 	linkgit:git-pack-objects[1] to build a ``thin'' pack, which records
 	objects in deltified form based on objects contained in these
 	excluded commits to reduce network traffic.
 
---objects-edge-aggressive::
+`--objects-edge-aggressive`::
 	Similar to `--objects-edge`, but it tries harder to find excluded
 	commits at the cost of increased time.  This is used instead of
 	`--objects-edge` to build ``thin'' packs for shallow repositories.
 
---indexed-objects::
+`--indexed-objects`::
 	Pretend as if all trees and blobs used by the index are listed
 	on the command line.  Note that you probably want to use
 	`--objects`, too.
 
---unpacked::
+`--unpacked`::
 	Only useful with `--objects`; print the object IDs that are not
 	in packs.
 
---object-names::
+`--object-names`::
 	Only useful with `--objects`; print the names of the object IDs
 	that are found. This is the default behavior. Note that the
 	"name" of each object is ambiguous, and mostly intended as a
@@ -964,52 +964,52 @@ ifdef::git-rev-list[]
 	to remove newlines; and if an object would appear multiple times
 	with different names, only one name is shown.
 
---no-object-names::
+`--no-object-names`::
 	Only useful with `--objects`; does not print the names of the object
 	IDs that are found. This inverts `--object-names`. This flag allows
 	the output to be more easily parsed by commands such as
 	linkgit:git-cat-file[1].
 
---filter=<filter-spec>::
+`--filter=<filter-spec>`::
 	Only useful with one of the `--objects*`; omits objects (usually
-	blobs) from the list of printed objects.  The '<filter-spec>'
+	blobs) from the list of printed objects.  The _<filter-spec>_
 	may be one of the following:
 +
-The form '--filter=blob:none' omits all blobs.
+The form `--filter=blob:none` omits all blobs.
 +
-The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
-bytes or units.  n may be zero.  The suffixes k, m, and g can be used
-to name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k'
+The form `--filter=blob:limit=<n>[kmg]` omits blobs of size at least _<n>_
+bytes or units.  _<n>_ may be zero.  The suffixes `k`, `m`, and `g` can be used
+to name units in KiB, MiB, or GiB.  For example, `blob:limit=1k`
 is the same as 'blob:limit=1024'.
 +
-The form '--filter=object:type=(tag|commit|tree|blob)' omits all objects
+The form `--filter=object:type=(tag|commit|tree|blob)` omits all objects
 which are not of the requested type.
 +
-The form '--filter=sparse:oid=<blob-ish>' uses a sparse-checkout
-specification contained in the blob (or blob-expression) '<blob-ish>'
+The form `--filter=sparse:oid=<blob-ish>` uses a sparse-checkout
+specification contained in the blob (or blob-expression) _<blob-ish>_
 to omit blobs that would not be required for a sparse checkout on
 the requested refs.
 +
-The form '--filter=tree:<depth>' omits all blobs and trees whose depth
-from the root tree is >= <depth> (minimum depth if an object is located
-at multiple depths in the commits traversed). <depth>=0 will not include
+The form `--filter=tree:<depth>` omits all blobs and trees whose depth
+from the root tree is >= _<depth>_ (minimum depth if an object is located
+at multiple depths in the commits traversed). _<depth>_=0 will not include
 any trees or blobs unless included explicitly in the command-line (or
-standard input when --stdin is used). <depth>=1 will include only the
+standard input when `--stdin` is used). _<depth>_=1 will include only the
 tree and blobs which are referenced directly by a commit reachable from
-<commit> or an explicitly-given object. <depth>=2 is like <depth>=1
+_<commit>_ or an explicitly-given object. _<depth>_=2 is like <depth>=1
 while also including trees and blobs one more level removed from an
 explicitly-given commit or tree.
 +
-Note that the form '--filter=sparse:path=<path>' that wants to read
+Note that the form `--filter=sparse:path=<path>` that wants to read
 from an arbitrary path on the filesystem has been dropped for security
 reasons.
 +
-Multiple '--filter=' flags can be specified to combine filters. Only
+Multiple `--filter=` flags can be specified to combine filters. Only
 objects which are accepted by every filter are included.
 +
-The form '--filter=combine:<filter1>+<filter2>+...<filterN>' can also be
+The form `--filter=combine:<filter1>+<filter2>+...<filterN>` can also be
 used to combined several filters, but this is harder than just repeating
-the '--filter' flag and is usually not necessary. Filters are joined by
+the `--filter` flag and is usually not necessary. Filters are joined by
 '{plus}' and individual filters are %-encoded (i.e. URL-encoded).
 Besides the '{plus}' and '%' characters, the following characters are
 reserved and also must be encoded: `~!@#$^&*()[]{}\;",<>?`+&#39;&#96;+
@@ -1017,52 +1017,52 @@ as well as all characters with ASCII code &lt;= `0x20`, which includes
 space and newline.
 +
 Other arbitrary characters can also be encoded. For instance,
-'combine:tree:3+blob:none' and 'combine:tree%3A3+blob%3Anone' are
+`combine:tree:3+blob:none` and `combine:tree%3A3+blob%3Anone` are
 equivalent.
 
---no-filter::
+`--no-filter`::
 	Turn off any previous `--filter=` argument.
 
---filter-provided-objects::
+`--filter-provided-objects`::
 	Filter the list of explicitly provided objects, which would otherwise
 	always be printed even if they did not match any of the filters. Only
 	useful with `--filter=`.
 
---filter-print-omitted::
+`--filter-print-omitted`::
 	Only useful with `--filter=`; prints a list of the objects omitted
 	by the filter.  Object IDs are prefixed with a ``~'' character.
 
---missing=<missing-action>::
+`--missing=<missing-action>`::
 	A debug option to help with future "partial clone" development.
 	This option specifies how missing objects are handled.
 +
-The form '--missing=error' requests that rev-list stop with an error if
+The form `--missing=error` requests that rev-list stop with an error if
 a missing object is encountered.  This is the default action.
 +
-The form '--missing=allow-any' will allow object traversal to continue
+The form `--missing=allow-any` will allow object traversal to continue
 if a missing object is encountered.  Missing objects will silently be
 omitted from the results.
 +
-The form '--missing=allow-promisor' is like 'allow-any', but will only
+The form `--missing=allow-promisor` is like `allow-any`, but will only
 allow object traversal to continue for EXPECTED promisor missing objects.
 Unexpected missing objects will raise an error.
 +
-The form '--missing=print' is like 'allow-any', but will also print a
+The form `--missing=print` is like `allow-any`, but will also print a
 list of the missing objects.  Object IDs are prefixed with a ``?'' character.
 +
-The form '--missing=print-info' is like 'print', but will also print additional
+The form `--missing=print-info` is like `print`, but will also print additional
 information about the missing object inferred from its containing object. The
 information is all printed on the same line with the missing object ID in the
 form: `?<oid> [<token>=<value>]...`. The `<token>=<value>` pairs containing
-additional information are separated from each other by a SP. The value is
-encoded in a token specific fashion, but SP or LF contained in value are always
+additional information are separated from each other by a _SP_. The value is
+encoded in a token specific fashion, but _SP_ or _LF_ contained in value are always
 expected to be represented in such a way that the resulting encoded value does
 not have either of these two problematic bytes. Each `<token>=<value>` may be
 one of the following:
 +
 --
 * The `path=<path>` shows the path of the missing object inferred from a
-  containing object. A path containing SP or special characters is enclosed in
+  containing object. A path containing _SP_ or special characters is enclosed in
   double-quotes in the C style as needed.
 +
 * The `type=<type>` shows the type of the missing object inferred from a
@@ -1073,7 +1073,7 @@ If some tips passed to the traversal are missing, they will be
 considered as missing too, and the traversal will ignore them. In case
 we cannot get their Object ID though, an error will be raised.
 
---exclude-promisor-objects::
+`--exclude-promisor-objects`::
 	(For internal use only.)  Prefilter object traversal at
 	promisor boundary.  This is used with partial clone.  This is
 	stronger than `--missing=allow-promisor` because it limits the
@@ -1081,7 +1081,7 @@ we cannot get their Object ID though, an error will be raised.
 	objects.
 endif::git-rev-list[]
 
---no-walk[=(sorted|unsorted)]::
+`--no-walk[=(sorted|unsorted)]`::
 	Only show the given commits, but do not traverse their ancestors.
 	This has no effect if a range is specified. If the argument
 	`unsorted` is given, the commits are shown in the order they were
@@ -1090,7 +1090,7 @@ endif::git-rev-list[]
 	by commit time.
 	Cannot be combined with `--graph`.
 
---do-walk::
+`--do-walk`::
 	Overrides a previous `--no-walk`.
 endif::git-shortlog[]
 
@@ -1106,10 +1106,10 @@ endif::git-rev-list[]
 
 include::pretty-options.adoc[]
 
---relative-date::
+`--relative-date`::
 	Synonym for `--date=relative`.
 
---date=<format>::
+`--date=<format>`::
 	Only takes effect for dates shown in human-readable format, such
 	as when using `--pretty`. `log.date` config variable sets a default
 	value for the log command's `--date` option. By default, dates
@@ -1159,12 +1159,12 @@ omitted.
 1970).  As with `--raw`, this is always in UTC and therefore `-local`
 has no effect.
 
-`--date=format:...` feeds the format `...` to your system `strftime`,
-except for %s, %z, and %Z, which are handled internally.
+`--date=format:<format>` feeds the _<format>_ to your system `strftime`,
+except for `%s`, `%z`, and `%Z`, which are handled internally.
 Use `--date=format:%c` to show the date in your system locale's
-preferred format.  See the `strftime` manual for a complete list of
+preferred format.  See the `strftime`(3) manual for a complete list of
 format placeholders. When using `-local`, the correct syntax is
-`--date=format-local:...`.
+`--date=format-local:<format>`.
 
 `--date=default` is the default format, and is based on ctime(3)
 output.  It shows a single line with three-letter day of the week,
@@ -1174,33 +1174,33 @@ the local time zone is used, e.g. `Thu Jan 1 00:00:00 1970 +0000`.
 --
 
 ifdef::git-rev-list[]
---header::
+`--header`::
 	Print the contents of the commit in raw-format; each record is
 	separated with a NUL character.
 
---no-commit-header::
+`--no-commit-header`::
 	Suppress the header line containing "commit" and the object ID printed before
 	the specified format.  This has no effect on the built-in formats; only custom
 	formats are affected.
 
---commit-header::
+`--commit-header`::
 	Overrides a previous `--no-commit-header`.
 endif::git-rev-list[]
 
---parents::
+`--parents`::
 	Print also the parents of the commit (in the form "commit parent...").
 	Also enables parent rewriting, see 'History Simplification' above.
 
---children::
+`--children`::
 	Print also the children of the commit (in the form "commit child...").
 	Also enables parent rewriting, see 'History Simplification' above.
 
 ifdef::git-rev-list[]
---timestamp::
+`--timestamp`::
 	Print the raw commit timestamp.
 endif::git-rev-list[]
 
---left-right::
+`--left-right`::
 	Mark which side of a symmetric difference a commit is reachable from.
 	Commits from the left side are prefixed with `<` and those from
 	the right with `>`.  If combined with `--boundary`, those
@@ -1229,7 +1229,7 @@ you would get an output like this:
 	-xxxxxxx... 1st on a
 -----------------------------------------------------------------------
 
---graph::
+`--graph`::
 	Draw a text-based graphical representation of the commit history
 	on the left hand side of the output.  This may cause extra lines
 	to be printed in between commits, in order for the graph history
@@ -1241,15 +1241,15 @@ This enables parent rewriting, see 'History Simplification' above.
 This implies the `--topo-order` option by default, but the
 `--date-order` option may also be specified.
 
---show-linear-break[=<barrier>]::
-	When --graph is not used, all history branches are flattened
+`--show-linear-break[=<barrier>]`::
+	When `--graph` is not used, all history branches are flattened
 	which can make it hard to see that the two consecutive commits
 	do not belong to a linear branch. This option puts a barrier
-	in between them in that case. If `<barrier>` is specified, it
+	in between them in that case. If _<barrier>_ is specified, it
 	is the string that will be shown instead of the default one.
 
 ifdef::git-rev-list[]
---count::
+`--count`::
 	Print a number stating how many commits would have been
 	listed, and suppress all other output.  When used together
 	with `--left-right`, instead print the counts for left and
-- 
gitgitgadget

