Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761D27473
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025896; cv=none; b=qaXbz4qFAzo+p1zHssSh1HOC3BMatuZ1VIsilVJenSFxMFMkY+epinOhPoQWg8sR9TZ2HCy9hdUZOd6xEmOVyuh/DUrKAFeL98yORRmXsYj4FvHEXljuIOjPoQ/dua+oUvKvHZLiDe7l9oFIlhIzbCjwWxGB2gd14Js0NQJO9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025896; c=relaxed/simple;
	bh=4qwAt1sXFrwXMLWf4rDDac3D+7BSNQClhAQPjBZZvPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoVPb/Fq8woYBUC8tj8psSzDCl66Z3GEKHIOgr9gGTDzrLld+yUyf7nI+rA1vgaoaD2bRHv0HyuoHRKww9fT0YJXIRUzdiqI/khfxWlkqFWhGEZ2jOSwrLaLLZ/Ou+8IrHe1cZK7h1nf/a7ooIt4FexdHJnkarUYTInOZEw9fsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bs6hFDoN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cmxi6Gzv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bs6hFDoN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cmxi6Gzv"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 36F0A11400EF;
	Thu, 25 Apr 2024 02:18:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 25 Apr 2024 02:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714025891; x=1714112291; bh=W6FoFjd3Tn
	vneYnV7YKs/VkyV5pL1j+uhnmdJSQV5Wk=; b=Bs6hFDoNpB2K6fhnwzq6Ywxwms
	iChd3uHlR9Om+U9x9kfOy/OtNcSLwuAIHgXyMKLeKffrFpTqWZ+uIxxpLOZlOdMl
	um1dfW+/hytGgIbHH3jQAEdzF1UDiygIO15BA2Yp4XtefHsfo5gPrGzan/lTOTMA
	zhX4kiHhH0gn8UC2OiXoNWCYxrJ7mkNtuqtood94oPUSSwEU/AHe+tu/X/sQqKws
	LFgN2KN/QGFtvZz4jkNQkiRcf74IXusGpKCI5w7RpO3lcPdVoMvElNcj5Fjoe2PC
	gNREDjxmzemFYO1M1zdiZ9hQG2cU/j53b2R2bNM10rTAdmjDRH47LmA7Lcvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714025891; x=1714112291; bh=W6FoFjd3TnvneYnV7YKs/VkyV5pL
	1j+uhnmdJSQV5Wk=; b=Cmxi6GzvNMYYfREf3QtOSBBkDQkbkwL0J3GnrHr6xc9i
	FOVzzOQR74dC87U6np7LkKl9ZZJzHH3xqvTRJnTJ3IPJn2HRCi7yGzl2DtbHHV87
	+DcnYKE1mSqvERuQGzfGqduIP0Tf54Fs4k3hEbPI7NsVZMdlfN9shhQTs7oI0H8w
	Ty9q6qKiILP7VQhOhTYO5cMtpglQ9IRzAOGCZQGmAthycjSGszB+TIYNK3E6MJKN
	iUSEORvnPGkFC4/BYKDwd40K9mQo30oLFwMy8xznInAx8YWzGf7ptNB/NRYmrtTB
	jDAS8KPRxrqSAkKOfaKXSPjIMi05kbFNd4TRqYjY3g==
X-ME-Sender: <xms:ovUpZqhUAbhzugEmgZdLTvG6z3gFT89JafKWUrOp8QtOtNmRzqSTQg>
    <xme:ovUpZrAXdo2XbOPni00ae7eC2YprynCh4Y-woC6kHghwOVCs2bbWNFDXpcTQBhlrD
    mwhWTcJrJN_ffzxQA>
X-ME-Received: <xmr:ovUpZiGOMML86Nu78I18-jloskomnmwuRxzJNVRDxw4cXvu3ZCwhBJjLCtea8Q1990UM4VZT6iPaxWSzRZAiZnrlXO7a6TbuZL6zKUe7LwnFNX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeliedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ovUpZjSWrTe5xKfzjfiG-gLR7TFntzvWfjk-dUcLfBxcJrkO2E-_iA>
    <xmx:ovUpZnxwD3bwEBw5Lm46nAIVACO8Dkka6jfwUwaURwvivhbhbqoeSg>
    <xmx:ovUpZh7p2N5RWs4UhkmiSI1nerwuDbavViYYcq2M2CkSX0HkhJNJjw>
    <xmx:ovUpZkzHESJG4Ir2Wm1Eug4E8amR1we46bQVTj6B7vSo8U7WSFCeFw>
    <xmx:o_UpZptzAMbP-Z3SD-PYP0bOnbfS599LBnGBGLBkmXxV0DCyJw0AgnqN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 02:18:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id be9bac6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Apr 2024 06:17:55 +0000 (UTC)
Date: Thu, 25 Apr 2024 08:18:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Roland Hieber <rhi@pengutronix.de>
Cc: git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] completion: add 'symbolic-ref'
Message-ID: <Zin1nOSfckSt-H0J@tanuki>
References: <20240424215019.268208-1-rhi@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IlobtzfFoocmthRe"
Content-Disposition: inline
In-Reply-To: <20240424215019.268208-1-rhi@pengutronix.de>


--IlobtzfFoocmthRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:50:17PM +0200, Roland Hieber wrote:
> Even 'symbolic-ref' is only completed when
> GIT_COMPLETION_SHOW_ALL_COMMANDS=3D1 is set, it currently defaults to
> completing file names, which is not very helpful. Add a simple
> completion function which completes options and refs.
>=20
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> ---
> PATCH v2:
>  - no changes
>=20
> PATCH v1: https://lore.kernel.org/git/20240424210549.256256-1-rhi@pengutr=
onix.de/
> ---
>  contrib/completion/git-completion.bash | 11 +++++++++++
>  t/t9902-completion.sh                  | 16 ++++++++++++++++
>  2 files changed, 27 insertions(+)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 75193ded4bde..ffcc55484bcd 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3581,6 +3581,17 @@ _git_svn ()
>  	fi
>  }
> =20
> +_git_symbolic_ref () {
> +	case "$cur" in
> +	--*)
> +		__gitcomp "--delete --quiet --short --recurse --no-recurse"
> +		return
> +		;;

Instead of hardcoding these we may use the `--git-completion-helper`
option, which outputs the options for us. We have `__gitcomp_builtin ()`
to do this.

> +	esac
> +=09
> +	__git_complete_refs
> +}
> +
>  _git_tag ()
>  {
>  	local i c=3D"$__git_cmd_idx" f=3D0
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 569cf2310434..a34953da6c96 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2518,6 +2518,22 @@ test_expect_success 'complete tree filename with m=
etacharacters' '
>  	EOF
>  '
> =20
> +test_expect_success 'symbolic-ref completes short ref names ' '
> +	test_completion "git symbolic-ref foo m" <<-\EOF
> +	main Z
> +	mybranch Z
> +	mytag Z
> +	EOF
> +'

Nit: let's add a newline between those two test cases.

Patrick

> +test_expect_success 'symbolic-ref completes full ref names' '
> +	test_completion "git symbolic-ref foo refs/" <<-\EOF
> +	refs/heads/main Z
> +	refs/heads/mybranch Z
> +	refs/tags/mytag Z
> +	refs/tags/A Z
> +	EOF
> +'
> +
>  test_expect_success PERL 'send-email' '
>  	test_completion "git send-email --cov" <<-\EOF &&
>  	--cover-from-description=3DZ
> --=20
> 2.39.2
>=20
>=20

--IlobtzfFoocmthRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYp9ZcACgkQVbJhu7ck
PpQ1xxAAgnzvFwqJzTusm7KcbB09hp2tq+DI0mSybLR/AuVmtUcZpcjhCSySzL0K
u69TfjNuFaBvQ1i479Za4OVw1PL/+xVeeMGU6b4g06sNB9/sgjFE9wS3fQTeINB7
qSZXoZwWQp2MtixhL2HDMEbenBi9Ys2bSGaStnXc7/akWZF12+X49FS31tNunPyr
4EJWiz4FLS2Su+T2Xc5Si90F2jItPv4y5WODlxXBb/083zLv04hNhlZ9vqQH2d6I
MV7MZ12Z2IOaw7sWHqQQaM2+72yDOIE9L/1B7PpxBwbg/+ABQyq1Fg/ym51z0JTn
cdbsPH+oIW1qYNyC2NtuO93LqmOWB3P4MOhynqWVsOkuazZqzxwerzurI4mwry7H
wkOeW8bWF+UJ/ypLaIfypQCBi9eW8RFhOM3Gv2up3k6lmewrJtaBiHzj0BhoZgc1
2BIhXTx9GSCk4aPOKfQArW4SABv5tJ39JfUqCHANQBbUELKITQCae3C25rXr02uc
avn8opxkQX2i2amrgCJ4ygikZt//FHJanh0UISp3aieCoCoKsfVxp/YYN50+/cNA
/ddvUwjMDSM4avpOeviqYqJgR4BK7tpPDl/S7Ddbe9+wt/ArHpYd84Y9h+Ywt1JR
ng3pj5ZLhGHWwF9NrtvaCGdrGVKFgqZzrjKhSykZoGv3OAmZ5Zg=
=Cdtz
-----END PGP SIGNATURE-----

--IlobtzfFoocmthRe--
