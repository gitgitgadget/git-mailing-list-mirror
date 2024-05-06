Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38901140E2B
	for <git@vger.kernel.org>; Mon,  6 May 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982328; cv=none; b=eaJQMNjmZ86mCPFSD1yBYvJqZ8EYdybCXudojR2aOML/K3TGLOuGLDMfaPxQoYRCwmlJwWkV7AqFeE7BpiM1BbzWmoxsmncemQfI1SNwwmq24YT5v1UjsV4G042Kl1Bhl/h/MP2yc7+Wd3JMQY8WoZXwxEwvN2UJsfW/Ls25V4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982328; c=relaxed/simple;
	bh=KObPQ858TeCPVpiGN5/ZqNi0Md+RBIC6anTyV6gsDxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2f8s983M59DaAq2IjqC5u2B6UP8q6f8Abmbg3YPzh/n4NuFOi4JcxJUGlrhUFbDWLV97rP1JKSNdC00t+EJjhzmvIfqa0f4UvkCwsXeLjZyls2oRRY1hgpaCq0jnrbB+H1pCzKYi94/riYQkYwEBa6WV7EDrMpY6PveZkxRJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V2bvDHxN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=We7IOxC8; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V2bvDHxN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="We7IOxC8"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 082081800092;
	Mon,  6 May 2024 03:58:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 06 May 2024 03:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714982325; x=1715068725; bh=0Bet6VEAjD
	hJymxjIY5QI/924awYxA2bJ6aGGZxvzvE=; b=V2bvDHxNJodaBsNnQicXj8AX5o
	D0/gq9MBTiYCR3HSyu6zCnIuSi6iaFWnQDDYBticdx40mXlTUbnCc6qMEad5cYbc
	S8s/aCfUDbxBSVGTd1+YmsZ9mN4VIAfSB35Wu30+wKYvQLuBwfO5ej/OlzrHvWAk
	CGXnFA+uOLw42vUuMXup/LSNFa+RtKMErVaxK2JwguZ+tBEydk3zwEHjm2BY7YIY
	TvJgTF8qQwWi+j3cyZhY2B1o660y3j0PK11MdFDkTAwAyyCgMnhLC9gy3I/L0w7b
	BMxE9JCwpO7Jw8B9DKxOUtSmnXIQOI3NWbSM9LF+onRmS9BLZyG7PPtadJvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714982325; x=1715068725; bh=0Bet6VEAjDhJymxjIY5QI/924awY
	xA2bJ6aGGZxvzvE=; b=We7IOxC834UzcBrBZenLcyoHSmNSG8BsNwjVuG3y6XGu
	L7z55ZkYr3sQNE5uCzYSgjNcX8asLq8a6yIBp18WAQGM8ujK1J8E94aw5/sYQBCT
	FAcxThx2ikDHRgzuvRSLw2bAZC45GjKxSCwqhVfzb2naUmqCJ8CVGAdY/ZhhWWgZ
	jTVErwWdrB+sPAvAmE1GyepGoZuzemaT8H6em0ufdpBiyYwHqGHw1ARtOvMSmhVD
	HnshbtpCqh72yZ5FfDkNCb4LiW7GPCEYiWL+b5X71rr2SeFAwHDG7y3AcSQCNXrX
	D1Cm9Ju+3+7JQFmAyv0UnPSMwEvXjIvopStMQ5R/PQ==
X-ME-Sender: <xms:tY04Zu49OQTiQXhGuotrkOqd9cQba0E7p3wPv8x5lBWxQapXkAlnPw>
    <xme:tY04Zn5OYf0ySZHOCakzlKbMMAOjPCB0PC3SmfZvw8MyEI3DEzAqsob1Vy6t3xEGP
    3CqgSLXYJ19rN2ZVA>
X-ME-Received: <xmr:tY04Ztf3e-brC6MQwskuqtq-tiU6LodmkC0HL4MdhOsnh2Yj5G9ZkD5WPDqDpEXEI0yxXWmywyycz-pWS4-OE0cOoL-UAvkVI22ZoqL8PY41SnFC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:tY04ZrIci7RNfGfCA44srztW9_9dQgTNZNneV0BvlIFAkuLirm3lzw>
    <xmx:tY04ZiLoXufFmIYEjIroLIX3IG3O4E9F5URxU3irZbPVmM0SxQrg1g>
    <xmx:tY04Zsz-NcSLGMpxUZ6eBdljCkMY67z_pjFMhRjjrb2eo82_l19Piw>
    <xmx:tY04ZmJWlkwdr8e5Wu4uODDs7e6dmObvyPXT_JELSveP45XgG0kWmA>
    <xmx:tY04Zjp009sbkXBFx00YFk1nN98ID82zipQNyKjBhrfeZ05sJ6AvkMxn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 03:58:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f118c49a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 07:58:36 +0000 (UTC)
Date: Mon, 6 May 2024 09:58:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
Message-ID: <ZjiNr-PUue2_mJGr@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
 <b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
 <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ABxd5f+W7ejas8CQ"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>


--ABxd5f+W7ejas8CQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 06:08:57AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > While git-config(1) has several modes, those modes are not exposed with
> > subcommands but instead by specifying e.g. `--unset` or `--list`. This
>=20
> s/specifying/specifying flags/ perhaps?
>=20
> > user interface is not really in line with how our more modern commands
> > work, where it is a lot more customary to say e.g. `git remote list`.
>=20
> Tangent: I totally agree with the patch, but it would be nice to have a
> 'DesigningCommands' document which would highlight UX do's and don'ts.
> It would be nice to add that as reference in discussions.

I agree that we should have that discussion, but feel like it should be
part of a separate patch series. If I were to adopt that into this
series I very much think that the resulting discussions would take quite
a while to settle.

I'll start the discussion soonish in a separate thread.

[snip]
> > @@ -2590,7 +2608,7 @@ test_expect_success '--fixed-value uses exact str=
ing matching' '
> >  	test_cmp expect actual &&
> >
> >  	git config --file=3Dconfig --fixed-value --replace-all fixed.test bog=
us "$META" &&
> > -	git config --file=3Dconfig --list >actual &&
> > +	git config ${mode_prefix}list --file=3Dconfig >actual &&
> >  	cat >expect <<-EOF &&
> >  	fixed.test=3Dbogus
> >  	fixed.test=3Dbogus
> > @@ -2751,4 +2769,6 @@ test_expect_success 'specifying multiple modes ca=
uses failure' '
> >  	test_cmp expect err
> >  '
> >
> > +done
> > +
> >
> Nit: Wouldn't it be better if the tests are indented here? That way you
> know it's part of a loop.

We would basically have to reindent 2500 lines of code. I don't think
that'd be a helpful to reviewers :)

Patrick

--ABxd5f+W7ejas8CQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4ja4ACgkQVbJhu7ck
PpTh9g//WRSbXPA92wpTCbIUea8g5m2Bh/Har+mJax6B0H44e1p3vl0v/WebkJ1S
ExgPVd3t8wSWtU1oN1clbh/SYEZnQ0N07U5tOF/U+2p0bBrD3Q/yL65l+9kIxOKB
gv0E+nHYxZ9ingWY/PQFfUTAEgFAKM6ui3zqwcVuR5NMwN/XvOWfNZEUa80mb9AX
Zf67PqBLEzxjNAU+vrWlLzmXVbJc6GwhfUaa7/9AmZVXLOREhAa6niHX7/ndthZ/
hLWO44RX9VZ3+OyPEEIju6YlWwZa16CDFxdNT89xnQWQfvBb+/27Kwqhx+/4rAt8
Ghb78XWvWVGnPH/6HnZvDQJLJB6+gQmrg7QwbNTncSFg8hiUhJt4xrNeAiZiCGji
LeljvfLahj+BEg4gGUbI6dD48YY/ID+06yJZIaIY32hBlFiHUyJAydx0VxgRdHiT
zEMz7fVaaOQhn1Hsn1QHD+EpeIlMIg1eowUkxlBPNXuE2E39DfvR8kWB5KD73/7f
x0vhXUupxXs6VJ6Gpn3wUa6kOupa4ZOxN0c5PLyLNCSpPSApMSey0wBjWS6fLtUr
Vz6cKHRktBfsSXj66lLDWn/FM1M3WOM5tWaGhF55pcuU2EN5+XThlBF4iGUwE3Q2
XSZqu7vt20yqPc2pgfgMxkAtDUFYT9LdBi2AqoMJdNVyPq7I03Q=
=IUNP
-----END PGP SIGNATURE-----

--ABxd5f+W7ejas8CQ--
