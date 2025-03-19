Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B322F19
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742345576; cv=none; b=DjaTTFiLOEhvvT3sEx6c8fphNrAjahmYBqsANP3sVJSI6LxrjyWaC2gU3sqQ0eF/tLITRMe75d0PLy2Ppfn0DePo+7hWu/crVa9tjtMU69LhAR6m+mgfPD2NkzTWv3W22pUaRevONaErwgXU1PGVt3pq4AFoQus/JEQusPympYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742345576; c=relaxed/simple;
	bh=qwpXKbM4H32YGkYWrq/6lriG5NiEuqv50f/jj4K9kgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SJEPc1pBrNpwlyKAhJbCL7YvNn21lD0zUdNOYtx9DVKWkYlwGZCASEkPnbYfsC4EVQjdhggD0DEK8pe1MK4R1xcArbZtnr9HOFaYeAuThTp2QSKxyM1GER9wFhsD8F1UhHjrBw2QoHN+BBsI70RTwxAkpzr/tQ9Ln2+7Qax2EgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hGcE70vQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wHHnpwJu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hGcE70vQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wHHnpwJu"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE4672540160;
	Tue, 18 Mar 2025 20:52:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 18 Mar 2025 20:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742345573; x=1742431973; bh=/II18qX2Dm
	8O4CxsPLht+RtMDZpI6uyM+m+Zr+PIB3E=; b=hGcE70vQOm8ygx/NYR99ry03a3
	neWLHmcYA13FYNH6xulVxJZmAUs1EyN1shQH5hi+GS4hU3/sSeajNMoaG7QL+B0I
	RAWVQ3BPUYGfeW2Taxje63kG917v8svW2mRwVb+fUItHe+sZpVNK/fKmGeEDw/c3
	w5YC1kTRAplwxia3d0JmpmNLdSLfmQ9pYqE9JAuIiBM1hhIaZI5UwfLT8Te3iZPp
	AUzA31QBB2svC1+zc/pmra9Cl0pJEFg+m9z+KXCj/JcrmTH3YM9nCPil5saNRLI7
	rYtxXZpAOO2cjZiroST3CobgWbItvKAY58p9k2rqS4cJQnVJqiUPzh2hkl4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742345573; x=1742431973; bh=/II18qX2Dm8O4CxsPLht+RtMDZpI6uyM+m+
	Zr+PIB3E=; b=wHHnpwJuzwzPIr9DpJkr4Wp12PTbtL2pn8zlU88yBcMUL0QxFBz
	tEoGo8xfX1IuE429Sikp9jEH0E4ALUB9XQtQgbz+wL8rKKP6QJ1h5BXxi2aTC9gc
	tusJ36Z4HNzwDTnN4u+2Sv7m0PA+0LQ6ml6/RiiyDlim2YBkxYuy1fcZKgqF4iBU
	7UDdp2yIiCr6pfSjA+C6PEZ1GPMOFA7XkdfPh9SIRY7RPVprWJhmuU6w6p5wNXkL
	Jy5ZKtl76oRHkkeQFNWGgun+rsNurmeXGiPhg0blei3iUoZh8bSMA55ifN1822+P
	q3dqQXwi/QjNvgqFiZKxqwiCP+gHJD0ULUA==
X-ME-Sender: <xms:ZRXaZ_dDM0Qu77fY2exR6Co6M3RfZMwR8f00JmDjhF1sIwcYwdaw4A>
    <xme:ZRXaZ1P2jTqq_5Ai_qMVj27xtHdL-dLSNmVyQ33l5oCJJL9hMtyZVJZdvA8so1MR4
    VqIGsAhLNnFsSXnPQ>
X-ME-Received: <xmr:ZRXaZ4jLpH84-YHMxJpOZD9JNCDGFXR71hBbZUSpwoSlFRNtlz-PI0oj3uweU22Bq7UI68eMo-570eIPmqhGTeyYOuYJdv0ATs3Lcv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehtrggrhhholhesuhhtuhdrfhhipdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:ZRXaZw9FSj48XSbESMkdej0gPEYqDP08WGH0dHuucIywAtd1YVWTcA>
    <xmx:ZRXaZ7ulwic57nBqNZz1lPHfmKIzekFRszwLj6GohM8QJXuiXG7VNQ>
    <xmx:ZRXaZ_EuEULVF7gFBqmA2W_4c2nmeb71fgwxYjc6LWERHa16TGcBDA>
    <xmx:ZRXaZyMUR0jD53H_Kryy-q1CjUzPumlD_N_TwucSopQ1bRMHSRIoDA>
    <xmx:ZRXaZ7Ih3I1QswM32L9KZ4fW42tg8Wi-DnR3UBs_CUrHjkl6o5aKnZf2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 20:52:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: use raw format for notes
In-Reply-To: <20250318.233012.1423505396684882738.taahol@utu.fi> (Tuomas
	Ahola's message of "Tue, 18 Mar 2025 23:30:12 +0200")
References: <20250318180251.3712-1-taahol@utu.fi> <xmqqy0x2yr6b.fsf@gitster.g>
	<20250318.233012.1423505396684882738.taahol@utu.fi>
Date: Tue, 18 Mar 2025 17:52:51 -0700
Message-ID: <xmqq4izpzvrw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> From: Junio C Hamano <gitster@pobox.com>
> Subject: Re: [PATCH] format-patch: use raw format for notes
> Date: Tue, 18 Mar 2025 14:17:32 -0700
>
>> [--] more importantly, the contents of the note loses its crucial
>> leading spaces that makes sure that any random lines in the note
>> that happen to begin with "diff", "---", etc. are not mistaken as
>> the beginning of the first patch.
>
> Thanks for quick response. That was indeed a compelling point.
>
>> So, no, this change is not a good thing to do, at least in its
>> current form.  Besides, unconditional change like this will break
>> existing users.
>
> I see that similar patch was proposed in 2017. I should have searched
> more thoroughly, I guess.

Heh, your archive spelunking skills are far superiour than mine, it
seems.  And in

https://lore.kernel.org/git/xmqqingw8ppj.fsf@gitster.mtv.corp.google.com/

I see that I said exactly the same thing to exactly the same patch.

It is not to say that I've been a good person to be very consistent
(I do not have to be---over the years I can hear more opinions from
others that may sway how I think about the same issue), but says
that there aren't new arguments to sway the old decision in the past
7.5 years.

And exactly the same way as back then, I am open to a valid argument
to add such an output as an optional feature if there is a good use
case for it.

Thanks.


