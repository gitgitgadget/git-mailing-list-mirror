Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA7170A15
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504725; cv=none; b=pD4xzFaRgrGv5HWswFfuBhRw6Perdv43+I1Od0Kh9Ajk/bzE4lrKneCeDv8fSQ4t0Q1ho6T9h9fSemTNWE8762DzYLHoQCPc/g+sqAjGx8nsra8c4lfb4nSYblLqS6eimtKYKK+zWn6hHkujzgUVc3JxRT47lq/M6Qy4OnEm0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504725; c=relaxed/simple;
	bh=jM8SQ4CF8BhIA/wJ8riKFP7Vbox3rhrQr2sClsfSLxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWTCxTr0dZ8ADzfPr9ZWgItX8r2ac9uZrPpKHdtE8a1r7U2nz5cCZ/Nf2mlp9+C5fGfLgIklIFxCn6Wru7Iwv+ePBnftvqovx9c2bIN+pG1VDHcRXHglPY3zRw1d5owT7/55r6gc0aVKgrmDkWqh1Rgkm8KmgYgR6mNf21Ch6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ocyn6TgB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fradMXHz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ocyn6TgB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fradMXHz"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0AC2B1386982;
	Thu,  1 Aug 2024 05:32:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 05:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722504723; x=1722591123; bh=jM8SQ4CF8B
	hIA/wJ8riKFP7Vbox3rhrQr2sClsfSLxQ=; b=Ocyn6TgBy1jBAlvQRXhG3/KSNP
	9hOxldOYnjyo/Aa3zcpbri4sFKz+p9sM1WPYzZDn5acZb7rey6iqTTBYJcvt7WU1
	Ocm4Jd4eVcn/4uXds8+cczfTVFJbn+nso5bn/eemOh0xYg2O38xIrNA02/f4FMyX
	jjigG4c7uPjQti7L+u1xePhpqhVBJeJ3Zx/efzxT3d0sbMIj1z7Ke+WU420AMrvl
	59YLEr9hl34jfyYHkQOeLydyoDk5fRca59Op5lUitsB06GheGJYMy9nS5Uim0q7w
	YwyD2eWJuaGI511kfMq6X6Gttep7sWNWFyVutrowyHxWWZ5L6IrP0mZtUUMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722504723; x=1722591123; bh=jM8SQ4CF8BhIA/wJ8riKFP7Vbox3
	rhrQr2sClsfSLxQ=; b=fradMXHzJILh4CzgEhtqbTrC5VR7LxHaXJZf85X+Jc/q
	9rfO/zm0qPeBFpStZcI6jT+o9aLfRBEJNG1UNEo7I78GjCIAAWm29auWQXZ5N9v0
	mnZ+bUyqfW8lvE93d+xri3eu0KCgMlBK+v84Q6wU5YUC5uhXjzR+jGpg3fLV0dNX
	4NBxLAS4fB4WEGG7KXPgo1CMOWUljERSu3BWDFMYjPL2TaOLiZs+UFwpo24a6xG+
	ExVdgGgqmuuLBecAqkKZ1a4S2/yITH10t6t0x1bp0LeE5+EfNbq39Crh3G9bGyTl
	BoKgdDiMOzf4VhrDeVt1faW5wUz/gvWi4Ar6ADkelw==
X-ME-Sender: <xms:ElarZrHLmZBSxZFrSxGaWmD3ni-ykPV3VieNFpIOJCPWva97bgjqUw>
    <xme:ElarZoXcnktlb1Z44p9eDuV1oj20bzy8gVczvojcHCyG-QJ-7Qw7TZQ7qcghW6lcH
    uKK3RWPEtOOax_85w>
X-ME-Received: <xmr:ElarZtK6v4SfTR0bKb1amHbW2uxNBC3l-TGq-c1tvc07HIA4ojDHobg8pwBAJWb0Q5hg6d1s13_kCwGsZ6-7QIJN7JJuCnskQ4n7D9wksLx7H2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ElarZpGj9mGuqAlssQjKD3u-2tA_8Oo2OA2fmqXInK7kqipnijDGdA>
    <xmx:ElarZhWv5xAQik5W7_IXfRVoK1VJYjs_YW_1Bx20mtk-n8pCAvZesg>
    <xmx:ElarZkMGNXiew0W4r6uRKxSZzxAyYc-oK9BTI2g9YAva1IMyCfuN8Q>
    <xmx:ElarZg1ulSQhCFZuq86Tnm8uUZuwNDudIu5Fm1qJ6k_qwZHPn50_7w>
    <xmx:E1arZgGSvC8TB5e1Ua4zrhfLtgT6DOpR-Byqd2GiXoJ3nKWwAKXQ8eUu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 05:32:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 907a328a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 09:30:29 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:31:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Josh Steadmon' <steadmon@google.com>, git@vger.kernel.org,
	=?utf-8?B?J1JlbsOp?= Scharfe' <l.s.r@web.de>,
	'Junio C Hamano' <gitster@pobox.com>,
	'Kyle Lippincott' <spectral@google.com>,
	'Phillip Wood' <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/3] t: import the clar unit testing framework
Message-ID: <ZqtWDtqkXzjz2A8u@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im>
 <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
 <00a801dae384$de2780d0$9a768270$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1AD+/s9eBuNzzq/B"
Content-Disposition: inline
In-Reply-To: <00a801dae384$de2780d0$9a768270$@nexbridge.com>


--1AD+/s9eBuNzzq/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 04:04:29PM -0400, rsbecker@nexbridge.com wrote:
> On Wednesday, July 31, 2024 2:27 PM, Josh Steadmon wrote:
> >On 2024.07.31 11:04, Patrick Steinhardt wrote:
> >> Import the clar unit testing framework at commit faa8419 (Merge pull
> >> request #93 from clar-test/ethomson/fixtures, 2023-12-14). The
> >> framework will be wired up in subsequent commits.
> >
> >Rather than forking our own copy of clar, could we just add it as a
> submodule
> >instead?
>=20
> What are the requirements to build/use this?

In its current form, Python is a dependency due to "generate.py". I
mentioned elsewhere though that I'd be happy to port it to our language
of choice.

Other than that it should only require a C89 compiler.

Patrick

--1AD+/s9eBuNzzq/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarVg0ACgkQVbJhu7ck
PpTByA//TklqNs3gBQWMR1h1Yh6JL7rwsf+32eAY0bhg7U2DRT2YYtZgez57uz7S
ZPwaus5OB3DFnVAy/lzybKUzCAU58Q31aykz482oSMr6/Lo1jL5GXk+3InuHlwwf
AO9fehWtvdWMP4+8rSbpT/1l/M4EtYmzRDhlhSe9DoKNnav7TCCtEGtfpzodbMVG
xZqrShHyc1cA/QA4pSSBnh4ap+bXe2FxGOBp9j3kroNXV7BZfXJhNS9iLnU1Iqpn
xV67K+HeeUoUPH9d8GoBF/tzelsdn8MIn+jLFcDlF7jAr75zulKG8jc6essy63Ta
q26nQgTNyX6jbrGPsQ/As5xP70MbzVXcAbWmRIsnALZqkRVVutZ3YA2GiZKHAiOn
JeAO45VPvP05AfQeFu6KNV8b3yWGuOVqGf3HnJ6W/fz1kSH2dOGADsQlGRNU8mVJ
VDR9U/Iz4Pj9oFsO8ytPITvrncVNj10AdBGXK5rtRkW4N4uyOmDzS5m7glZX/8Fe
8Er3CYix9cm05sJX6suxYSqhONHUMDQQma0s7J8oZBE1D4nlLRnQCCM0kq3cPKHb
hvkvpbkRHsmp9EPnaqYWdXX/0qrddl3tMSmkr0RXDxwlR+xsLzxdfCjqAfatP01B
blF3GoyQKPxLwCeXHnRtd9mookcHi5ofKnD1qcg/VMXMToQsJTg=
=lV7d
-----END PGP SIGNATURE-----

--1AD+/s9eBuNzzq/B--
