Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="idM/xSwN"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E13D43
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:09:20 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C11031B5A10;
	Thu, 23 Nov 2023 22:09:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	Sv0+KttBvPK4ZSI/eQntyVWwkWxPoELR6qrHiT8qMs=; b=idM/xSwNcygmfRXnF
	biFo82mgmvVQIHTjEnXyZE7hGPSZVfWHTyu328CXBQLrthZt1iDCseTEk3ALSiAA
	tSpAGnSkzjUiXrnxXXFUk1uJWG2XMXpxib9jmxaeE42cSf9IONPqX7rzr9/lwTAl
	SvEPzY210RN7lZbkMPttnbUa7Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B81DE1B5A0F;
	Thu, 23 Nov 2023 22:09:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 211A21B5A0E;
	Thu, 23 Nov 2023 22:09:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] orphan/unborn: add to the glossary and use them
 consistently
Date: Fri, 24 Nov 2023 12:09:18 +0900
Message-ID: <xmqqbkbj97a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DBAEF124-8A76-11EE-9BD8-25B3960A682E-77302942!pb-smtp2.pobox.com

To orphan is a verb that denotes the act of getting on an unborn
branch, and a few references to "orphan branch" in our documentation
are misuses of the word.  They caused end-user confusion, which was
made even worse because we did not have the term defined in the
glossary document.  Add entries for "unborn" branch and "orphan"
operation to the glossary, and adjust existing documentation
accordingly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/config/advice.txt    |  2 +-
 Documentation/git-checkout.txt     |  2 +-
 Documentation/git-switch.txt       |  2 +-
 Documentation/git-worktree.txt     |  4 ++--
 Documentation/glossary-content.txt | 18 ++++++++++++++++++
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c548a91e67..6aaee01d7f 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -140,6 +140,6 @@ advice.*::
 		Advice shown when a fast-forward is not possible.
 	worktreeAddOrphan::
 		Advice shown when a user tries to create a worktree from an
-		invalid reference, to instruct how to create a new orphan
+		invalid reference, to instruct how to create a new unborn
 		branch instead.
 --
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4af0904f47..3d526613d5 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -213,7 +213,7 @@ variable.
 	below for details.
 
 --orphan <new-branch>::
-	Create a new 'orphan' branch, named `<new-branch>`, started from
+	Create a new unborn branch, named `<new-branch>`, started from
 	`<start-point>` and switch to it.  The first commit made on this
 	new branch will have no parents and it will be the root of a new
 	history totally disconnected from all the other branches and
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index c60fc9c138..3e23a82cf2 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -171,7 +171,7 @@ name, the guessing is aborted.  You can explicitly give a name with
 	`branch.autoSetupMerge` configuration variable is true.
 
 --orphan <new-branch>::
-	Create a new 'orphan' branch, named `<new-branch>`. All
+	Create a new unborn branch, named `<new-branch>`. All
 	tracked files are removed.
 
 --ignore-other-worktrees::
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 93d76f5d66..2a240f53ba 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -99,7 +99,7 @@ command will refuse to create the worktree (unless `--force` is used).
 If `<commit-ish>` is omitted, neither `--detach`, or `--orphan` is
 used, and there are no valid local branches (or remote branches if
 `--guess-remote` is specified) then, as a convenience, the new worktree is
-associated with a new orphan branch named `<branch>` (after
+associated with a new unborn branch named `<branch>` (after
 `$(basename <path>)` if neither `-b` or `-B` is used) as if `--orphan` was
 passed to the command. In the event the repository has a remote and
 `--guess-remote` is used, but no remote or local branches exist, then the
@@ -234,7 +234,7 @@ This can also be set up as the default behaviour by using the
 
 --orphan::
 	With `add`, make the new worktree and index empty, associating
-	the worktree with a new orphan/unborn branch named `<new-branch>`.
+	the worktree with a new unborn branch named `<new-branch>`.
 
 --porcelain::
 	With `list`, output in an easy-to-parse format for scripts.
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 5a537268e2..c67b7f3ec1 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -294,6 +294,12 @@ This commit is referred to as a "merge commit", or sometimes just a
 [[def_octopus]]octopus::
 	To <<def_merge,merge>> more than two <<def_branch,branches>>.
 
+[[def_orphan]]orphan::
+	The act of getting on a <<def_branch,branch>> that does not
+	exist yet (i.e., an <<def_unborn,unborn>> branch).  After
+	such an operation, the commit first created becomes a commit
+	without a parent, starting a new history.
+
 [[def_origin]]origin::
 	The default upstream <<def_repository,repository>>. Most projects have
 	at least one upstream project which they track. By default
@@ -674,6 +680,18 @@ The most notable example is `HEAD`.
 	object,
 	etc.
 
+[[def_unborn]]unborn::
+	The <<def_HEAD,HEAD>> can point at a <<def_branch,branch>>
+	that does not yet exist and that does not have any commit on
+	it yet, and such a branch is called an unborn branch.  The
+	most typical way users encounter an unborn branch is by
+	creating a repository anew without cloning from elsewhere.
+	The HEAD would point at the 'main' (or 'master', depending
+	on your configuration) branch that is yet to be born.  Also
+	some operations can get you on an unborn branch with their
+	<<def_orphan,orphan>> option.
+
+
 [[def_unmerged_index]]unmerged index::
 	An <<def_index,index>> which contains unmerged
 	<<def_index_entry,index entries>>.
-- 
2.43.0

