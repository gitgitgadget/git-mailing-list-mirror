Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5C320C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546366; cv=none; b=AjqccnfF1KdmG0Keg1/vzRbppwZyNVVnZSQ6lADtIPRhyZ9gpQFO7UiZkP9PHYUaNlLPaykN73ohbfwGtXdI8sznItrjV5IDY0BBSV1FnmpstJYlwhG0b6Rls7IMTlzYcU1gwJx6r6PotQSzf3VnT7IUx9b8/w/uk0uPX6SetxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546366; c=relaxed/simple;
	bh=JtNYn2NVa/m4Mtvkb+NNei3aEAbzxyo/SAHKCHXFdVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otmKwu0u76voXX59MdimDoMCt/xGiivITQK7gKjsIdnylk4oR420E4oTNV0uOMhUGqz4+WS7rJWC8KCc4sDsQa4Xr3TEzijHBzaEgXhlt6364nMUjTlIF/opPUO2lRh/fPGXynOMpT79b+L6zEND8afOJxdLQFkfAp+/MAGMpxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0QJsIXi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rdWZlsiH; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0QJsIXi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rdWZlsiH"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 5A0301C000B8;
	Mon,  4 Mar 2024 04:59:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 04:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709546362; x=1709632762; bh=ijAiWFUG0B
	2vMKbXelgvpcSFA3zwOe85qG6Ee4BwY5g=; b=W0QJsIXilNd5tCOv1wvnh7yK8n
	QtxI1/IGCgWPCtUJpOXtTXdyZoXxljyftggPcCCrCwlUSuMNCYHj5O9ZpDXKS8nH
	mWpkWiw2lG+Brk0GF52vGsjVwkpibYftjaQXrtkIzctZ7YxGRAVguHJ/OUA/KWrM
	ku/4IrNLF/Qyp7SnGR8X7Lt5rI5RWRA7z5lvvhjGjjfuj9/VRBuFVIIpMdSDouvK
	KsSxmNVcaLJGIvGC20JPr76njR/dIDTqetA7MzZ9dRiHv6hvYH1w7D8tM3nKx8mV
	Ev4UTp4mFItx75NpFXor0xdJwTu5CZeoRNbokoev8MJ7khYxjMt6vVoUvCUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709546362; x=1709632762; bh=ijAiWFUG0B2vMKbXelgvpcSFA3zw
	Oe85qG6Ee4BwY5g=; b=rdWZlsiHilQAQmP8x3hJosOCen4VRaR4JQE6Ds+iLQlV
	mXK6ZssbQqyWdimnqC5pQ/t/XbmI40r1C2lBOkSimSRWS5YCiwd/cjNQSFW2Xg4+
	hY+jya5jXfKAMEzbEjwc5UBnufRo8lMT34VCe2JIbqIJEGOpvZq+cWhf4LuS5gwG
	vNoKEMngl2kFdgFB2Bg9fvDEjg4N8XM1Gu+QEcUKjsWRvyMrwnEFxnSJt8X3T1ox
	3N0I/NofvZZ5XW1TWyZkF9BNuscuWYWDJ+tOJQLn8HTjWf4limTrglTwJF7je2ie
	ZXWbE1jV9yJ7530gaxbpXp5b47nlt+CDn3/FcEFd5Q==
X-ME-Sender: <xms:epvlZYx98Cv_eOvaxgRAIQdNYncS9nNkedV_ci60iXoMgeKbwa1uqw>
    <xme:epvlZcRYNzPt_njazQlTiFOLUhYdStv0VQBr6Lri0MVsNZa3A0CMpHT3PBvJwYFtC
    EC_MRhg66H_rgm0Xg>
X-ME-Received: <xmr:epvlZaU7YUxaKyvvAbr49gUq0XF07DhtHbrrX00eYwewH4oYKFcESLys3NyBLvmqDg6PGl8Q1uH6YkX8ysLfkCSYdbcz-LVs0c2bjpedaCJlgt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:epvlZWgP_DeN9G474VQ8D4GM_Xkp9mwgIXEILwGroOotQLBZ3Xl7xw>
    <xmx:epvlZaDDTeysAC836JG7ZZQG-Sz0qWVzLTInsZGnxSKrPm30iaMYMA>
    <xmx:epvlZXKnRBM4rndYbN6Fa1Qv4xgFdmPurpfhB1B4sHR3WiftxTPHLw>
    <xmx:epvlZd_pLJskoK4mzv7fDA7rTDCj7unckVIBJZ6J7o2X1wcrOu251NFrzIU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 04:59:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 467ad3d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 09:54:55 +0000 (UTC)
Date: Mon, 4 Mar 2024 10:59:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/1] [PATCH] t9117: prefer test_path_* helper functions
Message-ID: <ZeWbdvFmhUYN9ekE@tanuki>
References: <20240301130334.135773-1-shejialuo@gmail.com>
 <20240304095436.56399-1-shejialuo@gmail.com>
 <20240304095436.56399-2-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P+vGhBWvK44yTp5/"
Content-Disposition: inline
In-Reply-To: <20240304095436.56399-2-shejialuo@gmail.com>


--P+vGhBWvK44yTp5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 05:54:36PM +0800, shejialuo wrote:
> test -(e|d) does not provide a nice error message when we hit test
> failures, so use test_path_exists, test_path_is_dir instead.
>=20
> Signed-off-by: shejialuo <shejialuo@gmail.com>

This version looks good to me, thanks!

One suggestion for potential future contributions by you: it's always
helpful to create a "range-diff" of what has changed between the
previous version of your patch series and the next one. Like this,
reviewers can immediately see what the difference is between the two
versions, which helps them to get the review done faster.

Assuming you use git-format-patch(1) you can generate such a range diff
with the `--range-diff=3D` parameter.

Patrick

> ---
>  t/t9117-git-svn-init-clone.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
> index 62de819a44..3b038c338f 100755
> --- a/t/t9117-git-svn-init-clone.sh
> +++ b/t/t9117-git-svn-init-clone.sh
> @@ -17,32 +17,32 @@ test_expect_success 'setup svnrepo' '
>  test_expect_success 'basic clone' '
>  	test ! -d trunk &&
>  	git svn clone "$svnrepo"/project/trunk &&
> -	test -d trunk/.git/svn &&
> -	test -e trunk/foo &&
> +	test_path_is_dir trunk/.git/svn &&
> +	test_path_exists trunk/foo &&
>  	rm -rf trunk
>  	'
> =20
>  test_expect_success 'clone to target directory' '
>  	test ! -d target &&
>  	git svn clone "$svnrepo"/project/trunk target &&
> -	test -d target/.git/svn &&
> -	test -e target/foo &&
> +	test_path_is_dir target/.git/svn &&
> +	test_path_exists target/foo &&
>  	rm -rf target
>  	'
> =20
>  test_expect_success 'clone with --stdlayout' '
>  	test ! -d project &&
>  	git svn clone -s "$svnrepo"/project &&
> -	test -d project/.git/svn &&
> -	test -e project/foo &&
> +	test_path_is_dir project/.git/svn &&
> +	test_path_exists project/foo &&
>  	rm -rf project
>  	'
> =20
>  test_expect_success 'clone to target directory with --stdlayout' '
>  	test ! -d target &&
>  	git svn clone -s "$svnrepo"/project target &&
> -	test -d target/.git/svn &&
> -	test -e target/foo &&
> +	test_path_is_dir target/.git/svn &&
> +	test_path_exists target/foo &&
>  	rm -rf target
>  	'
> =20
> --=20
> 2.44.0
>=20

--P+vGhBWvK44yTp5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlm3UACgkQVbJhu7ck
PpS/pA//RuHmSNVT357ZLYuoGGWFmR5LwyEmApvlyHC8pHB9g+cEcK6vggmIgqHj
3txleukBkxLKBN/OyIATDfHpJx9KvS7rFQG+Ahu3EBpyVmVHI/CurPOzOiCUyhf1
8m5wuU+9pnsvIouTJKS4DwM0fBh0HgWuQwoEhN/AFh73SpFASRZRDq8yRpfCNPqU
LPdv1L8JlyRfNLTBVbqHJVwtAVNanNHA/E00yuiDb79OTxfLbaSdOeSwluphaA8z
ZxxAvqkI+hfzgDQTW7QHiIOgpdUMMj06iJR7e4LdvOtMYnY1VGnT7bcLfB9yZTZr
+Ch562j4raqhf6pHdXcTHq1xb2Rbf6k1ONQpThx0MNN8b9UD+KRHI3sUV2/Qqn3G
G+uuO2DznHPQaz2DVERmdR1tODMvvRGtLJl9JzcY0Ns0hW7lvvRiZsJD5vnR90bH
8YGC6kZFFuRx2AMHM2+pPnODUt2uMzWsfDdQFfXrpvNhySk1M1tgDnrzr7DusyLJ
+vFuEKItrLmJaVfX7OYpiFaq/Sv1btftAe+AMO9a0e4gZGp78PG9B8BVY+tenaWa
yW3brLICIqv1NfeOn+QTstK4xsq6DXWmuyWLBt/8t0yvI6bbtS1C+4bm7qiczWuN
n52u+5tmcckRKkPoU6hJSy7rpE/mySZSLnnMvr2Dl43Ef9bajRo=
=f2fR
-----END PGP SIGNATURE-----

--P+vGhBWvK44yTp5/--
