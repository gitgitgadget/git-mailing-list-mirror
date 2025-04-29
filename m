Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313566F073
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966262; cv=none; b=fmznECr+tyhyp/iDPOD5zbJSCMzNJ3PVsAhvZT6UIgLkYsbf8HRG71FvEzBNnGJ8OTloKUnSa8pUhOQaCA5YaSmjVxD8Dp9hUWUyi/ssblp3To2wOLFskzCNC/vCjfPF6DW33HGDofMMD+6MADT0eWNEBBTLOXrZvoECnbMLa/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966262; c=relaxed/simple;
	bh=Xa+GwpbhD3sh6LHJZGsxGdoDvwWXmVT3kX6AM81/lXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFJQvENSe/pyWts0ip4hFXfPrpJUA07BI2836BcRiQJgZok06/JzKRerjeMnF1SBBBzvBkYsMuSud5PPL74nVXg+uEta6J+OgLKp1ZlDXce8H6Je5VmdZJXHDnwwtMB3HJUBBEp/kBv0Vg+cIEzLvXXRIHv4wnKHOecFwaUKEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QILcXjUG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HiBWtaKY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QILcXjUG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HiBWtaKY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A7B11380863;
	Tue, 29 Apr 2025 18:37:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 29 Apr 2025 18:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745966258; x=1746052658; bh=k15S2hdBow
	Q0cRFF4W07/eyxO8+xrxCOOCthudtNmzY=; b=QILcXjUG9Exs9QM0xABGp8PJz6
	iyQyGC+fOgMTfXccYEA56X2yEZbT5A6uWP7lH+sMfFvdjrtprel+U2QzbJizSMst
	DSw8JlmT8Gno32bkTn7bY7Jfaae4+apBYbXufNvxC1vehSDtKQVke2HE1l4wcD4V
	qvzBfYsLum06uyAsnnf0JwPiRH7/pkZQu2Gk5FvNVeuMAwukMEVuNcF7yQaSVeKm
	ffB0aoQ9B6pk1p74JaKHDjLeGr/8tuJ1d8rvgcgscxG7dcO7Fgi8IakKBAGeEsaX
	jrAWNdSK7Ta0zJbRSrjgGXL+Y9vRgxsS368WYB89SGJdlqaZ5DUVWf0evdJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745966258; x=1746052658; bh=k15S2hdBowQ0cRFF4W07/eyxO8+xrxCOOCt
	hudtNmzY=; b=HiBWtaKYZwTDk5u3VWjoqd6FuP33gI6fvo4xI9xoAC9mv/zozpx
	pO+9gs34ffsyH3GAo0qikZbtNSjNg9ckWJ3j4xxQ2yW76UVYJrZkXTzRNQt5o05/
	l8AdRIesEuhGBZwypi0KVdRJ43uqFGbdWU6C4urSJFnA0rnhGoUjgL/J7l5QA7ik
	Ij5RPvZrLxnDvjaI/0s7sCJK4ur/YxF+4g+qVihgzljq+2T4oGYbnXI0/cIMaX52
	kUkQsozkKROqKNRI7gTYcQvO92AUkjQY/Q5kZW264XdaCetUOnksMVkSF8q+XOEH
	SansE0Jej5hADfJO2hR7lSkRZuuyYXdNRGg==
X-ME-Sender: <xms:sVQRaNrnRWLjZv9rh2cMnAZboj_jF58yS4MaZ0k9RtPJsnVyx5m69A>
    <xme:sVQRaPqv_7YXf3-rhWRfp7TA6NlUeaT9siIl-aF1HD5oQV0vPm7-AoEMFs-Z_H3uT
    m_dy71BBiacIfyv3w>
X-ME-Received: <xmr:sVQRaKPh0KB5y9cftlEHrKvw0LUNC1BqvOZvyfB9G6VTapJRz5vtpm_FMM03rxYTSB70CXLRcAcx42CmsX-t4oh997pVjFQatxBn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sVQRaI7wz8S1e5Z8XbZVedmvNh2QE-mTLmB7iKsigeEsTuALlGR7bQ>
    <xmx:sVQRaM7E1MGbDfT4IcVPPtCPO8P8GH4p-OPBYRphzEqevKg5K2cPYQ>
    <xmx:sVQRaAh8N0OUHqaI07WnQqye4BQ7n5B6SoreDLWsdJuTZw7WTG8LPA>
    <xmx:sVQRaO6QDDIQSjV2DrIYFmVFvkq6rTPWeNZjfkZToVa_ObgANfHNhw>
    <xmx:slQRaGYYV5FfqHD3rm417IgdnvTM-UbvbgG_2ub7SYukxs1FmM7_-p_8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 18:37:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] diff: check range before dereferencing an array element
In-Reply-To: <20250429215847.GB36727@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 29 Apr 2025 17:58:47 -0400")
References: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
	<pull.1887.v3.git.1745926679028.gitgitgadget@gmail.com>
	<20250429215847.GB36727@coredump.intra.peff.net>
Date: Tue, 29 Apr 2025 15:37:35 -0700
Message-ID: <xmqqldri4ms0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> @@ -892,7 +892,7 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
>>  
>>  	/* skip any \v \f \r at start of indentation */
>>  	while (s[off] == '\f' || s[off] == '\v' ||
>> -	       (s[off] == '\r' && off < len - 1))
>> +	       (off < len - 1 && s[off] == '\r'))
>>  		off++;
>
> ...since the same pattern exists for the other s[off] checks, is it
> worth future-proofing this like:
>
>   while (off < len - 1 &&
>          (s[off] == '\f' || s[off] == '\v' || s[off] == '\r')
>
> ?

But doesn't it change the semantics?

s[off] == '\f', even if off is at the end of the string, i.e. (off
== len - 1), must trigger the off++ increment.

On the other hand, CR that is the part of CRLF at the end of line is
*not* treated like other funny whitespace control characters.  This
"is off not at the end of line, if so check CR" comparison is about
that.
