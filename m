Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFA72633
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085546; cv=none; b=KZv+ctjvoPkjnKowyUPFat8QN+54BUp2ZPryUzHeCYjobQY8l1LsBRnld8zw/cmOc46MdUONYuFlCCZMa5eTZZfU4LhkLVyPLMiQB7Fo2VpjW2h5bo2Y/ElgjZnTRYt8U3iI2GIiNHLoNh18zgw2+phQY9W4LJOjrkrGJc8+dgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085546; c=relaxed/simple;
	bh=zSZU9vEsdWSveXBHFGi7DLHiOHLJ6eGHFMxkb+q3O5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fczb+BfSlQkkaFibsSN9T4ViI0JY8WU9RFiZCp7ziJyFD2cxX1swmpSVZoy9cE8azUW4cngVRh6+kZzij7maADnp10Xf+FQA8QXfXYwp/d/Yy97mVVbtLHmcpAdFoSIm5rSLcwDGPbQ66FI99hgpIptCY31uJxCd+SiW5fdzTvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BfKwibsv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFsONne3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BfKwibsv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFsONne3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 893AF14002CF;
	Fri,  5 Sep 2025 11:19:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 05 Sep 2025 11:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757085543; x=1757171943; bh=KmGivFfa+U
	/3hIV6mP8/br5N+Baj1nT4c2o0x6AaOQM=; b=BfKwibsv7F237sv8RO000gnuxi
	QoU4pXZUjjlqRqS9l4855CxhbDx5pClOwRc/xizdAysl8CMKnNx2y1tABcJfJelc
	HNFMRmv8bfI0vSQpf5WZwMwHy2d9Ryuo38eCO5Y6P6dFEPSvH00I5HCrbv6ZYkfs
	q8+TLrLJnTYYaDeAdxSqPF8pwKWWxCjPqtdGEktdLni7zSixGVm2TAx0cW6/q0qU
	LS9VLnKqW2biXlzxk4rNiGy/hMZ/2ukYd7ANHgfheKFVPwGgbTuCQBeTGaDw/Jf0
	cdlFEQXGP3OIlNBUuyuhc9DHKwTvFiRoQ9VezbjoDMdcRR9E2Z8MUOvpygug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757085543; x=1757171943; bh=KmGivFfa+U/3hIV6mP8/br5N+Baj1nT4c2o
	0x6AaOQM=; b=FFsONne3c1XoXZv5A0CskSVSTx4W34hy3Uz8VFHM0FqBDEzjQlk
	j1J5El0uSdaNzoGSQ5j6gOvt3jb86MxD0OA9cinptzUjkAgo6JJSUUgyn6gR0mcb
	sRAASz6DTNOS1zEx0HdLfMoPlyP110mz2myFZiSrR+pQPH0XoAwANdzN9UnLWAud
	W1OsGrvq3V3wl7HzUwXgQhvfQyU9JhQHXPO1mDcNpon/JE4T3CSXy3mplJE5gRi+
	d9bw41S38E8dDYFgNqlu/lJzisSBFVIRrCpMA+X7CxNECST9Xdr6Mt+GOG9/gs8x
	IIARClLDGVKcHu+u0v6cyWxnZcrIS2wXFxQ==
X-ME-Sender: <xms:Zv-6aHIFmztMisf14Fuq9A0lBWAnaKqhfRt4cVtXPp2AfPC-MpXOjw>
    <xme:Zv-6aDkYwdEXe1J-WKbURkMzU4cwM-sFh-kcDxMcaydc4eFP9J9pNbh8zkEzRG04j
    jm9smG6afvmSduXTg>
X-ME-Received: <xmr:Zv-6aAL2c3F04JnDkgQGfFPDEenBYiQqQ_tr-U9qyBXM2V7jge5vu-G5Y_ehymp65xfOG1_pOmp2FWjHWlff10juGb3VCDdLyXL-xE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepjhhrvgesphgvnhhguhhtrhhonhhigidruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Zv-6aA5as2mG2YRIWG2TZKj3KVIn-Iu1geyusFsPYeg6Epwnijm7zg>
    <xmx:Zv-6aM0KXtytRDlnnY4ID76jEpBwzaR1EicC00nC-hNzSaz4ae9M5Q>
    <xmx:Zv-6aOc9wxodg3UumOEVgN_xQ-ADb8T-J6Tkz-pmsgkybXhx-bUNgQ>
    <xmx:Zv-6aKfpgDD-tWar9v2jz_GXxHfN_5C4pu0xaFTZXsiXMYsNajFa1Q>
    <xmx:Z_-6aK6981e-8wihheH-tHWxbdAiMkint4BIUkT7KmIg0YyrGKKDqhYW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 11:19:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jonas Rebmann <jre@pengutronix.de>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  kernel@pengutronix.de
Subject: Re: [PATCH] GIT-VERSION-GEN: Use standard versioning suffix
In-Reply-To: <aLrVQLZpAf-WqFvY@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 5 Sep 2025 12:19:12 +0000")
References: <20250905-semver-v1-1-3f6dd32f71a3@pengutronix.de>
	<aLrVQLZpAf-WqFvY@fruit.crustytoothpaste.net>
Date: Fri, 05 Sep 2025 08:19:00 -0700
Message-ID: <xmqqh5xh3p23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-09-05 at 12:14:38, Jonas Rebmann wrote:
>> In snapshot builds of git, git-version uses a modified variant of the
>> git-describe output, e.g. 2.51.0.178.g2462961280 instead of
>> 2.51.0-178-g2462961280 for seemingly historical reasons.
>> 
>> This is not semver compliant which makes the output harder to parse in
>> tooling such as b4, which currently errors out when using a snapshot
>> build of git.
>
> Git doesn't follow SemVer.  We make breaking and incompatible changes
> without bumping the major version all the time, so it doesn't make sense
> to say that we should follow SemVer for version numbers.
>
> I would say that since Git has had this version number format for a long
> time, b4, which is much newer and should be designed to work with Git,
> should gracefully handle the Git version number rather than have Git
> conform to b4.

Well said.

If somebody cares about the format deeply enough to patch it, it is
likely that somebody else cares equally deeply about the current
format and depends on it, as Git these days are used by more than a
few thousands of people, and "semvar syntax" is too weak a reason to
change it for everybody.

If somebody wants to have their own versioning scheme, there is an
escape hatch to drop the "version" file in their source material,
which does not have to change versioning schemes used by other
builders with a patch like this one.

Thanks.
