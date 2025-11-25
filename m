Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B223ED6A
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101212; cv=none; b=CFs2K8Wbr0RXqWPij1hBu1QdaBjKOGvrxeqUlzTvmJIeROUJ08NiclP8jXMINL0nfLv+KC5A+I0EEQpP2HD6Mob5PZAKv6OHsi0bqWdnKLc4WkZ0SUhi8xYa12I3k7ShZ+wVrY8+S4T5ugCJ2624eHpIx+DSBXK9TklqaQvdOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101212; c=relaxed/simple;
	bh=hCyZIVDKgWW8m1Vc8EKXlCggw//9rqcqQu60Qf6hTPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FiAGd0JvIEg/ABDde0H9luK2h+ua2zHYuQxVeKaS73EGQVso/mhnlWNM7qrCDg5b4oGqpx+Q7aaKarVwySkbbUxzxQHAvLY8BITNzKz1a6oeYIKB9Tc9W0KQFKUq7I0Oom45LlY4vYELlSIZ+GYMWlRPivca+Phoi1O4kMjBATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ub1ZYXBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgLVB0mR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ub1ZYXBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgLVB0mR"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C905F1400151;
	Tue, 25 Nov 2025 15:06:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 25 Nov 2025 15:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764101207; x=1764187607; bh=B26Ad0J9co
	Ommp4Yrtvx1pPDK4HlhGdE/b771UsQOCU=; b=Ub1ZYXBpcTZlARALUmGAvfXhm0
	l7+d6ZJFvoEuJ38WX66vu/GIGtl92425eYL5FGKCX1/FWVh4b9u/sWvUtKMBs3Z8
	KKF5ays5do+J5FM9TT9eDiIVPu6rdJFJUtyniTC7N6OoRZoeegu++7uiuOpzfMln
	C3A7kpC9B/IXjzc58Ef5R4Vo5lcGKeoDR7EQ9nNRkYRUExOkKGLSE8zZz6bt1VOf
	apiKfniLoE4Ff1JegpIjGrunHjagaSmKxIvT6zZz1kH0IS4fQH+Y9dmxqlecOE9U
	8vL1d+rbOsGZbphg5/KBBjoL2hgc85rv2dFnpR3sqRzgBzCcYpTpmSlh0gqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764101207; x=1764187607; bh=B26Ad0J9coOmmp4Yrtvx1pPDK4HlhGdE/b7
	71UsQOCU=; b=JgLVB0mRSUpL/vtcMVWEjZz4pYiygy06l94uz1LYaYMMmMAjCgu
	I6t7Apqqc6RURBYDTjZdiEPDF6sKm8QfkQkrWA3lf0xdsutni0QgQpxP1ZnO2k0F
	L3og++T+y0Kk48M2zl+fIVcPzAMMBFGuYx23g3LULgnyeDflo+8Dr5KXGlIy8DLP
	BijTihLSaMK4I6bq98YZdOPjYHDYmulbFSil8+PjmkcOznFBwMR6cECDBBJUGmfA
	t3/9kZ8JKk81EzFR50upVyBbh7BqUaK0WxrXLm7ieTr16aSMpn2+enKVLKMIh6eg
	cGuge9cVFvdRZoY6jiC9N8Kuf8fInBQq1+Q==
X-ME-Sender: <xms:VgwmaRaxzRCNc6aQZPbYiRdnXaqrAwLNMUcJoibwAGNHjugVoDsN2g>
    <xme:VgwmaSw_K9DvNlKwzX4tvsY5y34Tts2SldHXrgpcm6BXvfEGV1346vLRl_lp7ShLs
    5jGql6qtVd44261iqNw5hqvPGvO-Ip7iw0BxBJuHIiNpSPrbSzbB4A>
X-ME-Received: <xmr:VgwmaaENgo5a54Fl6qxVqOMSaw6kCDciNPaBx5ffguVxPcB3axPcZJWkC0ailtO4-Kr6SEjsjk0l9_JN_1K9M9soMqjuo3b-pYR->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:VgwmaayXcc85CObs4vprk5hRA57yt3ZWXl7JUI3qamNFTjtT29BIeA>
    <xmx:VgwmaVMhXfDP8BmSvw1ZnVkKyhLtnUfPAsvRoye04gHuSstQrO3h6g>
    <xmx:VgwmaYY1xul35XiGc6kSPkaFAendu_cJo-71-3pUxoNSSdIw5RFKow>
    <xmx:VgwmaUCe5okpsuSpcltO-Na_dbMG1AsCOGdAcieV_4aj_7tyugf3DQ>
    <xmx:VwwmaR2LxwuZ2tRaHykpKV0vuscpCUSg0tScgQFkUnFR3yGYziEDY2oS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 15:06:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  newren@gmail.com,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
In-Reply-To: <xmqqjyzdrjf1.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	25 Nov 2025 11:39:30 -0800")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<20251125170056.34489-2-siddharthasthana31@gmail.com>
	<xmqqwm3drk6m.fsf@gitster.g> <xmqqo6oprjti.fsf@gitster.g>
	<xmqqjyzdrjf1.fsf@gitster.g>
Date: Tue, 25 Nov 2025 12:06:44 -0800
Message-ID: <xmqqfra1ri5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> By the way, I probably would not be queuing this version today, as
> this has obvious conflict with a large code movement made by
> Patrick's "history" series, which itself is expecting a reroll.
>
> Perhaps collect review comments on this iteration a bit more and
> wait for that other topic to be rerolled, and if it turns out to be
> solid enough, base a v2 of this patch on top of it?

While I cannot test it with other topics, I had a chance to run
tests after applying the patch directly on top of 'master':

    $ make CC=clang SANITIZE=address,leak test
    ...
    Test Summary Report
    -------------------
    t3650-replay-basics.sh                           (Wstat: 256 (exited 1) Tests: 31 Failed: 5)
      Failed tests:  23-25, 27, 31
      Non-zero exit status: 1

The first failure was this one

    expecting success of 3650.23 'using replay with --revert to revert a commit': 
            # Revert commits D and E from topic2
            git replay --revert --onto topic1 topic1..topic2 >result &&

            test_line_count = 1 result &&
            NEW_TOPIC2=$(cut -f 3 -d " " result) &&

            # Verify the result updates the topic2 branch
            printf "update refs/heads/topic2 " >expect &&
            printf "%s " $NEW_TOPIC2 >>expect &&
            git rev-parse topic2 >>expect &&

            test_cmp expect result &&

            # Verify the commit messages contain "Revert"
            # topic1..topic2 contains D and E, so we get 2 reverts on top of topic1 (which has F, C, B, A)
            git log --format=%s $NEW_TOPIC2 >actual &&
            test_line_count = 6 actual &&
            head -n 1 actual >first-line &&
            test_grep "^Revert" first-line

    test_line_count: line count for result != 1

The "result" file has 0 bytes (hence 0 lines).

Actually, address or leak sanitizing build is not needed to
reproduce this problem, it seems.

    $ make CC=clang test

Was sufficient to see the same first failure.
