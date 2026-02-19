Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56394C8E6
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488799; cv=none; b=ZwX4J1uwxSUwh3gSqRIs+D+tO7YUUpVX/ltWrxjKbrEN5w2+he2DN78C08Zu5HGrVlS15imD9nXMmLFdh+0ziOicsFUSXHLMVG5KETEvimQ1ha6o5Zwrj0e31p+ctRR+q0OhcoVFzXb1sliH3EOSo/MHbueSJsd/KxQS95tm3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488799; c=relaxed/simple;
	bh=ffMRfkNQxkntbv34TGHuT7x05BoEMiCp9lRMzGn0e+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3H/V/jhRDM9CoX7tDIhVQxrFd1hTQRCqdJ1Yvok3TxdEomNl8WN0LlUQguZPDSku9Iya9Vf2zbPyLp/W2ALNULDqYSO7JRQaZUs+9LWVTNIQw+45nMeXay+EG80Bm9Xt0MdxjSls2YddQnZboC/jnALinxpQAgPIKHB57jFcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fztSurZw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sa40ccqD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fztSurZw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sa40ccqD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 739B2EC0572;
	Thu, 19 Feb 2026 03:13:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 03:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771488796;
	 x=1771575196; bh=ayHj3vROBR9DY+Lnc+9qSzj9pjHIyUL+PdHKECq2Ryg=; b=
	fztSurZwCtvKST92QdHk/P0vR15mjizRvSrf0p4woIky3ofPtzhWqi1fmCz6LZL6
	HNoobwZ4moHGkTzlbMBkelq6IJiPXBxBMBBDPz4OYoIUvZlI9JzNYUstJakpQd+3
	2euRLYOhS2r1iGNUK8qIv/2vq+c5lqBjaD3Wms4ELFAjDvGsGMVqBitx0BRUYQ57
	oxybnSFw3OEndFM/aj/uOozHj7P9SL+3l2Dmd2RP9V31kChnAWv1bfmy8NVjwbdP
	G6Va7NVe4WUCobBe7vXH46TRczqbxKR8ohhXQjABvIrwMbs1duUcVjW9fJFc3HVm
	p3/LzE4n0+fPiS8UthzeRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771488796; x=
	1771575196; bh=ayHj3vROBR9DY+Lnc+9qSzj9pjHIyUL+PdHKECq2Ryg=; b=s
	a40ccqDLV9IJdV3js8U16NBAir4c4Fs6PTNxWWZmipewehVMgsyZwh9ZD7JvihX5
	yDk7iF+T/+GwNud9JwU5R3l8i2sIMTqTY3adjSFmtlGGv+NsNeuQaanY4q6Xqoft
	U4a2vQOwsjV11aSGyOMm74TcQ2RkljMpnw+Fp9hjTV8xa45AFyQnKuX8fhvpwpp1
	dnBCRMPC9nERVumqBgGkjy5I9VYOyB2XnO2ZF6xUsvQkAR6vnNlIHCuv2h9TnCJ0
	aRL3Sw1lw0drmfZo3UplUv5fyZy2X+40mwEv6PUpy68ZC+z2M+/83tfBpEExqfZa
	kp0iGXcfM2noFuRLwb8MA==
X-ME-Sender: <xms:HMaWabZ7YSn57GGzbtMzD6FSBnZb0SjbGleAer_FNGK4H4YlDN5HgQ>
    <xme:HMaWaRbxnXZjDbo9hlJti55xI0MyXle1ae155YKnEe663IP5hemerfba8mGIklLz4
    IzKSO5SyLsqZ6NUoG0BE9nyL-xdGOip1ff5TNbX62AhYTNrcX5MAlQ>
X-ME-Received: <xmr:HMaWaS94CyrwQF40d6o45CEjr3k47Mxuhzgn4Uw5xnt1VycvdLTsPU7NOs13Tg9LVXx3QecUsbaGG9QBxL2CPvclZWVD8u0FT3G4HQhfBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:HMaWaQh0UJuHVlyIr80hTlj3X_fOjpI9DMl3D1UTx57S4tL_3Vkuxw>
    <xmx:HMaWaSfNIf5ywCm9IjSUon29SUo1k_G-Ky_4w4iRv3q8WXIGNDIJPA>
    <xmx:HMaWaXqxP9Oiq5pJKVKB_sk_PMbz-_gV9OLSZsKQqy2kLD99AExhTw>
    <xmx:HMaWaXBA9RuYjNofAQxSgGdKTC18rt0EVCsQGHcWRdX3wGvd9st3sg>
    <xmx:HMaWaScPFqUGWIgfgsUxar0Np_misiUVZiRz-be00zdtONMv21coHlz->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 03:13:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8518d37f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 08:13:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 08:57:50 +0100
Subject: [PATCH v4 2/4] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-2-57ac30172fae@pks.im>
References: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
In-Reply-To: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

The "pack.preferBitmapTips" configuration allows the user to specify
which references should be preferred when generating bitmaps. This
option is typically expected to be set to a reference prefix, like for
example "refs/heads/".

It's not unreasonable though for a user to configure one specific
reference as preferred. But if they do, they'll hit a `BUG()`:

    $ git -c pack.preferBitmapTips=refs/heads/main repack -adb
    BUG: ../refs/iterator.c:366: attempt to trim too many characters
    error: pack-objects died of signal 6

The root cause for this bug is how we enumerate these references. We
call `refs_for_each_ref_in()`, which will:

  - Yield all references that have a user-specified prefix.

  - Trim each of these references so that the prefix is removed.

Typically, this function is called with a trailing slash, like
"refs/heads/", and in that case things work alright. But if the function
is called with the name of an existing reference then we'll try to trim
the full reference name, which would leave us with an empty name. And as
this would not really leave us with anything sensible, we call `BUG()`
instead of yielding this reference.

One could argue that this is a bug in `refs_for_each_ref_in()`. But the
question then becomes what the correct behaviour would be:

  - Do we want to skip exact matches? In our case we certainly don't
    want that, as the user has asked us to generate a bitmap for it.

  - Do we want to yield the reference with the empty refname? That would
    lead to a somewhat weird result.

Neither of these feel like viable options, so calling `BUG()` feels like
a sensible way out. The root cause ultimately is that we even try to
trim the whole refname in the first place. There are two possible ways
to fix this issue:

  - We can fix the bug by using `refs_for_each_fullref_in()` instead,
    which does not strip the prefix at all. Consequently, we would now
    start to accept all references that start with the configured
    prefix, including exact matches. So if we had "refs/heads/main", we
    would both match "refs/heads/main" and "refs/heads/main-branch".

  - Or we can fix the bug by appending a slash to the prefix if it
    doesn't already have one. This would mean that we only match
    ref hierarchies that start with this prefix.

While the first fix leaves the user with strictly _more_ configuration
options, we have already fixed a similar case in 10e8a9352b (refs.c:
stop matching non-directory prefixes in exclude patterns, 2025-03-06) by
using the second option. So for the sake of consistency, let's apply the
same fix here.

Clarify the documentation accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/pack.adoc |  9 +++++----
 pack-bitmap.c                  | 13 ++++++++++++-
 t/t5310-pack-bitmaps.sh        | 41 ++++++++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh    | 43 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index 75402d5579..fa997c8597 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -160,12 +160,13 @@ pack.usePathWalk::
 	processes. See linkgit:git-pack-objects[1] for full details.
 
 pack.preferBitmapTips::
+	Specifies a ref hierarchy (e.g., "refs/heads/"); can be
+	given multiple times to specify more than one hierarchies.
 	When selecting which commits will receive bitmaps, prefer a
-	commit at the tip of any reference that is a suffix of any value
-	of this configuration over any other commits in the "selection
-	window".
+	commit at the tip of a reference that is contained in any of
+	the configured hierarchies.
 +
-Note that setting this configuration to `refs/foo` does not mean that
+Note that setting this configuration to `refs/foo/` does not mean that
 the commits at the tips of `refs/foo/bar` and `refs/foo/baz` will
 necessarily be selected. This is because commits are selected for
 bitmaps from within a series of windows of variable length.
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2f5cb34009..1c93871484 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3328,15 +3328,26 @@ void for_each_preferred_bitmap_tip(struct repository *repo,
 {
 	struct string_list_item *item;
 	const struct string_list *preferred_tips;
+	struct strbuf buf = STRBUF_INIT;
 
 	preferred_tips = bitmap_preferred_tips(repo);
 	if (!preferred_tips)
 		return;
 
 	for_each_string_list_item(item, preferred_tips) {
+		const char *pattern = item->string;
+
+		if (!ends_with(pattern, "/")) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s/", pattern);
+			pattern = buf.buf;
+		}
+
 		refs_for_each_ref_in(get_main_ref_store(repo),
-				     item->string, cb, cb_data);
+				     pattern, cb, cb_data);
 	}
+
+	strbuf_release(&buf);
 }
 
 int bitmap_is_preferred_refname(struct repository *r, const char *refname)
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6718fb98c0..310b708c5c 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -466,6 +466,47 @@ test_bitmap_cases () {
 		)
 	'
 
+	test_expect_success 'pack.preferBitmapTips interprets patterns as hierarchy' '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+
+			# Create enough commits that not all will receive bitmap
+			# coverage even if they are all at the tip of some reference.
+			test_commit_bulk --message="%s" 103 &&
+			git log --format="create refs/tags/%s/tag %H" HEAD >refs &&
+			git update-ref --stdin <refs &&
+
+			# Create the bitmap.
+			git repack -adb &&
+			test-tool bitmap list-commits | sort >commits-with-bitmap &&
+
+			# Verify that we have at least one commit that did not
+			# receive a bitmap.
+			git rev-list HEAD >commits.raw &&
+			sort <commits.raw >commits &&
+			comm -13 commits-with-bitmap commits >commits-wo-bitmap &&
+			test_file_not_empty commits-wo-bitmap &&
+			commit_id=$(head commits-wo-bitmap) &&
+			ref_without_bitmap=$(git for-each-ref --points-at="$commit_id" --format="%(refname)") &&
+
+			# When passing the full refname we do not expect a
+			# bitmap to be generated, as it should be interpreted
+			# as if a slash was appended to the pattern.
+			git -c pack.preferBitmapTips="$ref_without_bitmap" repack -adb &&
+			test-tool bitmap list-commits >after &&
+			test_grep ! "$commit_id" after &&
+
+			# But if we pass the parent directory of the ref we
+			# should see a bitmap.
+			ref_namespace=$(dirname "$ref_without_bitmap") &&
+			git -c pack.preferBitmapTips="$ref_namespace" repack -adb &&
+			test-tool bitmap list-commits >after &&
+			test_grep "$commit_id" after
+		)
+	'
+
 	test_expect_success 'complains about multiple pack bitmaps' '
 		rm -fr repo &&
 		git init repo &&
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index faae98c7e7..449353416f 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1345,4 +1345,47 @@ test_expect_success 'bitmapped packs are stored via the BTMP chunk' '
 	)
 '
 
+test_expect_success 'pack.preferBitmapTips interprets patterns as hierarchy' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		# Create enough commits that not all will receive bitmap
+		# coverage even if they are all at the tip of some reference.
+		test_commit_bulk --message="%s" 103 &&
+		git log --format="create refs/tags/%s %H" HEAD >refs &&
+		git update-ref --stdin <refs &&
+
+		# Create the bitmap via the MIDX.
+		git repack -adb --write-midx &&
+		test-tool bitmap list-commits | sort >commits-with-bitmap &&
+
+		# Verify that we have at least one commit that did not
+		# receive a bitmap.
+		git rev-list HEAD >commits.raw &&
+		sort <commits.raw >commits &&
+		comm -13 commits-with-bitmap commits >commits-wo-bitmap &&
+		test_file_not_empty commits-wo-bitmap &&
+		commit_id=$(head commits-wo-bitmap) &&
+		ref_without_bitmap=$(git for-each-ref --points-at="$commit_id" --format="%(refname)") &&
+
+		# When passing the full refname we do not expect a bitmap to be
+		# generated, as it should be interpreted as if a slash was
+		# appended to the pattern.
+		rm .git/objects/pack/multi-pack-index* &&
+		git -c pack.preferBitmapTips="$ref_without_bitmap" repack -adb --write-midx &&
+		test-tool bitmap list-commits >after &&
+		test_grep ! "$commit_id" after &&
+
+		# But if we pass the parent directory of the ref we should see
+		# a bitmap.
+		ref_namespace=$(dirname "$ref_without_bitmap") &&
+		rm .git/objects/pack/multi-pack-index* &&
+		git -c pack.preferBitmapTips="$ref_namespace" repack -adb --write-midx &&
+		test-tool bitmap list-commits >after &&
+		test_grep "$commit_id" after
+	)
+'
+
 test_done

-- 
2.53.0.414.gf7e9f6c205.dirty

