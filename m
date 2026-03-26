Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD6332604
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557919; cv=none; b=WmhT2UDK603F24d6mlohw/a6SRWU+F9vrNxaktR2PATOEQgFOProtTwzHpseIa7kcm7okPXXW2EzTByC2rQI69/rdip8iETVPK14MajOFbg10IGb0fhXAX/yITfc8ADwIU3WTrEPYID4K1x2KmgKszou2wSrRpFJ0mW/7FuM18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557919; c=relaxed/simple;
	bh=EZIint5BJ7C7GC1byKQCsXZg+MT8K9GNGB+LUTsZWak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PwIZlNJ/4k3gV2KznMWFmtfwDM+UV3hYP+RRuc+puow9awvA4XOKUIx7gpmJ8Jq+DiC80SvkqgTUuAptzLGKYO09dgInwKo8BiaaOPhfJwp7j4Oqlz6MWFvF9ySAGV0+ZapyAEi3N7sQ1biXqEDaTJaKZXM9lHonN75pLJ8bImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hkr+Ruo3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAuWgVuK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hkr+Ruo3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAuWgVuK"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DCD5EC01BD;
	Thu, 26 Mar 2026 16:45:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 26 Mar 2026 16:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774557917; x=1774644317; bh=iKbPcLPBZO
	Zp9ehqN6B4JZfpbBOCexdeyITCt8K82CY=; b=Hkr+Ruo3VIOYdsJxVPaa47BtL1
	dM0KPICTLhNQLE8MujXIPJMP60VNjzOzR6tgs2+icX4xHK17Shv4pA7ABsQ7gsVL
	aANKD0yqJq8IDJhn1biaLcDN7yE6cTkK0XD1oQY11CD9GmsAITf3mfDzRZpp4Z+Q
	RnXiumma+4S1c22ANSH8rBTSENIt7bdEVbscLA0pX0jig3lbp8j0Atwgp6ATRBfW
	1sGfMU8pEhExPDCG37ShOW+bO3jv8gwAzAaFD37NuM2B6qq59MBJkMdm6RAo6AkL
	AhwlHSEnpfDbrF0t+wqvbaQFiz9yl3Xkuxo5n1sCnbHViK9pOvVmmRBTKeOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774557917; x=1774644317; bh=iKbPcLPBZOZp9ehqN6B4JZfpbBOCexdeyIT
	Ct8K82CY=; b=gAuWgVuKCIYT9jNCBugIziIllDy+JFX8pA09+CpippnvIVPCd08
	2lVPMYp3gRzhEm+rZkNTdr6WVgls7Is+1UcHDzrh+gxXdzx17D7JizekG9hOXgTo
	2/iUgatTFGEU4nwA+SjJxPMfLmUdD/RFX+i/EDc1E/wPyyQLwk8zir0KoAruGcSN
	tLNKwjzGOPyxU60Mr+X5x+Y22iu09mCB2lpIXwT6RvFyyX4P/C/VmF3dyFNBGX3l
	Rf2aMVjl4H9rz2oPJb6T+QqSa/0hlBLYBu0TXfrQUbcnenWanEMhzGR4hAC3Bpud
	SolR0K9y0uwJMOrFxUUvcvGb1cMSsm+pIlw==
X-ME-Sender: <xms:3ZrFadv51hkpcgIgNzz6Bn68tUEgMo3c3LiQhCc1k_QW9YTkafvY8w>
    <xme:3ZrFad4buRZRrNf6WYlJyiQ2ayhYeKgfnabQ7Dw4z62atpyoKWO48BUO8TTXkvz0t
    ZfvmxbyJz8YFHtYVQdNa0mmvtlY7VQHDOp23YVGupFKWc6SdcGkww>
X-ME-Received: <xmr:3ZrFaeJZAGUz0BaHxeUUa3Em2ujMEaYvYUO4rzi6WkHnTAHPv6h_tTdY1n4x6S_QtzFd-BWF9wLj5CcnQA-zCNRiVdgXbrsvQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3ZrFad7UCRP8Iqdwu2o1TQVg_EkeoRZ0SBwYkAFpm6ziqzD9-ll2kw>
    <xmx:3ZrFaRySeBuLN4zehQ6yflThLSyFwetICVYV9fdItcMhwr4kg5jjSg>
    <xmx:3ZrFaRbf_AkC0mTlUSGByx8Zo80YyBjL6OaP-kwEYUbkRpzRZqc8iA>
    <xmx:3ZrFaTTKM5uD0o8K0A5dp6ig6bJi-ZyG8A5bDyr4tks_K3feRmYc1Q>
    <xmx:3ZrFaalLC4al87wpSUBDQ4LRjGSfjo143xQiX9mVCUhTK4dvqLX_2VMY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 16:45:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] docs: fix --commit-list-format related entries
In-Reply-To: <20260326200643.20251-1-mroik@delayed.space> (Mirko Faina's
	message of "Thu, 26 Mar 2026 21:06:40 +0100")
References: <20260326185541.17523-1-mroik@delayed.space>
	<20260326200643.20251-1-mroik@delayed.space>
Date: Thu, 26 Mar 2026 13:45:15 -0700
Message-ID: <xmqqse9mnwv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Ended up with something more verbose compared to what Junio proposed,
> but it might help the user to better understand why we check for the '%'
> in the first place.
>
> Same goes for the implied `--cover-letter`. Instead of rephrasing I
> added a note for the user to clear up any ambiguity.

I dunno.  

Being verbose is usually a good way to discourage readers from
reading.

Let's see if we can shorten them without losing information.

>  --commit-list-format=<format-spec>::
>  	Specify the format in which to generate the commit list of the patch
> +	series. The accepted values for format-spec are `shortlog`, `modern` or
> +	a format-string prefixed with `log:`. E.g. `log: %s (%an)`.
> +	Modern is the same as `log:[%(count)/%(total)] %s`.

"Modern" -> "`modern`".

This is necessary to stress the fact that this is a fixed token the
user must give verbatim.

> +	The user is allowed to drop the `log:` prefix if the format-string
> +	contains a '%' character. The '%' is expected as part of a placeholder
> +	but this is not validated by git.

    The `log:` prefix can be omitted if the format-string has a `%`
    in it (expecting that it is part of `%<placeholder>`).

> +	If not given, defaults to `shortlog` unless the
> +	`format.commitListFormat` configuration variable is set.

    Defaults to the `format.commitListFormat` configuration
    variable, if set, or `shortlog`.

> +	This option given from the command-line implies the use of
> +	`--cover-letter` unless `--no-cover-letter` is given. Note that
> +	`format.commitListFormat` being set does not imply the use of
> +	`--cover-letter`.

    The use of this command line option implies `--cover-letter`,
    unless explicitly countermanded with `--no-cover-letter`.

