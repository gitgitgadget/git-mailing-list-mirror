Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC334D90E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845840; cv=none; b=VTIM+yF4alZORdHuaqsoShu8FWklhYdZSYIumww/BoSWcG13WsCl30gRqUIYkj16/hxFs7XQNN7gX2dhtLpbcm6lgFv4KPrljiaS9FBF7rhRCSoGW7k2Xrq7xT0Hj88rXYSTxt5zN50eKM1BnyMqWpNVFLtxbju6BPNcgDA27E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845840; c=relaxed/simple;
	bh=jzFWV74FiWudPJAEWJ0UXZ6wPAPpds3WpbuIaDcZSYg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CMdBkYpO7tt7afXwjV114tb4DyrTB5OHlnQQGwgvV7xdFrybTxUGY1Nu87fuGQtyrRHVfhYXqGbf4LBeitY6aoYcjSmDj441QL5FqeHedaXCzpwb/yr++TPlMCPhTs7Hz6aLrGQwP2w2iKWp6AacNPIxFb7VByPsWz+JYtlq9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCkFLHE/; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCkFLHE/"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bd3b0bc201so2830788eec.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 03:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845834; x=1772450634; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQN8xFRXe7acp09fHCWdR1KYBxEAC4MWYioV+iW7Vcc=;
        b=OCkFLHE/pdjdX6ApeR1ydMBVV2MO8SbqqizwhxEpbGtu9Zas8ZUdpubFAhOjNEFhGg
         g+4nqW1BlksPntQfoULXSqLuGMk+7I5nQJRTrqrliqVrut/dnOQE97dY+6LAn3mTKg7I
         uZGD5QFj2GK2P4LnrTn4YaCZyAQKckd0mUqg7iSov8Wx2w1X5OYROEsrhMS9W3g0zR0W
         tg+fR9ibWbJZvzzBQH5Q7XR/ko9wDlyBGZ6k0bLbf2kinzLQl/IrWllaMi7WsKUEO7Z8
         uBze8gmzxeln1wFsClS8dq2OVfaJpAq635VD+bJEmjyTm70nn++YPqG6LjSGWuyFy/t1
         E9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845834; x=1772450634;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQN8xFRXe7acp09fHCWdR1KYBxEAC4MWYioV+iW7Vcc=;
        b=vCFx9lebppQ4NwuKUMRyzbx6uBumghP9kRmKpF7xuY3uKzV6sXzL3NyUcodQ7VLzWK
         ysWBxSRQiAiRwr0/rOi9eSS/iEspZXM1A9nMdYzE5rDNR4EpKZWVBs6C7qn00RKNqAor
         UngCEjMA4cj/pFCjrUPZRceB0xXFzFXeAZ+j1oC2ycqxU5vQvQaWs12uZVveGoBNQI5s
         PkDLKHtG43UNdjANf39OdRDy7YZ6d9moBTehBUL8uuGr/nBHM1tGhSx7phR/CHol8izp
         f7zAdfO2VcMcju8tPNdeHcyq/B4YBFdCKhBTNQ9ylWyCj9YJe8TaLuTAdE72Z2NWo9+E
         fpDw==
X-Gm-Message-State: AOJu0Yz3s6WVVnPPqmT4OnHZB5+0xTErUwx68FRJv0s8Vy+JlcesWkQ6
	KXOGLGGpYWKTGIIJbUE1j/iNI3bzr7ZaNACZ7LYXkauR202n5mhSJ4UF8mEO2Q==
X-Gm-Gg: ATEYQzxUtNl7lw4pf6mqBjM2LWCXyRf4sMLJWHFZZPDqQ3LQB4lDvKwWbesvY/5y6SA
	bfgCRCErVYSFMANiEpJMtdZ4tJxB2+u+MRRmFjsxkKPub16+zVck5nCgrpDYjBD0iP5VtdwtG6b
	/Zw9B1pI32FhItsDtNFZEi8GCFc+wlSyT6r/mlG4o2R4vgb//p+FNgXL83KKjGqBtHd4vv5GfM+
	mwukT4iGJWLdBXPig2PN7xYKkhehUupJRJPij8qqP7B/sZHcZ9uErkE76GW2IULGA86oVAtxI0E
	MXOGuQtX3c6edBPtxo79mweKOV84TJrIew4WvC9kUeaDoHaT91k2WgP/vO4BtPsbdI2Z105u+5k
	+NtCenR+fFp7TA0MWfUvIKvqqLbbKJgUBvfHNwKm+zpdnFF6CcOUNNRVaOLffDyHhbGT+Q1syOJ
	7tOByUFMmAHjHc9gGS04l+UdRLyg==
X-Received: by 2002:a05:693c:3108:b0:2ba:6b88:d636 with SMTP id 5a478bee46e88-2bd7bd59e7dmr3604013eec.31.1771845831286;
        Mon, 23 Feb 2026 03:23:51 -0800 (PST)
Received: from [127.0.0.1] ([20.168.115.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daccc44sm4643659eec.15.2026.02.23.03.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:23:50 -0800 (PST)
Message-Id: <pull.2055.v2.git.1771845829480.gitgitgadget@gmail.com>
In-Reply-To: <pull.2055.git.1771844130973.gitgitgadget@gmail.com>
References: <pull.2055.git.1771844130973.gitgitgadget@gmail.com>
From: "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 11:23:49 +0000
Subject: [PATCH v2] doc: format config values with backticks
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Md Ferdous Alam <mdferdousalam1989@yahoo.com>,
    mdferdousalam <mdferdousalam1989@yahoo.com>

From: mdferdousalam <mdferdousalam1989@yahoo.com>

Wrap bare true/false config values in backticks throughout the
Documentation/config/*.adoc files, following the convention used
by most of the documentation. This ensures consistent formatting
of boolean configuration values.

Signed-off-by: Md Ferdous Alam <md.ferdous.alam.official@gmail.com>
---
    doc: format config values with backticks
    
    Add backtick formatting to bare true/false values in configuration
    documentation so they render in monospace as config literals, matching
    the style used throughout most of the existing documentation.
    
    Files updated:
    
     * am.adoc, blame.adoc, branch.adoc, clean.adoc, color.adoc
     * commitgraph.adoc, core.adoc, credential.adoc, fetch.adoc
     * fmt-merge-msg.adoc, format.adoc, gc.adoc, gitcvs.adoc
     * grep.adoc, gui.adoc, http.adoc, instaweb.adoc, interactive.adoc
     * log.adoc, mailinfo.adoc, maintenance.adoc, merge.adoc
     * mergetool.adoc, pack.adoc, pull.adoc, push.adoc, rebase.adoc
     * receive.adoc, remote.adoc, repack.adoc, rerere.adoc, revert.adoc
     * stash.adoc, status.adoc, submodule.adoc, trace2.adoc
     * transfer.adoc, uploadarchive.adoc, worktree.adoc
    
    This addresses https://github.com/gitgitgadget/git/issues/244

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2055%2Fmdferdousalam%2Ffix-config-doc-formatting-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2055/mdferdousalam/fix-config-doc-formatting-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2055

Range-diff vs v1:

 1:  631b9abe41 ! 1:  3a1ca6e5d9 doc: format config values with backticks
     @@ Metadata
       ## Commit message ##
          doc: format config values with backticks
      
     -    Add backtick formatting to bare true/false values in configuration
     -    documentation so they render in monospace as config literals, matching
     -    the style used throughout most of the existing documentation.
     +    Wrap bare true/false config values in backticks throughout the
     +    Documentation/config/*.adoc files, following the convention used
     +    by most of the documentation. This ensures consistent formatting
     +    of boolean configuration values.
      
     -    Signed-off-by: Md Ferdous Alam <mdferdousalam@gmail.com>
     +    Signed-off-by: Md Ferdous Alam <md.ferdous.alam.official@gmail.com>
      
       ## Documentation/config/am.adoc ##
      @@
     @@ Documentation/config/blame.adoc
       
       blame.coloring::
       	This determines the coloring scheme to be applied to blame
     +@@ Documentation/config/blame.adoc: blame.date::
     + 
     + blame.showEmail::
     + 	Show the author email instead of author name in linkgit:git-blame[1].
     +-	This option defaults to false.
     ++	This option defaults to `false`.
     + 
     + blame.showRoot::
     + 	Do not treat root commits as boundaries in linkgit:git-blame[1].
     +-	This option defaults to false.
     ++	This option defaults to `false`.
     + 
     + blame.ignoreRevsFile::
     + 	Ignore revisions listed in the file, one unabbreviated object name per
     +
     + ## Documentation/config/branch.adoc ##
     +@@
     + 	that tracks another branch, this variable tells Git to set
     + 	up pull to rebase instead of merge (see `branch.<name>.rebase`).
     + 	The valid settings are:
     +-`never`;; rebase is never automatically set to true.
     +-`local`;; rebase is set to true for tracked branches of other local branches.
     +-`remote`;; rebase is set to true for tracked branches of remote-tracking branches.
     +-`always`;; rebase will be set to true for all tracking branches.
     ++`never`;; rebase is never automatically set to `true`.
     ++`local`;; rebase is set to `true` for tracked branches of other local branches.
     ++`remote`;; rebase is set to `true` for tracked branches of remote-tracking branches.
     ++`always`;; rebase will be set to `true` for all tracking branches.
     + 
     + +
     + See `branch.autoSetupMerge` for details on how to set up a branch to track another branch.
     +@@ Documentation/config/branch.adoc: This option defaults to `never`.
     + 	supported.
     + 
     + `branch.<name>.rebase`::
     +-	When true, rebase the branch _<name>_ on top of the fetched branch,
     ++	When `true`, rebase the branch _<name>_ on top of the fetched branch,
     + 	instead of merging the default branch from the default remote when
     + 	`git pull` is run. See `pull.rebase` for doing this in a non
     + 	branch-specific manner.
      
       ## Documentation/config/clean.adoc ##
      @@
     @@ Documentation/config/clean.adoc
      -	is given. Defaults to true.
      +	is given. Defaults to `true`.
      
     + ## Documentation/config/color.adoc ##
     +@@ Documentation/config/color.adoc: color.interactive.<slot>::
     + 
     + color.pager::
     + 	A boolean to specify whether `auto` color modes should colorize
     +-	output going to the pager. Defaults to true; set this to false
     ++	output going to the pager. Defaults to `true`; set this to `false`
     + 	if your pager does not understand ANSI color codes.
     + 
     + color.push::
     +
       ## Documentation/config/commitgraph.adoc ##
      @@ Documentation/config/commitgraph.adoc: commitGraph.maxNewFilters::
       	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
     @@ Documentation/config/commitgraph.adoc: commitGraph.changedPaths::
       
       commitGraph.changedPathsVersion::
      
     + ## Documentation/config/core.adoc ##
     +@@ Documentation/config/core.adoc: Git for Windows or Eclipse).
     + In such a case it may be necessary to set this variable to 'false'.
     + See linkgit:git-update-index[1].
     + +
     +-The default is true (when core.filemode is not specified in the config file).
     ++The default is `true` (when core.filemode is not specified in the config file).
     + 
     + core.hideDotFiles::
     +-	(Windows-only) If true, mark newly-created directories and files whose
     ++	(Windows-only) If `true`, mark newly-created directories and files whose
     + 	name starts with a dot as hidden.  If 'dotGitOnly', only the `.git/`
     + 	directory is hidden, but no other files starting with a dot.  The
     + 	default mode is 'dotGitOnly'.
     +@@ Documentation/config/core.adoc: core.ignoreCase::
     + 	it is really the same file, and continue to remember it as
     + 	"Makefile".
     + +
     +-The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
     +-will probe and set core.ignoreCase true if appropriate when the repository
     ++The default is `false`, except linkgit:git-clone[1] or linkgit:git-init[1]
     ++will probe and set core.ignoreCase `true` if appropriate when the repository
     + is created.
     + +
     + Git relies on the proper configuration of this variable for your operating
     +@@ Documentation/config/core.adoc: and file system. Modifying this value may result in unexpected behavior.
     + 
     + core.precomposeUnicode::
     + 	This option is only used by Mac OS implementation of Git.
     +-	When core.precomposeUnicode=true, Git reverts the unicode decomposition
     ++	When core.precomposeUnicode=`true`, Git reverts the unicode decomposition
     + 	of filenames done by Mac OS. This is useful when sharing a repository
     + 	between Mac OS and Linux or Windows.
     + 	(Git for Windows 1.7.10 or higher is needed, or Git under cygwin 1.7).
     +-	When false, file names are handled fully transparent by Git,
     ++	When `false`, file names are handled fully transparent by Git,
     + 	which is backward compatible with older versions of Git.
     + 
     + core.protectHFS::
     +-	If set to true, do not allow checkout of paths that would
     ++	If set to `true`, do not allow checkout of paths that would
     + 	be considered equivalent to `.git` on an HFS+ filesystem.
     + 	Defaults to `true` on Mac OS, and `false` elsewhere.
     + 
     + core.protectNTFS::
     +-	If set to true, do not allow checkout of paths that would
     ++	If set to `true`, do not allow checkout of paths that would
     + 	cause problems with the NTFS filesystem, e.g. conflict with
     + 	8.3 "short" names.
     + 	Defaults to `true` on Windows, and `false` elsewhere.
     + 
     + core.fsmonitor::
     +-	If set to true, enable the built-in file system monitor
     ++	If set to `true`, enable the built-in file system monitor
     + 	daemon for this working directory (linkgit:git-fsmonitor{litdd}daemon[1]).
     + +
     + Like hook-based file system monitors, the built-in file system monitor
     +@@ Documentation/config/core.adoc: something that can be used to determine what files have changed
     + without race conditions.
     + 
     + core.trustctime::
     +-	If false, the ctime differences between the index and the
     ++	If `false`, the ctime differences between the index and the
     + 	working tree are ignored; useful when the inode change time
     + 	is regularly modified by something outside Git (file system
     + 	crawlers and some backup systems).
     +-	See linkgit:git-update-index[1]. True by default.
     ++	See linkgit:git-update-index[1]. `True` by default.
     + 
     + core.splitIndex::
     +-	If true, the split-index feature of the index will be used.
     +-	See linkgit:git-update-index[1]. False by default.
     ++	If `true`, the split-index feature of the index will be used.
     ++	See linkgit:git-update-index[1]. `False` by default.
     + 
     + core.untrackedCache::
     + 	Determines what to do about the untracked cache feature of the
     +@@ Documentation/config/core.adoc: core.quotePath::
     + 	backslashes in the same way C escapes control characters (e.g.
     + 	`\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
     + 	values larger than 0x80 (e.g. octal `\302\265` for "micro" in
     +-	UTF-8).  If this variable is set to false, bytes higher than
     ++	UTF-8).  If this variable is set to `false`, bytes higher than
     + 	0x80 are not considered "unusual" any more. Double-quotes,
     + 	backslash and control characters are always escaped regardless
     + 	of the setting of this variable.  A simple space character is
     + 	not considered "unusual".  Many commands can output pathnames
     + 	completely verbatim using the `-z` option. The default value
     +-	is true.
     ++	is `true`.
     + 
     + core.eol::
     + 	Sets the line ending type to use in the working directory for
     +@@ Documentation/config/core.adoc: core.eol::
     + 	is set to `true` or `input`.
     + 
     + core.safecrlf::
     +-	If true, makes Git check if converting `CRLF` is reversible when
     ++	If `true`, makes Git check if converting `CRLF` is reversible when
     + 	end-of-line conversion is active.  Git will verify if a command
     + 	modifies a file in the work tree either directly or indirectly.
     + 	For example, committing a file followed by checking out the
     +@@ Documentation/config/core.adoc: mechanism.
     + core.autocrlf::
     + 	Setting this variable to "true" is the same as setting
     + 	the `text` attribute to "auto" on all files and core.eol to "crlf".
     +-	Set to true if you want to have `CRLF` line endings in your
     ++	Set to `true` if you want to have `CRLF` line endings in your
     + 	working directory and the repository has LF line endings.
     + 	This variable can be set to 'input',
     + 	in which case no output conversion is performed.
     +@@ Documentation/config/core.adoc: core.checkRoundtripEncoding::
     + 	The default value is `SHIFT-JIS`.
     + 
     + core.symlinks::
     +-	If false, symbolic links are checked out as small plain files that
     ++	If `false`, symbolic links are checked out as small plain files that
     + 	contain the link text. linkgit:git-update-index[1] and
     + 	linkgit:git-add[1] will not change the recorded type to regular
     + 	file. Useful on filesystems like FAT that do not support
     + 	symbolic links.
     + +
     +-The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
     +-will probe and set core.symlinks false if appropriate when the repository
     ++The default is `true`, except linkgit:git-clone[1] or linkgit:git-init[1]
     ++will probe and set core.symlinks `false` if appropriate when the repository
     + is created.
     + 
     + core.gitProxy::
     +@@ Documentation/config/core.adoc: core.sshCommand::
     + 	when the environment variable is set.
     + 
     + core.ignoreStat::
     +-	If true, Git will avoid using lstat() calls to detect if files have
     ++	If `true`, Git will avoid using lstat() calls to detect if files have
     + 	changed by setting the "assume-unchanged" bit for those tracked files
     + 	which it has updated identically in both the index and working tree.
     + +
     +@@ Documentation/config/core.adoc: Git will not normally detect changes to those files.
     + This is useful on systems where lstat() calls are very slow, such as
     + CIFS/Microsoft Windows.
     + +
     +-False by default.
     ++`False` by default.
     + 
     + core.preferSymlinkRefs::
     + 	Instead of the default "symref" format for HEAD
     +@@ Documentation/config/core.adoc: core.alternateRefsPrefixes::
     + 	`core.alternateRefsPrefixes` has no effect.
     + 
     + core.bare::
     +-	If true this repository is assumed to be 'bare' and has no
     ++	If `true` this repository is assumed to be 'bare' and has no
     + 	working directory associated with it.  If this is the case a
     + 	number of commands that require a working directory will be
     + 	disabled, such as linkgit:git-add[1] or linkgit:git-merge[1].
     +@@ Documentation/config/core.adoc: core.bare::
     + This setting is automatically guessed by linkgit:git-clone[1] or
     + linkgit:git-init[1] when the repository was created.  By default a
     + repository that ends in "/.git" is assumed to be not bare (bare =
     +-false), while all other repositories are assumed to be bare (bare
     +-= true).
     ++`false`), while all other repositories are assumed to be bare (bare
     ++= `true`).
     + 
     + core.worktree::
     + 	Set the path to the root of the working tree.
     +@@ Documentation/config/core.adoc: read-only snapshot of the same index to a location different from the
     + repository's usual working tree).
     + 
     + core.lockfilePid::
     +-	If true, Git will create a PID file alongside lock files. When a
     ++	If `true`, Git will create a PID file alongside lock files. When a
     + 	lock acquisition fails and a PID file exists, Git can provide
     + 	additional diagnostic information about the process holding the
     + 	lock, including whether it is still running. Defaults to `false`.
     +@@ Documentation/config/core.adoc: core.logAllRefUpdates::
     + This information can be used to determine what commit
     + was the tip of a branch "2 days ago".
     + +
     +-This value is true by default in a repository that has
     +-a working directory associated with it, and false by
     ++This value is `true` by default in a repository that has
     ++a working directory associated with it, and `false` by
     + default in a bare repository.
     + 
     + core.repositoryFormatVersion::
     +@@ Documentation/config/core.adoc: core.sharedRepository::
     + 	the repo read/write-able for the owner and group, but inaccessible to
     + 	others (equivalent to 'group' unless umask is e.g. '0022'). '0640' is a
     + 	repository that is group-readable but not group-writable.
     +-	See linkgit:git-init[1]. False by default.
     ++	See linkgit:git-init[1]. `False` by default.
     + 
     + core.warnAmbiguousRefs::
     +-	If true, Git will warn you if the ref name you passed it is ambiguous
     +-	and might match multiple refs in the repository. True by default.
     ++	If `true`, Git will warn you if the ref name you passed it is ambiguous
     ++	and might match multiple refs in the repository. `True` by default.
     + 
     + core.compression::
     + 	An integer -1..9, indicating a default compression level.
     +@@ Documentation/config/core.adoc: core.fsyncObjectFiles::
     + 	This setting is deprecated. Use core.fsync instead.
     + +
     + This setting affects data added to the Git repository in loose-object
     +-form. When set to true, Git will issue an fsync or similar system call
     ++form. When set to `true`, Git will issue an fsync or similar system call
     + to flush caches so that loose-objects remain consistent in the face
     + of a unclean system shutdown.
     + 
     +@@ Documentation/config/core.adoc: This can speed up operations like 'git diff' and 'git status' especially
     + on filesystems like NFS that have weak caching semantics and thus
     + relatively high IO latencies.  When enabled, Git will do the
     + index comparison to the filesystem data in parallel, allowing
     +-overlapping IO's.  Defaults to true.
     ++overlapping IO's.  Defaults to `true`.
     + 
     + core.unsetenvvars::
     + 	Windows-only: comma-separated list of environment variables'
     +@@ Documentation/config/core.adoc: This setting defaults to "refs/notes/commits", and it can be overridden by
     + the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
     + 
     + core.commitGraph::
     +-	If true, then git will read the commit-graph file (if it exists)
     +-	to parse the graph structure of commits. Defaults to true. See
     ++	If `true`, then git will read the commit-graph file (if it exists)
     ++	to parse the graph structure of commits. Defaults to `true`. See
     + 	linkgit:git-commit-graph[1] for more information.
     + 
     + core.useReplaceRefs::
     +@@ Documentation/config/core.adoc: core.useReplaceRefs::
     + core.multiPackIndex::
     + 	Use the multi-pack-index file to track multiple packfiles using a
     + 	single index. See linkgit:git-multi-pack-index[1] for more
     +-	information. Defaults to true.
     ++	information. Defaults to `true`.
     + 
     + core.sparseCheckout::
     + 	Enable "sparse checkout" feature. See linkgit:git-sparse-checkout[1]
     +
       ## Documentation/config/credential.adoc ##
      @@ Documentation/config/credential.adoc: credential.interactive::
       
     @@ Documentation/config/credential.adoc: credential.interactive::
       
       credential.sanitizePrompt::
      
     + ## Documentation/config/fetch.adoc ##
     +@@
     + 	in `git pull`) will recursively fetch into populated submodules.
     + 	This option can be set either to a boolean value or to `on-demand`.
     + 	Setting it to a boolean changes the behavior of fetch and pull to
     +-	recurse unconditionally into submodules when set to true or to not
     +-	recurse at all when set to false. When set to `on-demand`, fetch and
     ++	recurse unconditionally into submodules when set to `true` or to not
     ++	recurse at all when set to `false`. When set to `on-demand`, fetch and
     + 	pull will only recurse into a populated submodule when its
     + 	superproject retrieves a commit that updates the submodule's
     + 	reference.
     + 	Defaults to `on-demand`, or to the value of `submodule.recurse` if set.
     + 
     + `fetch.fsckObjects`::
     +-	If it is set to true, git-fetch-pack will check all fetched
     ++	If it is set to `true`, git-fetch-pack will check all fetched
     + 	objects. See `transfer.fsckObjects` for what's
     + 	checked. Defaults to `false`. If not set, the value of
     + 	`transfer.fsckObjects` is used instead.
     +@@
     + 	`transfer.unpackLimit` is used instead.
     + 
     + `fetch.prune`::
     +-	If true, fetch will automatically behave as if the `--prune`
     ++	If `true`, fetch will automatically behave as if the `--prune`
     + 	option was given on the command line.  See also `remote.<name>.prune`
     + 	and the PRUNING section of linkgit:git-fetch[1].
     + 
     + `fetch.pruneTags`::
     +-	If true, fetch will automatically behave as if the
     ++	If `true`, fetch will automatically behave as if the
     + 	`refs/tags/*:refs/tags/*` refspec was provided when pruning,
     + 	if not set already. This allows for setting both this option
     + 	and `fetch.prune` to maintain a 1=1 mapping to upstream
     +@@
     + 	section of linkgit:git-fetch[1].
     + 
     + `fetch.all`::
     +-	If true, fetch will attempt to update all available remotes.
     ++	If `true`, fetch will attempt to update all available remotes.
     + 	This behavior can be overridden by passing `--no-all` or by
     + 	explicitly specifying one or more remote(s) to fetch from.
     + 	Defaults to `false`.
     +@@ Documentation/config/fetch.adoc: For submodules, this setting can be overridden using the `submodule.fetchJobs`
     + config setting.
     + 
     + `fetch.writeCommitGraph`::
     +-	Set to true to write a commit-graph after every `git fetch` command
     ++	Set to `true` to write a commit-graph after every `git fetch` command
     + 	that downloads a pack-file from a remote. Using the `--split` option,
     + 	most executions will create a very small commit-graph file on top of
     + 	the existing commit-graph file(s). Occasionally, these files will
     +
       ## Documentation/config/fmt-merge-msg.adoc ##
      @@
       `merge.branchdesc`::
     @@ Documentation/config/format.adoc: format.useAutoBase::
       If one wishes to use the ref `refs/notes/true`, please use that literal
       instead.
      
     + ## Documentation/config/gc.adoc ##
     +@@ Documentation/config/gc.adoc: use, it'll affect how the auto pack limit works.
     + 
     + gc.autoDetach::
     + 	Make `git gc --auto` return immediately and run in the background
     +-	if the system supports it. Default is true. This config variable acts
     ++	if the system supports it. Default is `true`. This config variable acts
     + 	as a fallback in case `maintenance.autoDetach` is not set.
     + 
     + gc.bigPackThreshold::
     +@@ Documentation/config/gc.adoc: will also be excluded (this is the equivalent of running `git gc` with
     + `--keep-largest-pack`).
     + 
     + gc.writeCommitGraph::
     +-	If true, then gc will rewrite the commit-graph file when
     ++	If `true`, then gc will rewrite the commit-graph file when
     + 	linkgit:git-gc[1] is run. When using `git gc --auto`
     + 	the commit-graph will be updated if housekeeping is
     +-	required. Default is true. See linkgit:git-commit-graph[1]
     ++	required. Default is `true`. See linkgit:git-commit-graph[1]
     + 	for details.
     + 
     + gc.logExpiry::
     +
     + ## Documentation/config/gitcvs.adoc ##
     +@@ Documentation/config/gitcvs.adoc: gitcvs.logFile::
     + 	various stuff. See linkgit:git-cvsserver[1].
     + 
     + gitcvs.usecrlfattr::
     +-	If true, the server will look up the end-of-line conversion
     ++	If `true`, the server will look up the end-of-line conversion
     + 	attributes for files to determine the `-k` modes to use. If
     + 	the attributes force Git to treat a file as text,
     + 	the `-k` mode will be left blank so CVS clients will
     +@@ Documentation/config/gitcvs.adoc: gitcvs.usecrlfattr::
     + 
     + gitcvs.allBinary::
     + 	This is used if `gitcvs.usecrlfattr` does not resolve
     +-	the correct '-kb' mode to use. If true, all
     ++	the correct '-kb' mode to use. If `true`, all
     + 	unresolved files are sent to the client in
     + 	mode '-kb'. This causes the client to treat them
     + 	as binary files, which suppresses any newline munging it
     +
       ## Documentation/config/grep.adoc ##
      @@
       grep.lineNumber::
     @@ Documentation/config/grep.adoc: grep.threads::
      +	If set to `true`, fall back to `git grep --no-index` if `git grep`
      +	is executed outside of a git repository.  Defaults to `false`.
      
     + ## Documentation/config/gui.adoc ##
     +@@ Documentation/config/gui.adoc: gui.spellingDictionary::
     + 	off.
     + 
     + gui.fastCopyBlame::
     +-	If true, 'git gui blame' uses `-C` instead of `-C -C` for original
     ++	If `true`, 'git gui blame' uses `-C` instead of `-C -C` for original
     + 	location detection. It makes blame significantly faster on huge
     + 	repositories at the expense of less thorough copy detection.
     + 
     +
     + ## Documentation/config/http.adoc ##
     +@@ Documentation/config/http.adoc: http.emptyAuth::
     + http.proactiveAuth::
     + 	Attempt authentication without first making an unauthenticated attempt and
     + 	receiving a 401 response. This can be used to ensure that all requests are
     +-	authenticated. If `http.emptyAuth` is set to true, this value has no effect.
     ++	authenticated. If `http.emptyAuth` is set to `true`, this value has no effect.
     + +
     + If the credential helper used specifies an authentication scheme (i.e., via the
     + `authtype` field), that value will be used; if a username and password is
     +@@ Documentation/config/http.adoc: empty string.
     + 
     + http.sslVerify::
     + 	Whether to verify the SSL certificate when fetching or pushing
     +-	over HTTPS. Defaults to true. Can be overridden by the
     ++	over HTTPS. Defaults to `true`. Can be overridden by the
     + 	`GIT_SSL_NO_VERIFY` environment variable.
     + 
     + http.sslCert::
     +@@ Documentation/config/http.adoc: http.sslTry::
     + 	when connecting via regular FTP protocol. This might be needed
     + 	if the FTP server requires it for security reasons or you wish
     + 	to connect securely whenever remote FTP server supports it.
     +-	Default is false since it might trigger certificate verification
     ++	Default is `false` since it might trigger certificate verification
     + 	errors on misconfigured servers.
     + 
     + http.maxRequests::
     +@@ Documentation/config/http.adoc: http.noEPSV::
     + 	A boolean which disables using of EPSV ftp command by curl.
     + 	This can be helpful with some "poor" ftp servers which don't
     + 	support EPSV mode. Can be overridden by the `GIT_CURL_FTP_NO_EPSV`
     +-	environment variable. Default is false (curl will use EPSV).
     ++	environment variable. Default is `false` (curl will use EPSV).
     + 
     + http.userAgent::
     + 	The HTTP USER_AGENT string presented to an HTTP server.  The default
     +
     + ## Documentation/config/instaweb.adoc ##
     +@@ Documentation/config/instaweb.adoc: instaweb.httpd::
     + 	repository. See linkgit:git-instaweb[1].
     + 
     + instaweb.local::
     +-	If true the web server started by linkgit:git-instaweb[1] will
     ++	If `true` the web server started by linkgit:git-instaweb[1] will
     + 	be bound to the local IP (127.0.0.1).
     + 
     + instaweb.modulePath::
     +
     + ## Documentation/config/interactive.adoc ##
     +@@
     + interactive.singleKey::
     +-	When set to true, allow the user to provide one-letter input
     ++	When set to `true`, allow the user to provide one-letter input
     + 	with a single key (i.e., without hitting the Enter key) in
     + 	interactive commands.  This is currently used by the `--patch`
     + 	mode of linkgit:git-add[1], linkgit:git-checkout[1],
     +
     + ## Documentation/config/log.adoc ##
     +@@ Documentation/config/log.adoc: This is the same as the `--decorate` option of the `git log`.
     + 	history lines in `git log --graph`.
     + 
     + `log.showRoot`::
     +-	If true, the initial commit will be shown as a big creation event.
     ++	If `true`, the initial commit will be shown as a big creation event.
     + 	This is equivalent to a diff against an empty tree.
     + 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
     + 	normally hide the root commit will now show it. True by default.
     + 
     + `log.showSignature`::
     +-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
     ++	If `true`, makes linkgit:git-log[1], linkgit:git-show[1], and
     + 	linkgit:git-whatchanged[1] assume `--show-signature`.
     + 
     + `log.mailmap`::
     +-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
     ++	If `true`, makes linkgit:git-log[1], linkgit:git-show[1], and
     + 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
     + 	assume `--no-use-mailmap`. True by default.
     +
     + ## Documentation/config/mailinfo.adoc ##
     +@@
     + mailinfo.scissors::
     +-	If true, makes linkgit:git-mailinfo[1] (and therefore
     ++	If `true`, makes linkgit:git-mailinfo[1] (and therefore
     + 	linkgit:git-am[1]) act by default as if the --scissors option
     + 	was provided on the command-line. When active, this feature
     + 	removes everything from the message body before a scissors
     +
     + ## Documentation/config/maintenance.adoc ##
     +@@
     + maintenance.auto::
     + 	This boolean config option controls whether some commands run
     + 	`git maintenance run --auto` after doing their normal work. Defaults
     +-	to true.
     ++	to `true`.
     + 
     + maintenance.autoDetach::
     + 	Many Git commands trigger automatic maintenance after they have
     +@@ Documentation/config/maintenance.adoc: maintenance.autoDetach::
     + 	continue to run in the background.
     + +
     + If unset, the value of `gc.autoDetach` is used as a fallback. Defaults
     +-to true if both are unset, meaning that the maintenance process will
     ++to `true` if both are unset, meaning that the maintenance process will
     + detach.
     + 
     + maintenance.strategy::
     +@@ Documentation/config/maintenance.adoc: maintenance.<task>.enabled::
     + 	with name `<task>` is run when no `--task` option is specified to
     + 	`git maintenance run`. These config values are ignored if a
     + 	`--task` option exists. By default, only `maintenance.gc.enabled`
     +-	is true.
     ++	is `true`.
     + 
     + maintenance.<task>.schedule::
     + 	This config option controls whether or not the given `<task>` runs
     +
     + ## Documentation/config/merge.adoc ##
     +@@
     + 	branches at the remote named by `branch.<current-branch>.remote`
     + 	are consulted, and then they are mapped via `remote.<remote>.fetch`
     + 	to their corresponding remote-tracking branches, and the tips of
     +-	these tracking branches are merged. Defaults to true.
     ++	these tracking branches are merged. Defaults to `true`.
     + 
     + `merge.ff`::
     + 	By default, Git does not create an extra merge commit when merging
     +@@
     + 	command line).
     + 
     + `merge.verifySignatures`::
     +-	If true, this is equivalent to the `--verify-signatures` command
     ++	If `true`, this is equivalent to the `--verify-signatures` command
     + 	line option. See linkgit:git-merge[1] for details.
     + 
     + include::fmt-merge-msg.adoc[]
     +
     + ## Documentation/config/mergetool.adoc ##
     +@@
     + `mergetool.<tool>.trustExitCode`::
     + 	For a custom merge command, specify whether the exit code of
     + 	the merge command can be used to determine whether the merge was
     +-	successful.  If this is not set to true then the merge target file
     ++	successful.  If this is not set to `true` then the merge target file
     + 	timestamp is checked, and the merge is assumed to have been successful
     + 	if the file has been updated; otherwise, the user is prompted to
     + 	indicate the success of the merge.
     +
     + ## Documentation/config/pack.adoc ##
     +@@ Documentation/config/pack.adoc: all existing objects. You can force recompression by passing the -F option
     + to linkgit:git-repack[1].
     + 
     + pack.allowPackReuse::
     +-	When true or "single", and when reachability bitmaps are
     ++	When `true` or "single", and when reachability bitmaps are
     + 	enabled, pack-objects will try to send parts of the bitmapped
     + 	packfile verbatim. When "multi", and when a multi-pack
     + 	reachability bitmap is available, pack-objects will try to send
     +@@ Documentation/config/pack.adoc: pack.allowPackReuse::
     + If only a single pack bitmap is available, and `pack.allowPackReuse`
     + is set to "multi", reuse parts of just the bitmapped packfile. This
     + can reduce memory and CPU usage to serve fetches, but might result in
     +-sending a slightly larger pack. Defaults to true.
     ++sending a slightly larger pack. Defaults to `true`.
     + 
     + pack.island::
     + 	An extended regular expression configuring a set of delta
     +@@ Documentation/config/pack.adoc: The minimum size allowed is limited to 1 MiB. The default is unlimited.
     + Common unit suffixes of 'k', 'm', or 'g' are supported.
     + 
     + pack.useBitmaps::
     +-	When true, git will use pack bitmaps (if available) when packing
     ++	When `true`, git will use pack bitmaps (if available) when packing
     + 	to stdout (e.g., during the server side of a fetch). Defaults to
     +-	true. You should not generally need to turn this off unless
     ++	`true`. You should not generally need to turn this off unless
     + 	you are debugging pack bitmaps.
     + 
     + pack.useBitmapBoundaryTraversal::
     +-	When true, Git will use an experimental algorithm for computing
     ++	When `true`, Git will use an experimental algorithm for computing
     + 	reachability queries with bitmaps. Instead of building up
     + 	complete bitmaps for all of the negated tips and then OR-ing
     + 	them together, consider negated tips with existing bitmaps as
     +@@ Documentation/config/pack.adoc: particularly when there is poor bitmap coverage of the negated side of
     + the query.
     + 
     + pack.useSparse::
     +-	When true, git will default to using the '--sparse' option in
     ++	When `true`, git will default to using the '--sparse' option in
     + 	'git pack-objects' when the '--revs' option is present. This
     + 	algorithm only walks trees that appear in paths that introduce new
     + 	objects. This can have significant performance benefits when
     +@@ Documentation/config/pack.adoc: pack.writeBitmaps (deprecated)::
     + 	This is a deprecated synonym for `repack.writeBitmaps`.
     + 
     + pack.writeBitmapHashCache::
     +-	When true, git will include a "hash cache" section in the bitmap
     ++	When `true`, git will include a "hash cache" section in the bitmap
     + 	index (if one is written). This cache can be used to feed git's
     + 	delta heuristics, potentially leading to better deltas between
     + 	bitmapped and non-bitmapped objects (e.g., when serving a fetch
     + 	between an older, bitmapped pack and objects that have been
     + 	pushed since the last gc). The downside is that it consumes 4
     +-	bytes per object of disk space. Defaults to true.
     ++	bytes per object of disk space. Defaults to `true`.
     + +
     + When writing a multi-pack reachability bitmap, no new namehashes are
     + computed; instead, any namehashes stored in an existing bitmap are
     + permuted into their appropriate location when writing a new bitmap.
     + 
     + pack.writeBitmapLookupTable::
     +-	When true, Git will include a "lookup table" section in the
     ++	When `true`, Git will include a "lookup table" section in the
     + 	bitmap index (if one is written). This table is used to defer
     + 	loading individual bitmaps as late as possible. This can be
     + 	beneficial in repositories that have relatively large bitmap
     +-	indexes. Defaults to false.
     ++	indexes. Defaults to `false`.
     + 
     + pack.readReverseIndex::
     +-	When true, git will read any .rev file(s) that may be available
     +-	(see: linkgit:gitformat-pack[5]). When false, the reverse index
     ++	When `true`, git will read any .rev file(s) that may be available
     ++	(see: linkgit:gitformat-pack[5]). When `false`, the reverse index
     + 	will be generated from scratch and stored in memory. Defaults to
     +-	true.
     ++	`true`.
     + 
     + pack.writeReverseIndex::
     +-	When true, git will write a corresponding .rev file (see:
     ++	When `true`, git will write a corresponding .rev file (see:
     + 	linkgit:gitformat-pack[5])
     + 	for each new packfile that it writes in all places except for
     + 	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
     +-	Defaults to true.
     ++	Defaults to `true`.
     +
     + ## Documentation/config/pull.adoc ##
     +@@ Documentation/config/pull.adoc: pull.ff::
     + 	command line). This setting overrides `merge.ff` when pulling.
     + 
     + pull.rebase::
     +-	When true, rebase branches on top of the fetched branch, instead
     ++	When `true`, rebase branches on top of the fetched branch, instead
     + 	of merging the default branch from the default remote when "git
     + 	pull" is run. See "branch.<name>.rebase" for setting this on a
     + 	per-branch basis.
     +@@ Documentation/config/pull.adoc: pull.octopus::
     + 	at once.
     + 
     + pull.autoStash::
     +-	When set to true, automatically create a temporary stash entry
     ++	When set to `true`, automatically create a temporary stash entry
     + 	to record the local changes before the operation begins, and
     + 	restore them after the operation completes.  When your "git
     + 	pull" rebases (instead of merges), this may be convenient, since
     +
     + ## Documentation/config/push.adoc ##
     +@@ Documentation/config/push.adoc: new default).
     + --
     + 
     + `push.followTags`::
     +-	If set to true, enable `--follow-tags` option by default.  You
     ++	If set to `true`, enable `--follow-tags` option by default.  You
     + 	may override this configuration at time of push by specifying
     + 	`--no-follow-tags`.
     + 
     +
       ## Documentation/config/rebase.adoc ##
      @@ Documentation/config/rebase.adoc: rebase.stat::
       	rebase. False by default.
     @@ Documentation/config/rebase.adoc: rebase.rescheduleFailedExec::
       	command line, with or without an argument, overrides any
       	`rebase.rebaseMerges` configuration.
      
     + ## Documentation/config/receive.adoc ##
     +@@
     + receive.advertiseAtomic::
     + 	By default, git-receive-pack will advertise the atomic push
     + 	capability to its clients. If you don't want to advertise this
     +-	capability, set this variable to false.
     ++	capability, set this variable to `false`.
     + 
     + receive.advertisePushOptions::
     +-	When set to true, git-receive-pack will advertise the push options
     ++	When set to `true`, git-receive-pack will advertise the push options
     + 	capability to its clients. False by default.
     + 
     + receive.autogc::
     + 	By default, git-receive-pack will run "git maintenance run --auto" after
     + 	receiving data from git-push and updating refs.  You can stop
     +-	it by setting this variable to false.
     ++	it by setting this variable to `false`.
     + 
     + receive.certNonceSeed::
     + 	By setting this variable to a string, `git receive-pack`
     +@@ Documentation/config/receive.adoc: receive.certNonceSlop::
     + 	can check `GIT_PUSH_CERT_NONCE_STATUS` is `OK`.
     + 
     + receive.fsckObjects::
     +-	If it is set to true, git-receive-pack will check all received
     ++	If it is set to `true`, git-receive-pack will check all received
     + 	objects. See `transfer.fsckObjects` for what's checked.
     +-	Defaults to false. If not set, the value of
     ++	Defaults to `false`. If not set, the value of
     + 	`transfer.fsckObjects` is used instead.
     + 
     + receive.fsck.<msg-id>::
     +@@ Documentation/config/receive.adoc: receive.maxInputSize::
     + 	is unlimited.
     + 
     + receive.denyDeletes::
     +-	If set to true, git-receive-pack will deny a ref update that deletes
     ++	If set to `true`, git-receive-pack will deny a ref update that deletes
     + 	the ref. Use this to prevent such a ref deletion via a push.
     + 
     + receive.denyDeleteCurrent::
     +-	If set to true, git-receive-pack will deny a ref update that
     ++	If set to `true`, git-receive-pack will deny a ref update that
     + 	deletes the currently checked out branch of a non-bare repository.
     + 
     + receive.denyCurrentBranch::
     +-	If set to true or "refuse", git-receive-pack will deny a ref update
     ++	If set to `true` or "refuse", git-receive-pack will deny a ref update
     + 	to the currently checked out branch of a non-bare repository.
     + 	Such a push is potentially dangerous because it brings the HEAD
     + 	out of sync with the index and working tree. If set to "warn",
     + 	print a warning of such a push to stderr, but allow the push to
     +-	proceed. If set to false or "ignore", allow such pushes with no
     ++	proceed. If set to `false` or "ignore", allow such pushes with no
     + 	message. Defaults to "refuse".
     + +
     + Another option is "updateInstead" which will update the working
     +@@ Documentation/config/receive.adoc: the index have any difference from the HEAD, but the `push-to-checkout`
     + hook can be used to customize this.  See linkgit:githooks[5].
     + 
     + receive.denyNonFastForwards::
     +-	If set to true, git-receive-pack will deny a ref update which is
     ++	If set to `true`, git-receive-pack will deny a ref update which is
     + 	not a fast-forward. Use this to prevent such an update via a push,
     + 	even if that push is forced. This configuration variable is
     + 	set when initializing a shared repository.
     +@@ Documentation/config/receive.adoc: E.g.:
     + 	git config --system --add receive.procReceiveRefs !:refs/heads
     + 
     + receive.updateServerInfo::
     +-	If set to true, git-receive-pack will run git-update-server-info
     ++	If set to `true`, git-receive-pack will run git-update-server-info
     + 	after receiving data from git-push and updating refs.
     + 
     + receive.shallowUpdate::
     +-	If set to true, .git/shallow can be updated when new refs
     ++	If set to `true`, .git/shallow can be updated when new refs
     + 	require new shallow roots. Otherwise those refs are rejected.
     +
     + ## Documentation/config/remote.adoc ##
     +@@ Documentation/config/remote.adoc: remote.<name>.push::
     + 	linkgit:git-push[1].
     + 
     + remote.<name>.mirror::
     +-	If true, pushing to this remote will automatically behave
     ++	If `true`, pushing to this remote will automatically behave
     + 	as if the `--mirror` option was given on the command line.
     + 
     + remote.<name>.skipDefaultUpdate::
     +@@ Documentation/config/remote.adoc: remote.<name>.skipDefaultUpdate::
     + 	values, the value of the last occurrence will be used).
     + 
     + remote.<name>.skipFetchAll::
     +-	If true, this remote will be skipped when updating
     ++	If `true`, this remote will be skipped when updating
     + 	using linkgit:git-fetch[1], the `update` subcommand of
     + 	linkgit:git-remote[1], and ignored by the prefetch task
     + 	of `git maintenance`.
     +@@ Documentation/config/remote.adoc: remote.<name>.vcs::
     + 	the remote with the git-remote-<vcs> helper.
     + 
     + remote.<name>.prune::
     +-	When set to true, fetching from this remote by default will also
     ++	When set to `true`, fetching from this remote by default will also
     + 	remove any remote-tracking references that no longer exist on the
     + 	remote (as if the `--prune` option was given on the command line).
     + 	Overrides `fetch.prune` settings, if any.
     + 
     + remote.<name>.pruneTags::
     +-	When set to true, fetching from this remote by default will also
     ++	When set to `true`, fetching from this remote by default will also
     + 	remove any local tags that no longer exist on the remote if pruning
     + 	is activated in general via `remote.<name>.prune`, `fetch.prune` or
     + 	`--prune`. Overrides `fetch.pruneTags` settings, if any.
     +@@ Documentation/config/remote.adoc: See also `remote.<name>.prune` and the PRUNING section of
     + linkgit:git-fetch[1].
     + 
     + remote.<name>.promisor::
     +-	When set to true, this remote will be used to fetch promisor
     ++	When set to `true`, this remote will be used to fetch promisor
     + 	objects.
     + 
     + remote.<name>.partialclonefilter::
     +
     + ## Documentation/config/repack.adoc ##
     +@@ Documentation/config/repack.adoc: repack.useDeltaBaseOffset::
     + 	native protocol are unaffected by this option.
     + 
     + repack.packKeptObjects::
     +-	If set to true, makes `git repack` act as if
     ++	If set to `true`, makes `git repack` act as if
     + 	`--pack-kept-objects` was passed. See linkgit:git-repack[1] for
     + 	details. Defaults to `false` normally, but `true` if a bitmap
     + 	index is being written (either via `--write-bitmap-index` or
     + 	`repack.writeBitmaps`).
     + 
     + repack.useDeltaIslands::
     +-	If set to true, makes `git repack` act as if `--delta-islands`
     ++	If set to `true`, makes `git repack` act as if `--delta-islands`
     + 	was passed. Defaults to `false`.
     + 
     + repack.writeBitmaps::
     +-	When true, git will write a bitmap index when packing all
     ++	When `true`, git will write a bitmap index when packing all
     + 	objects to disk (e.g., when `git repack -a` is run).  This
     + 	index can speed up the "counting objects" phase of subsequent
     + 	packs created for clones and fetches, at the cost of some disk
     + 	space and extra time spent on the initial repack.  This has
     + 	no effect if multiple packfiles are created.
     +-	Defaults to true on bare repos, false otherwise.
     ++	Defaults to `true` on bare repos, `false` otherwise.
     + 
     + repack.updateServerInfo::
     +-	If set to false, linkgit:git-repack[1] will not run
     +-	linkgit:git-update-server-info[1]. Defaults to true. Can be overridden
     +-	when true by the `-n` option of linkgit:git-repack[1].
     ++	If set to `false`, linkgit:git-repack[1] will not run
     ++	linkgit:git-update-server-info[1]. Defaults to `true`. Can be overridden
     ++	when `true` by the `-n` option of linkgit:git-repack[1].
     + 
     + repack.cruftWindow::
     + repack.cruftWindowMemory::
     +@@ Documentation/config/repack.adoc: repack.cruftThreads::
     + 	variables for defaults and meaning.
     + 
     + repack.midxMustContainCruft::
     +-	When set to true, linkgit:git-repack[1] will unconditionally include
     ++	When set to `true`, linkgit:git-repack[1] will unconditionally include
     + 	cruft pack(s), if any, in the multi-pack index when invoked with
     +-	`--write-midx`. When false, cruft packs are only included in the MIDX
     ++	`--write-midx`. When `false`, cruft packs are only included in the MIDX
     + 	when necessary (e.g., because they might be required to form a
     +-	reachability closure with MIDX bitmaps). Defaults to true.
     ++	reachability closure with MIDX bitmaps). Defaults to `true`.
     +
       ## Documentation/config/rerere.adoc ##
      @@
       rerere.autoUpdate::
     @@ Documentation/config/rerere.adoc
       rerere.enabled::
       	Activate recording of resolved conflicts, so that identical
      
     + ## Documentation/config/revert.adoc ##
     +@@
     + revert.reference::
     +-	Setting this variable to true makes `git revert` behave
     ++	Setting this variable to `true` makes `git revert` behave
     + 	as if the `--reference` option is given.
     +
       ## Documentation/config/stash.adoc ##
      @@ Documentation/config/stash.adoc: ifdef::git-stash[]
       endif::git-stash[]
     @@ Documentation/config/status.adoc: This variable can be overridden with the -u|--
       	unlimited number), the submodule summary will be enabled and a
       	summary of commits for modified submodules will be shown (see
       	--summary-limit option of linkgit:git-submodule[1]). Please note
     +
     + ## Documentation/config/submodule.adoc ##
     +@@ Documentation/config/submodule.adoc: submodule.active::
     + 
     + submodule.recurse::
     + 	A boolean indicating if commands should enable the `--recurse-submodules`
     +-	option by default. Defaults to false.
     ++	option by default. Defaults to `false`.
     + +
     +-When set to true, it can be deactivated via the
     ++When set to `true`, it can be deactivated via the
     + `--no-recurse-submodules` option. Note that some Git commands
     + lacking this option may call some of the above commands affected by
     + `submodule.recurse`; for instance `git remote update` will call
     +@@ Documentation/config/submodule.adoc: submodule.propagateBranches::
     + 	Enabling this will allow certain commands to accept
     + 	`--recurse-submodules` and certain commands that already accept
     + 	`--recurse-submodules` will now consider branches.
     +-	Defaults to false.
     ++	Defaults to `false`.
     + 
     + submodule.fetchJobs::
     + 	Specifies how many submodules are fetched/cloned at the same time.
     +
     + ## Documentation/config/trace2.adoc ##
     +@@ Documentation/config/trace2.adoc: trace2.eventTarget::
     + include::../trace2-target-values.adoc[]
     + 
     + trace2.normalBrief::
     +-	Boolean.  When true `time`, `filename`, and `line` fields are
     ++	Boolean.  When `true` `time`, `filename`, and `line` fields are
     + 	omitted from normal output.  May be overridden by the
     +-	`GIT_TRACE2_BRIEF` environment variable.  Defaults to false.
     ++	`GIT_TRACE2_BRIEF` environment variable.  Defaults to `false`.
     + 
     + trace2.perfBrief::
     +-	Boolean.  When true `time`, `filename`, and `line` fields are
     ++	Boolean.  When `true` `time`, `filename`, and `line` fields are
     + 	omitted from PERF output.  May be overridden by the
     +-	`GIT_TRACE2_PERF_BRIEF` environment variable.  Defaults to false.
     ++	`GIT_TRACE2_PERF_BRIEF` environment variable.  Defaults to `false`.
     + 
     + trace2.eventBrief::
     +-	Boolean.  When true `time`, `filename`, and `line` fields are
     ++	Boolean.  When `true` `time`, `filename`, and `line` fields are
     + 	omitted from event output.  May be overridden by the
     +-	`GIT_TRACE2_EVENT_BRIEF` environment variable.  Defaults to false.
     ++	`GIT_TRACE2_EVENT_BRIEF` environment variable.  Defaults to `false`.
     + 
     + trace2.eventNesting::
     + 	Integer.  Specifies desired depth of nested regions in the
     +@@ Documentation/config/trace2.adoc: trace2.envVars::
     + 	default.
     + 
     + trace2.destinationDebug::
     +-	Boolean.  When true Git will print error messages when a
     ++	Boolean.  When `true` Git will print error messages when a
     + 	trace target destination cannot be opened for writing.
     + 	By default, these errors are suppressed and tracing is
     + 	silently disabled.  May be overridden by the
     +
     + ## Documentation/config/transfer.adoc ##
     +@@ Documentation/config/transfer.adoc: data in git's configuration files. If you do want to use this, set
     + transfer.fsckObjects::
     + 	When `fetch.fsckObjects` or `receive.fsckObjects` are
     + 	not set, the value of this variable is used instead.
     +-	Defaults to false.
     ++	Defaults to `false`.
     + +
     + When set, the fetch or receive will abort in the case of a malformed
     + object or a link to a nonexistent object. In addition, various other
     +@@ Documentation/config/transfer.adoc: transfer.unpackLimit::
     + 	The default value is 100.
     + 
     + transfer.advertiseSID::
     +-	Boolean. When true, client and server processes will advertise their
     +-	unique session IDs to their remote counterpart. Defaults to false.
     ++	Boolean. When `true`, client and server processes will advertise their
     ++	unique session IDs to their remote counterpart. Defaults to `false`.
     + 
     + transfer.bundleURI::
     + 	When `true`, local `git clone` commands will request bundle
     +@@ Documentation/config/transfer.adoc: transfer.bundleURI::
     + 
     + transfer.advertiseObjectInfo::
     + 	When `true`, the `object-info` capability is advertised by
     +-	servers. Defaults to false.
     ++	servers. Defaults to `false`.
     +
     + ## Documentation/config/uploadarchive.adoc ##
     +@@
     + uploadarchive.allowUnreachable::
     +-	If true, allow clients to use `git archive --remote` to request
     ++	If `true`, allow clients to use `git archive --remote` to request
     + 	any tree, whether reachable from the ref tips or not. See the
     + 	discussion in the "SECURITY" section of
     + 	linkgit:git-upload-archive[1] for more details. Defaults to
     +
     + ## Documentation/config/worktree.adoc ##
     +@@
     + 	If no branch is specified and neither `-b` nor `-B` nor
     + 	`--detach` is used, then `git worktree add` defaults to
     + 	creating a new branch from HEAD.  If `worktree.guessRemote` is
     +-	set to true, `worktree add` tries to find a remote-tracking
     ++	set to `true`, `worktree add` tries to find a remote-tracking
     + 	branch whose name uniquely matches the new branch name.  If
     + 	such a branch exists, it is checked out and set as "upstream"
     + 	for the new branch.  If no such match can be found, it falls


 Documentation/config/am.adoc            |  4 +-
 Documentation/config/blame.adoc         |  6 +--
 Documentation/config/branch.adoc        | 10 ++--
 Documentation/config/clean.adoc         |  2 +-
 Documentation/config/color.adoc         |  2 +-
 Documentation/config/commitgraph.adoc   |  8 +--
 Documentation/config/core.adoc          | 72 ++++++++++++-------------
 Documentation/config/credential.adoc    |  2 +-
 Documentation/config/fetch.adoc         | 14 ++---
 Documentation/config/fmt-merge-msg.adoc |  6 +--
 Documentation/config/format.adoc        | 22 ++++----
 Documentation/config/gc.adoc            |  6 +--
 Documentation/config/gitcvs.adoc        |  4 +-
 Documentation/config/grep.adoc          | 12 ++---
 Documentation/config/gui.adoc           |  2 +-
 Documentation/config/http.adoc          |  8 +--
 Documentation/config/instaweb.adoc      |  2 +-
 Documentation/config/interactive.adoc   |  2 +-
 Documentation/config/log.adoc           |  6 +--
 Documentation/config/mailinfo.adoc      |  2 +-
 Documentation/config/maintenance.adoc   |  6 +--
 Documentation/config/merge.adoc         |  4 +-
 Documentation/config/mergetool.adoc     |  2 +-
 Documentation/config/pack.adoc          | 30 +++++------
 Documentation/config/pull.adoc          |  4 +-
 Documentation/config/push.adoc          |  2 +-
 Documentation/config/rebase.adoc        | 18 +++----
 Documentation/config/receive.adoc       | 24 ++++-----
 Documentation/config/remote.adoc        | 10 ++--
 Documentation/config/repack.adoc        | 20 +++----
 Documentation/config/rerere.adoc        |  4 +-
 Documentation/config/revert.adoc        |  2 +-
 Documentation/config/stash.adoc         | 16 +++---
 Documentation/config/status.adoc        | 20 +++----
 Documentation/config/submodule.adoc     |  6 +--
 Documentation/config/trace2.adoc        | 14 ++---
 Documentation/config/transfer.adoc      |  8 +--
 Documentation/config/uploadarchive.adoc |  2 +-
 Documentation/config/worktree.adoc      |  2 +-
 39 files changed, 193 insertions(+), 193 deletions(-)

diff --git a/Documentation/config/am.adoc b/Documentation/config/am.adoc
index 5bcad2efb1..d072613400 100644
--- a/Documentation/config/am.adoc
+++ b/Documentation/config/am.adoc
@@ -1,5 +1,5 @@
 am.keepcr::
-	If true, git-am will call git-mailsplit for patches in mbox format
+	If `true`, git-am will call git-mailsplit for patches in mbox format
 	with parameter `--keep-cr`. In this case git-mailsplit will
 	not remove `\r` from lines ending with `\r\n`. Can be overridden
 	by giving `--no-keep-cr` from the command line.
@@ -7,7 +7,7 @@ am.keepcr::
 
 am.threeWay::
 	By default, `git am` will fail if the patch does not apply cleanly. When
-	set to true, this setting tells `git am` to fall back on 3-way merge if
+	set to `true`, this setting tells `git am` to fall back on 3-way merge if
 	the patch records the identity of blobs it is supposed to apply to and
 	we have those blobs available locally (equivalent to giving the `--3way`
 	option from the command line). Defaults to `false`.
diff --git a/Documentation/config/blame.adoc b/Documentation/config/blame.adoc
index 4d047c1790..2fc99d7da7 100644
--- a/Documentation/config/blame.adoc
+++ b/Documentation/config/blame.adoc
@@ -1,6 +1,6 @@
 blame.blankBoundary::
 	Show blank commit object name for boundary commits in
-	linkgit:git-blame[1]. This option defaults to false.
+	linkgit:git-blame[1]. This option defaults to `false`.
 
 blame.coloring::
 	This determines the coloring scheme to be applied to blame
@@ -14,11 +14,11 @@ blame.date::
 
 blame.showEmail::
 	Show the author email instead of author name in linkgit:git-blame[1].
-	This option defaults to false.
+	This option defaults to `false`.
 
 blame.showRoot::
 	Do not treat root commits as boundaries in linkgit:git-blame[1].
-	This option defaults to false.
+	This option defaults to `false`.
 
 blame.ignoreRevsFile::
 	Ignore revisions listed in the file, one unabbreviated object name per
diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..e05563efe2 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -20,10 +20,10 @@
 	that tracks another branch, this variable tells Git to set
 	up pull to rebase instead of merge (see `branch.<name>.rebase`).
 	The valid settings are:
-`never`;; rebase is never automatically set to true.
-`local`;; rebase is set to true for tracked branches of other local branches.
-`remote`;; rebase is set to true for tracked branches of remote-tracking branches.
-`always`;; rebase will be set to true for all tracking branches.
+`never`;; rebase is never automatically set to `true`.
+`local`;; rebase is set to `true` for tracked branches of other local branches.
+`remote`;; rebase is set to `true` for tracked branches of remote-tracking branches.
+`always`;; rebase will be set to `true` for all tracking branches.
 
 +
 See `branch.autoSetupMerge` for details on how to set up a branch to track another branch.
@@ -81,7 +81,7 @@ This option defaults to `never`.
 	supported.
 
 `branch.<name>.rebase`::
-	When true, rebase the branch _<name>_ on top of the fetched branch,
+	When `true`, rebase the branch _<name>_ on top of the fetched branch,
 	instead of merging the default branch from the default remote when
 	`git pull` is run. See `pull.rebase` for doing this in a non
 	branch-specific manner.
diff --git a/Documentation/config/clean.adoc b/Documentation/config/clean.adoc
index c0188ead4e..095945d508 100644
--- a/Documentation/config/clean.adoc
+++ b/Documentation/config/clean.adoc
@@ -1,3 +1,3 @@
 clean.requireForce::
 	A boolean to make git-clean refuse to delete files unless -f
-	is given. Defaults to true.
+	is given. Defaults to `true`.
diff --git a/Documentation/config/color.adoc b/Documentation/config/color.adoc
index 2f2275ac69..9a0cc992ca 100644
--- a/Documentation/config/color.adoc
+++ b/Documentation/config/color.adoc
@@ -132,7 +132,7 @@ color.interactive.<slot>::
 
 color.pager::
 	A boolean to specify whether `auto` color modes should colorize
-	output going to the pager. Defaults to true; set this to false
+	output going to the pager. Defaults to `true`; set this to `false`
 	if your pager does not understand ANSI color codes.
 
 color.push::
diff --git a/Documentation/config/commitgraph.adoc b/Documentation/config/commitgraph.adoc
index 70a56c53d2..1c33e08141 100644
--- a/Documentation/config/commitgraph.adoc
+++ b/Documentation/config/commitgraph.adoc
@@ -9,9 +9,9 @@ commitGraph.maxNewFilters::
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
 
 commitGraph.changedPaths::
-	If true, then `git commit-graph write` will compute and write
+	If `true`, then `git commit-graph write` will compute and write
 	changed-path Bloom filters by default, equivalent to passing
-	`--changed-paths`. If false or unset, changed-paths Bloom filters will
+	`--changed-paths`. If `false` or unset, changed-paths Bloom filters will
 	be written during `git commit-graph write` only if the filters already
 	exist in the current commit-graph file. This matches the default
 	behavior of `git commit-graph write` without any `--[no-]changed-paths`
@@ -20,8 +20,8 @@ commitGraph.changedPaths::
 	always takes precedence over this configuration. Defaults to unset.
 
 commitGraph.readChangedPaths::
-	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
-	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
+	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if `true`, and
+	commitGraph.changedPathsVersion=0 if `false`. (If commitGraph.changedPathVersion
 	is also set, commitGraph.changedPathsVersion takes precedence.)
 
 commitGraph.changedPathsVersion::
diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index a0ebf03e2e..a04b9d39f8 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -18,10 +18,10 @@ Git for Windows or Eclipse).
 In such a case it may be necessary to set this variable to 'false'.
 See linkgit:git-update-index[1].
 +
-The default is true (when core.filemode is not specified in the config file).
+The default is `true` (when core.filemode is not specified in the config file).
 
 core.hideDotFiles::
-	(Windows-only) If true, mark newly-created directories and files whose
+	(Windows-only) If `true`, mark newly-created directories and files whose
 	name starts with a dot as hidden.  If 'dotGitOnly', only the `.git/`
 	directory is hidden, but no other files starting with a dot.  The
 	default mode is 'dotGitOnly'.
@@ -34,8 +34,8 @@ core.ignoreCase::
 	it is really the same file, and continue to remember it as
 	"Makefile".
 +
-The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
-will probe and set core.ignoreCase true if appropriate when the repository
+The default is `false`, except linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set core.ignoreCase `true` if appropriate when the repository
 is created.
 +
 Git relies on the proper configuration of this variable for your operating
@@ -43,26 +43,26 @@ and file system. Modifying this value may result in unexpected behavior.
 
 core.precomposeUnicode::
 	This option is only used by Mac OS implementation of Git.
-	When core.precomposeUnicode=true, Git reverts the unicode decomposition
+	When core.precomposeUnicode=`true`, Git reverts the unicode decomposition
 	of filenames done by Mac OS. This is useful when sharing a repository
 	between Mac OS and Linux or Windows.
 	(Git for Windows 1.7.10 or higher is needed, or Git under cygwin 1.7).
-	When false, file names are handled fully transparent by Git,
+	When `false`, file names are handled fully transparent by Git,
 	which is backward compatible with older versions of Git.
 
 core.protectHFS::
-	If set to true, do not allow checkout of paths that would
+	If set to `true`, do not allow checkout of paths that would
 	be considered equivalent to `.git` on an HFS+ filesystem.
 	Defaults to `true` on Mac OS, and `false` elsewhere.
 
 core.protectNTFS::
-	If set to true, do not allow checkout of paths that would
+	If set to `true`, do not allow checkout of paths that would
 	cause problems with the NTFS filesystem, e.g. conflict with
 	8.3 "short" names.
 	Defaults to `true` on Windows, and `false` elsewhere.
 
 core.fsmonitor::
-	If set to true, enable the built-in file system monitor
+	If set to `true`, enable the built-in file system monitor
 	daemon for this working directory (linkgit:git-fsmonitor{litdd}daemon[1]).
 +
 Like hook-based file system monitors, the built-in file system monitor
@@ -112,15 +112,15 @@ something that can be used to determine what files have changed
 without race conditions.
 
 core.trustctime::
-	If false, the ctime differences between the index and the
+	If `false`, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
 	is regularly modified by something outside Git (file system
 	crawlers and some backup systems).
-	See linkgit:git-update-index[1]. True by default.
+	See linkgit:git-update-index[1]. `True` by default.
 
 core.splitIndex::
-	If true, the split-index feature of the index will be used.
-	See linkgit:git-update-index[1]. False by default.
+	If `true`, the split-index feature of the index will be used.
+	See linkgit:git-update-index[1]. `False` by default.
 
 core.untrackedCache::
 	Determines what to do about the untracked cache feature of the
@@ -156,13 +156,13 @@ core.quotePath::
 	backslashes in the same way C escapes control characters (e.g.
 	`\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
 	values larger than 0x80 (e.g. octal `\302\265` for "micro" in
-	UTF-8).  If this variable is set to false, bytes higher than
+	UTF-8).  If this variable is set to `false`, bytes higher than
 	0x80 are not considered "unusual" any more. Double-quotes,
 	backslash and control characters are always escaped regardless
 	of the setting of this variable.  A simple space character is
 	not considered "unusual".  Many commands can output pathnames
 	completely verbatim using the `-z` option. The default value
-	is true.
+	is `true`.
 
 core.eol::
 	Sets the line ending type to use in the working directory for
@@ -176,7 +176,7 @@ core.eol::
 	is set to `true` or `input`.
 
 core.safecrlf::
-	If true, makes Git check if converting `CRLF` is reversible when
+	If `true`, makes Git check if converting `CRLF` is reversible when
 	end-of-line conversion is active.  Git will verify if a command
 	modifies a file in the work tree either directly or indirectly.
 	For example, committing a file followed by checking out the
@@ -223,7 +223,7 @@ mechanism.
 core.autocrlf::
 	Setting this variable to "true" is the same as setting
 	the `text` attribute to "auto" on all files and core.eol to "crlf".
-	Set to true if you want to have `CRLF` line endings in your
+	Set to `true` if you want to have `CRLF` line endings in your
 	working directory and the repository has LF line endings.
 	This variable can be set to 'input',
 	in which case no output conversion is performed.
@@ -235,14 +235,14 @@ core.checkRoundtripEncoding::
 	The default value is `SHIFT-JIS`.
 
 core.symlinks::
-	If false, symbolic links are checked out as small plain files that
+	If `false`, symbolic links are checked out as small plain files that
 	contain the link text. linkgit:git-update-index[1] and
 	linkgit:git-add[1] will not change the recorded type to regular
 	file. Useful on filesystems like FAT that do not support
 	symbolic links.
 +
-The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
-will probe and set core.symlinks false if appropriate when the repository
+The default is `true`, except linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set core.symlinks `false` if appropriate when the repository
 is created.
 
 core.gitProxy::
@@ -271,7 +271,7 @@ core.sshCommand::
 	when the environment variable is set.
 
 core.ignoreStat::
-	If true, Git will avoid using lstat() calls to detect if files have
+	If `true`, Git will avoid using lstat() calls to detect if files have
 	changed by setting the "assume-unchanged" bit for those tracked files
 	which it has updated identically in both the index and working tree.
 +
@@ -283,7 +283,7 @@ Git will not normally detect changes to those files.
 This is useful on systems where lstat() calls are very slow, such as
 CIFS/Microsoft Windows.
 +
-False by default.
+`False` by default.
 
 core.preferSymlinkRefs::
 	Instead of the default "symref" format for HEAD
@@ -313,7 +313,7 @@ core.alternateRefsPrefixes::
 	`core.alternateRefsPrefixes` has no effect.
 
 core.bare::
-	If true this repository is assumed to be 'bare' and has no
+	If `true` this repository is assumed to be 'bare' and has no
 	working directory associated with it.  If this is the case a
 	number of commands that require a working directory will be
 	disabled, such as linkgit:git-add[1] or linkgit:git-merge[1].
@@ -321,8 +321,8 @@ core.bare::
 This setting is automatically guessed by linkgit:git-clone[1] or
 linkgit:git-init[1] when the repository was created.  By default a
 repository that ends in "/.git" is assumed to be not bare (bare =
-false), while all other repositories are assumed to be bare (bare
-= true).
+`false`), while all other repositories are assumed to be bare (bare
+= `true`).
 
 core.worktree::
 	Set the path to the root of the working tree.
@@ -349,7 +349,7 @@ read-only snapshot of the same index to a location different from the
 repository's usual working tree).
 
 core.lockfilePid::
-	If true, Git will create a PID file alongside lock files. When a
+	If `true`, Git will create a PID file alongside lock files. When a
 	lock acquisition fails and a PID file exists, Git can provide
 	additional diagnostic information about the process holding the
 	lock, including whether it is still running. Defaults to `false`.
@@ -374,8 +374,8 @@ core.logAllRefUpdates::
 This information can be used to determine what commit
 was the tip of a branch "2 days ago".
 +
-This value is true by default in a repository that has
-a working directory associated with it, and false by
+This value is `true` by default in a repository that has
+a working directory associated with it, and `false` by
 default in a bare repository.
 
 core.repositoryFormatVersion::
@@ -395,11 +395,11 @@ core.sharedRepository::
 	the repo read/write-able for the owner and group, but inaccessible to
 	others (equivalent to 'group' unless umask is e.g. '0022'). '0640' is a
 	repository that is group-readable but not group-writable.
-	See linkgit:git-init[1]. False by default.
+	See linkgit:git-init[1]. `False` by default.
 
 core.warnAmbiguousRefs::
-	If true, Git will warn you if the ref name you passed it is ambiguous
-	and might match multiple refs in the repository. True by default.
+	If `true`, Git will warn you if the ref name you passed it is ambiguous
+	and might match multiple refs in the repository. `True` by default.
 
 core.compression::
 	An integer -1..9, indicating a default compression level.
@@ -708,7 +708,7 @@ core.fsyncObjectFiles::
 	This setting is deprecated. Use core.fsync instead.
 +
 This setting affects data added to the Git repository in loose-object
-form. When set to true, Git will issue an fsync or similar system call
+form. When set to `true`, Git will issue an fsync or similar system call
 to flush caches so that loose-objects remain consistent in the face
 of a unclean system shutdown.
 
@@ -719,7 +719,7 @@ This can speed up operations like 'git diff' and 'git status' especially
 on filesystems like NFS that have weak caching semantics and thus
 relatively high IO latencies.  When enabled, Git will do the
 index comparison to the filesystem data in parallel, allowing
-overlapping IO's.  Defaults to true.
+overlapping IO's.  Defaults to `true`.
 
 core.unsetenvvars::
 	Windows-only: comma-separated list of environment variables'
@@ -746,8 +746,8 @@ This setting defaults to "refs/notes/commits", and it can be overridden by
 the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
 core.commitGraph::
-	If true, then git will read the commit-graph file (if it exists)
-	to parse the graph structure of commits. Defaults to true. See
+	If `true`, then git will read the commit-graph file (if it exists)
+	to parse the graph structure of commits. Defaults to `true`. See
 	linkgit:git-commit-graph[1] for more information.
 
 core.useReplaceRefs::
@@ -758,7 +758,7 @@ core.useReplaceRefs::
 core.multiPackIndex::
 	Use the multi-pack-index file to track multiple packfiles using a
 	single index. See linkgit:git-multi-pack-index[1] for more
-	information. Defaults to true.
+	information. Defaults to `true`.
 
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See linkgit:git-sparse-checkout[1]
diff --git a/Documentation/config/credential.adoc b/Documentation/config/credential.adoc
index 80a7c77772..0e88c4c7f2 100644
--- a/Documentation/config/credential.adoc
+++ b/Documentation/config/credential.adoc
@@ -19,7 +19,7 @@ credential.interactive::
 
 credential.useHttpPath::
 	When acquiring credentials, consider the "path" component of an http
-	or https URL to be important. Defaults to false. See
+	or https URL to be important. Defaults to `false`. See
 	linkgit:gitcredentials[7] for more information.
 
 credential.sanitizePrompt::
diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index cd40db0cad..2b90ed52f2 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -3,15 +3,15 @@
 	in `git pull`) will recursively fetch into populated submodules.
 	This option can be set either to a boolean value or to `on-demand`.
 	Setting it to a boolean changes the behavior of fetch and pull to
-	recurse unconditionally into submodules when set to true or to not
-	recurse at all when set to false. When set to `on-demand`, fetch and
+	recurse unconditionally into submodules when set to `true` or to not
+	recurse at all when set to `false`. When set to `on-demand`, fetch and
 	pull will only recurse into a populated submodule when its
 	superproject retrieves a commit that updates the submodule's
 	reference.
 	Defaults to `on-demand`, or to the value of `submodule.recurse` if set.
 
 `fetch.fsckObjects`::
-	If it is set to true, git-fetch-pack will check all fetched
+	If it is set to `true`, git-fetch-pack will check all fetched
 	objects. See `transfer.fsckObjects` for what's
 	checked. Defaults to `false`. If not set, the value of
 	`transfer.fsckObjects` is used instead.
@@ -38,12 +38,12 @@
 	`transfer.unpackLimit` is used instead.
 
 `fetch.prune`::
-	If true, fetch will automatically behave as if the `--prune`
+	If `true`, fetch will automatically behave as if the `--prune`
 	option was given on the command line.  See also `remote.<name>.prune`
 	and the PRUNING section of linkgit:git-fetch[1].
 
 `fetch.pruneTags`::
-	If true, fetch will automatically behave as if the
+	If `true`, fetch will automatically behave as if the
 	`refs/tags/*:refs/tags/*` refspec was provided when pruning,
 	if not set already. This allows for setting both this option
 	and `fetch.prune` to maintain a 1=1 mapping to upstream
@@ -51,7 +51,7 @@
 	section of linkgit:git-fetch[1].
 
 `fetch.all`::
-	If true, fetch will attempt to update all available remotes.
+	If `true`, fetch will attempt to update all available remotes.
 	This behavior can be overridden by passing `--no-all` or by
 	explicitly specifying one or more remote(s) to fetch from.
 	Defaults to `false`.
@@ -95,7 +95,7 @@ For submodules, this setting can be overridden using the `submodule.fetchJobs`
 config setting.
 
 `fetch.writeCommitGraph`::
-	Set to true to write a commit-graph after every `git fetch` command
+	Set to `true` to write a commit-graph after every `git fetch` command
 	that downloads a pack-file from a remote. Using the `--split` option,
 	most executions will create a very small commit-graph file on top of
 	the existing commit-graph file(s). Occasionally, these files will
diff --git a/Documentation/config/fmt-merge-msg.adoc b/Documentation/config/fmt-merge-msg.adoc
index 696ba0531a..4bcf5b2688 100644
--- a/Documentation/config/fmt-merge-msg.adoc
+++ b/Documentation/config/fmt-merge-msg.adoc
@@ -1,13 +1,13 @@
 `merge.branchdesc`::
 	In addition to branch names, populate the log message with
 	the branch description text associated with them.  Defaults
-	to false.
+	to `false`.
 
 `merge.log`::
 	In addition to branch names, populate the log message with at
 	most the specified number of one-line descriptions from the
-	actual commits that are being merged.  Defaults to false, and
-	true is a synonym for 20.
+	actual commits that are being merged.  Defaults to `false`, and
+	`true` is a synonym for 20.
 
 `merge.suppressDest`::
 	By adding a glob that matches the names of integration
diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ab0710e86a..a9736b196a 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -8,23 +8,23 @@ format.attach::
 
 format.from::
 	Provides the default value for the `--from` option to format-patch.
-	Accepts a boolean value, or a name and email address.  If false,
+	Accepts a boolean value, or a name and email address.  If `false`,
 	format-patch defaults to `--no-from`, using commit authors directly in
-	the "From:" field of patch mails.  If true, format-patch defaults to
+	the "From:" field of patch mails.  If `true`, format-patch defaults to
 	`--from`, using your committer identity in the "From:" field of patch
 	mails and including a "From:" field in the body of the patch mail if
 	different.  If set to a non-boolean value, format-patch uses that
-	value instead of your committer identity.  Defaults to false.
+	value instead of your committer identity.  Defaults to `false`.
 
 format.forceInBodyFrom::
 	Provides the default value for the `--[no-]force-in-body-from`
-	option to format-patch.  Defaults to false.
+	option to format-patch.  Defaults to `false`.
 
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
 	is more than one patch.  It can be enabled or disabled for all
-	messages by setting it to "true" or "false".  See --numbered
+	messages by setting it to `true` or `false`.  See --numbered
 	option in linkgit:git-format-patch[1].
 
 format.headers::
@@ -65,7 +65,7 @@ format.suffix::
 format.encodeEmailHeaders::
 	Encode email headers that have non-ASCII characters with
 	"Q-encoding" (described in RFC 2047) for email transmission.
-	Defaults to true.
+	Defaults to `true`.
 
 format.pretty::
 ifndef::with-breaking-changes[]
@@ -85,7 +85,7 @@ format.thread::
 	where the head is chosen from the cover letter, the
 	`--in-reply-to`, and the first patch mail, in this order.
 	`deep` threading makes every mail a reply to the previous one.
-	A true boolean value is the same as `shallow`, and a false
+	A `true` boolean value is the same as `shallow`, and a `false`
 	value disables threading.
 
 format.signOff::
@@ -99,7 +99,7 @@ format.coverLetter::
 	A boolean that controls whether to generate a cover-letter when
 	format-patch is invoked, but in addition can be set to "auto", to
 	generate a cover-letter only when there's more than one patch.
-	Default is false.
+	Default is `false`.
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
@@ -119,11 +119,11 @@ format.useAutoBase::
 format.notes::
 	Provides the default value for the `--notes` option to
 	format-patch. Accepts a boolean value, or a ref which specifies
-	where to get notes. If false, format-patch defaults to
-	`--no-notes`. If true, format-patch defaults to `--notes`. If
+	where to get notes. If `false`, format-patch defaults to
+	`--no-notes`. If `true`, format-patch defaults to `--notes`. If
 	set to a non-boolean value, format-patch defaults to
 	`--notes=<ref>`, where `ref` is the non-boolean value. Defaults
-	to false.
+	to `false`.
 +
 If one wishes to use the ref `refs/notes/true`, please use that literal
 instead.
diff --git a/Documentation/config/gc.adoc b/Documentation/config/gc.adoc
index 21d56db279..b63202cfcc 100644
--- a/Documentation/config/gc.adoc
+++ b/Documentation/config/gc.adoc
@@ -40,7 +40,7 @@ use, it'll affect how the auto pack limit works.
 
 gc.autoDetach::
 	Make `git gc --auto` return immediately and run in the background
-	if the system supports it. Default is true. This config variable acts
+	if the system supports it. Default is `true`. This config variable acts
 	as a fallback in case `maintenance.autoDetach` is not set.
 
 gc.bigPackThreshold::
@@ -61,10 +61,10 @@ will also be excluded (this is the equivalent of running `git gc` with
 `--keep-largest-pack`).
 
 gc.writeCommitGraph::
-	If true, then gc will rewrite the commit-graph file when
+	If `true`, then gc will rewrite the commit-graph file when
 	linkgit:git-gc[1] is run. When using `git gc --auto`
 	the commit-graph will be updated if housekeeping is
-	required. Default is true. See linkgit:git-commit-graph[1]
+	required. Default is `true`. See linkgit:git-commit-graph[1]
 	for details.
 
 gc.logExpiry::
diff --git a/Documentation/config/gitcvs.adoc b/Documentation/config/gitcvs.adoc
index 31d7be3992..dc5c9b53a1 100644
--- a/Documentation/config/gitcvs.adoc
+++ b/Documentation/config/gitcvs.adoc
@@ -11,7 +11,7 @@ gitcvs.logFile::
 	various stuff. See linkgit:git-cvsserver[1].
 
 gitcvs.usecrlfattr::
-	If true, the server will look up the end-of-line conversion
+	If `true`, the server will look up the end-of-line conversion
 	attributes for files to determine the `-k` modes to use. If
 	the attributes force Git to treat a file as text,
 	the `-k` mode will be left blank so CVS clients will
@@ -23,7 +23,7 @@ gitcvs.usecrlfattr::
 
 gitcvs.allBinary::
 	This is used if `gitcvs.usecrlfattr` does not resolve
-	the correct '-kb' mode to use. If true, all
+	the correct '-kb' mode to use. If `true`, all
 	unresolved files are sent to the client in
 	mode '-kb'. This causes the client to treat them
 	as binary files, which suppresses any newline munging it
diff --git a/Documentation/config/grep.adoc b/Documentation/config/grep.adoc
index 10041f27b0..a446830a5c 100644
--- a/Documentation/config/grep.adoc
+++ b/Documentation/config/grep.adoc
@@ -1,8 +1,8 @@
 grep.lineNumber::
-	If set to true, enable `-n` option by default.
+	If set to `true`, enable `-n` option by default.
 
 grep.column::
-	If set to true, enable the `--column` option by default.
+	If set to `true`, enable the `--column` option by default.
 
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
@@ -12,7 +12,7 @@ grep.patternType::
 	between 'basic' and 'extended'.
 
 grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
+	If set to `true`, enable `--extended-regexp` option by default. This
 	option is ignored when the `grep.patternType` option is set to a value
 	other than 'default'.
 
@@ -21,8 +21,8 @@ grep.threads::
 	use as many threads as the number of logical cores available.
 
 grep.fullName::
-	If set to true, enable `--full-name` option by default.
+	If set to `true`, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
-	If set to true, fall back to `git grep --no-index` if `git grep`
-	is executed outside of a git repository.  Defaults to false.
+	If set to `true`, fall back to `git grep --no-index` if `git grep`
+	is executed outside of a git repository.  Defaults to `false`.
diff --git a/Documentation/config/gui.adoc b/Documentation/config/gui.adoc
index 1565c0af19..da7f9ef7fe 100644
--- a/Documentation/config/gui.adoc
+++ b/Documentation/config/gui.adoc
@@ -41,7 +41,7 @@ gui.spellingDictionary::
 	off.
 
 gui.fastCopyBlame::
-	If true, 'git gui blame' uses `-C` instead of `-C -C` for original
+	If `true`, 'git gui blame' uses `-C` instead of `-C -C` for original
 	location detection. It makes blame significantly faster on huge
 	repositories at the expense of less thorough copy detection.
 
diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 9da5c298cc..c45b386b2a 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -64,7 +64,7 @@ http.emptyAuth::
 http.proactiveAuth::
 	Attempt authentication without first making an unauthenticated attempt and
 	receiving a 401 response. This can be used to ensure that all requests are
-	authenticated. If `http.emptyAuth` is set to true, this value has no effect.
+	authenticated. If `http.emptyAuth` is set to `true`, this value has no effect.
 +
 If the credential helper used specifies an authentication scheme (i.e., via the
 `authtype` field), that value will be used; if a username and password is
@@ -182,7 +182,7 @@ empty string.
 
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
-	over HTTPS. Defaults to true. Can be overridden by the
+	over HTTPS. Defaults to `true`. Can be overridden by the
 	`GIT_SSL_NO_VERIFY` environment variable.
 
 http.sslCert::
@@ -260,7 +260,7 @@ http.sslTry::
 	when connecting via regular FTP protocol. This might be needed
 	if the FTP server requires it for security reasons or you wish
 	to connect securely whenever remote FTP server supports it.
-	Default is false since it might trigger certificate verification
+	Default is `false` since it might trigger certificate verification
 	errors on misconfigured servers.
 
 http.maxRequests::
@@ -319,7 +319,7 @@ http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
 	This can be helpful with some "poor" ftp servers which don't
 	support EPSV mode. Can be overridden by the `GIT_CURL_FTP_NO_EPSV`
-	environment variable. Default is false (curl will use EPSV).
+	environment variable. Default is `false` (curl will use EPSV).
 
 http.userAgent::
 	The HTTP USER_AGENT string presented to an HTTP server.  The default
diff --git a/Documentation/config/instaweb.adoc b/Documentation/config/instaweb.adoc
index 50cb2f7d62..5173a8a7db 100644
--- a/Documentation/config/instaweb.adoc
+++ b/Documentation/config/instaweb.adoc
@@ -7,7 +7,7 @@ instaweb.httpd::
 	repository. See linkgit:git-instaweb[1].
 
 instaweb.local::
-	If true the web server started by linkgit:git-instaweb[1] will
+	If `true` the web server started by linkgit:git-instaweb[1] will
 	be bound to the local IP (127.0.0.1).
 
 instaweb.modulePath::
diff --git a/Documentation/config/interactive.adoc b/Documentation/config/interactive.adoc
index 8b876cb4eb..4baf303df4 100644
--- a/Documentation/config/interactive.adoc
+++ b/Documentation/config/interactive.adoc
@@ -1,5 +1,5 @@
 interactive.singleKey::
-	When set to true, allow the user to provide one-letter input
+	When set to `true`, allow the user to provide one-letter input
 	with a single key (i.e., without hitting the Enter key) in
 	interactive commands.  This is currently used by the `--patch`
 	mode of linkgit:git-add[1], linkgit:git-checkout[1],
diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f20cc25cd7..4c914b0496 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -61,16 +61,16 @@ This is the same as the `--decorate` option of the `git log`.
 	history lines in `git log --graph`.
 
 `log.showRoot`::
-	If true, the initial commit will be shown as a big creation event.
+	If `true`, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
 `log.showSignature`::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	If `true`, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--show-signature`.
 
 `log.mailmap`::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	If `true`, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
 	assume `--no-use-mailmap`. True by default.
diff --git a/Documentation/config/mailinfo.adoc b/Documentation/config/mailinfo.adoc
index ec3a5d81f7..e719cb59f9 100644
--- a/Documentation/config/mailinfo.adoc
+++ b/Documentation/config/mailinfo.adoc
@@ -1,5 +1,5 @@
 mailinfo.scissors::
-	If true, makes linkgit:git-mailinfo[1] (and therefore
+	If `true`, makes linkgit:git-mailinfo[1] (and therefore
 	linkgit:git-am[1]) act by default as if the --scissors option
 	was provided on the command-line. When active, this feature
 	removes everything from the message body before a scissors
diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index d0c38f03fa..fdfb35fb6c 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -1,7 +1,7 @@
 maintenance.auto::
 	This boolean config option controls whether some commands run
 	`git maintenance run --auto` after doing their normal work. Defaults
-	to true.
+	to `true`.
 
 maintenance.autoDetach::
 	Many Git commands trigger automatic maintenance after they have
@@ -11,7 +11,7 @@ maintenance.autoDetach::
 	continue to run in the background.
 +
 If unset, the value of `gc.autoDetach` is used as a fallback. Defaults
-to true if both are unset, meaning that the maintenance process will
+to `true` if both are unset, meaning that the maintenance process will
 detach.
 
 maintenance.strategy::
@@ -52,7 +52,7 @@ maintenance.<task>.enabled::
 	with name `<task>` is run when no `--task` option is specified to
 	`git maintenance run`. These config values are ignored if a
 	`--task` option exists. By default, only `maintenance.gc.enabled`
-	is true.
+	is `true`.
 
 maintenance.<task>.schedule::
 	This config option controls whether or not the given `<task>` runs
diff --git a/Documentation/config/merge.adoc b/Documentation/config/merge.adoc
index 15a4c14c38..4eb90fbd88 100644
--- a/Documentation/config/merge.adoc
+++ b/Documentation/config/merge.adoc
@@ -21,7 +21,7 @@
 	branches at the remote named by `branch.<current-branch>.remote`
 	are consulted, and then they are mapped via `remote.<remote>.fetch`
 	to their corresponding remote-tracking branches, and the tips of
-	these tracking branches are merged. Defaults to true.
+	these tracking branches are merged. Defaults to `true`.
 
 `merge.ff`::
 	By default, Git does not create an extra merge commit when merging
@@ -34,7 +34,7 @@
 	command line).
 
 `merge.verifySignatures`::
-	If true, this is equivalent to the `--verify-signatures` command
+	If `true`, this is equivalent to the `--verify-signatures` command
 	line option. See linkgit:git-merge[1] for details.
 
 include::fmt-merge-msg.adoc[]
diff --git a/Documentation/config/mergetool.adoc b/Documentation/config/mergetool.adoc
index 7064f5a462..088edaebc6 100644
--- a/Documentation/config/mergetool.adoc
+++ b/Documentation/config/mergetool.adoc
@@ -21,7 +21,7 @@
 `mergetool.<tool>.trustExitCode`::
 	For a custom merge command, specify whether the exit code of
 	the merge command can be used to determine whether the merge was
-	successful.  If this is not set to true then the merge target file
+	successful.  If this is not set to `true` then the merge target file
 	timestamp is checked, and the merge is assumed to have been successful
 	if the file has been updated; otherwise, the user is prompted to
 	indicate the success of the merge.
diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index 75402d5579..ae2226b3f7 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -28,7 +28,7 @@ all existing objects. You can force recompression by passing the -F option
 to linkgit:git-repack[1].
 
 pack.allowPackReuse::
-	When true or "single", and when reachability bitmaps are
+	When `true` or "single", and when reachability bitmaps are
 	enabled, pack-objects will try to send parts of the bitmapped
 	packfile verbatim. When "multi", and when a multi-pack
 	reachability bitmap is available, pack-objects will try to send
@@ -37,7 +37,7 @@ pack.allowPackReuse::
 If only a single pack bitmap is available, and `pack.allowPackReuse`
 is set to "multi", reuse parts of just the bitmapped packfile. This
 can reduce memory and CPU usage to serve fetches, but might result in
-sending a slightly larger pack. Defaults to true.
+sending a slightly larger pack. Defaults to `true`.
 
 pack.island::
 	An extended regular expression configuring a set of delta
@@ -123,13 +123,13 @@ The minimum size allowed is limited to 1 MiB. The default is unlimited.
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 pack.useBitmaps::
-	When true, git will use pack bitmaps (if available) when packing
+	When `true`, git will use pack bitmaps (if available) when packing
 	to stdout (e.g., during the server side of a fetch). Defaults to
-	true. You should not generally need to turn this off unless
+	`true`. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
 
 pack.useBitmapBoundaryTraversal::
-	When true, Git will use an experimental algorithm for computing
+	When `true`, Git will use an experimental algorithm for computing
 	reachability queries with bitmaps. Instead of building up
 	complete bitmaps for all of the negated tips and then OR-ing
 	them together, consider negated tips with existing bitmaps as
@@ -146,7 +146,7 @@ particularly when there is poor bitmap coverage of the negated side of
 the query.
 
 pack.useSparse::
-	When true, git will default to using the '--sparse' option in
+	When `true`, git will default to using the '--sparse' option in
 	'git pack-objects' when the '--revs' option is present. This
 	algorithm only walks trees that appear in paths that introduce new
 	objects. This can have significant performance benefits when
@@ -178,34 +178,34 @@ pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
 
 pack.writeBitmapHashCache::
-	When true, git will include a "hash cache" section in the bitmap
+	When `true`, git will include a "hash cache" section in the bitmap
 	index (if one is written). This cache can be used to feed git's
 	delta heuristics, potentially leading to better deltas between
 	bitmapped and non-bitmapped objects (e.g., when serving a fetch
 	between an older, bitmapped pack and objects that have been
 	pushed since the last gc). The downside is that it consumes 4
-	bytes per object of disk space. Defaults to true.
+	bytes per object of disk space. Defaults to `true`.
 +
 When writing a multi-pack reachability bitmap, no new namehashes are
 computed; instead, any namehashes stored in an existing bitmap are
 permuted into their appropriate location when writing a new bitmap.
 
 pack.writeBitmapLookupTable::
-	When true, Git will include a "lookup table" section in the
+	When `true`, Git will include a "lookup table" section in the
 	bitmap index (if one is written). This table is used to defer
 	loading individual bitmaps as late as possible. This can be
 	beneficial in repositories that have relatively large bitmap
-	indexes. Defaults to false.
+	indexes. Defaults to `false`.
 
 pack.readReverseIndex::
-	When true, git will read any .rev file(s) that may be available
-	(see: linkgit:gitformat-pack[5]). When false, the reverse index
+	When `true`, git will read any .rev file(s) that may be available
+	(see: linkgit:gitformat-pack[5]). When `false`, the reverse index
 	will be generated from scratch and stored in memory. Defaults to
-	true.
+	`true`.
 
 pack.writeReverseIndex::
-	When true, git will write a corresponding .rev file (see:
+	When `true`, git will write a corresponding .rev file (see:
 	linkgit:gitformat-pack[5])
 	for each new packfile that it writes in all places except for
 	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
-	Defaults to true.
+	Defaults to `true`.
diff --git a/Documentation/config/pull.adoc b/Documentation/config/pull.adoc
index 125c930f72..4a7ac40149 100644
--- a/Documentation/config/pull.adoc
+++ b/Documentation/config/pull.adoc
@@ -9,7 +9,7 @@ pull.ff::
 	command line). This setting overrides `merge.ff` when pulling.
 
 pull.rebase::
-	When true, rebase branches on top of the fetched branch, instead
+	When `true`, rebase branches on top of the fetched branch, instead
 	of merging the default branch from the default remote when "git
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
@@ -30,7 +30,7 @@ pull.octopus::
 	at once.
 
 pull.autoStash::
-	When set to true, automatically create a temporary stash entry
+	When set to `true`, automatically create a temporary stash entry
 	to record the local changes before the operation begins, and
 	restore them after the operation completes.  When your "git
 	pull" rebases (instead of merges), this may be convenient, since
diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index d9112b2260..e39a7d8c5b 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -72,7 +72,7 @@ new default).
 --
 
 `push.followTags`::
-	If set to true, enable `--follow-tags` option by default.  You
+	If set to `true`, enable `--follow-tags` option by default.  You
 	may override this configuration at time of push by specifying
 	`--no-follow-tags`.
 
diff --git a/Documentation/config/rebase.adoc b/Documentation/config/rebase.adoc
index c6187ab28b..307688f306 100644
--- a/Documentation/config/rebase.adoc
+++ b/Documentation/config/rebase.adoc
@@ -9,22 +9,22 @@ rebase.stat::
 	rebase. False by default.
 
 rebase.autoSquash::
-	If set to true, enable the `--autosquash` option of
+	If set to `true`, enable the `--autosquash` option of
 	linkgit:git-rebase[1] by default for interactive mode.
 	This can be overridden with the `--no-autosquash` option.
 
 rebase.autoStash::
-	When set to true, automatically create a temporary stash entry
+	When set to `true`, automatically create a temporary stash entry
 	before the operation begins, and apply it after the operation
 	ends.  This means that you can run rebase on a dirty worktree.
 	However, use with care: the final stash application after a
 	successful rebase might result in non-trivial conflicts.
 	This option can be overridden by the `--no-autostash` and
 	`--autostash` options of linkgit:git-rebase[1].
-	Defaults to false.
+	Defaults to `false`.
 
 rebase.updateRefs::
-	If set to true enable `--update-refs` option by default.
+	If set to `true` enable `--update-refs` option by default.
 
 rebase.missingCommitsCheck::
 	If set to "warn", git rebase -i will print a warning if some
@@ -43,7 +43,7 @@ rebase.instructionFormat::
 	automatically have the commit hash prepended to the format.
 
 rebase.abbreviateCommands::
-	If set to true, `git rebase` will use abbreviated command names in the
+	If set to `true`, `git rebase` will use abbreviated command names in the
 	todo list resulting in something like this:
 +
 -------------------------------------------
@@ -60,7 +60,7 @@ instead of:
 	...
 -------------------------------------------
 +
-Defaults to false.
+Defaults to `false`.
 
 rebase.rescheduleFailedExec::
 	Automatically reschedule `exec` commands that failed. This only makes
@@ -68,14 +68,14 @@ rebase.rescheduleFailedExec::
 	This is the same as specifying the `--reschedule-failed-exec` option.
 
 rebase.forkPoint::
-	If set to false set `--no-fork-point` option by default.
+	If set to `false` set `--no-fork-point` option by default.
 
 rebase.rebaseMerges::
 	Whether and how to set the `--rebase-merges` option by default. Can
 	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
-	true or to `no-rebase-cousins` is equivalent to
+	`true` or to `no-rebase-cousins` is equivalent to
 	`--rebase-merges=no-rebase-cousins`, setting to `rebase-cousins` is
-	equivalent to `--rebase-merges=rebase-cousins`, and setting to false is
+	equivalent to `--rebase-merges=rebase-cousins`, and setting to `false` is
 	equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
 	command line, with or without an argument, overrides any
 	`rebase.rebaseMerges` configuration.
diff --git a/Documentation/config/receive.adoc b/Documentation/config/receive.adoc
index 36a1e6f2d2..75ffe2d980 100644
--- a/Documentation/config/receive.adoc
+++ b/Documentation/config/receive.adoc
@@ -1,16 +1,16 @@
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
 	capability to its clients. If you don't want to advertise this
-	capability, set this variable to false.
+	capability, set this variable to `false`.
 
 receive.advertisePushOptions::
-	When set to true, git-receive-pack will advertise the push options
+	When set to `true`, git-receive-pack will advertise the push options
 	capability to its clients. False by default.
 
 receive.autogc::
 	By default, git-receive-pack will run "git maintenance run --auto" after
 	receiving data from git-push and updating refs.  You can stop
-	it by setting this variable to false.
+	it by setting this variable to `false`.
 
 receive.certNonceSeed::
 	By setting this variable to a string, `git receive-pack`
@@ -32,9 +32,9 @@ receive.certNonceSlop::
 	can check `GIT_PUSH_CERT_NONCE_STATUS` is `OK`.
 
 receive.fsckObjects::
-	If it is set to true, git-receive-pack will check all received
+	If it is set to `true`, git-receive-pack will check all received
 	objects. See `transfer.fsckObjects` for what's checked.
-	Defaults to false. If not set, the value of
+	Defaults to `false`. If not set, the value of
 	`transfer.fsckObjects` is used instead.
 
 receive.fsck.<msg-id>::
@@ -75,20 +75,20 @@ receive.maxInputSize::
 	is unlimited.
 
 receive.denyDeletes::
-	If set to true, git-receive-pack will deny a ref update that deletes
+	If set to `true`, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
 
 receive.denyDeleteCurrent::
-	If set to true, git-receive-pack will deny a ref update that
+	If set to `true`, git-receive-pack will deny a ref update that
 	deletes the currently checked out branch of a non-bare repository.
 
 receive.denyCurrentBranch::
-	If set to true or "refuse", git-receive-pack will deny a ref update
+	If set to `true` or "refuse", git-receive-pack will deny a ref update
 	to the currently checked out branch of a non-bare repository.
 	Such a push is potentially dangerous because it brings the HEAD
 	out of sync with the index and working tree. If set to "warn",
 	print a warning of such a push to stderr, but allow the push to
-	proceed. If set to false or "ignore", allow such pushes with no
+	proceed. If set to `false` or "ignore", allow such pushes with no
 	message. Defaults to "refuse".
 +
 Another option is "updateInstead" which will update the working
@@ -103,7 +103,7 @@ the index have any difference from the HEAD, but the `push-to-checkout`
 hook can be used to customize this.  See linkgit:githooks[5].
 
 receive.denyNonFastForwards::
-	If set to true, git-receive-pack will deny a ref update which is
+	If set to `true`, git-receive-pack will deny a ref update which is
 	not a fast-forward. Use this to prevent such an update via a push,
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
@@ -137,9 +137,9 @@ E.g.:
 	git config --system --add receive.procReceiveRefs !:refs/heads
 
 receive.updateServerInfo::
-	If set to true, git-receive-pack will run git-update-server-info
+	If set to `true`, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
 
 receive.shallowUpdate::
-	If set to true, .git/shallow can be updated when new refs
+	If set to `true`, .git/shallow can be updated when new refs
 	require new shallow roots. Otherwise those refs are rejected.
diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 91e46f66f5..2f440cce62 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -38,7 +38,7 @@ remote.<name>.push::
 	linkgit:git-push[1].
 
 remote.<name>.mirror::
-	If true, pushing to this remote will automatically behave
+	If `true`, pushing to this remote will automatically behave
 	as if the `--mirror` option was given on the command line.
 
 remote.<name>.skipDefaultUpdate::
@@ -47,7 +47,7 @@ remote.<name>.skipDefaultUpdate::
 	values, the value of the last occurrence will be used).
 
 remote.<name>.skipFetchAll::
-	If true, this remote will be skipped when updating
+	If `true`, this remote will be skipped when updating
 	using linkgit:git-fetch[1], the `update` subcommand of
 	linkgit:git-remote[1], and ignored by the prefetch task
 	of `git maintenance`.
@@ -73,13 +73,13 @@ remote.<name>.vcs::
 	the remote with the git-remote-<vcs> helper.
 
 remote.<name>.prune::
-	When set to true, fetching from this remote by default will also
+	When set to `true`, fetching from this remote by default will also
 	remove any remote-tracking references that no longer exist on the
 	remote (as if the `--prune` option was given on the command line).
 	Overrides `fetch.prune` settings, if any.
 
 remote.<name>.pruneTags::
-	When set to true, fetching from this remote by default will also
+	When set to `true`, fetching from this remote by default will also
 	remove any local tags that no longer exist on the remote if pruning
 	is activated in general via `remote.<name>.prune`, `fetch.prune` or
 	`--prune`. Overrides `fetch.pruneTags` settings, if any.
@@ -88,7 +88,7 @@ See also `remote.<name>.prune` and the PRUNING section of
 linkgit:git-fetch[1].
 
 remote.<name>.promisor::
-	When set to true, this remote will be used to fetch promisor
+	When set to `true`, this remote will be used to fetch promisor
 	objects.
 
 remote.<name>.partialclonefilter::
diff --git a/Documentation/config/repack.adoc b/Documentation/config/repack.adoc
index e9e78dcb19..b421ceb9c7 100644
--- a/Documentation/config/repack.adoc
+++ b/Documentation/config/repack.adoc
@@ -7,29 +7,29 @@ repack.useDeltaBaseOffset::
 	native protocol are unaffected by this option.
 
 repack.packKeptObjects::
-	If set to true, makes `git repack` act as if
+	If set to `true`, makes `git repack` act as if
 	`--pack-kept-objects` was passed. See linkgit:git-repack[1] for
 	details. Defaults to `false` normally, but `true` if a bitmap
 	index is being written (either via `--write-bitmap-index` or
 	`repack.writeBitmaps`).
 
 repack.useDeltaIslands::
-	If set to true, makes `git repack` act as if `--delta-islands`
+	If set to `true`, makes `git repack` act as if `--delta-islands`
 	was passed. Defaults to `false`.
 
 repack.writeBitmaps::
-	When true, git will write a bitmap index when packing all
+	When `true`, git will write a bitmap index when packing all
 	objects to disk (e.g., when `git repack -a` is run).  This
 	index can speed up the "counting objects" phase of subsequent
 	packs created for clones and fetches, at the cost of some disk
 	space and extra time spent on the initial repack.  This has
 	no effect if multiple packfiles are created.
-	Defaults to true on bare repos, false otherwise.
+	Defaults to `true` on bare repos, `false` otherwise.
 
 repack.updateServerInfo::
-	If set to false, linkgit:git-repack[1] will not run
-	linkgit:git-update-server-info[1]. Defaults to true. Can be overridden
-	when true by the `-n` option of linkgit:git-repack[1].
+	If set to `false`, linkgit:git-repack[1] will not run
+	linkgit:git-update-server-info[1]. Defaults to `true`. Can be overridden
+	when `true` by the `-n` option of linkgit:git-repack[1].
 
 repack.cruftWindow::
 repack.cruftWindowMemory::
@@ -41,8 +41,8 @@ repack.cruftThreads::
 	variables for defaults and meaning.
 
 repack.midxMustContainCruft::
-	When set to true, linkgit:git-repack[1] will unconditionally include
+	When set to `true`, linkgit:git-repack[1] will unconditionally include
 	cruft pack(s), if any, in the multi-pack index when invoked with
-	`--write-midx`. When false, cruft packs are only included in the MIDX
+	`--write-midx`. When `false`, cruft packs are only included in the MIDX
 	when necessary (e.g., because they might be required to form a
-	reachability closure with MIDX bitmaps). Defaults to true.
+	reachability closure with MIDX bitmaps). Defaults to `true`.
diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 3a78b5ebb1..20eb3ba870 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -1,7 +1,7 @@
 rerere.autoUpdate::
-	When set to true, `git-rerere` updates the index with the
+	When set to `true`, `git-rerere` updates the index with the
 	resulting contents after it cleanly resolves conflicts using
-	previously recorded resolutions.  Defaults to false.
+	previously recorded resolutions.  Defaults to `false`.
 
 rerere.enabled::
 	Activate recording of resolved conflicts, so that identical
diff --git a/Documentation/config/revert.adoc b/Documentation/config/revert.adoc
index 802d6faca2..da2b66dc58 100644
--- a/Documentation/config/revert.adoc
+++ b/Documentation/config/revert.adoc
@@ -1,3 +1,3 @@
 revert.reference::
-	Setting this variable to true makes `git revert` behave
+	Setting this variable to `true` makes `git revert` behave
 	as if the `--reference` option is given.
diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
index a1197ffd7d..c4c998d575 100644
--- a/Documentation/config/stash.adoc
+++ b/Documentation/config/stash.adoc
@@ -7,8 +7,8 @@ ifdef::git-stash[]
 endif::git-stash[]
 
 `stash.index`::
-	If this is set to true, `git stash apply` and `git stash pop` will
-	behave as if `--index` was supplied. Defaults to false.
+	If this is set to `true`, `git stash apply` and `git stash pop` will
+	behave as if `--index` was supplied. Defaults to `false`.
 ifndef::git-stash[]
 See the descriptions in linkgit:git-stash[1].
 +
@@ -18,15 +18,15 @@ linkgit:git-pull[1].
 endif::git-stash[]
 
 `stash.showIncludeUntracked`::
-	If this is set to true, the `git stash show` command will show
-	the untracked files of a stash entry. Defaults to false. {see-show}
+	If this is set to `true`, the `git stash show` command will show
+	the untracked files of a stash entry. Defaults to `false`. {see-show}
 
 `stash.showPatch`::
-	If this is set to true, the `git stash show` command without an
-	option will show the stash entry in patch form.  Defaults to false.
+	If this is set to `true`, the `git stash show` command without an
+	option will show the stash entry in patch form.  Defaults to `false`.
 	{see-show}
 
 `stash.showStat`::
-	If this is set to true, the `git stash show` command without an
-	option will show a diffstat of the stash entry.  Defaults to true.
+	If this is set to `true`, the `git stash show` command without an
+	option will show a diffstat of the stash entry.  Defaults to `true`.
 	{see-show}
diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
index 8caf90f51c..fe0d44e617 100644
--- a/Documentation/config/status.adoc
+++ b/Documentation/config/status.adoc
@@ -5,24 +5,24 @@ status.relativePaths::
 	prior to v1.5.4).
 
 status.short::
-	Set to true to enable --short by default in linkgit:git-status[1].
+	Set to `true` to enable --short by default in linkgit:git-status[1].
 	The option --no-short takes precedence over this variable.
 
 status.branch::
-	Set to true to enable --branch by default in linkgit:git-status[1].
+	Set to `true` to enable --branch by default in linkgit:git-status[1].
 	The option --no-branch takes precedence over this variable.
 
 status.aheadBehind::
-	Set to true to enable `--ahead-behind` and false to enable
+	Set to `true` to enable `--ahead-behind` and `false` to enable
 	`--no-ahead-behind` by default in linkgit:git-status[1] for
-	non-porcelain status formats.  Defaults to true.
+	non-porcelain status formats.  Defaults to `true`.
 
 status.displayCommentPrefix::
-	If set to true, linkgit:git-status[1] will insert a comment
+	If set to `true`, linkgit:git-status[1] will insert a comment
 	prefix before each output line (starting with
 	`core.commentChar`, i.e. `#` by default). This was the
 	behavior of linkgit:git-status[1] in Git 1.8.4 and previous.
-	Defaults to false.
+	Defaults to `false`.
 
 status.renameLimit::
 	The number of files to consider when performing rename detection
@@ -37,9 +37,9 @@ status.renames::
 	Defaults to the value of diff.renames.
 
 status.showStash::
-	If set to true, linkgit:git-status[1] will display the number of
+	If set to `true`, linkgit:git-status[1] will display the number of
 	entries currently stashed away.
-	Defaults to false.
+	Defaults to `false`.
 
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
@@ -63,8 +63,8 @@ This variable can be overridden with the -u|--untracked-files option
 of linkgit:git-status[1] and linkgit:git-commit[1].
 
 status.submoduleSummary::
-	Defaults to false.
-	If this is set to a non-zero number or true (identical to -1 or an
+	Defaults to `false`.
+	If this is set to a non-zero number or `true` (identical to -1 or an
 	unlimited number), the submodule summary will be enabled and a
 	summary of commits for modified submodules will be shown (see
 	--summary-limit option of linkgit:git-submodule[1]). Please note
diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 74f1659a91..a9ed5f923e 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -66,9 +66,9 @@ submodule.active::
 
 submodule.recurse::
 	A boolean indicating if commands should enable the `--recurse-submodules`
-	option by default. Defaults to false.
+	option by default. Defaults to `false`.
 +
-When set to true, it can be deactivated via the
+When set to `true`, it can be deactivated via the
 `--no-recurse-submodules` option. Note that some Git commands
 lacking this option may call some of the above commands affected by
 `submodule.recurse`; for instance `git remote update` will call
@@ -92,7 +92,7 @@ submodule.propagateBranches::
 	Enabling this will allow certain commands to accept
 	`--recurse-submodules` and certain commands that already accept
 	`--recurse-submodules` will now consider branches.
-	Defaults to false.
+	Defaults to `false`.
 
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
diff --git a/Documentation/config/trace2.adoc b/Documentation/config/trace2.adoc
index 05639ce33f..897244ac48 100644
--- a/Documentation/config/trace2.adoc
+++ b/Documentation/config/trace2.adoc
@@ -20,19 +20,19 @@ trace2.eventTarget::
 include::../trace2-target-values.adoc[]
 
 trace2.normalBrief::
-	Boolean.  When true `time`, `filename`, and `line` fields are
+	Boolean.  When `true` `time`, `filename`, and `line` fields are
 	omitted from normal output.  May be overridden by the
-	`GIT_TRACE2_BRIEF` environment variable.  Defaults to false.
+	`GIT_TRACE2_BRIEF` environment variable.  Defaults to `false`.
 
 trace2.perfBrief::
-	Boolean.  When true `time`, `filename`, and `line` fields are
+	Boolean.  When `true` `time`, `filename`, and `line` fields are
 	omitted from PERF output.  May be overridden by the
-	`GIT_TRACE2_PERF_BRIEF` environment variable.  Defaults to false.
+	`GIT_TRACE2_PERF_BRIEF` environment variable.  Defaults to `false`.
 
 trace2.eventBrief::
-	Boolean.  When true `time`, `filename`, and `line` fields are
+	Boolean.  When `true` `time`, `filename`, and `line` fields are
 	omitted from event output.  May be overridden by the
-	`GIT_TRACE2_EVENT_BRIEF` environment variable.  Defaults to false.
+	`GIT_TRACE2_EVENT_BRIEF` environment variable.  Defaults to `false`.
 
 trace2.eventNesting::
 	Integer.  Specifies desired depth of nested regions in the
@@ -58,7 +58,7 @@ trace2.envVars::
 	default.
 
 trace2.destinationDebug::
-	Boolean.  When true Git will print error messages when a
+	Boolean.  When `true` Git will print error messages when a
 	trace target destination cannot be opened for writing.
 	By default, these errors are suppressed and tracing is
 	silently disabled.  May be overridden by the
diff --git a/Documentation/config/transfer.adoc b/Documentation/config/transfer.adoc
index f1ce50f4a6..f3f5faf27e 100644
--- a/Documentation/config/transfer.adoc
+++ b/Documentation/config/transfer.adoc
@@ -39,7 +39,7 @@ data in git's configuration files. If you do want to use this, set
 transfer.fsckObjects::
 	When `fetch.fsckObjects` or `receive.fsckObjects` are
 	not set, the value of this variable is used instead.
-	Defaults to false.
+	Defaults to `false`.
 +
 When set, the fetch or receive will abort in the case of a malformed
 object or a link to a nonexistent object. In addition, various other
@@ -113,8 +113,8 @@ transfer.unpackLimit::
 	The default value is 100.
 
 transfer.advertiseSID::
-	Boolean. When true, client and server processes will advertise their
-	unique session IDs to their remote counterpart. Defaults to false.
+	Boolean. When `true`, client and server processes will advertise their
+	unique session IDs to their remote counterpart. Defaults to `false`.
 
 transfer.bundleURI::
 	When `true`, local `git clone` commands will request bundle
@@ -124,4 +124,4 @@ transfer.bundleURI::
 
 transfer.advertiseObjectInfo::
 	When `true`, the `object-info` capability is advertised by
-	servers. Defaults to false.
+	servers. Defaults to `false`.
diff --git a/Documentation/config/uploadarchive.adoc b/Documentation/config/uploadarchive.adoc
index e0698e8c1d..ade9fb2258 100644
--- a/Documentation/config/uploadarchive.adoc
+++ b/Documentation/config/uploadarchive.adoc
@@ -1,5 +1,5 @@
 uploadarchive.allowUnreachable::
-	If true, allow clients to use `git archive --remote` to request
+	If `true`, allow clients to use `git archive --remote` to request
 	any tree, whether reachable from the ref tips or not. See the
 	discussion in the "SECURITY" section of
 	linkgit:git-upload-archive[1] for more details. Defaults to
diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
index a248076ea5..5eec006f77 100644
--- a/Documentation/config/worktree.adoc
+++ b/Documentation/config/worktree.adoc
@@ -2,7 +2,7 @@
 	If no branch is specified and neither `-b` nor `-B` nor
 	`--detach` is used, then `git worktree add` defaults to
 	creating a new branch from HEAD.  If `worktree.guessRemote` is
-	set to true, `worktree add` tries to find a remote-tracking
+	set to `true`, `worktree add` tries to find a remote-tracking
 	branch whose name uniquely matches the new branch name.  If
 	such a branch exists, it is checked out and set as "upstream"
 	for the new branch.  If no such match can be found, it falls

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
