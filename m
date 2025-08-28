Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF7265CCD
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421200; cv=none; b=uSS8S35+D6mLvrrVNyRaNex/pP5YYcwK3nWZOKxKC6GksnOxwbpKbZto2wxnySrwDp4Wl4mWoiYR9ZvtltMzWvI553MJlmdmchLI4xpMcTSJk8urt9OYfgXUu2OOoHoNVS59rtsHOJb0MvboKdXso2+tKkRdje6UbRbUMS0lALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421200; c=relaxed/simple;
	bh=/DtUuhToqjNTAKgWbVKEPKHf10R+1lgH2/4TL9+NIDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQmSvRQnEO57YIX2n0x7GcaAyvIZd3CzYcgWHG/6T03VJMPY64saUrDh8WcTokTA5qgYWe7OSH0wll15IPilKsT3odlSVNOycP/gnc17gvdiIUUhSs/8Qf/mnCCJdORcRBkXeyiwCMFrQ1+5nBGd6xprHSSBh18kiLWkfKkm1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hxX65SS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EgtJJWV0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxX65SS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EgtJJWV0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F3B877A01B0;
	Thu, 28 Aug 2025 18:46:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 28 Aug 2025 18:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756421196; x=1756507596; bh=MfEah+5pzU
	aCg/kzMwCiKBVqpamdWXv6d8n8wEhD+DM=; b=hxX65SS3DZXg3fhZJ0Zd3CO+O0
	uD5r0b+ziW+R7e5dLio235oO7K13VSexPUeYdXcc2JFnp71cutRpta1ppn2LvGn7
	P3ZtQbxEUzTXA3eXIujdpu/Bne9wKt3GOZtupsr1gqQDpwwdEBobMeiplroQ8Uvd
	AIl8RiItm6ViJsA55DNAxk+nJdX3kA3ABkZ4zTw7yltak9Pp4zKwKpcnGXHkjLOu
	lgm/7JCM43GrfvEKo/zbqjs8JrOX58JWw0tn7yNLjsDsUm9SXZ96GZrRw9Hcittg
	h/LkE5dgNkGnDVB0hdeI4hDuFDpw2vrNsMJTpx8jiANogTqBDs3E8AZi/YtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756421196; x=1756507596; bh=MfEah+5pzUaCg/kzMwCiKBVqpamdWXv6d8n
	8wEhD+DM=; b=EgtJJWV0wkqRfDXLPG2wG8RvgBfumHeOHt63bMp/KIqZ2b8apRG
	iHnTFQFMnkqiSK2B5WjiUP/SgIvEOuKZviY7+uPlrV/8XSVgIRpcmAgv3TMoOH4f
	OSutCKDv/y/PIrYOZsIpDMLT9BjXF86KTSCok3KDK7Q4GbU8s4wT1iT4CLOkCnci
	o0SvxbUDWDccm5z7afkdbtr0dAZUeTQKNGQWPhEbjCSSnzEeZW15+bl/wJGcTJDz
	fZVwxmR+FmsWd4KzoYdqhNH5NXMLI1kv3ti5AkpcCAf+mGazJrVlrZW9XvpV5L1g
	tfZ0xLJkte0tqW6hEJk4brzatrd20wFioXA==
X-ME-Sender: <xms:TNywaJJJhu5Xr2qvMOU9sKVYj6EY8EQo7YWwY1GYTBjly2N9SscA5g>
    <xme:TNywaCtbIo-2DaLJy-BiLKlDYCT_chR0zZuvhUvKJsU2FPREyZQIM-zCmZH_ihuy_
    Q36lTq8Q9TiuUf8jQ>
X-ME-Received: <xmr:TNywaILh3LPhXErlevOWlJDW38dd9YKtpa6npbxQeChS7ydXkEZAm0xjaG1NXFyKd-IxR0lFCuKCCENBHhfyjKMZNhdqtkYh7vfd9Ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TNywaL-kM-8f3G1lmB8HZvb6U748LOkrwiPWw0kF-6ZS0KVRXkUszQ>
    <xmx:TNywaBwfYhMW2Z4lUce5S58HFveDj8tE-LNbN_f17KXcb1GGrsaKMw>
    <xmx:TNywaI7CZNJX6ZOuC7VNc6b9OwfPb6n1l1DtCLlSCG9LdmM-ZYaU_A>
    <xmx:TNywaI9lAymhbPPg8bEbrVF_QQgTS5mzl2mZQeMGjPPZ3cp9v3bz8g>
    <xmx:TNywaN3lHkEqXMtk4mkmpiYTfhGA_MGTN-58gu0ko6jRmmPyod0hdNZI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 18:46:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Toon Claes
 <toon@iotcl.com>,  Derrick Stolee <stolee@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/10] midx: stop duplicating info redundant with
 their sources
In-Reply-To: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
	(Patrick Steinhardt's message of "Mon, 11 Aug 2025 15:46:40 +0200")
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
	<20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
Date: Thu, 28 Aug 2025 15:46:35 -0700
Message-ID: <xmqq1povt67o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>   - Fix a comment typo.
>   - Introduce another commit that simplifies the calling convention for
>     `link_alt_odb_entry()`.
>   - Link to v1: https://lore.kernel.org/r/20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im
>
> Changes in v3:
>   - Introduce `odb_find_source_or_die()` so that we don't have to repeat
>     the calls to `die()`, as suggested by Taylor.
>   - Split out a patch to adapt `link_alt_odb_entry()` and friends to
>     consistently name the parameter that refers to the alternate object
>     directory's path.
>   - Link to v2: https://lore.kernel.org/r/20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im

This has gone quiet even though the previous two iterations got
fairly detailed review.  Should we declare victory and mark the
topic for 'next' now?

Thanks.

