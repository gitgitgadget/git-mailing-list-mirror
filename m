Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289E2E1758
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765852166; cv=none; b=F70YgkIEqfEPOA+jo9piwbzsPmGn3Q7Bh9vvPE+oi1RZ4EQL92dEojTj7v0PswjoF5KXf430TlLqzbKKAPtIq+HyiahT6pW3HRK6KcVUGtO8ahmnqaD+R1p70L1WTH1QvNHdp9yLltwGX9qcRWhc+jefgREmURRtNR8gRJIQcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765852166; c=relaxed/simple;
	bh=/87B3Z+Wv9GBDHvv2Naw1bDt1UVDh4JTHfAjiTxhInk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W3ma9988NtZiAqoGRaq1XaYDATsWtzLJVKhZoqfBQHbq7r+sChQUFnZ/Tdk4MOqPxBd9WnEkhvtnGIIytLDmfVViULYwdjRpvY327RzZ4IZpid1XVsq6/2hRRedlysC6AYBdNcSdUuNoM45AHFa/8PH6QawPiRgvRsrXkoj6Xnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IHQbzJgr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xmy3MLLj; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IHQbzJgr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xmy3MLLj"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D1747A01CB;
	Mon, 15 Dec 2025 21:29:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 15 Dec 2025 21:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765852162; x=1765938562; bh=+Dubc4UvwR
	0TxGxiYTLqqpTQ285y+ihqvqkCGGQ9mqI=; b=IHQbzJgr3fHER3sZJunVyMVsax
	xd5NCun40DYfEKRB4Vnq93pvBjoUiyT8/dzq1DrKhzQ/EH/GZCOgTs7b7xG5mR36
	rHNIZxKJvFOEYS0pAkzKwgUlPWPVlzYb5UTnd+DACdhlxHq2ru/OmrGsaUXRXrrO
	GB54BUGknYUYJ/T9K4t9ZT0fKW7DO5wcHGeyAJXKLPlxITGdqHX59BB6XF3xB6rc
	3QOSpj9xEwm9ZY4gmc/JV/SOYPIP1N82+9LOg7v9/BVc90t9mcYAcbkDkrf53TPZ
	Ju81ZUV5NDUFz4DwgYKIvKTv/x016xkte7Z8cZGIQd44WkMF/ZQSzXfUcYrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765852162; x=1765938562; bh=+Dubc4UvwR0TxGxiYTLqqpTQ285y+ihqvqk
	CGGQ9mqI=; b=xmy3MLLjVDvhfASTYALXvU4MMEpQwr7Z3nIRD/mxI8N+/+slUBq
	rBzX9F8qlT4+d8YsT3F4rLFIVf5h6LUXJGrXrrR7hR8uFGynqkcd6wMlGEcMAmnt
	23kzUgYyGX8xf40rlLlz/6+D4Pi0blCEYGfaBbtnL5fxBo0MzPgnh1zUxJddw5UE
	EdcQvagHRrJ+x3w4eX0azSBnhxtkI9fLqMkUNV4/0XP60kMmKnvc4kD5hZlwcYkH
	F0npKqYmehym02PQ/nNERnjsigRgDcYslSQaMM6qrk5z0GahgpimSEJFJhiaLXbV
	iSn5RGELjgqGVAkdiXWM91204m+z+mDLd4w==
X-ME-Sender: <xms:AcRAaaft-x_nIHexESjfG1PQNbpmse6ttPOHhZq8xmvm03JGcOugkA>
    <xme:AcRAaX57LdXzV1HNfF4UjtWLqS00UDzKCfEGzqCFNtD_v2B3ow27zucTU3BBbhawB
    jlDGGdPpP2MC8l9sfWLdhmgFZmMPmDkfdva0Y9E2kk7L5ESy9GI>
X-ME-Received: <xmr:AcRAaVUjPAZa25aoYGydg-Pa1in0SEbp6QOGdptDs9qtvIYLD76TlLYkQvjmMXbshJKFes_6wS4LkpJD7sjojBHThqbdWygHIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhishhtsheshh
    grlhhlvghrqdgsvghrlhhinhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AcRAae7YotvhElAwZmKWUoBGM0Tei42ehUVS6MEcMZxjCGYAsk6OuA>
    <xmx:AcRAaYoAGpl3K-Elxzx4kXbz2m4fl_43Uyrk83563aAjE7T5Fnn0pw>
    <xmx:AcRAaZlV9kb3cqDkghIEokxJRJRn33VMFhyfJ4cu2abb2SL5hhsNCw>
    <xmx:AcRAacNe3iwKJcqcQo4Cd_XVfmpv_2UekHE8-h2SriJtlN4PhBIRFQ>
    <xmx:AsRAaYZFv5pp3r3VBXbrmcxyLkP6oY5wm8ILz4S94OEKvIjoCFmtQNee>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 21:29:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Carlo Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  Stefan Haller
 <lists@haller-berlin.de>,  Git
 <git@vger.kernel.org>
Subject: Re: Would it make sense to add a commit.signOff config?
In-Reply-To: <CABPp-BGCwjTBEi4wkg=065QofiO9ZL+9XVCCcTiHriXqgH1Szw@mail.gmail.com>
	(Elijah Newren's message of "Mon, 15 Dec 2025 16:17:21 -0800")
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
	<aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local>
	<xmqqsedc8w7k.fsf@gitster.g>
	<aT9iu9He3yJ3npWX@fruit.crustytoothpaste.net>
	<xmqqldj48pyl.fsf@gitster.g>
	<CABPp-BGCwjTBEi4wkg=065QofiO9ZL+9XVCCcTiHriXqgH1Szw@mail.gmail.com>
Date: Tue, 16 Dec 2025 11:29:20 +0900
Message-ID: <xmqqwm2n40sf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> diff --git c/Documentation/signoff-option.adoc w/Documentation/signoff-option.adoc
>> index cddfb225d1..0b869dfbe4 100644
>> --- c/Documentation/signoff-option.adoc
>> +++ w/Documentation/signoff-option.adoc
>> @@ -16,3 +16,15 @@ endif::git-commit[]
>>  +
>>  The `--no-signoff` option can be used to countermand an earlier `--signoff`
>>  option on the command line.
>> ++
>> +As it makes it harder to argue against one who tells the court "the
>> +log message of the commit ends with a Signed-off-by trailer by person
>> +X, but it is very plausible that it was done by inertia without person
>> +X really intending to certify what DCO says, hence the Signed-off-by
>> +trailer is meaningless", if we add more publicized ways to add
>> +sign-off automatically, Git does not (and will not) have a
>> +configuration variable to enable the `--signoff` command line option
>> +it by default.
>> ++
>> +There exists `format.signoff`, but that is a historical mistake, and
>> +it is not an excuse to pile on more mistakes of the same kind on top.
>
> This feels like it's missing context (it'll take the reader a while to
> figure out why the paragraphs are there and that the two are related),

Very true.  It may be sufficient to leave this part unmodified,
keep the updates to gitfaq document, and do nothing else.

