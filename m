Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D93AD51
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735838838; cv=none; b=IgQHcvc21mjQhaR7QcekUDJ5OjhsC02tQzq1V5NLXVEpDifsfQW/lpx40LdA6uwqrXgHOU2Jesbf7h64qRbyFn1B3Z/PGx7mTJXLE07zRqygnEGR05l2yqkFxN0Va47gEIxrCsMHbiDP1D/GmOlQ9HPsFzQuc4+6LjU4rl1mmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735838838; c=relaxed/simple;
	bh=XKY8jZvYqUUllqLyBbv9oKLpxUD+baR8omb0q5DYlL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u4ayGfPjmt8c//1IaMma+DOwbe9DdGyhEpUXuRY8xffWDzaRavjo4ntBjM4iKxVoDm/Ep5281Rb4brkl8z4PdnWD8+388oqV5DIHJW0siuObnJaofz7qPr0a4k+Ulx7/YFodQVfHJhlCu7yzFfk2IU9glMbkiXW3t5Du9K3+oTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zYLQtqVA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9/MOWso; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zYLQtqVA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9/MOWso"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70B8C1140172;
	Thu,  2 Jan 2025 12:27:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 02 Jan 2025 12:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735838835; x=1735925235; bh=ijzl1P2Akt
	BK5zllisgfaDBrO2ndsnS74RPWusaw+Kw=; b=zYLQtqVAhCmKfwl7+0r8T5xLub
	UQqke6OUB6ozLPcUBj/Fd0Z+eixiib2PFHhhhQ0yyqBLw2ZTkrkPxs5tmaEs7Yrx
	1kg1Yg/la76y98adfsXChZsz/TORejwmQ3lKyE6Ua1VuLQk9YD6yOvWk9wCvlOD3
	t0Gq8LVrw4ohxdA++SsdPbyGH9JeFrLKR4WDqFosEz9IhBzl3QgpOKlbD2zIlSBx
	ejxWr5ryDxVvw6jesouUn/P7h3smjsQAjV4VlRJff1AKYWXUgLGJsMv4vaf1x+QS
	KsRd5qpldwcKSkoiwQPW0UIFY24DYw0Z6xiwAui1R9C5Cq2ORC2G7hd8OI0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735838835; x=1735925235; bh=ijzl1P2AktBK5zllisgfaDBrO2ndsnS74RP
	Wusaw+Kw=; b=l9/MOWsoBElf8BRFwzTbKIjMzrByXrMFfTkJN9nE4lzbH+yo6Oy
	1sq8UPtGSP4rRgXuRZo4ZYvVkWI8KbI42K9oaBpYABvtJsiWpyeZWkLYxxPv6NdT
	OPVFKjo9hNlEGg3vmJvtIqRAXH7mZi2mX+2b9dcPOQNGh/W4xP60aK4Ib5cbPhO9
	tQ1/twMucxaSpyinyVZmuhhBGeqCS2/a/b0mJUyH+4qYtM0sr6pNecPIyzaO+t74
	MXOVWWMMjyCGtu4iyIuo447SY/FxhQVZdwrYgN4exUV9GMGiCP7WRdBs6NO3egUX
	eNOc08S2+dLDU2I7KSOA9AKOeHBUmJtSdow==
X-ME-Sender: <xms:c8x2ZxXwY6p69nhWQbZfM6Ve0FOcpV2m6tV0JsK5a7JXreInBQAKOg>
    <xme:c8x2ZxkzkidPPDOyWONYXfEVuCP5HsqS9L4s9r-VZKuSxy2NENiGeaVMY_KOjo85o
    NlLYvhBisb1WV23mQ>
X-ME-Received: <xmr:c8x2Z9aPlPNtLR0cadhxqHjjqnJ72hm0Br8yUCDAA5JtxmQ2SNB8-AaFmB3i0ET8ggve1LNzb7E-meirmL3Zac7kgFVtqXTH0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehstghhfigrsgeslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprghnugihrdhkohhpphgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:c8x2Z0XupqE4V5lrT8SnEgBB5xH7XNfLf7vXDfP6-qonqRva9zNmNg>
    <xmx:c8x2Z7k1BYjRe3kFAEkADgbjR7Z-2_Ma4Ux_Xorail2_M3qxULpPbQ>
    <xmx:c8x2Zxey7g0s7rF3zmog1K-6mQvlZKUAnZHOBazsZiJSo3__gB8FJw>
    <xmx:c8x2Z1EPdPRUPTRKrxxck2rt7YrxEPQwgHjditpELRsvE701nu6DYw>
    <xmx:c8x2Z5aEMWBkCn02Wg7xvNX8_vJuqPY2khe4AVLHaz0fBN5w9XnobbBt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 12:27:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,  Andy Koppe
 <andy.koppe@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: meson-test syntax error
In-Reply-To: <87a5c9uo3n.fsf@igel.home> (Andreas Schwab's message of "Thu, 02
	Jan 2025 18:23:08 +0100")
References: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
	<Z3ah2YQSx4ZreBpK@google.com> <xmqq5xmxwabj.fsf@gitster.g>
	<Z3avRmaMr70FOs8A@google.com> <xmqqr05lusvp.fsf@gitster.g>
	<xmqqmsg9ussz.fsf@gitster.g> <xmqqed1luqqq.fsf@gitster.g>
	<87a5c9uo3n.fsf@igel.home>
Date: Thu, 02 Jan 2025 09:27:13 -0800
Message-ID: <xmqqa5c9unwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jan 02 2025, Junio C Hamano wrote:
>
>> And
>>
>> 	$ make SHELL=/bin/dash test
>>
>> does not seem to pass SHELL=/bin/dash down when it does this part of
>> the Makefile
>>
>>         test: all
>>                 $(MAKE) -C t/ all
>>
>> at the top level.  Oh well.
>
> Command line options (which include macro definitions) are passed
> implicitly to sub makes via the MAKEFLAGS env var.

Yes, that is what I thought.  My complaint was that it didn't seem
to be happening, and it did not cause the bash-ism in check-meson
target to barf.

Thanks.
