Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137C30F53C
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862430; cv=none; b=iQpdqxyn2+EvMmT+hZn/SBL4KvQxPXsMHVXpl6Hvh2s0HeIOHfmDqmazuH6WmKjBVDKSiWNWcTCfcVmbcdmb7fq1ix0/wkr3CF38F/TNiHm9BWFDpjzPfDH1zRcOmKH3kKyYflzkRMDT889rpXP3753x2ChaytSTsgaNnhxaC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862430; c=relaxed/simple;
	bh=0Y3vUKMKCtOPEncYIk4WmYDEc8ekR+/hSxDvPYCuV80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ef4+/PZDTnYDoNO3KsSNFjfXZVXU+bcsZjpqsAv30ana7fgxct1P7FxXsKDY6QXBr6tnxBs7Kxlx4SEqzRRm+Om0bBais0WkItaiNivIdvWDxhQHwUFOHRsD+wihhFP9DJG4GX9HcluaQZYXC9s+WBUWx0or3B1i8/G0FMRt9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LhYXz021; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vhy/Wqsc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LhYXz021";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vhy/Wqsc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD8D514001E3;
	Mon, 23 Feb 2026 11:00:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 23 Feb 2026 11:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771862428;
	 x=1771948828; bh=mJ3O8FiSFNJCEKBT1valf+PNy1e8eFROk1mB40CRG6w=; b=
	LhYXz021rA7y0OnaS3v7R1w0cx5OETRyWWkN0sQCXxDmlez1a+Ktvw7ZFU9q5I3y
	kqtX21H/Y5umGGrlWqur2Uh8GJ7o/LjtyoPnZzyAWPLMxsMqtIIhDDJJpJgl+E8+
	v3srNVQ8wE9pB/k7uzsfb3OM+YTiFPDUVVmzWr1+BtrVEGibJ+RcI0dM0vTiDBZU
	+j4Ajo3sh0zUwpF24Doub10TWS4FWMKwXe3hfjU7pBINQ5lygRKsn68ln0i8vlTn
	M7aaPyLseOM2yvNOWGiUEd8fl/QGH3xzBeRUX63P7lh4ocaJYJvObXWVJ8EuHQay
	6h7bY8b5pE8IJIcMvkGhYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771862428; x=
	1771948828; bh=mJ3O8FiSFNJCEKBT1valf+PNy1e8eFROk1mB40CRG6w=; b=v
	hy/WqscwrISFuRrxtCgk6PQCuO0ylUlmT+Y9WvyxDdUcAleQpHGGbV45zXljjheg
	nkmLY0KyAMAJjsTte58LMqiBz7xggoL7WYmQ9JxhOGMX00Mn4GnwFu80Pjbih4zR
	MgPzvLd4DLqVZpVVpTiAzQWon6flBX3XA+Wn+FkZx08fx+LqueQsKc1zDOHo+9cl
	Vh+iOqKkZcqKRwvUtuGkSrPq+OTK3JLZZtwnzqxszs729+1thwHINWSuzU9u13Vg
	LHKSLynTsQxn14diQ+oXIMDPPtkIw1bg6Gq7dGtEtvSIJb+fh/GmmhtJuC9Feu5B
	f3VMTvshzsv95Nkz5VEAg==
X-ME-Sender: <xms:nHmcaY8UQeysPuXwLpNHonFHg7vnLrEgcGgPJyAxSDRH9jzv_10ctA>
    <xme:nHmcaXkhLyGnN57fSDmD3uH7bjZhM-bqHBUt6vCxVoK9cfD_bCCiWAwQPjmrOkdh_
    5lR5mnARzgc2E9W-qCx3Thsw0nr1VmsgmLOS_miF-Pf8xrMcLCW>
X-ME-Received: <xmr:nHmcaWWJwuUiT2R19jwFaP_-HAOBsuFb2WKiL75-8exQ-gyFpKkS-qn7qe6981zEMi4vpQUOY6qfAZQTp5orfH1UwbLp-TDprkTC9OQEoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:nHmcaUFoAmAgjIkSipTSR8xArGs2zzwSaXTg1VT7YtSv-0DR1h5tKg>
    <xmx:nHmcaaeGsrmJ6-abgHwhuS4w9Y5rY5sNDnKHii7RBNnN6_B6bbnB_g>
    <xmx:nHmcadK47W3EQN6yUWJl_x4Y3EIKsMOpBETlEX2Allk_k7ziZ9egFw>
    <xmx:nHmcaXGlFTYUe_pM_pD7EBd_UQAAJdfxTjyjtqpKWQRMEpxt1XLiXw>
    <xmx:nHmcaQPHrCNMbMeKVtA7WoKt0sozHa_X6r7URF3vsUqBcKFFCQ0QSMZI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:00:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f731412 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 16:00:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:00:09 +0100
Subject: [PATCH v2 4/4] pack-check: fix verification of large objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-fsck-fix-v2-4-99a0714ea3bd@pks.im>
References: <20260223-pks-fsck-fix-v2-0-99a0714ea3bd@pks.im>
In-Reply-To: <20260223-pks-fsck-fix-v2-0-99a0714ea3bd@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.3

It was reported [1] that git-fsck(1) may sometimes run into an infinite
loop when processing packfiles. This bug was bisected to c31bad4f7d
(packfile: track packs via the MRU list exclusively, 2025-10-30), which
refactored our lsit of packfiles to only be tracked via an MRU list,
exclusively. This isn't entirely surprising: any caller that iterates
through the list of packfiles and then hits `find_pack_entry()`, for
example because they read an object from it, may cause the MRU list to
be updated. And if the caller is unlucky, this may cause the mentioned
infinite loop.

While this mechanism is somewhat fragile, it is still surprising that we
encounter it when verifying the packfile. We iterate through objects in
a given pack one by one and then read them via their offset, and doing
this shouldn't ever end up in `find_pack_entry()`.

But there is an edge case here: when the object in question is a blob
bigger than "core.largeFileThreshold", then we will be careful to not
read it into memory. Instead, we read it via an object stream by calling
`odb_read_object_stream()`, and that function will perform an object
lookup via `odb_read_object_info()`. So in the case where there are at
least two blobs in two different packfiles, and both of these blobs
exceed "core.largeFileThreshold", then we'll run into an infinite loop
because we'll always update the MRU.

We could fix this by improving `repo_for_each_pack()` to not update the
MRU, and this would address the issue. But the fun part is that using
`odb_read_object_stream()` is the wrong thing to do in the first place:
it may open _any_ instance of this object, so we ultimately cannot be
sure that we even verified the object in our given packfile.

Fix this bug by creating the object stream for the packed object
directly via `packfile_read_object_stream()`. Add a test that would have
caused the infinite loop.

[1]: <20260222183710.2963424-1-sandals@crustytoothpaste.net>

Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-check.c    |  2 +-
 t/t1450-fsck.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/pack-check.c b/pack-check.c
index 46782a29d5..7378c80730 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -155,7 +155,7 @@ static int verify_packfile(struct repository *r,
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (!data &&
-			 (!(stream = odb_read_stream_open(r->objects, &oid, NULL)) ||
+			 (packfile_read_object_stream(&stream, &oid, p, entries[i].offset) < 0 ||
 			  stream_object_signature(r, stream, &oid) < 0))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8fb79b3e5d..54e81c2636 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -852,6 +852,44 @@ test_expect_success 'fsck errors in packed objects' '
 	! grep corrupt out
 '
 
+test_expect_success 'fsck handles multiple packfiles with big blobs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# We construct two packfiles with two objects in common and one
+		# object not in common. The objects in common can then be
+		# corrupted in one of the packfiles, respectively. The other
+		# objects that are unique to the packs are merely used to not
+		# have both packs contain the same data.
+		blob_one=$(test-tool genrandom one 200k | git hash-object -t blob -w --stdin) &&
+		blob_two=$(test-tool genrandom two 200k | git hash-object -t blob -w --stdin) &&
+		blob_three=$(test-tool genrandom three 200k | git hash-object -t blob -w --stdin) &&
+		blob_four=$(test-tool genrandom four 200k | git hash-object -t blob -w --stdin) &&
+		pack_one=$(printf "%s\n" "$blob_one" "$blob_two" "$blob_three" | git pack-objects .git/objects/pack/pack) &&
+		pack_two=$(printf "%s\n" "$blob_two" "$blob_three" "$blob_four" | git pack-objects .git/objects/pack/pack) &&
+		chmod a+w .git/objects/pack/pack-*.pack &&
+
+		# Corrupt blob two in the first pack.
+		git verify-pack -v .git/objects/pack/pack-$pack_one >objects &&
+		offset_one=$(sed <objects -n "s/^$blob_two .* \(.*\)$/\1/p") &&
+		printf "\0" | dd of=.git/objects/pack/pack-$pack_one.pack bs=1 conv=notrunc seek=$offset_one &&
+
+		# Corrupt blob three in the second pack.
+		git verify-pack -v .git/objects/pack/pack-$pack_two >objects &&
+		offset_two=$(sed <objects -n "s/^$blob_three .* \(.*\)$/\1/p") &&
+		printf "\0" | dd of=.git/objects/pack/pack-$pack_two.pack bs=1 conv=notrunc seek=$offset_two &&
+
+		# We now expect to see two failures for the corrupted objects,
+		# even though they exist in a non-corrupted form in the
+		# respective other pack.
+		test_must_fail git -c core.bigFileThreshold=100k fsck 2>err &&
+		test_grep "unknown object type 0 at offset $offset_one in .git/objects/pack/pack-$pack_one.pack" err &&
+		test_grep "unknown object type 0 at offset $offset_two in .git/objects/pack/pack-$pack_two.pack" err
+	)
+'
+
 test_expect_success 'fsck fails on corrupt packfile' '
 	hsh=$(git commit-tree -m mycommit HEAD^{tree}) &&
 	pack=$(echo $hsh | git pack-objects .git/objects/pack/pack) &&

-- 
2.53.0.536.g309c995771.dirty

