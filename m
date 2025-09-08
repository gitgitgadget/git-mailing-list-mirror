Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D62749E4
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365461; cv=none; b=eMFRkKmelsYboB3Rlq2kYICHoAABlWbvI6sUPmMXzhwXb41+JqslRUWcbJJRCfghRNJJxL3VQ2VFI5tkzqAmEXVikO20HxGg/Fvg49Z+2iDqQD+PceSaXjPWlWcC1VGmvbcImPI04/HJBc0RjQFlcWsC2G8Weq8HsohP0yVMBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365461; c=relaxed/simple;
	bh=i6C6bJD1WsVWedD4LX+jPFaIKsz3reLVf/ErlLwS1F8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IDaABwpiZS0wyz6a8b4aadg37QUqAuvV6rNxQ3KvhmbbCOc7k0nmgd9bu5JXiAmKCmj41Uh8uV+Xn6ixCBxdXoUiwwgiLNp5ekkukUGRLwrZKwHyNUQ760rXOcv8JYcZ2a7kCYbR/vIKJD+Q32uQ1CU/hfjTF/uJjuRg4HyM0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zLLOnaSR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dgh4fP4R; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zLLOnaSR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dgh4fP4R"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CA277A00B4;
	Mon,  8 Sep 2025 17:04:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 17:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757365458; x=1757451858; bh=Su2t/uZhwB
	bChQyiFJvkLK6FdhsI0Btfj3jw7CV6YiA=; b=zLLOnaSRbiL4wzYWtDzCm51Cbw
	Cjzt/gipvThhXOBVcKisarIWvVlqNSP5xmFmkBkdXhQhPcpnUHgeP2xpfSdMNbvj
	EU7zqgdQed/4S59+kyGdbXpVyc+VNKFsjAizafoii8gaNqXMos83tPKxwNSEJFx7
	0TuqxZ5muVuPETzNwekJTmHk+FL4/qscL4AOKFNFOrbV+YuSjs3w5xdLPAJJakSI
	al7GgkvBZ7cUxyz5qZXGM04E0HBxEauZMgPSvw370Z1pQW3XkR883SZU4l2UlGKE
	pwjo3TDfaXTxekT+sbMvcQrXdId6KeGfSEdtPcsIc/q+ZXuIOUTvWkZVPqkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757365458; x=1757451858; bh=Su2t/uZhwBbChQyiFJvkLK6FdhsI0Btfj3j
	w7CV6YiA=; b=Dgh4fP4RhgG1KzRVtyEun8TkVQRaBvu8xTtED1P3qz2SlDZjA1a
	TI8Y1KHlgB7Vkpm+Izg19Yj8CtYRJaLk7+rkY2gaV6wm/M8IgtoYwROKJQLRPmrr
	vrEdXY+jqc9UqrR6orOO7I1LsUrXsa8J50oV+lEZ8REU5lPc5srN+mJpnEtEk16C
	NWZKIqhbIqz2pShRKnNmMyoKJx6CjuuyXxiYHT6TEn+/ViiZPqU1YzhnfxwmDaHy
	skz3uIi7vxtPgOmN8iOTFmGepbzCIbUAWMRC7lswl0zaMytJhKBiZbe0wpe+GwBq
	nNBTl4V4ZGHuAGBCuuRJZ9n8pZC1qETPWXA==
X-ME-Sender: <xms:0US_aAxiLF8XCQx7sM_7BUgV2PlRKEgg7Xx03elXqsauacI0M5p0Mw>
    <xme:0US_aNu8Td40YqWFP_zAHw3IEivMGMspx0M7JHWPgd9y0rQoezGD2QR8PVSqJY_kZ
    5hy4QTms1hIucs01Q>
X-ME-Received: <xmr:0US_aB55QNHszMCsNcvpG5KVQiXgZSLXjtvyNEhmVRj___yrYIb3e-8EkEQr9TPRSx96p3GEuKEam6wDFR56pfMOpWzqvuZ8YfBldxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghmoh
    hnrghkohhvsehishhprhgrshdrrhhupdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    seguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0US_aESZ1zgr02_ZX36sUCgW2k9opOmdwyzlrDrtgKozIi1bHYbnpA>
    <xmx:0US_aIpAXEVQn2epLLIvNLx3jcplwNl2GqPV9_swku0DWeeupP5m0A>
    <xmx:0US_aKIJjjiuRoz1KRQZekvhAJyAk81_wR5vaj1sW_1sc9ZHdjP7eQ>
    <xmx:0US_aDrQGpSkeJaIZ_1D26-B6CJhWpioebMGimanfVfvu_mGGGhGDg>
    <xmx:0kS_aK-evahSwOoo7S3HW95R-yrLrsnwLRSTaHWQjQewqmyWdQhZCYVw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:04:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
In-Reply-To: <abb2bc1a-e68b-85a3-2562-53328fb502c6@ispras.ru> (Alexander
	Monakov's message of "Mon, 8 Sep 2025 22:06:56 +0300 (MSK)")
References: <20250728190520.10962-1-amonakov@ispras.ru>
	<20250728190520.10962-3-amonakov@ispras.ru>
	<aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com>
	<353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru>
	<5cf47722-7073-4761-8698-090af840d0c4@gmail.com>
	<c2fe3b69-8436-af46-c47d-dde5bb037227@ispras.ru>
	<0379ba2d-837b-761e-9d5a-d65ca9d051d6@ispras.ru>
	<xmqq7byx8yo3.fsf@gitster.g>
	<abb2bc1a-e68b-85a3-2562-53328fb502c6@ispras.ru>
Date: Mon, 08 Sep 2025 14:04:16 -0700
Message-ID: <xmqq8qiowt9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Monakov <amonakov@ispras.ru> writes:

> On Wed, 20 Aug 2025, Junio C Hamano wrote:
>
>> The thread has gone quiet.  I assume everybody is happy with the
>> result?  Can we have a hopefully final v2 iteration of these
>> patches, to address the updated to the table (this thread), to
>> squelch the __asm__() issue [*asm*], and a reword you mentioned
>> [*reword*] against Phillip's review?
>
> I was expecting that Phillip would come back to the question of underwhelming
> performance improvement he was seeing on his CPU. I was working on an
> alternative approach to speed up that function, which I just sent in the v2
> thread: https://lore.kernel.org/git/20250908184939.16338-4-amonakov@ispras.ru/
> It does not depend on the performance of integer multiplication anymore,
> so it should work better from architecture neutrality point of view.
>
> I'm not sure what's the current status though, it seems nobody gave the original
> two patches a Reviewed-by?
>
> If the proposed changes in v2 are too sudden, what happens now?

Well, it has been quite a while since I asked, and the last round,
which looked reasonably well done, is now in 'next' and is about to
graduate to 'master'.  So, if there are further good changes on top,
can you make them incremental on top of 'master' after I push out
today's integration result?

Thanks.
