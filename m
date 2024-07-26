Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF617A92E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995563; cv=none; b=EecffcAxbu+y/D7sshndfxz2ePCue45lXF2AyeTVYyVlJ2kOV4xPilm/vDgZr/S+WM8fmiS0e92iCAXqPi9uJ9FgOy6lPKCWV0yTZnZCd0kdQgwd7iq56QzD6/Jo6ppFaw8IAIA5CLs/Z14sVZLqYghBhA49EHg5F9pXPy4rfX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995563; c=relaxed/simple;
	bh=cl8wyQDnF1rtdwO5RKVkyY/e4wWtzwbRxLT67gBZXTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqfSVOPBuTeTjPIGwuqIDxMtuXf7UBrzWlvnhLYprtufa4jW8Tuk/lWOQYpMDnvyJjn6lh2+GFse9/74ABU8OmFibprs574r6QVlB+Yi0WDqLQ8y2LCUhpqv1l5dqrtpQdSnerEaJ+B/6or6Ds4remeDxQHdbz+vGC3ILfqUXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GmMSIGNm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GRf3mmqw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GmMSIGNm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GRf3mmqw"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A28361380149;
	Fri, 26 Jul 2024 08:05:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 26 Jul 2024 08:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721995558; x=1722081958; bh=CINlApRmod
	/kQagE3LIOC7vyNFIBvvKgXIiYqm8uf38=; b=GmMSIGNmb0/X0MchmAhuGKdGdc
	SuxxaSnO/Hfe/k70Tx+v+yrB7EThelYPymRbygb05V8emiGXOWRkP7YSSNddpwTg
	zmVsIW4zhHT/f6jtHz+LoU1b/Cm1D+p2lJV3E/Epv2JPt59o5pPcSlrSFQy9yn5q
	sQeXW8aXQ4IeMinap2jPVjxsE+i3RTnforYtTd1XbOpe2GEZ9ERqA2J+Dn+efXrq
	dQcy4lRxeb3TT7uhir2/UhWrcV95NN5XzXHt4Rx1Jxw1/jxSDYYXpx+v22YMNmil
	8OSHImV2sIrBhG6QzljVFm0AkjU4TuQbtiXTtM+aS8tGC11FVOawJmXsLfKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721995558; x=1722081958; bh=CINlApRmod/kQagE3LIOC7vyNFIB
	vvKgXIiYqm8uf38=; b=GRf3mmqwzRtvIYxIJ4bfJ3WgzxvmzQs4T/Zhb7h6cYH0
	HRsLG29VchoLXbyK1iRs/0salYe/uzsSUcRVes1wgg0sfL/8yVfSd0CNa9wDKovl
	9Ysn0ioZjYRFoaBmqLc/wKQg8+qbhTwfmHx5X8oNOiCejeFfkxhgwj29Ay8F/kjR
	1ntebjV3RKA6SFqwi+e6lBPn5n5JNJouUn0mP2qduiqvByNNyGeSMpzJQvheSxa5
	+vx7z6xTVMQnbbSHgDG/LxQeYhfRubH25GsJWY+WMdAnT2QLgMbpBThSsaxjL+Du
	biWbXyxS/J/6j8xHszQuWVbkMw1gsFLveW6vtHTrVg==
X-ME-Sender: <xms:JpGjZvi9uQVJ5zp3RUqKob5twqCoOOdh7-0-e-5oD1-Aa0WSPps2Xw>
    <xme:JpGjZsDOWMl6EWiL3zRwcdZtc1wGqSleOmAZ4vMewsIhrlamfvPZJKv-kVC-lsr13
    Xb6Va1cbRuh4Q2CnA>
X-ME-Received: <xmr:JpGjZvHf8JQSxmLuHS9ZxqufxjkbtYAq5G3iaDr7haQS7UyR2AZLjE-7iZNVuLuKAjqZk7CS-MIOQ6W5J2tNcERPHdHs-xFbkVzD5GFXPPLkN0eU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:JpGjZsRL0Ygiq-uXvtbPdsA_Y-aCnl7tZSe4iZij0eWwxUazHGaCUA>
    <xmx:JpGjZsweI1hPC-kDxem4BwGpIQNtRt6r58gRksRsfTap9BIqwpuPMw>
    <xmx:JpGjZi4BluHT1bw41wMWSDRUr8sJR9j28mbOXSfBQ0-6RadjmV7FmA>
    <xmx:JpGjZhxm8z7wuhQpUiUTin_jNVRqEq45UTl9HnyhnA7OEzq1OAQMDA>
    <xmx:JpGjZo8eYOIhmTbWqEqFuyCnPN-pkSAIcic62VI-7W2c60Lp8k8ytv4_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 08:05:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bd98c8d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jul 2024 12:04:35 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:05:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] csum-file: introduce discard_hashfile()
Message-ID: <ZqORDmTj4GT0Eeqq@tanuki>
References: <xmqqle1p1367.fsf@gitster.g>
 <20240726044216.GA642208@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="swi4b4bO2k+Sc2PE"
Content-Disposition: inline
In-Reply-To: <20240726044216.GA642208@coredump.intra.peff.net>


--swi4b4bO2k+Sc2PE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 12:42:16AM -0400, Jeff King wrote:
> On Thu, Jul 25, 2024 at 04:07:28PM -0700, Junio C Hamano wrote:
>=20
> > Introduce discard_hashfile() API function to allow them to release
> > the resources held by a hashfile structure the callers want to
> > dispose of, and use that in read-cache.c:do_write_index(), which is
> > a central place that writes the index file.
>=20
> Nicely explained, and the patch looks good to me.
>=20
> A few small comments (that probably do not need any changes):
>=20
> > +void discard_hashfile(struct hashfile *f)
> > +{
> > +	if (0 <=3D f->check_fd)
> > +		close(f->check_fd);
> > +	if (0 <=3D f->fd)
> > +		close(f->fd);
> > +	free_hashfile(f);
> > +}

Are we sure that this is always correct? A valid file descriptor may
have a zero value, and we wouldn't end up closing it here.

> > @@ -2992,8 +2992,14 @@ static int do_write_index(struct index_state *is=
tate, struct tempfile *tempfile,
> >  		hashwrite(f, sb.buf, sb.len);
> >  		strbuf_release(&sb);
> >  		free(ieot);
> > -		if (err)
> > -			return -1;
> > +		/*
> > +		 * NEEDSWORK: write_index_ext_header() never returns a failure,
> > +		 * and this part may want to be simplified.
> > +		 */
> > +		if (err) {
> > +			err =3D -1;
> > +			goto discard_hashfile_and_return;
> > +		}
> >  	}
>=20
> There's other repeated cleanup happening here, like free(ieot) and
> strbuf_release(), which made wonder if we could bump it down to the
> cleanup label at the end of the function to simplify things. But
> probably not, as we are often doing that cleanup even in the non-error
> case. And of course the "sb" strbuf is local to a lot of blocks.
>=20
> So even if we did want to do it, I think it would come as a separate
> patch. But mostly I wondered whether the label should be a more generic
> "cleanup" than "discard_hashfile". We could probably worry about that
> later, though, if that separate patch ever materializes.

Indeed, I wanted to say the same. I've got a patch series sitting around
locally where I do this. I guess I should send out my memory leak fixes
sooner rather than later to avoid duplicated work :)

Patrick

--swi4b4bO2k+Sc2PE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajkRgACgkQVbJhu7ck
PpRrGw/+NIoAw83x1a4SDq7iQh2bBpZv1imtrGnPhv2DUu1fEeBI8BjykVLT8gYx
4zfCWTr9AnZCs91xd7VNXElNGxL8ZpgKUPJ5qcw1yAkoLyAJLMKjye8csikZBJ9I
MELjKDtvvF0CfqlbImK9VxdoEnsUWcQy/gDI4SqgqZ2y9dsh4GLq75wR9vh9a36q
bhI8nSd2C23vRVH146UyJn+HM8hCgXd9lBIb9hEwWfLAR5QFKS52Vpmbn2J43ABC
RIMwEf+i4HvUZeiHhU6g9eKzEdF21KVvl9AOlYZ91Qoyv3Wq1n5CT8wpsRKEwr+T
IyqGltpM8zByqcoCavd6wwggGw4CathSA5I7xp0p0XuV0bXmiAg+Y2LHv2oVN0mr
FBeuH0HZgf54ieiU0f5ZtGOfkGgl3XiVOHNRx+k1bwU3F3AplBf/PxhBmAkcLWj1
B0CR85M3n5XALadLsgd0A3P1XduOwZX3Z16sCK3MGSITx11qqVNhHGs7JwCebS2x
Y75tbqI2RpTl1KXKv43B1JTNkJW7cavg3n9AoTwitjXMiq8VZ+fdnhVjv9i9cyUr
iTEGKRmnSNLEMVVB/+4Wr8b6MGsb6ekrLKnDkRa4p0Y2eDR8rO7U8icDFVBDDeTe
nrNUSLT8uWr6IQUMQWWMNXYWldgNBF+qpv8qOXdTwwOXZ+cdhsg=
=aTYv
-----END PGP SIGNATURE-----

--swi4b4bO2k+Sc2PE--
