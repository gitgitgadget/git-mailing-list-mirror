Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7413634B
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859902; cv=none; b=GSO7wt8vcYLXFbq8+SRIcQDUtON0SuB9PIDa/xlEEB6EQBk1RezqOrEuLYx9GPukKo7ne/FMR5Pf30ARXVJAfX588w0r2JbSSgcUzAzN+Lm6SCF+xEYr5jjaxtW9ui9AKp0Zeh0ao1cP7MVk+hGfK/lUBsu4iq6SY+N0w5TO7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859902; c=relaxed/simple;
	bh=HCJuiI/hQqG8nmHl8wf3ap4qwvrhSACXyYx1Ac+P6Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVT3p55uIT56qb2EtrJgTajbmONPV8Ck7OfY535seTE3wJ0V13sLRxHoHxbsdjPy1PQ1L46UGMjhBNDKHG2iJoC9ydJx3Qk1+o3PEvpiKpfksb3JRJC4WixJzVYc3Z5/6gtUO5a6d740HwoQvRKZFTQMYeIcWNtNI62YPCNwBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gl0aTvx9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Opfwqx+w; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gl0aTvx9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Opfwqx+w"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 253D11382976;
	Mon,  5 Aug 2024 08:11:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 05 Aug 2024 08:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722859899; x=1722946299; bh=MD9/veI0Zu
	pdCIHqeJWg5CS0EMlYQCZzwQbP8aXYsEw=; b=Gl0aTvx9kBlkG318hpxPblSlbp
	cvRkHPhajvp15PMWDGX+gGps4Av4cdqZFwcn3K+qsCWoz4BWS98zy2TWSBgdH82R
	wgqFjArA+i9syudJ44SNo3B6T1EGJCCKvWtvmYVAVq/dUjl44g82gPSXI7z7MiUf
	N/cY6vD3B04x+Er4Dn7yF0n9W9Gw7yb7qbWrj7JxkO7FHDaPM+p4AyXKkU5GXzQB
	2ZawA41KHXqKffM1ul+bM9AUtSsB8ImKBAJPxmcyWMVkBDYkQX7Ayk+n4UBUpMeP
	ibPli4XzoEPwDJEFzdfrPxTii90hgK4KsRZkdsHSDsuotqul+1PAI/m9zInw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722859899; x=1722946299; bh=MD9/veI0ZupdCIHqeJWg5CS0EMlY
	QCZzwQbP8aXYsEw=; b=Opfwqx+wb8eiv1ekIFGHDBQcu51BlXbXkn8Pk25acTDH
	osLntUJK+xg1lcwMWu6uToYVntqJZLxXiofeIzpygFAvZa8z4mlGWnCBHabaJMmm
	4JHqSic2flmUpxBstFMXLUGsCeXsf0KExlAHgO9CHgu5zosD05QFxtebT67/yPoF
	P0XBRb8Ul+hpfRySiFxhStLIolzdrhBkUXXrRvl53D3DDWjreDqd0GNQeGQHg+Nn
	6rndNkVP8S26q1COdUtTtV91uIpVxBmvKhTq659w2TCkvroYH7FxCIQ/BOGRf3Qd
	LP2PcqVkFPO+ER9aXoAeAllctuu7Oi+mBoJ4KVqfMQ==
X-ME-Sender: <xms:esGwZphprYJoBOmlNhlh7eeG3U8uZNwavtGks_hpAVDw7TZD1peQSw>
    <xme:esGwZuChyuC76h0ufalM3uq-MbNrq2tX6pyH9pcVxsNo3ZGm7R9IpPidX09PO3u8D
    Mcyg4b98lHvnrVgDg>
X-ME-Received: <xmr:esGwZpGEljXMwdmSH0e6rNPvd0LzBRML9tkzkC2Njt4PO9mny4JFZvPd0kiT9QD1pUMdCRajbamhzEfJ9_KmkDnfN074Ff_aOwVHynW76fdgPL00Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:esGwZuQjwESC0a04MRlEriU0WoMH2vBDNn_5LepSQAgYecPKjqrSDg>
    <xmx:esGwZmzkgfAU15j_R2YvEm6voapQLuQBZRutoaofcea9PeW23GNfiw>
    <xmx:esGwZk7m_dYXwv2jd_D22PTcarJq0FllD3lMqAeitxwYLGcuCHY70w>
    <xmx:esGwZry0ig2eYjK1NEygDDPTT_Tcoj-80Skqj3x2zB_nlfyVes0k9A>
    <xmx:e8GwZh-TBIKFubRey7HkkvbtlJhqjIKQ65TBaBZt_QCxxfiAu2ucqZ4p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:11:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 795643ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:11:35 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:11:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] reftable/stack: test compaction with already-locked
 tables
Message-ID: <ZrDBdesFvYFP7NLU@tanuki>
References: <cover.1722435214.git.ps@pks.im>
 <123fb9d80eecbd3690280991e0415cbb718b7202.1722435214.git.ps@pks.im>
 <xmqqle1ebpp4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vjtj1hhPbrOIkIxl"
Content-Disposition: inline
In-Reply-To: <xmqqle1ebpp4.fsf@gitster.g>


--Vjtj1hhPbrOIkIxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 02:05:43PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +		ref.refname =3D buf.buf;
> > +
> > +		err =3D reftable_stack_add(st, &write_test_ref, &ref);
> > +		EXPECT_ERR(err);
> > +	}
> > +	EXPECT(st->merged->stack_len =3D=3D 5);
> > +
> > +	/*
> > +	 * Given that all tables we have written should be roughly the same
> > +	 * size, we expect that auto-compaction will want to compact all of t=
he
> > +	 * tables. Locking any of the tables will keep it from doing so.
> > +	 */
> > +	strbuf_reset(&buf);
> > +	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[2]->name);
> > +	write_file_buf(buf.buf, "", 0);
>=20
> OK.  [2] is just a random number pulled out of 0..5?

Not quite as random. It is picked such that we can demonstrate in a
follow-up patch that auto-compaction knows to pack tables 4 and 5, while
leaking tables 1 to 3 intact. This only becomes important in a follow up
patch where we change the backing logic.

> > +static void test_reftable_stack_compaction_with_locked_tables(void)
> > +{
> > +	struct reftable_write_options opts =3D {
> > +		.disable_auto_compact =3D 1,
> > +	};
> > +	struct reftable_stack *st =3D NULL;
> > +	struct strbuf buf =3D STRBUF_INIT;
> > +	char *dir =3D get_tmp_dir(__LINE__);
> > +	int err;
> > +
> > +	err =3D reftable_new_stack(&st, dir, &opts);
> > +	EXPECT_ERR(err);
> > +
> > +	for (size_t i =3D 0; i < 3; i++) {
> > +...
> > +	}
> > +	EXPECT(st->merged->stack_len =3D=3D 3);
>=20
> Hmph, this somehow looks familiar.  The only difference is how many
> tables are compacted with which one locked, and whether it is
> compact_all() or auto_compact() that triggers the compaction
> behaviour, right?
>=20
> I wonder if we want to factor out the commonality into a shared
> function, or it is too much trouble only for two duplicates and we
> can worry about it when we were about to add the third one?

I was also briefly thinking the same, but then didn't follow through
with that thought. In fact, there's multiple places in this file where
we populate a stack with N tables. I think it should be easy enough to
pull this into a function indeed.

Patrick

--Vjtj1hhPbrOIkIxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawwXQACgkQVbJhu7ck
PpRg3Q/9G5EoOfctzgZChR1/HytkCZyfE11KKXZweqaJ1Nd3of1971cd6LHVNZ//
GpjuV+rY4vLAj4vqIdI+eY3XQh4qowJEfV6f/72fk2/XCRb/oRbB20fq8h5ZdgSP
v6UW+bAQ2CMhmk10U+V55FIVKw11S7k3Dnm0E9WQiwq2xinxrWRdE4xyiOpmpx8Y
lPrS1HFpPNLm5MqV68KiPFLYXur503CUSutIem7NloHgPo+v0TWDZS8Iv6i36gI7
tbEkJ3jHLB5VgBXfb7AvnJ3ftEOARnQxw9lZ9sVWF4jaJQt570uZ8gESSJTlVd3E
Tr+jzGGozolDTzzk9onBiUvuplErUi7BY10ARZtu2XfwCphmD/A+t96tfWobC7mv
40Eq5bi3Nd6Tmf4MhQzVSEdrb5p2Ltwd2mQBeuw7YtGQmf79h5skdT6huC3/q12x
/51UPsQULfGm3ZrKJpHQMsV1ox8Ruf2gKR2P5WeVI1tqp1aMssc/0NGX3oXIvRVY
XsZIQlGSKjIhC3BPKDMK/h8iOP0WoR5wdK/tzGLbOqjUlMQ6RGbHoCR9rTmJ1qQL
jZuWHYmw8KhdRCRcDQ9mPIy2NDV58vqpThk6VtRDXOYJCE6VFW9zZ/8HD9wwoIUG
qYi8JE1UpT2icAxKuBUojKfjVOkGOxh4A/47ZU25XV48HtWzjCg=
=XYpo
-----END PGP SIGNATURE-----

--Vjtj1hhPbrOIkIxl--
