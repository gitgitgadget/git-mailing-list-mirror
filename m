Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EDB645
	for <git@vger.kernel.org>; Tue, 14 May 2024 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715661146; cv=none; b=Nd/9Hf4GGkeYGJ7iNar+e7rp7Y5eorKSnrW1zi9pZVImxELLVVtsHQnIul22D0qK259McH9q/FgIuZsE6w1LEfRIgwIX7GMyZrIt0lkjmvEFFg0VrRaYAgn02hS6BbEvkHWzh/FQTz10lI5pSwXV4tZibL/rggM6oClcTr19Bns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715661146; c=relaxed/simple;
	bh=bHPQvDeuLDCahAZoCBeghK2tO3mn6E1OC84RCuDzuGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7Z88PsNQo8MLGeWFcpjkm6H6fyQB/eFDUPuZ+mN0xSiuTByJwCylfSCkc+kw1kmwucMWsEQ1hcWdHYoTelC+LfUBb8aLQGRTIgMSYo3lpHp2I3Uvisp2Q6nhh2TuhSNV6aQIXLTTvtBZBGWo5sLZFGZUQZ8g0kK9Lgu33dLnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=orx4L7E1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBuIEZzD; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="orx4L7E1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBuIEZzD"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 587101C000EC;
	Tue, 14 May 2024 00:32:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 May 2024 00:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715661143; x=1715747543; bh=9Sb1WCq4mh
	t9hF2S8/ZI9z1x0ofBvAtCCpjFWro909c=; b=orx4L7E1OfADKnURt0aFhbcyz3
	GdaKqVABXmTD9+VhE3gEhjapjfbPpLTMeHppG5CuHbSpA5HQIZSsEVAVKn+UVeg2
	TDi9umpZGbnWp3MvfvlZ+t+3kFuiKFtScA8ykXMAV93h9JtOLEUCBEswYPoNXG/Q
	mb89lAyEVfvavHxpwEyT6canjV3TaJwAQqmIR3gZB7lRIdqicIWUDW4z6bCDno5e
	OpRoFT9Bni0LWRiJ8OJN/qDv+KJPTYJmk2YEihKfI1O5u4cNQ+mVEFNOUd0Kh20g
	Dk2FR9PedCQuGfOmjIGuTiFhMEgvw74q7gzaF3Emc3cTlOjzSrPkXhbYMOAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715661143; x=1715747543; bh=9Sb1WCq4mht9hF2S8/ZI9z1x0ofB
	vAtCCpjFWro909c=; b=RBuIEZzDISQSgaVGQKBZ/aRiIdZ1B3IdBlhPdo1Jgfq0
	f7Ddoq2drRWPQFufEaQHEjivOo+lYecMm+n8ZlUV+SsrG/Zh1Zo3rvV9Mqecg5qa
	3T/kXmjL0z+1XBAOYjC3ndVzyfs7E6jkKvfi4NXroSy7VZWYTHR06qD5m4dn6kot
	rbEBe3ddZA3svF0VnH0wrjkicbV5S5ShWyQzd6ppK4/N66gQLLgE4N/VJhUjXo/w
	GPPCcIq5jig2EYp6UeUWhtqBWb67nnbyHDfO+HyFzVzcUBlwZTqFR3h+vgbb//HQ
	6+0AQXO4NpQYJfMkNvZ9t/6HlGGdn9974s7WDsJBBA==
X-ME-Sender: <xms:V-lCZqx6ZsbMsBVyhBDfRoms9UhK4lLit7GaTX_FNW8RaFOngLguCg>
    <xme:V-lCZmTfXhLI1Z-nKp4xcUscRf-XrnofA1Eci0w2r1mqYDd5g8nNaEptmD_CvmMtx
    tYMfHJCVeVVGcyipg>
X-ME-Received: <xmr:V-lCZsVNqa6PG6ype0cvojYCLzKJj0pCGw_GUJrSDDhNHJNyxTfG-oRo5_lobx7vsFnytqO8Ws0IC7OiZvVKykwfjFwpbAh3QSquIL2ObbRFOBkkdChi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:V-lCZgiHdEb6MiV7hAbVifj28IRgQC9rVvJQeBHsKJ_zqIdbdRSUfQ>
    <xmx:V-lCZsByklhIr5MPM2CcQqJpJwEgMNLKotzuZv4DTmrk12SHukd6Eg>
    <xmx:V-lCZhL4WRO_hF-jBgnStMA2lRe9Cl998_IM4hAmVKblmZ65OPyXAA>
    <xmx:V-lCZjBdZNFPlzhb3-okPxnDa5QYD4jNTUARLaaxEl1tqpf6ksIEIQ>
    <xmx:V-lCZvMXsfIFSj7NnIigbskutND8KkyspLwCj8QFQAbpCyLSK6Mpfd8T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 00:32:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1f8d1e8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 04:32:03 +0000 (UTC)
Date: Tue, 14 May 2024 06:32:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/5] builtin/hash-object: fix uninitialized hash
 function
Message-ID: <ZkLpVSVv1XPz-D8v@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240513224127.2042052-1-gitster@pobox.com>
 <20240513224127.2042052-5-gitster@pobox.com>
 <xmqq7cfxcnlc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vma296TYQzHGJZ4M"
Content-Disposition: inline
In-Reply-To: <xmqq7cfxcnlc.fsf@gitster.g>


--Vma296TYQzHGJZ4M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 04:13:19PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > From: Patrick Steinhardt <ps@pks.im>
> >
> > The git-hash-object(1) command allows users to hash an object even
> > without a repository. Starting with c8aed5e8da (repository: stop setting
> > SHA1 as the default object hash, 2024-05-07), this will make us hit an
> > uninitialized hash function, which subsequently leads to a segfault.
> >
> > Fix this by falling back to SHA-1 explicitly when running outside of a
> > Git repository. Users can use GIT_DEFAULT_HASH_ALGORITHM environment to
> > specify what hash algorithm they want, so arguably this code should not
> > be needed.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  builtin/hash-object.c   | 3 +++
> >  t/t1007-hash-object.sh  | 6 ++++++
> >  t/t1517-outside-repo.sh | 2 +-
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> > index 82ca6d2bfd..c767414a0c 100644
> > --- a/builtin/hash-object.c
> > +++ b/builtin/hash-object.c
> > @@ -123,6 +123,9 @@ int cmd_hash_object(int argc, const char **argv, co=
nst char *prefix)
> >  	else
> >  		prefix =3D setup_git_directory_gently(&nongit);
> > =20
> > +	if (nongit && !the_hash_algo)
> > +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
>=20
> This is slightly different from your version, which always used SHA-1
> when nongit is true, in the hope that it would make it more useful if
> the user can say "GIT_DEFAULT_HASH_ALGORITHM=3Dsha256 git hash-objects"
> outside a repository.  I am not 100% convinced it is better or we
> rather should aim for predictability that you'd always and only get
> SHA-1 outside a repository.

I'd prefer the latter -- always use SHA-1. As you say, it's easier to
understand and doesn't create implicit mechanisms that we'll have to
maintain going forward. Also, users didn't have a desire yet to pick a
different algorithm than SHA-1, which probably also comes from the fact
that SHA-256 repositories are still scarce.

Eventually, we should then add a new option `--object-hash=3D` to
git-hash-object(1) and other commands that may run outside of a Git
repository to let the user pick their desired hash.

Patrick

--Vma296TYQzHGJZ4M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZC6VQACgkQVbJhu7ck
PpTcpg//crGF9+m7ch3ijFR3xqxWXjjmcGnyb9R8yoZi/F8NQfZ5OdDbDz/pfaPG
Wf0qVgLcRGZ7fgjg00Fk/bjNgQJPeDNProgLqyqflz+4gmuzyQZJN06zSqVLq2fF
fRXlWLnpkAeaH3S6/h3jwhDPBP+7Ijwh4YbomyJmYNV5I8rPm+bWlt/fVMMlMRwe
1WgaLCKwnDtcgBFER/xj6owGoObnhrJfiwEhAzOqV4EPr3v88+TbRqdO+ssL3VIO
X2yVSTKvtgalkOjtngYc18oqZQceAQlM4QNrig9TPmWzGOUfN0Yg+WhkL5n0/+9y
JU6RuwHnKD1Mclfs4XbwFH6Ydwn1vrZLijJQxiWdCQi9+ZH5XI23VbFhtzzShX/n
m7dIgMpoPmilDjtpEWfRQygmsSIEin51omPdS0PYe2MqcWsEu4H6Bm/uAOnxtO8j
F07LxQ8E/kGx5/bs01wTtYTSrKgYNNUiF0Fgh3FPaF5iWXweO+AXzNdFnaC3BDGD
mjqYoTLxV4wTKixX6gE/nyDZU/5uIK2qeY7C18zxe5GyciQ1SWAmO4/MxusfPZuP
UIkZIJ5R/m/etdVhQMvYEH4r/4ruywFkurLOtARn7rILHtQeWjvbMadPYAobIa2v
iaLmLi/qinQ23tFb3+d3b9Ko3irtXGtrRF6nH0GE5fqj1xLWByM=
=Sr3E
-----END PGP SIGNATURE-----

--Vma296TYQzHGJZ4M--
