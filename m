Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265F34EEEF
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840260; cv=none; b=GgDRKZxRoCs80In2st0F7ZNUriKOdl7AFEwABpfqB/5TsKJvc1D0ynth1O0OobaQUCfvuC93TCZTXo5iebwQvtxOaEg6tno3xowrIpBU1jiJ7OCFe6GaNhlLf7XjgCmBf8MATOwE7xb6mZJJrOaOFFd+sAZDw+Evm1SBwLMFtok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840260; c=relaxed/simple;
	bh=7bKSbdJncMHtUIL43eTKEt6jM0v92dVyjuIfMuoRHuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8LInacpaiMg/UCSDfTOhxxEwBgyr2nTJ5gtL1RtZd2OFm9+lcGbv0QJVhLHqiZiNSvAUb/jU3HZ8984E1xj/8ssy5zrNc+Z2+bgw6eCtV+7TDKnRwP7gI/WXDXAXmDQ2SOoG5CXjmDgRVz2dATARkVAHdKw9zlH6UyNZF8WJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eRDnOJ/T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlNW4v1A; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eRDnOJ/T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlNW4v1A"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 85F87EC054C;
	Mon, 23 Feb 2026 04:50:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 04:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771840258;
	 x=1771926658; bh=wVPkcxzpMlwafSwvq4PVerAgEU7y09DmWPADDCNde1A=; b=
	eRDnOJ/TDzIAkM6zTaACwLowwhgK74DCzWMRG+TyMcedGNA//SjZ3qD+1+BycXxd
	nb8TUnDn9HG87y8Q/xbgJRz9VphZI+e9fZ1tRuAOwlZ1HkFiq6TOGbtXt8J1s44c
	4h09cGQSe1l+/mucDkywZUXjI2FUOu3iZkNMm42FYbdvd81ldZPfyxZ5HFevbdEL
	TtYuRqZKgTpLNJ3q2Edj3CFg1gPFAFuofENLKvyyMfxFdGrvrhUUpCFI4wJ/AHIT
	qsa3wZFX3YnVH60i6TTlcJyyFV7G5ZHke986r1z065eDct1leqtlhNxSCt9lHWp4
	o3At+Uoxde3GBVMiFLr7YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771840258; x=
	1771926658; bh=wVPkcxzpMlwafSwvq4PVerAgEU7y09DmWPADDCNde1A=; b=T
	lNW4v1A7cuw1JJF5UocOkGnbl+Rcz6JHYiZ5ysBcSL3fqS7WxHQREFnp3HGNhyE/
	s/3AZ88wqUW7i5sBDjp78rd/ynWls6GtPaDkEolYDONjFEWULyqXYQrXHcgI4A4B
	KCGSIjifppcWAZ5ZD7MGcy15Q0U5PKZwhLc5C1OKI80cNK2HW15qNQENFT3PcxW/
	/TVigebxwjPkcRNivOuHavqAJmCkyKX6LbycauqOpnOppdFTRtAfq1AZej0ceIXR
	5yqC8Q/svpoj4zJDn76FmWFulGmGPCZCG9tkJAGvXhIPJazz5RBOYNEP/XJsFGXQ
	fFWB5cqE5JWzrIQ7ygDHw==
X-ME-Sender: <xms:AiOcacUJKQMbA94540_RqRDxiOtTJS8jFfau_i2UF0E7js6sKbc2Uw>
    <xme:AiOcaXnnCnIStGS8vqvZlvLcP4H9pFrw-OA2LqWOQDkEH8oFVTS-RJbiZCAKiPTFD
    VU0k4FOkrs7mH41AtMW25YFlrnbxLhQzDIXaiLtYn_yhfJfWNRmD3s>
X-ME-Received: <xmr:AiOcaVZSERqbbdj4Ntyg-BhpRCQgAU40AQR3_MvQdFa0WIWl2sIg1TLQv51c2DSdGss5-sIqI_6p2HNXKFgqgHQxxe1ntcVOh3l0dPl5UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:AiOcaaNgwf3J9w0BKaoA-f5XT4do3VMD69h_g7jJ8YiDpA1GEPiiag>
    <xmx:AiOcaSbNreVzVcTZQMgh2XhVisrklg7NdciLGrnOBjBRUbHkQY32RA>
    <xmx:AiOcaQ3L7lK7CQwaoa1-QyyKVzHIN8SKDtLneg00IgLPJ48YMw8ypg>
    <xmx:AiOcaQc2AdiyC4GQYI-YpfCPV7rkpO3YEV0h3lsSHCdiKr1txqaEbg>
    <xmx:AiOcadZkDgAJcgAgsQVXdINpKS3jrdwwQO3V4TlNMrW7hkDONA8Ejxv0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 04:50:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a640a2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 09:50:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 10:50:43 +0100
Subject: [PATCH 4/4] pack-check: fix verification of large objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-fsck-fix-v1-4-c29036832b6e@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
In-Reply-To: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
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
 t/t1450-fsck.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/pack-check.c b/pack-check.c
index 46782a29d5..6149567060 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -155,7 +155,7 @@ static int verify_packfile(struct repository *r,
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (!data &&
-			 (!(stream = odb_read_stream_open(r->objects, &oid, NULL)) ||
+			 (packfile_read_object_stream(&stream, p, entries[i].offset) < 0 ||
 			  stream_object_signature(r, stream, &oid) < 0))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8fb79b3e5d..ec68397ea3 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -852,6 +852,21 @@ test_expect_success 'fsck errors in packed objects' '
 	! grep corrupt out
 '
 
+test_expect_success 'fsck handles multiple packfiles with big blobs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		blob_one=$(test-tool genrandom one 200k | git hash-object -t blob -w --stdin) &&
+		blob_two=$(test-tool genrandom two 200k | git hash-object -t blob -w --stdin) &&
+		printf "%s\n" "$blob_one" | git pack-objects .git/objects/pack/pack &&
+		printf "%s\n" "$blob_two" | git pack-objects .git/objects/pack/pack &&
+		remove_object "$blob_one" &&
+		remove_object "$blob_two" &&
+		git -c core.bigFileThreshold=100k fsck
+	)
+'
+
 test_expect_success 'fsck fails on corrupt packfile' '
 	hsh=$(git commit-tree -m mycommit HEAD^{tree}) &&
 	pack=$(echo $hsh | git pack-objects .git/objects/pack/pack) &&

-- 
2.53.0.414.gf7e9f6c205.dirty

