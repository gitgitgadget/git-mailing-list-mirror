Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CC22612
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677492; cv=none; b=crxbtceD0f39EYnCs/ouwyUAWxhVGn/sX24XXuKnfCSbPyBotnCKqjHvXoXI0c760al4naUDmC/PD9zSvivkRMGVOoMem01itrnrbz5qX/MU+M70BnsVl3UAIUChQpI3FcDrDzH6EPWuSrCoapvHgqYRaJw+kTI6b6hIFtjJXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677492; c=relaxed/simple;
	bh=SdO5j6gnqHKa6hP3qIBFgRcjc/mcS3cQWmgSo1wvS4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sY8AVGi7VPNCy64ZPmxx/BSJ3COLl76uoDdpk9GXjiESC2tjdlmisTfkG3QAZOws6tmsOEbmdKbRt8Y0NETftGhqyMWvKJTZCNjDplsqJ3T8Uq0YC1MpofoDNRtSmu5Ks9PhE/itWcPQI5gjsbupa3dI+ZRuXlwCHE3exJnKyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cY0p8YDV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSWcCPaO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cY0p8YDV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSWcCPaO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6E60525401CA;
	Tue,  4 Feb 2025 08:58:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 04 Feb 2025 08:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738677489; x=1738763889; bh=2sxfWNM9cL
	W2hn0KK/4/Mkwwo77yoohDLJnalICjNK8=; b=cY0p8YDVmJJ48E5+HrOX03Yl2h
	mouAXsqvY7mOrbqdL24yh7MC0DdakPVm1NC31B0pmDlDCq9ega3HtNhhHotWizWp
	3wZmTxR3Wna1LC3c1d2silQKPktWz0bJVG0a1henbeqfzpy0tL0j9do/rl4SpHrC
	jmhNSjvjWKf86X+i/8tF6NqE4KGygQ4BBizfw4niq+KCF7FZE1ZwEoU9iR6oILZC
	egxSVcK2edRDl6X+I7sSMe44IIZ5Bjtl+q9dzXz6dfL0xYk3eDBLVKt5I2Eo92Tj
	mJZwMNOD1SeVKoshT2p7JVdNcHDGLXuEv/Ji+tew00McoFBHewVCLuSXkesA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738677489; x=1738763889; bh=2sxfWNM9cLW2hn0KK/4/Mkwwo77yoohDLJn
	alICjNK8=; b=YSWcCPaOY+IXWIe1OAkxpdyc1LTr5jc+aJDVf3tQsE1Vr/OqYR8
	RdxoObqCA57XzdCq+beLZtHxKySeoALxzMAoEnXOZXKLyAq5UuMdVGRvprLRAfZY
	VyQz1mXp1d+V9NFye/thJegOcHKjp8Uq/4w/emokSHO9DWBNq1YnziB3OLdIWnEP
	j/1y+hQTWtToNuzOdsMj1YXcs+eYkRYBQv63Ir56KpPJkRzp0BMKsUd31pbLhr/o
	dkqJ6UwcLNY6PWYeUvoiFG4ZOHIhfo/LPIHQ/la8V3xkSAwHWKtSfdVni6i6+xG1
	NVq2G5UuOkhnMS91lDvamaw+FFCuEjvv4UA==
X-ME-Sender: <xms:8ByiZzY6pJj7IDPastJ-DsFhA2F7Wvyrx1WLfjTDy9YmcEiHggNzjA>
    <xme:8ByiZyZp908FjHyuiYQ00JXmlpbtf8R9m4tfpXyuBRaZvfqVyWXHKLH5IhJhiHtrn
    IUsUAXpvSGILIzgAA>
X-ME-Received: <xmr:8ByiZ19BOC8TVA1t0rBKc1MUlggPV3_W2NiDTtK6cbfpnXAlZCBvE0EOM-JA8xLKEDJxUuVaKAFSGyc3W3EohFtqbCoEZdsauWFj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvggvthhsohhnih
    eftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhusg
    hhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthht
    rhelgeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprh
    gtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehlihhurdguvghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8RyiZ5qbJpDTd-wP4PohB2xbwR_V4368QxCFWR6S0jG6aykll9sEBA>
    <xmx:8RyiZ-pgeEorhxwZa13ImJiHrujl6EBFjTCvZrPP-RqNvPF0FsOwmg>
    <xmx:8RyiZ_Qb8qA8rX2-PAw7bqTqDm-SDxe4MhBqg69f4EWHfgwgAeBrEA>
    <xmx:8RyiZ2qwwNsvk4HOBMycRCPDbehM4Lml04u1OYLxeMKu-O7jwJbO7g>
    <xmx:8RyiZ93W4UV3APu7ibd2RBg4zNJUJULwYfpKOqnqtKZOV2PPtRGZZQt->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 08:58:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  shubham.kanodia10@gmail.com,  Matthew Rogers <mattr94@gmail.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  Jacob Keller <jacob.keller@gmail.com>,  Denton
 Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 3/5] refactor(remote): rename query_refspecs functions
In-Reply-To: <CAPhwyn0-Hq5WHWvGzhqwafrJqmDic5+_S7hRxShk53d++hfw8A@mail.gmail.com>
	(Meet Soni's message of "Tue, 4 Feb 2025 09:09:03 +0530")
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
	<20250201064202.76116-1-meetsoni3017@gmail.com>
	<20250201064202.76116-4-meetsoni3017@gmail.com>
	<Z6BmKO-034bqOCjS@pks.im>
	<CAPhwyn0-Hq5WHWvGzhqwafrJqmDic5+_S7hRxShk53d++hfw8A@mail.gmail.com>
Date: Tue, 04 Feb 2025 05:58:07 -0800
Message-ID: <xmqqwme5vmkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

>> So:
>>
>>   - `query_refspecs()` would be renamed to `refspec_find_match()`.
>>
>>   - `query_refspecs_multiple()` would be renamed to
>>     `refspec_find_all_matches()`.
>>
>>   - `find_negative_refspec_match()` would be renamed to
>>     `refspec_find_negative_match()`.
>>
>> Patrick
>
> Thanks for the review.
> Meet

Yup, using predictable names that follow patterns based on
easy-to-follow rules is a very useful tool to help developers.

Thanks, both.
