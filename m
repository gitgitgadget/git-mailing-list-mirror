Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aLS17vIb"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27A1FFD
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 18:03:28 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B5C51B529D;
	Thu, 23 Nov 2023 21:03:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uwx38pCSEPU6RiEp6/9l0/5y5KhdsXvf+6hq+X
	LXbvI=; b=aLS17vIbRcaNp3RF96Ee/ZHrKgexTfgAOCHFFRrvSUPf1FrZoOJ9hz
	vs/mxGhL9EQMLoWe8T1HGnZIIJOhmY8AAwQ4Vv9t9nQvi0W1CMd2xjtFiM7L28es
	+zDsjCotcmoVHmCv3ZaqGRpqzpW7ZtOJHRJ2deEN1cIztUybxoAi4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 62E161B529C;
	Thu, 23 Nov 2023 21:03:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFF1E1B529B;
	Thu, 23 Nov 2023 21:03:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Craig H Maynard <chmaynard@me.com>,  Git Community <git@vger.kernel.org>
Subject: Re: Orphan branch not well-defined?
In-Reply-To: <CAPx1Gvf_meaEBq9XfS9aPg0yLja-2sAW5SUg0jx6f1jNyfmWHw@mail.gmail.com>
	(Chris Torek's message of "Tue, 21 Nov 2023 17:42:42 -0800")
References: <FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com>
	<CAPx1Gvf_meaEBq9XfS9aPg0yLja-2sAW5SUg0jx6f1jNyfmWHw@mail.gmail.com>
Date: Fri, 24 Nov 2023 11:03:23 +0900
Message-ID: <xmqqwmu79ac4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A6ABA1E2-8A6D-11EE-930E-25B3960A682E-77302942!pb-smtp2.pobox.com

Chris Torek <chris.torek@gmail.com> writes:

> ** Unborn Branch is the better term **

Yes,  To orphan is a verb that denotes the act of becoming on an
unborn branch, and a few references to "orphan branch" in our
documentation are misuses of the word, I would have to say.

I suspect that there are other mentions of "orphan branch" in the
code comments, variable names, and even end-user facing messages,
some of which may need to be corrected, but the first place to start
is in the glossary.  How about this?

 Documentation/glossary-content.txt | 19 +++++++++++++++++++
 Documentation/config/advice.txt    |  2 +-
 Documentation/git-checkout.txt     |  2 +-
 Documentation/git-switch.txt       |  2 +-
 Documentation/git-worktree.txt     |  4 ++--
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-content.txt
index 59d8ab8572..bbf7b84ab7 100644
--- c/Documentation/glossary-content.txt
+++ w/Documentation/glossary-content.txt
@@ -312,6 +312,13 @@ This commit is referred to as a "merge commit", or sometimes just a
 [[def_octopus]]octopus::
 	To <<def_merge,merge>> more than two <<def_branch,branches>>.
 
+[[def_orphan]]orphan::
+	The act of becoming on an <<def_unborn,unborn>> branch.
+	After such an operation, the <<def_HEAD,HEAD>> points at a
+	<<def_branch,branch>> that does not yet exist, and the
+	commit first created from such a state becomes a root
+	commit, starting a new history.
+
 [[def_origin]]origin::
 	The default upstream <<def_repository,repository>>. Most projects have
 	at least one upstream project which they track. By default
@@ -695,6 +702,18 @@ The most notable example is `HEAD`.
 	object,
 	etc.
 
+[[def_unborn]]unborn::
+	The <<def_HEAD,HEAD>> can point at a <<def_branch,branch>>
+	that does not yet have any <<def_commit,commit>> on it, and
+	such a branch is called an unborn branch.  The most typical
+	way users encounter an unborn branch is by creating a
+	repository anew without cloning from elsewhere.  The HEAD
+	would point at the 'main' (or 'master', depending on your
+	configuration) branch that is yet to be born.  Also some
+	operations can get you on an unborn branch with their
+	<<def_orphan,orphan>> option.
+
+
 [[def_unmerged_index]]unmerged index::
 	An <<def_index,index>> which contains unmerged
 	<<def_index_entry,index entries>>.
diff --git c/Documentation/config/advice.txt w/Documentation/config/advice.txt
index 2737381a11..4d7e5d8759 100644
--- c/Documentation/config/advice.txt
+++ w/Documentation/config/advice.txt
@@ -140,6 +140,6 @@ advice.*::
 		Advice shown when a fast-forward is not possible.
 	worktreeAddOrphan::
 		Advice shown when a user tries to create a worktree from an
-		invalid reference, to instruct how to create a new orphan
+		invalid reference, to instruct how to create a new unborn
 		branch instead.
 --
diff --git c/Documentation/git-checkout.txt w/Documentation/git-checkout.txt
index 240c54639e..26ad1a5e27 100644
--- c/Documentation/git-checkout.txt
+++ w/Documentation/git-checkout.txt
@@ -215,7 +215,7 @@ variable.
 	below for details.
 
 --orphan <new-branch>::
-	Create a new 'orphan' branch, named `<new-branch>`, started from
+	Create a new unborn branch, named `<new-branch>`, started from
 	`<start-point>` and switch to it.  The first commit made on this
 	new branch will have no parents and it will be the root of a new
 	history totally disconnected from all the other branches and
diff --git c/Documentation/git-switch.txt w/Documentation/git-switch.txt
index c60fc9c138..3e23a82cf2 100644
--- c/Documentation/git-switch.txt
+++ w/Documentation/git-switch.txt
@@ -171,7 +171,7 @@ name, the guessing is aborted.  You can explicitly give a name with
 	`branch.autoSetupMerge` configuration variable is true.
 
 --orphan <new-branch>::
-	Create a new 'orphan' branch, named `<new-branch>`. All
+	Create a new unborn branch, named `<new-branch>`. All
 	tracked files are removed.
 
 --ignore-other-worktrees::
diff --git c/Documentation/git-worktree.txt w/Documentation/git-worktree.txt
index 93d76f5d66..2a240f53ba 100644
--- c/Documentation/git-worktree.txt
+++ w/Documentation/git-worktree.txt
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
