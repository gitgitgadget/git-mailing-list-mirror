Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642944C8E
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329992; cv=none; b=G9OGRzJ4UHJrVKIUFSl/173dXjf2185d49JqyOu3R7QA+tURBbB94tBD4/hYyuLT4t6/j2kags34UTakmVK3U3W7S9nXIuqARcagqLdPT//ep6/TZrC9Sw59sUIQ4KqqzLl8OK0RbkCr/Axe24CXyev8XrEshGBfv02J0Dbde0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329992; c=relaxed/simple;
	bh=U9MJth37gwfio9gHRklWSQ5MGox1xDyaU/H7iChLqzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVQPYA6G7vMng6sDhIxhewWWDWRZAonAzAts6KyDM3FW69X5RMeghReNGLfED9oRqiGv/beenEBkZZAWWhXsJXkheut8HVaXgdIHeYgLE+/x5tYyePf1TGfU4NUtnuQVB8+uKnLkRJnBfdPRgVClSigOVgIJKtperd8XCvXVMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IZe+KHof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4VVMCqL; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IZe+KHof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4VVMCqL"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 48715180012E;
	Fri, 10 May 2024 04:33:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 10 May 2024 04:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715329988; x=1715416388; bh=9AtCalTTvP
	r0RvUZGzP1+cfvnVGqqjzv3DXQtlmnpRY=; b=IZe+KHofamGfrtMnRIluFomvsP
	9SHpSpnGqkp8Y3oQW23d7LNIFO4SyLyTjrqbiI/LyHfSMcicdMTPBgA3o9MfdIPa
	5hh+iUFsEVEc8qKLx7c+H4g5oozFw5G+LA1H3f74oIi/Kf+pn55WxzAWqacuGOp6
	vmvLA85Mpf9tK7iRWhDquM4MAAl2+mzVjPazCisUvxUVhKNtQst1mxo2kpYqQWGC
	uIs9x9SdssxKKyMa/BAgwVYPCUOurvdQD7ppSWd48QhtDwt/7uLpnXG41yzQkP4L
	nFxgKVn/QAw1FYkiJYG17gsDmgkjVuDXUTB+umxx41f0wQgFw2XCB8p2OSMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715329988; x=1715416388; bh=9AtCalTTvPr0RvUZGzP1+cfvnVGq
	qjzv3DXQtlmnpRY=; b=W4VVMCqLWxLoQULBFyMgFMm85DogqlBV0JB0G6rawbyT
	vsLd5xuBp+XErqnq518waujc+uO4m2G+5jXm3rV0U1x01DJ6yIxMu9URVY6Vx9Uf
	IShmT3Emqy6tOTNl2whUVir1TBp2wXg9WMKl563udvMVlevOpne9urUwJWjWYrnb
	7cckPG8wd2jwZCXKLH9LCzPxJdOYyoYdtS0cQ9fOAeZTXtePhhpGa6qWGNbnV74P
	wDyCzizwkDSW9uiSPeXVK5AuQ+ecwPezkZHhP7CL4pj7GRARJm8x2sSzZta0Xr9p
	zLbb3mJFYJOqJRbx2FaUmrIThWGgSIBpdm+icXxXIw==
X-ME-Sender: <xms:xNs9Zsg8mDr97WecCng44-Lw3bQG1l4ZSJB17vzz5B3VMISqh2jrqw>
    <xme:xNs9ZlCtw3kWrdQj_uSHckfnAoCtJgs9Hct5q43-amZ_TiHA2LpchE0bz-fG6D-8Y
    IHCP4kxz7265untZA>
X-ME-Received: <xmr:xNs9ZkEDJ8OqO83KR2mbDY-K8UO4lPn1esclhuN7wJv-7cE96aYHbe8uJSJjG1I7YSKU6ixVjd2FdREkozinYl26CGxXh4sy3oSqMWo85uXB285Uzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepfedvleefueetgeeitdekheelffekkefgffduhfduvdefffdtheekiefhkeejkeeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xNs9ZtQ0WMf2a-KhTvey4Z4rE3cv3AVh9g4ueNceIj2W_0gPRl3Leg>
    <xmx:xNs9Zpy6uOeAd_ydmckojMg_Y-demI5kS58MHeCIH0R2f_N8CCespQ>
    <xmx:xNs9Zr44BnL9XlclGgdG0o3EeQMUtnjG9ZMeNVTm43HFAdN0MGRX1g>
    <xmx:xNs9ZmxuZql8nBUGef8uCzOPWjfRTTfom0bYU1uZzduWadYMt86PRA>
    <xmx:xNs9ZrveVtNkhV1doTmOcy_sb8R41ZwKzXnXwfi-SaJtx21EOUThmEBb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:33:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 52e3c18f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:32:51 +0000 (UTC)
Date: Fri, 10 May 2024 10:33:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
Message-ID: <Zj3bvtbMrhe1Mmsk@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
 <3886895.kQq0lBPeGt@cayenne>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n4IXsrAv6+Ii7wbZ"
Content-Disposition: inline
In-Reply-To: <3886895.kQq0lBPeGt@cayenne>


--n4IXsrAv6+Ii7wbZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 07:29:18PM +0200, Jean-No=EBl AVILA wrote:
> Hello,
>=20
> On Monday, 29 April 2024 15:41:28 CEST Patrick Steinhardt wrote:
> > ---
> >  Documentation/glossary-content.txt | 36 ++++++++++++++++++------------
> >  refs.c                             |  2 ++
> >  t/t6302-for-each-ref-filter.sh     | 17 ++++++++++++++
> >  3 files changed, 41 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-
> content.txt
> > index d71b199955..4275918fa0 100644
> > --- a/Documentation/glossary-content.txt
> > +++ b/Documentation/glossary-content.txt
> > @@ -497,20 +497,28 @@ exclude;;
> ...
> > +
> > + - "`AUTO_MERGE`"
> > +
> > + - "`BISECT_EXPECTED_REV`"
> > +
> > + - "`NOTES_MERGE_PARTIAL`"
> > +
> > + - "`NOTES_MERGE_REF`"
> > +
> > + - "`MERGE_AUTOSTASH`"
>=20
> Quoting the names seems overkill here, as they are already formatted with=
 the=20
> back-quotes. The rendering as bold or monospace is enough.
>=20
> Regards,
>=20
> Jean-No=EBl

These don't exist in later versions of this patch series anymore. But
there are other cases where I did the same in the current version, so
let me drop that.

Thanks!

Patrick

--n4IXsrAv6+Ii7wbZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY9270ACgkQVbJhu7ck
PpTVdRAAkrYG2i32NR7qSM/Dt8k5rlARrn1hrgE829iXJd7MnIqnl35JcjCbNct8
PTjZ9s+X6eKfJjKi9SNgfzAm9cl3iDN+S1PJmwGoVhcVedEZDH+xWTkkTh+TRDmP
r3La+a7G8CCf61EnM3H/8vE17uTpg20xt+VwS5kWPz3VmcIV4ZqkXHhS0OZCBLP3
5WlqS8tBNJQloMfG3MiVqVfTjDnV3RpFetfX7GHtTZmaUc3D8Ofdqlv0Qvy0LpSu
Op2crtQM7hvBQN+dLnUYWKQS89gebeG+U6SEfK4RaS/Q/EvYclXLbKDV/abaBBEK
HZdWWh/RdzmRN3XS47oQSlr6Jzmpl5Si4xMq684lKJ6+t8oLDlzqB2dxS9YXmQXq
GfqqTsDteclw3kzc1+4Dxu2XizKkKbyefnMrENi00oXixnYaiSrTesgFHjogUc6w
98CsGxi4sHFENn8l/YvXcvGyzNnzzzwS4RtKTMVb9YkP6cIJpsUH0EBjaTNJjZNb
v7bywj/gxa5wIA7FTz1TOiggAppTaDZZsH0aIem+l4zkVFko6M/QmzK1bqF1YgLS
eq9/RaAVdC0NwtSEeUAOURY90ebjjmQ2OC9YqBmzUU56xmmMcwF3h2gIfKWOlh9b
bfJNQnZxjoc97kWPS19L9+B6jqkrjjbNrLZKEgdJ1Uz96OFgL/o=
=TkUv
-----END PGP SIGNATURE-----

--n4IXsrAv6+Ii7wbZ--
