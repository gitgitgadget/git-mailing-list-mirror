Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E1259CAF
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227449; cv=none; b=qRmW+Z7H3egeeNDZaXyt2t+QP+JR6kmiFixxsDGpK9jojR3JcI7VhcVD8kcy9Sto+nZxFO8Aq1d32b87jUiLZdPVi2xIAEbhs56sQU4D3ZgAwhJVKIEyHiwXi7zK/T2ukZYUFdDRKHMN/2rW51cklzR31bsv2xY0QejmllSXTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227449; c=relaxed/simple;
	bh=Ts0rxyiVQWPBZulvOt/fMlJL5CZ0/8e9do7pEwR3de0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqhjINVh/JfWOwdXFBHMnJOlo5tOLb7g+wK8U1F+DcRVNEBEiB0cOlGXvFoIDlIcoH4SaOS1w2PaewBMG9EagppOaXbCE6b+nooAn+nMInjKK0G+DXt3I80mYLS3VcBa277O9m97bbdJ0043Du7xzvbX780KQM9nr1ZE42yC/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c5gpDPJC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ToYI7CEK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c5gpDPJC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ToYI7CEK"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D46C9EC0599;
	Mon, 12 Jan 2026 09:17:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 12 Jan 2026 09:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768227437;
	 x=1768313837; bh=lmMeyePlvcR4VwOjq8mdnP3WpPj2Xp8VH7QkEAJh400=; b=
	c5gpDPJCqu6rz7iUmB9sL9a103AzCznrjCoZ8j5MRcqoLie8U5m2nzI+z8S0AuWw
	st6V/z0CZX1HoiiO5m0u3w9iFmUBj9+peBYk2g1KPEUB88IYFaCCwaBgHHgHW5cR
	IN3BYbewHgF+X6bFglU5qo0OJzOBxpOeYwmGoeWK6vOvUWvG0Hdq8EKtC2BhH0kS
	qoRelcFFYkBPs/JgzCfbKuf+Be0X+Ka4Nu+YbtKyDijoEokpnLkgrgJJPbsldkeg
	xwLNv9pJ+Ohsho9FcVD4x2dcsNdnWjOuI6O2vGiDXWKmX+W/9Zj34KNx4hduK9BD
	rJVNlyh4DpkzXNz580xcRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768227437; x=
	1768313837; bh=lmMeyePlvcR4VwOjq8mdnP3WpPj2Xp8VH7QkEAJh400=; b=T
	oYI7CEKrvOp2srsMQATafoub2sjY0kJm4RuNmad7DK606KbHEw7VijCXFmQbz2t3
	xzuHzGEvoMiVQLnSHKmQlLaHvLHzOki1mRR9Z83EWs+Dbyty2dexmLvymGT+kCEi
	vzR603UMbpyQqorwBMkxYVr9LhLmnAIQWHj5nybqJ8Fwk+t1IbWP5S6Ll0yWPlG7
	AbFgWwVmxjCnp8PDPBML04CV4DpBtYe54UJpKmwmGpwSIQBj7C+40Yy34dXT04c2
	ChPd4HXt8F9ND3r1cy0Hc/2oqIz/14DQRSECf93UWhNJW72SYM9B4bVMnfYOiW4I
	GAyY48+7spHWO1zPVod+A==
X-ME-Sender: <xms:bQJlaQILezEEBjYvQ9eweFcaF-iYl-jXz7GRY8NGp-wb_OjnwP1Ngg>
    <xme:bQJlab_mUDx9bSb-MMSHA72S0lATc1xgDLriaY7rSiBRDbSWWh6rT5kc30fhKXGg-
    wIrEe1KrY0RaDEnCZfhjQxang1DCQNbhb_22t-SHuM1jgdibHuAVw>
X-ME-Received: <xmr:bQJlacESJ4CMSG_hJtRoWngTuxdBx5OQ0BNH49F9ubgrmA8qUvq3q3fLyrb2O_w0ePCSme3fBm8jCPe_kCE_cU_IbcifLDiG0PrXfF_mtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggv
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:bQJlaW6fFoapIhVotmSnj8bAJxDDs5KY-NXO4HXImLjw-1m5tynV3A>
    <xmx:bQJlaVZM0Q5cSAmvZ13Xf8kVqCbCEVIlw0bmNfpZU2Ibfo9zbObeyA>
    <xmx:bQJlaUiW-Xd0BcSbI7T55iZhWTe3TiSbObz7dNjIPMBQ6TOHjdyFDg>
    <xmx:bQJlaXe6Qhb4hwULcaogic7lGi4szzERLngrG37frapcrWaqWilRGw>
    <xmx:bQJlaeInmFAhNV8wdQjyM0moRuJTHdwntJL4UneBF-XT8ECLn1FsETUJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:17:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 34948189 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 14:17:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 15:15:17 +0100
Subject: [PATCH v10 5/8] replay: support updating detached HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-history-builtin-v10-5-e3c6aa5b4cec@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

In a subsequent commit we're about to introduce a new git-history(1)
command, which will by default work on all local branches and HEAD. This
is already well-supported by the replay machinery for most of the part:
updating branches is one of its prime use cases, and the HEAD ref is
also updated in case it points to any of the branches.

However, what's not supported yet is to update HEAD in case it is not a
symbolic ref. We determine the refs that need to be updated by iterating
through the decorations of the original commit, but we only update those
refs that are `DECORATION_REF_LOCAL`, which covers local branches.

Address this gap by also handling `DECORATION_REF_HEAD`. Note though
that this needs to only happen in case we're working on a detached HEAD.
If HEAD is pointing to a branch, then we'd already update that branch
via `DECORATION_REF_LOCAL`.

Refactor the loop that iterates through the decorations a bit to make
the individual conditions easier to understand.

Based-on-patch-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c                 | 47 +++++++++++++++++++++++++++++++++--------------
 t/t3650-replay-basics.sh |  9 +++++++++
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/replay.c b/replay.c
index a8e6d5b30b..6a8cd2f72d 100644
--- a/replay.c
+++ b/replay.c
@@ -150,11 +150,17 @@ static void get_ref_information(struct repository *repo,
 static void set_up_replay_mode(struct repository *repo,
 			       struct rev_cmdline_info *cmd_info,
 			       const char *onto_name,
+			       bool *detached_head,
 			       char **advance_name,
 			       struct commit **onto,
 			       struct strset **update_refs)
 {
 	struct ref_info rinfo;
+	int head_flags = 0;
+
+	refs_read_ref_full(get_main_ref_store(repo), "HEAD",
+			   RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
+	*detached_head = !(head_flags & REF_ISSYMREF);
 
 	get_ref_information(repo, cmd_info, &rinfo);
 	if (!rinfo.positive_refexprs)
@@ -269,12 +275,13 @@ int replay_revisions(struct rev_info *revs,
 	struct merge_result result = {
 		.clean = 1,
 	};
+	bool detached_head;
 	char *advance;
 	int ret;
 
 	advance = xstrdup_or_null(opts->advance);
-	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto, &advance,
-			   &onto, &update_refs);
+	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
+			   &detached_head, &advance, &onto, &update_refs);
 
 	/* FIXME: Should allow replaying commits with the first as a root commit */
 
@@ -312,18 +319,30 @@ int replay_revisions(struct rev_info *revs,
 		/* Update any necessary branches */
 		if (advance)
 			continue;
-		decoration = get_name_decoration(&commit->object);
-		if (!decoration)
-			continue;
-		while (decoration) {
-			if (decoration->type == DECORATION_REF_LOCAL &&
-			    (opts->contained || strset_contains(update_refs,
-								decoration->name))) {
-				replay_result_queue_update(out, decoration->name,
-							   &commit->object.oid,
-							   &last_commit->object.oid);
-			}
-			decoration = decoration->next;
+
+		for (decoration = get_name_decoration(&commit->object);
+		     decoration;
+		     decoration = decoration->next)
+		{
+			if (decoration->type != DECORATION_REF_LOCAL &&
+			    decoration->type != DECORATION_REF_HEAD)
+				continue;
+
+			/*
+			 * We only need to update HEAD separately in case it's
+			 * detached. If it's not we'd already update the branch
+			 * it is pointing to.
+			 */
+			if (decoration->type == DECORATION_REF_HEAD && !detached_head)
+				continue;
+
+			if (!opts->contained &&
+			    !strset_contains(update_refs, decoration->name))
+				continue;
+
+			replay_result_queue_update(out, decoration->name,
+						   &commit->object.oid,
+						   &last_commit->object.oid);
 		}
 	}
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 307101eeb9..c862aa39f3 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -249,6 +249,15 @@ test_expect_success 'using replay on bare repo to rebase multiple divergent bran
 	done
 '
 
+test_expect_success 'using replay to update detached HEAD' '
+	current_head=$(git branch --show-current) &&
+	test_when_finished git switch "$current_head" &&
+	git switch --detach &&
+	test_commit something &&
+	git replay --ref-action=print --onto HEAD~2 --ref-action=print HEAD~..HEAD >updates &&
+	test_grep "update HEAD " updates
+'
+
 test_expect_success 'merge.directoryRenames=false' '
 	# create a test case that stress-tests the rename caching
 	git switch -c rename-onto &&

-- 
2.52.0.590.g1f87b77810.dirty

