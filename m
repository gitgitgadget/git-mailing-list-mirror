Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347DB1482E1
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149820; cv=none; b=b4pvtlo2m04gKBh4LbNSirZ8364DZw9TaOPL0tjM3544+Lsd2JlbO4sVaFgLeEtKjYx2l6trCehB59E/OP1xlHTi3UE1jRa4S4EVq8NIGdPo4GyOmGioDR3jHuFgr5wS2hToIrkAAlk/xF60CjpdQ8Ov59zhx02FDVStC7UR/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149820; c=relaxed/simple;
	bh=kFknFjhcIQt8hXIDgchkiGq0Vzv8NtI4XiRPqPVdOMQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyCQ9BdYcQt83hroNl0k28hGSIpBdnNa3XSbFipuPEfVkr1yV+/ivFIFcc7nqZ4MphMS/rpqkJthIam56nVa5LOnEl5KcVxaitKC/2weF2TJOkHWQrEWFTPGDyrprgI78dF02XJfkkZ1vGWEWmVyYbKh5yMEBUsjPIQ4YBlcT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FYWRD0wC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xj5UKymk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FYWRD0wC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xj5UKymk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3835813801EB
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 09:10:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 03 Apr 2024 09:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712149817; x=1712236217; bh=RNnldwmq7p
	w235VePTq2O+nPHhCWHYFbM3aq8yUfwHw=; b=FYWRD0wCULnDsYyqLLUpyi/s1X
	SMLwyJcakopwbGv+xSMYSRlCV3DHOKNfMKMkVtPYfH4kCyKN4ObItiCQq42USAqG
	4KqdD+GXQU3mYmmvM47jjq585GzmfuZimXV4vxg0YdXJGB1XeY0enCeUfFrgcikT
	XUJTN26a2LH3FSXfqzEtbYgURDBytDQ/1X0hOKl/RnwbElPv78+1necoSnfbh4Qt
	lZ5P+IB/W2xKUVpXDGdzaHHq8RhGaa+Jq2Hj5K61QdjeIP9b1SEWjJip0xfoqtxm
	1I8duoLCEMUNEO3ohB2S0S5Ue4uNpR07p2hSDkS5cfZnfn8A1QKsuoaohDfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712149817; x=1712236217; bh=RNnldwmq7pw235VePTq2O+nPHhCW
	HYFbM3aq8yUfwHw=; b=xj5UKymkSam3STaZNk9L3mMxWIu2tXiYxLv+HvyFQ+YM
	6qUwZNasH5/D3db0fZCj5HJoFCnRY48BZAX0+eKInjAAB3tfzXRl/flhYlujpvWk
	4cte/z5dV3t+mFnvK7DNldwOD6schE+l2CmiHlVTEz2K/KIY/pokVUzqr2h5Rf6f
	/vH5ih0/zy9qYfioaYFvdNPX+tIac1FaDBXd8C0p/jCdG8KoIMSKymbqb7agHT7N
	vlV/JkjaKRvKpQdD9yjsay2q8sEI8BsdvOZtt500JThgdGt9EIkclIgJ6n1wFAJG
	+MWQh4fOfQxsYR1adzw3KdwUNN975Uf0HqvMiAFZ4Q==
X-ME-Sender: <xms:OFUNZnM98KITtN-QYDOOsw10bFzVqVdV8_UKdeOviPVAhvcrtjooZw>
    <xme:OFUNZh-Yed-2QSw2jk-81A3INr0qaiyoaYi_KzqI0UtKOQxX6DP6CdzrL9ND7Q8Q9
    Xkta0wXwz0htdky0A>
X-ME-Received: <xmr:OFUNZmT3ZXvIQv6m9rNDHsDLAqgxIrfIJLD6IWNtD2goxkCAPYU0tiH0RmXcbFcWPyfhdbVUgUAnnyUrMBhdOkb_0Z50sAkqhFpzPxxnZswqFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:OFUNZruZwTOk2CBfp5e5rMSBibnjWjoMZf_uu7JS6a9DkjK93VpThg>
    <xmx:OFUNZvc6NBhGZGgtu5HQ4KrOldnn9gz1Jh3kHeWBNNJW7kUpZ3Z-Lg>
    <xmx:OFUNZn2h0Ukzmvqyx-QrLSwe0Ow9VNF8vfq5IEJB7uVIifdlEchR9Q>
    <xmx:OFUNZr-hMX0CrEhI2sBwI6l9kUM0Fo_apnHJ0HGc6CVcegt_jNrvIg>
    <xmx:OVUNZgoQ2Tp_byJnTGQqzEAugLuhRFQlVbEgYT-Nv-Nl79-ecc2PswaL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 3 Apr 2024 09:10:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 321113f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 3 Apr 2024 13:10:02 +0000 (UTC)
Date: Wed, 3 Apr 2024 15:10:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 5/9] reftable/block: move ownership of block reader into
 `struct table_iter`
Message-ID: <Zg1VM6fz3TnmTGqy@tanuki>
References: <cover.1711519925.git.ps@pks.im>
 <f10882a0840a77f2569cf891374b70d1e84ceb4b.1711519925.git.ps@pks.im>
 <hwfkdfilniy46usnc3vnksaphdxboi5bxep4ek7aj2qxfhu332@6ym7dnn35k7z>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bL8WFu5ciYxbvw29"
Content-Disposition: inline
In-Reply-To: <hwfkdfilniy46usnc3vnksaphdxboi5bxep4ek7aj2qxfhu332@6ym7dnn35k7z>


--bL8WFu5ciYxbvw29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 11:52:58PM -0500, Justin Tobler wrote:
> On 24/03/27 07:37AM, Patrick Steinhardt wrote:
> > The table iterator allows the caller to iterate through all records in a
> > reftable table. To do so it iterates through all blocks of the desired
> > type one by one, where for each block it creates a new block iterator
> > and yields all its entries.
> >=20
> > One of the things that is somewhat confusing in this context is who owns
> > the block reader that is being used to read the blocks and pass them to
> > the block iterator. Intuitively, as the table iterator is responsible
> > for iterating through the blocks, one would assume that this iterator is
> > also responsible for managing the lifecycle of the reader. And while it
> > somewhat is, the block reader is ultimately stored inside of the block
> > iterator.
> >=20
> > Refactor the code such that the block reader is instead fully managed by
> > the table iterator. Instead of passing the reader to the block iterator,
> > we now only end up passing the block data to it. Despite clearing up the
> > lifecycle of the reader, it will also allow for better reuse of the
> > reader in subsequent patches.
> >=20
> > The following benchmark prints a single matching ref out of 1 million
> > refs. Before:
> >=20
> >   HEAP SUMMARY:
> >       in use at exit: 13,603 bytes in 125 blocks
> >     total heap usage: 6,607 allocs, 6,482 frees, 509,635 bytes allocated
> >=20
> > After:
> >=20
> >   HEAP SUMMARY:
> >       in use at exit: 13,603 bytes in 125 blocks
> >     total heap usage: 7,235 allocs, 7,110 frees, 301,481 bytes allocated
> >=20
> > Note that while there are more allocation and free calls now, the
> > overall number of bytes allocated is significantly lower. The number of
> > allocations will be reduced significantly by the next patch though.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ...
> > @@ -340,14 +344,14 @@ void block_iter_copy_from(struct block_iter *dest=
, struct block_iter *src)
> >  int block_iter_next(struct block_iter *it, struct reftable_record *rec)
> >  {
> >  	struct string_view in =3D {
> > -		.buf =3D it->br->block.data + it->next_off,
> > -		.len =3D it->br->block_len - it->next_off,
> > +		.buf =3D (unsigned char *) it->block + it->next_off,
>=20
> Would it be best to use the `uint8_t *` type instead of `unsigned char *`
> to match `string_view.buf`? Not sure if it matters in this case.

It doesn't really. `uint8_t` should always be equivalent to `unsigned
char`. I'd also think that `unsigned char` is a bit more idiomatic in
our codebase, but may be mistaken there.

> > +		.len =3D it->block_len - it->next_off,
> >  	};
> ... =20
> > diff --git a/reftable/block.h b/reftable/block.h
> > index 601a1e0e89..b41efa5042 100644
> > --- a/reftable/block.h
> > +++ b/reftable/block.h
> > @@ -84,16 +84,18 @@ int block_reader_init(struct block_reader *br, stru=
ct reftable_block *bl,
> >  void block_reader_release(struct block_reader *br);
> > =20
> >  /* Returns the block type (eg. 'r' for refs) */
> > -uint8_t block_reader_type(struct block_reader *r);
> > +uint8_t block_reader_type(const struct block_reader *r);
> > =20
> >  /* Decodes the first key in the block */
> > -int block_reader_first_key(struct block_reader *br, struct strbuf *key=
);
> > +int block_reader_first_key(const struct block_reader *br, struct strbu=
f *key);
> > =20
> >  /* Iterate over entries in a block */
> >  struct block_iter {
> >  	/* offset within the block of the next entry to read. */
> >  	uint32_t next_off;
> > -	struct block_reader *br;
> > +	const unsigned char *block;
>=20
> Same question here. Would it be better to use `uint8_t *`? Or does it not
> really matter?

Same answer :)

> > +	size_t block_len;
> > +	int hash_size;
> > =20
> >  	/* key for last entry we read. */
> >  	struct strbuf last_key;
> > @@ -106,17 +108,22 @@ struct block_iter {
> >  }
> > =20
> >  /* Position `it` at start of the block */
> > -void block_iter_seek_start(struct block_iter *it, struct block_reader =
*br);
> > +void block_iter_seek_start(struct block_iter *it, const struct block_r=
eader *br);
> > =20
> >  /* Position `it` to the `want` key in the block */
> > -int block_iter_seek_key(struct block_iter *it, struct block_reader *br,
> > +int block_iter_seek_key(struct block_iter *it, const struct block_read=
er *br,
> >  			struct strbuf *want);
> > =20
> > -void block_iter_copy_from(struct block_iter *dest, struct block_iter *=
src);
> > +void block_iter_copy_from(struct block_iter *dest, const struct block_=
iter *src);
> > =20
> >  /* return < 0 for error, 0 for OK, > 0 for EOF. */
> >  int block_iter_next(struct block_iter *it, struct reftable_record *rec=
);
> > =20
> > +/*
> > + * Reset the block iterator to pristine state without releasing its me=
mory.
> > + */
>=20
> Do we want to make the comment a single line to match the other adjacent
> examples?

Can do. I'll refrain from sending a new version of this patch series for
now though as none of the comments really need addressing, in my
opinion. But please, feel free to push back in case you disagree.

Patrick

> > +void block_iter_reset(struct block_iter *it);
> > +
> >  /* deallocate memory for `it`. The block reader and its block is left =
intact. */
> >  void block_iter_close(struct block_iter *it);
> > =20
> ...
>=20
> -Justin

--bL8WFu5ciYxbvw29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYNVTIACgkQVbJhu7ck
PpQQMQ/8CoTuGiHREUgvauNbUy+ON6Mto+pmgqZCEmQXIroNaZ5OsvZgx1NEEDVx
XIW+NY4D22EHT0jSXXiSLX+UljbMrXPK+6ja+o7zzUl4fwox9bmRUOBzvucat4g+
Tlu+6o4zN3k8nN2t94vX6R9bcwGspfNYPraI3Wivvxb/FXJB/3vYAcKodmzZad31
lR+pDugRwu27GuY9EueworX3Ai4KcBxfDYYePI4N7MElzw7shQmhYFjh18FvbBXt
cteJFh4edCVhVkd2S2sI9jHAHgQ+TOHyiDxCpMWKAy+uD4XzpxPQ26IZLlOCbc2K
w4K2NKe3zCAPQzG7JdZUG5JnYoZDbmiM+f1qkkrYQgDxRoBmT1mfi+gIEvI554oO
skT+DLThiKaGE8MDlozfER4z1u0FVDznVWNjxqYHI00ION+XoWv0G05GtDQLYhw/
kzVEpBvBDchLz5PkvKqgPVZtDvUew7X4ffv3+vhjXpjMTf5tRUoKgU+9oKDne1zj
WFGl13MKIT8ZNUHy8ECVbr0agmzalBRVnKiHqDi1VZoC2Hia5p4G/CESgwdVH8c5
hd9g+6K81YDHtyfUwPMnGvl4uLgXH5w6X5SJWJ+6ff0iKA2qx4Lxw4LQkhFmyEIK
kkQaSiUMK+y8kH9JP/FL+8ipHctPvlZbwthwEfeN0SJKJgAD3YY=
=zQx7
-----END PGP SIGNATURE-----

--bL8WFu5ciYxbvw29--
