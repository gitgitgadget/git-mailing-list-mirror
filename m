Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774516E865
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185241; cv=none; b=S/YzQwAZ1v2fvIGe8LIP0F7bJ7eY+RSXH0EFrs7GAKifQmA0OZu1FuSi9oxatGAkcL/qIXFbfYRTD18wd2b4CyA8VmRdQ/sNhR0kZiAWP9iOE8VcAZkVnNh1gWyWPuf4dpjzub8oKsK53dtDAFF8gi+ANalDDkjBZ3rnDw7U0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185241; c=relaxed/simple;
	bh=ZAs95G9RkhEnzyyqmhMxjs/fgHJg9ye01zRtoHi3Ahg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6uRKC9NnDxzEp1Rx7Awj/9+wpAv+goECgB4pM6zJR9lF1ZiE5PzMNvphwfpREvbFtXgF3ewyXmmeLW28mTfzsnZ+BGRc2+0YTijY3Fw3IIfv56L1A74oPqwLZBT1z/NKZWd+irTkcapPJVPMnJGyFU/Lx6gTe0l+QbeSqRSgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UNWTxn5D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjovkfkE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UNWTxn5D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjovkfkE"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7C160138008C;
	Wed, 12 Jun 2024 05:40:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 Jun 2024 05:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718185238; x=1718271638; bh=Mqol3ZEvtj
	EDY/5mznjAJpVnSDkOxHy6uOs5lI080A4=; b=UNWTxn5DPGcD73JMJySHo6lWlH
	Bi3PraNhzRgHYdIXTNo3+68bf1kBgvF/GVbDigroWza5W4lzPqoaBYNQQWb7O+Jh
	C+P2tdmAi5xDZn6dqGDK3n4gbXEtDpPcZBclDs8HtiyH3O2RVetnKckSe/noyyPP
	0hlESDXSLit+wFXkU7nMvJsfRJGc1Cc3F27RyZP4o4dp2y8yNEGt3gnjgRRpWAfQ
	hXxQHK/mnfC/l5qaTtEYHMvfuFu3ETc8i060elXzbl7YJziC6pErTMQX7n2/zVR6
	j+/Tdm63/XaHT6W33q+/fyYy/mEO55wpqWGGVfzNuKuC+gke8THTTND2El5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718185238; x=1718271638; bh=Mqol3ZEvtjEDY/5mznjAJpVnSDkO
	xHy6uOs5lI080A4=; b=YjovkfkEyHvE3nRzCEuTk0RVaQU2BjJvv1+zQ5Q+Xbs1
	ouBZ2Myt+NL2rkjibNofFsud/qFgmfjGZlL/ofTYrrHP/KhxF440hnFZaX8762ya
	4a6nU4CUl2nc73l4Ss5t2fjBNgrDIPmK4A9mgpVo5+6aqEU9X4PVpkTPYUvLy1kS
	CDXS7z0QZPVFeuSLZX4nEDtRrXDpG1yV8tblUrzB5bF7CiLdCD1ARUdfOR5dnGrD
	eaP539pRqrW5vShs1dBkbYcVGnql/3LaBGxR2onET4ndX5Fas8wzxbaLfWJpv7pJ
	eryG51fE9f2jOk/RNm3EvAyLW5fJWQ3cfDunSTHOvg==
X-ME-Sender: <xms:Fm1pZt7PejTzUzKQBuoIn37d_zNtATGhrU3yoeE-NK9JWfIlAdzfpg>
    <xme:Fm1pZq4RqhvbILS5yKnsfpBpw9knY5YrMCWq5dLEcfrhrQP6ndSMrfxJQ1wvjHUrv
    I_E_qo1Vmvw1o0kGw>
X-ME-Received: <xmr:Fm1pZkczFLsQ09CKEamzMycLVTH0depXOv6kRhKAgXMlKuVqrYk6mqBEzo_ODTKjsjN28WTN749D9BB7OAOdcyz-4twoB48LlTGq7z89S0gTGYhH2iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Fm1pZmILA-qc9YL_WeP3yEWVB3HvHmFXz6vuTI4YAdFe-Gsp-Ztu9g>
    <xmx:Fm1pZhKpIRYdUXgp6kDh3zFP3iipTPR8pmDUimzau06Wc1-ruazJmw>
    <xmx:Fm1pZvzEuaNRFR9H-Cmi5tqDu6sba_esuJn2cR4GBqAtjIGj9J3znQ>
    <xmx:Fm1pZtLYADBokrKmkr0wS0NQ_MRWp0kZ0GraYUWGotpNz86ozBBzOw>
    <xmx:Fm1pZh1OX14wnXR8q80XWpt2c9XCkpcK6UpyLTxYcOS5I2O0cmtUmR47>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 05:40:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 639880ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 09:40:26 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:40:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 07/16] mktree: use read_index_info to read stdin lines
Message-ID: <ZmltEti7TRpaiCD-@tanuki>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <8d1e1eaa70b96779416f2f48a862d31a730c4521.1718130288.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E2CqFM7vn54FLrj8"
Content-Disposition: inline
In-Reply-To: <8d1e1eaa70b96779416f2f48a862d31a730c4521.1718130288.git.gitgitgadget@gmail.com>


--E2CqFM7vn54FLrj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 06:24:39PM +0000, Victoria Dye via GitGitGadget wro=
te:
> diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
> index 383f09dd333..507682ed23e 100644
> --- a/Documentation/git-mktree.txt
> +++ b/Documentation/git-mktree.txt
> @@ -13,15 +13,13 @@ SYNOPSIS
> =20
>  DESCRIPTION
>  -----------
> -Reads standard input in non-recursive `ls-tree` output format, and creat=
es
> -a tree object.  The order of the tree entries is normalized by mktree so
> -pre-sorting the input is not required.  The object name of the tree obje=
ct
> -built is written to the standard output.
> +Reads entry information from stdin and creates a tree object from those =
entries.
> +The object name of the tree object built is written to the standard outp=
ut.

It makes perfect sense to not single out git-ls-tree(1) anymore. But I
think we should help the reader a bit by continuing to point out which
commands can be used as input here. That can be either here in the
description, further down in the new "INPUT FORMAT" section, or in both
places.

Patrick

--E2CqFM7vn54FLrj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpbREACgkQVbJhu7ck
PpT7axAAixRT7u8TC9uH86DxmlqH/k6/soKliNYOCwh0pH38/QoJrxMYQxYGZ8sN
XLvy16B2Yfm71fXknqiYlFsx7vFgirVyKtbYtLDxd02tjFYk7OLSB9TZyalJb2Ti
L5Xpeajnp6nLySi09c0kGq+AaVaLLl96r+dPF1K/ye9uiQhxSP4BJAr87CTGzhVc
PSFgWzD6OCpBgx0/7ZkPG0m0aVKSbGJ3OG5gKL+jplvf6CRx06AMOWjH1xa8M3OC
xiEGrojDPsGwpDlcrY1iNWhWEa+Up2X1gNSHdOVcwDOSotcF70r/TLU22ygQvhJ+
mLvqdzPUykts+QnMCoUFDl2hDNpGQQFXa+MJm/eshL726cxD7TjqNACJCpBNub/w
7PgNEXQ1WbG3KgoKvp/iYlQfGwY+j5G15ZXXiWgoPPmSl1fKjCpx4tmf+U0FDP6j
tNjLw+zxo6CN/lb9yHvWz9MYGUh99dDgOnEiwKnoRKXHXiq3HjW0lpqFnwB5T9if
K6T0R0OXbt0+mY++w1D6Z7sPfrBn1cjUirhm8olULAAzRfJ9PJeT4jS6w9NxcKgk
ioyu/xuRNrmmNS5LJHj3hIqdNc7pxV77tqv23mjWqYbjMZD408ir7GXRqnEOov76
JG5Kra2NCxBYLinWxWaxLgcMIXXya2itgwitR63M9FLJqH7frCM=
=FIr7
-----END PGP SIGNATURE-----

--E2CqFM7vn54FLrj8--
