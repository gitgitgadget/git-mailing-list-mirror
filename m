Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2615A490
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078711; cv=none; b=JqnA6uWJa0VQEOc7fgfhldqzlSJOJZEjqVPvdyXRwIYemlFuQlL1wazX0I9zm2lxVd1YGXZN5VDOdOHQHbHq2mvMsJso3Iq7df/VGn7Z7jreDodZE/vgkjLSd4FvfEeNK9E/a/ySp5VSNQVfqfn7opfNk62Iyrh/cTLIYXtcRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078711; c=relaxed/simple;
	bh=uMq6t6NVH4lJMZY5uov8S6RAJOurLE3oNLxyyUUf4zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln2nEYxjALUY7vq5juEVXgOxhdO45Vm9vbNaDVdPEEwzi7H2GQKxmcgitxk+x+P2nkejMsFEtgmeeoLhesUyKgDTuyvcZrq8bnB4UrJX0XIVqpdQx5ZyzcSbO2ZJUySDEITHZuVcROi5KjIs39Intl07DbBy2cvwwGEckIzbdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ffeSOYbH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aaMFZGVm; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ffeSOYbH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aaMFZGVm"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 2164A1C000CA;
	Tue,  2 Apr 2024 13:25:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 13:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078708; x=1712165108; bh=HqbeboZThC
	WuHJSg+lFcs523NEz2UpsfohZvsPTLGyY=; b=ffeSOYbHmDFpQm184T/OCsiND5
	NN2ZR1MN6HR++L56g629msgkSpxsq5JPm0fQya+Nx/Xu6y+Yt/uEPLd9RoCSX7+9
	RjokDMremHrYtZIbvkuK2jaYG5scvmDqpR1M/nLtGvr2sg+Ru7bQHIHXttXPcUSN
	ILgtTN7UQRvXMReSz0GTQ4O3kPASe1X0IGb/LUv5dnja1VM9oA7NzleYqImqzBWN
	IMpr0xBn2YC0UCz4u53veq+hEEK0hjZX7XnnEFBTplkX8Y/gLQ4AnJgC+jWGv/aJ
	JN+fvb8CHr9uLSmcGxxc3Ugr0oyY5MYxrIlUWiJX5O6gIuaSCRm7umdRacZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078708; x=1712165108; bh=HqbeboZThCWuHJSg+lFcs523NEz2
	UpsfohZvsPTLGyY=; b=aaMFZGVmC3yGHAviOrVFumKqSkaklpSQX6PSZXfBsFtW
	ZrXUHJoWKh/I92NgcdpewGyCtAi9GEUNKdq1eLQiQ2MWva5IB5qDpSY+Ui6EnpEM
	I4C4/LV2c+3aFHolvEUKg2BGgQOzyzjljTDTBCivo0wP+WuVlCT9KsiD4OKbSxVU
	iv2R2EXdTjBL+hmB7weJbL1WOxrKxZUOhesyqWPCTuvTz26qfc4QRB2xqwXdvayn
	/3GtNyauo7dESz5sK+xnKkKrWZvyKRt2nOOQC3AdH4Ao5LOZZrgTfRI4uXggjYCt
	/BTm5cXd5Kxw1cO4SzJ6HZLm4Xb2RiV4/DCZxPmsaw==
X-ME-Sender: <xms:dD8MZjiQMKVjQ_pU5iAmsxGiHDm1vNxTbRIOzdxGdhMAQra7HGZb9Q>
    <xme:dD8MZgDU1cJDjXE44W0WJXJok88oEkIcmHKbjvdrBSn-YzaKjeKwaaWQNRkAvWw4K
    lTg0V3BZmLwyn7LHg>
X-ME-Received: <xmr:dD8MZjGc43hTnZBIv2B-pXJj-XAMcp9DfuHSJQq18o6HQ8OR6dmpRuzfUzXa2xGU6irWKkDZvvMv5DWILKPw93RplEO9hDBNEszH--yEQIMy5ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:dD8MZgTzTLddNlcc-vjJMnONtcNy4Kqzr8mCr4ppoUxaNbqBHhQOuQ>
    <xmx:dD8MZgzVDOpcl3pEQXktk_zwGFGF8aeuspMWKWIiMztR6layukrEvw>
    <xmx:dD8MZm4a1n5gxpuW3HEppeDL96Oj0dY4kgmanWrDO8hlvwxw4X0Bkw>
    <xmx:dD8MZlym7ZBRgCBbbo4ADhsFVZ58whd_bDBX8D7vdnNkxjt4tryIug>
    <xmx:dD8MZs8fkl2p-QXv0g2DQeEnyVRV6zIgxPs9YK3TQyO0g7HGM88ZfKKJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:25:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7efabf8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 17:24:58 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:25:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 7/7] reftable/block: avoid decoding keys when searching
 restart points
Message-ID: <f53bf9e1ccc27c6d0a0fc320c36ca58f24e2d204.1712078263.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712078263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YKw11p1NoGu7aqAz"
Content-Disposition: inline
In-Reply-To: <cover.1712078263.git.ps@pks.im>


--YKw11p1NoGu7aqAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When searching over restart points in a block we decode the key of each
of the records, which results in a memory allocation. This is quite
pointless though given that records it restart points will never use
prefix compression and thus store their keys verbatim in the block.

Refactor the code so that we can avoid decoding the keys, which saves us
some allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index ca80a05e21..8bb4e43cec 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -287,23 +287,32 @@ static int restart_needle_less(size_t idx, void *_arg=
s)
 		.buf =3D args->reader->block.data + off,
 		.len =3D args->reader->block_len - off,
 	};
-	struct strbuf kth_restart_key =3D STRBUF_INIT;
-	uint8_t unused_extra;
-	int result, n;
+	uint64_t prefix_len, suffix_len;
+	uint8_t extra;
+	int n;
=20
 	/*
-	 * TODO: The restart key is verbatim in the block, so we can in theory
-	 * avoid decoding the key and thus save some allocations.
+	 * Records at restart points are stored without prefix compression, so
+	 * there is no need to fully decode the record key here. This removes
+	 * the need for allocating memory.
 	 */
-	n =3D reftable_decode_key(&kth_restart_key, &unused_extra, in);
-	if (n < 0) {
+	n =3D reftable_decode_keylen(in, &prefix_len, &suffix_len, &extra);
+	if (n < 0 || prefix_len) {
 		args->error =3D 1;
 		return -1;
 	}
=20
-	result =3D strbuf_cmp(&args->needle, &kth_restart_key);
-	strbuf_release(&kth_restart_key);
-	return result < 0;
+	string_view_consume(&in, n);
+	if (suffix_len > in.len) {
+		args->error =3D 1;
+		return -1;
+	}
+
+	n =3D memcmp(args->needle.buf, in.buf,
+		   args->needle.len < suffix_len ? args->needle.len : suffix_len);
+	if (n)
+		return n < 0;
+	return args->needle.len < suffix_len;
 }
=20
 void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
--=20
2.44.GIT


--YKw11p1NoGu7aqAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMP3AACgkQVbJhu7ck
PpQSrA/9EXCgnqKRHl74mEiXRlKlx5NEAb0PHs5Xa2GH1PYUzR6hq/qr0ZUp0+pX
HRER9zh8ql6+Qf8LlI1VgBXpaur6lnDIRPU03ejNhZYQfVjHYIJ/kaOTawKmCbOJ
Mdjt4BQIXAxXKO6Bi70I9kX3PRJ5LN1wfUrjPgyBbExpjlST24datcReXRAqDotz
oBobXgn4zSrmGHcL4rDp0/9+oSI9CPH0dXZDt8m5bZUJ/9y6JQ2dZv/C5Vu/4eSu
JKjIIkhyPxNparS+SZJ4eZwg0rxosakDslXNv54N3VSwZp4KVxlHXRTJvSdjaEYI
V4p4mqLN2GcZDb/D47AcKrIOZ1W08zhqb3KfuctvkW6K8ZLu6JCPJ3oq1JWMPMTJ
0YblPfsDzjE6NCPngsM665/frCXmvHbi4dH567lCXDEJbgFEOKygXLuYoevN9xrv
ebjAA3WIHZOX2+lM0SySZvXic6VjMk+mOpJnnsbR/i7sr0W8wQ5Y+5QTZlUHgJry
lYVgV6I5iLDqWd2lg7NZsPpw5PrysOZbxpJ9GaN9wf7AYqLrcEbQ46kI4uCnH98b
YKcMq+rZ6JjhAMxpl5XZ2+5Ld6KpSMt3M4D0fR4RG43KuBlo362pMyfpZr2jcXFp
OR1XmWVdF8TUWl3GKGApUNNKsnti/n1/+yzSgb6g3yBvjdCF+1A=
=8VVl
-----END PGP SIGNATURE-----

--YKw11p1NoGu7aqAz--
