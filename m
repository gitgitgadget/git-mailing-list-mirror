Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905320766E
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751203248; cv=none; b=eCBZbOx43wc4cJdiKqLKOf0E2cS/vcGye6IaCco8giummHtkZzC+JTJyEqN7tQ8BxaYZKC1uio6RkUJm0BNu8oNUYnFyaxHRC9vmvyj/5FoFzDJ5SIZ3AfMNxYFcGK0IvbXsbF2VmhMifHplkQd5OBFbeYSMUbJwD7UMi01iipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751203248; c=relaxed/simple;
	bh=rm/qwvO1xjx7m+wN6f0VjZ4GFyd6nyn7jD5B3Codr7w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=P33ZvOJAsgKavHyYkA5UJfctj7vcvq7Qbon3G0zFMdXe32LKcm2THFtkt5+VbZqx4s7/Tex2MizjrE8maUZdQJubM9iv6Y+Cf4TiW+HesLEMEQUtGwg65AJvmwnQh+KC46Mwt7lPHMTHukb41AWIww4N9SRWViF2B2vhA/RJZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWsr8LdG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWsr8LdG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a582e09144so882390f8f.1
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751203244; x=1751808044; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSsLs8SOT6SV/JMMHXjxTtBPaLyVLjNwekcPZu3xVCE=;
        b=WWsr8LdGPab8Nq2HfOhpx+ruYRpmBY+H1e4aYVgciHppMJfI/93Rgkl2FQnXKoUoQr
         wZ7wvBbiqRNRgevNLD3f0SXVhmLJy5ZAgjiGVa6hcTkQKLCWYkqipm/AvR1tmxz9ZiJ1
         4GHht6LEnH+Pgzz2xrAZBHUgXeA/dlUFe1/44pH9uyrWez6Ne9pJyt2uAkT8MLDlziQ1
         sX8totdlYDP1LEny1fr2uW72AkPTbG2V6IT8PgKKhVFwSTEUlJROzlIwYTLsLARl/VUr
         zmSpE4wwqqXj1tAcCR3gfvE+N29XMo6eQpoGQNfVGJCq3tl7xeU9N+N1OGlPuws6AS4a
         h4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751203244; x=1751808044;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSsLs8SOT6SV/JMMHXjxTtBPaLyVLjNwekcPZu3xVCE=;
        b=UknQO1y7ZuaItl+WPQFS7TBLOQHBq1yrNXZaI/Rf5A/Nbm9mD6tkmmIBRB0467XXpc
         pOnQsq6a/FVpe4f/HVZWUcjgotjPGaUdMdyNjOzbVgEb2blBixlZQDUowM9pD3wfxEGa
         SHZ6+qt8cPcR15Ok5f6IvXCQCjV1hTLs0x75nibiUjfUp9+lfgR3cyBDJdwIwqwu1umR
         ZYsKsk58ssMGyfLQYHK7e/K2qtERLLO6IKtN871jotqdOVP0ylJDqxBn+liky42DuG4p
         rPdqNYshkuXHvm4APzlK9juO12aP3LXr7auZIU/tqSvwJtXg/nx/AEEhb651UIlWCsjn
         w0JA==
X-Gm-Message-State: AOJu0YyamuTBzG6fcrzHiobbqbRHRomKB9M5+yRgh3ny13WPOiO7+RE5
	v1gK+/JEbXSMZcbgYV5E6o1hSadw+GaRMQCyirYahMquY5d+phryJe3KWrW0uA==
X-Gm-Gg: ASbGncsOTWrd/aGOLQc1ht9f/brsu0t+gs9OIkIFbK1Fv2+/LSWAkheSWDb+SYxIs/V
	kzRQkHf3yYFZw8Eh2vIdeS4J8Fz1wbBzqJGu1G7HVnE+pbjSm6Gjv7S4nDtWf+o0uxX57l56qU4
	KXH/xjVPWsXTCpd3kxdAz/LAfp4bj0E9hkT1uiQP1N0Tz7EiDTor9pAwv2M+HuOUFzhChFVD2G2
	5+gVFMH/Dytfb51QkpCe/ga15PFxwlgommw62IFEBewPRmdL/Fs1eKBV1ZhFFDpw091Mr2Hc7rl
	DP3635WwGzUWkIMUWlr9IeyDshOC28oneDJVIgs6B0KA3lKhirvKaPwh2UJAEok=
X-Google-Smtp-Source: AGHT+IHqynGEPET16Sg+UjwenA/TGhKMBwMIuowOAHYjQLaBqgjcgKrt6qbdCyQ7VddsIiKEHHB3rg==
X-Received: by 2002:a05:6000:2307:b0:3a4:d02e:84af with SMTP id ffacd0b85a97d-3a9038fb216mr7840455f8f.58.1751203244310;
        Sun, 29 Jun 2025 06:20:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe28dsm105623345e9.20.2025.06.29.06.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 06:20:43 -0700 (PDT)
Message-Id: <f2b6958819537cb1c0663124360d0896d6263deb.1751203241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
	<pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Jun 2025 13:20:33 +0000
Subject: [PATCH v2 1/9] doc: convert git-log to new documentation format
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

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

We also transform inline descriptions of possible values of option
--decorate into a list, which is more readable and extensible.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-log.adoc | 86 ++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index ae8a7e2d6389..b6f3d92c435f 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -8,8 +8,8 @@ git-log - Show commit logs
 
 SYNOPSIS
 --------
-[verse]
-'git log' [<options>] [<revision-range>] [[--] <path>...]
+[synopsis]
+git log [<options>] [<revision-range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -27,28 +27,34 @@ each commit introduces are shown.
 OPTIONS
 -------
 
---follow::
+`--follow`::
 	Continue listing the history of a file beyond renames
 	(works only for a single file).
 
---no-decorate::
---decorate[=short|full|auto|no]::
-	Print out the ref names of any commits that are shown. If 'short' is
-	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
-	'refs/remotes/' will not be printed. If 'full' is specified, the
-	full ref name (including prefix) will be printed. If 'auto' is
-	specified, then if the output is going to a terminal, the ref names
-	are shown as if 'short' were given, otherwise no ref names are
-	shown. The option `--decorate` is short-hand for `--decorate=short`.
-	Default to configuration value of `log.decorate` if configured,
-	otherwise, `auto`.
-
---decorate-refs=<pattern>::
---decorate-refs-exclude=<pattern>::
+`--no-decorate`::
+`--decorate[=(short|full|auto|no)]`::
+	Print out the ref names of any commits that are shown. Possible values
+	are:
++
+----
+`short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
+	`refs/remotes/` are not printed.
+`full`;; the full ref name (including prefix) is printed.
+`auto`:: if the output is going to a terminal, the ref names
+	are shown as if `short` were given, otherwise no ref names are
+	shown.
+----
++
+The option `--decorate` is short-hand for `--decorate=short`. Default to
+configuration value of `log.decorate` if configured, otherwise, `auto`.
+
+`--decorate-refs=<pattern>`::
+`--decorate-refs-exclude=<pattern>`::
 	For each candidate reference, do not use it for decoration if it
-	matches any patterns given to `--decorate-refs-exclude` or if it
-	doesn't match any of the patterns given to `--decorate-refs`. The
-	`log.excludeDecoration` config option allows excluding refs from
+	matches any of the _<pattern>_ parameters given to
+	`--decorate-refs-exclude` or if it doesn't match any of the
+	_<pattern>_ parameters given to `--decorate-refs`.
+	The `log.excludeDecoration` config option allows excluding refs from
 	the decorations, but an explicit `--decorate-refs` pattern will
 	override a match in `log.excludeDecoration`.
 +
@@ -56,51 +62,51 @@ If none of these options or config settings are given, then references are
 used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
 `refs/stash/`, or `refs/tags/`.
 
---clear-decorations::
+`--clear-decorations`::
 	When specified, this option clears all previous `--decorate-refs`
 	or `--decorate-refs-exclude` options and relaxes the default
 	decoration filter to include all references. This option is
 	assumed if the config value `log.initialDecorationSet` is set to
 	`all`.
 
---source::
+`--source`::
 	Print out the ref name given on the command line by which each
 	commit was reached.
 
---[no-]mailmap::
---[no-]use-mailmap::
+`--[no-]mailmap`::
+`--[no-]use-mailmap`::
 	Use mailmap file to map author and committer names and email
 	addresses to canonical real names and email addresses. See
 	linkgit:git-shortlog[1].
 
---full-diff::
+`--full-diff`::
 	Without this flag, `git log -p <path>...` shows commits that
 	touch the specified paths, and diffs about the same specified
 	paths.  With this, the full diff is shown for commits that touch
-	the specified paths; this means that "<path>..." limits only
+	the specified paths; this means that "`<path>...`" limits only
 	commits, and doesn't limit diff for those commits.
 +
 Note that this affects all diff-based output types, e.g. those
 produced by `--stat`, etc.
 
---log-size::
-	Include a line ``log size <number>'' in the output for each commit,
-	where <number> is the length of that commit's message in bytes.
+`--log-size`::
+	Include a line `log size <number>` in the output for each commit,
+	where _<number>_ is the length of that commit's message in bytes.
 	Intended to speed up tools that read log messages from `git log`
 	output by allowing them to allocate space in advance.
 
 include::line-range-options.adoc[]
 
-<revision-range>::
+_<revision-range>_::
 	Show only commits in the specified revision range.  When no
-	<revision-range> is specified, it defaults to `HEAD` (i.e. the
+	_<revision-range>_ is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
 	specifies all the commits reachable from the current commit
 	(i.e. `HEAD`), but not from `origin`. For a complete list of
-	ways to spell <revision-range>, see the 'Specifying Ranges'
+	ways to spell _<revision-range>_, see the 'Specifying Ranges'
 	section of linkgit:gitrevisions[7].
 
-[--] <path>...::
+`[--] <path>...`::
 	Show only commits that are enough to explain how the files
 	that match the specified paths came to be.  See 'History
 	Simplification' below for details and other simplification
@@ -145,14 +151,14 @@ EXAMPLES
 
 `git log --since="2 weeks ago" -- gitk`::
 
-	Show the changes during the last two weeks to the file 'gitk'.
+	Show the changes during the last two weeks to the file `gitk`.
 	The `--` is necessary to avoid confusion with the *branch* named
-	'gitk'
+	`gitk`
 
 `git log --name-status release..test`::
 
-	Show the commits that are in the "test" branch but not yet
-	in the "release" branch, along with the list of paths
+	Show the commits that are in the "`test`" branch but not yet
+	in the "`release`" branch, along with the list of paths
 	each commit modifies.
 
 `git log --follow builtin/rev-list.c`::
@@ -164,7 +170,7 @@ EXAMPLES
 `git log --branches --not --remotes=origin`::
 
 	Shows all commits that are in any of local branches but not in
-	any of remote-tracking branches for 'origin' (what you have that
+	any of remote-tracking branches for `origin` (what you have that
 	origin doesn't).
 
 `git log master --not --remotes=*/master`::
@@ -200,11 +206,11 @@ CONFIGURATION
 See linkgit:git-config[1] for core variables and linkgit:git-diff[1]
 for settings related to diff generation.
 
-format.pretty::
+`format.pretty`::
 	Default for the `--format` option.  (See 'Pretty Formats' above.)
 	Defaults to `medium`.
 
-i18n.logOutputEncoding::
+`i18n.logOutputEncoding`::
 	Encoding to use when displaying logs.  (See 'Discussion' above.)
 	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
-- 
gitgitgadget

