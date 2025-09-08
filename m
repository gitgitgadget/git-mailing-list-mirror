Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F082FF65D
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350572; cv=none; b=LDKT8B+2C7I8971dPDr+JmxttBEvk1zaRbIW5H9+HalPSgUv+RYljdsF7rx5u86GzzgVMTJukWtI5UQIxhiUmmhXCtl/xp3lKBgykwaahN/rOk934hWUfPZKdtYg70XoqIZAC501pyiURi2ooAUqoJ0KljIKKw1Th9A2L11tIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350572; c=relaxed/simple;
	bh=hHQdoI4IxoMqbSiq9lQ9rSkVoBXIXy8EsITYXVJkSy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wf71gh6qY9/HzB63oWTAf+hsZPMcfgetFxVwK+QTJLax84wybID5JZwfqitTSwp3ZI4rpKmnOOh15QJeFTkZ4IwBwtEtDtrkNiHrlaDqpzwFK2A9fFmJfo/5O+a67PDYcFtlDAjsRrZlhKu0V2se+vR1b8/CfZZ7n13AnPOfxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X1/4mkKQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STkxHxzQ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X1/4mkKQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STkxHxzQ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 466FD7A0067;
	Mon,  8 Sep 2025 12:56:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 08 Sep 2025 12:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757350570; x=1757436970; bh=XFNl7PAE1I
	JHTaVoMEIUegSMhcycGM9Fsowm0dXtVFY=; b=X1/4mkKQ9NktQmZAMbWsbvqjX4
	oIWoNuPdbhRkeRs3ueAgE6cySz1m17ByYmSwst/yvCX1bJuD5gdyJXw1QympX30w
	oub0Xz/GQfKp6zwB1j5eldthccLG3onmx1oZFnWWqTblzfdMHQfFrVKo2tzURj6k
	waC1olu79gTbjpaKGGZCsd4yax8m0g0oh8BxYNB8HDwRC6/Fgtpiv/a5h4y+Ao5E
	gMHrpnGorxMdtc1+mu1eg9LJWoeXtfckrPPkGD0I2jeNINZO0D0e5thdR49Fwq5P
	fvC/doHXgXSkxbmFIf6PvckHg8m0I7sLMBKMPPJj1KDYis6eH4bFRmGg/0LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757350570; x=1757436970; bh=XFNl7PAE1IJHTaVoMEIUegSMhcycGM9Fsow
	m0dXtVFY=; b=STkxHxzQblTHHslBrliHNbx3ZPgh0JsZ/1XcCGsOhx6Gg++2t5m
	Ug5/01kDIIjYpsMei6tLe0lkO57KOmYzoZpqIglDl0wSnClEVvxgZuArF9FZd3aU
	ZHWc+erV1wnNW5W8/OGXj7D2XjCnGj3S/44ha9ZK4TUYzy689AuIa5sYEFhoWYCr
	5cZ2hHD2CsCziM+ifCrFUivrejdVQXtz+N/o8JHIorQLxSNvF0QLHpKRC8df5d7y
	ssIU1sIa0Gb4z+36K5dkeUhXQHH08Lit9aDUdkX4Nd0sso0Wv5y7+P0MwLjGEWRK
	UGC4NnWzWfunpoHhzXxYBZ6Z8LQ4FIqdxVQ==
X-ME-Sender: <xms:qQq_aHB3FDm377dK1YdemJoHfTpkNmhq8aMxUEBRt8HtPiXgQkOTRA>
    <xme:qQq_aAyDwyASM_KRkgKKnqL1eaI5FXyBc3sOM6d3nuhWmIkr-ECA4ZC4xwwdoMYja
    ZyKwblLM2f3_Xjvtw>
X-ME-Received: <xmr:qQq_aMAX1rpWMarUcIIxQ1-TVsgJEfp-2--UJ-ddsR5_l4s3gjEQq6DFpVHWUcJYcYhHTVbTSlclvxiyZ7BMlGxt8ve5DyStKjtFxdI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgr
    lhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qQq_aFYY4LUL1myQJXBT941xdsPIJ0epBN7c9HJo7ATn4ScCkWXCtA>
    <xmx:qQq_aMghIdRwBMvk9vt5TFJvyExOrm7BUEfAhkeQJ2MQx0vm-mpZbA>
    <xmx:qQq_aP4bqBg1CpsepkpJ1l2HGudhOFVk3nRK2BJJYXQuBJtvX402Fg>
    <xmx:qQq_aL7fEP6DUG5nhqxKOJNfDNfhSetXLDxPxBTRJaTXrlX4nr1fQQ>
    <xmx:qgq_aJa-SXXOtJOyTt5vxQQR4JacOUZQVatPC2luPo2pkUBDvarNflkl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 12:56:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
In-Reply-To: <aL21gazVeyHMeG-s@ArchLinux> (shejialuo@gmail.com's message of
	"Mon, 8 Sep 2025 00:40:33 +0800")
References: <aL21gazVeyHMeG-s@ArchLinux>
Date: Mon, 08 Sep 2025 09:56:08 -0700
Message-ID: <xmqqv7lsx4rb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> We would return negative index to indicate exact match by converting the
> original positive index to be "-1 - index" in
> "string_list_find_insert_index", which requires callers to decode this
> information.
>
> This is bad due to the following reasons:
>
> 1. The callers need to convert the negative index back to the original
>    positive value, which requires the callers to understand the detail
>    of the function.

That has pretty much been the convention so far, not convincing that
it is "bad" at all.

> 2. As we have to return negative index, we need to specify the return
>    type to be `int` instead of `size_t`, which would cause sign compare
>    warnings.

That sounds more like the tail wagging the dog.

Construct your argument the other way around, perhaps?

 - We NEED to be able to use the full range of size_t to express the
   index in the array string_list holds for SUCH AND SUCH REASONS.
   But string_list_find_insert_index() uses "int", which may not be
   large enough to cover the range size_t covers.

 - In addition, in order to signal that the returned value for a
   query is about an existing entry in the array, or a location that
   an entry would be inserted at, we use a signed int and use the
   bog standard "-1 - index" encoding for this purpose.  This
   further halves the range of valid array index.

 - To allow us to use the full range of size_t, use full size_t for
   the index, and have a separate bit to tell if that index is about
   an existing entry, or where the queried entry would be stored at
   if we inserted it.

Your argument does not justify the first point, your desire to use
size_t in the first place, and that is what makes it sound
backwards, I think..
