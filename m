Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCE1514D2
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666756; cv=none; b=E9VH5DLxYIvzORElG0Z2G/ZppmpY2BQG0mO4+BJAdZYmLZkouUCiXsDxXCHpcDAdyazuxLPqAi0CkNzBaV8Og24JJ1R2sIaqepvq7p/zbj2yTssqaycYZvBlvpmzrGsiEUcAd7UJwRFjQhlLqbnxQdfwh9W+IedMf4UyorLeQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666756; c=relaxed/simple;
	bh=rHn5ikXEJ9999PBndWcJYGLC22G+zcqVJ5UWkyFNU4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwB5xJGRLI0tyDT76Ct/cs6RDdWQqXq9nf/ERcYJM4OOYnMS3M/dX38XLN+6X1BQulu7096zLK4fBRU9z7AO/kcydvj6osQqUA8LlpaZRPXWrUwNCi6wV/I0R0OYu9YANcI/kx/5AYaDTXYWPtfkurZcqq2GyUN2GDtBuku1HtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DAIkfx9n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STEmwGRs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DAIkfx9n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STEmwGRs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2AEB1138017F;
	Thu,  6 Jun 2024 05:39:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 05:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717666754; x=1717753154; bh=xeqOqbq+uI
	yrcin/+ESjwZXPlGvPoLaRSDsibxqWnX4=; b=DAIkfx9nPfyM5FpWYL+qLVW1SF
	0ZFKa0KhjClnE7yQEkGH6MxbCVxyoPXvaCanyoQVKnveZXc/gTwB8WHPRV4lRFKq
	dzwe7Aqg3tesmOqhQOPOe/D3bBdTeWIyg9i9kSch2GAJCSpWhoOaftYMekbOVQDM
	sU2JZ7jZ1apv3YPFx04NNf5saYooEsgXvxVjmjlE35XSTCdI5FDGjf7RIXcinmHI
	svmUVOp8mRnGhyoku5o35ANQ4PGTq7aDG3jexkjHcwn19oQhBZ1mVem/7ViS6P0k
	UcHAIgc0VLvgbobKKUQqeioiAz+U310QK9YmqefOe/4ew4rWlh3W8lnT9+Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717666754; x=1717753154; bh=xeqOqbq+uIyrcin/+ESjwZXPlGvP
	oLaRSDsibxqWnX4=; b=STEmwGRsYbeffyyWxUiPX1mKEpQyJzWZAUZZAwkNYLdG
	R+WePUqbrwTFMEBLZzB/v+m3ouLtPxb2sEqoXoPLypNa6XMyN4crelUXFY9u+/4Z
	0/zbAzoDw7KNPUM0DVauxkf9KBO/Y4nESHRWmAOgKEYDvvMluxoktwiavlHU52/9
	JY/AW2jZ1P0AZh4zAG1vL6IOlgPRVTC2R2oGPYGlpLmauKISeJcRkfXCuhq/Btak
	3twgBQpKpAaKT3pzzYUHkuAt6uH/vhWXDk6ilZCVEXFiC5x75HVjNSvb5mYZPfac
	gXIAWsgs2RY3IMkO3FEgZYGW1umf7Mdr0kkCe0bcRw==
X-ME-Sender: <xms:wYNhZtCjM87lfKXcACbaVt8fIZVxMa4ODpC-Thws1uQvocX3nb0c5w>
    <xme:wYNhZri739xdWqd76ySvQHuu47uN0t2SWbysmkTOMI2DPvjgx-W3W0omDwoAXEmTu
    vmmrKNKX92sVZXlIA>
X-ME-Received: <xmr:wYNhZomV6qKdUk4k0amxyHa62YFlpSFCNlz3nG1IUVNH6eGJnav7CNoSwzUO4SQ064bqCAJqffVKudKz05XC-QWZ3WPXgEqTmhXjbyfIxpifC4qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:wYNhZnwtag0FNAr7wuRgPyWV_opcAXF-cKwTMSGAN7zDgc4XjF_VXQ>
    <xmx:wYNhZiSKps38o_y1bOeLQqodD1jQattrOiFhvgKui1HhHpAOqGl4qw>
    <xmx:wYNhZqbFG0LOAdlZBnesptxpMSMUQDUrv3oZaJxmUD5TLSQp5vkApQ>
    <xmx:wYNhZjTdC7VTyJwmxBUHY_FgoKeWQ3zQ7Pl7TbPvA5gOZpZgJf4ieA>
    <xmx:woNhZoNeYE6htgVHoAAnWHEhECuFZWx0QV9R-soYzaDsN2MuoiYAYeK2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 05:39:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2e0f7ff4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 09:38:42 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:39:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 0/3] Branches are branches and not heads
Message-ID: <ZmGDvtZKHdkVD6qL@tanuki>
References: <20240603200539.1473345-1-gitster@pobox.com>
 <20240604220145.3260714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M+C8lSnb2cOKwRGb"
Content-Disposition: inline
In-Reply-To: <20240604220145.3260714-1-gitster@pobox.com>


--M+C8lSnb2cOKwRGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 03:01:42PM -0700, Junio C Hamano wrote:
> tl;dr for those who did read v1: v2 does not warn when deprecated
> variants are used.
> ----------------------
>=20
> Back when Git started, we used the word "head" to mean the tip of
> possibly multiple histories, and that is where the name of the
> hierarchy .git/refs/heads/ came from.  But these days we call these
> entities "branches" in human terms, and "head" is still used to
> refer to the tip of the history each of these branches represent.
>=20
> When asking "git ls-remote" or "git show-ref" to limit their output
> to branches (as opposed to showing any ref), we use "--heads" for
> historical reasons, but give the option a more human friendly name
> "--branches", and demote "--heads" to the status of a deprecated
> synonym. =20
>=20
> We do not plan to remove "--heads" or "-h" yet, but we may want to
> do so at the Git 3.0 boundary, in which case we will need to start
> advertising upcoming removal with an extra warning when they are
> used.  But let's not start annoying users for now.

This version looks good to me, thanks!

Patrick

--M+C8lSnb2cOKwRGb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhg74ACgkQVbJhu7ck
PpQvpw/9Edg9dpahRdEsU8MwvliXgynLMVZXcIW/BZFT/Txe2KKbqbTln6AbgLLX
sKsX5+XaX+xW1Lu6NtebPZj0cSH1EmNtWLOLucZCP2pGtTl0VkVXeyj1IT5VoQxn
DPORGXEVCfM7e7nkui7YfP1DberHralfiXZwrWnVoenOr9pYf2YsBBdLzC8EVG8L
4Mfvp4Xrko5F6h+hv3hds7QJ4XSUeClPMBVAzakOBBNO7q+YAuirLPSwDTJ2xl+a
zZ4BCH3UPfcdhWX8R+yW7aWdhlYtSuOsfiyaPTgMuybf3XAsVXNm0XVLBGC0xjmC
6+S4CRtoPUffAM7vgqE4VacSZUp4Lom2W8ZqvMGmvElSM/5VGSduABdH8wS0PzzH
jRGC6J7g7Q+nHwTp/UhNTUOYUt/sjHdAV/RqV4hVSbc97FoRtkUM2FUhb3c/+BuZ
sVEnzhZcL8WZNg55Nkhq4m1XpJDSBnPEdq0EHmKfXs3qPX6DrYJZCIU2D9A9sYVI
q3icmpsVjAZFecHeq6LAuBzLL8R7QC0M4O7mIJxvNSUdAodegyYOO2kF8Z+0rFlC
WKqHFVvHvJvUl5x+eapLfe5fk3eBm/XnD0KXzMmeRf3iIowj5KbWmxLwS57nuTDF
cFtwCgBu0HNVFrD+ky3A/GU1VUoiaUkHpqlOiuY3gzvofGQazs4=
=FtPT
-----END PGP SIGNATURE-----

--M+C8lSnb2cOKwRGb--
