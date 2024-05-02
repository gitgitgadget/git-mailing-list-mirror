Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DEB22EF0
	for <git@vger.kernel.org>; Thu,  2 May 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636055; cv=none; b=o5q0bsW/rX8kP/r/e1ToQvZ/FxobNJKDrtOlqLhOvHl/1fCXsy6rWuORHjZrE+G7BoiD5dxQNZRjOqlzXS13lXVeSd1Ekc4wFliKbSlZ+lBE0FFk7M6OqSwMnT10P9yb7kiChC8bs6e/TXuoJb0xELtA/9eYPxazmz+PoiHtNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636055; c=relaxed/simple;
	bh=Vsq0wxdKuOprR3nkUfd0MI7Uv4WVHfujbIIWSM7TeUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+a1/tVkdvdnVYX0ly01PMS5ehb9YysGFn8pgfLpLf/iNAuDnkkIeHr1o4+q7UEgDutH5Bnz9yczjbIE3t8NFD0CwgON4Ip41r99iVEQvmtKfSlWkLVC7LKYTvrKH26xahIeZL4wrZaE+b9YYTQTObXiLRaXI4Rlgr7YyKMB0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=upC1GOCB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9sfGQSI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="upC1GOCB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9sfGQSI"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9CA611380F77;
	Thu,  2 May 2024 03:47:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 02 May 2024 03:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714636052; x=1714722452; bh=zl2Zr1BlOm
	UZ+yKP4eCIGPNM4A7TE2aDSQiMQhrb7rM=; b=upC1GOCBPuhtgSG0UbFkPAmuTV
	8oMO18ChHcH1Aop8/KNc3ur5tP4Wo1VV54hQdgqBdYHLlbqnEUt8AH5bD54Mos0L
	KlhUXH70/ScaH1lD/MihUvOysYsi+Xku94K9kBbeslBobKz0rc9G/qmsoCz4eoGR
	GmqmVDmvLs7nzC/UZ2wYv2i5UJS9YT8hjxE6A9QKR7GIFC36u8Kcm9wZX3u0pa0d
	7syF0CZYieU6MmKqM70yI52emnu1CNstRmZg+cui58OcHy3RcI4AeZPgmOIQ3Vqw
	ECsX9gsjt3xnAPygg3bgVr0qrsQaRH86G5/q4Xzms9iw2OsmGAuy+JRSOgfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714636052; x=1714722452; bh=zl2Zr1BlOmUZ+yKP4eCIGPNM4A7T
	E2aDSQiMQhrb7rM=; b=T9sfGQSILG8hg8uFH/oYyn8e33D0Tm9KGvrKciQhdYxZ
	YUBn2SVzBtAm2QT/Qfs+HZXc7sFqVbBkTQS2ek1YqtDOYvD/Ob/Ji3loCXDcfchq
	lvcIC0y7tOVTRaITUC3JnzGwyXklFK8i8FQkW2m1qoHiETcp3dpkSVWESmanWOZb
	X1Zn32KPM6H4YNt5nu/qzfLOkkbpUAu13P77vqfkpg2WbmL4UV868lZOhceYxbVQ
	mrWz4lsJhQY83vBW5xOq+qsPAqimzQHuryXi+wBuB7NVJ9K0HrmWtLTg+x36Huh3
	jTh3eOxkwilHCeha5AUOOIXjP5FHmdtVPAnfDxCL7A==
X-ME-Sender: <xms:FEUzZt8frbUyPp5HYNl1JzcCv9h-zaub2Pe3pH-E-VFosgHNqJuDcQ>
    <xme:FEUzZhsI4_B9Wh5YV055NVXGJIu8c_KK9pKAeWZI1Hmge4zI0XEx_zxBmflyDh1vc
    LDzIJcrqhDBAg-cgA>
X-ME-Received: <xmr:FEUzZrANN2RCSIKEw3QN8RcIqaPX1zqnuX25fSLawIM2YkZEBUv9WqGcz5jPno6oVLDRbfR2wCpsyyaGH_pTABJQpcMEj8XzKZM5v62TqdTB98s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:FEUzZhdg4KTl2Vxlnj5R16e3xXPm3z6ZPGDlFISA6t2KrlTwmN3SDg>
    <xmx:FEUzZiNYVY2-wJruOlutV-v1aAjTJ9EU_4s2L4itL61P0LTGZlHfKw>
    <xmx:FEUzZjmVsPVlK-u4HbiuYPXlbdOWwTTLJdUNkk1jPLaEnFF9cIT-dQ>
    <xmx:FEUzZstQarOoFLMQCWeNAYze9tFDaza8DVSgHrxEe6fyFdLnX_bh6g>
    <xmx:FEUzZvoNK0BozCjjeW2nPa0_ifpu51X-Yz5bWmLr0KYIm6C1FaqgDai2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 03:47:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e87bf77b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 07:47:05 +0000 (UTC)
Date: Thu, 2 May 2024 09:47:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 5/7] refs: use transaction in `refs_create_symref()`
Message-ID: <ZjNFEHA9QgQlMl5F@tanuki>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-6-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nSxaCI9sdoYbNpZ3"
Content-Disposition: inline
In-Reply-To: <20240501202229.2695774-6-knayak@gitlab.com>


--nSxaCI9sdoYbNpZ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 10:22:27PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The `refs_create_symref()` function updates a symref to a given new
> target. To do this, it uses a ref-backend specific function
> `create_symref()`.
>=20
> In this previous commit, we introduce symref support in transactions.
> This means we can now use transactions to perform symref updates and not
> have to resort to `create_symref()`. Doing this allows us to remove and

Nit: "not have to" -> "don't have to"

[snip]
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 178791e086..9e8d22bcbd 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -286,7 +286,7 @@ test_expect_success 'ref transaction: creating symbol=
ic ref fails with F/D confl
>  	git init repo &&
>  	test_commit -C repo A &&
>  	cat >expect <<-EOF &&
> -	error: unable to write symref for refs/heads: file/directory conflict
> +	error: ${SQ}refs/heads/main${SQ} exists; cannot create ${SQ}refs/heads$=
{SQ}
>  	EOF
>  	test_must_fail git -C repo symbolic-ref refs/heads refs/heads/foo 2>err=
 &&
>  	test_cmp expect err

Nice. Not only do we have less code to worry about, but the error
message is better, too.

> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index 2092488090..4433ac2177 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -134,4 +134,27 @@ test_expect_success 'interleaving hook calls succeed=
' '
>  	test_cmp expect target-repo.git/actual
>  '
> =20
> +test_expect_success 'hook captures git-symbolic-ref updates' '
> +	test_when_finished "rm actual" &&
> +
> +	test_hook reference-transaction <<-\EOF &&
> +		echo "$*" >>actual
> +		while read -r line
> +		do
> +			printf "%s\n" "$line"
> +		done >>actual
> +	EOF
> +
> +	git symbolic-ref refs/heads/symref refs/heads/main &&
> +
> +	cat >expect <<-EOF &&
> +		prepared
> +		$ZERO_OID ref:refs/heads/main refs/heads/symref
> +		committed
> +		$ZERO_OID ref:refs/heads/main refs/heads/symref
> +	EOF

Nit: the contents of the heredoc should be indented one level less.

Patrick

--nSxaCI9sdoYbNpZ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzRQ8ACgkQVbJhu7ck
PpTWvg//QDsTEG68zhvRUrLPWJWP1Cqxm8Fs0/yq1dtNjR9LJ0dQXG9l5IJWRbsP
b7yRdmS/h+DlYRi+99apLAm/22sx4Jcr7ETXMQvbVQloTdK/Jt1qqC+kbgt8H7db
zvIkA5mzTOGhW3poQgT6W8YbNRdTxDYGDgJ8rGshRELU1jOa7/v4hS3arkVHKz68
SBWg0zmWfFPS8CclvSaYRzyIGOjkiocLMqAtwf9/Q7ESjEPiB1maKuKmUdXucFBR
B7f288kXC5Imwg/mBptsDoI1YPwMUr/0gkbVzUqMqDoih1FZFezS7P8cgv3Wp4WS
6Zi9yAnHL2uRJ/T4tjGh0Kzn0nvT1epsChmuPxR/HbH91noVgKbuZGNbUmVWf+Dz
nhxmQWohhd4CnMD8zApjD1OpiTUjaygOTtFgGOziZweCSEF5r3rPWG6I6vLbTVv2
vMgTYm8ysQuqZ0eaJbSrN0RvKhvy8cpaLd1kBhLKrDyABkukkqqG9bdZJ4bxx2u7
/duQZSsUWEtZSwmfqDA+Vd9283dtaQFT7CtJFPTLe9CQ785RdQBQEV+pc0NO8oAu
tiSNQrsS1hRBFZRHH7q0MhDjpR/Gn44GM+G3Bynrc+qtkC+01qFlaASpOLDY42St
3I0I8A+vVBXskmoj1lRjlxYuo0tozX1L8EpZ00bvjjdIID1qpDA=
=BbPs
-----END PGP SIGNATURE-----

--nSxaCI9sdoYbNpZ3--
