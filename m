Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5522B8B0
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153092; cv=none; b=iXWMQUxYUVc43EzUQOkfBB490GRPp/55OGs7RIGFQIGbWHhAHou7fWk1TRBh9HHRX1ADelQwbhQDG3Ei6BMSQHsaUrSAz0VPR2/e6oqFOQzzEvpeo1LEP0GG2lYJib0JzQT+oaaI0ICTyfvfZj5PVyMuntT2XZOy60vNXPQzPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153092; c=relaxed/simple;
	bh=1+6fJ8+CoY8jhMva+jZ1T/WJwlWDSgbb6S5KSAuEQLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQFYcXY3NQsEnDJrgnmg1WSU6ZEApSDOUHRsP+aQI6cTGGs5Kp+dkZFTB4lwiSV/MY09K7XvVIdbVHMnmIRO9eRE8oaKFGuSV+DyyVTTlPXa2EPlNM1Svi5orwZgWMpLv5nZCQfPrqWxe8TbTPGkxboRtNXGGIv/H+CYuea7J1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eS+1xRYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J23gXHpK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eS+1xRYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J23gXHpK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B27D8EC1273;
	Sat,  2 Aug 2025 12:44:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 02 Aug 2025 12:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754153089; x=1754239489; bh=tNTg8XfA1X
	qny7bP3/Twv7owuIdijaAAVKXwrFXAOpE=; b=eS+1xRYYdSQsmZ1qn3ZE2dIfyt
	Rkof5WvlGtxoZge3ziFVazL3fL+zKQ+UVRAV81EY9HxQbw4P1j85wQDfYD4xpl1W
	pSOd+/tHfv8aDytshaOsAStrqD9tgp7mkjyGKpUdT2xir7CFKu6uzm0Qj6bOlgE7
	/xtMepwcdJsXxC7uSX1FcRg5WwectWkZsK1mQbm/19xyM0C4uI3WWyg1j1wQGQdK
	g2i/v/jb2gJ16yjzg8lF9McGHOH+H1Vsi8XJR/0yCaKjh2qCHatuHQAFaVmv3N5f
	zQrCmFnFlxcEhDnK0yXebtRmBEuW73Q0VN8tnqhfbFGU9QFIsDG4LubcDRSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754153089; x=1754239489; bh=tNTg8XfA1Xqny7bP3/Twv7owuIdijaAAVKX
	wrFXAOpE=; b=J23gXHpKp+NOSKbu8EbBUB1ZE0kpHiRoNi8T7ceGgGo9W4Abtjo
	FVZO14jXKKBxMZLL+UOgoEKoan2hSF1JdoXLS4+xm7YGWmpf2j6kh8dF3cL+DKy5
	yazVSJkl9ZyrQLFmsewGvkXFWZkKOeXQcqVtT6AITwXdt+Rmv0ujqevuElIMHgXZ
	W1b//JAoljyChv2JWlMyOtnMy5C9tI5IPQlA1b3paOW6nmqIzdttPf8k6ao94de7
	WDsH0F6oBlAtockgerejV1bm1eE3by0aFDZJcZKSd/AoSLla07sv30IPDDgJzWuE
	5Oj2Y+1ELtDCybkkRAgNByeM9GsvROypK/g==
X-ME-Sender: <xms:gUCOaMbH97yWaSuWTMRck0kbfDf6TghV6D0ulUEByfeFYOERggI72Q>
    <xme:gUCOaKr7ASZrDAgmnAeHNqCVYj0TNmTbxygnFiLrHeVedUstqLiSQmnDc5JVDVg9l
    awvgLOnvXAwkU2dxw>
X-ME-Received: <xmr:gUCOaAZndUwRBjCkThXMI_MDjBCYDkn9rv3zpL-4JpFDItHAZDUYKH_JW03RK8ZNO93E9TH3qdeyYJPiABuR5kbC3hAX1Znopb3q4_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gUCOaCS9daCz8pQe9dyBYzSODT_mBUK-xJ5EXsVYOcqwRTGjZR5eEA>
    <xmx:gUCOaH5h0bmwJd_7oNcbGQawbC-YJF1WSOUX5DTGozS59_9TgvnbNw>
    <xmx:gUCOaHzAuM0slJid7giV_udWsxtU7KlPoWRYKjEqiv4KXrMiNYuyNQ>
    <xmx:gUCOaGQdGPLXaK5PqiEHXNEdSlmWQHc1Nd1yXRhZq5l4i1cJG9ZUig>
    <xmx:gUCOaKuSWxkTFj_DHIanbce6UL7fY0y2BlBvasZiGucckykdZjKZi4w2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Aug 2025 12:44:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 02/11] clean: do not pass strbuf by value
In-Reply-To: <20250802083846.GC3711639@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Aug 2025 04:38:46 -0400")
References: <20250731074154.2835370-1-gitster@pobox.com>
	<20250731225433.4028872-1-gitster@pobox.com>
	<20250731225433.4028872-3-gitster@pobox.com>
	<20250802083846.GC3711639@coredump.intra.peff.net>
Date: Sat, 02 Aug 2025 09:44:47 -0700
Message-ID: <xmqqtt2pisg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jul 31, 2025 at 03:54:24PM -0700, Junio C Hamano wrote:
>
>> This is a catastrophe waiting to happen.  If the callee causes the
>> strbuf to be reallocated, the buf[] the caller has will become
>> dangling, and when the caller does strbuf_release(), it would result
>> in double-free.
>> 
>> Stop calling the function with misleading call-by-value with strbuf.
>
> This is definitely an improvement, though I wonder if we could go
> further.

Yes, but in short, between these two

 - think twice before you pass struct by value
 - do not insist taking the whole struct, take only what you need

lessons, I happened to pick the former one more important to carve
in stone than the latter one.  Both are valuable guidance we should
give to our developers, though.

>  		nr = parse_choice(stuff,
>  				  opts->flags & MENU_OPTS_SINGLETON,
> -				  choice,
> +				  choice.buf,
>  				  &chosen);
>  
>  		if (opts->flags & MENU_OPTS_SINGLETON) {
>
> I dunno. Maybe it is nitpicking, but I think "don't take a strbuf if you
> only need a string" is a good general rule. Of course there is only one
> caller here, so flexibility is probably not that important.

But I think we engrave both lessons in the history by keeping this
step as-is, do the string_list_split_in_place_f() thing, and then
add a new patch to pass just the .buf member to parse_choice().
