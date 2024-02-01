Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C8158D7A
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772558; cv=none; b=WwLOEgRqPUFR5CMX3dCSTjs+pu6dLKGdBqy+Gi+xNsENGmuKrWIDD1q0cK59xP7plwjywz0FfZJ5OLTJt5wj7/02Oj0inJif2tj/EZHk04aR2SHrJm5CoVyx7fWHkWINSjOAcOPXW0zPkqQ8pDNq2GOcw/e0LppSupz/UM9tuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772558; c=relaxed/simple;
	bh=yI3i6+zeKPcbMa0bomATqDdVxvwoUNl3S5HTMpFA9M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBUruadroCPD/fzFZQ0x/VJxzw8AN0LSJBzlAWRi65OwUhKTJjhqi61NbbjbVPDZq/UXxD6bKCJb/NZzwq6V88QIXXvDvsb52xQyQPu4uKJPhsxdR12asyDLaZJN9DtywczdXqWEtCp5qnpKLFhnF0rF2bypB7HpEfU6tm32rWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IORlmaBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZrioM+5; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IORlmaBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZrioM+5"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id C0F461C0007A;
	Thu,  1 Feb 2024 02:29:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Feb 2024 02:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772553; x=1706858953; bh=qoJzd5CugA
	iTOQJ0GC4JHxe8GvzFb3VBzP0QfANlFoI=; b=IORlmaBrISHwfwcn/wWAxTP9PA
	IY6K7spRyCpgGQblq2T1WefgA6up9+vwlYEYfrvEC5GJ4rtX48afh9j29bSyknq/
	/F+7msLvIfBheSCCELmyAZ5ny4Y8SvtcC+gA8FK5U24c+prbAX/WmugcUcb1zlfI
	lf3szZ3IHM2QWeOJbCdBbHLzFO7iKRFcqB/dvfa0B29am9aIJZdKr7vIRaOEdrdS
	pysb8y+VkjENGlJxa0ynUor6nlWkADAZ5wTmpYFNDZepSWwQWRwHCKDRpyfHj1Ss
	w29Qv0eFsBVXUm7YOAaCjvtLB+LOmwtFtmZoDgmKetzXJT+QETI9h8QZwWNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772553; x=1706858953; bh=qoJzd5CugAiTOQJ0GC4JHxe8GvzF
	b3VBzP0QfANlFoI=; b=mZrioM+5K7/1z00BC365z2Jb+4yqQuSI/w8A3B99SNE7
	DT2HkTru1TFRlPk969kXK2vl1KKPqRTk5C/xHbASNNSBDPLj6VGv/wFXb4nKUHSG
	M2FL9fckVLwLaZ8x4xEOt6u6ZF0xgz1+SKkhxkeSHoTqmGDk2tOho+tyBMZVnw61
	+l04sxrmeHUmey0OA9QGwc7M5/lrcyEVhlOVEv5TIoDTGnERZ2C18yIM4oJ3pI4n
	PUVXmHkvZFvWARIAz42A/JONsV38E0PB0zWXPdES8zoyPsp+Sgx6EyCEhYwZwq0K
	E0LXXebJvwCWvgknOhMnGPvnFpPY9nIbItJ5eRFXSQ==
X-ME-Sender: <xms:SEi7ZZQg1TLb1kIQqZfV6vf_kuFdl6FZySEgCqegME0e2tqFy9qb9A>
    <xme:SEi7ZSzzachDAo6jeZUnXVl55RhyXdi9XCBK6Lo8gMjCYjml2fymOhQHWMpBJh42k
    GJr2Yq72cqabaeNTw>
X-ME-Received: <xmr:SEi7Ze1phtGG7j1QB8SnvUimisDidREd0iT8fh-5ZA8jTAL6WvL7dwRXGzsS4W4INHmFa11ET1X8GmFbU2Nw9k3MhczInGtukexgduyXsYPGtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:SEi7ZRB0xWorS2YcmnG2soRoXplkz1CTlIwNQEf0-wW2CxDsj29pVA>
    <xmx:SEi7ZSiPXPdH9Ty_KwuDiysrKTNOGCsUWDywuhgBATib73M0yRVQvg>
    <xmx:SEi7ZVqAzaTag3b_3qrA7__XB9NGjpIhaWO5k5-77HUGmhGvFrAHSg>
    <xmx:SUi7ZVtZa6Wnf7loGw8XmrSDVK7DBrZ7_JJHxFhZO0N_kk6Kqpm32YqUFSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:29:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e1909c0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:25:46 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:29:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] reftable: introduce macros to grow arrays
Message-ID: <ZbtIQ3Hk6Mgvkv4j@tanuki>
References: <cover.1706687982.git.ps@pks.im>
 <0597e6944a1a65720d050f47bc82766d5bcf860b.1706687982.git.ps@pks.im>
 <xmqqmssl44wo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gZrmbb/qDLzDFH/i"
Content-Disposition: inline
In-Reply-To: <xmqqmssl44wo.fsf@gitster.g>


--gZrmbb/qDLzDFH/i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:35:51PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > patterns in the reftable library. For In most cases, we end up only hav=
ing a
> > single item in the array, so the initial capacity that our global growth
> > factor uses (which is 24), significantly overallocates in a lot of code
> > paths.=20
>=20
> You need to know not just that you very often initially have only
> one but you rarely grow it beyond 3, or something like that to
> explain "significantly overallocates", though.

True.

> > This effect is indeed measurable:
>=20
> And measuring is very good, but I somehow expected that you would
> measure not the time (if you often under-allocate and end up
> reallocating too many times, it might consume more time, though) but
> the peak memory usage.  I cannot quite tell what to think of that 2%
> time difference.

Very good point indeed. I don't think peak memory usage is really all
that helpful either because the problem is not that we are allocating
arrays that we keep around all the time, but many small arrays which are
short lived. So what is telling is the total number of bytes we end up
allocating:

    Before change:

        HEAP SUMMARY:
            in use at exit: 671,983 bytes in 152 blocks
          total heap usage: 3,843,446 allocs, 3,843,294 frees, 223,761,402 =
bytes allocated

    Growth factor (alloc * 2 + 1):

        HEAP SUMMARY:
            in use at exit: 671,983 bytes in 152 blocks
          total heap usage: 3,843,446 allocs, 3,843,294 frees, 223,761,410 =
bytes allocated

    Growth factor (alloc + 16) * 2 / 3:

        HEAP SUMMARY:
            in use at exit: 671,983 bytes in 152 blocks
          total heap usage: 3,833,673 allocs, 3,833,521 frees, 4,728,251,74=
2 bytes allocated

Allocating 21 times as many bytes with our default growth factor should
be a much more compelling argument why we don't actually want to use it
compared to the 2% speedup.

It's somewhat amazing though that this huge difference only makes for a
2% speedup.

> > Convert the reftable library to use these new macros.
>=20
> In any case, the conversion shortens the code and is a good thing.
> I wish we had a way to tell these macros that we are actually using
> the same single allocator (which we are doing in our code when
> linking the reftable thing to us anyway), which would have made this
> even simpler because you did not have to introduce separate macros..

Yeah, I wasn't a huge fan of this, either. I initially just wanted to
reuse our usual macros, but when I noticed the resulting difference in
allocated bytes I already had two arguments against this: the fact that
we have pluggable allocators in the reftable library and the growth
factor. While we could make our macros more flexible so that they can
accommodate for both, I don't think that the result would be pretty.

So at that point I decided to just duplicate the code. It still ends up
removing a lot of code duplication in the reftable library itself, so I
don't think it is too bad.

Patrick

--gZrmbb/qDLzDFH/i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7SD4ACgkQVbJhu7ck
PpShng/9GrhKxV6Zr0zyzMLnQh8BtpHkKp5A/fP+yzA9OWvcsswZFkt9vy5SKrgG
ou0pKplRTs+aTPvb0AXowj+S+WdHYYu/ISMvcbHHTDQzMsCeSxwOKk38MPwaPXGy
41Yt9F/QJ+8yQe+BfzT+CPpCmrUoS3+eOgog+hoEwzwr0KiwlbXGAIiUenQ8hA4l
E5apPm6q/JHZ/J2HSoiKm1EshgZ5w1ZUJqe70aJnI98SiqBDz8QrXsBxoMg2OZBp
t0d2NRWaVE14lTRQHQUbMAhQx5eQlSe36LaxjpwQc1Qt0cVt7BWhR9kK4Qj1hmtf
WAuajQsp+5jy+FCPu5cqZprPNjjcW4TapHQtu+lSczNLsiSOzlgO+2eXRPf6frog
uFpVTV0sErOwKpTcC9HEY3GzWpGqI4H9ExcRFam6I+8vdm3D18QimLa7xzV8kW+K
EioqpvHH0cnEIkHeuVgJswJoGhu1fdH+QluFUt6sv9LHDoeEwB9W1E0Ehbua1mGH
LjUk7Dd8CU+z2Qr0dshwFZjFwc2TsCW2FKnqC8fHK77M7F+3vvmmeOtr1Nbk3LkK
p+I5dhY9gwVQPDjbLcWNFVIOd5pE1LHGOjo1yWwcPI0MN4RVjYeaIOqRacPz1loN
5DT4N//f0owzO83QW9k2c/WyLOdTBhH9LmFnsOe/dUxW1pRFxBA=
=vQzg
-----END PGP SIGNATURE-----

--gZrmbb/qDLzDFH/i--
