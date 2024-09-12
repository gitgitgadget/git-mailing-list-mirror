Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A4D191F71
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134355; cv=none; b=m5uFFzkGcpL3UCV0vyWdTjydAr+fWuGYqv3XPY2Nn9BM54s4R2MwKBkTt/+T9lfDNOnE5nD81J/ZBN8EA8+w1bYW89ykKYpTgPm8a0X6glO/80lTlAn3ULPPno4sYHEl/koDZb1Mt+W+YBGzRHCyQER2csn64QRonrB7ue0Jjc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134355; c=relaxed/simple;
	bh=AhcHoIZkC9nxKb+7VCwLup/2t4CLyFN2/BYx2WButv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdaIkM6A/NCkiGpPxwMo/T3w8eXAwNZXF6QGRueYUc6gaSU8lFyF+KDe0Pw3XtM2SsHytdPl8zTtKQU3H0b6X7FZ7N8v91DaME/3fXLvbTq43b1rmyWEq5TiJInVYiT6EY8Ht83TNWXUIGzELKhGxXTppXrxlcj0gZP7+hOXur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RBed8r53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a88BrFU+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RBed8r53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a88BrFU+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA72211405C3;
	Thu, 12 Sep 2024 05:45:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Sep 2024 05:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726134351; x=1726220751; bh=lkvZussKm1
	w9WkkquprhU65D3FBE4mIuRv9QrhrEHtg=; b=RBed8r53TitmXRrJxne7NKeJXg
	ILuAd8VWYvLDwN8Ca2XNQ8e9M48H4ybPFMGpaQohB7q4fMvYvZqN3m+L3vE7VX08
	VrQkN07bwSE2M4E9j7V03vrZ1A7vIBLoqn2bHJc9zH5BJw8ieXWv8ThpIDrM9UFo
	YsKH81qbY3AFq/uGYnbLZFgXbHOZe5ngxHM7ZszarEPhwbTJLjQdEmtY9GioYhNI
	PcEL9BDuNGDug6HSueqcbXKFbrzfkUJc5j3RIxzIFB7lL9SJ3XpI5dLnlDQ6NB1b
	pF52gKG5KxNV3+VNypf9W41ci9RrJ5b3ZxZ6ccQNSyJQpeUiTPXQ8feF/E8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726134351; x=1726220751; bh=lkvZussKm1w9WkkquprhU65D3FBE
	4mIuRv9QrhrEHtg=; b=a88BrFU+anAJSD3xiukBAOC+pxdBr1EsC6MUv9AahDRy
	6Bw6dQUVt7GLhycnpC/NGxl6CvRO2rfuWqmhd+WHnVhm1wmFf1thUpUdPbrXLgYH
	3hFnVX3rMlglX8Hr0y87fWotHB4YPM43SbrRgkUwbNEe0jTyyHB36K3so5zxlxEZ
	ZfhKfWnFsVxs6HDhKysKK9dcP5pB+/x4+15kVXUAgrVQD/ljeB6WzW6p9ErFgJ77
	xy3WC22oBIQZlG3yYuppaCiZ31CzEtduTPakBr9DqGEE+O5/8Dh94aNPyWXH4TKD
	/imXSjCUi8W8AZ+Y6mN48wFgjd4bF79HJ7nT+LZxlQ==
X-ME-Sender: <xms:T7jiZtJuAjqbDMLbNJ7japqdnWfeCkhZDQoJmu8rcaVngOGyWyraEw>
    <xme:T7jiZpL3J3CUWwzQQkLjYVdWr9zm379H4Fc00q4HbcULuIKcRYO-ftBpN-5T__eMS
    TUpHa1inTBxA14dKQ>
X-ME-Received: <xmr:T7jiZlvtaXcqv2tYsOm8qG8-i5sfWHwDM6WUsbdiZFV3hyXATj-CROvhupnXZ0bugSiFe1JYNegMEjfbhZUWtVHAEZvZbznnDLOIDXHjtj6J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekie
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:T7jiZuY9IQIoOM__T8qbAy1dooCTyBxDtdrybQ33IgSQI01pTJdHFw>
    <xmx:T7jiZkbDD4ZWFkygCFYdG_yjsFiCxyUBGmhUTs5UaIM_aM-UjgwvMQ>
    <xmx:T7jiZiCllXfCRi_1Ps2IXbgqxp9OiZZxyr7-tztwd6mJdrSQHLXbtA>
    <xmx:T7jiZiagL8lAqtKJD5hnzqptshJVptJKdNKeqLjYMhdiroOEdfvgIA>
    <xmx:T7jiZrXNCphfFoJ9gfsw624TmYOBMUGZa_2GplQkWTtBS2op9ZT-hevn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 05:45:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b70d32e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 09:45:39 +0000 (UTC)
Date: Thu, 12 Sep 2024 11:45:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] builtin: add a repository parameter for builtin
 functions
Message-ID: <ZuK4RXMfherFBIxP@pks.im>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
 <9aaf966254493678d3e25b93cb11017c814d3087.1726001961.git.gitgitgadget@gmail.com>
 <xmqqed5rdw61.fsf@gitster.g>
 <xmqqfrq56gqm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrq56gqm.fsf@gitster.g>

On Wed, Sep 11, 2024 at 02:08:17PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >>  git.c                              |  12 +-
> >>  help.c                             |   3 +-
> >>  stkOs5Qh                           | Bin 0 -> 10485768 bytes
> >
> > WTH is this file?
> 
> It turns out to be an "ar" archive full of *.o files.  Perhaps
> creation of libgit.a was interrupted, then later somebody said
> "git add .", and the file somehow ended up as a part of Git.
> 
> I've applied the series after removing the cruft.

I've noticed that something leaves behind this garbage from time to
time. It's a shame that its name is just random gibberish, because that
makes it impossible to set up a gitignore rule for it.

> The overall thrust to pass the repository found by the setup step to
> builtins as a parameter is a very good one, as most of the Git
> commands are designed to work in a repository.

Yup, that's the direction we want to move into. We're basically trying
to approach getting rid of `the_repository` both bottom-up and top-down
now. My changes are bottom up, libifying the low-level subsystems as we
go. And this here is the first change going top-down, getting rid of the
global dependency in our builtins. Eventually the plan is to meet in the
middle.

Patrick
