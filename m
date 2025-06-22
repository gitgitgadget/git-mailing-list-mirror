Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3E2F2E
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 04:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750566193; cv=none; b=JvxAcfKFTMJLcZzXN7XGCtkopSdLpFcYZjK/xBonSkycTlSNg8jMd6GuRU85XtX2trRggjnUNoITqWtigzf2+wxyeNlF6dsx0/b+LSPv31MO+36sGnNJseXNHszowV4duxiBVACL6Ry+mIbsktuA7q3LhR0jf1wUOxzr29D9484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750566193; c=relaxed/simple;
	bh=aJwZJr9dn7d9aJFw3gFZgRVgjxPu/ujLRe53tnWW+5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dclY9VELW3y2oCZBNCqm0QoTskQLdXLJTqRyvDjgIr2kHK+qsSwu94J0PWR9X+0AC+hCrkHVCkWW4ntrZTNJ7+2jT25mGtRc/tXNcYCgAK4Wt7tKVRZRgwaNi/9RzfVtRVX04c89ZooMjew/P4mcEpYnHophxcqUImygwLJYZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CcFyxNaf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tq9pz8Wh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CcFyxNaf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tq9pz8Wh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A4212540095;
	Sun, 22 Jun 2025 00:23:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 22 Jun 2025 00:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750566190; x=1750652590; bh=9TD5OoVrD+
	0NQ5k/m/3Gnm/7278qjm5DzDJtl8ZUtu8=; b=CcFyxNafwVJ1k+f8KELqcpKHIA
	2yoM5t5OL1/VJ2TMues7ps7iOAfFWK9YjkH7UhFhaNR1jA6xLVRDbNvxclVisfW+
	ogb1h6Ssd2fx8U8AmBwoOidJ+sTE7Ah9tAPXWWRmexqN2hTaLN+B83R3+/Pqr2+N
	ltKYcbJ1AIua/8iEABKbWhOT2sCx6JomtnnigolsPqZNDqFom0En0/pFT+ltwTGG
	n7P8WizeqkqErfpOJ283Zwjs9ua6o2JaKqvBYcWkqaDYj/qDyYtV8m6Uh7ifRVUW
	ZriWCoIYid/BG4AszgTY+1Cd1L/+8ZKsYCFX3WdjxZmh+QJdebRE9Fc90rbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750566190; x=1750652590; bh=9TD5OoVrD+0NQ5k/m/3Gnm/7278qjm5DzDJ
	tl8ZUtu8=; b=Tq9pz8Whfqsw7ppJjq1zDYLn9aT0773Zchkr/9uxVx5yozFQiDh
	0yy2rH6p8aBS2r8HoiwDqn6PkVeDE1RqOda9W9+6Pf75DqYJ2NE00dhpmHWUXKtr
	iVJUdQdl02TCWSKl8b5BYqEGPWAG1A+pYoTGo4FDetF5iDtKzB/K2V4lhpjP3Arb
	nL4C4YzDYBM/EiGLk5fPNNS1jzgOU/yqeg521iP34k/VuQXw6rZiIYQgrpK5s0uB
	nuV9R5ferTRMTdYkzqthC9LN1dsdg+wiVLZxwHHxBmK2FqzNQR3jJnKSTPEKwKKT
	E10D1gitQclJBpbwHnGy9NugiPTYrDTImtw==
X-ME-Sender: <xms:LYVXaDEhARKp-ZRukmaB-bP4VeL3K2ot_cj53lIBmYdMF-d1Io-EPA>
    <xme:LYVXaAVEbw3vy_GBcGD_DKmz3fmrBjkHJ0OGRhirTneJt8-20Zj9VgeBBUDotcAvI
    ygAvXpENlwIZae6jQ>
X-ME-Received: <xmr:LYVXaFLMeLENN6mTIoSyrG1GY3WQm5NvMC0eWbxZFPXEBhq-jIz43fi92lxHxcl1GWE0GXoir0PBmv7qBCthPa2UHVBU43blNTk1quE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddufedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LYVXaBEXfNQ0gxwj0iIMi3uzomUeDylLBtAOGxFgdb_JXN2kNiOPMA>
    <xmx:LYVXaJXcfjNsBQY94yFNDMbeCPxdYzyVEANIfxIHqCzLbLlW4KoJlA>
    <xmx:LYVXaMNldPcFm4vA9dYPB-01dV2w5xaV_0qJiGlYVJ_sVRCMHbcUAA>
    <xmx:LYVXaI0XXkwWbZaTne7eOhg4S1pBL54q0J5L9bcmpzlM8vjMQl9G6Q>
    <xmx:LoVXaNwPb-kRAcL7WniyQjjAnv3ziLp4nZNykHYZ7SAWCKWus3yQTaBG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Jun 2025 00:23:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 0/2] refs: fix some bugs with batched-updates
In-Reply-To: <CAOLa=ZRuyr_DALnjDJfT4F3SJwcExPKZZnf4w6g3+JshBM4iJQ@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 21 Jun 2025 04:08:22 -0700")
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
	<20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
	<xmqqcyay4c4o.fsf@gitster.g>
	<CAOLa=ZRuyr_DALnjDJfT4F3SJwcExPKZZnf4w6g3+JshBM4iJQ@mail.gmail.com>
Date: Sat, 21 Jun 2025 21:23:07 -0700
Message-ID: <xmqq5xgo8kwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> Just to let you know, as these two are fixups to the topic that are
>> no longer in 'next' as we rewound the tip of 'next' after release,
>> if you want, you can redo the base topic instead of piling small
>> fixes on top.
>>
>
> Well the first patch in this series, is a bug fix for master since we
> already have batched updates exposed via git-update-ref(1). So only the
> second patch can be squashed in.
>
> That said, while it is easier for me to not re-roll, I'd happy to do so,
> what do you think?

I'll let you decide; please choose whichever way you consider would
give us the better result.  The second one seems to be a band-aid
that trades one bug with another bug, so it may be prudent to leave
it separate.  It would make it easier for a future change that fixes
the lower-layer transaction processing to refer to it, with "earlier
we took thw two step approach, which had these downsides. now we fix
the issue for real".

Thanks.

