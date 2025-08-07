Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE211D7E26
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591817; cv=none; b=cdImqHy4FhFXcXlxwuPKnE+cNmX6JtC++VSYBLAJZk5p3A4vtXAAEhW+Ek3xu4kcnWcjxdnYSCtXnn+DAzq436MIiyx/0/M31LgYpLckkcWovxbHptVGMVNC1fvOUxU8T/kN0oY8YsKqJ/IbJkrjdygFUSQ8S9ExYhDeJrz7208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591817; c=relaxed/simple;
	bh=D8dv9GQDACXbWVWo11OiTcjuZwiXRyXCDRMy7dCMMWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NdT4FuyV74V5IsOnrSHIXxZjStkiOWzypvpx6Qu8n/ibb/r6KlmoHjQkRVzz1bMRtLAdLdTXWN+MuN//flw/ZOcqyXh/cTARXF6a3o1FNyun3+2dKoFCK0MHDSd7R1zaRc9OAUnGaTWsnxDmOfT8eW19uD5A4Q+pfHpZBkjeIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DkuSGAPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1EnevBX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DkuSGAPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1EnevBX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4519D14001DD;
	Thu,  7 Aug 2025 14:36:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 07 Aug 2025 14:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754591813; x=1754678213; bh=R7E0xLN0Oc
	fAf58K6uDFDlsLAdr0Iq4Fa/9EBPG7+iY=; b=DkuSGAPY+ec5PE47SfdLQspIdz
	FzEwV9cNluTuRBYn/fSjhn3tk8TMvVqLUd7jZpci7EWhNLODvj3jpbFHVwMGebVU
	7+keMKQ3QA5dH7XNIx1UUhVwb6rriJ+K6sYkjqbIcpE8iEGTf1Wyta2dyF5MYZf4
	A5IS5Di4Nhu7/KCGcNM5EfOm/7SNuD7CNc0x/QIiF8S/JO5bcAmTm4mnvVqiIoZH
	4FwAXHBt6EqTw6EHp54ykTinh7c5qfygm4UOnAevxGYxy+GapMEafEj2rbtyMtQV
	L78RuUhm+HDjW24zrcsTEjfJHxFYFUkafVjlFtUUOT0wuy6YexoibAWKzb1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754591813; x=1754678213; bh=R7E0xLN0OcfAf58K6uDFDlsLAdr0Iq4Fa/9
	EBPG7+iY=; b=c1EnevBXR16zHKQ3Bp5KU5maNQnsJYqmj1u6G6GuONMaPjqKBKM
	ye7WtomE8LhKBTMhtUqlvgp6DqKbGQ2U+H9jNF9fVZYLmDbh8k5QiPur2GsMbxCZ
	Uk92aGwmBeHzxMHeOEHqIUrVsaIIW7H1AFx1WfABOPomuGGbnUx59Ztx6eGWSOC+
	I7kId1P0Z7Z9vT0h3AjKzcgewHRMp2mYxQVO9v8xcZf7/KIG3Y2jvYRXGrNUVjms
	py0WEcAtFmeNudgMXXPOxRrfEzch/qAUkNkP9vg14+OO6byjHvg7pMkA0BGCOHyA
	Ihq4JQPVpbgJAtS8SBe+sS0phTQCl4ybebg==
X-ME-Sender: <xms:RPKUaCEBaZ-jGzkXruMtObvimWOhKZJf4BhKDE4AO5rIK5qcNUHfOg>
    <xme:RPKUaGkpoxNfM1JqAxYTR5Eg7A2HgKgvxuFLFVniSHjks6J7Z3VxJ4GUfIMIyQU2W
    Pv5XVoFZGNfvUsKrA>
X-ME-Received: <xmr:RPKUaFl7Qxfgx_dqx-EVx0VNDQwuqI1XP4AklPUEA8kjRUsa4W7zI4vMg6z6eDM5-4cq4KXL6ALXE_hSHjDpNUYPQ7tw71Y7Fb3zoiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeevgeduteduffejkeelvdeikedvvd
    ehkeeuueehtddtjeevfeekkeethffgheeuteenucffohhmrghinhepughifhhfrdgtfien
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehophgvnhhsohhurhgtvgesghhrvghgohhirhgvghgvrdhish
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RPKUaHv2-tbfkq69Cl3Xrz_HNxWS-tKPpgpj-b2_XO-kuDx1vBSA5Q>
    <xmx:RPKUaIn1QvApRmyBMDggixyGufNUfmJ51Zr0IaAPvX19YWXfnOEuIQ>
    <xmx:RPKUaCurOgtOO8uHJySWWliNLcrH3REpP-9Uy972ThYtVSIVJHyx3Q>
    <xmx:RPKUaOdDlvbwyWbLw4lpCHc1v1OZSlKt3SZjKa8ikao41qHVGX_WvA>
    <xmx:RfKUaOUjZAGAxPuk6w3QoVD4OdWIk_7LOpX93QEtdIYy3JGsyEjKFEw4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 14:36:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gregoire Geis <opensource@gregoirege.is>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] diff-no-index: fix stdin path in subdirectory
In-Reply-To: <20250807150613.32177-1-opensource@gregoirege.is> (Gregoire
	Geis's message of "Fri, 8 Aug 2025 00:06:13 +0900")
References: <20250807150613.32177-1-opensource@gregoirege.is>
Date: Thu, 07 Aug 2025 11:36:51 -0700
Message-ID: <xmqqtt2jm118.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gregoire Geis <opensource@gregoirege.is> writes:

> `git diff --no-index` tried to normalize paths before printing them,
> skipping a prefix before reading a string. However, `-` doesn't start
> with this prefix, leading to a buffer overflow:

Thanks for a report, but ...

> I noticed that running `git diff --no-index /dev/null -` in a
> subdirectory leads to garbage file names (instead of `a/-` and `b/-`).

... there fundamentally is something wrong here.  Why does the code
even need to "strip" the "prefix" in the first place?  Once the user
said "git diff --no-index", there is no concept of "subdirectory"
anymore.  The user just told Git to pretend as if it is operating
outside any Git-controlled working tree, so whereever you are is
your current directory, and you would never be "in a subdirectory"
of anything to begin with.  But apparently diff_no_index() code is
pretending as if it is part of Git proper and doing the prepend and
strip the prefix dance.

Would something more direct like the attached patch work?

--- >8 ---
Subject: diff: --no-index should ignore the worktree

The act of giving "--no-index" tells Git to pretend that the current
directory is not under control of any Git index or repository, so
even when you happen to be in a Git controlled working tree, where
in that working tree should not matter.

But the start-up sequence tries to discover the top of the working
tree and chdir(2)'s there, even before Git passes control to the
subcommand being run.  When diff_no_index() starts running, it
starts at a wrong (from the end-user's point of view who thinks "git
diff --no-index" is merely a better version of GNU diff) directory,
and the original directory the user started the command is at
"prefix".

Because the paths given from argv[] have already been adjusted to
account for this path shuffling by prepending the prefix, and
showing the resulting path by stripping the prefix, the effect of
these nonsense operations (nonsense in the context of "--no-index",
that is) is usually not observable.

Except for special cases like "-", where it is not preprocessed by
prepending the prefix.

Instead of papering over by adding more special cases only to cater
to the no-index codepath in the generic code, drive the diff
machinery more faithfully to what is going on.  If the user started
"git diff --no-index" in directory X/Y/Z in a working tree
controlled by Git, and the start up sequence of Git chdir(2)'ed up
to directory X and left Y/Z in the prefix, revert the effect of the
start up sequence by chdir'ing back to Y/Z and emptying the prefix.

Reported-by: Gregoire Geis <opensource@gregoirege.is>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * After we worked on our own "diff" enhancements like rename
   detecion, colored output, etc., we thought it may make the world
   a better place if we gave non-Git using people the benefit of our
   "diff" implementation.  The correct thing to back then do may
   have been to give patches to integrate our extended diff code to
   diff implementations of other people (like GNU), but we took the
   lazy route to bolt the code to slurp two sets of paths to compare
   out of filesystem files on to our own diff implementation.  After
   fixing many fallouts from this impedance-mismatched code, it is
   not surprising that a bug like this still remained.

 builtin/diff.c           | 14 ++++++++++++++
 t/t4053-diff-no-index.sh | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git c/builtin/diff.c w/builtin/diff.c
index 9a89e25a98..3eb4cbb057 100644
--- c/builtin/diff.c
+++ w/builtin/diff.c
@@ -487,6 +487,20 @@ int cmd_diff(int argc,
 
 	init_diff_ui_defaults();
 	repo_config(the_repository, git_diff_ui_config, NULL);
+
+	/*
+	 * If we are ignoring the fact that our current directory may
+	 * be part of a working tree controlled by a Git repository to
+	 * pretend to be a "better GNU diff", we should undo the
+	 * effect of the setup code that did a chdir() to the top of
+	 * the working tree.  Where we came from is recorded in the
+	 * prefix.
+	 */
+	if (no_index && prefix) {
+		chdir(prefix);
+		prefix = NULL;
+	}
+
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
 	repo_init_revisions(the_repository, &rev, prefix);
diff --git c/t/t4053-diff-no-index.sh w/t/t4053-diff-no-index.sh
index 01db9243ab..44b4b13f5d 100755
--- c/t/t4053-diff-no-index.sh
+++ w/t/t4053-diff-no-index.sh
@@ -26,6 +26,23 @@ test_expect_success 'git diff --no-index directories' '
 	test_line_count = 14 cnt
 '
 
+test_expect_success 'git diff --no-index with -' '
+	cat >expect <<-\EOF &&
+	diff --git a/- b/-
+	new file mode 100644
+	--- /dev/null
+	+++ b/-
+	@@ -0,0 +1 @@
+	+frotz
+	EOF
+	(
+		cd a &&
+		echo frotz |
+		test_expect_code 1 git diff --no-index /dev/null - >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git diff --no-index relative path outside repo' '
 	(
 		cd repo &&
