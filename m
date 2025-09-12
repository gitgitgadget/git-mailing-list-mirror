Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D67221FCA
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694783; cv=none; b=mu2aI8iyCRKf7WLQVqE2WNqmcJMHEOPj6oV9D6/Bcri0/Mh9zq8VJdQv0KxyaNSsNPZn38SkjpK06AK2zA9u2EuzXJGopFYTzAu1dOWapyu9EDdRpY2un1+GpQk0YW7b+cO/lcsuOrfPZaA7GfAHszMKRO4LWfnKzpWCK02q6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694783; c=relaxed/simple;
	bh=Vqd73kfgK6Ob+o1ieKtC9eTJ7pkljLWrQtnxPyYG/jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qiya5qtLqn6uxDfjB+yEvDcLwzF5DUJE/3UU4ObYKg5hwMSvt221/ZvbHGVOB1PkiHB7XXYbs3l3NUfI/CgZM6DaGMx6Ll07il7pRMrezc08QprJ4ADwPIAvexoZG+Fn7AN3uppK773Py/7NVBhG8snDPOj3ZBFuZs+M+YoE6JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=19LpjqRu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k+zC/KJI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="19LpjqRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+zC/KJI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 064AF7A0169;
	Fri, 12 Sep 2025 12:33:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 12 Sep 2025 12:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757694780;
	 x=1757781180; bh=x8bUR4Z6lqme3V4q1q2mGUO5Fmv1C2QNYnx11c6ntdw=; b=
	19LpjqRuwHBQ8JlT//x0J6Pat3BVBRAH8x3u/goc7rruXcw1wHNOEUi7kM2obWa7
	gadHLwdhKWGHTkN/CIHlpXyBOzBWSyP+Jj9iRdE3apWQlxeYlFePHLL3p9nS2Oud
	3sYEeZJqkVvWSQW1lfpwTrifwXT6lv6Nxf0w11uoDuhT/83bqVM03k3tXJNpWbQO
	c+Pr001qUzUcW8TFweDiu7+4UI8XZXF71xqXUZ3mrgj8+waGB3+kl2hs8IJBHTUU
	zDv93B8s9HgBtpMYVq/97zJWTo5sjgWU2/oFRpmVum+w1ycLuNPgnMYVkd5lolTk
	9WWehSJdiZ9dIrR1dMO/Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757694780; x=
	1757781180; bh=x8bUR4Z6lqme3V4q1q2mGUO5Fmv1C2QNYnx11c6ntdw=; b=k
	+zC/KJIH7zHBefAwpefcYTif+vhD/er3rBqC0XlT7Q4Q9wAinQ0jjFk49nIEe//W
	eJTyOYkOyWqJ24zDofB9F6Pve5vp4hlKeL3W5uvwRja/qUDuYDj0EeXel7fu5C1l
	35kbIwm1VhcA1t/2NdhVdM2XwUy0HSbGcBP7ZDUwcP+O6wUfAG4Ur5JSaQeCvkIi
	Nft/RHgQB274s+RtZlaL3YG8fAKYKVFueOrKGagKtPFnqDHNpsX3My0zsj85Jlm7
	ZThqUjeEXXWQRsbkyHc3oio9wOkz9cIZNTVVqk/ey7M/EaXkdSr3G47hRMHS+oLH
	aLHAfVAldNoV6bzXh/EgA==
X-ME-Sender: <xms:O0vEaAGcK0EKf_pZ1RSYeprnNAzy5e-_sswGD5JOnnEaGOzb6V_rgw>
    <xme:O0vEaENuohIOEcpKhSa9VGcqM5F0NcejmZXDN5V-Gv_eGlkvsSDIp5nCpeJuUGgIn
    uwus6yK3jCB2Fx5kQ>
X-ME-Received: <xmr:O0vEaEVwY29ThFJX2DJdbvVnHm45Un5BEoDVUZyhxIeUD82c0aUOvxSUcFGgwLxSgCxt7u30fxcA9G1846lBhShY8Tq8zApZsCpgwP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrd
    hmvgdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhn
    khdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtoh
    hordhorhhg
X-ME-Proxy: <xmx:PEvEaDwJ0OnKcwFucsi6ydlYVtgvTf22CSXRnwJjS-mzLCtEx9qFcA>
    <xmx:PEvEaMNUaD1OTQ8ST2bMT6G9zPe0dadhZvO076R9yUnYw757ck2nKQ>
    <xmx:PEvEaNpOBP7fRTbnwKRRmqi_u5tBpqIxXCfZIvFltR0SD9RPmVJk7g>
    <xmx:PEvEaL84J3F9t9yQZmsybyDJ8_Iqd7lfCsGQ4rx8_CkOuewBHGym9w>
    <xmx:PEvEaFFwm5vfUmnSbKoYGpgzEQKp3hgnSg7ex5iKBxEixgcKv-7RsA36>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 12:32:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "Haelwenn
 (lanodan) Monnier" <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 0/9] Introduce Rust and announce that it will
 become mandatory
In-Reply-To: <aMRADFAoh68aWkdD@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Fri,
	12 Sep 2025 17:45:16 +0200")
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
	<20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
	<aMRADFAoh68aWkdD@szeder.dev>
Date: Fri, 12 Sep 2025 09:32:58 -0700
Message-ID: <xmqqplbvmy11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>>  3:  ccac54a247 !  3:  873f9d82f5 Makefile: introduce infrastructure to build internal Rust library
>>     @@ .gitignore
>>      @@
>>       /fuzz_corpora
>>      +/target/
>>     ++/Cargo.lock
>
> The Cargo.lock build artifact is back in .gitignore in this version of
> the patch series, but the 'clean' target is not updated accordingly to
> remove it.

I too noticed a leftover Cargo.lock file but was a bit too
distracted to report it (and instead kept going with "git clean -f"
X-<); my bad.

Thanks for being extra careful.
