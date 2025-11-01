Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A3284B4F
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761985120; cv=none; b=m+9qBBmE25L2TsSgxz6vlH6ksCzmMKLKQnrTMr/3T8x9VKSA1Ohxm1tmYEgTyj9QqYNKUnK2DR+SXyfcC/jU4hIZs308ry5uifoP1tDT1H14mc4VNfi56mJizfangIjwRUxHoUFAzxR2sFIRaUjMS5i/Oft1F4XMNL3yZbo7Y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761985120; c=relaxed/simple;
	bh=OiveoFLtnZIdPDIktPdt4vXS0SwK+MnM4phWF58mGOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETUqqFnf6wsOTdGwtzAo/qZZKOj8GmXpnlCq0IzcTqVQNN2/jnvOBpYz8maFZwwr5BBqJnd3vzesZmrBLKttzaZ98RVKS4nuaCywD8AFxWO8yENlqC99BngOTPhFAuSSM35b45Q6yNvXkfBcScULmnl6aGxseIcZje4GRPzl6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ef2wnNMC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FCEynACH; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ef2wnNMC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FCEynACH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 574BE7A0184;
	Sat,  1 Nov 2025 04:18:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 01 Nov 2025 04:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761985116; x=1762071516; bh=nT1dQF03Tm
	J95ZWGbVxx4hHSqrJY+kNGqCfTlVAZ/mY=; b=ef2wnNMCjms5nfTwxu44TUwnHi
	y04X1SUwmOk7PRYJwnTjrFYfKSi+fNbzxFgPrkDeLdGWHa9VIFRLrHei5kCWaVAh
	84/r6p7TDCwkS8AxfLu4isujvl/AiatybW0iAKQNDfva4cl5ulecBFYUxYRxbbU4
	ajlrBbzyJiD0FAXj2p/hw4nUMG9EhtXexfB3iwJ/LCDT/H+HwrHR811FTLGtxMKj
	YuHuGBQwaXKu08YGROFxyN+MaWlo7X5zDg+2ItgEu2y4Vf6IsZ6pFcfiSiE57aso
	KsdGCTrO96es6D26Kc7ri37PzCYeUMf9Ep/MuFR16OkjmKgMSjgHwD6Wi+GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761985116; x=1762071516; bh=nT1dQF03TmJ95ZWGbVxx4hHSqrJY+kNGqCf
	TlVAZ/mY=; b=FCEynACHODwkoSg5kJaaafhreFDpTDD2Zqcza6NxqFuS8qGtUaE
	4LwlQkqySAvwlgUBTTiGJtostS5kMurAdLl5FAcCd03wbrNeS/QqWwLJw0+rCxp9
	+6zfjwh7vfnFyzdM6ujf40SsjK4X6N0inwi5ebafbVUIs7kd/KcjKg9tQJW/Ln5b
	b+n2Q3qjXYbOvRHShZht9+mbQopAKpOIrj+gFvycjj6u+5g7pbw5u1tFgkNo9034
	AoEeCIVTLV1QXWPOz7gzs20Pd1TKGeiPAzy/Kcw/mo7Dj4pI7zcN0K2CXx5J4grF
	zi3mWv0ViGraU6yPtkPSiW675/Nb61h56qA==
X-ME-Sender: <xms:W8IFaRlr3UTfBIPWm_5mBYa-FYcMFSMOobr1iaHMNK1h4B2V2--Ujw>
    <xme:W8IFaeU5LC-3CTZg0s6UeDFX67GTd04uGJM7ifsZGaVIO9oEiJkdTk4Zvvu8q3Xbv
    b0MgrWpQxmIcoB2jh3JZSm0vrQ-T43mUpTh7mveLvKcc_8FEo-z7Q>
X-ME-Received: <xmr:W8IFaXshCvyFz3Nu0tX5D6bv7ITApto0eqAbW2qEN1Hy9ChDHyfuKbGPTY6PS6Q13Qv--RFdAO3EB9Jglt1_teFdvuw6_EwvrbWR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhdrfihinhgulhesuhhkrhdruggvpdhrtghpthhtoh
    eplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:W8IFaRYdxfW5AzL3UAiseAirivufvYyo6Fgj6EdN-tnNxwBL7MTiCg>
    <xmx:W8IFaWVukPdu5cOy2iNSIWimu5_eX0R27qg42NDkeZYSWTw-k4whFA>
    <xmx:W8IFaWQAO34FmnZBwIdo0AIEKaSenpXfLcRIoqLgJaLC73dZtzitsA>
    <xmx:W8IFaUNdbB6oqHBXUokVwA9Gcus-VRIwk8HpdyxoacnXvSUY9mhtUQ>
    <xmx:XMIFactnP42S-eDGSxtwfhK62IB6U20Pg041qUutbImoTDnSVAICqElK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 04:18:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Windl, Ulrich" <u.windl@ukr.de>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [EXT] [PATCH v2 1/5] add-patch: improve help for options j, J,
 k, and K
In-Reply-To: <697bf0301cd9459195bdd3cc79e517ae@ukr.de> (Ulrich Windl's message
	of "Fri, 31 Oct 2025 10:08:14 +0000")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
	<75b08ed6-4f0f-4ede-b84a-c2f1c3d15734@web.de>
	<697bf0301cd9459195bdd3cc79e517ae@ukr.de>
Date: Sat, 01 Nov 2025 01:18:33 -0700
Message-ID: <xmqqjz0axj1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Windl, Ulrich" <u.windl@ukr.de> writes:

> For the patch
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index ad629c46c5..3266ccf105 100644
>
> I don't see an actual improvement, and I'd prefer the previous
> version of the doc.

We'd prefer to see something more concrete that refuses the
reasoning that led to the change, than a subjective "I don't see,
I'd prefer".

At least, the commit log messge given by 2c3cc43f (add-patch:
improve help for options j, J, k, and K, 2025-10-06) explains why
the change is an improvement, and I found it sensible.
(<b5034851-65bd-49da-b270-48b68d9210ff@web.de>) 

The old description said 'j' leaves this hunk undecided and goes to
the next undecided hunk, but it is both pointless and misleading to
say 'leave this hunk undecided'.  Unlike 'y' or 'n', the movement
options 'j', 'k' are not about changing the state of the current
thing we are on (so it is pointless to say "LEAVE it undecided"),
and more importantly, when we say 'j', the state of the current
thing we are on may not necessarily be 'undecided' (so it is
misleading to say "leave it UNDECIDED").
