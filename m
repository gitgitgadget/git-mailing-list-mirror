Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A42F50
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093496; cv=none; b=GtSgeU9Iswpbg2lphMrEOAGR52kPNCprWCUeDGtIuCWL9MqA15X4oaK6ip8TdCRqyXYew1MkghTJ8BJRmLVa2oAkNeJv9Nrfvp5Q6loRIkLJnVdW4do47LkU8vamqGS8qflKfbxS/bY7VVXSPCdHGRjDhwsUugcZXVcFas0rbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093496; c=relaxed/simple;
	bh=aIVFXtlVSYaRRwGLoiv8yz7ZZnL9YBGzxw1VHTEEFK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLWMtKrH+FeIc4oX0L+aJiYa0erzvN8cQjeWyITnVtCZRaO9XYEr70klIPgXvYvdlFa6DGhXEdqENPpdFkSiQnr/rOIkNj8fAmdWCCUCqOvJhRU9GT5Dda1no/Lh37IL6Vg8H84s5VRhrF51R0IM5YoWLGhL68zMm+vkkkaHq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Trk+8aD2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NVqXIEfV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Trk+8aD2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NVqXIEfV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 835F11151C47;
	Thu,  8 Aug 2024 01:04:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 08 Aug 2024 01:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723093493; x=1723179893; bh=XHWNXkbpTO
	8rKb2EFKNX/fuvguY/ZxBsIylO5wqNiRE=; b=Trk+8aD2miM80jk6WEp1donUNC
	e52I44AjmTZlobuG1RD/1YPdK968hH24h8gYaEKzOHSZ0IE3e9WgLkjfBpWgqJIo
	ItGvVSzvM4BHpWUM6KFplFwfMaSwuwnYyXcGvN7XS0pK81IwInX6VP/b1jdJKn3z
	ypYGgOL+ePQgeYkTMt5dAMsjQ38UUxAHdQs7aQ5oeQ85AYeGAYsRFSS5eW5xn70M
	RLAPP6q28IBbYZ8qWQMZqT6+oKRypF4AvQXuKiQw+wsq9qLeB4CxX8S/9jBaT1gK
	AOPtmvc5m2EbZJChgPQZPdMvH9D3LjboJXISjmL8ouZi+7/xOQls6TJv0yRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723093493; x=1723179893; bh=XHWNXkbpTO8rKb2EFKNX/fuvguY/
	ZxBsIylO5wqNiRE=; b=NVqXIEfVCtCZ1ycjl52yt/uA3zNU70LjzkHz3qg+B00r
	RIHhsJY0DoBcAu3nYjLHW+OV/y9HavvPwpciwDsyMpTmya2fN2GtVvNqELs/dhv+
	yxXEmHrpZKMTy3P/OBNWtpyVczfQ0i8Oc8vFJ3huG9J5CKomCoJG94mCQE0VOiZ3
	7V7FHPedsPmQ5Qf3LXLcLvFW/8Edl+dOzKUabGevuI1TRyNjRnusSV1BGyX/6YW7
	7H8kkGGSyIdIjF3BVYKTDxurfxctGvat9MyL+jpJ2H1cL0OFG/J7yohN93McAX1X
	203KZV/9O7vWdUBRVAznbYNRBr9S2T2QSmqd0hpdtw==
X-ME-Sender: <xms:9VG0ZkAW-4GOnYdCM3slTCkXEGjcxjrQ8GV16K2bgOD3cgSx1bjnTA>
    <xme:9VG0ZmgV3Djq4TuUppQwoMahaxnqnbFICK3Q4tvfTmIXiNldrqrkUlVH3W23G1LvS
    iwfHUwPCGMiDA8JKQ>
X-ME-Received: <xmr:9VG0ZnnlMNQEcSrhjMd2QLKwZqslAJCkJF3hBRM1LH4iQk_bA7Tnu5F6YB8xkK8ck7k9LcBb9OhJ_XTjmp16cLr-s-W0ALgR2vGwEMYzQd9LqcqH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9VG0ZqzWawVDlv5SBVBvTqpQEsdEhWp3KYsQbIo0xedxxSe6KfaMeA>
    <xmx:9VG0ZpSznHw5tXMikMOU3_K_RbEJb2wWs1xSpzRt99x2KyQ1FBVeGg>
    <xmx:9VG0ZlYKZj0N7oA6whX1m9bvUQFTd6DAgAWkl86EddEE3avGYfMEVg>
    <xmx:9VG0ZiQ8oV9zr0RK9mUhmJKvxjDl6uoGRcGvWgXy_JaHzLzNqJwxbA>
    <xmx:9VG0Zkcf6wCjacMxgyVPqHG56d_ElFZBWjK9BRGOjC84LkeM01VRjXuw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:04:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9164ea06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:04:45 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:04:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/22] read-cache: fix leaking hashfile when writing
 index fails
Message-ID: <ZrRR8crXHBGvMdjM@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <2810cada0af14c3331674a807b20d18e6c9af022.1722933642.git.ps@pks.im>
 <D39HIJOL7UTK.29BEN5ZXSH4KF@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BzVET1eMFuDd3T4E"
Content-Disposition: inline
In-Reply-To: <D39HIJOL7UTK.29BEN5ZXSH4KF@jamesliu.io>


--BzVET1eMFuDd3T4E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 05:01:17PM +1000, James Liu wrote:
> On Tue Aug 6, 2024 at 7:00 PM AEST, Patrick Steinhardt wrote:
> > Refactor the code to have a common exit path where we can free this and
> > other allocated memory. While at it, refactor our use of `strbuf`s such
> > that we reuse the same buffer to avoid some unneeded allocations.
> >
> > @@ -3105,7 +3117,14 @@ static int do_write_index(struct index_state *is=
tate, struct tempfile *tempfile,
> >  	trace2_data_intmax("index", the_repository, "write/cache_nr",
> >  			   istate->cache_nr);
> > =20
> > -	return 0;
> > +	ret =3D 0;
> > +
> > +out:
> > +	if (f)
> > +		free_hashfile(f);
> > +	strbuf_release(&sb);
> > +	free(ieot);
> > +	return ret;
> >  }
>=20
> Is it generally a pattern in Git to use `goto <label>` instead of
> returns when there are multiple return points in a function? We're also
> performing cleanup duties here and in most of those scenarios but there
> are some cases like `reftable_be_pack_refs()` where the goto simply
> collapses multiple return points into a single path.

Yes, that's usually how we avoid repetetive cleanup code for each of the
return paths. `reftable_be_pack_refs()` is a bit more on the curious
side as the common exit path doesn't really do helpful. That one could
have just as well used plain returns.

Patrick

--BzVET1eMFuDd3T4E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0UfAACgkQVbJhu7ck
PpTSbw//fC7O4b/G2V297AIFJI+M5NOawiOaC3KV9X7KyT+eoUULUl8UfR6qg3/j
YbBvjGRcaqld0WGdkudrJBsdKLpLgw5gLrCxR4c2LssIVT5kD0dJXVS/qhovtPu1
IvFJ3aVtcKNin7kyFRAUQ1tGnOfxy+0Len6Hg+I8NZ51pDViFA+Buvyj5FVz4bP4
dG8S2xo0pLo4RuPb5ZBa+sq+CDkLIMWzCU2cQ947FuvCLqPjRxjZaxdf4EIxZQuC
QiXaWQxUeEZ8U9NodVFUOL424+GelemRJE2ZDKQw1QxPcQpioU/zBHmt/m9U2rxQ
H2WeuS1qX2Kxstl5p4j2RNbT80WUwKZTqsRK4iOTytvZfTiGq3u8g7di2Y0RiH7H
7Jhd4Zuv7k7QhP0VlLvbpb7HJ3gddnwSjFyGZAmebuuVd0GIrOq6gplrSLCt/X9+
qpWjg2kkmrhrXDzCZoI48cQAMQ5BuP0hKWZLxpjnZkCLzMul7Pl6srY4H6LdcYAb
zlecNYml0nTvpryD6htXku2RyxxHujWFH+gUYE/x4BcsQtdhMls8Bxxqd6YKL5Jq
7fVYInPnD8A2E+9+gAIO0d6vQIx/UXDCduoH+Rl4Md1UZReJzGXwTngd7ML1iABG
3Wv0mNm+L+4Q9a8K13yyNcrNxrB0XmZaqvgO7IxRB3ayCqUo3c0=
=6e+H
-----END PGP SIGNATURE-----

--BzVET1eMFuDd3T4E--
