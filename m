Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34132138486
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022566; cv=none; b=VDaRC60GoYxA2Y2x+z9DeXDMkJrjWuZVcARwdi0bUBbJ1R7kbvvigatVHkHL7bDPsnOTyRCWvI8+wXRRw8bI0F0Qn9YF+tJWIVxFnQvDRQ7nz/5Vve7RtAaFaaaI4cXwaEiegR+BxBuXco/d0G/HYajoFfip5QWpka6YBHXDOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022566; c=relaxed/simple;
	bh=Gf7m0xm8IrKYOGD97Af3odAMu5D/G9q6lzxWy27Ik6I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=cy4gs+9nSZpaIRQVBhi6Z6VppI8YBcaKkrpavi5hA08ErhrpuHhRfCV5jnXAqFzCBaayYOiyM+L9rgvo1UF5epHW1Y461s4hWeHaymQt3GtzrxvEsmAaEyJbePIDTiX5/R1S0Bm9y4VIrTAaE5qx/ruC2wtZl20OpNjMYO1y6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=miJrkJPX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="miJrkJPX"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708022553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jdBVGg13GkMW91x/fH8wh7WoDw9AgCAEWGFa+niUoss=;
	b=miJrkJPX3VBqZwTB2R6eIzhk7a8aIJA/gEqnjdGMJiuOT/yZXeDRXAMyHsCfjTiVU8v3X/
	x4nVI2owxaVylI1LshO8gRpq+D0X7LmmcpUu4tN6F44bZ60q0USSgAcB4wqaQfTeM2lJpE
	nZLcj2XxzoEGR9BKLSw1jE+yp3F+cZSpLh2n0Y3W1dxLvR8Yo8NBrkYLNichqem8Wbyy0m
	r6xv6iHLl1v00iBN9h37q6QmdseCWvf7b+0Q7qjkJVIl15n65SToETVy0hYoe0z3+cIsXe
	IvOz0RojDXjtJ1cwJc4zUSeJCnrYob1httSdrqkvMPGM3yYy33TYDUFP8TUSsQ==
To: git@vger.kernel.org
Subject: [PATCH] branch: rework the descriptions of rename and copy operations
Date: Thu, 15 Feb 2024 19:42:32 +0100
Message-Id: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
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
    
    Consequently, this is effectively version 2 of the patch, which includes
    detailed feedback from Kyle and Junio, who suggested moving/adding the
    argument descriptions to their respective commands.  This resulted in more
    significant changes to the contents of the git-branch(1) man page, in an
    attempt to make it more readable.
    
    [3] https://lore.kernel.org/git/e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org/T/#u

 Documentation/git-branch.txt | 44 +++++++++++++++---------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0b0844293235..370ea43c0380 100644
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
@@ -128,18 +118,28 @@ Note that 'git branch -f <branchname> [<start-point>]', even with '-f',
 refuses to change an existing branch `<branchname>` that is checked out
 in another worktree linked to the same repository.
 
--m::
---move::
-	Move/rename a branch, together with its config and reflog.
+-m [<oldbranch>] <newbranch>::
+--move [<oldbranch>] <newbranch>::
+	Rename an existing branch <oldbranch>, which if not specified defaults
+	to the current branch, to <newbranch>.  The configuration variables
+	for the <oldbranch> branch and its reflog are also renamed appropriately
+	to be used with <newbranch>.  Renaming fails if branch <newbranch>
+	already exists, but you can use `-M` or `--move --force` to overwrite
+	the files in existing branch <newbranch> while renaming.
 
--M::
+-M [<oldbranch>] <newbranch>::
 	Shortcut for `--move --force`.
 
--c::
---copy::
-	Copy a branch, together with its config and reflog.
+-c [<oldbranch>] <newbranch>::
+--copy [<oldbranch>] <newbranch>::
+	Copy an existing branch <oldbranch>, which if not specified defaults
+	to the current branch, to <newbranch>.  The configuration variables
+	for the <oldbranch> branch and its reflog are also copied appropriately
+	to be used with <newbranch>.  Copying fails if branch <newbranch>
+	already exists, but you can use `-C` or `--copy --force` to overwrite
+	the files in existing branch <newbranch> while copying.
 
--C::
+-C [<oldbranch>] <newbranch>::
 	Shortcut for `--copy --force`.
 
 --color[=<when>]::
@@ -311,14 +311,6 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
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
