Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC88F5B
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647915; cv=none; b=i+CuCLUoc6vYMHnmKd5GaDuwZk363y89Lej3d5SaQ47AHKq/+/zvbR40uoAA76LEvHwnQ6tfeFJH2StezYLTH1SnAgLlADpgsTLe3EOCH3aaOJY7nFAefqjvV8XDzQKV8piBrgTlHqzDGeHc0vxbK5Kff1lHWuuatabZQwajK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647915; c=relaxed/simple;
	bh=k8lsEUcjD3moMF1zT3ND5yAqxWUvyzQJyf+UYZIatQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNKGzLfAtNFZLTpdzhkJ/M9lnlrSJ0gqWqLBbrLmNU78hzjZ+TgD+7TRZ9kQTRVShbfA4u10KVqNjujG5EYuJ593B8peYwS7BVMOcMuiJQpwtD89UFeuQ/m7mTttmtp8FvEeYYYTWbr2DzJgXoqqYOA0myYRNY0jweIRQu31wno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mCSfFHEn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rAft/OT9; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mCSfFHEn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAft/OT9"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2ABF33200A3E;
	Fri, 19 Jan 2024 02:05:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Jan 2024 02:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705647912; x=1705734312; bh=k8lsEUcjD3
	moMF1zT3ND5yAqxWUvyzQJyf+UYZIatQs=; b=mCSfFHEnynChDqOoRswck344hc
	JDLosTMCUl0HF5q5jKLP/3SZ45U/b1RMFQDFzC9e718U7xQkCHsgRE810OD8q0Ct
	kqEtao8SnCo+ZpxAateAzdWtJmNNdjSoTxjoloWtn3Vx7ahJotmqBg+0xSjzImNm
	D695CpRaP+RqmzA3gWMt4F9xhHLReHA+jqY6w1QscuRDe11p4PyXRMVa9b4XJ6xj
	HZjSxGafI3pjR/0Ex9JoLVglrFgI78p1mdPgDmWVt6VP9oK4qRmHGVO7kI5QaJ56
	DdG/b3IdltBkoIYuKUjiCqh1B5gNmO5ut/PM7lSAiLGm7WBGvT7LtxvUwE+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705647912; x=1705734312; bh=k8lsEUcjD3moMF1zT3ND5yAqxWUv
	yzQJyf+UYZIatQs=; b=rAft/OT9+daVI0rv64VTEHamRjFCdXT14KvqisTi2n7f
	XpyC8GCCTMQyn6JJaDlG7oZ/OyD9HMyuaFT0UiKkiT3pFSVGxkl0QLdEhIEzkySE
	xKICtZRwcy8LRkAJCX8do0vyCmC0JEBQCsFgFtQf9hG6Xt4e5+RoALRxoy/c3o4c
	piw9TFMltTAFWdQxCPwwTHXkFsgjaHqOnCxeKvkGJUluR+hBiG4ZOt6RODDejdkZ
	o+BaV3J8vEy2AYbl9xj7UgD8luEi2enb6KJP7cVVqsBp+gOzLwMuVtFfJd3twCvZ
	+/bChMAGQW44pmYi56FrqSvrlPhl/uxknCFEziF3Jw==
X-ME-Sender: <xms:KB-qZabLEyzaiItNSvvmc4N0rMi9lL6YNFZMLqo6ZZ5OSb5BewXiLw>
    <xme:KB-qZdb1YoaB0faQtGFwn-438a-uyhZJqC-u3ATZ7ns7TRsY3nCdCR8W_BndSJOF0
    FjgAMqaXIT1yPFU7g>
X-ME-Received: <xmr:KB-qZU9IqU3_id9IowjVUCE5PU7E5NKNc7X32yHP9k-uI_RpqgKrP-Ht3etC5tCsOyRMvQziB_YKYPexBuGF-nC4l4-Lz3cLXED1rxWH6wFHbZ7XAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:KB-qZcovwpeppD4IrNF0y3jaqkCa0fvBdCUAO7pPyrbZNgZdR-dDaw>
    <xmx:KB-qZVqZGYvJW-myxiuUqqq543sHptbSWIa4_PRpMmVmCcRBINm2Jg>
    <xmx:KB-qZaTDiyUZO-snhx9hlJF86JmWttev95FMLaSmbgu89XW0RGxasg>
    <xmx:KB-qZWCqP6X20zVbevjPTeuBLq3-l3qCtwse-Y1jY8kB2gS1qahrTA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 02:05:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ea46b17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 07:02:15 +0000 (UTC)
Date: Fri, 19 Jan 2024 08:05:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] completion: improvements for git-bisect
Message-ID: <ZaofJhHsFjRxx7a3@tanuki>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z81gS54vYVJitkGP"
Content-Disposition: inline
In-Reply-To: <20240118204323.1113859-1-britton.kerin@gmail.com>


--z81gS54vYVJitkGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:43:18AM -0900, Britton Leo Kerin wrote:
> CC to add: CC: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps=
@pks.im>
>=20
> Relative to v2 this only changes a wrong misleading commit message.
>=20
> Bring completion for bisect up to date with current features.

Thanks for your patches! I've got a few comments to bring them more in
line with how we're doing things in the Git project, but I agree with
the overall direction that they are going into.

It might be a good idea to also add a few tests in t9902-completion.sh
to ensure that the newly introduced completions work as expected.

Thanks!

Patrick

--z81gS54vYVJitkGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqHyUACgkQVbJhu7ck
PpQgAQ//X75OqlrnsHDH+S5xidZoYLjASP6c7FPZowdPfFMpy6rwCgQ8z9ZEOHDt
tgdh58Fvy9t9qunvFaEJSD9rMsb1oviYIRiQqtOS0DVBf4sXIM58siWZAqYkaoL2
uXGMIK58e3CqrL23dmFbmOkhB5VtUU9x1gCeEStbYMhOkYKoeeLDrxbzUt4cctlE
OIwnjEpyIAeWNP8rGPx3N2PO2kn3aQmsQI8VSe6dbZl7+kkr1pc8XEtVND9mfN1z
r4rVjZHle8qnRcgUjOZEPUjhCtWVQK7ocPDWDAfQK8/o7L7Mh/8BllHOKwntgw8A
9FMlVlWyfm11/uLTaTXLb4cxV86zPbQYyw9VvNbuBwKZEcrRmXuJEgo5kG7rRamr
4K642GC2eRAxZHk51GOe/WxRb6izj0DSV5yxN3t6XvY0Nzpva13sHUL6H1yB90sY
9RAYN11FYgDfNEH3ShjMdCCuHKep4CAQvyS5mZzoOojGxy9gIsXZobjOMYjkYp5+
uoeE/hlV5wlVui0ZdsIS5GIVBvG9HTLz/dGXaYHYjj7/BcCs4JA1ade7dXUCW+8J
KQuvVfyaY+WTPSZoB/cTzr4DxQyrI+b/d+Kwr4OfPCJs5+ndY+dnLYGMyZifMB3z
GvRF1SO07hKj27D3m+JAMgbsXYSI84eA+/OCI03afzOasrVo2ME=
=BWwA
-----END PGP SIGNATURE-----

--z81gS54vYVJitkGP--
