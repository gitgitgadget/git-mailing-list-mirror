Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CD1917EF
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162733; cv=none; b=adMDPxG7hjUKTHmFpv8Z+OJ+GQxWHpijZeSy8cpC3kcmlI4Gi26Zi+dERlTU5MzJ2OfOXvLVTLxB3KZ+8xHII8SqJab5ranRfvY/7OHv4Ig9ggJi/oNkbTTgl1GlWXsRsW09UHah30f3r6mjroqWUUN7PQfsaxWPWJSg1b4y604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162733; c=relaxed/simple;
	bh=y8K1KjuELFVbwthYQp2OWFJiyd6MN6eKlIY3ZWYPOlo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEBTcJ5EfdtVExuAIrzBM2LReWrudfLopDZf1FpXkUZe57+nwlkEuDmyPpbdFRqKjN+xUOm95UDh7qjhkMUTmCFyIRxu7TLjHPgjT90oRzJ9V/fQwLAFkV2iQKQJGsxV1N3sLwxfg9L5G5fdLsn03QNjilqhowhwjXt7u4t4+tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xksxe0SH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEysfmNm; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xksxe0SH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEysfmNm"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 592C3138FC36
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162731; x=1724249131; bh=O8QXy96Qtf
	R6mQErCqM+V1HmQQkJtD/I900UtsWbPr0=; b=Xksxe0SHvcq3jTL4L4pVj6bocB
	301DBc2kZzNC4E5LZnSnGUvYNwUhJDhnW1jmKpEPXVoZRvbUjNp7GAuU+MFN5eQl
	AyfUOSboEKQ0OHbikAZXGEn2Rh09x9SPgQ8oNrkmjmBezKz2dmCh4t8+4o5Y1ILm
	L6IcNTD0W7dbYgSpcQlzjIjYXPQ978xsAdZHoSYWtVrSmcohDgcRAzlZU4nSH10o
	am1232kuEySj7Zwqx8MHExLG1Gg5sA6/oc6asHYkXVPPKMmLSMJGDCxJUQ1xYA3a
	jLgFoYZTmHPempqbgypLAFrfoRjy5vO9NuqYEf2LqOZdRXRamZuH2Ux9zt/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162731; x=1724249131; bh=O8QXy96QtfR6mQErCqM+V1HmQQkJ
	tD/I900UtsWbPr0=; b=UEysfmNm9tDQC06iby/U0LRG4G3jYnXV8zl8oW6HI9RQ
	/jNCx8qsGrhI3o9EFxkSOz2BPokLPRz/AYQ6AabNx51VurlH/ursW9AWuR0UqbEL
	fObE45yiOeJXdwtM2BYYIoZcyQBwOskW+eJzhnFAx7LK1WIajCyaGFuvfDguvgys
	CcCyNEGzkrfOHjonMaM6pTv9DR7WmY70/Dh/R7wqtWWAEDM9nwIk+p4wpbeeDD+P
	jC8NZatenIx4BfYWrGiZKmlsv1Z+HKKLCcL4yw/lwHDjJ4BA7IbMbr5+G6xdnyOF
	/xsNdPDlxHLoHy49OVXfInZSEN4RWvIOxnpP7gg8Cg==
X-ME-Sender: <xms:q6LEZtMR8V55HNXUZC-VAKHRhJjAUp35OOL7wLigyZlgRqE8z64Log>
    <xme:q6LEZv9EIrOm8PRzD-9yByRKAZ7B5_-e5KjvT4ZRMWsV1Tpy-Wk7meC4AKjsqvdnz
    F0kWxz9dmvLKCNtng>
X-ME-Received: <xmr:q6LEZsTSCMR9mIgkK3QB-rrvdOEVF4miOfvyJK6jq8MkPp7vNGcZJxHoKjl75tqeNzpUES7Rcz2D746Mgi_SQlDoudZRYCehceD3zW_lOELSN1jxvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:q6LEZptBse7CXEXyEjCpukIQrRJBRQdg5EolDMF3vdnrRsKAluYZzg>
    <xmx:q6LEZlf1kQOt_mO-szaxiUYWZN-tKFWmQDP6zdLalmBP0P3nfOWprw>
    <xmx:q6LEZl08rMZHHvK6b-IJYmCp5jeHscmWLtgBgvtmUDUmvLTVzqtKEQ>
    <xmx:q6LEZh_T6hMqKvnUxKLBBnEcq49GVLVB7puwRwX8W4Z8FKg_E0YV9Q>
    <xmx:q6LEZlHFVriuZb1ZRmMnUJOjKbQqJq_3_bHRSGH40NMMGqwbw0GfhJpP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ab3b4eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:59 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/20] t/helper: fix leaking multi-pack-indices in "read-midx"
Message-ID: <9caf5eeea934da49608420fa09fc9179c73a4de7.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

Several of the subcommands of `test-helper read-midx` do not close the
MIDX that they have opened, leading to memory leaks. Fix those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-midx.c   | 8 +++++++-
 t/t5319-multi-pack-index.sh | 2 ++
 t/t7704-repack-cruft.sh     | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 69757e94fc2..438fb9fc619 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -86,6 +86,8 @@ static int read_midx_checksum(const char *object_dir)
 	if (!m)
 		return 1;
 	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
+
+	close_midx(m);
 	return 0;
 }
 
@@ -102,10 +104,12 @@ static int read_midx_preferred_pack(const char *object_dir)
 
 	if (midx_preferred_pack(midx, &preferred_pack) < 0) {
 		warning(_("could not determine MIDX preferred pack"));
+		close_midx(midx);
 		return 1;
 	}
 
 	printf("%s\n", midx->pack_names[preferred_pack]);
+	close_midx(midx);
 	return 0;
 }
 
@@ -122,8 +126,10 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 		return 1;
 
 	for (i = 0; i < midx->num_packs + midx->num_packs_in_base; i++) {
-		if (nth_bitmapped_pack(the_repository, midx, &pack, i) < 0)
+		if (nth_bitmapped_pack(the_repository, midx, &pack, i) < 0) {
+			close_midx(midx);
 			return 1;
+		}
 
 		printf("%s\n", pack_basename(pack.p));
 		printf("  bitmap_pos: %"PRIuMAX"\n", (uintmax_t)pack.bitmap_pos);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ce1b58c7323..fbbc218d04a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='multi-pack-indexes'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 . "$TEST_DIRECTORY"/lib-midx.sh
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 959e6e26488..5db9f4e10f7 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -2,6 +2,7 @@
 
 test_description='git repack works correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objdir=.git/objects
-- 
2.46.0.164.g477ce5ccd6.dirty

