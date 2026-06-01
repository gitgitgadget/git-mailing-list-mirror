Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E0258EC1
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298093; cv=none; b=FdvgcKKiEr6pFqCDdHP9QoIaJ8Z7VJrNMSDDf9rGMU5hiWuwItDz4Mnj6/gScpKcBSxN5WRrBm+nWyvWNMHKToCL4lCa1f3o6HTGuMN/0R/8qh74/HRFyVhIn4fOWkbI74KQx18wyyj3ZCNSNpAvitnqm3957+OieF62Ga/Na/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298093; c=relaxed/simple;
	bh=Wi5cel/TL1pH4o+SruVniERNpr2T9RbybXELQWJdfb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p4wfd628ACx1mRUCDiBg44iP21oP3H8jPb/fNtjCj2W+Mny6VgDSAhIyV5/FCohKr42GHILVYRwLKYyCtbhKe55yA1aqm3EhCvleAZbVRdXAlqAHu5wpA+Jh0M+bw/MQM0NhjdR4FsNpmQpg7qnXGV75DgyFEHsnok1vgZF5rxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aM8rmJPF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=do9n2+yL; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aM8rmJPF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="do9n2+yL"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C9D991D00245;
	Mon,  1 Jun 2026 03:14:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 03:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780298090; x=1780384490; bh=Wi5cel/TL1
	pH4o+SruVniERNpr2T9RbybXELQWJdfb8=; b=aM8rmJPFvFk6ab57heHcwNDkNN
	xhn79mrHUzql/XFAxSeshVpjBGNReq4Tl16z+r01kChbFkk8jXU7p2DvAdrDp0zj
	unOxPwz5SObpk5iwsLDjJoJNva+rL96CZgX2zHWlstksWoKrVcCD1VPYnM3T+TA/
	JfmR7E6GB5P/U4PNp7ok4Y6GHY5p8FjqAA+OqfvJ6DfKrRfqOBsI+L1ZYr631i1/
	rt743LP2V7d0dmNvykKvGkYHM5tW8nLA3c/QQwmbbQ1ESDjR519NUvJe3ugzyGBw
	dfZm0s/Q47nNV5hCG2wHOnBLLGU9PxATxVMKC752ywgXv8IXAcP9E9eSPi8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780298090; x=1780384490; bh=Wi5cel/TL1pH4o+SruVniERNpr2T9RbybXE
	LQWJdfb8=; b=do9n2+yLvVjpPgaGBIpxhY8juNm61jIZ6IKNUBs4ry8siHbBwOZ
	MwkPG0WyFrRuqmmUhbkbGBGbKUyi6pwSUp8tDkMA+R6dHgfKiEdW0UcV34l3pWkN
	d/pZUmSvG5KYfdufIoo7U5GgUPM/3ql0bq5SAX5A2Adx/kCkH9GCq1X0xbFIcToC
	YVfkiDr6v6elsFnv2zRcEgOeyAXg9EcaDvOryBJpwZsj6nW4RQ0HFzzhPNNLx5MD
	qCJpSazQgC9YSV/rsWtYIqrXbac1wmJKHvidCHLQ6Qa/tqF3vBdCsvcXenHBBNgk
	p5wP3XQBZiRJU/wx5LbLFZG3ZOWIX8JIY6Q==
X-ME-Sender: <xms:ajEdaidBvTleJoZczTLvrez0BDd_OLY7PrcZ7xItlQMwkQB76UFhYw>
    <xme:ajEdav4Ig3ehLsjCyh8VUetgDFgCG0fV5oy-fjbxT9vM0yeaJ1nKchYcbBLwrehyA
    L2--jqzm99lA0ml59LKjEtb9OHqVFYTiiEHrd-VjCd_AbYkMPri8g>
X-ME-Received: <xmr:ajEdatViynMRBbHoRy0pgxyTfmO3tWWnBEaIrgnDaa9LU5pG874hOHqYFvPtFtoCKn39msOxSA2CslyTDluiq6xNcxMzxHTIAdQ5>
X-ME-Proxy-Cause: dmFkZTGjvkFuTOfq1UNBxcXm6+u5IirxoxNFTJ+u9UWpFgdE64H/ZyOSBCU5kg7bWj+6OI
    tKDgFdYylgE5a7ucy2xpnMUVjiRH3p6UmGoBhifzGeWINaWmlhX5EYkAWrQry6asEF/Fbn
    ctOUBet+3YNt+ryTEH20ymjfS5DyKZ6NX2Y/29WhWP5tQqCkKzbRQYscQgO4S4dsJvlWP8
    VQFKA/QGPV47kg/XfxYAyrBVhT069zykqf4rTwmdT23FKVShSGq0IPIt3xt+r3W8r1bHfO
    C0Of5krJ4zlkMqZuNikNNaou6/xH9fNdkDf5qnhFXffr5hAOm0yvPeaDseINCSAtZ/77tm
    GCyPJjYZpAFVfxWRav27LPlaV0PjOOKi80vCdO8yCJ0rdx+CeKgzBQg4lYb+q9PulhnSzs
    c3glaUwa+LdlnyvlmdRKbpyczh5UR/vilFpvaBGCHPKTL/U9jF/Ll5mrUjJyWnaAJ117X4
    WghnDxobEZaUjw28P5kBMo7C39Mv5sTyuv9a3bxU119O3EHm3Mz+PJnxtYY/D640wy94II
    i32eqgHgUDHTNlKDdAG461RUNSyYGrWP+2sQK8kf9uuRx6v0tmWGFvjyyfHPo2cdIr1hjA
    hVHZQFcg349svJh2EcRTDDiCaqP9iuP93NdT7l8sRgFv7iDHVRcGNvGnuSng
X-ME-Proxy: <xmx:ajEdam7iQNgsaCn7O5vF_1s9-ICjhU7iaLrydi87LxEV15LrqagpGA>
    <xmx:ajEdagoM7eZzUmuVGzyOK2_GjPMXYusZLkn_o1VkIrRqqMEdn4KpJw>
    <xmx:ajEdahk7J6A_eODAZ5Q_8MmkErTNgngV9gU4icVXrFr4EPP7GFlZVA>
    <xmx:ajEdakMW4abxw0eDG2W6HiL8u7S2h1uen7FJHTiQeYoqw2ZPXveZzQ>
    <xmx:ajEdar5l7loFAnhTLMaKmywtoFU8jjLa9sqsvo2fNrZTQDZH8SboN814>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:14:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: kristofferhaugsbakk@fastmail.com,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] commit: remove deprecated functions
In-Reply-To: <20260529083716.GE1106035@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 29 May 2026 04:37:16 -0400")
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
	<V2_CV_commit.h_remove_deprecated.732@msgid.xyz>
	<20260529083716.GE1106035@coredump.intra.peff.net>
Date: Mon, 01 Jun 2026 16:14:48 +0900
Message-ID: <xmqqa4te91g7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, May 28, 2026 at 09:00:09AM +0200, kristofferhaugsbakk@fastmail.com wrote:
>
>> Topic summary: Remove deprecated comments that were slated for removal
>> after Git 2.53.0.
>
> This looks obviously correct to me, but the whole topic made me wonder:
> was it worth retaining the old names and deprecating them, versus just
> removing them back then?
>
> Topics in flight would have needed an update then, but they did
> eventually anyway. So it feels like the total amount of work done is
> larger, compared to just fixing them as the topics were merged. Either
> way the compiler tells us, and the adjustments themselves are small.

Your alternative approach will depend on the integrator doing all
the fixups at the merge time.

The amount of effort required by the entire community as a whole may
have been larger, but the way the rename was carried out did spread
them thinner.

Admittedly, with help from rerere and merge-fix mechanism, such a
"fixup at the merge time" typically needs to be done only once per
the other conflicting topic in flight, but still, when constructing
a workflow, I try to avoid having to depend on the single bottleneck
for a task that does not need to be performed by the single
bottleneck, especially when the single bottleneck has other tasks
that can only be done by the single bottleneck.

> Not a huge deal either way, but just pondering for future such
> situations.
>
> -Peff
