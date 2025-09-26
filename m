Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B33E72633
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909155; cv=none; b=DDevHq6/BwzxCRU7n2ssGOXpQAWy6/RDisV7nnYMl2nADETBnrUFGtrARE8S+EbVVZti8rizu/iRqo4UT7nCHNy0b4ouqoSJx0Ow0IO+c4B1PT4wLVEx7WyCEg8qSFjHUhU7yG29pUWz+UOvM31CzecsEr6UBb3a/Hf1+Nbrv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909155; c=relaxed/simple;
	bh=dlqkGDr/LU4ht6ewaChQB8ErB7U61pjT97yoMqO7FHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=duUf/L+iRkIF9TJA8r2/PKVFnCv7MVbLS+ssXN10U8crxQoesMtpAwHOCWKL1PP9uZ4KSxIZsBQse+ZKcavlEoiW4XNXGqvrMNcBJWkGom/SQ0MTcTk5R3bybtl4eoDVq3XcX8I6eBKTqr60bb6jqM3HJ00gsN89KbLzMjqZwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IRhNvAWg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CiHIBtoz; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IRhNvAWg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CiHIBtoz"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A5717A00CB;
	Fri, 26 Sep 2025 13:52:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 26 Sep 2025 13:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758909151; x=1758995551; bh=k6dBDQRMLy
	npsQ5z6K7wsUdy//b6FywL5Ibwsj/Opr0=; b=IRhNvAWgV3EChuXaIrSzYfJsBj
	wck6vAbl98Uuej4+po5R7t1rvZMCVGpmmkvzeGIUUqgaKjVaso6eg6RLrXfXe1PI
	De7RB9GtK3QVkIOGXSbanxAbjQ8eBQDpapalrMag4LL8HyJg55DY1pfrxDeZN0ou
	wFNIdB9+6tqDQMkN267GqQdLCI+FncDl0lJi0Hl19jDu9yXxYjbW27owK4VHhLkW
	dgiQn2wu+u/bQS6+9Khl/lOwKPpKWGjdSHmXXylLNgW2fPpiMx1Xh/bg5gy67gkJ
	tqb7+Qs8Ykr3xOEH6J8X40Ad4seop7a4/oR3RodEbCcmHViwpZ7LNUd/CHNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758909151; x=1758995551; bh=k6dBDQRMLynpsQ5z6K7wsUdy//b6FywL5Ib
	wsj/Opr0=; b=CiHIBtozmTQg4SPr2RfOXzhlFrxJo+X4cm3aQ/ShPJcPDCZ3XyL
	l68gaE7X/ZOwLf7pb6mTlfmvY/+z0bP4z3VWnIusW+cVGLATnQeb52Q1t4t2lz8b
	H9+KmINGFuULl39xkbQVz3AYNValOmVgxb4QnIb4GkkIPwBI5gme+z2YvV35OplQ
	6V+j2/UMJBqajPBIBN2mdxIrsh2tvif/o0lPlFh5QbqgRi49DMJns4gZPN11zMvg
	SBEh/zjNewSGxMIL5IaN2w8sIq7bgS99JoJ0MyX5Xvrwo2tcltxyR4QEnK22pP24
	CYVHJRO//Jm7h4FsTBw99HlI5qbmm+J6cdg==
X-ME-Sender: <xms:39LWaCySDNd6Ph9H-4TVq_8n3hK_JJ7YjOCNHUuM_a4ZS7XSArzmHw>
    <xme:39LWaA2l8fYvTFkeNON6wmnE_TkeUr0hY5mzKcZcJqW3hAgzXLeXhcHt1tjdliwAj
    cLyiFCrmnyIXfBOxfgotZkMfE6r2mZh0U6TVWSvANh2Pk0sKx1BZTw>
X-ME-Received: <xmr:39LWaH_JRjTUhcvh3FrKxkLJW57yEOcerqQ22UJIkWqGqQghzrgSuv16OG2wdFvquLU7XnFEUnezyfETwCStw_lvqirPOzmB0N_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgu
    rghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegr
    vhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:39LWaIqazMt1u-nSnN0YeCZc3MRz733V29qt6PMGcKcgWlS3PbR6gg>
    <xmx:39LWaJT4rT1RNCXVe53siynvga0SvsIHGItDuXPQy-3PGxBxFEFiUg>
    <xmx:39LWaDOFeSL1f9CISo-_xcD8lA0Kic-FqoERl6nXDjZY2iQQ6ZK1cg>
    <xmx:39LWaPiEdKl6v9tYLkU9qMU5uD2J2n83hhJOPZLcOLtP_AKFU3s4LA>
    <xmx:39LWaA0xlaq_s1l45TMIaiL8Ojr4dT01pJGPnF5Yyi0MxU7Lf-zMa8Zq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 13:52:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Emily
 Shaffer <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c
 to hook.h
In-Reply-To: <f408e46c-650a-4632-9628-cf817e393e7f@gmail.com> (Phillip Wood's
	message of "Fri, 26 Sep 2025 15:12:43 +0100")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20250925125352.1728840-4-adrian.ratiu@collabora.com>
	<f408e46c-650a-4632-9628-cf817e393e7f@gmail.com>
Date: Fri, 26 Sep 2025 10:52:29 -0700
Message-ID: <xmqqikh5ayoy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	ret = write_in_full(hook_stdin_fd, to_pipe->buf, to_pipe->len);
>
> This will block until the hook has read all of the input. Unless the
> hook drains and closes stdin before it does anything else it will
> block the parallel execution of other hooks.

Ouch.

>> +	if (ret < 0) {
>> +		if (errno == EPIPE) {
>> +			return 1; /* child closed pipe, nothing more to feed */
>> +		}
>
> Style: we don't use braces for single statement bodies.
>
>> +		return ret;
>> +	}
>> +
>> +	/* Reset the input buffer to avoid sending it again */
>> +	strbuf_reset(to_pipe);
>
> Shouldn't the return value do that?

Sorry, I do not understand this comment, but did you mean to_pipe
strbuf is left with some buffered bytes when we take the early-return
path when we got an error above?

This part of the new code makes me wonder what the lifetime rules
for the to_pipe message are?

In the original code before this rewrite, it was clear that the
caller of this function was responsible to allocate the strbuf, to
feed it to the subprocess, and to release the resources it held.
Now, what is the rule?  The caller still prepares the strbuf, but
the called machinery using the hook API will release the resources?
