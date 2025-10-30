Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1D3446A5
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820749; cv=none; b=HAsHPHnlNr7nxtjVW1pNjWpPxF2mSgHczSV5RLHUmfDS1MAaXkfAOc7Q5ihY4U9+Vm6ortHtZJ9FUW/znycR975n+0ZvCuFX/eI1VZ0/2NtuhGcB3QxaFpYgQLfFCTWHa5B0KcVyVOra5Wz4W0zyVJvp+CepUex+j5FO1XRSd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820749; c=relaxed/simple;
	bh=9F3jGAZ6XYzL9Ez6q5c6sJsV01mSRLPo7nkYbxoVz40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJy3MK2DsfawoBm3JwXpNMfsJd2sBYgygKauH2KwEUJ3gKPlPOfEgPiTOhge8626+zKZfsCOmdOmwvCyEgH/EADUJ0zff0/ovUdZfZRp8Rh4qFhLpq1jISTH4w+3yUowahflf8KjO7rB8Cgh5KQap9t4XU8GafV0ElbeuQtoxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T8sefEMA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+pqQWoW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T8sefEMA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+pqQWoW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 608A6EC01C9;
	Thu, 30 Oct 2025 06:39:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 06:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761820746;
	 x=1761907146; bh=WpNZ/g9oLDdcHOVCOc+au2dlMnflM8zu6jPs3jymmTU=; b=
	T8sefEMASMM2bxgIv6BOyQ4kgWNM+1iybubz47Ko55y0nzJPwz3P66iyMIR+4L5+
	m1Bpo0PIWYsIhGDE4JrhfONB9+06EPGoH94MJIFiMJxnPvCSeuie8YBxkU+N/nNn
	BKgo4Eqydc1tu1XLcaccDQoZmO6iBwjDljefw6AYlvtb4N7XSsoxVoTM9WGc6hir
	wI8iW1NOE7JLnVi94XmITXAaWcEx5QOoY0IfL8AUUJW3Ct8NxLT8S4A7N0WVVGoN
	5swwXt+ENzMXqtSoRqXgryZVWooEk22Bcx7gWl27AH/iQpFim5o4AHa70Bo/lZRE
	5ZdEd6o8cLBuDsujRW2yWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761820746; x=
	1761907146; bh=WpNZ/g9oLDdcHOVCOc+au2dlMnflM8zu6jPs3jymmTU=; b=X
	+pqQWoWJJnc0PZo/y/DxpKDmAoLfH7ZRaXmNGoB5kgrdkrBiDGdvygD80ZB1Kku1
	Dkh3n6esEpLa8d1KeL0Sheedfxg+o27LeMFCtONEQutjG1+0R3kGR261DkeiOocC
	3kZuCrNOt7sReUbLqRgu77MxE7gDWMWlBIVY6ssoia0CmuEfOWTvb0KTCPXPKJ8d
	UWVgb5y+i0SeME4VpJ9SP9kuUjYv7UGHIwajswrZQck30ulqAP5+YuDO/CPewRq8
	iVaGXjrby242sv7qZBEkJs3vwZm/W09Sj3Zh7Z53BB41jBm1etZwzRJQe6TfciUS
	NB0U7omUivIiBsROg7uPQ==
X-ME-Sender: <xms:SkADaTMddz4FOEe_IClRcmwVm8qetJthuKEhBefHdTS2gOwF1YsrQQ>
    <xme:SkADaU8BJiViJT-XbFCCl90O-4QZuTRHInN42nZOLb2BqZ5rlBOq4gcpNk9LOvuW8
    g9KcS9Sdfd0p5cx0xINzoF1EYkTihOBFeyVa6-9EFCr5kUjhdg>
X-ME-Received: <xmr:SkADaXSWGRskw8wquDklPHxke2viFT_ihybxuy6iQJtde-AOUxZcRS10y29QkQYp0h563b5ApWBZLgACKRkP17RjmaFrMHTfEKm6d79D5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefieduhedvveffkeffvdelueejhfffudfggfduueelgeevgeffveeifeettdejgeen
    ucffohhmrghinheptggruggushhthhgvfhgvthgthhgvughprggtkhhtohhthhgvshhtoh
    hrvghsohhthhgrthifvggtrghnrggttggvshhsihhtshhosghjvggtthhsrdhinhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SkADaWlVIas_NvVhUUCfMPulKZpNJfzpR-72lLhcleJOpA4Yoyq0nw>
    <xmx:SkADaXTp-kfZe9f3Z1Zl4mWgw1Q1EGgRlYqXrBNqPewutsF83VgLfg>
    <xmx:SkADaUPsGTHwlJRThxpNAUqWDzqugYmCdA9jWZOh3WzAXhCcCjbLFA>
    <xmx:SkADaQXe_KEyuW4MttMssOvNRsBH2a47PRxWe-xwoRVU4VreOO5jfw>
    <xmx:SkADaazVObbQw1ovd2kzqoDPaUEy05l68Vp0n3O8DtGpG6ZP9IuC9xV4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:39:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 91a37b66 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 10:39:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Oct 2025 11:38:44 +0100
Subject: [PATCH v2 7/8] packfile: always add packfiles to MRU when adding a
 pack
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-pks-packfiles-store-drop-list-v2-7-84654f080cc0@pks.im>
References: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
In-Reply-To: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

When preparing the packfile store we know to also prepare the MRU list
of packfiles with all packs that are currently loaded in the store via
`packfile_store_prepare_mru()`. So we know that the list of packs in the
MRU list should match the list of packs in the non-MRU list.

But there are some direct or indirect callsites that add a packfile to
the store via `packfile_store_add_pack()` without adding the pack to the
MRU. And while functions that access the MRU (e.g. `find_pack_entry()`)
know to call `packfile_store_prepare()`, which knows to prepare the MRU
via `packfile_store_prepare_mru()`, that operation will be turned into a
no-op because the packfile store is already prepared. So this will not
cause us to add the packfile to the MRU, and consequently we won't be
able to find the packfile in our MRU list.

There are only a handful of callers outside of "packfile.c" that add a
packfile to the store:

  - "builtin/fast-import.c" adds multiple packs of imported objects, but
    it knows to look up objects via `packfile_store_get_packs()`. This
    function does not use the MRU, so we're good.

  - "builtin/index-pack.c" adds the indexed pack to the store in case it
    needs to perform consistency checks on its objects.

  - "http.c" adds the fetched pack to the store so that we can access
    its objects.

In all of these cases we actually want to access the contained objects.
And luckily, reading these objects works as expected:

  1. We eventually end up in `do_oid_object_info_extended()`.

  2. Calling `find_pack_entry()` fails because the MRU list doesn't
     contain the newly added packfile.

  3. The callers don't pass `OBJECT_INFO_QUICK`, so we end up
     repreparing the object database. This will also cause us to
     reprepare the MRU list.

  4. We now retry reading the object via `find_pack_entry()`, and now we
     succeed because the MRU list got populated.

This logic feels quite fragile: we intentionally add the packfile to the
store, but we then ultimately rely on repreparing the entire store only
to make the packfile accessible. While we do the correct thing in
`do_oid_object_info_extended()`, other sites that access the MRU may not
know to reprepare.

But besides being fragile it's also a waste of resources: repreparing
the object database requires us to re-read the alternates file and
discard any caches.

Refactor the code so that we unconditionally add packfiles to the MRU
when adding them to a packfile store. This makes the logic less fragile
and ensures that we don't have to reprepare the store to make the pack
accessible.

Note that this does not allow us to drop `packfile_store_prepare_mru()`
just yet: while the MRU list is already populated with all packs now,
the order in which we add these packs is indeterministic for most of the
part. So by first calling `sort_pack()` on the other packfile list and
then re-preparing the MRU list we inherit its sorting.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 2 --
 packfile.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 8022be9a45e..24e1e721754 100644
--- a/midx.c
+++ b/midx.c
@@ -462,8 +462,6 @@ int prepare_midx_pack(struct multi_pack_index *m,
 		    m->pack_names[pack_int_id]);
 	p = packfile_store_load_pack(r->objects->packfiles,
 				     pack_name.buf, m->source->local);
-	if (p)
-		packfile_list_append(&m->source->odb->packfiles->mru, p);
 	strbuf_release(&pack_name);
 
 	if (!p) {
diff --git a/packfile.c b/packfile.c
index 71e95ae11c5..60f2e42876a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -871,6 +871,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 		pack_open_fds++;
 
 	packfile_list_prepend(&store->packs, pack);
+	packfile_list_append(&store->mru, pack);
 
 	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }

-- 
2.51.2.997.g839fc31de9.dirty

