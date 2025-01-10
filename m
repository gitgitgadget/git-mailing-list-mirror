Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66520B7F7
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503767; cv=none; b=VIxBfatYYt28i+42m05d6Oa1GMkdyCvCVpoj0PpjlZbyDv63EJwQsju9gzZCGKeWNwJcr8FTQC26LBLeVwW43ONERJR5HXDIncE1RoYOlsVFEzi1G6x5H0SznKxUniZqYRYZbHLFCAVxIeyS83GipM1iigrqyAuuxCxZbcLEmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503767; c=relaxed/simple;
	bh=yOqUJSsjZ8RGuw9EHc/U1ilxoUdoRmTbbHVsEfws6u8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=e935uC6WTIUljGfCsGpmcUxWlYS7BDLH/Bit1cyl+ZPfjL9XCRHMppd/JnfN4omK6VzvsBmxtRuZ002pO4PwrnezWKk7wkyWXAR6coc4kxCCgNPFMKUmqJuzkEk86ADHeG2Zn5l6Jtsp3Pmi1fPWnzhDK+CcKO5fBRb/kJJBukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPBzNrkT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPBzNrkT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43621d27adeso13773435e9.2
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 02:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736503762; x=1737108562; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLY9CjpOmVmd8NXSi5+GZ8EMgkcmBRG9GSHcBbcOpLY=;
        b=GPBzNrkTGYv1RXWuWaNf/1q+ApMGQ1VEM0kfharvMUNbqoomfA5ZrAq4p+hk/OuR+r
         usol1SznRZbyib3a/DJuRl8j4IuomYflCpALIQ0Abd4XgQa8XhuOaOvD1bUIrPx75FE0
         iky8CKiFhEM8FSQoyuh9QKokkUmZaTXa2sx1nxooPDaBZI9siMIDYPUweitZUlfcbUOj
         Fn93ebJaGP6krqtSgD6Qp7vzrfUaVHFHAJoKFyKi0FhOm0Ai+bh4kersclqb6NtbM4fH
         n/0LI8Rbl1FgbWU1zy/qEmM3X6NURfrMllCCmCiM3pRPsppzqJEGdaY2DTDLx99z+7P7
         VC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736503762; x=1737108562;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLY9CjpOmVmd8NXSi5+GZ8EMgkcmBRG9GSHcBbcOpLY=;
        b=MOl8BA1acZcCIiUdl9Ynv0LevJaxXMcxhPNLzlj77h+hP/re/Fu0ZeV9lkKa6bmnsX
         xegeMDUL0mBGqfmeWsaIqpJcNqf5VM2O8VjxDYwQ55FEio2WnBu7WqgkOt8Yim8HNWkq
         Zxl9XX4kYMj9gRYCcWSGWDTKgCYVY32VYmkjz0jqRHNJguRGnKS9VMx7kM/bJMouPFJk
         ENyyWOMQxMf/UHOq/mIobtKKbqtT6L4CFpjp83aPL7oa1T862m2wA6dVa/l/bMMkR5+/
         +gLaSfhLBPEIGy9fu04wU0O0qqEC7obj/HKvj4g+YFXxvjJiCqNXkKT1j/KwbR6YPWA7
         +zIg==
X-Gm-Message-State: AOJu0Yw0YAptqJ48X2eiuIMkZ5XDkyYghhV1QOP2dXpigjde+hUDDCln
	BRSflZowKKGW+dxxU7tMjMtJB6Lp0WchV/ST8nmQRfmzjZkxVPaS2J7xTw==
X-Gm-Gg: ASbGnctfjxKpLGxcf2obdcTNJXPVzRM4fplDkaaqeKmbJCaAVs4K4F7nOE684cGuNjH
	N+CMkMO/C1CBq0OEgjQW10UWVjGfMdONDaR8c6tj7yLVAvDLhqj0oFKnzzCxImCNx8kPc63mSuK
	XJrxO8FAYzBSDxXkbxe4wTHge3RNJmsQH3uUY/Bc293D/G4aJtfLGVFQqYqgyokvZb2kHMIM8zn
	G6DQ46wtzs7iWBNSzIpwqlS6b4jniNA0fz6WSfxyN2sIlBiL6gD/Jq3cg==
X-Google-Smtp-Source: AGHT+IH0HrCnYjkiRilUKlrqsbRt1WOR0vZGK6oJcFU2B3qLI2F46JGKHdo9ZU99NkWuDJlTfVe4lg==
X-Received: by 2002:a05:6000:184e:b0:385:f560:7911 with SMTP id ffacd0b85a97d-38a872c93e3mr8989561f8f.10.1736503761768;
        Fri, 10 Jan 2025 02:09:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c7aesm4198188f8f.53.2025.01.10.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:09:21 -0800 (PST)
Message-Id: <pull.1847.v2.git.1736503760086.gitgitgadget@gmail.com>
In-Reply-To: <pull.1847.git.1735996601092.gitgitgadget@gmail.com>
References: <pull.1847.git.1735996601092.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 10:09:19 +0000
Subject: [PATCH v2] doc: convert git-restore to new style format
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

- Switch the synopsis to a 'synopsis' block which will
  automatically format placeholders in italics and keywords in
  monospace

- Use _<placeholder>_ instead of <placeholder> in the description

- Use backticks for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

While at it, also convert an option description to imperative mood.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: git-restore: migrate to new style format
    
    cc: Patrick Steinhardt ps@pks.im

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1847%2Fjnavila%2Fdoc-git-restore-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1847/jnavila/doc-git-restore-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1847

Range-diff vs v1:

 1:  424ddb959ff ! 1:  69c01f08852 doc: git-restore: migrate to new style format
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    doc: git-restore: migrate to new style format
     +    doc: convert git-restore to new style format
      
     -    The git-restore manpage was converted to the new documentation
     -    format:
     -
     -    - switching the synopsis to a 'synopsis' block which will
     +    - Switch the synopsis to a 'synopsis' block which will
            automatically format placeholders in italics and keywords in
            monospace
     -    - use _<placeholder>_ instead of <placeholder> in the description
     -    - use `backticks for keywords and more complex option
     -    descriptions`. The new rendering engine will apply synopsis rules to
     +
     +    - Use _<placeholder>_ instead of <placeholder> in the description
     +
     +    - Use backticks for keywords and more complex option
     +    descriptions. The new rendering engine will apply synopsis rules to
          these spans.
      
     +    While at it, also convert an option description to imperative mood.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/git-restore.txt ##
     @@ Documentation/git-restore.txt: OPTIONS
      -As a special case, you may use `"A...B"` as a shortcut for the
      -merge base of `A` and `B` if there is exactly one merge base. You can
      -leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
     -+As a special case, you may use `"<refA>...<refB>"` as a shortcut for the
     -+merge base of _<refA>_ and _<refB>_ if there is exactly one merge base. You can
     -+leave out at most one of _<refA>__ and _<refB>_, in which case it defaults to `HEAD`.
     ++As a special case, you may use `"<rev-A>...<rev-B>"` as a shortcut for the
     ++merge base of _<rev-A>_ and _<rev-B>_ if there is exactly one merge base. You can
     ++leave out at most one of _<rev-A>__ and _<rev-B>_, in which case it defaults to `HEAD`.
       
      --p::
      ---patch::
     @@ Documentation/git-restore.txt: in linkgit:git-checkout[1] for details.
      +`--overlay`::
      +`--no-overlay`::
      +	In overlay mode, never remove files when restoring. In no-overlay mode,
     -+	remove tracked files that do not appear in the `--source` tree, to make
     -+	them match _<tree>_ exactly. The default is no-overlay mode.
     ++	remove tracked files that do not appear in the _<tree>_ of
     ++	`--source=<tree>`, to make them match _<tree>_ exactly. The default
     ++	is no-overlay mode.
      +
      +`--pathspec-from-file=<file>`::
      +	Pathspec is passed in _<file>_ instead of commandline args. If


 Documentation/git-restore.txt | 110 +++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 975825b44aa..751f01b4418 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -7,10 +7,10 @@ git-restore - Restore working tree files
 
 SYNOPSIS
 --------
-[verse]
-'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] [--] <pathspec>...
-'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] --pathspec-from-file=<file> [--pathspec-file-nul]
-'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [--] [<pathspec>...]
+[synopsis]
+git restore [<options>] [--source=<tree>] [--staged] [--worktree] [--] <pathspec>...
+git restore [<options>] [--source=<tree>] [--staged] [--worktree] --pathspec-from-file=<file> [--pathspec-file-nul]
+git restore (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -32,8 +32,8 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 OPTIONS
 -------
--s <tree>::
---source=<tree>::
+`-s <tree>`::
+`--source=<tree>`::
 	Restore the working tree files with the content from the given
 	tree. It is common to specify the source tree by naming a
 	commit, branch or tag associated with it.
@@ -41,79 +41,79 @@ OPTIONS
 If not specified, the contents are restored from `HEAD` if `--staged` is
 given, otherwise from the index.
 +
-As a special case, you may use `"A...B"` as a shortcut for the
-merge base of `A` and `B` if there is exactly one merge base. You can
-leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
+As a special case, you may use `"<rev-A>...<rev-B>"` as a shortcut for the
+merge base of _<rev-A>_ and _<rev-B>_ if there is exactly one merge base. You can
+leave out at most one of _<rev-A>__ and _<rev-B>_, in which case it defaults to `HEAD`.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	Interactively select hunks in the difference between the
-	restore source and the restore location. See the ``Interactive
-	Mode'' section of linkgit:git-add[1] to learn how to operate
+	restore source and the restore location. See the "Interactive
+	Mode" section of linkgit:git-add[1] to learn how to operate
 	the `--patch` mode.
 +
 Note that `--patch` can accept no pathspec and will prompt to restore
 all modified paths.
 
--W::
---worktree::
--S::
---staged::
+`-W`::
+`--worktree`::
+`-S`::
+`--staged`::
 	Specify the restore location. If neither option is specified,
 	by default the working tree is restored. Specifying `--staged`
 	will only restore the index. Specifying both restores both.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Quiet, suppress feedback messages. Implies `--no-progress`.
 
---progress::
---no-progress::
+`--progress`::
+`--no-progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
 	attached to a terminal, regardless of `--quiet`.
 
---ours::
---theirs::
+`--ours`::
+`--theirs`::
 	When restoring files in the working tree from the index, use
-	stage #2 ('ours') or #3 ('theirs') for unmerged paths.
+	stage #2 (`ours`) or #3 (`theirs`) for unmerged paths.
 	This option cannot be used when checking out paths from a
 	tree-ish (i.e. with the `--source` option).
 +
-Note that during `git rebase` and `git pull --rebase`, 'ours' and
-'theirs' may appear swapped. See the explanation of the same options
+Note that during `git rebase` and `git pull --rebase`, `ours` and
+`theirs` may appear swapped. See the explanation of the same options
 in linkgit:git-checkout[1] for details.
 
--m::
---merge::
+`-m`::
+`--merge`::
 	When restoring files on the working tree from the index,
 	recreate the conflicted merge in the unmerged paths.
 	This option cannot be used when checking out paths from a
 	tree-ish (i.e. with the `--source` option).
 
---conflict=<style>::
+`--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values
-	are "merge" (default), "diff3", and "zdiff3".
+	are `merge` (default), `diff3`, and `zdiff3`.
 
---ignore-unmerged::
+`--ignore-unmerged`::
 	When restoring files on the working tree from the index, do
 	not abort the operation if there are unmerged entries and
 	neither `--ours`, `--theirs`, `--merge` or `--conflict` is
 	specified. Unmerged paths on the working tree are left alone.
 
---ignore-skip-worktree-bits::
+`--ignore-skip-worktree-bits`::
 	In sparse checkout mode, the default is to only update entries
-	matched by `<pathspec>` and sparse patterns in
-	$GIT_DIR/info/sparse-checkout. This option ignores the sparse
+	matched by _<pathspec>_ and sparse patterns in
+	`$GIT_DIR/info/sparse-checkout`. This option ignores the sparse
 	patterns and unconditionally restores any files in
-	`<pathspec>`.
+	_<pathspec>_.
 
---recurse-submodules::
---no-recurse-submodules::
-	If `<pathspec>` names an active submodule and the restore location
+`--recurse-submodules`::
+`--no-recurse-submodules`::
+	If _<pathspec>_ names an active submodule and the restore location
 	includes the working tree, the submodule will only be updated if
 	this option is given, in which case its working tree will be
 	restored to the commit recorded in the superproject, and any local
@@ -122,30 +122,30 @@ in linkgit:git-checkout[1] for details.
 	not be updated. Just like linkgit:git-checkout[1], this will detach
 	`HEAD` of the submodule.
 
---overlay::
---no-overlay::
-	In overlay mode, the command never removes files when
-	restoring. In no-overlay mode, tracked files that do not
-	appear in the `--source` tree are removed, to make them match
-	`<tree>` exactly. The default is no-overlay mode.
-
---pathspec-from-file=<file>::
-	Pathspec is passed in `<file>` instead of commandline args. If
-	`<file>` is exactly `-` then standard input is used. Pathspec
-	elements are separated by LF or CR/LF. Pathspec elements can be
+`--overlay`::
+`--no-overlay`::
+	In overlay mode, never remove files when restoring. In no-overlay mode,
+	remove tracked files that do not appear in the _<tree>_ of
+	`--source=<tree>`, to make them match _<tree>_ exactly. The default
+	is no-overlay mode.
+
+`--pathspec-from-file=<file>`::
+	Pathspec is passed in _<file>_ instead of commandline args. If
+	_<file>_ is exactly `-` then standard input is used. Pathspec
+	elements are separated by _LF_ or _CR_/_LF_. Pathspec elements can be
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
-	separated with NUL character and all other characters are taken
+	separated with _NUL_ character and all other characters are taken
 	literally (including newlines and quotes).
 
-\--::
+`--`::
 	Do not interpret any more arguments as options.
 
-<pathspec>...::
+`<pathspec>...`::
 	Limits the paths affected by the operation.
 +
 For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
@@ -154,7 +154,7 @@ EXAMPLES
 --------
 
 The following sequence switches to the `master` branch, reverts the
-`Makefile` to two revisions back, deletes hello.c by mistake, and gets
+`Makefile` to two revisions back, deletes `hello.c` by mistake, and gets
 it back from the index.
 
 ------------
@@ -165,7 +165,7 @@ $ git restore hello.c                     <2>
 ------------
 
 <1> take a file out of another commit
-<2> restore hello.c from the index
+<2> restore `hello.c` from the index
 
 If you want to restore _all_ C source files to match the version in
 the index, you can say

base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
-- 
gitgitgadget
