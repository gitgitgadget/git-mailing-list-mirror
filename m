Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0943B27F7
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333122; cv=none; b=BSq7JOEI5yJtxFvvHehd1TqFSiSRnMf6/U89aEBD17VmQ2wsz52HupJ+okhx0mXNuHHvwKpT6Uqqs8cuOzR4ZvpYOztcupeohsyFUAlwuu5eh7k8NT2XVb2xfreJj8Nl4xpjErJbCHZg5YIWGcEUTWMaUbEEMpb77O6mDnW0XTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333122; c=relaxed/simple;
	bh=OAZOg3yo/3jWRn1e5thZlKJ9RfZHgfyAZ0T7jeXj5p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=dQLIkye46EehmkcQ1UJfRo4MBJWXZg9DK1rFBbhpy1v6YJya8+NoxbD66rSOnuJ/i+a43jyA5d1nyyMw5uUWeRKMBO//5/m9zyC483QXqsrhhsheC6OR1jc0Oo687WhpUvXbpa/4+uR1xcnLr5FyIMZ3zA1QtAxSKLm6NlhGdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jhpYVGw7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHLRKSJ4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jhpYVGw7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHLRKSJ4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 62648EC00A1;
	Tue, 24 Mar 2026 02:18:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Mar 2026 02:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774333113;
	 x=1774419513; bh=rXZ4kijBthlNDVzsYBOkIz9zjCfMUo0zBayU/LRh/9M=; b=
	jhpYVGw76GEfQQtA1yUatMBeq847d6pGVgqKw7d+SEsXJ7d9m96lbkXjpZBHgshr
	R3L8QntkPMc9XenrgKCvIHg94TMqCr6njYXZshvYUx5VIpw48+nHk6XFoB9vN91a
	z0GVjpahDvVnj6dbZrzEOomPOtST+SWITjdQaBqhyqhr5WmWYagIQ6ioCHgk78mS
	HQVRt+r7FNcI1rM9a83nK4gwEvOW46PZULaBrXsbxI3gceVbDKQY3ugj4TTEqjYp
	tO0/I2Ho/h7bPgs4kQYWQX9jCpcZVPCIAN8pmYpmwL/TQKz0DiY2jMUSSXYIk9qn
	1uFJVEqzKdvFyn/81J4U5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774333113; x=
	1774419513; bh=rXZ4kijBthlNDVzsYBOkIz9zjCfMUo0zBayU/LRh/9M=; b=D
	HLRKSJ49PEMkZJH6vt1DqfN9iR1YXsT9nsczTx8FN99db6uinX4FZTHaM8wqqKsD
	BtUBn7T5J5EaxfMydqNZ9W49xkBEl43YQwp2ZOV8EdLBJucLdClEncmYZhL4Tdhb
	A549YcnwTvUGzplFZPS8GFmh7E/PWqG4ev9vpJNeGhn9aCXspbNfanyQz5wvReRF
	kLs2lrAuaPaO3MGADZMF2Lx3trHsNgMrdzDg/Vu2Vh4miCqC5rPeVouKH16ESTwr
	8XgUtvXOnulR6Sgb7zFw2c19C5w7KYazZ18jzNY+xEJYVsQsCmDTJ+RbnVHBlJlz
	nkfV8Nnn8QaDWlrfn8naA==
X-ME-Sender: <xms:uSzCaZU-c-BDBWP420vOsMsPg7ZGfTiTTwjZlKwWNS6PBe9af_Zjsw>
    <xme:uSzCaRB7ebSwmgwojs7r2AYtYdOp26twZ6qBC8bqWstTkGb6QW-7jTsZtcgJfkVJK
    jT-YskGJ3bXGukXSNLjb9sN86tzg6nMB0rogTToA8bcld85E7Sn>
X-ME-Received: <xmr:uSzCaSzOh4O7vCZ9DDJkdWPK-2iRTDZwvNEsYjkjZqDN4zPF03iPLwYpCPTgDClhlW7nyZfeYfAX9qUeyKZL5VlaZ3bgvecgit6oR3BsB1ZJng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtveeuveevueevffduieetheegveekjeefjefhheettddvgfdtgfehieefkefftden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uSzCaWDUaCU-KkJzRgB30LOa9EB271ftmLR9QyS9sFimIqR6W3xg3g>
    <xmx:uSzCaXYoUo_yN3JI3c-fe5n8o3Wh-9AU9nrJLhgT0gv_ksaiyU4g1w>
    <xmx:uSzCaWi_roHjdq9eDW5lgaHMrLMJlEOlH28d4wT4sLgaWkpxLBkjuQ>
    <xmx:uSzCaR75EUnnm17h8h0XPwKz0ejWE67SqtkPF2BhMJaOoMGlEqwFtQ>
    <xmx:uSzCaVCZGcoI7qdGGoI8II4WC3SahK-HsUnGfYP9M_l2ypZ4nUiwoNcV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 02:18:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9537443 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 06:18:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Mar 2026 07:18:26 +0100
Subject: [PATCH v2] commit-graph: fix writing generations with dates
 exceeding 34 bits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>
X-B4-Tracking: v=1; b=H4sIALEswmkC/42NQQ6CMBBFr0Jm7Rg6xCquvIdhAWVKJwolLakaw
 t2tnMDl+/n//RUiB+EI12KFwEmi+CkDHQowrp0GRukzA5Wky0qdcX5ENH4cZcEhtLNDnzjYp39
 hWZvKdprpVLeQ93NgK+/dfW8yO4mLD5/9Kqlf+o81KVTIumMmMv2F9C13jzJCs23bF24cjCG/A
 AAA
X-Change-ID: 20260317-pks-commit-graph-overflow-09c3fb6e259a
In-Reply-To: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im>
References: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.3

The `timestamp_t` type is declared as `uintmax_t` and thus typically has
64 bits of precision. Usually, the full precision of such dates is not
required: it would be comforting to know that Git is still around in
millions of years, but all in all the chance is rather low.

We abuse this fact in the commit-graph: instead of storing the full 64
bits of precision, committer dates only store 34 bits. This is still
plenty of headroom, as it means that we can represent dates until year
2514. Commits which are dated beyond that year will simply get a date
whose remaining bits are masked.

The result of this is somewhat curious: the committer date will be
different depending on whether a commit gets parsed via the commit-graph
or via the object database. This isn't really too much of an issue in
general though, as we don't typically use the date parsed from the
commit-graph in user-facing output.

But with 024b4c9697 (commit: make `repo_parse_commit_no_graph()` more
robust, 2026-02-16) it started to become a problem when writing the
commit-graph itself. This commit changed `repo_parse_commit_no_graph()`
so that we re-parse the commit via the object database in case it was
already parsed beforehand via the commit-graph.

The consequence is that we may now act with two different commit dates
at different stages:

  - Initially, we use the 34-bit precision timestamp when writing the
    chunk generation data. We thus correctly compute the offsets
    relative to the on-disk timestamp here.

  - Later, when writing the overflow data, we may end up with the
    full-precision timestamp. When the date is larger than 34 bits the
    result of this is an underflow when computing the offset.

This causes a mismatch in the number of generation data overflow records
we want to write, and that ultimately causes Git to die.

Introduce a new helper function that computes the generation offset for
a commit while correctly masking the date to 34 bits. This makes the
previously-implicit assumptions about the commit date precision explicit
and thus hopefully less fragile going forward.

Adapt sites that compute the offset to use the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this fixes a regression recently introduced by myself in 024b4c9697
(commit: make `repo_parse_commit_no_graph()` more robust, 2026-02-16).
The regression was found by GitLab's tests suite, see [1].

Changes in v2:
  - Account for platforms where `timestamp_t` has 32 bit precision. This
    matches logic in `write_graph_chunk_data()`, where we also depend on
    the size of the commit timestamps.
  - Link to v1: https://lore.kernel.org/r/20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/gitlab/-/jobs/13522328632
---
 commit-graph.c          | 37 ++++++++++++++++++++++++++++++++++---
 t/t5318-commit-graph.sh | 20 ++++++++++++++++++++
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f8e24145a5..cb514bfb60 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1319,6 +1319,37 @@ static int write_graph_chunk_data(struct hashfile *f,
 	return 0;
 }
 
+/*
+ * Compute the generation offset between the commit date and its generation.
+ * This is what's ultimately stored as generation number in the commit graph.
+ *
+ * Note that the computation of the commit date is more involved than you might
+ * think. Instead of using the full commit date, we're in fact masking bits so
+ * that only the 34 lowest bits are considered. This results from the fact that
+ * commit graphs themselves only ever store 34 bits of the commit date
+ * themselves.
+ *
+ * This means that if we have a commit date that exceeds 34 bits we'll end up
+ * in situations where depending on whether the commit has been parsed from the
+ * object database or the commit graph we'll have different dates, where the
+ * ones parsed from the object database would have full 64 bit precision.
+ *
+ * But ultimately, we only ever want the offset to be relative to what we
+ * actually end up storing on disk, and hence we have to mask all the other
+ * bits.
+ */
+static timestamp_t compute_generation_offset(struct commit *c)
+{
+	timestamp_t masked_date;
+
+	if (sizeof(timestamp_t) > 4)
+		masked_date = c->date & (((timestamp_t) 1 << 34) - 1);
+	else
+		masked_date = c->date;
+
+	return commit_graph_data_at(c)->generation - masked_date;
+}
+
 static int write_graph_chunk_generation_data(struct hashfile *f,
 					     void *data)
 {
@@ -1329,7 +1360,7 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 		struct commit *c = ctx->commits.items[i];
 		timestamp_t offset;
 		repo_parse_commit(ctx->r, c);
-		offset = commit_graph_data_at(c)->generation - c->date;
+		offset = compute_generation_offset(c);
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
@@ -1350,7 +1381,7 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
 	int i;
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.items[i];
-		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		timestamp_t offset = compute_generation_offset(c);
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
@@ -1741,7 +1772,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.items[i];
-		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		timestamp_t offset = compute_generation_offset(c);
 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
 			ctx->num_generation_data_overflows++;
 	}
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 98c6910963..1c40f904f8 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -417,6 +417,26 @@ test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow ch
 	test_cmp full/.git/objects/info/commit-graph commit-graph-upgraded
 '
 
+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'overflow chunk when replacing commit-graph' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >commit <<-EOF &&
+		tree $(test_oid empty_tree)
+		author Example <committer@example.com> 9223372036854775 +0000
+		committer Example <committer@example.com> 9223372036854775 +0000
+
+		Weird commit date
+		EOF
+		commit_id=$(git hash-object -t commit -w commit) &&
+		git reset --hard "$commit_id" &&
+		git commit-graph write --reachable &&
+		git commit-graph write --reachable --split=replace &&
+		git log
+	)
+'
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the

---
base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
change-id: 20260317-pks-commit-graph-overflow-09c3fb6e259a

