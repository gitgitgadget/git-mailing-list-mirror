Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763002931E4
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688555; cv=none; b=AcgD/VTLUUBai4mPvG9+Pwr/vVORLkv9AWrv0GsEd6v0R7WxCLaGj07ii5BPaIMFBRIj+MHaUSmEBTfWaVYaRcJow6tI3435RioO5KuB+V94aoXZbXvKytlQ8XO4u6HCAlR1AIq6fTmT/aE1hH0botescfhE2OGiuK/7d6uPQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688555; c=relaxed/simple;
	bh=0p5cW+aPrdrYrq8K9PHYHB3mRsYTDCCaSuzWNvxQwWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uFBkDKFDFC5TwV50kcT8UkO0Jr2r0OoCgYC/ihy08MExnQLVzql1ahwRXhzJO78s691GJF8vr98YELxqZsYN80r0bdiq+/gpB8R7ihdpY7nXaovDD1f0yb8B1iN1wIewrpjzu5wAEqZ3T0zZeB1TV+nGbkeOFANOo0vhYP/ZrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YsDljz/Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6cj6DNm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YsDljz/Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6cj6DNm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A405D7A00E6;
	Sun,  2 Aug 2026 12:35:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 02 Aug 2026 12:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785688553; x=1785774953; bh=0p5cW+aPrd
	rYrq8K9PHYHB3mRsYTDCCaSuzWNvxQwWA=; b=YsDljz/YAouwsLsKq54rAk4KjA
	W3BdDWVFglFXx6KmPoHCn+CDoc0nW7NIStumTBflv5M+Pdaz0i1UVhBORe31dX0D
	4HjdixNLO3nh61NwpORjamSRBGMqV/0xUB2zbCHwtxx0KjjNjktgA2nzWYzG72lZ
	Nee2P7t2FSfLtou6dcq6zJR9qLZCiYg/Mns20+t7a5ZqCEM4yQq7l0LU3nJFdHip
	ifi2+ThyWLlhNuy3YmV0YALbBsFG5z/md0r6PlHhhQVfoIshT2393mGl5FFCCcGW
	tZozWW33lLU6IEpFItD1ASjfeZZhf3uaw+Gridf3w4hg6epAD+3JsQmxPd+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785688553; x=1785774953; bh=0p5cW+aPrdrYrq8K9PHYHB3mRsYTDCCaSuz
	WNvxQwWA=; b=Z6cj6DNmrQOQoLw1F0qN3BircL2ZzMn3ToD/7/EPoDW+MVb9hjF
	grdGVEhT6YoGcjnUg7A9L7sj+sgtratsjgIzDq2OsczIbboUzIrVl116KHkqxyHp
	v1Or2Nv0mY9t4Y0JCf+Uq7a7QP8o2/47RDFYGYhOEDj3sIqd3RDt1K5ks95hohHR
	KMjo5Lc/gONOAmd0VygtsqPDoZDrU5hHqA1jLHoPm0//gLyQRNb3y/EMWeObXqJO
	SUpAZF5U6PnseITLMJymukvA3eWx36mDU6akRoXkHXNVMLby6LLHPv2LJ/YdNibm
	jrYUEngRL9aeALUye8nGBwPCz7UhM0xkQhA==
X-ME-Sender: <xms:6XFvatS3BjDpC6KzCxPRmV_B8x_V0tjSJr5iP_cENXg0QIm9AQXSNg>
    <xme:6XFvaqf-5cKCRjd-nh_js0AvSgG0O9LvS4NgNCxsu9tp_JME-WHdYGYzZ0bm7nv-U
    YMhZvmzThe-sOUOQaIY7Hqot1ZZSVREbA5wZ-c_n5Zbrp_YQFUT5jE>
X-ME-Received: <xmr:6XFvasrRbnsPLxZNb0GyiBDsRfl6biTZYwUGZBdQ_i_PPjKHo886QIufIV0sh-aCLBU7CqslAKISLocJXWvxKIGFOP6mK0oovw>
X-ME-Proxy-Cause: dmFkZTGK/aYvaRhMK4ISXIL3+RzZWP+v37bSjv7X+gedSJlFBJU1OL57GHnVmxUj0WX7tf
    SknXbpCwPyvFr7fnGEUTTs/ArhCS/p2IgmMhyzzJ9nl9w0MsaiQhEjNApZSbBu0X6aPU0z
    lbyxKmHmJkvU3VB3cuz8Q9GCH3SnoNwZKTj7qHFrpY730RPV3DW5XprlY1bs4n/PlG7Wm/
    BZjFaEnqZ4NsyHi0ICiW3i/klUC0b/ibv9O+FB/F5aL5vGKBZDSqAbgwuqctfyqBdsAidN
    meEn3MyEaNdAwj4kXAqQB+k1QS8PDgElS0hWl4jWMtai+4M4uS6xPeA5/C1zsS3GVc3vO7
    WWnJyFdEaIDkmzcOuwEfFeJEVW4mPWmhUHG7GbE0WFw3v3V33rv49i+ix0nHZNklhGfxX/
    y+q3a5uAEU1nD/fyiWYxwW+lBUG+qgTMheVK06nVUh+7HDa466yBGB3rtmt1W3BvmxYjfG
    NFLPBobkzeokDF67ArvUeYIJQjXQGCQmCH2HZmDJ0vk763W1OO40PHVyPZD2AsbKJv4/ds
    72eKlpbsVfw+s5cZi/jhtrG9tL/keqJuB8LWdRunroguTtgsCcCF8Kh3TmwfsClHNPuDQy
    lqawaEBlZyFYea2F6NrfrxncxYJeDyLChZa6zwFC4/C/VSt3TNqka/eDVbsg
X-ME-Proxy: <xmx:6XFvar8-0JRXYE2-rby7w2uRZu3Gu0NM6b-HvfZAxaI502G49Xz9xA>
    <xmx:6XFvaocglFXJl9oCEyzYnj8aW3o8rWQnQfRfIXvxMnB5qHtU6SvVEg>
    <xmx:6XFvalJC7yJIrRfu8dz6OdiPGyW0UWjIpBtHHNYiEGLHBEd9leI9ZQ>
    <xmx:6XFvaohfFSOYsHwRQcMo1fQwcNNWquQ6mZiPmKnAJBVS6hD9v_EPEQ>
    <xmx:6XFvapCFvaBS-dlWtHdQPl0_KkGKVvXdYA2xdBI-0fkvTooizGZ8Sl-I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 12:35:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  git@vger.kernel.org,
  chandrapratap3519@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
In-Reply-To: <20260802154309.GA17844@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 2 Aug 2026 11:43:09 -0400")
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
	<20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
	<xmqq7bmaa0sw.fsf@gitster.g> <xmqqzez67yg1.fsf@gitster.g>
	<DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
	<20260801231437.GA2097059@coredump.intra.peff.net>
	<20260801232941.GA2097163@coredump.intra.peff.net>
	<xmqqpl015lfl.fsf@gitster.g> <DKEGM4BYZ4UW.UVJ1H8IGVF0Q@gmail.com>
	<20260802154309.GA17844@coredump.intra.peff.net>
Date: Sun, 02 Aug 2026 09:35:50 -0700
Message-ID: <xmqq8q6o4h09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think the "after the dust settles" suggestion was for changing the
> interface of "struct object_info". That all becomes moot if we stop
> using it here entirely. So I think you should proceed along the lines of
> the object_info_results you showed above.

OK, if we are not using object_info structure at all, then I do not
think it matters all that much if it is a struct of arrays or an
array of structs (even though I suspect the latter would be
cleaner).

But I'd rather see it named differently, leaving no room to be
confused with the existing object_info structure.

Thanks.

