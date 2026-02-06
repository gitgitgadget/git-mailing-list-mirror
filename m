Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7C3451C7
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364209; cv=none; b=o14Ni3sZCSo0IMbZRsQHw5U7OcRI05rT8pEKrXlmusei2BrRTdwM8nOboduRCgLOVSiC3ds1OpZ5lFZ8M+Pe87OG6uKzJNg/uE6tJ7DWXA3fszcQeJsjOJUn2ZaSBsHkKv/tPXOEBYPGGBWGZDqWWLe1z7uGlaZwvhJd7fzFzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364209; c=relaxed/simple;
	bh=RqY4ta1dEKNxeCYng/na9AWmpJ2373PChsm3JHN6BuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHPBKJ5zqB7VVk962novqKVFO8T50P8jtd1NMI8Ki0dMIVFSm3oidzxT3ApnMVWlPbp7NRZCTlS7wSbRfNKj2xMZ20hJnkbfBQq39aLr6zJM1NBsLCA1KGPvefTxJgfPuJA5G1gWVhjgfJY82n88GRipHMUACzcdpsncGntEH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QJ1BRkNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XZ/DQT5N; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QJ1BRkNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XZ/DQT5N"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E12BB7A0154;
	Fri,  6 Feb 2026 02:50:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 02:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770364208;
	 x=1770450608; bh=pPS09DLcZPYQnvXMopgYIz4TW+N8eMWgxtKmzdCSVT4=; b=
	QJ1BRkNRuQzAUhjYnJxFinwfWb0/eI5xb84HdZoOOsuGDKftAlcdQDlAemNwj+fV
	5wcQPgTdoPLnio4RDesN0BZj5abEAGhWQ29BmSUb2DIhHMdm68Tkcy5oKBM4mEf/
	WQVrPUTHlhPntzRnN8ldt8roB0ji1VZecOAvxSsTUE69wrKFea7Txuq8H2OUaE3B
	ykmDNGlqFTtxXuj+Zx6c34MRyHz0iBSO7FbLXzvyl4M64miQTrokGqRXtgDTpyNG
	NuT2KacYhyL9siMxG7pBJVSDSis1m/4whqtusysHondC59PyDTKSGE3M0zxy0BDv
	PszPEfhr6+slbF5Eytm3aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770364208; x=
	1770450608; bh=pPS09DLcZPYQnvXMopgYIz4TW+N8eMWgxtKmzdCSVT4=; b=X
	Z/DQT5NeAPrb9DYpvfBqvnZx5PYPXFMaUHNCpzrJBiZgBm/Iy9DJpvdf5dY1fAPr
	bHD7aZH06QAz6EDrxc38c40tRFhcHIvAbvEnNkTqRVBUckeSnbriNEu530YMHcbh
	MzyThhC9jBdMyONz8ttctb68deTAZVpIccO9oMyEWeqla6/q1cxRDz56MX0lny7d
	uUIzUiLlKXKzLWFs/QLUKtXnZGTuc1oOt6WQ4nuNTOq8dJk2x8IMUXj1tal3U5xx
	qkNimy6BLW9bvqEGa4T1eig0Pw5sAX7kMaQbRHjI/Fsw/4k6sh0NIoudec5WbWkn
	hkaT7kYkY3KSTb7nJw9Eg==
X-ME-Sender: <xms:MJ2FaZtygZMEhs6vByyzo0lRwjjoNTtS5Zi5sfGILnxDlTiPwxLJtg>
    <xme:MJ2FaZfOJ4_mMuyp2qLAZ6jljt1nlaUlsRf8m6b8zjec3a0ZYLjdvgQBvCGxiXiJ0
    UjGu0EzA0YtuTWu-8TtQ8ojIhjhMiXUg7SZ2oGIMFcjitvL4A-wxcg>
X-ME-Received: <xmr:MJ2FaRyurIrWOn9HY2b1oEaX-FHk4BMBwrFZoq5Sd8p7k5ekrjCo6MlkeD9tnSst6sawQ5mCdnmFXDZed18tflCnzy7JWusXlvuDFnpNo-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:MJ2FafFX49J-sbdUAIKjRS0VG_1zgE6KLEG4JaDTkXiDfUNwgcDQiQ>
    <xmx:MJ2FaVwtPMk9nTBLl-SPW9Sxaes2sJsPNx2IQROeMvhQLVv8_247aA>
    <xmx:MJ2FaQtGxqYnpPYYAVtR0_lTqxlmS4HpeJFsc82wKgJM25s2ehFghA>
    <xmx:MJ2FaS3IaMkO3SVmLYWffLQXob7acqrxhyVyEOAozI8RXqC0F-XA4A>
    <xmx:MJ2FaVQPEAMcGZI5GyrSeZAhBw_rewsHPE438EqUqU8NbM6ci98NO03z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 02:50:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d2ee086 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 07:50:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Feb 2026 08:49:57 +0100
Subject: [PATCH v3 2/4] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-2-1e050c3d6a50@pks.im>
References: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
In-Reply-To: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
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
index 75402d5579..dd2de30f0c 100644
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
+	commmit at the tip of a reference that is contained in any of
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
2.53.0.239.g8d8fc8a987.dirty

