Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B39145B3F
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975636; cv=none; b=EypHS+ofirJGuv3iMV3U1TduGl+L4gXv2xElvuRgFqJoZifLggYuApLYptROCU7PsYWsaZ5MdpvBVzTNDELY+UKG/eroID0eE4XbQTtZjj+pRFtN8Ffwgh4+8vu+dSSed0he0wEzPEVrIE12WrasRFMmfVrFaDBntsEQ+oVv/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975636; c=relaxed/simple;
	bh=Lgg/sno8HIIie+jHD8+v8D7SvnOn11+rpA/CyOpBMRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JSWLERRGHzPT7u35aIWnug3Jrd3I+T5TFd5al/rvKYo598om0x1p8yX3t9zPYSYXb7BI3K7y0XT+HC9u7z74IsCL/7NTIM/LQOoW4XAZgVNRZxAmForw+NzMq4zlOlqXvULU9WA3YzByBgQdFIoeTywyC4sAEOV8yOOw9GlSunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KII/Lk3W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VptImyPi; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KII/Lk3W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VptImyPi"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B5D411401BE;
	Wed, 26 Mar 2025 03:53:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 26 Mar 2025 03:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742975633; x=1743062033; bh=Lgg/sno8HI
	Iie+jHD8+v8D7SvnOn11+rpA/CyOpBMRM=; b=KII/Lk3WZV7dY8xmoLN35lUoAw
	CnOky6ohZamSIKjDRPw8hne6GQgycRa5Vyct3YRoXCS0L/9BEMfFtPo3W4RPhMxS
	NAieIBW1UI6Zn4NHS2GFLpJzdAdGuYUZIlNIJw2NIQ0ul7nBPqBfjBYomQ3bgwnC
	WeR4tjKKoBEN/Ne4jukVjZtYa2H7SyRhnt51pgRKvgtpqzGftdUzQetsjYHvMNak
	n0ZH1ydAKDLDkLTpv2Wq/VHYZDeKM19GelB6F6HWP+UmRx+RSHSesja9dvP0DocF
	lXb4sFUgZ6eBBlHnw4Al9xIgqiG+xhz5sqD8rlBAPOVq5Cv7lPgDlK7ymtxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742975633; x=1743062033; bh=Lgg/sno8HIIie+jHD8+v8D7SvnOn11+rpA/
	CyOpBMRM=; b=VptImyPiwew98VndL12aRYvgCywx2nMlMxNmWFN1LgxjkV7Yty3
	TjlFf87Bs/tSxyrxdERZLH+UXQmIssH8cYDfRvD26Vz2JcETrVbkuGX1bjkVimJy
	PO2RdNUBf/oGEzs3w3OXsW053suzQEfwT7slxWS0Pm5vvB+Tl0L45ds8LVrX6PZH
	AxxMIqKG7ksT1UZnjF2PGJvKmjcmzxJVqmhj/qZJJ60+X2Aqt8ol5JDVGCsqN9hI
	6S2XK6LOaMjFKzDQBCI+C0MJGRDyjc0mQT8mudar+xB8rLVyEWQQxAPBUCVeVPhl
	KYtBRjuXfkTaDe+cgJvWhvquLTEIwwgQblQ==
X-ME-Sender: <xms:kbLjZ8lEIB_lAr0O7RxjzntOGDk95NO1p0EFWq85WsLFJluXeLMGdg>
    <xme:kbLjZ737yz3fj6wtr257PlOOosvihn7iD3LCndnT2BJrQWEzPb2iJz9Eft6Ro4nV8
    b861FsIYFmZAx4xuA>
X-ME-Received: <xmr:kbLjZ6pVooOs4725hOiqcNHdyn9_0jeWm_443zkWz-9bhHfL_kvRq75cf7BS46nVRlhDBQIprEQHrLoBt9Ybl5rPn2ixTYm0Zlf3G0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:kbLjZ4mhsI5e-d738Ys4p8v4VOlNJdFthqRVBUgaYNXxL0i-GKmGJA>
    <xmx:kbLjZ62h5WbTHWiN28vFAQcKRm9db5ueZHb7xmCmYP263MuwTv8Z_g>
    <xmx:kbLjZ_vgabGVtYvkdt9tZ6aR--rh4nx08wckNrSUrMpN2PPtREdPlQ>
    <xmx:kbLjZ2XeNy6BEzPXFLX6M7CKmv18nncQWSDSStXqVTE0AgGoOTggmA>
    <xmx:kbLjZ_xKUfA-XzKAGrC6AM80Rg7B671ZKaPJ089xvpe6HfbI4ml2orZw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 03:53:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: Releasing versions on Fridays, was Re: Git Bug Report: git add
 --patch > "e" makes keyboard unresponsive
In-Reply-To: <c4753c0d-d957-c4d0-a452-1e592cade34f@gmx.de> (Johannes
	Schindelin's message of "Wed, 26 Mar 2025 08:02:22 +0100 (CET)")
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
	<84c3ccdb-2aaf-9b34-91c5-cf5c27f53dcb@gmx.de>
	<xmqqsenb70u0.fsf@gitster.g>
	<2dd6e0fa-b997-f69c-874b-f424325123a8@gmx.de>
	<xmqqsen1mj1y.fsf@gitster.g>
	<c4753c0d-d957-c4d0-a452-1e592cade34f@gmx.de>
Date: Wed, 26 Mar 2025 00:53:51 -0700
Message-ID: <xmqqy0wsi5ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That said, I am eager to hear your thoughts on how we can shift this
> dialogue into a more productive and collaborative direction, one where we
> focus on enhancing the project together.

I am easy and can release on any day of the week.

You are the one with a stricter preference.

So, you can just say something like "let's make it at 1700 UTC on
Monday" and I can respond with "OK, let's make it so".

Let's not make it more complicated than it needs to be.
