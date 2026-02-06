Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5D3451D9
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364206; cv=none; b=m6R0q5ytqBf8THqERE7HVIVLZXIXoV5HghSnUdVIbQf7xvThcIoztck8Kx/3ecT0tg0/9rNKrLeDaC2mbM9SFXsWZYvN1GcOMb/BCFLqQ5UY5hjOh2IQnFjoCMd+FP7ffuHU+o+Ec6hrakXsLzAivJR4w+g7sdJRgq2kozfuBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364206; c=relaxed/simple;
	bh=rE/fyb7W+KFu+zlbSUIhfp37qBWwjCyx0J5ObUBBhD8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ciPlfdOdZ/EGAa/9tL1bd6XaWLw4RIhVXtyGcYYzI3kVjkBa5Esf8MGf8CCF7NtSkPypTzw+tnuu0f8NHNx/FD305MNcOWDzV2+hOJwwgLQFsSmjT3/EZjkQ9q0FqC20OqbbftTqbW3aKFtFx4B6nO3fG8mzlhC22z+Es7/XENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mhq1p4mK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OXUkWwFC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mhq1p4mK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXUkWwFC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 717EB1D000C7;
	Fri,  6 Feb 2026 02:50:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Feb 2026 02:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770364205;
	 x=1770450605; bh=EhQtQQ3EtsxSEFuIx3nbAvSHU8iAYflaXUPjfQO/3QM=; b=
	mhq1p4mKcY0kX1sUPe46AB7k3BDyUArDlMVwtNGAPWUp4DUWrj1ljgDUPpnmAWD3
	LTFarC3otp+bBV61q5y9lbsz4LM+QJ3jAwSLkZeIHQfuT+lelXKNZ11/1u5o8lBe
	CpZuZonrzUa33RYxhsp6dTinm8CMhT6FDFZ+54rN/z/clyjUsqvLCdHiFZM92d+q
	yJ5kvmSU1O1eccRznR6Xj1rzr0/2YisxGiNtD/rjcUcoOUb9Fx5WrcbvkNNqmmM2
	/EfdfIGLZUcYZ03P38FPGhai3wbKVirh8LbBx0OmG20x0Ks/RhVl5fOs5tqB2ZWY
	FTm2Y0pq37V/zcIEJKqdMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770364205; x=
	1770450605; bh=EhQtQQ3EtsxSEFuIx3nbAvSHU8iAYflaXUPjfQO/3QM=; b=O
	XUkWwFCXhFNaMDYjwWMXalwd1RqkI3SfAKXUbc24THkT7nj9VLcD8+fnbGnGlzYV
	/b9A/lOyd+HeKgh2/+tqXaGrudP7hZYpReZ4s7mNBzMk7L+94f4ehTGMgfUdbeAA
	P4RjYpKkavvaOY9rOAeR1aJYTZlBawC4aKwc2eRqK8i0BFU1E0y9G/Fjru57uvbm
	kUOHs1Jkj2VeVD2tLQEcwzpxhYkXZ1O1CFRGRcjhAKZFxZJjLZhZEKPx+yaeZP7I
	4PrU+29NtN48wDoRIM3Xcg29pD7fWBV1EpMnQiPczrqd52aQe0XjCTWFhRO7Wpg3
	CoSJevhBUEHCaTFugR/8Q==
X-ME-Sender: <xms:LZ2FaUAFJTQbHhTAy8lG-5kmA6I0N-0YTr700ya4P9ERuS1f6YtKvQ>
    <xme:LZ2Fadh8qTD3d2QPLQMahGSe54x2u4MYdwwbtZ2_wSHGNKLIYZzZ__X7AH-nTItzb
    qPbGgrST7bwXqccNrYtP3zkIEJbMIaKtfg7j0_2WyoTZIvNBIFeSQ>
X-ME-Received: <xmr:LZ2FaclFXtMWcVmf71BlWz5ShlByfX3tx_BUJ1Z-ZCPWF-byELAsRcwFuN3OpPvou9IUIc78WI_644Ym9sMyHdECYbhaMEPEb4mY2AR7bYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgjghfvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtud
    ehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LZ2FaZpaQi69empQ435meV_i6YeeoogxrMBeRq-W2eGia6i4ZdvWnQ>
    <xmx:LZ2FaVEl4A5cyTY5ah6fVdU8PbGvwwoRhbRUK6i8MF6UPou5Dn4VAw>
    <xmx:LZ2FaVz3OKr5ckycB6cfYsL0z8g9dTCgfb1YAxz5kr0vuzaPhZ7dRQ>
    <xmx:LZ2FaaoNOQEjdnXzmAed2_byzKKgyyH9D-v_kWELupt7e_X1ueWaQQ>
    <xmx:LZ2FaeQMOToITf3q4O6z7hf-B9LSLgsRlQ9YWWx95AhpWjRERGBlB2tO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 02:50:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 013fbb34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 07:50:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/4] Fix misuse of `refs_for_each_ref_in()`
Date: Fri, 06 Feb 2026 08:49:55 +0100
Message-Id: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACOdhWkC/5XNyw6CMBAF0F8xXTumD6jgyv8wLoYyyMTwSKsNh
 vDvFhbGpS7vTO65swjkmYI47WbhKXLgoU/B7HfCtdjfCLhOWWiprVS6gCqD8R6g4QmawQOha8F
 TA9xDx+EZCEqLZDUZZTAXyRnTm6dt43JNueXwGPxrm4xqvf6jRwUSanIOyRAedX5OhQN3YqWj/
 uKM/IXTiZNZVlaqLNAW6sMty/IGs0XADR4BAAA=
X-Change-ID: 20260128-b4-pks-fix-for-each-ref-in-misuse-96ae62e313a5
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Hi,

this small patch series fixes a bug I have discovered where configuring
"pack.preferBitmapTips" to an exact branch will cause Git to `BUG()`.

The root cause of this bug is misuse of `refs_for_each_ref_in()`: this
function accepts a prefix to yield refs for, and then strips the prefix
for each ref. Consequently, if passed an exact refname, then stripping
the prefix would make us end up with an empty refname, and that is not
supposed to happen.

There was one other caller that got it wrong, too, and which is also
fixed in this patch series.

Changes in v3:
  - Switch the approach to perform ref hierarchy matches instead, which
    is in line with the changes in 10e8a9352b (refs.c: stop matching
    non-directory prefixes in exclude patterns, 2025-03-06).
  - Link to v2: https://lore.kernel.org/r/20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im

Changes in v2:
  - Explain my thought process against why I chose to also allow exact
    ref matches in the second commit and clarify the documentation a
    bit. As said, I'm very open to changing this if my spelled-out
    thoughts are not convincing.
  - Apply Peff's patch to further simplify code.
  - Link to v1: https://lore.kernel.org/r/20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im

Thanks!

Patrick

---
Jeff King (1):
      bisect: simplify string_list memory handling

Patrick Steinhardt (3):
      pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
      pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
      bisect: fix misuse of `refs_for_each_ref_in()`

 Documentation/config/pack.adoc |  9 +++++----
 bisect.c                       | 16 +++++++---------
 builtin/pack-objects.c         | 19 ++-----------------
 pack-bitmap.c                  | 29 +++++++++++++++++++++++++++-
 pack-bitmap.h                  |  9 ++++++++-
 repack-midx.c                  | 14 +++-----------
 t/t5310-pack-bitmaps.sh        | 41 ++++++++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh    | 43 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 137 insertions(+), 43 deletions(-)

Range-diff versus v2:

1:  276b593c0d = 1:  927e8bf4ae pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
2:  e7a5e5e447 ! 2:  3e4ae331dd pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
    @@ Commit message
             doesn't already have one. This would mean that we only match
             ref hierarchies that start with this prefix.
     
    -    The first fix leaves the user with strictly _more_ configuration
    -    options: they can have prefix matches by not appending a slash to the
    -    configuration, and they can have ref hierarchy matches by appending one.
    +    While the first fix leaves the user with strictly _more_ configuration
    +    options, we have already fixed a similar case in 10e8a9352b (refs.c:
    +    stop matching non-directory prefixes in exclude patterns, 2025-03-06) by
    +    using the second option. So for the sake of consistency, let's apply the
    +    same fix here.
     
    -    Apply this fix and clarify the documentation accordingly.
    +    Clarify the documentation accordingly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/config/pack.adoc ##
     @@ Documentation/config/pack.adoc: pack.usePathWalk::
    + 	processes. See linkgit:git-pack-objects[1] for full details.
      
      pack.preferBitmapTips::
    ++	Specifies a ref hierarchy (e.g., "refs/heads/"); can be
    ++	given multiple times to specify more than one hierarchies.
      	When selecting which commits will receive bitmaps, prefer a
     -	commit at the tip of any reference that is a suffix of any value
     -	of this configuration over any other commits in the "selection
     -	window".
    -+	commmit at the tip of a reference that matches any of the
    -+	configured prefixes.
    ++	commmit at the tip of a reference that is contained in any of
    ++	the configured hierarchies.
      +
     -Note that setting this configuration to `refs/foo` does not mean that
     +Note that setting this configuration to `refs/foo/` does not mean that
    @@ Documentation/config/pack.adoc: pack.usePathWalk::
     
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: void for_each_preferred_bitmap_tip(struct repository *repo,
    + {
    + 	struct string_list_item *item;
    + 	const struct string_list *preferred_tips;
    ++	struct strbuf buf = STRBUF_INIT;
    + 
    + 	preferred_tips = bitmap_preferred_tips(repo);
    + 	if (!preferred_tips)
      		return;
      
      	for_each_string_list_item(item, preferred_tips) {
    --		refs_for_each_ref_in(get_main_ref_store(repo),
    ++		const char *pattern = item->string;
    ++
    ++		if (!ends_with(pattern, "/")) {
    ++			strbuf_reset(&buf);
    ++			strbuf_addf(&buf, "%s/", pattern);
    ++			pattern = buf.buf;
    ++		}
    ++
    + 		refs_for_each_ref_in(get_main_ref_store(repo),
     -				     item->string, cb, cb_data);
    -+		refs_for_each_fullref_in(get_main_ref_store(repo),
    -+					 item->string, NULL, cb, cb_data);
    ++				     pattern, cb, cb_data);
      	}
    ++
    ++	strbuf_release(&buf);
      }
      
    + int bitmap_is_preferred_refname(struct repository *r, const char *refname)
     
      ## t/t5310-pack-bitmaps.sh ##
     @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
      		)
      	'
      
    -+	test_expect_success 'pack.preferBitmapTips can use direct refname' '
    ++	test_expect_success 'pack.preferBitmapTips interprets patterns as hierarchy' '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
     +			# Create enough commits that not all will receive bitmap
     +			# coverage even if they are all at the tip of some reference.
     +			test_commit_bulk --message="%s" 103 &&
    -+			git log --format="create refs/tags/%s %H" HEAD >refs &&
    ++			git log --format="create refs/tags/%s/tag %H" HEAD >refs &&
     +			git update-ref --stdin <refs &&
     +
     +			# Create the bitmap.
    @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
     +			comm -13 commits-with-bitmap commits >commits-wo-bitmap &&
     +			test_file_not_empty commits-wo-bitmap &&
     +			commit_id=$(head commits-wo-bitmap) &&
    ++			ref_without_bitmap=$(git for-each-ref --points-at="$commit_id" --format="%(refname)") &&
     +
    -+			# We now create a reference for this commit and repack
    -+			# with "preferBitmapTips" pointing to that exact
    -+			# reference. The expectation is that it will now be
    -+			# covered by a bitmap.
    -+			git update-ref refs/heads/cover-me "$commit_id" &&
    -+			git -c pack.preferBitmapTips=refs/heads/cover-me repack -adb &&
    ++			# When passing the full refname we do not expect a
    ++			# bitmap to be generated, as it should be interpreted
    ++			# as if a slash was appended to the pattern.
    ++			git -c pack.preferBitmapTips="$ref_without_bitmap" repack -adb &&
    ++			test-tool bitmap list-commits >after &&
    ++			test_grep ! "$commit_id" after &&
    ++
    ++			# But if we pass the parent directory of the ref we
    ++			# should see a bitmap.
    ++			ref_namespace=$(dirname "$ref_without_bitmap") &&
    ++			git -c pack.preferBitmapTips="$ref_namespace" repack -adb &&
     +			test-tool bitmap list-commits >after &&
     +			test_grep "$commit_id" after
     +		)
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'bitmapped packs are stored via
      	)
      '
      
    -+test_expect_success 'pack.preferBitmapTips can use direct refname' '
    ++test_expect_success 'pack.preferBitmapTips interprets patterns as hierarchy' '
     +	git init repo &&
     +	test_when_finished "rm -fr repo" &&
     +	(
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'bitmapped packs are stored via
     +		comm -13 commits-with-bitmap commits >commits-wo-bitmap &&
     +		test_file_not_empty commits-wo-bitmap &&
     +		commit_id=$(head commits-wo-bitmap) &&
    ++		ref_without_bitmap=$(git for-each-ref --points-at="$commit_id" --format="%(refname)") &&
    ++
    ++		# When passing the full refname we do not expect a bitmap to be
    ++		# generated, as it should be interpreted as if a slash was
    ++		# appended to the pattern.
    ++		rm .git/objects/pack/multi-pack-index* &&
    ++		git -c pack.preferBitmapTips="$ref_without_bitmap" repack -adb --write-midx &&
    ++		test-tool bitmap list-commits >after &&
    ++		test_grep ! "$commit_id" after &&
     +
    -+		# We now create a reference for this commit and repack
    -+		# with "preferBitmapTips" pointing to that exact
    -+		# reference. The expectation is that it will now be
    -+		# covered by a bitmap.
    -+		git update-ref refs/heads/cover-me "$commit_id" &&
    ++		# But if we pass the parent directory of the ref we should see
    ++		# a bitmap.
    ++		ref_namespace=$(dirname "$ref_without_bitmap") &&
     +		rm .git/objects/pack/multi-pack-index* &&
    -+		git -c pack.preferBitmapTips=refs/heads/cover-me repack -adb --write-midx &&
    ++		git -c pack.preferBitmapTips="$ref_namespace" repack -adb --write-midx &&
     +		test-tool bitmap list-commits >after &&
     +		test_grep "$commit_id" after
     +	)
3:  261523862b = 3:  8d82966f8f bisect: fix misuse of `refs_for_each_ref_in()`
4:  e9b0fd0d5f = 4:  7f68687165 bisect: simplify string_list memory handling

---
base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
change-id: 20260128-b4-pks-fix-for-each-ref-in-misuse-96ae62e313a5

