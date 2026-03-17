Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B820ED
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774193; cv=none; b=FCcOx0XLUMeinS/ljuU41vs6fnItQNjYZAO+RF2Jp7kwfBL5Pt6YSsH8U6pwZwCy5O8j8Pu3rPhjVz7A7WtxyV5v3kalJyzHQ9DKgkNqXGeBERV1pbmBBwl9qBmncY+yvOcxXHAGgIZpdaMPZv5EjmkFR3EZ2exPKHNMugmAhcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774193; c=relaxed/simple;
	bh=VuPbkjh4WacqdO1CtXSLTW9H6UZ6int+WQuJ82aNSjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DROAl0p6TfIhb3jFRCpUJg/QOhfwNpuh3TaVddQKsJgOVhKJOt7Wcr+M6sBgQzxnwK5KuLUygXPCt1kY53iJhhdoLu2GkzjjP05IdG0FqnQBbqQH4zlWXpBr7smacPcnGvSGB6ELdCBE8ZOLotW7khp5CFSdkIMjdI5ZZF/96Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cU2qDxhO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bKl5xtF9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cU2qDxhO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKl5xtF9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8573F1400224
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 15:03:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 15:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1773774191; x=1773860591; bh=SuWfGOzr3O
	tVfm6MFQ/OkCyNB5ShTpAyYxdoO8sIJao=; b=cU2qDxhOQtBK3JECKjTlBiQxqV
	+Vt8+fEx0hriLcxJJ+rslnkphgtzqOihllYALdlTOrDhMVd7peMIJwZtml4i3N3u
	PnXrsia+OOR/WjbcMRrAHH+Us2TVbyg9eI9d4zywbgEmJuZVS+DD9efTme8BxYMa
	dBPek4qu6IgVgbyBlj/c+eMvcjGkK7zIDxWvuplt4U1Sv8OGOnpMrWOrrvcQK6lW
	riTt+GDQj/nqSuRbgEeKN3XKdI2FeuPgCZxcTNag+A5UqugKiC4SqDmyEncd7s2p
	ru6ri5jrHizNisGSXKCNctNQ0yRVwYJ5LE+QAWpTVHBnTJU1n5BrCgptTmjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773774191; x=1773860591; bh=SuWfGOzr3OtVfm6MFQ/OkCyNB5Sh
	TpAyYxdoO8sIJao=; b=bKl5xtF96FrS1/+wlBj/A5zNvgcrfJHBNhNL0PEXIzrx
	kF988oQwZt58J7IUYOCn0bdsK6uQPZSWJzuGSsNJUF+FJ+lxdFm+mvCcnycGwAgt
	YsBjwzz6/yjl3n5yZHopGyh/cMb3BZhiUbjC/2qrTrbpcjUgxNfGlIWpXYqD1DeX
	N/WO6ZAXYvsaFxtmm3lBl5qzNuRTp3TfrnyuXmMFWAf12lac1fN+qx0EAEWeb486
	GDK1KE2cDCxMZPVfbnkqlE1qDzPIyI4TxLBlYSze6qgPN2Zh6gUo75DF4okd8WWO
	18UleEgWQGNREFM0bjyEIptsL8bIV3powu+XuVDtEg==
X-ME-Sender: <xms:b6W5aSp-lRhJxOnTkCsocV9M-FsdF8ifs00ar3-qacuqt9c6nxGuVA>
    <xme:b6W5aXmIWCgC7ti5pdGvqHETb1DWICbCHsdiBLMr-kaxP8S-nZuhF9jNmh2ZnfkbP
    7D_CFMD7fKcxpJbly_0o26Lmip4RGjNjRc5x01oby7TOQKs0cmZ1w>
X-ME-Received: <xmr:b6W5ac08_fH-QX0Lc-qtcQNlYzi5mZCqUld2VV6AyDzmUlLVoEq3Pc9W1zR6uCxViX0LEJbQD0zvbbBvoBCjOkIg9RyXTvdmzlHcdqxbr9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedvgedvleejvdefkeetieejheelledtvefgteffffeuvddtvddtffeikefhvedv
    gfenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:b6W5aXCS5Mj2jZAatJQ1DdpXr0vMhmTndZpsg6jD79xAJxzDht0e5A>
    <xmx:b6W5aRzvR6VjdrwUUUipa-CGRaAeTIUu1zbDcDH_ZWIyXH5fjV7Ntg>
    <xmx:b6W5adnj7ncithH7oc_QQShvRTylxaz9ak6kbT8hxJKxB-TaXPELLQ>
    <xmx:b6W5aeECd_q8RnLfO4kHusVHRLa4gU8Ymip5gGvu1aXcT-bj_midPA>
    <xmx:b6W5aeJd4odDPStN3XFB6seTu_GnbZbxIcJfI2g9Z8g5rEKcoxjB0ApJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Mar 2026 15:03:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c77fc64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Mar 2026 19:03:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Mar 2026 20:02:52 +0100
Subject: [PATCH] commit-graph: fix writing generations with dates exceeding
 34 bits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im>
X-B4-Tracking: v=1; b=H4sIAFuluWkC/x3MTQqEMAxA4atI1hOoFRXnKsMsak01+NOSShXEu
 1tcfov3LogkTBG+xQVCiSP7LaP8FGAns42EPGSDVrpRVdlimCNav6684ygmTOgTiVv8gaqzles
 b0nVnIPdByPH5vn//+34AR+kqimsAAAA=
X-Change-ID: 20260317-pks-commit-graph-overflow-09c3fb6e259a
To: git@vger.kernel.org
Cc: 
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

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/gitlab/-/jobs/13522328632
---
 commit-graph.c          | 31 ++++++++++++++++++++++++++++---
 t/t5318-commit-graph.sh | 20 ++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f8e24145a5..7e293a1775 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1319,6 +1319,31 @@ static int write_graph_chunk_data(struct hashfile *f,
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
+	timestamp_t masked_date = c->date & (((timestamp_t) 1 << 34) - 1);
+	return commit_graph_data_at(c)->generation - masked_date;
+}
+
 static int write_graph_chunk_generation_data(struct hashfile *f,
 					     void *data)
 {
@@ -1329,7 +1354,7 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 		struct commit *c = ctx->commits.items[i];
 		timestamp_t offset;
 		repo_parse_commit(ctx->r, c);
-		offset = commit_graph_data_at(c)->generation - c->date;
+		offset = compute_generation_offset(c);
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
@@ -1350,7 +1375,7 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
 	int i;
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.items[i];
-		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		timestamp_t offset = compute_generation_offset(c);
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
@@ -1741,7 +1766,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 
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

