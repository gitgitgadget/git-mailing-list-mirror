Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB91B4156
	for <git@vger.kernel.org>; Wed, 20 May 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259137; cv=none; b=e1EqADtAVrzlIir7Aq7F9M+MQlu5QzO3ws6B/qsisx5wKmnr9+t8JzKvKBlRYCWARbOipz8v85XfXFGzrtCi3NeWF+/8an1hjftoqW6t9ia4bmwhYVTQNH8pqs2fJ6CbJs/8wvyRzjnJ5Ewsuj9XvbWTCBE9TGd5yK9jTJzuWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259137; c=relaxed/simple;
	bh=RzRYGKDG6/fBCYVQ9w2MWb1w5CpFUaVxgNxf2UPxkGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eUkXOApBTr8rxk9T/CPERDcKfSNacWNq40h4bN23PxtygpxvL21timpne95Xl0eEqK26ZhaD3agAbWMYwWB1AsOsuZTZjhkRnoZowe+m7j+jSXhuYMBgkiJkzCkIYA8knIsOIi/Ej5JnX4cxQTgmTGRQlHB09Md206qh1I8TpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tRT3KO3r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C07c0F3U; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tRT3KO3r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C07c0F3U"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AFAC11D00135;
	Wed, 20 May 2026 02:38:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 20 May 2026 02:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779259135; x=1779345535; bh=7Qpa4MFdWn
	DwwTBXy7297iPdmvdr82D0uvz+u7Cuh/A=; b=tRT3KO3rW0jVvO9BV9sg+jhg5q
	6gEJDyja3UOXPy0ea3QBrgPVunZXRxh6SaBX+WxyjraUE1KblyoArDfEsPYrLi/g
	ug4Tu6GXyPvfHXI3CgoUusCpxH33lY9PLwidmEfIh4Q8yVf8NLoX7//muCLx0h7r
	hspGRL+wJsnF+nwxj3wXrI25NmgaDJlKXOgC7Wag91SBji3dgWdkA6G3M3D0faic
	txfedXFh8rZi3iI3xJEi+BBXwSzw1lFB/347VlRAOznTwnQ2zscZiApIcQSFdNjW
	dvinxcvzJWPtc34tUPRalU/JV5K3Gc4tvPYC+nMSvAhPLv7Si+7MP5SmA2+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779259135; x=1779345535; bh=7Qpa4MFdWnDwwTBXy7297iPdmvdr82D0uvz
	+u7Cuh/A=; b=C07c0F3UjPrIma5Lr4eme71aGM0TXKr8DxAsnNy8/+G/ZIAxnLZ
	S7M2GepSzunaFwckzQXZTVbqRDnQ7ApI7pCyMfwQwxxShujtMnxejfJn1PkkAZcr
	ZXRNvCFeIcdZkuUxXfK9RuT0YuiY7rxg3PDlkbGH6IlITn2zGvvRzyQuP3Ghu+/F
	plr8f3qhOo4E6dIHOtFkkswBu4PBYBozHrRaN3GDW4eEeadcbiVL/iHQpr8Tyy7h
	HFi9cnd/3ObXOlk01fMxchQ7x2+f+/Pv9bVNAqdXMuEFANOjge8fIWjTnQcOggw9
	hoR6XbiUhBP3+7ln1WfYamP8rHuaf/TP7qA==
X-ME-Sender: <xms:_1YNarFjdqjzJYz46wZy8GF2bdVNRoPSyoZevmyggEZ1hYc1uNEGKA>
    <xme:_1YNavxv9y7-q4nVxn2OKq_7kdaAMrvC4f8C-DA0Jlw76vKD1Ouni3cxJCGaWgVOR
    TYsBEtx6QjyHgnO-GGKodZsJ-ZJumRdAP6Igoy9TV5gMOwGZEywjtE>
X-ME-Received: <xmr:_1YNaqgexUZyC0Y3-YcsXykhpzhDo-wYtz1LL7BFtVlRuYcUE9x_MJZYPfvV_VLlFKmze8nBZPTzW5nKEmqy40B9ntXrhKXebw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_1YNaiyBIxe05pJ4nabHsgAz8Mxc2DpbwqL2kwbkY66lbWrBDUHGEQ>
    <xmx:_1YNalIDHWclKYuBQoOZBMj0DzY0gQfD6O1B61wC6XrGWb17-JppeQ>
    <xmx:_1YNahSXfy6MT5aGRbjXw47WeaTmutC7XL9t9VtdPjSFie5_Gfkcqw>
    <xmx:_1YNalpVUnrc3oeitudWENxzVYQoLwfhGqJ-w4qYkzjpqi2hkf4Ibg>
    <xmx:_1YNasghIWzw49Hc94U9q_c8Gw_WGxUunjjcjuBsNRxS6OSwDoJ2HE2Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 02:38:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #05)
In-Reply-To: <20260520054436.GA3849892@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 20 May 2026 01:44:36 -0400")
References: <xmqqo6ia4q03.fsf@gitster.g>
	<20260520054436.GA3849892@coredump.intra.peff.net>
Date: Wed, 20 May 2026 15:38:53 +0900
Message-ID: <xmqqy0he37r6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, May 20, 2026 at 02:19:24PM +0900, Junio C Hamano wrote:
>
>> * jk/commit-graph-lazy-load-fallback (2026-05-18) 1 commit
>>  - commit: fall back to full read when maybe_tree is NULL
>> 
>>  The logic to lazy-load trees from the commit-graph has been made
>>  more robust by falling back to reading the commit object when
>>  the commit-graph is no longer available.
>> 
>>  Will merge to 'next'?
>>  source: <20260519050513.GA1635924@coredump.intra.peff.net>
>
> I posted an updated patch in response to your suggestion to use
> parse_oid_hex_algop(), but it looks like the topic in your repo has the
> original.

Indeed, with sufficient amount of front matter before the scissors
line, I missed the patch X-<.

Applied.  Thanks.
