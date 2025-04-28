Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77071AD3E1
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859700; cv=none; b=mlRC9VXMOV3KDs0H38+eFVz5zDtaC+/vFTPcdMx7BhMmYWWOCJ1T0Ax9zbkgHsyOUyzcjeJFOW99j8QiChtA7Kx6DYFpRTlvFPmQXDFN5DepeSAqDYEsjgbxciF72RAcb8ytjQO9l5627F8AHGD9DPWhjyvu6Ms7oFdb70R0iC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859700; c=relaxed/simple;
	bh=1oslylPDJZ3ehFo90zprCFVKpUFbixUUB54i+yp3/DM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KlPYWp5xUkqmqH8fyYp9JiXAH2xkViuT5Po7102xIhrtUyBl5aYRFQtT2ndFb2GKSSckGiRypYSYGTYAQ+KTq08RsX7nntRl/53alxc1cMFmCfpB5vnSNM1K36YkSAyVvSZ3BIWK6crQx0XqbCMLTkhrvcM3eHZ1w6uWisHCM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f2Hgvulh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBKMUDox; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f2Hgvulh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBKMUDox"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F02BB254022B;
	Mon, 28 Apr 2025 13:01:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 28 Apr 2025 13:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745859696;
	 x=1745946096; bh=7dlieUNpcXiNar6I0/on3OG2YdRMDvQIhVWLaPXzfL8=; b=
	f2HgvulhZxK4ZrLuQ4e78BddyHL9cRPCo8qYu9Hj6FJYwdu3AuOehqa4qVssmLuK
	sPvuQ5CpqI1IQuknYmOlphbnbcrASd9/08zBF8nHdo09NiPLxK4R1z30TafAHd38
	0DDhqy60eRHtrH1bdNqM6crbhQtbgsismIBm9a2ml5T5WJqdU7fjypNns60UPLOS
	+4H0Z9FHTXDbwvdfRCqilMwz6MIw08Y4fnIUWTl9MHrL8/Ab2yqUUDEf/9g6viD+
	wB7WObbUbq0SWU2DwsagGetVn0M+RmeH3fbvc134ZovaArjtZfwvaqCduwlYz7KN
	vkEx48XHeU781aYmlKGZaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745859696; x=
	1745946096; bh=7dlieUNpcXiNar6I0/on3OG2YdRMDvQIhVWLaPXzfL8=; b=f
	BKMUDox+HIsA5qiAFHxb6RZDo9wP7T1DSc5G8DlKwnTAtg/SsiwWcq1wmNW8+m//
	GLTuvu1ju3F6L0SsV7ewSoxVgJjLDkiZyLC5TXzgy+vu6SgsGJyCV2m1pYjzRilT
	UcrPrMgsxmDLwUteRC/5GXTWkqcn45mP3rZ9/EyPMZBQq8slyidjYaHNDg2QoO2J
	m6mm2la96jkfhkTsbFvKW+UAH7gf3UzTm3aPrw4aSx0tSWqvTQa9xPGzB4GVuU4T
	EfWv+zJqb/ldZJYEEPjmqqMSrqWqTFtknbcParwwX9Pj++vIAZUDCexViCjH672I
	H2tqMpn+JV8mYPcZHPDsg==
X-ME-Sender: <xms:cLQPaBLFa4z057r-jwTj85TmB6doaWUyh6hO20y95hh1jcIHvHPCZQ>
    <xme:cLQPaNIwfy3_O6MwrpNIY7KecL2OMg0zFbbUA6pLi72krZ5mC4wuOH63rOct8xJKv
    miDI0HO0MzM9SxgHA>
X-ME-Received: <xmr:cLQPaJvN_Llz3nOAf3pn5wFamkIEjgbZgnoULxRSGE7-VUMPHnp8qQVILq-PL3qyq1p7aD4a7q1T_9lZ8ZzIUfDmIvgmMsY4_p2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedugeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvjeehudehgeelheefieevtdeg
    leefvdfftdevtdduffeikeeiieejvdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cLQPaCY5JIsJCeslozrWJuhgVLdu56rYGuOiNpUZWiXFu2S0JlJivQ>
    <xmx:cLQPaIY9EKm1XWT_l0Fi58W4GO2zbd33VdWQC4AyZt10FHEtLxjBhA>
    <xmx:cLQPaGAyn_9yAf_YBQkRqEdJU0toKgaGCD96xgH-ZDnJsns99gNHHg>
    <xmx:cLQPaGZEKAHK_BINI8xpnwYsToETvoGOFQk2yws6_t9mH7XBep5BjQ>
    <xmx:cLQPaN8QcPs-oJ8PwE6PfcgBy51xRGxho-ZJCvhj7QCezO9qgv3fJN4T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 13:01:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(win+Meson): build in Release mode, avoiding t7001-mv
 hangs
In-Reply-To: <aA8ymUzWM2t0QkFP@pks.im> (Patrick Steinhardt's message of "Mon,
	28 Apr 2025 09:47:37 +0200")
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
	<xmqqmsc4uv6d.fsf@gitster.g> <aA8ymUzWM2t0QkFP@pks.im>
Date: Mon, 28 Apr 2025 10:01:34 -0700
Message-ID: <xmqq8qnkdxu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

>> > The reason for this timeout is the test case 'nonsense mv triggers
>> > assertion failure and partially updated index' in t7001-mv (which is
>> > not even a regression test, but instead merely demonstrates a bug that
>> > someone thought someone else should fix at some time). As the name
>> > suggests, it triggers an assertion. The problem with this is that an
>> > assertion on Windows, at least when run in Debug mode, will open a modal
>> > dialog that patiently awaits some buttons to be clicked. Which never
>> > happens in automated builds.
>> 
>> Interesting.
>> 
>> So another viable fix (no, I am not suggesting a counter-proposal,
>> but asking a pure question to see if I understand the issue
>> correctly) is to rewrite "assert(cond)" to "if (cond) BUG(...)"
>> or something like that, so that it truly fails?
>
> On the surface this sounds like a reasonable thing to do, but I don't
> have enough context to be really able to tell.

Interesting again ;-) I didn't realize that it was a fairly recent
development.  0fcd473f (t7001: add failure test which triggers
assertion, 2024-10-22) is what adds the questionable test.

And I do agree with Dscho's assessment that this is "show a bug
without bothering to fix it", which is not what we usually take
without first exploring how involved the necessary fix would be.

I wonder in what bad status would a production build that simply
disabled the assert() is leaving the resulting repository.

Quoting from the last part of my response [*] to the initial report
that eventually turned into the test after 9 months:

 [*] https://lore.kernel.org/git/xmqqil47obnw.fsf@gitster.g/

---- snip snap ----
Thanks for reporting, Kristoffer.

Any takers?

$ git shortlog --since=3.years -s -n -e --no-merges v2.43.0 builtin/mv.c
    15	Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
    10	Elijah Newren <newren@gmail.com>
     5	Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     2	Junio C Hamano <gitster@pobox.com>
     1	Andrzej Hunt <ajrhunt@google.com>
     1	Calvin Wan <calvinwan@google.com>
     1	Derrick Stolee <stolee@gmail.com>
     1	Sebastian Thiel <sebastian.thiel@icloud.com>
     1	Torsten Bögershausen <tboegi@web.de>
