Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC21EB3F
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165734; cv=none; b=Xh1Y72b9BTdTYr5/7ya+AWgNNN/vfDbSDkqGhKsH0hJT7PUSkd8a77C37JReSDh+/gA7sQiWfacgvnB8RMs65egkEd/hws+gC9qTuxrfKfnc0/JHADGiEDJlkNFKlzfGly/sYNoPIaTHzTr8o+rYxnIiNyE0rTwjKD7j8x2FJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165734; c=relaxed/simple;
	bh=+90Yrt9zNxfsQjThynYkR6iPXrZzljpPp2LH+uNPsXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhWV4t2PHR/qHnqz5Wa100cKoMvK4ptd2YUxzmlYEeQ8lz3bNCsqKeq2iTzOO6HJvSHrRB2N7SUBNqsRvUqpqEPW9JCQCZL1tydwH69IJ1qo6agWeWGlaxXZl6qf64H9Z8eN84ZbCXrRfGnjgGv9+QGFcFMgr1fnhpLd8rPmbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h/seDSzU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dfpEeSv+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h/seDSzU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfpEeSv+"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id D56FC1380460;
	Mon, 15 Apr 2024 03:22:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Apr 2024 03:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713165731; x=1713252131; bh=UeAzEK1UdD
	FLJllxTrIqxc1bU03q1lr5qwuWcQWm6iw=; b=h/seDSzUkdTi8+3FWX0/2M8so1
	hfGut/EVns3COP3WnyzSwHdRemq/ZkJCdXwmqTFPAF0Wl+jcegCMefwEpXlTudwS
	kDxp8az7J4+WT6VK6noqoqVQiR6NRzxAl4Vn3m0NcRwomev0AFwjSSrU/eMXruKk
	7SsaAr2mWD551pACDqVzhPo19ty2Pbnvo9KHixFhIx+P0DwVN6OOuI+/2fA66w/x
	7lCOST590p4f7cQmfcLXdXlRhXp2HVJnhjzLrn+KaZR+lSzGsQq5EKmkUrYfNyCt
	4c9DMioykbobDEuEbvHDoEs/DQLMKll17x6YKYpr2a4ZurtFVUxgTOW76IEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713165731; x=1713252131; bh=UeAzEK1UdDFLJllxTrIqxc1bU03q
	1lr5qwuWcQWm6iw=; b=dfpEeSv+dYmyDMgdE5iLBFS9QHAHxxeznanYg2m/Wy3V
	GUeAk7kDI+5b2gtITVxZG2KFUDCREmD3uxsX0Ji6tgTaOsWH7oSyNiJ7Uai5Sx93
	9m8RBSdKFiYIR0JSoWM+1Qj9fzv3qu6h4RXzE/kpw0nKhl3a3rGZNLLMvVxIUgbM
	lFoCyiwsL/H8udPVsInUXaXNsJ622pMvH0mz5wu8MZ5EGZpaGa8SZVAVzMQLIewA
	Uz1LK16Y+foI494nXnitw0qW6B8tQjQxoLI+guCyEHMbKLLO5mRxNbWDBz9bO3iE
	QLwNKVK7tnNR12c0uKvk3dTnwUWfljkAakJHyjFhLA==
X-ME-Sender: <xms:o9UcZig1nQDYyKEFkO1zuY8KklCKp1J_EqCaz-rkTB-gPFJRt9wUdA>
    <xme:o9UcZjCuh3masp1kCh4qTXOd7TTChDckcav9l44-Vq4u79vyGdHEWp4P3Rm4Cvnwi
    4YkogZ4HlwuNNuCkw>
X-ME-Received: <xmr:o9UcZqGi5NBcuNDeV0dO3RZti2T9AtpHbDswsKqLamA_wUIPIshyGv03q9Zk7kaIYeman1qwEiFSIVvBVBJC4h2cdyzLSbt3eZQi_uHzfImYm3vWTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejuddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:o9UcZrRQxSqrUCHzU5URt-t12A1pIrzZYS4m4X0kLCWhX9e9VrjDJw>
    <xmx:o9UcZvzYuDYcx9So4WgGOd8mXat05r9iYtiqKzqfG8tbBoPIwfbc0w>
    <xmx:o9UcZp5n3XA498swtFbFaVFbUwmLrhIQg-3j05qkq8_oH6NnREnnDA>
    <xmx:o9UcZsyjovW9HKjq3Dwz_pB8ZO8eFKe4c2qMc5rZwydxf11DRHZybg>
    <xmx:o9UcZv_iYxHBPlYfd1qwnItPWqRX3ipMCd1NifKUdDjOzgHIYjr096Aw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 03:22:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1b6da278 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Apr 2024 07:21:49 +0000 (UTC)
Date: Mon, 15 Apr 2024 09:22:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Yehezkel Bernat via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yehezkel Bernat <yehezkelshb@gmail.com>
Subject: Re: [PATCH] Documentation: fix linkgit reference
Message-ID: <ZhzVnnoBFt2nau4x@tanuki>
References: <pull.1706.git.git.1713132482976.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VioJ/SdLd/qIgv3+"
Content-Disposition: inline
In-Reply-To: <pull.1706.git.git.1713132482976.gitgitgadget@gmail.com>


--VioJ/SdLd/qIgv3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 10:08:02PM +0000, Yehezkel Bernat via GitGitGadget =
wrote:
> From: Yehezkel Bernat <yehezkelshb@gmail.com>
>=20
> In git-replay documentation, linkgit to git-rev-parse is missing the man
> section which breaks its rendering
>=20
> Add section number as done in other references to this command

Nit: sentences should end with a dot.

> Signed-off-by: Yehezkel Bernat <YehezkelShB@gmail.com>

Other than that this patch looks good to me, thanks!

Patrick

> ---
>     Documentation: fix linkgit reference
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-170=
6%2FYehezkelShB%2Fyb%2Ffix-linkgit-reference-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1706/Y=
ehezkelShB/yb/fix-linkgit-reference-v1
> Pull-Request: https://github.com/git/git/pull/1706
>=20
>  Documentation/git-replay.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
> index f6c269c62d5..8f3300c683a 100644
> --- a/Documentation/git-replay.txt
> +++ b/Documentation/git-replay.txt
> @@ -46,7 +46,7 @@ the new commits (in other words, this mimics a cherry-p=
ick operation).
>  	Range of commits to replay. More than one <revision-range> can
>  	be passed, but in `--advance <branch>` mode, they should have
>  	a single tip, so that it's clear where <branch> should point
> -	to. See "Specifying Ranges" in linkgit:git-rev-parse and the
> +	to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
>  	"Commit Limiting" options below.
> =20
>  include::rev-list-options.txt[]
>=20
> base-commit: 8f7582d995682f785e80e344197cc715e6bc7d8e
> --=20
> gitgitgadget
>=20

--VioJ/SdLd/qIgv3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYc1Z4ACgkQVbJhu7ck
PpQbSxAAjcSDFpaWPxMnBWSMvqcxUfUdoA5//YwwEBTImWuTtGfhbigkNCUT5pr/
IIHaxiUrLPVrRkO4HCq+M/VTMuI40TQQrXsnUk0JCfaTRtfNQYMQlgft35bUVQ9f
UJ68YC1BHUJjKfOkiQ481208QlCOHChsH0E6JBjjGnMFDf9YwSTOsSbIJqZ61pmI
8H7peSmOoQqzoHvexJvYRk4ZG+MnTIxJ6MNMwwiPeF+nXxSkAwZDcdDeiKMnb6KI
/DoAoDzeKnpTI/WGOD2MDWMcWHTswPIznd1/AmHPRTjoFHpSCFmNoVe19et/OKda
bjNXdJ//+PwRJicRmONJS1faXWFkW6+GIgucQGTWbO019PPnL3o2O9ETos5z7gjm
cw1k6YPW3BHrZD+0eqwiaHGTNCDdW7ugBFHPyuD8f7sAxwR33fT73gsElB7nRnoe
lYI+tHmsBtQi8oYtRPAjjdO9UJ6PuyFR78XA6UvUkXGvDRxwofocubCpb815+rWC
j3gRyTAn53wfTbaXPTKv0aXp5zkAvsjdQyfKlahg2uyi7ulvgz8l224clzJQyYOy
NsHvPxz59WShVMaCCLCXEmZOH8LbozXIAuRq5R4j2U+Hv/M2fH3GRzfrZP3KE8rt
2AliH4QisTbJidyxmIyCAZEBRhXcdrTTgofHF3wjpOhgxYO2XRs=
=xfxu
-----END PGP SIGNATURE-----

--VioJ/SdLd/qIgv3+--
