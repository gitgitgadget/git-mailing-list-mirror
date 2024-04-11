Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0513CAA2
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825756; cv=none; b=qkk7fEyJ2O0i0jPThAcfJ9k+Btpq+9+X1PkVPc6UFSSzsM+4EJ2ptFr9aZa/pBxgEBZC5E4d05aDAewvkgPvCUdP83uT6k84iwoeYZgZ69pIRRZLmUfuD9LLYjmrKNS1t+tBLM8wKs89NjF1C/iZ67BXbJ82kFY3XueV+v0fxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825756; c=relaxed/simple;
	bh=1G4yilAjRnSWcdx42/qqGfoZO985gmjUl+hvfVn3n10=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZyI592ucfuLmg+FNAvlqyVpcYHsYlTVzN+ogOVMg9k5oEasZDeZvfQA0O730BPvG89vK0FzIfNDTIKs+m5cUV/iX89dxqrfWpropmMgH/9aCXCFi+aij2hEvyNzjkZyUIigRiZwnPpjuy0+FQze/Ao6Qbep6O7VEvgbxY0r9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e61ec4me; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lSW4KUeX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e61ec4me";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lSW4KUeX"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id CA2E41380169;
	Thu, 11 Apr 2024 04:55:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 04:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712825753; x=1712912153; bh=KGVy913O0o
	i81sgvT315+/oAcwbzzs4xfb6+C+kqLUM=; b=e61ec4mec/k48MqmKdvx1TLx/S
	aGe883/y25xGa9XDi+KsXWC6So05FZIh3k/VBajvZH71fr1OLO2MqaRitBY2NL9+
	4eAbtfDdecgBPu9j4UzhsS1yhsSCVvnnLTmDmTxBv9c40Io3TVbI1Y5DjdKQuDpI
	9oNBOIcm/uNSxuIUmvv/7GnGNlErWkbhTbMyT9NCdqUj5cRSYN8kD9qZhXMPfiFS
	1Teewes9cg5kgxrajRsBv7s30WdkpYDvjoYGEem+fA7tSY3AEdBAOiw1qbd6o+X8
	uLd5SVqgpBIpiK/eSDAiAkvE0oYTfJbtjclj28DGRdtN5gFgR9owFmmVkeDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712825753; x=1712912153; bh=KGVy913O0oi81sgvT315+/oAcwbz
	zs4xfb6+C+kqLUM=; b=lSW4KUeX1YgWLx8BKakGX3bXVUYA8TlgPbsdA/70ODPs
	JDYvE+22JhCtvsL234UgEKrUYFuHdEjrtMbtdDCp8ffyVAhnA85AKe5EhWMC21Vs
	Yut2cX9Oj1kmIsWzsGUq8KNIFcvI+TDIRo65JEI6GASvDpiAwsmWZma9JV+td/FY
	Wa12gVZaW7qEpldSh7w2c79HBN78cfYJbTzqsJcGaF0dTt9+meH2BdTkgmv/qSAG
	YfrHkRD0l0DnCSMa+DpECmAjBAwCg5n6H9QXV0zfKswgbEHxoHgElTZ4JqReVVWT
	m46HpDwBTC8LDvZn/+GJoq22EiYOmrNq7E/QRfCo2w==
X-ME-Sender: <xms:maUXZu4XN-TERNxYMbkCu_nbbjZuvqekYfKyXeH2bB_M1JpdmGyo4w>
    <xme:maUXZn4gU2a2ubxFLUa_U3OUW_C1YDhvC0GdEpX_lJSm_1sqXkRKoun63dcA3qz0E
    z178SxC-U1t6r7ZPA>
X-ME-Received: <xmr:maUXZtdhHnC6D10DLIh_P7etd6rep2tDJWfOoeGrcpSlKRzrfeFLIkeIRSHaQWqp8el7J62tcoOEfXJwg90P67ZSzioS6IkzsfVKKXDIhEE-7XOr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:maUXZrI-7vHJPfI9-RBbh3H2MgIfPKXk1YZflUtR4SnntqimMuliyQ>
    <xmx:maUXZiJiIHPVywbJFPFpYwpzy5OfWkVNK9vUA5DsTavC6S0HXXTv9Q>
    <xmx:maUXZszwMpEUvX0YAENMx668TLD_xOZD_k-ylb1tQthGLzxOQwJ6DA>
    <xmx:maUXZmJgte3tV6a92H4Chb084T3ptZSSmLUZR5wsTu6rWPHENlhCRg>
    <xmx:maUXZkgREoK2te6fw68NQRwOZ991SwQY6bXcpgqFUgPbWBIHiCu3_VO4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 04:55:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5bba6e8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 08:55:40 +0000 (UTC)
Date: Thu, 11 Apr 2024 10:55:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <ZhelldbAia0wxIpD@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
 <t4powjtw4yapbivatafkez5e2ha5gcssintxam47ibkvjlb4le@ob5deeaxpzqr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nom9GI8FnHEedZeK"
Content-Disposition: inline
In-Reply-To: <t4powjtw4yapbivatafkez5e2ha5gcssintxam47ibkvjlb4le@ob5deeaxpzqr>


--nom9GI8FnHEedZeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 03:43:58PM -0500, Justin Tobler wrote:
> On 24/04/08 08:47AM, Patrick Steinhardt wrote:
> > While the reftable format is a recent introduction in Git, JGit already
> > knows to read and write reftables since 2017. Given the complexity of
> > the format there is a very real risk of incompatibilities between those
> > two implementations, which is something that we really want to avoid.
> >=20
> > Add some basic tests that verify that reftables written by Git and JGit
> > can be read by the respective other implementation. For now this test
> > suite is rather small, only covering basic functionality. But it serves
> > as a good starting point and can be extended over time.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t0612-reftable-jgit-compatibility.sh | 132 +++++++++++++++++++++++++
> >  1 file changed, 132 insertions(+)
> >  create mode 100755 t/t0612-reftable-jgit-compatibility.sh
> >=20
> > diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-=
jgit-compatibility.sh
> > new file mode 100755
> > index 0000000000..222464e360
> > --- /dev/null
> > +++ b/t/t0612-reftable-jgit-compatibility.sh
> > @@ -0,0 +1,132 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'reftables are compatible with JGit'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
> > +export GIT_TEST_DEFAULT_REF_FORMAT
> > +
> > +# JGit does not support the 'link' DIRC extension.
> > +GIT_TEST_SPLIT_INDEX=3D0
> > +export GIT_TEST_SPLIT_INDEX
> > +
> > +. ./test-lib.sh
> > +
> > +if ! test_have_prereq JGIT
>=20
> Do we want these tests to run in CI? As far as I can tell these tests
> would always be skipped.

They aren't skipped on Linux-based jobs at least. The JGIT prerequisite
is defined in "t/test-lib.sh" like so:

```
test_lazy_prereq JGIT '
	jgit --version
'
```

And because we have adapted "install-dependencies.sh" to install the
"jgit" executable into our custom PATH directory it is available,
meaning that the prereq is fulfilled.

But you're actually onto something: while the tests run on GitHub, they
don't run on GitLab. And this is caused by the unprivileged build that
we use on GitLab, where we install dependencies as a different user than
what we run tests with. Consequently, as the custom path is derived from
HOME, and HOME changes, we cannot find these binaries.

This is not a new issue, it's been there since the inception of the
GitLab pipelines. I'll include another patch on top to fix this.

Patrick

--nom9GI8FnHEedZeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXpZQACgkQVbJhu7ck
PpRxTA/+KNa3X9u08H8/zdx9ACjDJu+gjUWAS+MiuBxhWIbu1VgoGF4Gr1+tscIl
Jfs23WvAajoeRIXmmXX2y77bJloTHBHcPZJX0614HOH0LKoLRbwa1Hr3BHzsHKLK
wv1AW2dljRsq78xCbIGWd0Z3gqPNhau3e+neWYiJNh42Q/x+Lg9xb0h9s7kV7+NN
+7Sq0/oR6AMhhx6oYDfjwzOZqBXdS5T4mv6NSBRiZy2TAtLZCCyBkR0D7PatEAOu
Pb2yp1r3/ux/MzrxXz1hVkN/t5Bwqg6K8SufYLKrUbFR1oPlz750nd87C+1kA2oj
5VyPWsTYgyxfzGKXAZU6Dob76/SbtRJnF/oH9Lv5426NEv/EyC0ymJqd+FBevcyk
rY62qyv95JVbaG/FaXNo4zzdRQOJAiXD9ue79zM6xmCTHipG5Ujn6BYDo6KoU/VI
Fj2zUOaRez2kuUnswiV+NHN+2qGOdAdkIBHx+o6fPFYMbsNKVLpuGe/qxrLKxnFl
OS+8BBT8ruO7VE19aDBTbZLpT1LhvmChtz4Yw19hvRabxUtELnS4Y90p9rzYLGzo
QTxwmMOx9oTrhDSFNYl/df3eVcf9MmJ59yrxiHVokcERMC7XDnZWJNdEpGWI5QMm
qLsJfjADpfTKMhxTy8QaDWUYqbeDbKDFBXYilSNs7KFPJcVtAsE=
=YfY4
-----END PGP SIGNATURE-----

--nom9GI8FnHEedZeK--
