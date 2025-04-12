Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3113A418
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460457; cv=none; b=J8w9FC9IuzD2KknsnGy3twMLypoWXFiWoU44hXPUo4n+1zsgAJfPy2mh7tU9bsfCIbHfYIFOj4yUBInMmUBiGMt5k/LK3Y7eZn5HiGKO749/GSamGZnaIdpoHAqu6ln7eD9CivgslsGghN1ciLjou+t2b+Sl0d7bNHBhXT8XkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460457; c=relaxed/simple;
	bh=rER6dhDpSdlwRFWb/tSuJMdsxMMJULd4OVBeFfn2hCg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=V/lYPOgLx+qGL9TfXmF0yidJnJxmJaByjFSIZEzemBNS1cYTLjwMmcjgSZPGSM0VTc37DJ7BWQZ//bOMxU4i0PKFFPqEgWpcCdViPThNAw0RmgrEqK6NKnS9NVKa8rqpXX5lqYgH7F9i6/58/0if3f9/QNvqZQ0GE1YqS/npniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSgTpTm7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSgTpTm7"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39d83782ef6so2440337f8f.0
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 05:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460453; x=1745065253; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4+V00ShfXLgJvsVSvic5DNCNpnot1dRORucXNOL4uc=;
        b=XSgTpTm78hPAGsOZVoO1UFRFiiE3bRa65eO6xxywVieSUQ4e4t72dDcQLLIVVpuYo7
         DmHP9BmXjWYH97G/kMSi1JCEjF9SCClSTLbOOS3sQhNN8Ry9JxkHO8S47zIXXGc3Tki6
         s5L7gPdt62NZn8CJlwvHaMFKa2q8WH02iv+sk9hbh1o78peN/1Z2F5kYLp//hUs/6mrk
         WMWed8Wt6EI6NUqmN75l4TS6rgrtAU9Y98V3JTCL5PqiBCOSi4L8fK51Wx3UrPTHpmrO
         J1b+6Voxv1fkTAxMSjGozIOZmCJOqJ1wWprXT+dCDJ6of5ZAZjTXrr7a/Qd71QvbWUPS
         8OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460453; x=1745065253;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4+V00ShfXLgJvsVSvic5DNCNpnot1dRORucXNOL4uc=;
        b=hfDgiSfY88sGCohxmELGpzIAO9pRO4f4cABc7U7nrXqDwQqcHOZMBMYS0ORg+Y7i7z
         8eFKxu9hU44+K2B61vqr3hrSLc+eLadwPTj7zNzgIjnOFmKhvq1J7ZKvPkMGbOA/0oSw
         D35O9x/1u/22L5tBlEWNS+vE+MGQAssIMIHaAHqkYguNhT5kRFYXpNYEQ8Gmw+wRPPXm
         6ICnM7EmqqU+8Z4yGiSM+9VBNQZ7Pocv411mwKVxf9mmRYfup5PhMN6TyVM198phoBgc
         Y3rlm2WHEfWp0lSrF5mAncufHllKIoNP87aOv/sBfJOQRleM6LH2cTQt12Rjh5zLU3z+
         5IwQ==
X-Gm-Message-State: AOJu0YzOwkD1AMGIJdBFHAnKkesNSid03wZErWmPp3HEtTGpHLx9eYSj
	S8iQKs3rUyPzmEy+lVmQM40qviHJuZpX5oDkwA84featuGvlEtX4pMAZ8Q==
X-Gm-Gg: ASbGnctp5eVl7nXcuOQLd2YRB5pu3Sral6JzfgVg8JXX43L4UD94Fy/mIfD3/FiGudF
	3zRnpUJdIl144tHdOnAbq+ZEGfOrnw28CJ58e1Td6FwNDJISTcbv8oYPt1xvaYV2buTGw7RueUQ
	tY0w0/xUonbcDBb/wxiqnSi1atCF72TRcsceHfKkKU0+a9A8QOOK3xFPF93wL4GS0wLuxHNuQX7
	pSIR9/z8dJw5ndwzAnuUR8YTaAm7kUjtUr7cXsI8se+p1ZpQlqzMuIuO8cK+8edHSZtKuIlaqxL
	bzmAOHe7AZ21l6zVFkLsvDCFlmsr2+xeu23+ohUg6w==
X-Google-Smtp-Source: AGHT+IFHmB5qqjpsvL4AghHEhc0kWtuoVthjYJLszuCdIC8s79bfMa8wJWA6U6FRAlG6qc556Sf+Ng==
X-Received: by 2002:a05:6000:2401:b0:39c:30d8:3265 with SMTP id ffacd0b85a97d-39e6e4a1964mr5528075f8f.15.1744460453281;
        Sat, 12 Apr 2025 05:20:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae97751fsm4909571f8f.41.2025.04.12.05.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:20:52 -0700 (PDT)
Message-Id: <5a6c7def2608219ac4069a6da3afe96242695ef1.1744460450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
	<pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 12:20:44 +0000
Subject: [PATCH v2 1/7] doc: convert git-reset to new documentation format
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
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
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
 Documentation/git-reset.adoc | 98 ++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 79ad5643eed..53ab88c5451 100644
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
+	resets the head to _<commit>_, just like all modes do). This leaves
 	all your changed files "Changes to be committed", as `git status`
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

