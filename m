Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B731BC23
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735951; cv=none; b=i7TyJK+a1ftkBA9Vl0pHaDOqxHbXI4/XHAGQWHfg6negM3x9FfUvcsx71jXX/9J9mcaDuruKUryIxkvR0U8lxaqojGipdUb9+dEr1+0N89DDgzRm3jHqEI9WW9BmdkFJZ+X4utow7aLv+7wYyJeSPSlYRNla7EvfnFht/7sj3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735951; c=relaxed/simple;
	bh=M5/ypRRhsLQTnIxdpbhfVqs/YbsaNrp9sDVAHvx653I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POib0ugr75v1Y2/mNxKwvbEQrHkUfILxZ7no6blzaMCu9xuBg/v1sTLe1GSCKXp+fm4m+nkRq2AWNrMldgFgJpIjgiBnHlP3rGrbz0r+rLp9d+EjUZ5yyTDSQrQC41x9GAwF3FnF1+mDWX/LIRzKLKOKfFpNJyWfgVIW3jv9rGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NK3rhw2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LGkyr2/j; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NK3rhw2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LGkyr2/j"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id B3ADA13800FA;
	Fri,  7 Jun 2024 00:52:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 00:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717735948; x=1717822348; bh=JHBf1k5RbC
	z6liAbfT6mL+irPhXw2f1H1mbH5lRAynU=; b=NK3rhw2YLCBbMvljsSHHpKLhhz
	vl2p2eHNJiporec/yPpZRnS8HiVefEacPKK9KKUm3u8nyIg/eKW4psCfPby11izM
	HDQtG7clJ1nT2luVtGtKwKlH8RE+xdgRMOPglPO17iHtDBS/Vt44UrhUuo7DfkeA
	xD+xBf+MqJqXqQLg8xAhOa90tmtcBxsBHD68qnMOZvHYj3iB7lJmGB8/y4p7yho3
	u7V2qdu21fpYLCN/Lp9n5+FucHMwptq0Jw1nmcoROHHZ0OXSJ0ZNU5cnVYSb1e0Z
	DfWck/dTFgwx8LIs7Lgm2mS2eO4qvaqwGX/l1gQ1TDaKc0lEYPyMxeKmKXuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717735948; x=1717822348; bh=JHBf1k5RbCz6liAbfT6mL+irPhXw
	2f1H1mbH5lRAynU=; b=LGkyr2/jFsAtNA0VEenrtaeSHgQDp60aMjQvqew+AZB9
	dWbyetAvZMp8bFb46gFXDvXThpkYLsCqwQo+TTVXftzyM8AT6iYfCMYXlBKsXpZ2
	jRpTLIRbU2+nXWZIGvhATiGGoC0mAogtcjdMBVyT8QDuFxXGPjwv777xc0NAousX
	OdNtZ8BWHkRKx0iNXgJd+qYgA5GZ8eP/rvLo2ceMk/UxCgsAN8o1HDumxtQ7vqxv
	kt1Foe1VqxTkdQwmrre5Trx182xBRS3w6U7O8OqwQ401H3QcOpQck7xeTjnVySKN
	1CYa3kI5bdWHKKi8W96+XZ10utiqV0tSoArvUggeug==
X-ME-Sender: <xms:DJJiZhneaizDceisyZ_GDB0uyg97AKXnhF19lKuvJDwUKEfuj2h0-Q>
    <xme:DJJiZs0iDaK1AicsU2uUag-nKoOIFaN_JzJkmmhokbqBcWjnjoQuO1hd6HMjNvA6c
    Rm5aq3ZkCDbVUqPCw>
X-ME-Received: <xmr:DJJiZnpXOJ_mUXi308_U7nneiwcivIh5RJkUA_rjwwF2YVfOEXTYgV-b2RjWeaPAw-hijGsU9PHETIHPKwln4hkVaq0oA1MhZ_5Ns3-cOWlYa4QX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:DJJiZhlH8B4lMnYj4vIPzfcmMODeFU1HTXUpFDZGsasdK8X3l3lXHQ>
    <xmx:DJJiZv1_foEYdQIPpBpk6FsbBs_iEr0vApnylztPVFvHMDFl1FZGdA>
    <xmx:DJJiZgtp_K1MyKxb-82GQ-52amHmSdD7d7xfSyP22mE7waUvRD1Mdw>
    <xmx:DJJiZjUtmq2Jtg5026H-zxastML5ANm-XASMvRuPxpY0s-4WrZniWQ>
    <xmx:DJJiZqRNjuvpuQV0BUmgwKe6iYUgY1HvZ68xT7uA_jD_pOL-zLBmlPO4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 00:52:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9f27bb51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 04:52:25 +0000 (UTC)
Date: Fri, 7 Jun 2024 06:52:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 12/27] object-file: mark cached object buffers as const
Message-ID: <ZmKSBwqIkOLUhOlK@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
 <ecca8e973df77cfc8233ab63bf7d1f6fa83031a3.1717504517.git.ps@pks.im>
 <xmqqr0dapq1s.fsf@gitster.g>
 <xmqqmsnyppo3.fsf@gitster.g>
 <xmqqa5jynimn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z/CWqTOz3GAG3Vxu"
Content-Disposition: inline
In-Reply-To: <xmqqa5jynimn.fsf@gitster.g>


--Z/CWqTOz3GAG3Vxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 09:25:20AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Indeed, that seems to be the case.  With the attached at the tip of
> > the branch and rebuilding 'seen' seems to pass these 6130, 7010, 8002
> > tests with SANTIZE=3Dleak.
> >
> > From f307bbf7bd317d90db29bd1589b49e84b9e37e88 Mon Sep 17 00:00:00 2001
> > From: Junio C Hamano <gitster@pobox.com>
> > Date: Wed, 5 Jun 2024 23:03:34 -0700
> > Subject: [PATCH] fixup! object-file: mark cached object buffers as const
> >
> > ---
> >  object-file.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index b5b5a59dc6..2d5bd3a211 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1785,8 +1785,10 @@ int pretend_object_file(void *buf, unsigned long=
 len, enum object_type type,
> > =20
> >  	hash_object_file(the_hash_algo, buf, len, type, oid);
> >  	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_=
QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
> > -	    find_cached_object(oid))
> > +	    find_cached_object(oid)) {
> > +		free(co_buf);
> >  		return 0;
> > +	}
> >  	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
> >  	co =3D &cached_objects[cached_object_nr++];
> >  	co->size =3D len;
>=20
> Wait.  Why do we need to allocate co_buf that early in the first
> place?  IOW, shouldn't the fixup be more like this?

That is of course the much more elegant solution here. Will adapt.

Patrick

--Z/CWqTOz3GAG3Vxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZikgYACgkQVbJhu7ck
PpQMYw//WL0r67KYYemQ+2jWVnoBBfAQJAdYe6zhVBnto/TFUJBgmIWq1SsAKnzu
3Y7B6bTIdRJpgMKRWHpM9gvrvxTSBhqAKm33E+H6tZF997L1LikSP2vWA1IqAN2F
9JiUevEmFaKYQlOxjdZSNMxGwuAP1rAbJBVBDtdeshcA17Z9/Br4YoFO8cCPyNmY
Q0ABwpm+w47Q7sb5meJIPdtoZs493j4aLk1u41YzOaMN6nz5I7dZpMzIg24PzVn7
C0VIILTeDEQJ6Qd1iWu5iN7qDP9VoMzjE2gbZJ4++70/orbKu4yWG4NJVJfEDW4i
9VMTktY79CpGjrfox4DzQk3XU6Dp7BgICvzNEMIFS9kzW0FiBeeX+2KCct1HvkG9
wOvDiYG5c6ztCHykubWpPci6ewlnMy3UlKibn9JeMR49C23y18UmTpI/wlcj0949
U3vbwte+fyNnAXxaHqOCzUpbg2AKvVrw/Fg/RdWkpgIHgy0yOPCh/xjz/lTONjQP
3J4Ajx4P7a194rYdwrrNm4NkyzAfUv1voaAq3SPC+h3VXCmFqOA7U4dHCi3YB6D7
ybnRguAmRHRqDJtJoPEAzWwhsoxMsHCibPxf/Zk2CJQAgfe6r5WWr/Z4VCWfDma3
40xtKd6HJHdijNHl+djdqONu8iOZ18mJfX4serH+3eE1Lc3764o=
=aTpy
-----END PGP SIGNATURE-----

--Z/CWqTOz3GAG3Vxu--
