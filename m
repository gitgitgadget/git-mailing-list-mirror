Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B3022539E
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730355; cv=none; b=K0EGtRVOzKcW0DXLSfw/4tbKY2P7OHoB+Wb6kbeneR6KzPrO+S5ywTpPOjdqJN4nFQzWff2Q/vXEpoElX679lN1JrK694dXN6p+f+lGc1x+vZvtKnyc0JQSrxMXIrDZcjDU7qoSFCICHj1JacAEEsERbbZ4WqW7lbkc7QSZhpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730355; c=relaxed/simple;
	bh=f++zvds+K/3+CcOgOpdkgYzFzIOEPrrjEOLYWolvkac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fy5wI5AujodgL3lyHaqtJlhOw1A7X+40onz7K+nejm2Z6QzVMMk+7s7PtPllB+GbrDeRHd1NnkO/nl3nIfxfJNHVgFctDRlo4u4pZCv8x8BrqyIv6CmZz8141PKp2d6v8vWCgzK9Cve4PBU3n5Uu3S5Z23jNOL/+u7Tl5T8N6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DxHen49b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6uVScwd; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DxHen49b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6uVScwd"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E67A31140224;
	Tue, 11 Mar 2025 17:59:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-13.internal (MEProxy); Tue, 11 Mar 2025 17:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741730351; x=1741816751; bh=ed4sKERO4O
	O0rU9aoOm3dQvH3fynQNyqN04ASe4matk=; b=DxHen49bKkcH3PDhS2k9xVLvvb
	sEwRZkNiMDTOCIFdrXLvy13XLLG6Ra630la0WWnwvHghEoFvSTI68FTe69WUyB6/
	MVGBPCyPRNeL9AAE2L4STKguPN3vYE5sWdq2/zrUhBnmzsPT8J1MTjar+BrcZqSf
	UTd7qyWS0/TxOUXiJR2QJ4FkBztNgZqbU3YawzG4wbGWCotz1s29KTBb04V7ERrR
	MgpZE9Qsd5GBJ1TnY91K1hV7hX/qpLFR8ZCTCYZvFVUOLSdiH7ytrEOOUyYjkE2c
	I8Baj/UIxqxX3/yyqvpM5JKR4umeOMk9utcyC5aPM/iqsREIo2lj6Vuput/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741730351; x=1741816751; bh=ed4sKERO4OO0rU9aoOm3dQvH3fynQNyqN04
	ASe4matk=; b=Y6uVScwdvxvjRfp6aUiMeZKIDqjDQt5AQe1T+bEF72MiubxPZME
	36nGkwyIfwAEwGoAZWpsU4E97aDC0Q253t2BuMp1tKEx4mP00W4GFIMNffpqurim
	dFTVYzQx4AfIRUOOzbYiqfAspprr8PBMAAH4nSrvKVGzjfxw//zHgK20ijclh1YY
	aRYa4xM4EFYbRR4ig7JrTRDVMISK04J6cL9Gyy2xLDSIWadTKNF+icH39pzYTAak
	rpv8aU8c0lF20TUhx+Oenjs2Vei6QOHBQkxbjt3GfJcyE6UD4v5uVaYMxU1DOSoR
	WZ3uGXh8i4lJGd0OymmvAyE99z/czBFrEnw==
X-ME-Sender: <xms:L7LQZ7R75uiir-YUyNsfGYVrGFuWB_dyhgI7vSfvr3o8X2l8qT4qQw>
    <xme:L7LQZ8x_LKerKstaKEOjO7YXavsivhuGbsaLOP5qtjDg8QkKksK9v_TufFkIjS5aY
    J59ueLFDFCLdkw84A>
X-ME-Received: <xmr:L7LQZw0KNNggd5EUJ5amt3TBuxBgE5ndsNzbKeMo_6DoTv4otp692S7YrTtmfCsdSYZK4yBYTuQN-ENwbUyTJd_gBfod4Miw4LU7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:L7LQZ7BhD543TI1Wj5ncDq_8F1HT_qp269DJ3gzWRRSC9RHotQ0O0g>
    <xmx:L7LQZ0h81AjZ75v9is-zdecYoIiRxeMuGXFoKoJz8vB4wfF5vweMhA>
    <xmx:L7LQZ_o2aC0PF4yd5XspuS-QyiaPZMni9p6OAWpLiJkxPJG2s2cpwA>
    <xmx:L7LQZ_iV2eOkW2vbmRQAjHk-SFZaHiAzjnGrLauBmNYptUZUTf2iVA>
    <xmx:L7LQZ_U1eiixKcJ4Qmyt0nrkLSyG2EM0idNxDRx7yfSLc1yOES6TfMAZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:59:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
In-Reply-To: <f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 10 Mar 2025 20:21:46 -0400")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com>
	<f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
Date: Tue, 11 Mar 2025 14:59:10 -0700
Message-ID: <xmqqikof2pqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> When generating multiple cruft packs with 'git repack --max-cruft-size',
> we use 'git pack-objects --cruft --max-pack-size' (with many other
> elided options), filling in the '--max-pack-size' value with whatever
> was provided via the '--max-cruft-size' flag.
>
> This causes us to generate a pack that is smaller than the specified
> threshold. This poses a problem since we will never be able to generate
> a cruft pack that crosses the threshold.

So far I see absolutely *NO* problem described in the above.  The
user said "I want to chop them into 200MB pieces but do not exceed
the threshold" and the system honored that wish.

> In effect, this means that we
> will try and repack its contents over and over again.

The end effect however may be problematic, but isn't it due to the
way when to repack is determined?  You see 199MB piece of cruft pack
plus some other cruft data.  You have generated no new cruft and no
existing cruft expired out, but you do not know these facts until
you try to repack.  Because 200MB is the limit, you include the
199MB one as part of the ones to be recombined into the new cruft
pack because 199MB is smaller than 200MB and you do not know that
the reason why it is 199MB is because the earlier repack operation
found all remaining cruft material to be larger than 1MB; if there
were a 0.5MB cruft, it may have made it closer to 200MB.

So would it be feasible to remember how 199MB cruft pack is lying in
the object store (i.e. earlier we packed as much as possible), and
add a logic that says "if there is nothing to expire out of this
one, do not attempt to repack---this is fine as-is"?

> Instead, change the meaning of '--max-pack-size' in pack-objects when
> combined with '--cruft'. When put together, '--max-pack-size' allows the
> pack to grow larger than the specified threshold, but only by one
> additional object.

I do not think that would work well.  You have no control over the
size of that one additional object---it may weigh more than 100MB,
combining your 199MB cruft pack with something else to make it ~300MB
cruft.  In other words, "just a little bit larger" sounds like a
wishful thinking handwaving.
