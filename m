Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B13A7D9E
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461123; cv=none; b=nQTL6uNws3ciElR718HKEk6X0nSGnx67ztwmh2yaE8ecnxR7sSmW/SVp+eTYjlFkuWAtAhHycjFsH/nogOcjWoU9ek3IyOMeQDWRfxc5H0ZTndkYtIfX5S8yjBabNHoGrSs/4hVYU47ekdQN8nsAS+ciUHwzAFzKT3rCVieZPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461123; c=relaxed/simple;
	bh=bL5L9ahHgWY6SUom3SiZ/P0F8OuP4d2y+PV/RRNNagg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6xJinM7npsIYzS8JZlbtM5SYjiJvXOE3grVy8foJax00BNKOCZDDueFR8NvT3TfDjZ3MvszXJXHj5Ahkyh4mdOTBSAkZyO0CMfCwQd+EhOQA9h7k8xQSOuBYhnCncMidldyllAA7xIYVjSJpqBYOL4/nrWGd4abPoI6jg8ZrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t6Kx4/+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oqs4vQQA; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t6Kx4/+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oqs4vQQA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D97377A0125;
	Thu,  3 Sep 2026 14:45:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 03 Sep 2026 14:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788461120;
	 x=1788547520; bh=tmxPsWX7P9mQEEV0B7ha8GWJz7qt4onqOS01u8fBPc8=; b=
	t6Kx4/+LJakG/firTJqN3N2nFTnkiePpvw94zd28Vwmy09DDxsjry7H6nfEKD9rm
	FPpzU42p8jMdBUxA5pJPa8vodkm878OwEgC2rb2WYxNTG9bQzPyyl5Mj7KbPwlkl
	BAmVn0IbjmDYbmDG8B2LV2/9Qqka8keePKq+GsAz2u9oDRMuxM3di4n10SfAQUMg
	AXNW3xCY1hWJtE6Oa4RgcUKoARlnmdeA9538u6R5tKJ1N70bfd8UAhlbIBIQcMks
	4jktAsxILwDK9GuLWaJycYj2Eyblk1oGY2l0RWuQAUyYp+j2NYNgg/2bzEprOQ42
	LJmCUlBdgdLZLgXGdcLubg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788461120; x=
	1788547520; bh=tmxPsWX7P9mQEEV0B7ha8GWJz7qt4onqOS01u8fBPc8=; b=o
	qs4vQQAn52ooVfKHmRgsl2XNYkWozmaNO4aroPHXHlwJCaJzHI5keAkGGgWkG2KB
	ZQZ17LcFpY4WAaxodhDnBWh80kwSg7S30xrV3HgCTUyS1amKSRSUboNrMCLq3uIY
	pchqjvqbUsAMVOaEFTNAq2DaZFj/Tw2Cwq/uYOgFr4efKTvUcdqLTToZEEOhyslF
	Rg2HQ+C2be1bdtfgdjYf0br9uZWlAeXV5+Xdauh3s7y14y/1Q/BTOZKX1miHzwNq
	pcmteAq16DRuxn41/wJASuAeiVVcYQUgVXkUAzFoxswZQGYycdQJ2uKcq61gQLvT
	f55c3aFjk8RCWXZPsLRBg==
X-ME-Sender: <xms:QMCZaqUVguHURpwJiarnf6QCJ__ItF2KBMw7rgSmgZjXR6GcBAi9qQ>
    <xme:QMCZaqS2YuUMiwrX1uyvsfTJdDXNUlEXvlwm1AVsO_2mxOkro3m277vlrDtXJk9Xo
    wMMOhUuC92dlgPZG6NRcoRPZLGHiD_AxVmq-3yDEACtANSAvK8jaxQM>
X-ME-Received: <xmr:QMCZaoN2EjtXjmW_9LGQ3KfnGq6efUM_WY7yPVQDbtkANJqji5gjw-a4_XbUY4Ie7EHYrtspwia8mtg8uve76Qkf9sGwJ4IrsQ>
X-ME-Proxy-Cause: dmFkZTGRO+n1Lykf47EdDJEM+UOalSqk9MoSx3yBszkDRBmcG2ia7nngJWiMsrdu7BwLlY
    1qJ9G8uNszCnLTfo/wUBGvy4Z4wTXoh5oyA+S0EE6VaCl9+COd5sCSWoLhjcBgnQ3bik6v
    PEDkB5KDFSe7jjMFgK1eFC/3lF94NPR0oxZZYDWl/KmKnPb69LHwgr2zgN6TK3cZ7Bq8lo
    mDaOtP/0+evyJ8wFb1thQ8vRZKYWbiRMhqX2JCvP16tBcNfJjaM2Ks7Ts2btaPJ0bILvGm
    XGpTw57NPIs6dxhql3UYNuPXi6kAdQpBoAQGdq9FEFkWvNSNH3Pc3e3e9AXn8fPUYhTtT8
    Mp0vBbXVhZLTICS025Y3JP9sM7fU7gUwzIxpffT/8ZEcvHJyYeHLzDgNusP153muhBgnDH
    QYZMFreM7M+rkVB4cbWU67yfca2lBZd523AZ52+oHZOGHN68aOsZIZR65IJwNMTmfTGS26
    FQ4b3AQ2KuGRhLZ3xEiCiB3C1O3JrL38tb9NSeT5hr2ZIiVpjuL/mWZB0nhW9yUzgY8mmN
    h0YseLWop0nBtlw8yY9f7aWKTstKWkoCpjJT5Ix3mHvm4lsRh+EkFNe1fRXfIFDOWwJnHv
    lLh/gKLrb7/0vYlZs5CbG15lsi99dJhaaCFoobn/WQym2WKxl2RS9dFqxBhw
X-ME-Proxy: <xmx:QMCZaoSXB3zEnhj1zLe-bAzG-Om9rM6Da4NlXJcjLWrhodJZj6fuCg>
    <xmx:QMCZamjqgS0jc5FraHZvLDeqF1nP7qIrywuX_rMcRTwEMt7bZWLFmQ>
    <xmx:QMCZah9d-u_DWK3JOxm7u8qtfBrTGaVjWf3vQf-K7H0_C2CRzsFLhw>
    <xmx:QMCZatH23-WIHvTL3f2F8INdOxaCJx8Jwy6oOLBI1iD1cu15MRVkIA>
    <xmx:QMCZasTPVjzTCfLShdKeiwnNsPRnOK498PolQO2DBG8kOEC1T5v58w-6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 14:45:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence.csokas@arm.com>,  Kristoffer
 Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
In-Reply-To: <E4F5C2BA-B083-42F6-A7B1-93A5FB984604@gmail.com> (Ben Knoble's
	message of "Thu, 3 Sep 2026 11:14:05 -0400")
References: <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
	<E4F5C2BA-B083-42F6-A7B1-93A5FB984604@gmail.com>
Date: Thu, 03 Sep 2026 11:45:18 -0700
Message-ID: <xmqqmrtyb2dd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 3 sept. 2026 à 08:36, Bence Csókás <bence.csokas@arm.com> a écrit :
>> 
>> ﻿On 2026. 09. 03. 10:38, Kristoffer Haugsbakk wrote:
>>> Not a bug (2024) https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitster.g/
>>> 
>>>     I suspect that it is much more productive to deprecate and remove
>>>     "@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@"
>>>     does not act as a synonym for "refs/remotes/origin/HEAD"). [...]
>> I would not want to see @ removed, I have abandoned using HEAD years
>> ago, too much typing (especially if you want to express more complex
>> things, e.g. `git range-diff long-branch-name{^..otherbranch,..@}`, to
>> pick an example out of my bash-history).
>
> Ditto, though thanks for digging up the reference. It will surely be important to justify when proposing to tighten the branch-mode rules. 

It is very unfortunate that the quote is partial and incomplete,
though, and would not be a good input for people to decide on their
own.

