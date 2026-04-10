Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021932B9B5
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775795681; cv=none; b=R5tLhshGXAFq3LIgHL/p8rAbDuTHpX/gu3GOTH+y2hBGQJnWjX6HTostzC8quffg1in3v8Hy+i/xOtxXDHcHf6e0DgZNOG4c2LhVeHSf7aOPsVTVdQEKdPA8Iz0GFiyAMedXxE+xTh8DiTLiMi1d5qCcgZnrOa/Xd3q1B0kEedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775795681; c=relaxed/simple;
	bh=JaCL7t06yIppGSfr7C5Ag5Nj7R5OEHMmOG8RjDIhWrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po9mu1CacmX6pIVjTDa32eY/ngzHx9MfQhBK2frsI72dILEMcwrufw8FT9bvRV4p7uxFOXpF0iofZ2uHoXPg3ggyRU0CiItkPORNZMzckXCVGbbcPMYAFgC3VXFHBLH17HYF9qtqeHnUa0//anjE8kRv9yOXege3dYEx3UMCn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kKFhZv5V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IIjc8Ww8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kKFhZv5V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IIjc8Ww8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C648AEC0400;
	Fri, 10 Apr 2026 00:34:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 00:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775795678; x=1775882078; bh=6BNvy+o9kA
	irP75Z4Mo9Nlolx3BftXfGEL9lumxnsA4=; b=kKFhZv5V9d29k9SmO1bHQRXcg6
	rwj9Qmqb8YNDiP17BGAER4xQLdtGUIag7EwFzsNZEUNVl0A+dWZo9GFIXL/wRQJR
	GFrwGBZfXc0tmTIk5Bsh940t49xZVLvL1xdysRIt2tyskkdSguZSVU0D++qamu2b
	0NTSMB/hCnC6UlsdGSoCoREN3e7l96s3xQBSedcaCeh6sp+x8eEQHqJyzD3TwQXM
	t1fECYPeiFiemRkGFuMf1h+2q4lBt9osxjIpdafnQvgvzv0/kfYMjHwTqRptgxfa
	nOd3fyS50JUYsV1C0oJAB+cK/fWhny5xfxoJi3BjmQQmC/VfQPpqYjsRdsvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775795678; x=1775882078; bh=6BNvy+o9kAirP75Z4Mo9Nlolx3BftXfGEL9
	lumxnsA4=; b=IIjc8Ww8s12RwMRgIhe6WeJ2fRdGyIHNch+xmbXMDfqLza5Ffis
	RwbIx3LEg1MtMg4Z1J+lQLGFd9KodcP78qLPUE4mUBsL6irOlHwMEqTcAjv3oAA8
	/GJ7nB/iwgJhy7QKImfURuUpPedCFwW0gfeW0TOZCogBZohwVMj9wY5CKtexTv1O
	oBlBheVsWaUD/V2HUg4oTYDtL0ybqdqyN69hqibSE87UdwPxZkl27PF7rcwCGiz2
	ZBvky8SY2OWSuEWvaDCGfzJAJY1umSxGRd/G8rOraelRl4hiuESXyh/BHCeECeDU
	wNLY4qVprAphKNFQ4PjE0BtQHmfijxwcviQ==
X-ME-Sender: <xms:3n3YaSRzUkDYuAyLM2YWgwENZAmLGTITMPgeiCoz0H3l8R0nyA3K9A>
    <xme:3n3YaepE6u7D-ffG7aNhxAe4z7Shlnyu6YQpDVwj42ynEqyy105ocWryy53xCq3Kv
    bA2VqoL4AlPceQX6GQoStR4a7A4h2SInhzkYlRc5D5JwU0I3fM5Xg>
X-ME-Received: <xmr:3n3YaYImdEr8rTypTv62RLMQlnaU1Svtamh79Ok-5iJZtVyieKjjlN173xHg_0ki8AVIXjSPJcBtj9LibkO945VSCpVNhvhadL2IuMBkW6XPYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgv
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghr
    uhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:3n3YaZpbhs_5em6K3RpBQ3JhYVM2RTdZKmyDOclAdoaVeb5XKMy7kw>
    <xmx:3n3YaYwZj0V2JgvGm2pVtmIH0pNjiTCUPFmDPOwbuTACmJoKAF5_0Q>
    <xmx:3n3YaVMC7icNQhEg93tW7Td5A9KzllaR28523LmSx3Ka3u6XGSKjzQ>
    <xmx:3n3YaV7XKktiLt-9d1J0CycDytkLKrpLbAK8SyRjv9eZEh3HZGihzQ>
    <xmx:3n3YaawLcDqSm--CNxDStQqZN9uyS0GU9szpJFe0suJrDJ4GvfNX_gdC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 00:34:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd7c12ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 04:34:35 +0000 (UTC)
Date: Fri, 10 Apr 2026 06:34:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com,
	"'brian m. carlson'" <sandals@crustytoothpaste.net>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <adh92BCD47PlK9BM@pks.im>
References: <xmqqqzopxkxa.fsf@gitster.g>
 <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
 <20260408223233.GB2873736@coredump.intra.peff.net>
 <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net>
 <addgkjiB80pgKw69@pks.im>
 <021a01dcc827$4e6342c0$eb29c840$@nexbridge.com>
 <20260409203338.GB3076846@coredump.intra.peff.net>
 <029701dcc871$d055dd20$71019760$@nexbridge.com>
 <20260409225806.GA3133902@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409225806.GA3133902@coredump.intra.peff.net>

On Thu, Apr 09, 2026 at 06:58:06PM -0400, Jeff King wrote:
> On Thu, Apr 09, 2026 at 06:40:00PM -0400, rsbecker@nexbridge.com wrote:
> 
> > >> Please do not make the change in git-compat-util. This will break xwrite().
> > >> We already have MAX_IO_SIZE working and verified from years ago.
> > >> Changing that will remove our platform from being supportable.
> > >
> > >I think that was just there to demonstrate that the patch works regardless of the
> > >size, and would not be included in the final.
> > >Building with:
> > >
> > >  make CFLAGS=-DMAX_IO_SIZE=128
> > >
> > >is probably a nicer way of doing that, though. ;)
> > 
> > We had that set properly in git-compat-util.h for years. MAX_IO_SIZE should be set to SSIZE_MAX if SSIZE_MAX is defined.
> > #ifndef MAX_IO_SIZE
> > # define MAX_IO_SIZE_DEFAULT (8*1024*1024)
> > # if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
> > #  define MAX_IO_SIZE SSIZE_MAX
> > # else
> > #  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
> 
> Right. We would retain that. I think the point was that Patrick was
> dropping MAX_IO_SIZE artificially on his Linux system to exercise the
> new code.

Yup, exactly. I don't have any intent to change the above snippet in our
code base.

Patrick
