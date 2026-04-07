Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FC1A682F
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775600650; cv=none; b=CPFlO4XCgSmCrEV25MGCrkuQ7P5IcNNHti47y5Dh8wBBa95G7MrlvNRPnCIpFEkjESUbMXfJMwXqaTV1kz0oX1oMDkKFnG34UCewGoy0jPi+7LY5Kl50tvPw5JiqaomWqKYvkrPI4McUPEZOw8t2FRcPKR63B4R34O5rCRHEEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775600650; c=relaxed/simple;
	bh=Bd36zuqnsJIkOaT4tBKFxcPVegMwet8/GiA7LlHn1XA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBhQTdn2a9pLsgAKjhvmPn4eP56UUxEZQh5EQMMJKcgI1H9sXGTAGkaR5exUfyWWd2w+vsJvQdmrMdN4aD1XEgLysnz0N3ovJhmnX0UE/h7VkCSMZeeLNDwaXsjqWgVBAX2hNQb8YAPD4EX5plgSVYrLqJVa3tqnZjem47f3X60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jPlTwTUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OaFLDbIy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jPlTwTUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OaFLDbIy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26D02140008E;
	Tue,  7 Apr 2026 18:24:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 07 Apr 2026 18:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775600648; x=1775687048; bh=ZH16zUs211
	JAKvGXeAVWsW588cgMCUZ9Fwf0R9qLIt0=; b=jPlTwTUiNdK9g7THMJ36Jgarjm
	rjJ9w66XAJ9D+eaGBVJciiKRLmLitay2gi/NW1pZHgtWVFFVhklkWZSwM4k0scu9
	Pe2y4Swa/oueO56XRnTJQrk0qAjSFEOnC/2d9pgU1qDkbQ5Fvd8x/e2zGFudWFNT
	Y+YlxbgkRY/En/raTWBGU/j8baOPaHzOKqU/MXWIZsY8mbn4uupUMQFkNv4KhCQz
	MV9XrHz5MQE0Dl+dLdab0ItARxyrWKw3a+nfua2cAjqoLTJ/iATeM0o5U6iQfu+/
	5HeIpQBkyhQoFM5LIL7mNGAjj1UAahhSUauSFNqYd5l5PBvHqx/27+OegVrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775600648; x=1775687048; bh=ZH16zUs211JAKvGXeAVWsW588cgMCUZ9Fwf
	0R9qLIt0=; b=OaFLDbIySXpjJ2OYz19M/ccfEYm8dRmu/8BBPUCtS3XgC7yIlqv
	vwtDBE7vpjMCl2toZ+Pw6qRYHU4OGEC082+RHqtWdHiYj4iX1rUzyWioqdxpxnQ3
	hy60AgPBZCJLzllYM+6SyBcnPnDEPgLVuBNXSoFQGTI9Y/Dx8Pb76kHvIsnsl3L9
	XsEIYC46GCk9E8yglUxDKeBtLl998Ydey+sH1wfGZ6aI3yZHaPemQCsTdcnp7isk
	yCtuTSh4g+ByZWOLoKve9rdMbcTrA701LWA3+R0eH8HILd0mjoFF5JJYpIXJixuf
	kMIkJMCesNRRYm0g4r/71DVktjGr7bQmOpQ==
X-ME-Sender: <xms:B4TVaRPXrfZyl2TSJ85YAz9c-Svx-wRDdDruQfbae8GjARXfy73Vwg>
    <xme:B4TVaXrmNO6W_pF8_zUdGutW-Mnla0jpz-MF9MlygWdZFgFsj9gWmZNVffTiukbqB
    Ztodt8nzLR9LuHqHb2BmGMy7UvCNm7lxPxAyqqUDC82wSu37NtBXQ>
X-ME-Received: <xmr:B4TVaaEY04Bs1ZmmPhfCWP1IIYraQxu2dvqit9b-zbdy0quGv6FKQ2AeY5urx6yc3epCkyhn7uSUPJDG_pBlvwtyMT7ZTVhYHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheplh
    hutggrrdhsthgvfhgrnhhirdhgvgdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:B4TVaUqSW7gCZHkmXVUbTZJl7-Cz9djHBTrAOydDVOMPxy6n4zOFIg>
    <xmx:B4TVabaUGTOaEWfwCR6weou3KjHyQI3Y9ekId5jEQgm96s9Xw3jqIw>
    <xmx:B4TVaVX0dzic8jDO3vt-yGIQmFavCadbQwnkPloYg0BvUyLb-ukLcw>
    <xmx:B4TVac_c-9I4aIvKIJQAyQMH-6UEL4E5r__98tCOKIzDEB03nmnvvA>
    <xmx:CITVaV95NS9dXCIKHVwBtOcoCN9KfRwJzUt1FNqQz-_DD4woQN92-z5v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 18:24:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  peff@peff.net,
  luca.stefani.ge1@gmail.com
Subject: Re: [PATCH] object-file: avoid ODB transaction when not writing
 objects
In-Reply-To: <adV-NI-t6-jgJK7D@denethor> (Justin Tobler's message of "Tue, 7
	Apr 2026 17:08:54 -0500")
References: <20260407201730.2526914-1-jltobler@gmail.com>
	<xmqqo6ju31wx.fsf@gitster.g> <xmqqfr563099.fsf@gitster.g>
	<adV-NI-t6-jgJK7D@denethor>
Date: Tue, 07 Apr 2026 15:24:06 -0700
Message-ID: <xmqq7bqi2yux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/04/07 02:53PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > I'd appreciate it if you can give your eyeballs to the attached to
>> > see if that is how you would fixed the bug in the original context
>> > of v2.52 track.  If everything looks OK, then there is no need to
>> > spend time backporting on your side.  We have everything necessary.
>> 
>> Another thing.  Your jt/odb-transaction-write topic (in 'seen')
>> already addresses this issue, so we may merge this single patch down
>> to 'next' and 'master' first, but the merge that brings in the topic
>> can just supersede this patch, perhaps keeping the test added to
>> t1517.
>
> That would work :)
>
>> Do I understand correctly?  The t1517 part of the patch, when
>> applied to 'seen', does indicate that the problem is not there.
>
> Yes, that is correct. The jt/odb-transaction-write topic indeed already
> fixes this issue. The patch here is just a slimmed down version of a
> patch from that series.
>
> I can also send a follow up version for the topic built on top of this
> patch if that would be preferred. Otherwise, replacing the patch with
> the original topic and keeping the test as you suggested would work just
> fine.

OK.  I think I am almost done preparing for tonight's pushout, so
please double check, and complain if you see something that is
questionable, when it happens.  It probably will happen in 2 hours
or so.

Thanks.

