Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849E1D531
	for <git@vger.kernel.org>; Wed, 29 May 2024 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962418; cv=none; b=uHJhbFvfkl9o4ZC4NIN1gUGHO0eJbSqVWS+5Q++CWLVeVIrCfraXGvr3CLyWjPe4j8uCSYhYB3ll/+IwS0bWsrj1bc8hbDdDKLpEPULBAU4oXN86OXXaC3kTO/0yVjRAt2b5SWAa9HCvzqgWo9lRYRU+xw9HamInvwcTHJqvuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962418; c=relaxed/simple;
	bh=5yRIZLECbRYuq4hGP92FxlnxnWVL8CfqRZn579HHIsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TktlrgFj/vpjfAMHuL5GC298DFKRfoCvOvt+zWp0qw9gqt8nTCR3n0RLJGBzSYgKFTkS4Q8m/0eVmf/7rJp7JWbX3LzXu8O1pyTBV0vui91jn5L7V1QteupU0ewkPdi5lmG/meHjGMS1GvGkkZho6Yd9NyOqtHRPb5ME7s4AFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dXzAATQx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mAESIxCf; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dXzAATQx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mAESIxCf"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id A017E1800134;
	Wed, 29 May 2024 02:00:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 29 May 2024 02:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716962415; x=1717048815; bh=5yRIZLECbR
	Yuq4hGP92FxlnxnWVL8CfqRZn579HHIsM=; b=dXzAATQxRKK+zDGc6RLi5YapOb
	SZ9VbButXBBWgUguXcuU/eYxuOcuntk02TvFwBSfBBXRB8aKo98+G/pVdM8oOR2i
	hmNuW/ui16K2ZNmMS2j4GnnxC8I/P6/470I2W4Zyesfh4Fan1AERGvT6jAxvC6Xq
	+XEN41UzxojWj4XBrZ+OMdaXtPP+rp1gGHjZKcWgOBALzeuRQzZzi2pDWtVuW9Vp
	uyUKlg46JUhvdl6f+yU8Vpxt66U/BGS6GHJ/R3rdtkmSDTIw1iStWX5ivWaAjBDo
	LzCdL0Sg5qxZrlSFFtqKFpZ/Xg4HTsXOJwrQ7wzk8I5uKgkC+nF0rCWxYLMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716962415; x=1717048815; bh=5yRIZLECbRYuq4hGP92FxlnxnWVL
	8CfqRZn579HHIsM=; b=mAESIxCfOVslxHufgS/WJwBmS+fQmpc2sTgIskQM+7va
	F+vLXtV1D3O5+AmoQumJyVuTegEkkF9lwXR/v+j+bULiLonRM5Uaevi1+221jX8c
	+KB1D8FY0VwHG6mIhOwYAE/P6YPs5PkO7t7ltNgl9GjfnVmMxORvyLNUp0/aW6OL
	fiuocXJemgfWEFx78vl4IB5DP0rIB46CEB1bBl/UCq6O0WPlgI6iKyLKOz+DdDxw
	x/Q7F2LAkNqavSJcUpsLJsL1QfyHETRk+8rVgPVgE6VqU/Go2vplbQ4ovwYZFKKZ
	x7UOeqZo1GyInodS/SgHRenX3hNukmolj3MvXGOjsw==
X-ME-Sender: <xms:b8RWZrC_Bu4px_yOXZUcB3COQlJ5w2WIG9Mn4CUIuRurF4HIxq4AlA>
    <xme:b8RWZhjaTQeLY3z9rAlGWM10YX_lDYydq6ehwJlknaUpF9fMQ0zEXsfyU7RctvkiY
    Gqp0z1GR_wDrD5lYw>
X-ME-Received: <xmr:b8RWZmnEl-MsusLaNDTOiO-5VWFVhhbYDI6iuM0S95XoZdSxzF5SpXHEuQIAs_x_MNAhg6cJM07nHqijYQS3QvfgaFTWDo__3H-kdfhCv6dRasSd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeegtdeiuedtgfeuvdfghfdtkeelkeeltedtleeggfeufeelgfeitddvgedugfeh
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:b8RWZtxixKW0Pmpjs1H0Jo-HaujTwvze1JY4zgQdmZ3rK1FaLyjicQ>
    <xmx:b8RWZgSEgyxO3H1JLGXvFczPcRF74xLbQhVHnD89aIiqfh7L-sAQAg>
    <xmx:b8RWZgZqMcnw8ugfsW8DkPOStyWf-xsFjyegSmw6cAk9Fd3DJR_F0g>
    <xmx:b8RWZhQacXNq6uoEVI7Nj9Asmm8evDFW2WrJ1W0V2Sz1hfywBgavbg>
    <xmx:b8RWZmNXnKZHpObyLgmNnFOv4nyOK2X9o6dY7s5oYs899XMicqYgHDEr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 02:00:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2fab44af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 05:59:58 +0000 (UTC)
Date: Wed, 29 May 2024 08:00:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] t: improve upon reftable/basics_test.c in the unit
 testing framework
Message-ID: <ZlbEanuHHlwyaRfT@tanuki>
References: <20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240528113856.8348-3-chandrapratap3519@gmail.com>
 <CAP8UFD02Ck0M2AOmTtJO3gHr3w+3Of7BAAa0Rbc=CtMms60nyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2qE4ioaC6AiITolE"
Content-Disposition: inline
In-Reply-To: <CAP8UFD02Ck0M2AOmTtJO3gHr3w+3Of7BAAa0Rbc=CtMms60nyA@mail.gmail.com>


--2qE4ioaC6AiITolE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 02:46:17PM +0200, Christian Couder wrote:
> On Tue, May 28, 2024 at 1:40=E2=80=AFPM Chandra Pratap
> <chandrapratap3519@gmail.com> wrote:
> >
> > Enhance the new test for reftable/basics.{c, h} in the unit testing
> > framework. The enhancements include:
> > - Move tests for functions in reftable/basics.{c, h} from
> > reftable/record_test.c and reftable/stack_test.c to the new unit test.
>=20
> It might be easier for readers if one patch moved tests from
> reftable/record_test.c and a separate patch moved tests from
> reftable/stack_test.c.
>=20
> > - Add tests for functions that are not currently tested, like put_be16.
>=20
> This could perhaps be done in a separate patch.
>=20
> > - Improve the test-cases for the already existing tests.
>=20
> Are these improvements to tests that were moved in patch 1/2 of this
> series? If that's the case, these improvements could be in a separate
> patch too.

Some of the test cases are extended to also cover additional edge cases.
But I agree that this is easy to miss, and also think that this patch
should be split up further.

Patrick

--2qE4ioaC6AiITolE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWxGkACgkQVbJhu7ck
PpTFqg/9G7s3tTc1VMl00AyVWsFGKPLlmvWIgQYAE34p4siMqueyGKKDmP1XlB6T
CLRBfWJEaSzgebKe8O3LbD3ZF1iAOtQcnrTgpY5XgyZPmfgkSoHGnIdyKjQcB4Vd
xs0jZ9bOE8XScOOtEQqve3/HsxH5GVWc48dCjfzNZOrwJuJdyUZnzOy6Mq+myXh8
v33GtZ3xoXE51J8IoYg3PaS5gQhbtTUSDWijfQt+0utxbKmSJheawtXBjx05tZ3n
m5FKHA1FeZI6ulQ0Fy1coBmqHrPuMZPvcN8w48bH0LxuRsEUfeDynjy1tzGe+mIE
PqWwvnk/BiR6O43nv4569HC9CmxhRDR2S1+0mjg/tMhFJNFGptdgZsDKOnccpJI1
ybxwm8IS8Rjb8O30We4gNVKLnF/dSb2Xldal1KAXYne1bgrJax5MEyxFKA3/xsdi
Lho0IxodTYv4TspBZhuGR9g6QWVxxbyb3N6VgAZqzaVRbvZk3K9qsLNWUT+IlMn/
wm7VW3Os/YbfIOVVVm+TJUH2QlRniuuOdVnE7fFaynpkB/ne6a9b6d/4IDZCp5pS
mwryh90uc5hPYcl8hdSO1Vjj7v9S8w1oYJ2Ar1Zmq3ZWjd7UW4itKQ6+USYV5pWk
0+QOvT3jejTviA7dZWG0YSOhYJgZbJXwk3M5gU/hCF88mlocVxg=
=PdLJ
-----END PGP SIGNATURE-----

--2qE4ioaC6AiITolE--
