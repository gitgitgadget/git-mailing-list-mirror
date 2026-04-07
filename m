Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A835372EF5
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591877; cv=none; b=a9C8efAedEhLJd6yqlMOTE2HS6kGofLZYl9IQIx6bD82+2yXooFUh3N+9a601r+nZDQ3tRhJIN2XMOLTRO773R3dHsbZ7XteIFnSvY+/FDtNXPnjKsWCd/+zuruCXvP3CkmyrWDXRnhcyOGYMLZdcQmCNDZIAoWZjzdXHg73Fow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591877; c=relaxed/simple;
	bh=NiisO2EEKD2ZgNE5JNj9Q7repHKlOIMnEcTyiWVm1hE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVyjkAndARcGfVRbbitpGNyetYREuKQHKjiDKQzC+iYyBZ914xrglRkB48RaDmL00m7D5Tyd1tNgENvGt86FX1+1821SpyH0p0GSweKGx1eTOu51rdmAsB835QfkwS4JGdNeE2sB6XzMKDlVhKgj246xLinDF5kuWvoEomccAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LeSIZ+S8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENoQ1Wqu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LeSIZ+S8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENoQ1Wqu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BECF2EC011C;
	Tue,  7 Apr 2026 15:57:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 15:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775591875; x=1775678275; bh=KW/wmyngu5
	vpfl8EGW9zMTsNhUd5cz0JwbHXo046vnQ=; b=LeSIZ+S8V1vMOJgM3KWc29B/LQ
	o9+n6Qzb1zo0YaX3mYDcddmrz3cSW0RuvrYCyzZmCW9CATWDRCgn64IeBlLN5cCg
	FNBGWi2IgnvQu34ykWN4XoAXnEJYM99aP9qGIdx1oen6qD4a+3tPjHz6EDmaGRN+
	fFhBsebst7ir0OawWv3wg8zv2BYtZ200QENhDFUqDPTU6mZP6EWGauDUism7hroY
	iAtkx/X2fnakAhhSRdx3G9780RvNNuorS6jf/CVZANaIxfeS/XVjNSuT8zmZmfMm
	YawYwMDVryXDQ4aav5cwARDqWeAEMriyO1w/XCPK7ka8VIIQd50fOEzQw70Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775591875; x=1775678275; bh=KW/wmyngu5vpfl8EGW9zMTsNhUd5cz0JwbH
	Xo046vnQ=; b=ENoQ1WquK2kR0T3dCX9C08v/xrY/piHPTc4RSdL+aNUbzvJBW70
	iF/O306T+5Lm2PvN0I4x1G/hU3MrNj7DFSkGFOkXNqXCPE8CIEAEsAN0Zqjvevyl
	4dwFjBFA390G1WPKJB2dx5VSi4nNy+EPxilmFx7hXiOuu6j+PDIJ9x0XzK/LcXQc
	fJKWDhQKA8YysoHtcppntB2/W1pKbI56YxPTpm1DBwEf8x0w3jwUM3Jig3rm6uDY
	UUdyr5KcjZNyue/v0zo2RBYZjAClvau+TrHuikayFaaSgUFN1f/rwnD/QVEIsZ5o
	ko6TmxiHe6rRjmwadfVLe9ji9RpmxRf42uw==
X-ME-Sender: <xms:w2HVaYxcQ73fCq99ycb3IpNeKizGbSJvciWlSuWRkk46UAbF0LppfA>
    <xme:w2HVaTTwEjd7-3XRd7ZwDhlJyov774nwtL44JQKmgKe7J_V9HC8jhuSvZJxdBqhvN
    w1PHTnYSM7N25WEhzAf-shcJHg0XL75XzHmur9KsSnugIr_UFzG3g>
X-ME-Received: <xmr:w2HVafULuWy1Il6kos6PF1O35mvrklgM3nsv3K-O7Snt5xofXzzMZ-K4RiD_X1QlUZ4FZCmCDaWJEKWJE3BNrU9qvKd5L6LHqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hushhhkhgrrhhkuhhmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:w2HVaVZDhOCHkJo7p4R2FCfhU6mxup7NoaKQ4Ksk1YdOqujG8amJQw>
    <xmx:w2HVaV0lWcEFjaBzy5cBqqIlqEcJAZ7jSg0P8prQ6lvncqkdW-nUSQ>
    <xmx:w2HVaXjE2ND7RfgYbud7h4zZssFbUYJmTwdq7SUKO3TIMBwozK4cIg>
    <xmx:w2HVaZaKWmOQBG0fImgGGMze-y-6XoK8hlNV4FnmEKWXYX91JRDsUg>
    <xmx:w2HVaRTJGfKDIksgiSIoS7oe_qqEqidRnOCOb2vTuqECoFxC60_mZRID>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 15:57:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC] archive: behavior of --prefix with absolute or parent
 path components
In-Reply-To: <20260407192454.GA754735@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Apr 2026 15:24:54 -0400")
References: <20260407162101.2285-1-pushkarkumarsingh1970@gmail.com>
	<20260407192454.GA754735@coredump.intra.peff.net>
Date: Tue, 07 Apr 2026 12:57:54 -0700
Message-ID: <xmqq1pgq4k71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> In such cases, tar emits warnings like:
>>     "Removing leading '/' from member names"
>>     "Removing leading '../' from member names"
>
> Yes, but note that with "-P" tar will happily allow those paths. They
> _can_ be useful, if you know what you are doing, but they aren't
> necessarily safe when coming from untrusted sources.
>
> We can also generate zip files, but I think most unzip implementations
> have similar restrictions (info-zip does, with "-:" to override).
>
> In theory we could support other formats, but after 20 years I don't
> think anybody has bothered to do so. Cpio, anyone? :)
>
> Though speaking of cpio (the command, not the format), it will happily
> list and extract the paths above from a tar input without any extra
> option (it has an option to restrict, but unlike tar, it defaults to
> off).
>
>> From a user perspective, I was wondering:
>>   - Is this behavior intentional (i.e., leaving validation to archive
>>     consumers)?
>>   - Would it be worth documenting this explicitly?
>>   - Or should there be any normalization or validation at the Git level?
>> 
>> I understand that Git generally avoids enforcing policy decisions in 
>> such cases, but I wanted to confirm whether this behavior is intentional.
>
> I don't recall it ever being discussed. Of the three you mentioned,
> "../" and leading "/" are potentially useful, so I don't think we'd want
> to disallow them entirely. At least some tar implementations require
> "-P" on the generating side to avoid mistakes, so we could follow that
> path.  It may be considered a regression by anybody who is using the
> feature currently, though.

Thanks.  I was writing almost exactly the same message ;-)

> The "////" is meaningless AFAICT, and could be replaced with a single
> slash. But I think it's also mostly harmless, as the reading side (well,
> the kernel) will equate "foo/////file" and "foo/file". I don't know if
> there are systems where that would not be the case.
>
> So...yeah. I guess we can document it more explicitly. Since you seem to
> be the first to ask about it, it does not seem like a common question.
> But if we can clarify the behavior without making the current docs
> harder to read, I don't see a problem in doing so.

Yup, in other words, "Patches welcome".

