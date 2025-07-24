Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069B1DF244
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373222; cv=none; b=Y0CwyAUHw4IMTM6Rp1HMZIrt3p+njwumkl+asJSAGcsdba4J7myRZlhA6VOtCFW3z4pOAFzE8ZA+XgzNBzEF9o24Yf1Ggqd5cn6oSFCnxGvOCHEYZ7xVI2CIAh3uoE0VcrhRbwUvqyPJNUpBpZ0wVucl5OQP4PmzfM7RkbE18U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373222; c=relaxed/simple;
	bh=28v6E94NW/wJnIQn3i11MJw+QwFx3iztaKkZfvL3FEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NBEKr1TsIDdMK/EXbJ9nrHkxAReSiSx9xUi8tJ6pFKGS6SmQzz4CVijcl/LBAfjlqYyUi99Adyat2jE4wct1IVz01a3bd18KSvVZOQp24kmz3Cy3j30y7NlAwE/5U9sHf9dzkgn/xXfq6Y+7FwIT/FB/c2Q0IU3ujnD/kpI6aKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mh/2G62x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WC8Tni9t; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mh/2G62x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WC8Tni9t"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B1FBE1D0054A;
	Thu, 24 Jul 2025 12:06:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 24 Jul 2025 12:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753373219; x=1753459619; bh=9pBFlREGZS
	eUHl5OZPzn1wDeTtXv4A7ycmhVCMQ/DZg=; b=mh/2G62xcdRwEwNGWMzrA3sgNC
	vRRB2gybyDs+SePOUjBnS9gkqkK9v+RvyyEnKT+ronpp4zlj3u6xA+P0+KevAYRw
	PJE5Nimvp6vT8LG4UsmhGvmqnYpvHjcNGm4KnW5WCXJVTZuU20Ae/et2ALrRiqh8
	lwE9KSYjthH/csGcrqksvLyr3xzNEkRx2GKVidq6wvf5h5wnmEyfIW8bxnZppksW
	CH5eo3g8SDxM6Tx2YA00kiDDbP0+AdQ9ZfgYQX/0H867eaj7OQiuUbEQjbN5UCzG
	9uRRqxlqCHtUBCa0iXTFzcTGLt3Ywii5WwPQAM/UTCmna7DNvUp/0h5wWYNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753373219; x=1753459619; bh=9pBFlREGZSeUHl5OZPzn1wDeTtXv4A7ycmh
	VCMQ/DZg=; b=WC8Tni9tdcq/kgx7NDc9Jixql8oVefDeMV6BMGeJg/bjk5QSV5n
	jH+4UvooxYTO00fn0cvnhFGOwWFH4kbNB/17j2uhUs3MmQTYvgP7Ct4anlWXH5pj
	3V3qkeI/4wGsNpYxbZOheP/7Qxizc3vVRaAwiSJeFLEJpShf6gDjluH8kf5OmwHE
	dUfRLVt1MGMw7crN8bZUNtEL10tXL3o2XMBEntU5/wZ/gDJjO95mOB2Z55b2mk35
	Bbid+7UXTxwbTaZf8OsMTVgUGS7ZOagtrGhugexasDpJjAg0qUwakD8mupkQJFf4
	RI19cBhMbB4l656ftdYkdWo5z1/lCoXuYKw==
X-ME-Sender: <xms:I1qCaJ6YM_5f6Ln_hWfYs5VRWC9o2Z6DtTrkER7KKSBQ6DYfQ0NWtg>
    <xme:I1qCaBgfPs5EIG1f-igLIziGjh4IQfwibg9uE8Fu8BK4vKsIWZbi7KEgwE-8EGDb9
    eakGviCEHTzj0LmOQ>
X-ME-Received: <xmr:I1qCaGeDJCzDm1Z6kB0zj5Bc-eO1Apmlz2uxwfUyaJ-GBevHSjJahxEebCA_rQBmSYt-xCUY68jfXbLLgrcsXHjXSaFF1bma39Y0c_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekuddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrghsshgvihhkihho
    shhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehg
    mhigrdguvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I1qCaBx5ldfLKRINeFopVejor5Y2jBQJLPKCh1okGKOcbt4Ho8as1A>
    <xmx:I1qCaN2fD3uGvgIWXLPwFN7xK2k8s5Sv5J8FiZ3zqKy08aRwFZsBFQ>
    <xmx:I1qCaPzXqei2cFFW2Bzd96GxEJhesAcXXIGc_Wtv6lKjgPzrs3ZRaQ>
    <xmx:I1qCaKVfIn3_WIky7quWIBPSJbCT714WdUbRLoV7sQXlfHPTE2KNuA>
    <xmx:I1qCaI49nSlSrXnRT2lrgFEFSIdr9U7AwK1qQJJju78-1Ko1pT7rF5HX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 12:06:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  oswald.buddenhagen@gmx.de,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
In-Reply-To: <aIHRCz_qswp7RgSy@pks.im> (Patrick Steinhardt's message of "Thu,
	24 Jul 2025 08:22:03 +0200")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250722002835.33428-1-lucasseikioshiro@gmail.com>
	<20250722002835.33428-2-lucasseikioshiro@gmail.com>
	<CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
	<xmqqtt34tfna.fsf@gitster.g> <aIHRCz_qswp7RgSy@pks.im>
Date: Thu, 24 Jul 2025 09:06:57 -0700
Message-ID: <xmqqwm7xindq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> True.
>> 
>> I also wonder who it helps to use <LF> as a field separator.  Once
>> we require consumers to properly handle <NUL>, it does not make it
>> easier to write such a consumer script if the format uses <LF>
>> there, does it?  Besides, wouldn't it possible that field may have
>> to contain any end-user specified key, including <LF>?  If so, we'd
>> need to have some quoting/unquoting mechanism in the syntax anyway,
>> so the behefit of using <NUL> to simplify the parser would already
>> be lost.
>
> Scripts should always use NUL, true. But sometimes a user may want to
> inspect these key-value pairs, as well, just to double check a certain
> property of the repository, or to figure out how a certain property
> looks like while writing a script that parses the same key-value but
> NUL-separated pairs. Using NUL bytes would be a bit of a pain in that
> situation.

True.  I do not think the discussion so far had much focus on
helping human users doing ad-hoc inspection, and NUL can be annoying
for such use cases (even though tr is your friend).

> I'm not really too sure whether we need to bother with quoting. The
> LF-separated output shouldn't ever be used in a script, so I don't mind
> too much whether it always works. But I guess it wouldn't be hard either
> to just have something like:
>
>     if (uses_newline)
>         quote_c_style(...);
>
> So with that in mind it's probably better to just do the right thing.

The right thing being...?  Use <LF> as a record separator to avoid
forcing <NUL> on possible human readers, and adopt quoting in a rare
case where <LF>s or <NUL>s need to be in the payload?  Or something
else?

Thanks.

