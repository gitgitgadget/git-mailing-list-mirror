Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A302E03F5
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230148; cv=none; b=rK2cZoWREhVVyQWl0tiw0oGg1J9+q6sF513e2mCJ5u/ewZQBsffa6ZVSk+WqIKx4EOCxGVrvOr/qRmlOoXhCNuEErn9jYyoi8EMULvaxL4bfYYyeXVoj1aFxQ4jHRRHWyZDjvouzqd0+ea1E8pRrvM6XAOrQbmxiczduWLRYy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230148; c=relaxed/simple;
	bh=oTv6XJddEU/E2wprLqBa4NlHjB7ZsTDNm9FOaBl1kL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY4K8QyuhFADT3rMerzFHUJdwaiGUfUokvmPeJWu2KWoByfCRDQE8qoXwN/rJWXpIJGuzFa27DtzdqtHaQ0kGBGe+M6mmhJdWkwD9ZBxaM+wXLEgJhyOMczX/GGu8+gfe/WEl2IWweWAQ/7fToA3Zmbb1kOC6fYpPvdzgHw2WwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=agar/7hS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j68S04KU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="agar/7hS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j68S04KU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E4EF0EC062B;
	Mon, 12 Jan 2026 10:02:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 10:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768230145; x=1768316545; bh=t6R5JHN1Rj
	HFTkIx1zb/Z822HA2kz2XuMdNwDyfj6b4=; b=agar/7hS4JmIockq1hAjhBvsTP
	77HGfwX6LzYFGBGPeOkhxiqh6U+iIBuinW3bQSkqbmqbHmkKw/QaSOExBOUa3OXB
	fbx8oRMlr4k6AOJwiZzhflTlxNKhbFFU5n1fZ9chbTpLGmkerNa2Oes/Nm4Etsv9
	j4ALSyubteW87dtHkZYRPIw+F5rwe0UGDhZEfo0Ef9HPOpi4AGycAFqBKGDhIHmz
	YIfqgjxQFBfMjOC1HGhKe9Jbf2HhWcicBG1luZPTxjqNYbDu3WEFQCw6HmyLl9nc
	zVZmFv18sToANFvGhd1m0nAhTDPLzPmUXe64WZHLX3HH47pvdnbH5Z1ygqiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768230145; x=1768316545; bh=t6R5JHN1RjHFTkIx1zb/Z822HA2kz2XuMdN
	wDyfj6b4=; b=j68S04KUPQDyUlNiGNVte4Ik3/bWswYWS/VfnJ1uCs2U7uE5v30
	oaSZXd9Is0UZaimb9IMQjKMDJqQDec6BDdEtej/5u8NwbnlvE8llnsZcQjco7DtG
	PXWdNdYUjVvbbcMvLm5OK4uelj5+Im144V9szR/w0a3x6o/PGRob37e1x8f+6HiS
	Z4heZtGxnC5dofQYzN9lUjy9a2xi9LH5Rz9KRcgvnQRZIpCW+953gQxX0Dwveijp
	Xb9EwhTibk3Uym5MAH8CAfDNbn5+IO/hPcbci5Jybaw2sK/sDg/2fgMLN+Zn8l84
	ikqBwSBYukxzzPYxeKJnsaV+eaDBxQL0xHw==
X-ME-Sender: <xms:AQ1laVRz6LssgPXxi3PtTQERYvVLr8TAm13_uwxkMwrTI7tyUnbxJQ>
    <xme:AQ1laZWg8HCFadhgCNCkIXwFpbIPwE1ZYtyI4cpO6xElWp3mEH79MylgTEjXwSAsG
    l-EacAA51yysVwuYChqx_Yx60v265UWqzonAm-tw6LfJlKCY_BoAg>
X-ME-Received: <xmr:AQ1laXZLNl80T2j_6OUPewigkuKI2-lEA-OIeuIA85c5KNkiyQJuhEdBIX51bA4UwEqivqgrxC4g-II-0ZjBVg4JUFRyzhjBwT53B3hoQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AQ1laf1a8-N_DbnEqR_nbYc8xliURzyQyfjtrWkYrZCKVirJ9JudVA>
    <xmx:AQ1laZhZL0iFDtRJCd6v136Ygtu540CmzDK2EsgeiLFGwwWq4sFvag>
    <xmx:AQ1laTbJsjZbtebMmz-r-r3vVNSPbQr4gCgmyHEXUuCEMlxAsY120w>
    <xmx:AQ1laZQW21dxAP62bZIV_Nm7E1jeJd18fdPo-j32tzrMYClOne9ozQ>
    <xmx:AQ1lacAo1PYqieWY5c4pAwiBgIO9yJ4NLWbzW3YABIUkQNbG_A4XxGjg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 10:02:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 03cb7b3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 15:02:23 +0000 (UTC)
Date: Mon, 12 Jan 2026 16:02:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 10/17] refs/files: introduce function to perform
 normal ref checks
Message-ID: <aWUM9pc1S07uIgJp@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
 <20260112-pks-refs-verify-fixes-v2-10-2e9e453bd6c3@pks.im>
 <CAOLa=ZRMvbRT64+XdKobM5RZhgiPd=2k5_Yf=rgKyjWnbpMg1A@mail.gmail.com>
 <aWTyXufNdKckmBTC@pks.im>
 <xmqqldi2oqve.fsf@gitster.g>
 <xmqq8qe2oq26.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qe2oq26.fsf@gitster.g>

On Mon, Jan 12, 2026 at 06:37:05AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> On Mon, Jan 12, 2026 at 06:42:04AM -0500, Karthik Nayak wrote:
> >>> Patrick Steinhardt <ps@pks.im> writes:
> >>> 
> >>> > In a subsequent commit we'll introduce new generic checks for direct
> >>> > refs. These checks will be independent of the actual backend.
> >>> 
> >>> I don't think we've used the terminology 'direct refs' before. Took
> >>> me a second to understand. We generally use 'regular refs', but that
> >>> includes symrefs, so I think this does make sense.
> >>
> >> Yeah, I didn't really know what to call these other than "direct refs".
> >> We could instead say "non-symbolic refs", but that also feels kind of
> >> awkward. So I guess this is good enough...?
> >
> > The latter is understandable, if awkward.  The former is not.
> 
> Well, I failed to elaborate why I think "the former is not".
> 
> The former would have been, if we were calling HEAD as "indirect
> ref", instead of "symbolic ref".  But we use the latter, hence
> "direct ref" is much less understandable than "non-symbolic ref".

Fair enough. I've queued this change locally and will send it out with
the next iteration. Thanks!

Patrick
