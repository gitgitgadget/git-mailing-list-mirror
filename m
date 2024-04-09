Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA8129E7D
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632601; cv=none; b=bUE6itOLtnUvzxFL+IeqnNQd6Q4bu1lOukGskkuSuuGiqozJGr2UOkAS54pM27TUABQLIV8RrtW6MIBLgz6HONdrLf9PlZaByepUXBkDKIg2TSdh1pecNn+f6peL2kzULbaU+Frad2tGWQcnt6qJruV/E00A+VfKicJusHZ1GtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632601; c=relaxed/simple;
	bh=H2a9y/ewWL53qQHwORio4C6um9Jba9/8jpP5Islm1uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S247cmXtpaHqRpdEd1/EdmNgSor0/Tq/6Jw/DmR/K8J7ZJEdzMCTs6fKxT2hmCMefA1qTXrMUodJpvw/TEKJZoVP3cs3et+yeW3C0pRqSwUjzMqav/iCaS8onPiXECMVCcbVPOPFkZvVE7C4HFsw3ZCPFtLSLR5DeS3jDNzSHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dI+0DMZd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IaE8kk48; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dI+0DMZd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IaE8kk48"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 93D7C1380221;
	Mon,  8 Apr 2024 23:16:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 23:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712632598; x=1712718998; bh=WGRmGUMwHt
	ET/CQGbNVS0CFn+9I+6O+ASJrFJ7OKSW8=; b=dI+0DMZd+bnPEo/c8j+psps3J1
	bE9GI65vkrg9CpJcdlqfL71jwJlgBql6rSKDVpL2/JmywSFyaFobtC6fGYQT7AeW
	x2RSYHLzTAuAJ7QAwZY5MJV8OSwTwpU97CBSeCGSwLPBr2i66HjRNZTFtUPowpO7
	WRV8aDRSroEAx93fKbcAqX3G9SmAKyiM9+SqvmQ8RfRSSnjjqTKEjf1Eky0LPW+m
	n7mlf8sxRfjjzEL5yZglA7/kUngo8QPLpnzulVX3993etc6AU0CXAVbCc+er25jU
	8kOUo+PdGQw4ZFdUZa8erMXmacay60ai69E3dLmD8rhqFIArYn16DO9+8Lhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712632598; x=1712718998; bh=WGRmGUMwHtET/CQGbNVS0CFn+9I+
	6O+ASJrFJ7OKSW8=; b=IaE8kk48hx0GGVNCvMJd1HemrXoYYo55QMQ7VJaRd7Fr
	kWKDcEuIWYK8yMYaObgfZUw4+8WBS6JLm8z9bqbsMVmdM/p1n+Ulzc32cf0cV8hm
	IGSEg31i64Cah3FZbIa8Rxp3HV2ZdJcwiJgKskUdvj2GtwrUA8LtiN+OmzcYrTD1
	4pCAQ4QoOjLPGPPF0eut9EXfQQYcL4JJSPJV0lLIGi2AM1NXYbqnKJ2TcOv6B881
	frwDbVDGDTbxP5N6KTYpNu6ucgyG9F2TKho9ZhSSb368QzVKLm3/FHMEgQcdNTZh
	7LXuAkJ/gSOw5rINOHlwtneXcctPuW1dfwyUcGIv/w==
X-ME-Sender: <xms:FrMUZiw7zVuu-vIFHuu2rTAQ8N1epznbeXnJDUNlBgwUVIPQ9r487A>
    <xme:FrMUZuTVEXbtVoynF4Zb5njMy9w2lCNXFIyehk1rYvYMAbVr2ZmxnQHAqVoTKe7bX
    Wo-YcKyIwZjU1cf1w>
X-ME-Received: <xmr:FrMUZkVCUymSmzCq7kv-QHKbHpU9A-Pn7GuW2uHhGBl4xFdpqh7SDRDvLrZ7OxXRulD3ciN1yzIcLrksXHO_IwYTaoZYxpHuN6WCJJ0CtPGTgQlC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FrMUZoihfJgPpRVRYyY_warr54tmdxm9xYVdOBM0z75W-fu9OjxKIQ>
    <xmx:FrMUZkC71PtYeSRYWH0569J22-GOXI93yLrIozllcTBGQL6FbYZsAg>
    <xmx:FrMUZpLWtfnM-7DNVWzEv8M46Ncz-dCZeZZiiQWiLaDmrEPx6QcfIA>
    <xmx:FrMUZrAZaY50X3FWk6eVT4fu7m63H8BP-skO8tbaiYL6eUBQ9JPKvw>
    <xmx:FrMUZnO8d7dHB8XMAMc7x-Nh--gjZPJ6jDY2sSrUKZmA7Ln4wewF5mBh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 23:16:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ce6ae19c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 03:16:26 +0000 (UTC)
Date: Tue, 9 Apr 2024 05:16:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 00/11] reftable: optimize write performance
Message-ID: <ZhSzDxcEYgqauWi8@tanuki>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
 <xmqq8r1n5rdi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SNfKClXfmiifdlaq"
Content-Disposition: inline
In-Reply-To: <xmqq8r1n5rdi.fsf@gitster.g>


--SNfKClXfmiifdlaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 05:09:13PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > this is the first version of my patch series that aims to optimize write
> > performance with the reftable backend.
> >
> > Changes compared to v2:
> >
> >     - The series now deepends on ps/reftable-binsearch-update at
> >       d51d8cc368 (reftable/block: avoid decoding keys when searching
> >       restart points, 2024-04-03). This is to resolve a merge conflict
> >       with that other series which has landed in "next" already.
> >
> >     - Dropped the "reftable_" prefix from newly introduced internal
> >       reftable functions.
>=20
> Well, since I resolved the conflict and my rerere database already
> knows the resolution, you did not have to do the rebasing yourself.
> After undoing the rebase and recreating the merge of this topic into
> 'seen', i.e. db20edbf (Merge branch 'ps/reftable-write-optim' into
> jch, 2024-04-05), the difference I see between the previous version
> and this iteration I see are the following.  Please tell me if that
> is the only change you are expecting, and please yell at me if that
> is not the case---it would serve as a sanity check of my previous
> conflict resolution that will also be applied going forward.
>=20
> Thanks, queued.

The resolution looks as expected to me. Thanks!

Patrick

> diff --git a/reftable/writer.c b/reftable/writer.c
> index 32438e49b4..10eccaaa07 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -149,7 +149,7 @@ void reftable_writer_set_limits(struct reftable_write=
r *w, uint64_t min,
>  	w->max_update_index =3D max;
>  }
> =20
> -static void reftable_writer_release(struct reftable_writer *w)
> +static void writer_release(struct reftable_writer *w)
>  {
>  	if (w) {
>  		reftable_free(w->block);
> @@ -163,7 +163,7 @@ static void reftable_writer_release(struct reftable_w=
riter *w)
> =20
>  void reftable_writer_free(struct reftable_writer *w)
>  {
> -	reftable_writer_release(w);
> +	writer_release(w);
>  	reftable_free(w);
>  }
> =20
> @@ -653,7 +653,7 @@ int reftable_writer_close(struct reftable_writer *w)
>  	}
> =20
>  done:
> -	reftable_writer_release(w);
> +	writer_release(w);
>  	return err;
>  }
> =20

--SNfKClXfmiifdlaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUswoACgkQVbJhu7ck
PpRDxQ/9GjBGMkSBTEiW8RQd9lLe2CcZiiovBaTKg6EglCYd3PxCmez0DF3QQmOt
s4xOrVp/owHWnOkRupPW2SUqT5fCMTMURZ/Rv6L2Tzp9thUq4yVwVi2OTeAO6T8S
lRLrtmrsIKhngtL+4J1O2YmnBBDMQbZ3l7UrldiUDho0VLTuCxURlHgQahZm9/BM
3XgvohMusotXLjPUrjByN2nwkJtQqmBfNLTP3GxPm97ws4cQovZEQwA6WzF0n0ft
9AduJHqCjIfYkTIfmVBuHSPkPuuZdkGDUhkOqlZIUuTCaZsS9tM/A3j0FFwg0Ouk
KzivKGTUeAEdEL//YzKuDUZDgSDIdYrF7Dk5R8wGzuO8VPz5mAfc1iaFgy2k2OFZ
5ZhOIpZu51Y9Ivvweqn2z2I98Yl4jDmIYjUVbO5b0Qdawdplxny/w0j4+A/FpO+l
RUbkXWfb5IUEdlhW++DzTa6A5fpJOfIWY8/MtxmL5whNOjgIlovLvN7Y4H+wbogk
1Ocp1kjnIAfbdxXMTL3rRRCoD5r/yO5f9uSwkPuJGS5eOH0FKOFxwL9ooSaOuR5y
waizAZTQIZ+XzJDwHGNh/t98TypRcEerTHzJI6KgZys+Daa8YsHBJR2Brwn719rI
ClWFtEad73tSD8pc7Y/TJdNYfmaluUE6MIzAe8nXsTwPn8hOcG4=
=g9Mi
-----END PGP SIGNATURE-----

--SNfKClXfmiifdlaq--
