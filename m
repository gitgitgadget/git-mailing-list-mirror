Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4F18637
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722402095; cv=none; b=Zz9ptL4indH6buvZA67o0DEgAR1l0UgNeFzoJNhqro1XaVBFpIgFbeU9An0fIKks1n6mWEelljsWayFHIJ1y88AK9FvvKOKVtNjyCzhyAoMXN+c5VKFAOQGvIGbrFmLS2FcHY/YB9Obcff+xhmC3nxk3W2zFSr64sEq7FSj7xSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722402095; c=relaxed/simple;
	bh=M0yf2OC8d5DWzmfN7S/a/R4tE9oifuiPZJq1Wz4i0ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXcIue+g6Bwe9MOEIvAeSajnsqYOaFW4ETd1sj6LSY6ok+tjR4UVqCBHWJeL4K4b5ZQmEMQTrD0BSn0Wuo/Ybn3PuudcmdzHoYLSlhgmj4QuUEAdxX/58ElVf99vQ8xmeD7/XqKHJH2tsa5pPoGJDS25tyl799ATdFWDRdIz+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oPJJ0QNB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ys6BTTSm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oPJJ0QNB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ys6BTTSm"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BC2061146E60;
	Wed, 31 Jul 2024 01:01:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 31 Jul 2024 01:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722402092; x=1722488492; bh=M0yf2OC8d5
	DWzmfN7S/a/R4tE9oifuiPZJq1Wz4i0ng=; b=oPJJ0QNBTLbpKpR+y0R6H+wdZm
	QbCpPRru4NpbWhMlKucqN4az/TVaqeqqd9jnFnIpOCOu/GpBWg4lgOn2S3qYwQxj
	nDxrdRdJ9I9IitWQtBR3wtkD0IVk9oPtGy5y33VhGWZnF1Nax6w/kuM4aYCTk8YB
	VhJsyhNQJH9VtA4X1T1X5faG52ZxOpzkeL8Uml7ARc6KeoWhBwfGVgp/jFtJc9E+
	xmfSzsUm7V3qLgoCzDHhQctZbcRdTBhAYQLPuN7cjnq/MxyL/uEgWLazAiaWSqNw
	EmjxPbyhHcOiljY0EgEvvpIdLkD1DnMG2kbcBJEeXH9HUiDMd3jm7MiydeLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722402092; x=1722488492; bh=M0yf2OC8d5DWzmfN7S/a/R4tE9oi
	fuiPZJq1Wz4i0ng=; b=Ys6BTTSm4MrhBP08Erwo0PCDvBXz9wLtiiE37LFxJweW
	1IWH2PZl9eq2IispiiLzExWzuzbPKPh33GMK91I+KuBfKS7GNrOKCMHI0GL87AUd
	CDEo9p7y5ij/o0THEenVDnC9XsS/PUKy5pfBj91FJeQnq8lYyrm0lZWkUZ0sraTb
	KFzM2GuvpOqClK8+p5WEayHvn+qqdhrn7hdvAke8La8wZMr0VWb52XY0AoINVHPI
	kMiUgxdkNec8kYKd2H93CY3BXp6lt9NGnBK926BeGmvpIkAy2y7Ss4d9v87HjOWh
	XskMgJmxoqyo3kx6t2Bdb1G3A0CVzJqx+pwPZ8+NIQ==
X-ME-Sender: <xms:LMWpZkgxqsE82tGHQfXEJPRZUvKJvoNoJ-pLnc0X1qZrJ19MnxYRLw>
    <xme:LMWpZtDHE4Rh7JlBxPXhVVbb3-AO0N9TCD7IWIxbROP6bOBUVi2_AvuvgBqWTqPzf
    pB1kITZ0uisMVDX2A>
X-ME-Received: <xmr:LMWpZsFLEY1U1CmaTVFkQI9CwNXaXNh518doexSdxcbdMAMGRh-S9gMTS6fMhM3bqDlZE0_65bi1Z9giQ0VI-tSIjH4NjWFGd1dVYOoaxalGfB9B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeehgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:LMWpZlQTPBNyHHzqA8oTC3VwBJQnjoBWRvSYZJrWojm-PlmT6C8LnA>
    <xmx:LMWpZhx3pQ9DRmEWsjIBiA4lqMInZe_RnLcR1JW4h8aOlIdZq4i8qg>
    <xmx:LMWpZj57LemJ9LbnuA3XS53TTaFv-n8zZBBq0sEGToco9InUwrcG1Q>
    <xmx:LMWpZuy-3Pj__cxmI79ddfhf0P3HR-ngvGovJUvpWXKbOucpM_ddPg>
    <xmx:LMWpZs_LJSF3HzLNDUuAGHp-uBgPb5318boP0vyVpe1k8awH8e9Zgeg8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 01:01:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b1deb3ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 05:00:02 +0000 (UTC)
Date: Wed, 31 Jul 2024 07:01:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: stop using `the_repository`
Message-ID: <ZqnFKFoaodui2C-P@tanuki>
References: <cover.1722316795.git.ps@pks.im>
 <CAOLa=ZR+2FV-pdk2nZ1vR5dUx3G2Ze8=18CUCn8r_JUXfvR6fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TOX6/BSEmhXmhsEf"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR+2FV-pdk2nZ1vR5dUx3G2Ze8=18CUCn8r_JUXfvR6fQ@mail.gmail.com>


--TOX6/BSEmhXmhsEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 07:26:50AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Hi,
> >
> > this patch series removes use of `the_repository` in the refs subsystem
> > and drops the `USE_THE_REPOSITORY_VARIABLE` macro define from those
> > files.
> >
>=20
> So the idea is to slowly cleanup usages of `the_repository` and the
> `USE_THE_REPOSITORY_VARIABLE` macro acts as a check for this. I think
> the changes look great. I even ran clang-format on this series and apart
> from line wrap suggestions, there were no issues.

Exactly. One intent is to demonstrate to reviewers that a file actually
got rid of `the_repository`. The second intent is to hide away APIs that
have an implicit dependency on `the_repository`, which would be easy to
miss otherwise.

The second part is not perfect because we only hide away a subset of
interfaces. That part can be extended over time as required though.

Patrick

--TOX6/BSEmhXmhsEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmapxScACgkQVbJhu7ck
PpT3SA/+JkCUXof+b+3kI9CP1i6sMzDTxCTPqe4dg9cFn5lNf2WaPdQJ46Wy1HU8
rBE9S9NtNqVo36h0va+33gkxULk13SROKqft4kgY8fwGuxTsCGmHuaxQM5ViNScs
fNCQR7/euqK4aA+7kanRUMjtazKGnsr0PtpjRvdbA3Jx2zw62hlwmiQSecc48NwA
Mm0gPzgGrDXOL1Jrp8qGvDQVvqxp19oGfDuYfFkbdx3HnwLvphnmPjlbGrx0JRmC
MbGEfwLTJVYxLxug10RgaXNUOYhvBpZ+LCTnnoGgNexJ6qunuyusg4JWrYDH8HU8
5zFHDL8GabgFdpjqvL3irN7Fiyp8ez5aG/qV5gzMZpZU7/X833wmTj3E88UYhXHw
tBBOfj4b0wsLsBQiMiNijH0+scnN14Jg05fvCYpUGp6RrX3w6PJp1zNY8nyqnvoi
CSgACxNXhwobUGDMeL4HSAl7OzRdzv7J7pdZzX1RIIAIHLANAnDkcV2MTi/Qw9m8
TWk9gWvg+ewlDqUOEOjOG61IXYu0Hm/F3oUhwGtIOm7wC17bWwhDznpIPF3BzrzI
7fOdx+cIu1l4kekODp1JKBJKl28AA2+BCva4Ha3I6/EoMxZPtPYKtdcAQzaSQaRD
hTolqKw9mqjULH6aqIdm0ApuGR4nAzSk6pmJGMSU6CXYkg+MxiY=
=RaHa
-----END PGP SIGNATURE-----

--TOX6/BSEmhXmhsEf--
