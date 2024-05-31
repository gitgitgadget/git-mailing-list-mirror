Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ACB339AC
	for <git@vger.kernel.org>; Fri, 31 May 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160444; cv=none; b=YBQfqogZgj5cKvPg7KA3znbIo/7MESeUvXIP6Imj7xF3oXi9fRdrj6qsKV8lNPZZSpFTSf43tE2qwOMpZidA0ROURoa/ePvki40hNJhstPX2D+XRAeleVvltbT6YXdgRqXZeg4pCaAh/1J6Dtv/+Fz9Rv3apT6L4l1JKfklpQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160444; c=relaxed/simple;
	bh=EJnToFYf2Une6AMIz0Pogo/Kt9Bt9HAEiASntI3zheY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ2VEMGl4V0JIVv4PDF0/LvBepJ1r/vJCCXaSyWjOC+OZGM6mKJk3ZAtPTqCxaI8RMVF2IbOChkmoyG/gDfXgNDv4115rjQ99VksAIRuxp9XxBpp75NfLfZ27KIKqaqRiR37a8p7qQ0VN78AxRcPBH5gmIFP8WYW0EZrqN9SGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SbnIPekz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cs6sh3ux; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SbnIPekz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cs6sh3ux"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 706AB180010A;
	Fri, 31 May 2024 09:00:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 31 May 2024 09:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717160441; x=1717246841; bh=sEKmKH28Po
	YK8tKl5WP9lWL1AqNUCG/to1vHlcf6hT4=; b=SbnIPekzy+U+BUiA2lm8UHiVPg
	FXAsiZjMj7+mRuVAsKNWlXaZ8zjmULqLcFndHShbqlzBIGXCW0llt+PDI4nx3Nh5
	haSit9gzt5VJVC9rh/sJc3Afi4yqSZJAtXKM/MVsC3b5rcxaJDBfn6CAwiueQ4Hc
	AnVxlAzBn5O4L2C4wXi3NKw+wAWmfCtu+d2LZH3K4G0JqyGs8SZJw64MYqUThUSe
	eGJTu4oxU688FgAVKF45RmHUeXA59qoOr4DxihCfN/A893s/v0V7uIUv9Dc5XeN0
	7CAm597ASbrs1y5XPN52IQNsWo0Rb/FV4Wphe83kSWiiaiDuP20mTNbbFZFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717160441; x=1717246841; bh=sEKmKH28PoYK8tKl5WP9lWL1AqNU
	CG/to1vHlcf6hT4=; b=Cs6sh3uxgCYju6czfxC/r1klXaBloOYt40zAvOief/aM
	IhsW6dd2Q4z9DmqUX3bpj3VTuBAtNrmjPXYDde53iIKxvYwrxCpLStF0j3kDAyTu
	Xp4tN4QyAJAeO0w8XETB7BYgb+57qNM6mtQSkH67cRzb13k3tyNnTiYk41hlvPS4
	vF09Y+yi1diqbFuV8yD2SpL/s2zja5UKD3vf0BCHyLretTFFwOKjmeKsnmTG//bK
	YligVY6Mjt6xYpH5V/KLnh9EqrcwUbN29eAv3mXdDPahvpEF5qERPqrt8cXcW61l
	uWaYLbAmRCHDFiw1lBAkbSZg6nxVeyxQi0cZw2LViQ==
X-ME-Sender: <xms:-MlZZhrys_1uDd7V8vOCqRsb12BPce8ftCFawRzIk4yFGHoH4n8HnQ>
    <xme:-MlZZjqND7Xy3eEE9u2YfoJU1aMKA8x47xX7nrZ5QyYFTSlGt3KUo1CRtFljc4U7w
    CXIbGp0cXMLYWf0vA>
X-ME-Received: <xmr:-MlZZuOVWYWSEqeUmd8_bzs49MWoGa3EPzzw_5YnCS7AzzAzjSstufmnEKOie-KFJaFrdjRGv1DRuSpLjiDb9O2tnsDl9pPn7_WnAkANys1GYAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:-MlZZs4v9o8WG8mDCZC2c-oo1yswD8lNp0FHIggoi5bu8i9IH3N84w>
    <xmx:-MlZZg4z8WwIqIvUcJTBLwLbJJeGu5NSCwgd59-YGtkUQkx3JNGeKw>
    <xmx:-MlZZkjtX8yYnwvK0OlP0bbiH8zGW-rTgcg1xd_7KYUdoZk6RV5NlQ>
    <xmx:-MlZZi5JBNVSOv2phsGogHiwQokGXOEmH9Y-K33IG7lVacIV7l0iPg>
    <xmx:-clZZumzzdXm1d-AkXAAr7FAA0B-ASTBRKpw7cVrp3rAWOCtIxVscZ_Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 09:00:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d6985fdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 13:00:18 +0000 (UTC)
Date: Fri, 31 May 2024 15:00:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
Message-ID: <ZlnJ83qSnGlQ0FWR@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
 <xmqqplt4y1gk.fsf@gitster.g>
 <ZlhjN7K8JKYz6Opd@tanuki>
 <xmqq34pzozsq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bUciXIDb88qmqrax"
Content-Disposition: inline
In-Reply-To: <xmqq34pzozsq.fsf@gitster.g>


--bUciXIDb88qmqrax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 12:38:45PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Well, we do. Not in `get_fetch_map()`, but in `query_refspecs()`. It
> > does weird stuff where it writes the result into either `src` or `dst`
> > depending on which of these fields is provided by the caller. Which
> > means that one of the fields would typically be a constant, whereas the
> > other one will be allocated.
>=20
> Yes, <src, dst> is used as a pair of <key, value> to query one with
> the other (i.e. "where does this one go?" "where does this one come
> from?").
>=20
> But we are not talking about const-ness of the member (iow, once you
> point a string with the member, you cannot repoint the pointer to
> another string), but we are talking about const-ness of the string
> that is pointed by the member (iow, not "char const *src" but "const
> char *src"), no?  If I ask "I have this src, where does it go?" with
> a refspec element filled with src, the dst member may need to be
> updated to point at the string that is the answer of the query, but
> that still can be done with "const char *src, *dst", can't it?  That
> was what I was wondering.

Well, yes, the pointers can be updated. But that doesn't solve the
underlying problem that the interface is not well-prepared to track
ownership of its inputs and outputs.

The root problem is that `struct refspec_item` is being abused for
multiple purposes. One of these purposes it to store parsed refspec
items. Another purpose is to actually serve as a query. The requirements
for those two purposes regarding the lifetime of associated strings is
different:

  - When using it for storage purposes the strings should be owned by
    the structure itself. Consequently, the lifetime should be managed
    by the structure too, namely via `refspec_item_clear()`.

  - When using it for parsing purposes the input string is owned by the
    caller, whereas the output string is owned by the callee and then
    handed over to the caller. Here we cannot rely on the structure
    itself to manage the lifetimes of both strings, at least not in the
    current form.

Now of course, we could amend `struct refspec_item` to grow two
additional fields `src_to_free` and `dst_to_free`. But that only doubles
down on this misdesigned interface.

The proper solution in my opinion is to detangle those two usecases and
split them out into two independent interfaces.

> And again you are conflating "allocated" with "read-write" here.  It
> is often convenient if a variable that points at an allocated string
> is of type "char *" and not "const char *", because you do not cast
> it when calling free().  But if you want to make a structure member
> or a variable that holds an allocated string responsible for
> _owning_ the piece of memory, then you need to consistently have the
> member point at an allocated piece of memory (or NULL), no?  What
> this patch does, i.e. prepare an on-stack refspec_str[] array that
> is initialized from a constant string, and have .src member point at
> it, would not make .src freeable.  In other words, .src pointing at
> an allocated piece of string "some of the time" alone is not a good
> justification to make it a non-const pointer, I would think.

That's fair enough. I'm trying to work around a broken interface, but do
not solve the underlying issue.

Patrick

--bUciXIDb88qmqrax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZyfIACgkQVbJhu7ck
PpT0TQ/9GfLHPkLQwPJTjG7wGeE4UA0TUS3Qc3HAiVSvpBusgJAaO5JVh+n4KTcJ
r75Qx7DIrSML0rSXndVT47OJS7t3Db5oJ+Y7g1sBtUpRzxlDGv+kp4Qb9jS1xvBU
aVj5PIHpWZ5SScijVEpdA+ZT+NbxXr+5sV1FYL+h6XB0YYn6KkFmEXBKi/dVUWH+
AOmtSeG379c174zoXZ/6N7HZd0sUBrkLGoI8F1SpYZzt2RdA2oFmpYtgWn/yKsWC
rWTnsS6M+KlM4R/49WRmTKorHK8/Lyy6L5ek2dmSlORMliP7J5k341BydLNM/rtB
dysN++5E2cnGb4Kvn0PzR/dvhaQe2jPERxKOg72A+oYj/yA2aYx6seR0cTgiTWzI
pQ6YG1ttPIaNSp0/O45VEk2bBZtJAgBS8i0LrbdzC6wPuqwLqW689fObmQ0k1LJI
6ZuJhpQmqH6KA/YAN78RRixuR22BGp2VtaMwjHzYxfynR7jxmyshKW6UPSpOxn/J
k+bLyiViPH/okX5AuW+Je8OkU9X6b3Gb6RP3HwlNYyJJKYwPQ0xumzRXq+CH5jhb
B67nI39X5zlNNnvzdrC0biyJLkkQLM6VH4YOiHq336xGX1Qg6Khd2rNtTvnqnGtA
vKXH88mP2iI5a6XEGQ5l/hUvqG50U36xGol/F7/bJSODgeGaztc=
=lEWV
-----END PGP SIGNATURE-----

--bUciXIDb88qmqrax--
