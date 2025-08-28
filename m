Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06731DFE0B
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756410480; cv=none; b=DcBoCWIwutyUKS0GjLKtJ2XtuKfxzQWwnp8++OXcezQXJRuuPadPGAs40cBpb2sG1N9W4kI+pfsl4tJSSJ3zW/nBW5h8EnQ/vIwDgzpFJ2hf4OoKgzbavjR9OWbbyx/mVlt6EuPbmNRoLPpJwEz3U2yimNwl8G3Lm080cijiMpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756410480; c=relaxed/simple;
	bh=AGZBENVfKCRgqpmVCBhFzrpm4qZAFFIeCHc8AQGR9E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Knoe4gwqxmI+UxjrGogGkRTl8e9F7j7u5rvtg7mSG9hR82+ffQTfpXXBkfBTDj54eqgXgGI6UhgXNiWBlf9tNuUZg/paicU4skFP/59XaL7In/Ka1eEPdQjNSqGqyqfORH+VISnFvDCYUlWS4b+11tJh4R7V/06/yDwD0V7ZQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J6qBNWqP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGqSKAjg; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J6qBNWqP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGqSKAjg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0E0B7A0188;
	Thu, 28 Aug 2025 15:47:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 28 Aug 2025 15:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756410477;
	 x=1756496877; bh=Mgy4mIPaeABhskGWO/0t7QQfFRFuzEYPcQYfm2zvicc=; b=
	J6qBNWqPBNfN7BRUYwCCqwiTHWEKkTDgpX3KZDhTCB/LVJzki8JBSdF/Du4Om9ts
	mvjBcy8JYsH3BbCaTxRFT+C3YiJ5l6wIty3NVHeKX6S0b299lsddijX4xsOU6qme
	ugrTdzMgA4KrWTyEZL35gSTB6XnYsEpuunZA8gTKji4rwECLtW8WqLy/TMkkTy9A
	AlH85kfbo+ke+NCxIInYHmdgAeH+6qHZJwVturJz8yR9WWmawHBZ4f6tTNrojHJV
	oKmK/iiqQl3qkAdlo7MjyKcw20yzyu9l2YWaJYm4/ndp7e1kRAHnzUY77mw5zD8B
	cElRYYMDEUAZ+U+YCOuCPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756410477; x=
	1756496877; bh=Mgy4mIPaeABhskGWO/0t7QQfFRFuzEYPcQYfm2zvicc=; b=C
	GqSKAjg0us31KlzNLbgSi4dUUfD4oAscjwqPC6NsyMqOL2V7MUhVVPKDJgN7QLYI
	/LOY8FINAYTCVVMTh70YMTm073twGI/OAoGmciOSaf/yLIROLQt9AGUGKKpXPOi7
	va4wpuWRSZo/bVzbSITDdGa7U/ciVpFwJUmRTmscjHqitnxMONfdCPPxjhZ3ScBa
	W8jQqqWpVDkotMN5qVbnU+TH8Lu5DiKjFt3CnkNJIE4NUVh8m0pY4gkVjDQGV4f1
	W0Lpm/SUpzObj7TK/1q7cHZv2yPqIt+E+qiSHOod7HWziSwF5cZy9YvkZG3niDYy
	25cKBGEpK2OMGaN/2m3hw==
X-ME-Sender: <xms:bbKwaD3PJMOwL4_CXy_f2BeivAwoOgtAct_3EX261J7QSMwgYSew5A>
    <xme:bbKwaNmdK77jIqBLbxUmaCT6KXVTMIinZ9NBaia8sqiE5r8WOLBpbS5p2gnQ5PiI-
    AuaUE8amZ-ahgr6cA>
X-ME-Received: <xmr:bbKwaKVVEGApk7LL9f1obSCucOSQFv5Pxbj533oZmUXclWCSEoR_Tj2T7HARJ1jAieVXnD2N7TFPKDelKNvr-ZbyPoKE6UhkXwG5axM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedukeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnohhurhgrvghllhhmsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bbKwaDtyGNPmt40BK7z3JH0Oz9JVXpwsjDCQOGiAEFQdXjBBQ3aOhQ>
    <xmx:bbKwaNb-aVQRUMnP7qkzW6-zoq2o9dWXE682RQer_VdWB9oa-yLyNg>
    <xmx:bbKwaCUNlwMX94OI2u6NW9Is4a0FxYoBP99zGOwvQMnkj0cRjo8VZg>
    <xmx:bbKwaCQYrWhzZWkZbts2GrNt_kiORgKrV741UJpyjq9vVfWqbVhmDg>
    <xmx:bbKwaGAzO9DDzxwM4efdN8Orlw8YNVMPQnilVBpE5kSRujoOxKeeHNn7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 15:47:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: =?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?B?44OO44Km44Op?= | Flare
 <nouraellm@gmail.com>
Subject: Re: [PATCH v2] alloc: fix dangling pointer in alloc_state cleanup
In-Reply-To: <20250828192949.GA18641@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 28 Aug 2025 21:29:49 +0200")
References: <pull.2040.git.git.1756238268790.gitgitgadget@gmail.com>
	<pull.2040.v2.git.git.1756337312918.gitgitgadget@gmail.com>
	<20250828192949.GA18641@tb-raspi4>
Date: Thu, 28 Aug 2025 12:47:55 -0700
Message-ID: <xmqqtt1rut1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> On Wed, Aug 27, 2025 at 11:28:32PM +0000, ノウラ | Flare via GitGitGadget wrote:
>> From: =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9=20=7C=20Flare?=
>>  <nouraellm@gmail.com>
>> 
>> clear_alloc_state() freed all slabs and nulled the slabs pointer but
>> left slab_alloc, nr, and p unchanged. If the alloc_state is reused,
>> ALLOC_GROW() can wrongly assume that the slab array is already
>> allocated because slab_alloc still holds a stale nonzero capacity.
>> In that case s->slabs remains NULL and the next dereference writes
>> through a NULL pointer, causing undefined behavior.
> This is good.
>
>> 
>> To fix this, this patch:
> Style nit, we tend to use the "imperative form" here in Git,
> like this:
>
> - Rename allocate_alloc_state() → alloc_state_alloc().
> - Replace ...
> - Update ...

Thanks.  We also tend to avoid bulleted list.
