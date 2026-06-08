Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA783AF667
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954599; cv=none; b=jnpMSf45Zl+Tt1e2wS5sd3a9ivAis+avJ2z0KTYSCpsKqAhe5gndogqibaNY8dqGMVRAWd/Mt8XQX3+cz/EcEPvmFe4R20BvnXm1r73YCEGkCLc/+RTKrkJKw9WOfb4pIRCf1o1cS0C4OF7YdJDHB8JpQadmzr6ft8Zf84nmfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954599; c=relaxed/simple;
	bh=q3GbiZz/DwPwPdw0JRdMNp5xLnxMJL4mdHEZYz9Uegc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2mlaTfDyMaSx4wGR7WYHygn6dudz6ghGmHtd2uhFXFxBWyXVxQnP2JUTFJP2I39BkAOAuJZ1Jt6+rjD7EtimYPtra2A8CZTLW7JbJxKLRmXcR1PrZ4iOlS9AJcb9290T3weDza7vo1aapvhyQKLpOkjYtco3lGnspOa05ihgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RxWrvnH9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZF96YD8w; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RxWrvnH9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZF96YD8w"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F86F7A0171;
	Mon,  8 Jun 2026 17:36:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 17:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780954597; x=1781040997; bh=Mh5fKdakrI
	lRfDwKrb6wc9061RNpn7FkM1mltMBiNnQ=; b=RxWrvnH9NYfwOPEriWRb1rhe5u
	Hz+/3Zsv2WNV1toHZllSuuVZ9qitjHqnXAamgSi1hUWM+xCZqEyRv91M5L1EcxZ3
	vY5znd/VLqhqCjQZNmJoCEeTQGc04bRZu8Wb/GhFHxnDydo0VVz3bD4c8o5KolPF
	hhgoOJikETR1RdnPs9RJhMPazNczrehesYqSURW/pTFyJEwIMenO83o4UYDYuNOe
	JEIp22Fi3L48rVo++FvZIptS6wgKymnlJcQB6gnOYc8F0Fxk6b4CDwL6auE5jp3s
	l00FkwB8RlfSGiiRGlZLR/CCTgjLeqIfMOs8npEd6JBIhYIf1YcjuCk2PGuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780954597; x=1781040997; bh=Mh5fKdakrIlRfDwKrb6wc9061RNpn7FkM1m
	ltMBiNnQ=; b=ZF96YD8wYkmWZDcPvP5/fnHrRO4HVS/c2rRl0qpXYvQT9oQqnYm
	5RZ1K3ZcxLnjc+z/4OqEVbCFc+okq+OIl78mAtqADfxKhRjkKrCj6voBbIUtHEV/
	m2v5O9D76DmE++dn/vwOyMEZ98bpNKFtvXJFge8XkE60IO+SZLwlXzYWp5n5XF/s
	PDYrYPPrWgFFtg0+UhCZ6W9QSImKCYFFDkYNOgnlmyQQkHXpy4XEJ0dAMbBKDo0B
	j9OdVPTqAjrsri1pVB8b3Uee9ae/roprc2brcypxqprv+mgCB6F7RXmu90XmKFKy
	nYHcwFLZHLfbkpyHi+QEl4WVU5SFBKIW5/w==
X-ME-Sender: <xms:5TUnar4CLB3Uh9ZNmUrnDJMdSiN0JCpVSbhqu-m0BEP3o8wQSZjUdg>
    <xme:5TUnakkgzTjcKrWUx7Hx-FjUR805ea6AQezV5hongytE5ZrME4wt-C7AhZzvboR6K
    zhIwp6ZtQGRXh01d_tUAV6Z7UFAubGBWqUiAs4IEIRe79pDH4bhMg>
X-ME-Received: <xmr:5TUnasSvZ9ShhW0fNM4fkWrRVsTLN9duYcMURptZn3uYEYqc65WU8bMSpp0_g6xcDz3oXcDr3f2l5-LS51yxwYNPPuoYYsGsTrMU>
X-ME-Proxy-Cause: dmFkZTGaTUZbY+j8qLbZ7oLb3i3yiyLRh4juh7AkaZ9QGDCayC8g6PqTrPQ62pNt8q44pX
    lvnPeL2dTWMFf0d5FlxHD65YZl8VgBelhKa1dBwHaeXZCVv/N6cHU+PdFF68NEp0GBo4Dw
    Dn2W/rcDyJKJpWGGtK8uuG7Wvlf+3pi47hL/5hJIKt0E//JCgWwMdd6ztUYS8oKEFZJiaV
    iKM43qJgc/Kzkroh0G6QSsD2EBgL2FcLOX4upfN2rehr7jwwO9RYgu7rTTEymSZjQEvkcd
    mQoupmK3HVDSlXASqCSUNy/uDSw5BRewQ1q9luqtPYlCd8e5uBwD+hHEBWFOQpCgcJb9Uo
    aKtvO/g3R4H8mAcucm832hEIo4ELvxcriOfi+GYnujIzetNa5g+r8zTnwr4SK/naxjA+J8
    8UJqJeGP+pMHZI4mmVZJY6bEYW44toBm9GtQdCDpoWIIWP1h/MGqTLhHoKe0NWY21YdV+6
    ldNVggNCxB3L/Ma7UREVHsNm2If7Lbc3pz7BuNr+Mnv1Pr4cSRjf38vkhJ9btr4aQJ7Egp
    I5gwKcG5clLX5KedG7bIvm306Jfhg46LG7fN06e14+tkywXiJUo7xWFZVRzYGTw158xa31
    Bqad2GuLHhTfiMd0itE6HFfNSY56pdBmwkWsPmPZiji+ihKfmDioXLO8MJPw
X-ME-Proxy: <xmx:5TUnajFerXxS10ZWIZklTD7kAbw5A7kzIBW419DpVrrrDD7PNnbtQQ>
    <xmx:5TUnahHwEpL0utuBguoKWyXNr3seVLhS_6k6QUa1bhURmo_Ja9AwNg>
    <xmx:5TUnahScm9KJ99p_J8qjETDHIhgsOy5NKIhZB0MsUmGXvnykNj69nw>
    <xmx:5TUnaiLj88KAsgwG8MIzdgRXkOlDTQqioEXaGBGA04OXFI3x6jj9lw>
    <xmx:5TUnaoED9v8ug7YQQAyenTcTt6Z1nhTHWpyvAZBHjBioRQrrGjFH-1Op>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 17:36:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Michael Montalbo
 <mmontalbo@gmail.com>
Subject: Re: [PATCH 0/6] t: add lint-style.pl and convert grep to test_grep
In-Reply-To: <pull.2135.git.1780559158.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Thu, 04 Jun 2026 07:45:52
	+0000")
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 14:36:36 -0700
Message-ID: <xmqqldcovhnf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The test suite has a test_grep wrapper that prints file contents on
> assertion failure, making debugging easier. Many tests still use bare 'grep'
> for assertions, which silently swallows context on failure.
>
> This series adds a lint tool (lint-style.pl) to mechanically detect and
> convert these, then applies it across the test suite.

I do not think we want an automated tool that rewrites the source
files.  I was hoping that we would get a patch or two that _adds_ to
existing test-lint framework (i.e., 'test-grep' that 'test-lint'
target depends on in t/Makefile) that gives diagnosis in a similar
fashion as test-lint-shell-syntax and test-chainlint do.

Also some existing uses of "grep" are not end-user facing and should
not be rewritten to "test_grep".
