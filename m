Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC52C0276
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891145; cv=none; b=ecGx9WVtdBx8IdNKMNSVG80FXU5xJhG9LrQW55v3uycTn9EByXbjNEarNJLJkCX6zXGPjQkTNwKuXjHr+bZcxA/cTLnR63tLXfvK8hPnzExRGrH9l+c0pjouBrFUR4muEzey4IxWlU3cq0tedZg1FBVdvx1AtoSdpWe5Kel2wQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891145; c=relaxed/simple;
	bh=lmibwYKSqD54AmsGvNGngqV+V3otPHcH6bcquFLX2c8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew6FHQ8uWSKwcsh3LqJ+irRK2+BNe/TzsI/WT1f8RQPa2bqfcugzUaiKD3fm1Fia88tT145gJBKAetmAZEQ86phyUFJ82UreTUKIi5WBMJ/ZY7r4NDbziEYO8LOvxXCSlEf3QJzbP/b48o1V0svocs3ZJSp1UUhwUqEud6GPImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MIHGoNQ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADWah7vQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MIHGoNQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADWah7vQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B14A1D00172;
	Tue, 11 Nov 2025 14:59:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 14:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762891141; x=
	1762977541; bh=COFWVG3ek+VdjreldJ7US97bBSeLTbILveQNroXB/Qk=; b=M
	IHGoNQ+zFMQY1icHjYuPF+lAUq8NtG9ka04B7w/OhUbPfeJdW5IcUDKqhUDcaL+M
	mWzPb6qYsjOjvFp/ixVFf7tPIRqT/OOxk+oGDOvczVb7Rr24IJTx/Wp4frSwOTNg
	5N8Synqaet3hAp/8gk724xV0UFM3v3KPWQIMr+twkQHhEEmcOhUn0f6YcveqBSDt
	KJIgi1Sf4EY4KMl87S02jyARcEH5KUoHq3Ao7qBisopuN0OHCSA6F0GG+oAxc07W
	/d6N2KgKtXfFkZ0Q2SHwq3HgTfmtQWDEdva+yA2yU9z7vBIOnzzsrfoSFa2/KOPZ
	0KwIw9uV/FqOwRlYT9CWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762891141; x=1762977541; bh=COFWVG3ek+VdjreldJ7US97bBSeL
	TbILveQNroXB/Qk=; b=ADWah7vQGdUWrgUM2J0qSZOUDyIARqOPSSXqGgbc+FiI
	OQbHGtwsQFVNbk1csVwoQKvzrsXuVWfIYhDL4OsoaWPw6lHDp7nWjoQAcqWUJP9f
	dUpXbXWqPDmrMDJbRPz48Xd2B7pWBbposLU+yLMBxrzrPTtdw7Xy8OQS7n1akPZG
	yD9sFPQjzWL0E9R2W9ELIF5GMEgGiJAj0/oBwqPWpRvOLWt39dkF9bWf3tshQbHC
	6y3lavxknvWlwvAq2k6QfECW7+oYTb0ZKv7iwTK0kKvc0lpVWfipECfhepeAD1ny
	Q4QrH3qc9IC4TjF1sVyio4dfD15D/cCFuzHS0utWEw==
X-ME-Sender: <xms:hZUTaUzxV27JC64bPYI48Fkrrbfu9UDgeDyxdYAlUsnkB4WVLe3fHg>
    <xme:hZUTaeSk3zDmA3nugSltCmgyyD3vgqQwrF251o3gK-bobh9fc3u0xlXHw8oyf-Ns_
    bN_O2MjCPVeOW0bJEx3nZFXVwf6oqpg3B-SI5NpF1gmxGpGKG_DrA>
X-ME-Received: <xmr:hZUTaT8D16tHnvBgBzfd95OzkKufrWRYYr8CRcCJz9fR6U8GlxRtx-dhQ4GijvsyBqdtzDqgAU5Ci7xkQZEYcCDySjt8QQVa7jr_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:hZUTadpEZR93Ah0pyD7yvMvmDkI3uMMEYEi8XFO2dx30t2Njk_zAKQ>
    <xmx:hZUTaYmquMj1dt3c69aINzP0h-lFsgKMF0XjntQTeDiklBtKlTQCfA>
    <xmx:hZUTacKduwEmK02d5swx8WdUFJQ6nx5Lnp_E43Rvr4lJNfN5G7NwJQ>
    <xmx:hZUTaVwqC9Pg1AMcI8kNTV9UaEIUOxR2gS71WUWG_Glhfl2u_U_igg>
    <xmx:hZUTaYKV23qIzq3HbjLP3DqcoWRNRZBstBLoh9b5BM_u2kGkWUm783WU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 14:59:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 3/3] Documentation: your checkout directory is "working tree" (part 2)
Date: Tue, 11 Nov 2025 11:58:53 -0800
Message-ID: <20251111195853.2511146-4-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251111195853.2511146-1-gitster@pobox.com>
References: <20251111195853.2511146-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same fix as the previous step, which replaced "work tree" with
"working tree" where appropriate, but this batch addresses the two
word phrase that are split across lines.

Since I didn't come up with a clever "grep" pattern to work across
line boundaries, I used pickaxe to find a block of "word 'work'
appears near the end of line, possibly followed by a run of
whitespaces or asterisks, then a newline, and then possibly a run of
whitespaces or asterisks, then word 'tree'" in the comparison
between an empty tree and what we have today, like so:

    $ LF=$'\n' WS="[* "$'\t'"]"
    $ git diff --pickaxe-regex -S"work$WS*$LF$WS*tree" \
	4b825dc642cb6 -- ':(glob)Documentation/*.adoc' |
      grep -A1 -e '^diff --git' -e "work${WS}$"

after finishing the previous two steps.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.adoc       | 2 +-
 Documentation/git-read-tree.adoc | 2 +-
 Documentation/git-rm.adoc        | 4 ++--
 Documentation/git-submodule.adoc | 2 +-
 Documentation/gitcli.adoc        | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 18e7ed9b79..ced77a4713 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -173,7 +173,7 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 `--ignore-missing`::
 	This option can only be used together with `--dry-run`. By using
 	this option the user can check if any of the given files would
-	be ignored, no matter if they are already present in the work
+	be ignored, no matter if they are already present in the working
 	tree or not.
 
 `--no-warn-embedded-repo`::
diff --git a/Documentation/git-read-tree.adoc b/Documentation/git-read-tree.adoc
index 9d60badd74..0110ac9cb8 100644
--- a/Documentation/git-read-tree.adoc
+++ b/Documentation/git-read-tree.adoc
@@ -43,7 +43,7 @@ OPTIONS
 	abort the operation.
 
 -u::
-	After a successful merge, update the files in the work
+	After a successful merge, update the files in the working
 	tree with the result of the merge.
 
 -i::
diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
index a7a3068381..dce054ea5d 100644
--- a/Documentation/git-rm.adoc
+++ b/Documentation/git-rm.adoc
@@ -152,7 +152,7 @@ git diff --name-only --diff-filter=D -z | xargs -0 git rm --cached
 SUBMODULES
 ----------
 Only submodules using a gitfile (which means they were cloned
-with a Git version 1.7.8 or newer) will be removed from the work
+with a Git version 1.7.8 or newer) will be removed from the working
 tree, as their repository lives inside the `.git` directory of the
 superproject. If a submodule (or one of those nested inside it)
 still uses a `.git` directory, `git rm` moves the submodules
@@ -164,7 +164,7 @@ will be staged (unless `--cached` or `-n` are used).
 A submodule is considered up to date when the `HEAD` is the same as
 recorded in the index, no tracked files are modified and no untracked
 files that aren't ignored are present in the submodule's working tree.
-Ignored files are deemed expendable and won't stop a submodule's work
+Ignored files are deemed expendable and won't stop a submodule's working
 tree from being removed.
 
 If you only want to remove the local checkout of a submodule from your
diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index bdba17d166..df682b8b10 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -123,7 +123,7 @@ See the add subcommand for the definition of default remote.
 
 deinit [-f|--force] (--all|[--] <path>...)::
 	Unregister the given submodules, i.e. remove the whole
-	`submodule.$name` section from .git/config together with their work
+	`submodule.$name` section from .git/config together with their working
 	tree. Further calls to `git submodule update`, `git submodule foreach`
 	and `git submodule sync` will skip any unregistered submodules until
 	they are initialized again, so use this command if you don't want to
diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index db88e84aaf..d3df9fed31 100644
--- a/Documentation/gitcli.adoc
+++ b/Documentation/gitcli.adoc
@@ -35,7 +35,7 @@ arguments.  Here are the rules:
 
  * When an argument can be misunderstood as either a revision or a path,
    they can be disambiguated by placing `--` between them.
-   E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
+   E.g. `git diff -- HEAD` is, "I have a file called HEAD in my working
    tree.  Please show changes between the version I staged in the index
    and what I have in the working tree for that file", not "show the difference
    between the HEAD commit and the working tree as a whole".  You can say
-- 
2.52.0-rc1-455-g30608eb744

