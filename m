Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770C1173F
	for <git@vger.kernel.org>; Tue, 14 May 2024 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715661141; cv=none; b=VVfE4AzSaimsCUKtpCV+HvwZBCPdxHysnrT+CGlcNpO6UX8TIiDATGQQMF2Ua4g6cU+XkfhRNG/ZvqGZ4Wyc53UL5s8jzTWOt1mSza9mXT0E1Be2lXBkCT7X2K3CMwvxW2guEkT+biG0IGy/8/NQZxkVxzljCnzSQwIEWm66eYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715661141; c=relaxed/simple;
	bh=sbYMp+3xLezDEaBSsvamHWjwX3Mky+chEqF4wo7ZRV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/xpM7QHkXXHiUchJuSsPtfy1IQOrPpV29409ATsJmsdCpfiH/g3395K54EG9ZMhYYPxVLgbmp71DGP6+ZnTpmC4HW7VVCahdJTNkNayj5TWeU3jH+fHg9Ei+vxhi/IYN/Et6ixr2YlADfdIocVTgoqEQrNywu7B5/8jKj/h4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ALisnGXp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a6i4vyjH; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ALisnGXp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a6i4vyjH"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id AEFFE1C000EC;
	Tue, 14 May 2024 00:32:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 14 May 2024 00:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715661138; x=1715747538; bh=Z0Rb+e2p4j
	d+5A/rqbpA2oi5Z/nSN2byehmHPxJQA3Y=; b=ALisnGXpQlWUpJ62KlnUUXhdFu
	36H9XekUxuiQYzwEei1kjG0vh0ZWRTh7Vk5d8HVH5fzV8uSUZGipCJthKMdI44Jw
	0+gxkmGHQ4j1e+W4sZ8rCIkfyuRF+YjLOqj5i3apUP2RE0bQ3DU+ZGKS3lLQHZt7
	lmUyfjM84bteLAM2IgfwDCenst6BlfPRtf+vfDO15i30osH/Oqi75KM8AaoBhgMF
	UNiatfLmY7TQr/I2yWjHqitXJsKnnvVOAbF5LLXT1zXc8+zLCtT9AXPIewkDWIi4
	b/yvgyjnPOZwfzrsLRc4D0FuNlu5HBeeCSnCn1L15rkgs5i819vvGwvnUedA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715661138; x=1715747538; bh=Z0Rb+e2p4jd+5A/rqbpA2oi5Z/nS
	N2byehmHPxJQA3Y=; b=a6i4vyjHcsJu/WYxXhmdEpM2kMiTpOPWYxaRhPnyALXj
	e3nPFXBwxeL1GRfIV2fFKHzZyuYFWQDX3XBID0Fjp9qXYwEF4tDAw45r7Y6esA0k
	FUwa8BJsNKHMDOqRDJ5P1DyGMPnvmKCOegwuX1N1JmEqdgvO9ZWPlUP2PP23OEPT
	mxYpq8PnPB/7IOcii4Qy7QTXoVaKG5SdxC2On1Bty7YukS8/hTYKk6iWynzQVWWj
	05Y299BJmpBO4452oawrUF0jUYrbophzCG+lp4D7reeryU0X3lgq8KxXp4dR3DTL
	IkbUl5V7R3+I8I+GOAoo3mabkjBE2vQuyYhZaAnWTg==
X-ME-Sender: <xms:UulCZuFvDeGfhWD8ROkbVr2xpK9nETevRx2o2jnwOborqBuyopM2Wg>
    <xme:UulCZvXknm57eGXSJfTpU6PA1lsqVOvmhzjXGgrYAUt4uCuXHizNnsZgzikEegPwd
    acCmNuTPO-p9aPmrA>
X-ME-Received: <xmr:UulCZoLyl1pdcTQrOPDRQYx3NAbGmWvLFUUgLBzFJ4zLaTpAtZOXccI72KkA5Fwwja83uM41CNmmjsgO-oP-0b9P_0bp1ao871Enj6F5SJGqFPc_1ZZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:UulCZoF5TqfY3CoYQKv2Ob6YCIyV-cVvQbu6QQFd9LqBD6SkC7xsRA>
    <xmx:UulCZkVmw9pNUCtbvZwnIOsxUS6mV3Yh2NNiTG5Mjvq__vVrSlbElg>
    <xmx:UulCZrMll1E7HSlCw4m0oTMpJhCikMzj_gs_Z1PDWSIftYh4lmRipw>
    <xmx:UulCZr1w2_ZNHnIWbUpSH8nCOmp2YOlnBP5LDIjjVy5s1hytAV3EPQ>
    <xmx:UulCZhgXee_EnvAi-yOrKOPS1hOR9pHW1JxpYL5_-G7H-uzsitjF6GdJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 00:32:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bbf6e000 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 04:31:57 +0000 (UTC)
Date: Tue, 14 May 2024 06:32:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 2/5] t1517: test commands that are designed to be run
 outside repository
Message-ID: <ZkLpTwNgFGFyC4_N@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240514011437.3779151-1-gitster@pobox.com>
 <20240514011437.3779151-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CcFOKBEqCrcIBB5s"
Content-Disposition: inline
In-Reply-To: <20240514011437.3779151-3-gitster@pobox.com>


--CcFOKBEqCrcIBB5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 06:14:34PM -0700, Junio C Hamano wrote:
> A few commands, like "git apply" and "git patch-id", have been
> broken with a recent change to stop setting the default hash
> algorithm to SHA-1.  Test them and fix them in later commits.

Is there a specific reason why this needs a whole patch suite, as
opposed to adding the tests to the respective test suites of the
commands?

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t1517-outside-repo.sh | 61 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100755 t/t1517-outside-repo.sh
>=20
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> new file mode 100755
> index 0000000000..e0fd495ec1
> --- /dev/null
> +++ b/t/t1517-outside-repo.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +test_description=3D'check random commands outside repo'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +test_expect_success 'set up a non-repo directory and test file' '
> +	GIT_CEILING_DIRECTORIES=3D$(pwd) &&
> +	export GIT_CEILING_DIRECTORIES &&
> +	mkdir non-repo &&
> +	(
> +		cd non-repo &&
> +		# confirm that git does not find a repo
> +		test_must_fail git rev-parse --git-dir
> +	) &&
> +	test_write_lines one two three four >nums &&
> +	git add nums &&
> +	cp nums nums.old &&
> +	test_write_lines five >>nums &&
> +	git diff >sample.patch
> +'

We have the "nongit" command that does most of this for us.

Patrick

--CcFOKBEqCrcIBB5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZC6U4ACgkQVbJhu7ck
PpSfsQ//XcxqB6rdK/x8bGB9wQbs+LWXz/k4hXPLPUs/HoVG2MqnoyKihegDFbKW
CfzeqQrpcyaXyOdSdrt1FFDZcO25oC3gnbXyZgEfS26sc8dpMn+kXkHdb1Tm51NO
fqH1v1PdSTyCBxTQOXCJpiiQz1SF2eLrs9el9a0FHG1Qh58zKXfgCUDLSYJezPwM
KD3q8t4Ncnk5hIligTVpHaxAX88mWWpowPgFBIFm/R5ZwFBrBY2yYibO7r+ZxIba
6QXaGtdLeHmYZxYhJ1aXkA6OVgs01jFdHmsaR6kjcvRpan6hC1v0Lo6QIXw9g6IZ
lXZ3IoyRrildRwYwMSztk+eWkbfOqAJaoSbz5UhRanrpv7TT6FteXEG8Qpzosbx6
1jtpCur6B0SWoC2T1E8iIc5ckQy2I3f9TrqOu5P9b1AZRRe5iohq3jMepXLLB9gz
rInW2MiQmnz9V0fCZZlKwUhw5O0sWQz2JvLV9sd3sWoH+jGwfngADc/L6RhtRkBL
GtBpYnaSog5pZdb8y/NpxBUw/W4XnCBxJerLEh9j5fS2QSclb2YBCcwHuh5gt2pp
H50eKndatGX5KlSBmMmjTHnULAIXh3sVtUOkVnMX7dHvuVZhDQVqsJ0OB42jrSoD
sUude65R6Iwddh0H/sL59ewZnq2c0duIzq/Jiv9SCGCnMu2IbFI=
=HMBp
-----END PGP SIGNATURE-----

--CcFOKBEqCrcIBB5s--
