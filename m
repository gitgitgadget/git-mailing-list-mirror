Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FE340D98
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206948; cv=none; b=QPmLrY/l8h2Z6m0XelJMFVHdQelAKXwsmFIB7aXJdIp8MEiir/1l13L/eEkyLOgdn5Dmsf5rH2KydZxk+oqbQecys4SqqXCBxXyQE868oo29/rUY96dT6N7ud8514MSJ7XtCT2tqRc5+UtL4gw6YCVIF16boCK3zQwKQQZTom4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206948; c=relaxed/simple;
	bh=O/L+TIILKqTXUiGbfyHlLCfWpuDR5KKLn7TNvHY0m1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpMnwMU5mh3VLI0zgPVgWz7U/Bn5D9lkF9/QgGHhR1+CX3vSIkjBCcp/hIqnuLrtE4JTunNFs7NnEbFYYjNiN0wRVYrCcxHd2R2iw8mWuU68CfFiHYYD0qwRB26WTmoCVvG7GWGyHa5sn3iRSbVUUEyVDf0Zy7pyVPEnaLNZcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L/qp9Nz4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZgRoBsB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L/qp9Nz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZgRoBsB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 732BB1D000C0;
	Mon, 12 Jan 2026 03:35:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 Jan 2026 03:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768206946; x=1768293346; bh=kRM2jGDGVa
	wMCVR1wM/O3e+eayJmQ1oNZlTv8/wTbZc=; b=L/qp9Nz4aWa2d8atjos57Vj4XX
	aFZWwKaKv69CAZ/eweXjirjwf3UKa4o+JVG3FKJ3iBYjWiDlWJVIYNaClbnhbSIR
	GE179B1qiSzLtVLkXHdN2kZFsBCCy2m4ccPqdzUiHoJ1x845U2+dsm5ShYTbY7k9
	gq+IZqn5doUJxbymaBnxX7eunjecBne6ACNwyfyrpl0hKkOrAMKN9zUsz/DN+Jh8
	58TizBNSPpkZCepIquzsN4WggXF2ry82J//sIuxumaOBMCjgMvOZ8JM9dZIQI2hd
	PavZnQRM9IH9y6t1b6496SL8ha+YXiyd/XdJX5Cf84ozqxwoLArMqnXtGCJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768206946; x=1768293346; bh=kRM2jGDGVawMCVR1wM/O3e+eayJmQ1oNZlT
	v8/wTbZc=; b=PZgRoBsB+SNNSslQJZfEWIN+e5fmNQnjgipshPf8YS397SfUgcY
	v+wzk4XKklG+7zPO4RM0rZh4kjs4n9unhbffyE2PfTO2qObp+bFOLlba+f+xEwhE
	aaFkUzqIfVvBjMTZO/z0FjZMe4hNwR4w4lGJNMNzN7J0IqnlDsy5D2cTchyb9yP1
	Td+3Z8j7IGyCAFxDlPrQ/9MeONIMAq8OIbLD2Y+ilPicBjMLA5N+spUf9K4m/FvR
	ubPIs4inYQWmaRMUSfwRBgtTResz5K7GWjN+YRibSMPNhe2DKhISXUQXTM+AxFWA
	WXH/PWKnqt5dS4Gfjq60FI1/AcxbyJZCduQ==
X-ME-Sender: <xms:YrJkaTcqNymg9k1ciswwis8Z4k2MxRL-zwN21LvKwbou81dW47x28Q>
    <xme:YrJkaQpb8GpvipLd_zzKOIODIhKUGvHJlzgEjC7w2DY58Pt08WtW1VR7Bm8VXoL8T
    ZO6ujTdXfR33LtFb0-EGYZThiWvqL5uhacgRGw02aXHUwZ4MdDHGw>
X-ME-Received: <xmr:YrJkaZ7H10cTgbdZLgAKezqf_wohSn6czxuxcoATkm20QleUs7ChN-vt5aEoTRbfcdPr6B-OeNsVeCM-EJT0bdroemVKOq94THsaorVN7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YrJkaep1qmYsbalN2_DLShKnikn-qd_xuSzb-qs9YYhSDkZdoQEKAA>
    <xmx:YrJkaTjsneYASNXZbOaaGY_nuJWrr3fWto6zycQ60xeRSNne00frxQ>
    <xmx:YrJkaQJlqXGod2rcy92hOKiu4n5qnbsZMV5PYJ4Ps3kMtg81fEJYFw>
    <xmx:YrJkabDXit3iPSQCVXrxHHAAw--9KkRwqEtuTszxa-qjddWlSndXGQ>
    <xmx:YrJkaUJ21bbFQpiCfDYXBfdKKrnrKYvXOtIdqz3fPoSt5gImMYFE8Fyn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 03:35:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6504f53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 08:35:44 +0000 (UTC)
Date: Mon, 12 Jan 2026 09:35:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] Last preparations before upstreaming Git for
 Windows' symlink support
Message-ID: <aWSyXfxOkpWMgX6D@pks.im>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
 <pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>

On Fri, Jan 09, 2026 at 08:05:04PM +0000, Johannes Schindelin via GitGitGadget wrote:
> After preparing Git's test suite for the upcoming support for symlinks on
> Windows, this patch series touches up a couple of code paths that might not
> seem to be related at first, but need to be adjusted for the symlink support
> to work as expected.
> 
> This is based on js/test-symlink-windows.
> 
> Changes since v1:
> 
>  * Fixed Karsten's email address
>  * Instead of allowing unlimited symlink target lengths, it is now increased
>    from 2*PATH_MAX to 32,767.

Thanks, this version looks good to me based on the range-diff.

Patrick
