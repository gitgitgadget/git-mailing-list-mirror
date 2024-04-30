Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793B16426
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453494; cv=none; b=hu6cn9NGnN1Qu9pDiigqTVyZddGC23+3SMGmAwTx1c+qQk+I39L19VAojxk/laP6WZXcDLk4KmRMNj6Z1c0HAAGK/SwPE2RP2YoxPdl1nsoicarBpgsEIUWigKzj0CryKNgU10s56941n5Pv5FzqT+cHN4E43B6Q+WpOsUDP5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453494; c=relaxed/simple;
	bh=ZbEh0Es8I6pexCHDNPEVi9NSfGLSkfOBmF5tudl50oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwIEC9bzP9coN6KNQao/c2HswQdNN9LvbKwx7SEAsFiR7SqDAFivfwVtwlZ+Fr8G20++dvrXlTivCgepZ8nW/Kb6rtpzu33s4pt86kQD9d1Ms6nIuHD9f2WvlWaGsGWLAQTzJnYgYooaFng41MihbBgcntErMQMuzXRTc16jWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HBma38v0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VT6ogDy2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HBma38v0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VT6ogDy2"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id A9B871380263;
	Tue, 30 Apr 2024 01:04:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Apr 2024 01:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714453491; x=1714539891; bh=KyaWg+bFDL
	QoepT2YFon+cl6aK4bttom4Cw8IENsWRs=; b=HBma38v0sxKspoBRZpGgprmD4s
	P8KM10mWgEUQvJlaF1cvTP+CffKakqO7bqCKwk8BL2Wn0yJHZPPL6foMn+/Pl0fN
	SGus+GpwB98MTZucamqyjH/8Oxon9npiUNVCQW6sfzZwNQ8P0beyupOKKTekl4ZK
	QtDJ/dPH/rhBYWoOIX+JFo5dMGPMf961Q3/MyJU5USJ75zv13J4jJfGGwoqomtBs
	lSarqjP41ZefDg+EF7dmQO3uxPWbVPzkGqLlU27vHPhcmlFw9m15Qyf47N8JpFmP
	gETEf3XvhG2wscP43QtnD/TmR/OA25BhmtfZ4hyXhssv7qm49SXWI1XQveqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714453491; x=1714539891; bh=KyaWg+bFDLQoepT2YFon+cl6aK4b
	ttom4Cw8IENsWRs=; b=VT6ogDy2ecgixc6CR0iZzYl/y/Oz3SQ3BgIHVzujo3hJ
	/OGeN5PSnq3Ku74IgDDJY1FPbELRF6+RkdeymrvGpsMUXWozvt7kpxkDCM6CbyF/
	b4Bs5JwPV9e07aS8+QMNNFmtgbYivp10u6PL4WdA2lm6wsgeWeqxNhYsZ+gfbav4
	Dx9lMlRWmnhRHZuvV6EMqfsgyPsQP3gjC4CJUDL2P5GroadEM8CcuAgiqQT2YXJ8
	X8LTTDmzoV2dojJhndaP5ySVxq9JN2vGTIgR6h01l8fJgNqvcnzKYD5lwErvLctg
	yX8d83dm1TfMTeAHM8o9XR5MrtoZeuLCVzqqAhszAg==
X-ME-Sender: <xms:83swZotJhlNxXPBHxntTr4I_Ri3pGQ_UBLVl7SL_V2LE_x5DNr4kRw>
    <xme:83swZldOWtSVsHJ_jUQyGw4foHCOOWpc-1prZ1z0j-wGm2Zq-3AR2N9CdP3bnZqxs
    2K-o3D35Z6JwiGTAg>
X-ME-Received: <xmr:83swZjzdaS4d2iWmIczaqHOAy4wCKSAqegpv3KVJ2KdiWMQYkawRxDPrYUllg4x8aRq-m7UQxU6usJWBC1lZsOTmr3T7pe8o3Zk6hbrNrC0SSm4sZYAP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdeigefhfedtjeduledtieelleefhfehfffhudfggedtteeflefhgfdvhfevvdfg
    necuffhomhgrihhnpehshhdqrdgtihenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:83swZrOGCiCYQVMDk2my3RCQCjshdQLP7HiMaJCzO4Yue1pHFU1XiA>
    <xmx:83swZo_wx7zc-spYqvUCtxNpTubzb5eYnqcITv8-7SPnd9G7RdO1rw>
    <xmx:83swZjWD_EnFJfC0tu090GVxZnEgTGvWxYY7larhwicWEYQtZTuruw>
    <xmx:83swZhcN37tRFT5Wqkp57DTsqH2Nl68ky3euUwRw-iuHRFoPKOfyHA>
    <xmx:83swZqLgpNZKYFmuv3R_xGY_FeeMjZwnYmZG6dbtE21ucXawXv0XgbaO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 01:04:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 208bb678 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 05:04:28 +0000 (UTC)
Date: Tue, 30 Apr 2024 07:04:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
Message-ID: <ZjB77nSMou0ssu-V@tanuki>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sJx4T1wqUNnPXDrS"
Content-Disposition: inline
In-Reply-To: <20240430003323.6210-3-jltobler@gmail.com>


--sJx4T1wqUNnPXDrS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 07:33:23PM -0500, Justin Tobler wrote:
> To check for whitespace errors introduced by a set of changes, there is
> the `.github/workflows/check-whitespace.yml` GitHub action. This script
> executes `git log --check` over a range containing the new commits and
> parses the output to generate a markdown formatted artifact that
> summarizes detected errors with GitHub links to the affected commits and
> blobs.
>=20
> Since this script is rather specific to GitHub actions, a more general
> and simple `ci/check-whitespace.sh` is added instead that functions the
> same, but does not generate the markdown file for the action summary.
> From this, a new GitLab CI job is added to support the whitespace error
> check.

I still wonder whether we can unify these. Yes, the GitHub thing is
quite specific. But ultimately, what it does is to generate a proper
summary of where exactly the whitespaces issues are, which is something
that your version doesn't do. It's useful though for consumers of a
failed CI job to know exactly which commit has the issue.

So can't we pull out the logic into a script, refactor it such that it
knows to print both GitHub- and GitLab-style URLs, and then also print
the summary in GitLab CI?

> Note that the `$CI_MERGE_REQUEST_TARGET_BRANCH_SHA` variable is only
> available in GitLab merge request pipelines and therefore the CI job is
> configured to only run as part of those pipelines.
>=20
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  .gitlab-ci.yml         |  9 +++++++++
>  ci/check-whitespace.sh | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100755 ci/check-whitespace.sh
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index c0fa2fe90b..31cf420a11 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -102,3 +102,12 @@ static-analysis:
>    script:
>      - ./ci/run-static-analysis.sh
>      - ./ci/check-directional-formatting.bash
> +
> +check-whitespace:
> +  image: ubuntu:latest
> +  before_script:
> +    - ./ci/install-docker-dependencies.sh
> +  script:
> +    - ./ci/check-whitespace.sh $CI_MERGE_REQUEST_TARGET_BRANCH_SHA

Let's quote this variable.

> +  rules:
> +    - if: $CI_PIPELINE_SOURCE =3D=3D 'merge_request_event'
> diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> new file mode 100755
> index 0000000000..1cad2d7374
> --- /dev/null
> +++ b/ci/check-whitespace.sh
> @@ -0,0 +1,16 @@
> +#! /bin/sh
> +#
> +# Check that commits after a specified point do not contain new or modif=
ied
> +# lines with whitespace errors.
> +#
> +
> +baseSha=3D${1}

Two nits: first, I wouldn't call it "sha" because it really is a commit
ID that may or may not be SHA if we were ever to grow a hash function
that is not SHA. So "baseCommit" would be more descriptive.

Second, our shell variables are typically written in all-uppercase. So
that'd make it "BASE_COMMIT".

> +git log --check --pretty=3Dformat:"---% h% s" ${baseSha}..

Nit: there's no need for the curly braces here. Also, let's quote the
value.

Patrick

> +if test $? -ne 0
> +then
> +	echo "A whitespace issue was found in one or more of the commits."
> +	echo "Run the following command to resolve whitespace issues:"
> +	echo "\tgit rebase --whitespace=3Dfix ${baseSha}"
> +	exit 2
> +fi
> --=20
> 2.44.0
>=20
>=20

--sJx4T1wqUNnPXDrS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwe+0ACgkQVbJhu7ck
PpRDHg/8D0vdW2wP32MDg/hq8QpFxQKqHyPkBRWwXk1uv+4fjCcBqyHj8DIzun1E
9J7WdvE68VTqAbgxBIV7bv6XR3goTQpAHU+YIgvr3vvEHVA9Pc5s/5Od0qilwADm
LKKNeGu1G82kfSjaINQlNKfWXi3wC693TfJZylmNHuq5/RBijsehIjvPE5Z2C0On
gtNCNOQpJ7wY8RoeWGELfklKIuCwBAYh3RV3gWxRYXx4PZ1QgtK2p8CZldqi7xdr
iOeaZK8stl6V07tlrWBXitrhCb6h6XLnLqBn989GyUDkD74Xmqw1dk/UvGyC7/I2
QjpY84U2Q1Tl4LDkw+sppHmvlwr3yuZN+uO+FI+uvGnY9b4uxD46i13oiLsgmM0Q
zcn7XiNJCseumaVBTIMZzeo1PWFQn6gpLU8SaPW8aYAXzekHHIrZZug0RhYuiblW
E7AJwlqmBoVC00+JS7AS1pKjEcIwu/fbpA7dzVSMrDGxfC0oJBWQ3g3zHBRUVOHs
oLqHHFODpl4EjRoRmo4qEcei+UNlc4XKiUcLqf+t21PBNRsxwtAyuy6hw/stfIas
6Vv2308aijNEjd4eg7yyXsSy6mrHDsq8gF/FM1l9dZRTNMioPtdwTmTEx5byWLyF
XmFy6QVUTTdtmfWH2bMQLb3nY55yOCwuVmmXMKvAuK9Rsr5835I=
=k2Mq
-----END PGP SIGNATURE-----

--sJx4T1wqUNnPXDrS--
