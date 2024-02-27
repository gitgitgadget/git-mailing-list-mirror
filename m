Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4D13B2B4
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043743; cv=none; b=Hin2Iftpo/l6iXOabr+60Qpscmc0hUcAT7+8U0LrgTLZ53K4JFu4KVJes9mxVC8up80I1fjICOEsoP98gNQZY7ue75AEcxZDgD1LuDAz5V7Tr0oS3NqQvTfHGvSEAC+PeVsKbVfetpW4yj9Q4PrQWBMxaAAdlp3J+s0N0uyiVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043743; c=relaxed/simple;
	bh=dRmx+cDDlr64rBjCPWlKM7xfDal1LwdUk8rhIt7iRe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8b0udmfjvSdXVPsd6pTKi02lJO3IT9WEvspTmdToBPYU7TkrXFBHklonNNg7hP5Pve51e78ub4bEEccU8ehEQ7Y7VCvKSQdOs3VtiQIPRFbgZc0cktjqwi1FsQdv+tlGkK4zlYH7Ji+Wgt8SdPAzlGMTVnsco3iD6Ycux3OR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fPg+iB8M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q2OEIO58; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fPg+iB8M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q2OEIO58"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 0CD961C00095;
	Tue, 27 Feb 2024 09:22:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Feb 2024 09:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709043739; x=1709130139; bh=9ShbGtwUKK
	DddLYHS5lWOEAQWiLwK07qCTDxsKjcKFQ=; b=fPg+iB8MRWOiafLkSfraxTzdBD
	Rn5WGLZyUAWfJOPqAnb8xf96WFTu/p+NQGBQCGKoa2OdUrDZvaI7Xd6XXA9HqWZu
	HydndGkEzVtvhssmau7VqMRzkaGpdw1CoVqpXu+AEmTSLUnfEPh7oa7TcCAbEZvv
	YSXooeKn621KXH9EmVMQP3mTBfzCQhHJSSp8/RWo0OYEcNdK8YKhjycuwJLGp+1I
	vC5pr81mBm+ukMXoThl6dy9Vcfxy39bDEaL3p3o/sucMBZqKsRZjOpcx/ay3JGls
	353MKhEhFVGc2TpGn/0G/4q8gkHgasnY3EIrnAk1c8SgdHzauj6EChGGIHUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709043739; x=1709130139; bh=9ShbGtwUKKDddLYHS5lWOEAQWiLw
	K07qCTDxsKjcKFQ=; b=q2OEIO58N+ioD/4rhH2f+wIW5rplUQ3FHJF57+OXLyQS
	51bL3ntpd/4oZFbHwof+WesMbE778pjgw7TnGTIMt4f2xuAFSYoueigp5ZWx1kB/
	gOkntIN+g8wdkRqYYsuF5kMC8y38WWp/Cu55/GuuGRVzJhDJ8sUcY6P5brLIbTpb
	RvGIYxRzq+rZ1PMEEB2VeXbyjDvB3ho7yvHN8CGvOtFwORCDs/8M8X5PfmY9VKBx
	Ql4Tvmnu3XZqfSiaBajR6qfu7F9hb8ikNYVOem36vLGHjUx1DmX0BZDWZXXc3B+R
	suFxp5LKOYd3oUwxjHrr6P7IQ5cnzcWmqS2jrC0PCg==
X-ME-Sender: <xms:G_DdZQybuxBzTWdoVfgHNl6W8Dki4lkTuka2hftbCi961nEEtLqJ1w>
    <xme:G_DdZUToM0zC1s5_riB5Zr1fpvgRoPo0v_U-M-ZaU1zlksg1ktQyPjSqkZw1jP3M5
    MuyYiwFJ5dyz4Jkzg>
X-ME-Received: <xmr:G_DdZSVV1yKvo1DhRhMUnNFetBrkEef9n60fn-YbdhnN84JgoSWWhGRID_tYZPn90jsB-iCwUvHAIziGjmIJi-ngr73r55fT-8Q4zLV2xSIAwuwR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:G_DdZejqLSUzUmLDOsS14OmCPUM-nGjEi-J7Dg9in9abuGma_LzxxA>
    <xmx:G_DdZSA5vQ9ft9Y009VPXh2UN9M_tnhaGnPEQCnA95aoZkxtP76G6Q>
    <xmx:G_DdZfKuSp-J3i3RR-KKmyg6v_CiaqlBslC_aSQkeBtUGhmTXHnlYg>
    <xmx:G_DdZV_LfzB5hQ8vBHrTdRx0tIlGarT07dZcsBzYJjxd3rAM11JJcQFcslY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 09:22:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 65e32ca0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 14:18:01 +0000 (UTC)
Date: Tue, 27 Feb 2024 15:22:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: phillip.wood@dunelm.org.uk,
	'Torsten =?iso-8859-1?Q?B=F6gershausen'?= <tboegi@web.de>,
	git@vger.kernel.org
Subject: Re: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Message-ID: <Zd3wGKaDIEztGrsn@tanuki>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com>
 <01be01da681e$0c349090$249db1b0$@nexbridge.com>
 <20240225191954.GA28646@tb-raspi4>
 <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com>
 <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com>
 <Zd2hMmIzHKQ7JE45@tanuki>
 <02c501da6986$cb7c5c30$62751490$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YATTjtzpkYxIF30r"
Content-Disposition: inline
In-Reply-To: <02c501da6986$cb7c5c30$62751490$@nexbridge.com>


--YATTjtzpkYxIF30r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 09:10:55AM -0500, rsbecker@nexbridge.com wrote:
> On Tuesday, February 27, 2024 3:46 AM, Patrick Steinhardt wrote:
> >On Mon, Feb 26, 2024 at 03:32:14PM +0000, Phillip Wood wrote:
> >> Hi Randal
> >>
> >> [cc'ing Patrick for the reftable writer]
> >>
> >> > The question is which call is bad? The cruft stuff is relatively new
> >> > and I don't know the code.
> >> >
> >> > > > reftable/writer.c:              int n =3D w->write(w->write_arg,
> zeroed,
> >> > > > w->pending_padding);
> >> > > > reftable/writer.c:      n =3D w->write(w->write_arg, data, len);
> >>
> >> Neither of these appear to check for short writes and
> >> reftable_fd_write() is a thin wrapper around write(). Maybe
> >> reftable_fd_write() should be using write_in_full()?
> >
> >It already does starting with 85a8c899ce (reftable: handle interrupted
> writes, 2023-12-11):
> >
> >```
> >static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)=
 {
> >	int *fdp =3D (int *)arg;
> >	return write_in_full(*fdp, data, sz);
> >}
>=20
> Unfortunately, this fix is included in what I am testing but does not imp=
act
> the issue I am seeing one way or another, but thank you.=20

I didn't expect it to :) The mentioned commit only fixes things with the
reftable backend, which is not tested by default. I assume that you
didn't run tests with GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable, and thus
t7704 wouldn't use the reftable code in the first place.

Patrick

--YATTjtzpkYxIF30r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd8BcACgkQVbJhu7ck
PpQdFA/+JdpK7JU51UfrfCBAGJUzc1oy0J1GvBxo9r5adXya7BDXvacxB6OK58tK
lfNPDZYcNCW37BHlWEIpaYpWk9zNBQbt3oEvfooFNpyf05BHSdgtHV+xKrZIcNvj
gsU/1Kqf0A0OS2xjLRqEr//vIrQFk99eOuadDtkcXKcJX68cYOi4jzKWu9kG8gkS
zSA/9xzx5U9Qe7KZKFKOjQsUq9/L0iVsrRoPfz6cGfEH8koJ+2ReijBnAkcxJbmD
Rsp8GmkiyvtElAff0DvYum7rxoZd5mQvoEEcG/t6xHE+RwA6b5iFubD7Zd1Kir4n
jDGjOPXZcY7P3S7i+p4ryKv/drVlPwsdZP7IIhiMzaep7yN4JMSl0gQ/4uI8eS49
+MTXmpQo9w8/2SukDrH1EpGY43HY3DAMdFGh5OPmNOFvDzS5Mltl5fHAoRZ2PL6b
6GtTL5y83/IqEo/IFDjsZ833zj6/bRF48QzAuA8HkQB3l10A17CkXUZ7+HWXaxUQ
eGO55Tcn/2j3jg7K6UY/R1lvxxiD2G49d8Ao+rB/V9Sz/bgjPWnNZubVTBagbL2H
DfGu6NXizZRr/ZA704aYgF8Nu+HUkeaMvfp4YN/Ud5g4gbypDa5CEnoSJmhZXiyi
mzMFEewM8K2x9M20EucYDa4C39SW0UwcA9wJegtj7NXcJxOtgNQ=
=3K3H
-----END PGP SIGNATURE-----

--YATTjtzpkYxIF30r--
