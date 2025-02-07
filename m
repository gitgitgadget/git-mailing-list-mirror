Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59F1F4E56
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938562; cv=none; b=Gk9WdD2JHZhmrxpU8gv2A5ESLmFBiDqzHwVXE5U/a4nOOL23giF8Ii82KJhFcP3dILvsdIa7qCwqF+kpbUF+vDm98rKSRj+MjCOeov8DRnKugj11C2UXqbwWj3ZXXq2J9PUZz9Uu6hmB5crOZ+o6nn7BKNgT4YG9cnhpxXvFJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938562; c=relaxed/simple;
	bh=n6KuDlRYYKu8g/uqr1ii92FFGGgpwOFF4Xhs4HwmTMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFY6Pa56fmTvEbsbkI66y+7rZpr4pNsVIrDB6mDD6S2wnM89y+CFLj5p9K2Ve3hEvCUKFTWh56LILS3o6fDo8nXY/ss7g3c5qw1Rm44ObjnM3AS+uEYx6G2fKaExvJfGv23wowjRfC+yNVkI1pAEHHJkr01Hj+qxMsnCOb/jJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ewnSnQji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qbz5MyA3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ewnSnQji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qbz5MyA3"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E6F011401B3;
	Fri,  7 Feb 2025 09:29:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 07 Feb 2025 09:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738938558; x=1739024958; bh=ldawXFBDx2
	uQ08zb0KqR8t16Yt3N76F9EGM/IY6mlXw=; b=ewnSnQji1Hdy66Rni6mcWe8d0Z
	+jlChtdFGeV6MMIb+QDwuHNeCz9uy9By15m0qjoKyEb54vcCXqfh9nKYJOH1soSn
	suW/b8QWQOMtXa+t81e4A/7BWGaiNnkXq/UO62Y76ANMaMCKFPU3lWlnpt+6SSXh
	g8e6pvhLkMGn9sZrG3vGmijrR2J7hiNk+NtMtzgTWjJgu2nhV5E3+POmZXtZo7CF
	W+jV+YDS/zSStaX/5yxSkXuPHu5kX8cPLy7I7JP81wObTkBQuVbMNJe3wSgTil/3
	G9BWd97zwuHZRb3LzENOpfEHijSYV++NF8o3iv6Rjp+fb1beKy0xW5yjFzDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738938558; x=1739024958; bh=ldawXFBDx2uQ08zb0KqR8t16Yt3N76F9EGM
	/IY6mlXw=; b=qbz5MyA3FjUy093lgyaQtlun5RNHTr/+rDmTCEMU7mEH7jPJ9XJ
	nDExNF3NpELyo8o9gqbRwYI5/kkTRHBxK2bDJrlwKtX5XMA3MeAxvzesRCc7Ke1M
	rIlAFkbnSWUJ8RwweIH2Mrhmqgi7Q/3kvk4JZr/g/zBLS9tF3fRTlR68lzF1Z/6f
	IMC4zyMewF2rSXw5fk2UIWPwjYYm7hz3cPNFSzVSSx+1zo4Cd8kx2jGGUulFvTpo
	lxDmELfqasTTRoM/1gJdWoa39JXRa/mp3HPfAG31OfmaG4QqGMm4hAfROJNWo5Wj
	//YwwsYcbH+Yl/aXFq80JKhr8m1j0YUo3Bg==
X-ME-Sender: <xms:vRimZ7bUz4FfKg_W7JxkQKXpRyC5SqLNSEYGPMTTkzlMD95wCxIgmg>
    <xme:vRimZ6YxVzK7579NrVQAdyH846gGul7YqBeDtu2FQOhvwXr3qt0ulnQG8FvLc_EG0
    vQIly4xNT0DtDO1TQ>
X-ME-Received: <xmr:vRimZ9-fI3Ytdosssoa6oTNJtCONyAJw9cEMdmOhgXwN1q3XiLQDkoE3g42GFA0sviPJEDVoXamjbVZYjRF-i4zy9zv2JORW5UgdrWdFhMs7yCcq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthho
    ohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:vRimZxrYRFdWkcvrzumr_gdrLYWp9tjInRG6136S90DKSH8jXpFqSw>
    <xmx:vRimZ2ojswL8rWL5o7WXMUU2eFIHdJ9G0qd3CchqdUWS1EFlJlnHRA>
    <xmx:vRimZ3TstSqNti9gT1onEP9I4ql6h4OkAcw8KjPiBwfwIAb2DUj4Gg>
    <xmx:vRimZ-p2c6d10Zsw_cynkg7vn4ywjB9Ahb-XAcc5CNEufaSVLfzYug>
    <xmx:vhimZ5Xsu5263v49GTUVPDn0Yqg4QrAQEQg4zdUz-eDgfhMbwEzrmgye>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 09:29:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c80714f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 14:29:14 +0000 (UTC)
Date: Fri, 7 Feb 2025 15:29:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 09/13] meson: improve handling of `sane_tool_path`
 option
Message-ID: <Z6YYufqOOAGWru9r@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
 <20250130-b4-pks-meson-improvements-v2-9-2f05581ffb44@pks.im>
 <87zfix3lwn.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfix3lwn.fsf@iotcl.com>

On Fri, Feb 07, 2025 at 02:49:12PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `sane_tool_path` option can be used to override the PATH variable
> > from which the build process, tests and ultimately Git will end up
> > picking programs from. It is currently lacking though because we only
> > use it to populate the PATH environment variable for executed scripts
> > and for the `BROKEN_PATH_FIX` mechanism, but we don't use it to find
> > programs used in the build process itself.
> >
> > Fix this issue by treating it similar to the Windows-specific paths,
> > which will make us use it both to find programs and to populate the PATH
> > environment variable.
> >
> > To help with this fix, change the type of the option to be an array of
> > paths, which makes the handling a bit easier for us. It's also the
> > correct thing to do as the input indeed is a list of paths.
> 
> Should we consider this a breaking change, or aren't we because using
> Meson is still not the "official" installation method? I've noticed it
> breaks my "build" directory which was set up before this change and now
> am trying to use these changes on:

Meson is still marked as experimental right now, so I don't think this
needs to be explicitly called out. We should start to be more mindful of
any backwards-incompatible changes once Meson support has matured a bit,
say for example starting with Git v2.49 or v2.50. But until then it's
kind of expected that we'll still have to iterate a bit.

Patrick
