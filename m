Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326A3C8C71
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710625; cv=none; b=s2GpsiPNEe8bHN6CaYhq+lwEF32V+3y+58lDansD9HXgXDOT6w6xhhCbXcGz7hpQXMn7JQchguNAnNJtXuFyWk4laIMlK0wnQ1kyQbftiWrJfbKAWcrEpkS2MC9UquZ0BOGLEsm0AEpF9N0qHaGdteoXIlHCKD2sbNNql6RN7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710625; c=relaxed/simple;
	bh=9lscgxGxbfNcEzWvXS2yw7W2yuietbOGfDvOGhzZpxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jbczlZ75zC+qYXGCgVv8G9rTx1usZdE6wx18u6RxJCRJ47TDq6M7/akkxGn/xSHW6JgDs3mvecE6R3h0dFc0kHDFeRRSS/u733mvrgXxnjI4omj8WJ28MSzM8X5Tv57oSGoyjk5Ll9FCbYiZ4ZrUTZINsJ7KkJzRuOx0FfB6ltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cVK2obD0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jvg7Suzb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cVK2obD0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jvg7Suzb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CEC57A07AC;
	Tue, 29 Sep 2026 15:37:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 29 Sep 2026 15:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790710621; x=1790797021; bh=hjOBITdF+I
	BRIzovbPSLBKVBiyXq8v1/A+Qoo9CBj20=; b=cVK2obD0sicOa8RyVDjHWaabwj
	oHfXBk+T9HbPEBdTuI5SAcsUHnjqL8kIUogzDbkUCF9DfYvK3Mjwmu8kxB0wXnWM
	Bhby0LwNubeIayXTcsnZkDoFnNqhtczpC/18iJGYkDPPDSkvvHRtUd7grpFMdTA+
	PMFLB4RlN9+hJ1qs/vnDfArmP9uJV4UUlP/57z4c0UMfPRUSvNhOv1crmvUcHxJc
	ljgyO+i2OSs0WuXOy83jBiXCgSn5D/fDWoQqrle8RzBPZDaS7cJ5/3GbQ6Vz5V8S
	rfIjEAGgT5XEgnNS0pqGiY7Qwim+Y+6PkbBaPpyyopgaGa2J05d1iCeFjU1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790710621; x=1790797021; bh=hjOBITdF+IBRIzovbPSLBKVBiyXq8v1/A+Q
	oo9CBj20=; b=Jvg7SuzbJToPFB3hmjOa5bqrSZ2whAgECVA/S7iXw9lTrlxAumj
	dTemS80SaJNs68fUhubNfn7z4RDu/Dp5jq4XVFUKCvYMvlJHHMK4muoKp8yh/9JK
	nIQK5ZQd4FwWY3TasD09ul/wfAHDlrMIAVcojqCEZ5GnVObXjM/HpIJ7UZ+U4kkl
	BRA4hmiKZ927FqrfmmSUVxonq64kU3B9XhcR4ryNB2aV1+x9gS9NdM2Byzho6R4x
	C8+R2EDceBNJ1YjbrVlemdQ1F7WG+cyrRY1RWcjHyGYwK4T4Fj9Tmx08zCqV/YLR
	idD+S3cWLeKbzME5JE8DXAvsFL/VnHp29eQ==
X-ME-Sender: <xms:XRO8aiPivsn4JireN55-rbT_7aMpWdxNt75yDRURu6u6WswsDhqo-A>
    <xme:XRO8akr8Ji_cZkN5jTtm_nMQwIriCHUf81KhcfrtmKK2239TghE7G0bsvfKN0J_-Y
    3PqaDnbzCSL1LtznJ01IC82BAgs-xnUhG6e-6PbPP9fpY2W_G-fLv4>
X-ME-Received: <xmr:XRO8ajFCPyPPK2LU1q-8ciNtrv0_P-tJe_3I2mCJg8kiKw7BgoXv5TyYNKZx0c3Kyc_wJx4ws2Bo5nzN1QgRAppKvTLoJiqJ0tVv>
X-ME-Proxy-Cause: dmFkZTFsninSpRmZB5DDS+xvEsTbvutpyhYLR9OfD4hY9YNeFL4s5CTkfMavuW72Ylts8B
    4lava3Lya34bJm6kuG9nt2yN8cyDJjzH/KhcN0llMbTcvMbBnSy+a6ETAso/SLv21KbAu9
    pvnMZktE779z21fgvvNn12gmC7wdEkFW7V/OO8R4wAGZlNyONXyUJ0/qbgIqu03d6J5Ciu
    dYaLJYzDNRk2N69ElpUpIWlspP1eRTNLKrpGn7RO8B4b7JLeozOt6QDCIN+8ihPWpa0mjE
    6hUGCJ4Mb5qYTIDUbItgRkySPratTCQSKRGPIdmsrZMcbL0GhDF7ns58E7OQ5MiVLVJNgl
    bFq/hFaHDIePQ2vLsvYXIGcwZ229aMejWE7cASkB0/oT2542VhKXBUUkhDYezShqJTMeKY
    pG98/pMYKV0lfI1cGV4BgaR/J8HjJJJ7DsyIV82sRITWCgPYNw23OwPNy7Vrrvrw6uwhuV
    cCv6x95jKKFaE7CFbz3rADczcZodlr7PX97Wad1JKBiEssp4S3ioNzHbX32tT4876Gspia
    C5nrkZ2PY7msQfnIQMFWWAruhv/KpDFJR1M0pLkDEpsA8q0qIRCMyjN7ZoQYdYPj5GuBTa
    yUfqbaY8ngx+DOpOJmPeZZkCSvHozBH4KB2rQsg4MzePSGa+/BfJIAKDSHUQ
X-ME-Proxy: <xmx:XRO8apqkgD5atJ5xWDplFoLguiZ4-mABXfbz1mIG7ncUUch8BvxIFQ>
    <xmx:XRO8asZAFuH6sNnPRCjnf9mz1Vrj-G0ZnKp3iaE42HiulOnSWUDs3Q>
    <xmx:XRO8aiWXY87C4mlw_9yvUoePWLOFymtU5AW0yo1mepUHFMqgXUTiNw>
    <xmx:XRO8al8PV9SluNJh7tmRKZiaX9CY-dDFsHSYXzos-CXyBy8BI1YUGA>
    <xmx:XRO8amxYaO-vIgAto-ktdgnkRynKUgEr3hj0ohpm3-6qVsKMupgzsm1k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 15:37:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 0/4] fetch: avoid fetching every branch of a new
 remote in a shallow repo
In-Reply-To: <pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Tue, 29 Sep 2026 09:19:54
	+0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 12:36:59 -0700
Message-ID: <xmqqqzibg884.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Avoid fetching every branch of a new remote in a shallow repo.
>
> Changes in v4:
>
>  * Removed the automatic default-branch fetch. A fresh remote fetches
>    nothing until you track a branch explicitly.
>  * Fixed fetch report showing "new ref HEAD" instead of "new branch "
>  * Reworded remote..refmap docs and commit message.

Will replace.

As my eyes have been contaminated by and biased for this topic, I'll
spend my time on other topics first to let my eyes and brain
"forget" about it before I revisit these patches.  I'd really
welcome reviews with fresh eyes to happen in the meantime.

Thanks.
