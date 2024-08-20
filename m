Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62B192B7F
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162728; cv=none; b=sASyDd7qeKbQzf1pwSA45g4fPJ5xd0yn5u0pnSLGHmvdvqzc04kj9Y5c227PXLVvPwyAzeujdcIHQsn5l6gXynq8WHXcV9NP0kpqy7i4fBxMWjFeaj9PF3L3aO/pzHKykmfPXzNys5VXtbGxcWG/wtE+9rckZ+UGrH/SmUwZ3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162728; c=relaxed/simple;
	bh=vDxiqRp6iVYwbpu0j3aIDA5HytQKw8+cQrVg5vTFAsk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kj+vd8t0A9PJ5Qulcl6mW8CzbKEg6wi/no0HUdEd4D8QyID700yI2LrdZ1NGKRGSuGf4UBMhqV6EzEede05xyJ+nMpeIm70M6N53kocuokj/8gn5PgT8Jn/vCpQq9p+ATp+eOmgpVGGeOyvFuvKSBX80TBUMWAGkjzORy/UzK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UeAJ/oB3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AVxok8cT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UeAJ/oB3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVxok8cT"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 401ED138FC62
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162726; x=1724249126; bh=4ADS7qcSFd
	9ayjtKurewjD8k2fjjnnkXYWgV7sEV1YU=; b=UeAJ/oB38j4h60vOShyL1+hEco
	UTlBJ6mkzkOTz+46ld2/7ixvR/JQAzdiilI6YF8/hV34q+kLj6inNsuzBRkRgysy
	BXrSUX6yBf/uFurf7XnLGdW6Fp1Q+WOwhGtogCunDt43c8u8aECarhpC97KT/w2X
	4APpV2+HURh71ZT/HncQcvqEOIJ0+nvMKtRhjenQiR2Cz+7S27HMRU7hYAPgr9AO
	FgGBxtw+nQkL9lKJqjqPsdSxaAQDO51BTGfoUu1wcN/6Ppc5CRKWaBvnaJpJ/3jX
	6NXagrMw7d6gU0J480VppsIwgnykVXGj1cE+BVbAKq0QTewbPkziaItGbiIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162726; x=1724249126; bh=4ADS7qcSFd9ayjtKurewjD8k2fjj
	nnkXYWgV7sEV1YU=; b=AVxok8cT2cuvUVDndXi4fegYTD7k2+ZYif9g0U9RroQf
	ascYJybtO5pkd8OTR3fOrvJTQkILt0ZO5eAIANApDjz9JJZx0oX0SStuEfB6kG0e
	KI97ipoLRzWvh51bj6SnTtMX4rjUYBju57S98SZ1lXzGQ85CRHqhPpHtIoo6iiQv
	k8QhBmVCvPLwsqTFvtcXaJ+vayQRVsHuhPLdErZHy6uDE4xNT85MzmH6LxrndkdL
	8S/Xz4n+JsjYpbumBejaSyAHu2ks3y+4+LBvjwsjKJ7BjBkoppH35yC/WxevTO+R
	wA6Kwjn7x1DOx0Nvx77ri3ML32b/lycCwdg09ydNIg==
X-ME-Sender: <xms:pqLEZuZS-ktTqNrns1LdNKR_203nfuGytcuguMck8x-c63Tx3MG09A>
    <xme:pqLEZhYMDmgHdcrp66jjyae8dxHpQR2zDmzQ06QGmPTibLPAgkPH5zpx0-yyBqQTj
    MtBvJvN91JyvO_Wjw>
X-ME-Received: <xmr:pqLEZo9Bfxy4D8fPGeTBhbWBP5BdhGb7NPwsiURCkk_f4p-clfga__BgUJmKELrIanPQ7KPsxnJohBldDN9GGCgOZTaJ39WvKwc_dU7LPwoZ5Y8TLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pqLEZgrQzC3bih2KGxSrV5gMnZfDP5vl1hN4SFAS04vZH_Jz9Fry6Q>
    <xmx:pqLEZppUmTSOblQ0FPUw2tWz8AJGKiMc2fZZObgINIdqAWZp7od-Bw>
    <xmx:pqLEZuT9KTLQjzN542QrmoGC74QPJpzwZH3c2tazRQKJNWA7pBJXMw>
    <xmx:pqLEZpqDyU74-K5N96hszfhLXlAmtq1Zil7s7bynhEzT5zXwtAF7dg>
    <xmx:pqLEZqASZn9FGA7BrGaAo6hEM0He7XWG-gxHOGvAYGUa9SwtNkGx6eb4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8176d8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:54 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/20] midx-write: fix leaking hashfile on error cases
Message-ID: <5f042ce5098563aa0662026006c356c278dad0b8.1724159575.git.ps@pks.im>
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

When writing the MIDX file we first create the `struct hashfile` used to
write the trailer hash, and then afterwards we verify whether we can
actually write the MIDX in the first place. When we decide that we
can't, this leads to a memory leak because we never free the hash file
contents.

We could fix this by freeing the hashfile on the exit path. There is a
better option though: we can simply move the checks for the error
condition earlier. As there is no early exit between creating the
hashfile and finalizing it anymore this is sufficient to fix the memory
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx-write.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index e3fa33203fa..07d98d494aa 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1308,6 +1308,18 @@ static int write_midx_internal(const char *object_dir,
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
 
+	if (ctx.nr - dropped_packs == 0) {
+		error(_("no pack files to index."));
+		result = 1;
+		goto cleanup;
+	}
+
+	if (!ctx.entries_nr) {
+		if (flags & MIDX_WRITE_BITMAP)
+			warning(_("refusing to write multi-pack .bitmap without any objects"));
+		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
+	}
+
 	if (ctx.incremental) {
 		struct strbuf lock_name = STRBUF_INIT;
 
@@ -1333,18 +1345,6 @@ static int write_midx_internal(const char *object_dir,
 		f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 	}
 
-	if (ctx.nr - dropped_packs == 0) {
-		error(_("no pack files to index."));
-		result = 1;
-		goto cleanup;
-	}
-
-	if (!ctx.entries_nr) {
-		if (flags & MIDX_WRITE_BITMAP)
-			warning(_("refusing to write multi-pack .bitmap without any objects"));
-		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
-	}
-
 	cf = init_chunkfile(f);
 
 	add_chunk(cf, MIDX_CHUNKID_PACKNAMES, pack_name_concat_len,
-- 
2.46.0.164.g477ce5ccd6.dirty

