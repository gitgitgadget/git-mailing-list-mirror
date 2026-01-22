Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30035FF49
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109630; cv=none; b=c3Ihgw8DZ4/xtPctla4AdoJ7wpxR/e26BoHjOv0HG06DG3PL+PRlSJdh6cDDfarBB5BCrz1WKn/z0wXzbW9Z1ZEPkGciLlrbdfaApn0+4urey3X7TTsJJQ5VUbvig7bGp+FMH38O842AlBDFM6wyaA6wFEnlG0nyMwNoUqJhIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109630; c=relaxed/simple;
	bh=Q4ro6+TBe0zapFKHoflb3dJ+nC3kBc3+vN/6Uw8B5vY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GI8Nkw9bHxm2H/EdoGtfawjDXPtO90obAYjwVO8g1n2bydxvHXJbgpPJC/PSIA/g1eSqvkhSMCsdFJ7vQgG0DH1aCxofWpo62Ga4trymrLwKigg1PR/ozH/0RrgY648FRU2wkYXEixAnOyjnHRXOQi1O/1ZpWhY1ZBYEjmi4B9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D4GwLsBD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFqos4Mj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4GwLsBD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFqos4Mj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E817EC044D;
	Thu, 22 Jan 2026 14:20:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 22 Jan 2026 14:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769109619; x=1769196019; bh=mv9PokN/5E
	EedSgChDTDgs5ycmPgCq/BS4liYbdq2eU=; b=D4GwLsBDqfTzteqjWyoKOZHcHv
	BdvR8LwiM6QXOBtRxMrgYAZD99aN6JP08v3+IyQmQnIZN0Le1hFsrgQaTAn9+ci0
	SQkhgHY9ytIn5J85PbsjV6DEshdGV7Clfp2OFPrw8SQvMbWMj4e/a6IfamyONnFt
	wKr1TplRQIwcRnbouH+6KzMaLXrQCprsA1NnieZn7nxsZXbCWmy4M7qRLsBgx0Tt
	7PlYz7h15hllV19BDEau4tQC0eOeTfLPxzTroBbjJ2mmkOSLCXEd/FmkCisCKWSs
	deu2Nv2YpezdwdrCmZHj4TTRR+we+n3kazP0gLyH0EbC2LHrXUNwgjuR6Sog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769109619; x=1769196019; bh=mv9PokN/5EEedSgChDTDgs5ycmPgCq/BS4l
	iYbdq2eU=; b=TFqos4MjK368p94QDsg4kZGuJTtFZwiO6lt+wISzY1LZAjP3uOE
	GEkxYHn3tqqd14aEukMOsOxDHhpGp6HxlXIpz3DtS6mwamBGy805iWWSTXMWd2jn
	6UZoZzjOLBA3JYTxgrxU3PSB8YvcDkb2fvteaNgfYOh6Hm3ci5N4X7sB0Qf9rFBw
	UR3JqGOJd8Bl9UzwsH3jYoV+4Yb0pmDQTGYMvF29hqCGyaKqq3WCVLO9g7UNJZpU
	pxz9yzl7z3aPapiPQYLlSY1l6KDa0g424DC44RAggU81tMnSu/m4h2fOUkU5godB
	oPyFqT7YG3V04FnMidl1Hzg37xqfo8RZtkQ==
X-ME-Sender: <xms:c3hyace4VNCXgeAnuaPS_xzPXjpn2z-b-8iEEC_wuyW1HY9Mlxq_EQ>
    <xme:c3hyaVM3uB68sa4svayu311cZ8eaMf7GDvnl6VQCYL8Zv0ZlsVXLGGH96m69KywaY
    pCeABVgBgNfeIm5PeRvDQmGO2kLAeeuVg6tC7g4PNoKqrTRiOgY6A>
X-ME-Received: <xmr:c3hyaSgukv6g8fqZNGXOke4sdacpwPIPolXpw7dWA6jVwPd3jOjzIkXulbpEzl1O1Hw33XqNV8l-L1Hvib38X7_kfbCVtqT6uN2rwIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrg
    hrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:c3hyaQ2ltc-yhWCIzf1b6VEg1U1ay9DCVUzYoXWW6t8yLhkKnJHHvA>
    <xmx:c3hyaUgq3r0Alsxs-Lq_TtK65OrHM1-eMpBYFB-ORPrljiWmr0xXzg>
    <xmx:c3hyaYf-iipN98KHKdEvLcnZZ6o5zujF2HzN4D-Rty028cnJpGRBcw>
    <xmx:c3hyafm8Ojxpxjmq-j9RmhG1FiqCU9J8lV7-cwUHZI5sdtI5X2o8ZA>
    <xmx:c3hyaWCWRR0xfubz26RtMMPI2XVRJQEdvSWLDVOI6TAWW8W8GOc7yc6h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 14:20:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v27 0/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260122190954.64780-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 22 Jan 2026 20:09:54 +0100")
References: <xmqq1pjho4wn.fsf@gitster.g>
	<20260122190954.64780-1-haraldnordgren@gmail.com>
Date: Thu, 22 Jan 2026 11:20:17 -0800
Message-ID: <xmqqsebxmp3i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Before these list of CC's (which does not seem to have any effect,
>> by the way.  The message is going only to the list with your
>> personal address on CC: and to nobody else), ...
>
> Hmm, I always just the 'git send-email' snippet from example here:
> https://lore.kernel.org/git/xmqqbjilo6h9.fsf@gitster.g/, which for this
> message is:
>
>   git send-email \
>     --in-reply-to=xmqqbjilo6h9.fsf@gitster.g \
>     --to=gitster@pobox.com \
>     --cc=git@vger.kernel.org \
>     --cc=gitgitgadget@gmail.com \
>     --cc=haraldnordgren@gmail.com \
>     --cc=peff@peff.net \
>     /path/to/YOUR_REPLY

But the patch you sent was not using "git send-email", was it?  I am
not sure where those annoying and unused CC addresses comes from,
but it would be from GGG, not from "git send-email", I suspect.

>> ... please summarize
>> 
>>  (1) what this series of patches are about, to help those who
>>      encounter these patches for the first time, and
>> 
>>  (2) what changed in this iteration (v27) relative to the previous
>>      iteration (v26).
>> 
>> I happen to have seen your other message so I can guess this is
>> about deduping when more than one comparison target is listed and
>> some happen to become the same branches, but others may not have
>> seen that other message, and it is not helpful to just dump the
>> range-diff and force them to read it to deduce what you did.
>
> Fair point, but I always always use GitGitGadget to submit patches to here,
> I'm sure sure if there is a way to do that from there?

Sorry, I do not work on or use GGG; other users of it may be able to
chime in?

Thanks.
