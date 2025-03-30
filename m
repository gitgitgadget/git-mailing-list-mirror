Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6191F949
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354971; cv=none; b=G9ZDnCofLy/gmSsvwTa4LzQGlqBnQTUIJl+k1DIbbogsvuqYFN0iBId0/7MwjuksqtL7laI66PW337lxjmETwaRvN5fDj0OZUTbTEDsfB4XApvy2CgD0nWPjq14/IvbNOXNUb8Ef0Gn3MgrSpytU1hgTJOCcYEbxJrQ6FqvOpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354971; c=relaxed/simple;
	bh=l9o8h1wCbqu2yFkNl+VTPaqyav/NmLt3ZVL02MS69MU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=R4NJjEvXJdcFxrfW+kuqXXJlYVIMSswFcT4ioEH+l6LwSej5mqdjO4r29sT7fCcjwkcfDn8ip6mXX7JCCAL23fk7RJFm7VB6ezVGuYgK2IPtJOYdBMuzrvV2zX/4aVkWdFykpGBtErFqtLp+uYNP+X9ohpgA04X/hX8fatWcGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIzmm0TP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIzmm0TP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf257158fso26723735e9.2
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743354967; x=1743959767; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4dfVWDdoa/oas+4AdjJ4QV5gH8y7CUfBuIhB8fYOuo=;
        b=QIzmm0TPMLGFjXZX4DBGd+G6+HTMZWH7LGj8yWF9M81CLVZwyq5C9ylRMqOFufh0aa
         jOvVRZG6B6W+iS0ipoZs71mL8oPJEyhj6dew7Sk6lnzNk4+770rdIICyMkXyfqcHhSyz
         RsToyZDi36vNyE10b8AMjLLnm00BRfjNdfyzqUKg//fIKv2NbLRKG4J/++X3DmY7QljX
         IqDovhaYFhweneKjssARQmUEyFC1ZXWabPHy2f/qAXNSrP1j8H038np8Zmr7jANwJsAo
         B4tqzeKOSVAupT9Hc4jlSS1dzMYbjjxo7FzXkAJU1EgS3/zdq29swabh2fPmnBR3jR8k
         hgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743354967; x=1743959767;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4dfVWDdoa/oas+4AdjJ4QV5gH8y7CUfBuIhB8fYOuo=;
        b=c8VX0m5TqVPk1eSs0lehJ3hjip0IObVaDRyCpXGtgwLSW2KO8uqt4zPGm4d+zx7RTO
         JT2jcjcXhI/naQxcxIuTZgcHMHJiG83kWvZEYxEZjG44A6N8OqTvEjdezwFqhAh8sowf
         ibXaRKkThtK+fu6i1CrGf6L3NGqBjn12i+QTrF8nnUa+v++XnyVp5L65QPWP28ZhPNX+
         xrTA6IvltoHYT+im+3F3dT2IlU18yEnvze3EoLUDuZypIi68hg2Cszo8dgL/3l7Csadp
         k/vc8j3oE6CMjPQN0VO8gsfWyYc7Di0LNSWAwTxx7IW9Z0HUCzr1UXDEOOjoxuTnb0FR
         PkWA==
X-Gm-Message-State: AOJu0YzuuwwsqoZgyP2L6lKGvIUUEDonUMv20hT+OtYUjpkK6gsUnwvN
	dxcFXgBpRDM6jrdgma851uZU83GQvaDBlABKONifni3/CdHCauhJdfX/HQ==
X-Gm-Gg: ASbGncvdGseuFsq5vv1DTv8WGRtGS4LrcyXD/fGhc70JhCncLrhBy4XnBv+CuqBah+8
	05cUeInaRKKMQipM/sMpaPZySnCGKQuLnizdiyGUuG9msY2JslrKMxm4dEMfdZ7H2Jl0kRxlvKy
	FnN1DatZ4wGMNtCrSL6YWtLmaXf1d/kt56cXps/9C2PQJAQTfcL/i1ReA49PDihrChiGkDu7g/V
	ginfzuClMbPmUuKy3o4YPGO51caUhmkrVXWdRDF9lsXV4r8pe19wsYiiXG240IncgCJGxKp191R
	o06RiFC5tklLkxS1LiH6dhC3jl4heky/wybqjfP827cteA==
X-Google-Smtp-Source: AGHT+IHdI/t3bZKKd1XsQfC9p/tGuf2GYt+uZzvNOBrNaEaQwjvJ5927PykQhMvds/1d6OwM841Ffw==
X-Received: by 2002:a05:600c:8718:b0:43c:e8ca:5140 with SMTP id 5b1f17b1804b1-43db62bcfeemr51950835e9.23.1743354967010;
        Sun, 30 Mar 2025 10:16:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fbbfef2sm97099885e9.11.2025.03.30.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 10:16:06 -0700 (PDT)
Message-Id: <1676b5ac628fd2898c3dab1b25d6a852cedfa6ae.1743354964.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 30 Mar 2025 17:16:00 +0000
Subject: [PATCH 1/5] doc: convert git-reset to new documentation format
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

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-reset.adoc | 100 +++++++++++++++++------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 79ad5643eed..5c73448e072 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -7,23 +7,23 @@ git-reset - Reset current HEAD to the specified state
 
 SYNOPSIS
 --------
-[verse]
-'git reset' [-q] [<tree-ish>] [--] <pathspec>...
-'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
-'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
-'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
+[synopsis]
+git reset [-q] [<tree-ish>] [--] <pathspec>...
+git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
+git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
+git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-In the first three forms, copy entries from `<tree-ish>` to the index.
-In the last form, set the current branch head (`HEAD`) to `<commit>`,
+In the first three forms, copy entries from _<tree-ish>_ to the index.
+In the last form, set the current branch head (`HEAD`) to _<commit>_,
 optionally modifying index and working tree to match.
-The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
+The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
 
-'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
-'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]::
+`git reset [-q] [<tree-ish>] [--] <pathspec>...`::
+`git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
 	These forms reset the index entries for all paths that match the
-	`<pathspec>` to their state at `<tree-ish>`.  (It does not affect
+	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
 	the working tree or the current branch.)
 +
 This means that `git reset <pathspec>` is the opposite of `git add
@@ -37,30 +37,30 @@ and specifying a commit with `--source`, you
 can copy the contents of a path out of a commit to the index and to the
 working tree in one go.
 
-'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]::
+`git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
 	Interactively select hunks in the difference between the index
-	and `<tree-ish>` (defaults to `HEAD`).  The chosen hunks are applied
+	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
 	in reverse to the index.
 +
 This means that `git reset -p` is the opposite of `git add -p`, i.e.
-you can use it to selectively reset hunks. See the ``Interactive Mode''
+you can use it to selectively reset hunks. See the "Interactive Mode"
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
-'git reset' [<mode>] [<commit>]::
-	This form resets the current branch head to `<commit>` and
-	possibly updates the index (resetting it to the tree of `<commit>`) and
-	the working tree depending on `<mode>`. Before the operation, `ORIG_HEAD`
-	is set to the tip of the current branch. If `<mode>` is omitted,
-	defaults to `--mixed`. The `<mode>` must be one of the following:
+`git reset [<mode>] [<commit>]`::
+	This form resets the current branch head to _<commit>_ and
+	possibly updates the index (resetting it to the tree of _<commit>_) and
+	the working tree depending on _<mode>_. Before the operation, `ORIG_HEAD`
+	is set to the tip of the current branch. If _<mode>_ is omitted,
+	defaults to `--mixed`. The _<mode>_ must be one of the following:
 +
 --
---soft::
+`--soft`::
 	Does not touch the index file or the working tree at all (but
-	resets the head to `<commit>`, just like all modes do). This leaves
-	all your changed files "Changes to be committed", as `git status`
+	resets the head to _<commit>_, just like all modes do). This leaves
+	all your changed files "Changes to be committed", as `git status
 	would put it.
 
---mixed::
+`--mixed`::
 	Resets the index but not the working tree (i.e., the changed files
 	are preserved but not marked for commit) and reports what has not
 	been updated. This is the default action.
@@ -68,33 +68,33 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 If `-N` is specified, removed paths are marked as intent-to-add (see
 linkgit:git-add[1]).
 
---hard::
+`--hard`::
 	Resets the index and working tree. Any changes to tracked files in the
-	working tree since `<commit>` are discarded.  Any untracked files or
+	working tree since _<commit>_ are discarded.  Any untracked files or
 	directories in the way of writing any tracked files are simply deleted.
 
---merge::
+`--merge`::
 	Resets the index and updates the files in the working tree that are
-	different between `<commit>` and `HEAD`, but keeps those which are
+	different between _<commit>_ and `HEAD`, but keeps those which are
 	different between the index and working tree (i.e. which have changes
 	which have not been added).
-	If a file that is different between `<commit>` and the index has
+	If a file that is different between _<commit>_ and the index has
 	unstaged changes, reset is aborted.
 +
 In other words, `--merge` does something like a `git read-tree -u -m <commit>`,
 but carries forward unmerged index entries.
 
---keep::
+`--keep`::
 	Resets index entries and updates files in the working tree that are
-	different between `<commit>` and `HEAD`.
-	If a file that is different between `<commit>` and `HEAD` has local
+	different between _<commit>_ and `HEAD`.
+	If a file that is different between _<commit>_ and `HEAD` has local
 	changes, reset is aborted.
 
---[no-]recurse-submodules::
-	When the working tree is updated, using --recurse-submodules will
+`--[no-]recurse-submodules`::
+	When the working tree is updated, using `--recurse-submodules` will
 	also recursively reset the working tree of all active submodules
 	according to the commit recorded in the superproject, also setting
-	the submodules' HEAD to be detached at that commit.
+	the submodules' `HEAD` to be detached at that commit.
 --
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
@@ -104,31 +104,31 @@ between the three commands.
 OPTIONS
 -------
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be quiet, only report errors.
 
---refresh::
---no-refresh::
+`--refresh`::
+`--no-refresh`::
 	Refresh the index after a mixed reset. Enabled by default.
 
---pathspec-from-file=<file>::
-	Pathspec is passed in `<file>` instead of commandline args. If
-	`<file>` is exactly `-` then standard input is used. Pathspec
-	elements are separated by LF or CR/LF. Pathspec elements can be
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
@@ -348,7 +348,7 @@ $ git commit ...                            <8>
 ------------
 +
 <1> First, reset the history back one commit so that we remove the original
-    commit, but leave the working tree with all the changes. The -N ensures
+    commit, but leave the working tree with all the changes. The `-N` ensures
     that any new files added with `HEAD` are still marked so that `git add -p`
     will find them.
 <2> Next, we interactively select diff hunks to add using the `git add -p`
@@ -458,7 +458,7 @@ working index HEAD target         working index HEAD
 			  --keep   B       C     C
 ....
 
-`reset --merge` is meant to be used when resetting out of a conflicted
+`git reset --merge` is meant to be used when resetting out of a conflicted
 merge. Any mergy operation guarantees that the working tree file that is
 involved in the merge does not have a local change with respect to the index
 before it starts, and that it writes the result out to the working tree. So if
@@ -467,7 +467,7 @@ between the index and the working tree, then it means that we are not
 resetting out from a state that a mergy operation left after failing
 with a conflict. That is why we disallow `--merge` option in this case.
 
-`reset --keep` is meant to be used when removing some of the last
+`git reset --keep` is meant to be used when removing some of the last
 commits in the current branch while keeping changes in the working
 tree. If there could be conflicts between the changes in the commit we
 want to remove and the changes in the working tree we want to keep,
-- 
gitgitgadget

