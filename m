Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D6296FAC
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074941; cv=none; b=ljdy0CzEUXEvU161El3p3Tljv4SokIEsYSJl+kSikDO6i2YwlziRAYMYmXGgc483Oh8UCCbFQ7/RMAd4Qg6qKtVk3NYUpUtOYxNq1iI8y5ZyRw8vUfYaPphtZVKcH34bjm+tqSC8hYcb+6fNj230cdSRJr3fl128znfzzaJivmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074941; c=relaxed/simple;
	bh=XJIfNswd/Uqys+VTq8F/XDXKgioSqHAot/ReF/SxL/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ELX6zIzyZq0av7ly5YqW86G5GvWpMoXO6XRPFNwHtughbbUojvSumayoPdq+NwHU8/Q3JXk1LbVLuHV9Y8Pjb0H3qzBD3PbNV2KczX0zLnZLQt1x1Fk95ouzLi3Bq7mPUd+FxLXce/p3rSRUkpAiV+0HKmX8Q5yeUGRdpGQfIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Js4L9qwJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WKr0w8hg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Js4L9qwJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WKr0w8hg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 835871140148;
	Mon, 12 May 2025 14:35:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 12 May 2025 14:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747074938;
	 x=1747161338; bh=UlZjY7bZJe9FXDso/M54F8j0H7t0PvD4L0kL3k7sL1U=; b=
	Js4L9qwJ+sD6FB1EzlhSnBOIMN8UbE/TQ3cqB3ytIku0CMOgV+2oCiQ7UCJqth1O
	/XT33kUz3fP33ccTj3tbVki2gDTB3hG2NXeONEHk06bSMr2sAXWElqy0TfLWwa1b
	B807yr9/Gs28qBu94NwJBEFUsmp5MQcZSprfXMB6UVaJp08HNoc5ZBnH4ta5f2lk
	A9J+YtFK/nPR4fDKngXg+3f20BQ6LPQNZ6NL1JbpI49jwM16wi5HslHsSb4VDjRp
	Z/Vvd3dFAnrmr8Vcnss1hZ7odctReGcpvEe0Z7vP6dHrcPhm8sjXqAqMr0HXRbPH
	v1F8RTSGgxN0AxrQvc5azw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747074938; x=
	1747161338; bh=UlZjY7bZJe9FXDso/M54F8j0H7t0PvD4L0kL3k7sL1U=; b=W
	Kr0w8hgEzPjnpDyZsZW4o5W3nN5EYd0TQqZYyXQiEF6Kh0Yjh4Orn/OlC82C2XoO
	WTSt2vXzsJXK8Q+Xmm0M+4PtbtSe2pTwBxgqPV497LdXbHE1v+pupV1X0VKAFMM8
	f9V5i4FbQXsYIxMPyoXrrz5ZlT6orkLahI2SKbRFqnnhAXBKZdidU7GY/a3yAIHv
	jvRGs850DWMSagCQWqZWZ6tudFhCseWYvHnFkMWaV01NLkqQ2pnvbFs1glunTQ4Z
	pPz9qcSk5JOaCAEyucaL/XlkmgMbahq+3cPYcXxmIV41fI80EgHwskvXKNKNNs0k
	u5OHR3P8kC+OpBVpmXvBA==
X-ME-Sender: <xms:ej8iaE_GJ1Uq88YuWfeBSBRKAEm_hQ9fWZEv4GNk0E3u7S4HFTZonQ>
    <xme:ej8iaMuF5JhXqqLFV8ZqCP6mV1MGc9Irjskz3KcvMC4HXImZGHbgTHNBUgF_KCPcw
    SIeTI7BD3gOM2Qbog>
X-ME-Received: <xmr:ej8iaKCxBcLeg9Jwg-fEprjbbWCmoL8x8zbPEj0co4lWrx9WRSgKVeGUboDI36Q7gBSeU72RB-UVWnIeCClZ8iMXgi9SIdTk5oVzmWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ej8iaEfNZX6AaaKdqU3tHVSLDSgKpSLNlj0uv7vi-fu3TUi7A4Ch4A>
    <xmx:ej8iaJP1fVNe-4U3JuQfCEBczLZ29ZP-gm3fNkV0iKkt24i6Gt9OgA>
    <xmx:ej8iaOk9rhVVDE14VW1S8yH7WFqBXoIAitaR7gDTtpRgvn-Nk5dWTg>
    <xmx:ej8iaLtDOVoTWVJE6BaPJ8aJp3mj_XW6Zk7z1uPwhsOUBMARbSkczg>
    <xmx:ej8iaEb9uZTL77k9aXHnGz41OYQZoMp7jF29FVymLF3y78nup7G7Ezpq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 14:35:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] whatschanged: list it in BreakingChanges document
In-Reply-To: <CABPp-BE3Qh55=6GR7s-Wv2rS9+oAFokw=9R_1WiayLWDMsuAVA@mail.gmail.com>
	(Elijah Newren's message of "Mon, 12 May 2025 10:36:50 -0700")
References: <20250501225958.2947677-1-gitster@pobox.com>
	<20250503005814.3030099-1-gitster@pobox.com>
	<20250503005814.3030099-7-gitster@pobox.com>
	<CABPp-BE3Qh55=6GR7s-Wv2rS9+oAFokw=9R_1WiayLWDMsuAVA@mail.gmail.com>
Date: Mon, 12 May 2025 11:35:36 -0700
Message-ID: <xmqqh61psmmf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Fri, May 2, 2025 at 5:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> This can be squashed into the previous step.  That is how our "git
>> pack-redundant" conversion did.
>>
>> Theoretically, however, those who want to gauge the need to keep the
>> command by exposing their users to patches before this one may want
>> to wait until their experiment finishes before they formally say
>> "this will go away".
>>
>> This change is made into a separate patch from the previous step
>> precisely to help those folks.
>
> Were these three paragraphs intended to come after the "---" line, but
> accidentally placed in the commit message?

They are indeed meant above the "---" line to explain why this one
is separate.

>> +* The git-whatchanged(1) command has outlived its usefulness more than
>> +  10 years ago, and takes more keystrokes to type than its rough
>> +  equivalent `git log --raw`.  We have nominated the command for
>> +  removal, have changed the command to refuse to work unless the
>> +  `--i-still-use-this` option is given, and asked the users to report
>> +  when they do so.  So far there hasn't been a single complaint.
>> ++
>> +The command will be removed
>
> Missing period at the end of this sentence?

Indeed.

Thanks.

