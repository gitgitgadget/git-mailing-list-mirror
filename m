Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2678685
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087479; cv=none; b=qgnEa5IC93YhVCt09Fq7MrPnlUJ4PlnCW5EgJIb6Ups4rnWzza23spCFNKas97lL69I5pv/dcCVPjH3VOJjbW0zd9nrI6T+iP3fevx/kGvDdUjfJblC7VTGtDRTMatnZrVXNLPOJIQOEaVfB9KRdaiNJtrhArai1xi22PUFYD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087479; c=relaxed/simple;
	bh=OFAVaOrur0Ry+zx2vDXkrUMPfmqYx5KWsEoZfZDFiso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3DOP57llAntotZ3MrsefZMsqhntrpHy6+veUWwt+4nUyXm0GCsN/F/q5hBue0dN6jtwBVgI+6TpNoQ1CbxJCQNpqcU4em2+orcMsiRZVXD8e8vP2xnl5Q4a4OcTTGuBMDNCjK/CRB78MsV4eJP4yj/zXswocpIgkjp7yKq/zMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FJsO+UNX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FJsO+UNX"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708087469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GQKvRVMyy/BLUevTLcEgougMcFvtj1CpVwbc5ZYHCmw=;
	b=FJsO+UNXBUP+/ysa8ci7k69dsJoItn14GERV+u9lHfrZfE3gEQ+RlawAf7T8vW6Y2qxddF
	KqM/YNO4ICRkPvQfp9erclotqkHph23adDJa/tdJuXwFhqF7CwRDgn9ZbpmIuCVFjx1GM3
	ffthYVAispG5pFvZ2M61kbFSZ5i7WtsYAs7w2h4gM6kVPJqln06rhW+0efOB7fjDt9QQH9
	6TjL5qH71B5PwGSHxnXJ6UEMRDs28kycQrKq9FqpCi7AM3E3cbW1RpCTxXnahP0WgMf+fw
	S86AOaYztN8Tt/MvW5754+z6VJEmpmvSB3B51P4avIXMSuYoNBxYk0bcU7O0ZA==
To: git@vger.kernel.org
Cc: code@khaugsbakk.name,
	gitster@pobox.com,
	rjusto@gmail.com,
	spectral@google.com
Subject: [PATCH v2] branch: rework the descriptions of rename and copy operations
Date: Fri, 16 Feb 2024 13:44:19 +0100
Message-Id: <6e1c3f2c5816f09aab561bc7dec2b7455d70aaec.1708087213.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Move the descriptions of the <oldbranch> and <newbranch> arguments to the
descriptions of the branch rename and copy operations, where they naturally
belong.  Also, improve the descriptions of these two branch operations and,
for completeness, describe the outcomes of forced operations.

Describing the arguments together with their respective operations, instead
of describing them separately in a rather unfortunate attempt to squeeze more
meaning out of fewer words, flows much better and makes the git-branch(1)
man page significantly more usable.

The subsequent improvements shall continue this approach by either dissolving
as many sentences from the "Description" section into the "Options" section,
or by having those sentences converted into some kind of more readable and
better flowing prose, as already discussed and outlined. [1][2]

[1] https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/T/#u
[2] https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/T/#u

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This patch was originally named "branch: clarify <oldbranch> and <newbranch>
    terms further", submitted and discussed in another thread, [3] but the nature
    of the patch has changed, causing the patch subject to be adjusted to match.
    
    Consequently, the version 1 is effectively version 2 of the original patch.
    The version 1 of the patch includes detailed feedback from Kyle and Junio,
    who suggested moving/adding the argument descriptions to their respective
    commands.  This resulted in more significant changes to the contents of the
    git-branch(1) man page, in an attempt to make it more readable.
    
    The version 2 includes feedback from Kristoffer and Junio, by improving the
    wording of the opening sentences in the descriptions of branch rename and
    copy operations, and by mentioning the additional reflog entry created while
    renaming a branch, which was omitted in the v1 by mistake.
    
    [3] https://lore.kernel.org/git/e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org/T/#u

 Documentation/git-branch.txt | 51 ++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0b0844293235..d52b5e8dbacd 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -72,16 +72,6 @@ the remote-tracking branch. This behavior may be changed via the global
 overridden by using the `--track` and `--no-track` options, and
 changed later using `git branch --set-upstream-to`.
 
-With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
-If <oldbranch> had a corresponding reflog, it is renamed to match
-<newbranch>, and a reflog entry is created to remember the branch
-renaming. If <newbranch> exists, -M must be used to force the rename
-to happen.
-
-The `-c` and `-C` options have the exact same semantics as `-m` and
-`-M`, except instead of the branch being renamed, it will be copied to a
-new name, along with its config and reflog.
-
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
@@ -128,18 +118,31 @@ Note that 'git branch -f <branchname> [<start-point>]', even with '-f',
 refuses to change an existing branch `<branchname>` that is checked out
 in another worktree linked to the same repository.
 
--m::
---move::
-	Move/rename a branch, together with its config and reflog.
-
--M::
+-m [<oldbranch>] <newbranch>::
+--move [<oldbranch>] <newbranch>::
+	Rename an existing branch `<oldbranch>` to `<newbranch>`;  if left
+	unspecified, `<oldbranch>` defaults to the current branch.  The
+	configuration variables for the `<oldbranch>` branch and its reflog
+	are also renamed appropriately to be used with `<newbranch>`.  In
+	addition, a reflog entry is created to remember the branch renaming.
+	Renaming fails if branch `<newbranch>` already exists, but `-M`
+	or `--move --force` can be used to overwrite the contents of the
+	existing branch `<newbranch>` while renaming.
+
+-M [<oldbranch>] <newbranch>::
 	Shortcut for `--move --force`.
 
--c::
---copy::
-	Copy a branch, together with its config and reflog.
-
--C::
+-c [<oldbranch>] <newbranch>::
+--copy [<oldbranch>] <newbranch>::
+	Copy an existing branch `<oldbranch>` to `<newbranch>`;  if left
+	unspecified, `<oldbranch>` defaults to the current branch.  The
+	configuration variables for the `<oldbranch>` branch and its reflog
+	are also copied appropriately to be used with `<newbranch>`.
+	Copying fails if branch `<newbranch>` already exists, but `-C`
+	or `--copy --force` can be used to overwrite the contents of the
+	existing branch `<newbranch>` while copying.
+
+-C [<oldbranch>] <newbranch>::
 	Shortcut for `--copy --force`.
 
 --color[=<when>]::
@@ -311,14 +314,6 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	given as a branch name, a commit-id, or a tag.  If this
 	option is omitted, the current HEAD will be used instead.
 
-<oldbranch>::
-	The name of an existing branch.  If this option is omitted,
-	the name of the current branch will be used instead.
-
-<newbranch>::
-	The new name for an existing branch. The same restrictions as for
-	<branchname> apply.
-
 --sort=<key>::
 	Sort based on the key given. Prefix `-` to sort in descending
 	order of the value. You may use the --sort=<key> option
