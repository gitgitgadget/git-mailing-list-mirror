Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFDB35DD1C
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631087; cv=none; b=MKPWohVzf2cHwlySJD/GgoyB2FPE/v6E8+kfcOTivkRmicykiol533DLD0uxdOmMxz3dsrgLKjz2BTIES0HhOGcYsYGi0NTh2sCNOEYzIItTNvmAbB6c7MyAxWDcKn40zQdBfyvIPNQ6jmtXMMHpSpvyXUxQD0XAGPkWoK56/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631087; c=relaxed/simple;
	bh=QxQyzb+84OIP7J6qlDhxYfb2C6JrVi62efIeqCrXxgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh/n/IFisIkT9nUNN1w7t0KfR3UB0y0HYHoTWSg9OK8D3kMfzNJmlfLH4m7QbexvxxybuHcxBL7amVEDcscxYjLJBXX2wQ2WthfgfTUdlN7jk/Dml9u4mDIwm54VOJrpLF7RKWh9/LnDBZVbsggS+hFWi5lDZNlAkabzsjXZCdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cvDRcbjc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oeV2yFpm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cvDRcbjc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oeV2yFpm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12ABE1400083;
	Wed,  8 Apr 2026 02:51:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Apr 2026 02:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775631084; x=1775717484; bh=0407JnpCux
	GQGH99xSFUo1N5bjQeBVeQfbpIMx4GJk0=; b=cvDRcbjcomLtph6Ayt79c2+hwd
	csmn1c7dBOSvgtdp666/VViW5n6U6flBXmaQCU/T4BEVeyeKV8IRz/u6FlAqyaJb
	I3d1tY/jQmTAgMSNr4wZuKlV0XT1ftt2vtun07aSWUhHuLzGRPnwvx6qnlD++obL
	UFMnY16/xSqgm/S5rUYLlSEpFXL9kHYEamkKGvF6FBACutUGxy17HMuz1RHymKbM
	lTTSMB3B9DNri+Ob+nsWeT4JAhdI/UMQgfQE0jg/sRzjNkygjL6axvDAwBn7Ioqd
	v69yn0bFdlKtgB30wgnSKrY9ubXyZQMXV56DjcRvky0JCZC6KIKJBNbzBU/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775631084; x=1775717484; bh=0407JnpCuxGQGH99xSFUo1N5bjQeBVeQfbp
	IMx4GJk0=; b=oeV2yFpm5Rex8kkrAECmZSuxdZKe0sv1RwhClakb0Ix8M/bsrDn
	h4RwDV65UrHDBHbbpr6HUIY8MmE/y4fMSF3HRpH0HC2RY2AMHul6cpwY2Jb+B6ny
	i8c1s/QiDiCHpf2kQp7oy7FTY8i+H7TsptMSQmZZoIT8+Aa5UJhofflaCxRN0o7T
	FTb3QxMpRF50w9LLXzsw+iXviOD0Ry2JHf1NEi0Htr5nXbNygkuGG0z1S0nEidfe
	XNRn2+ruGGfNr4CTFJeMs8GhZRZLHh6mNhdOQGWEg34JlMgxosm79g4buYqZB7MF
	lYGmp4RNew4knF/tSseoco2xBYNVptjpzEg==
X-ME-Sender: <xms:7PrVaRlpUVnXfzn1QbLWmUwg1PVd2VdrRAmTgyzuiCT5KOmLoew_7w>
    <xme:7PrVaUQt9G43KxDAZAb50OOYYf-i4E_q1G4U5iq4Ki9UiNOMF3tzSIzYZjxEy-TGM
    hZ0zNlpwCqxh2WnQRFJ1wUVSbmGzesmicS6ygoN6MY6WfF7VSIF>
X-ME-Received: <xmr:7PrVaVBm0IUMxIF6iEa-wlACVRjX48i-U6n676X8KYBi7XYcL8b8mAyJK1ODxrlrphlGjdymz551fnfjCeqGXuislJBmmzKlcyygyQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvvdeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7PrVabTzMdDqcW9j7dZy1MuLZMr6Ya1CjgJCzi4qHJ_sW4frSjW-Iw>
    <xmx:7PrVaTr3ibI1-m8uQdA6eYkHfh-6KdbSDvbatKMdafOKEgLCKDpz5g>
    <xmx:7PrVadzg5TgIi74jCrIrEIY-HmQ3hXCoO0jB1wtNnnOtWIGUhKlOqw>
    <xmx:7PrVaYJviUJpScDgrPwwzWjo9FxSYe9amsKgqQTWfKnh0ASUoKHJrQ>
    <xmx:7PrVad8U5IJn43yfhz7gcxtE_3lFv96DOaEwvEIY2Qs2kWT5UmxWqJHo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 02:51:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25c05bda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 06:51:21 +0000 (UTC)
Date: Wed, 8 Apr 2026 08:51:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: correct information about reftable
Message-ID: <adX65j-4Vb24GpF8@pks.im>
References: <20260402224241.4104726-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402224241.4104726-1-sandals@crustytoothpaste.net>

On Thu, Apr 02, 2026 at 10:42:41PM +0000, brian m. carlson wrote:
> Our description of the reftable format is that it is experimental and
> subject to change, but that is no longer true.  Remove this statement so
> as not to mislead users.
> 
> In addition, the documentation says that the files format is the
> default, but that is not true if breaking changes mode is on.  Correct
> this information with a conditional.

Makes sense to me, thanks!

Patrick
