Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DD286D40
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548956; cv=none; b=SO3O0S6cl7PjOWIdeeltzoNS0a32GUHMkKULstVgLqHXMIJZLD7XLiLDMVFSDZZMGKoxgsbj5d69CiM+wkL8FP2fVMxEpFBuH3tX5JjWcEGOl7fysJMDZoBCpWrkYeCqwl5EyRYZZZdyG4AhQtT8xMkM8wY+OIj0WO0BJVsoMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548956; c=relaxed/simple;
	bh=CFgAW95iKpuO1K5j/e/Tam5vXtxr+405YtHmsdRz4EU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rP0iopE+gBgDd7IxW9NYs7LtT5XdB5h3rk46YxrZ+NmVfTUwhJnahbNdbiJp8Y25WmF8BciiNlVg/Zo0ZW73+/7iC7NJmWDppWujBd3z6Os6QdVk7Gmc9uFto4pnLcgvN1SlThcoAC13iGjIPxY1wQQ2bdXpMVJLHuYER1xxdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=quNCrBVh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZ9snMFS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="quNCrBVh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZ9snMFS"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5F8514000B1;
	Tue, 27 Jan 2026 16:22:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 27 Jan 2026 16:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769548954;
	 x=1769635354; bh=TnXPNFhw6JE0Hykz8pozWrW6Yw45Eqr8sBCI93N8dpM=; b=
	quNCrBVhR+HVYu06MYr0bt/Pkgt2MXVWpYOy3OQJhikUxT8BLYwWMjrI/d9Qg647
	UTSt04+lSYpQLrW1WWGMfLgz7rX39VMO1u+VinPAXl3auwqAPVrfJwKVqfvBBiQm
	COfaQR+R3nqfbkZY66QOXDMs0v8wSI4GSTCf2fAM2FAEAm7xd0Bq2tUR4+0bFxwl
	OGEJJ5BXu+MsSrfv1sWE3edtsKWgvo8l/1eP+Q+1wnMRtHWkdkJNVxZVr8pCGTIe
	jpq7DqA0L3/9NRU10woYa6SSX8RsmFgHVNpyPVZ4FpCfdR9MJt+KrGciMe8DdZtU
	5mwfo15Xa+O0ZYnJahm+TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769548954; x=
	1769635354; bh=TnXPNFhw6JE0Hykz8pozWrW6Yw45Eqr8sBCI93N8dpM=; b=E
	Z9snMFStXfvI/PQngKHQxH6JU1WTgqd9gr1PuBaJVKU14+tz7sYt+4aHBMpZgT5r
	fEotMaRi9WXQX1EXYkv28c8qa3qsKmyX5//0gbrN6V7aRCoqBEYRCOD3eGIiw5nn
	cZS/2+No39mmQbgvzU0ymyBTUy3xuSdklUjcwAZ29WawztEKEhzHHF4kUAF3lnqj
	TkM9ffUfbdqD11kUj+mvsoKm7jD7xLT0Pd/9xehVdRCPj3PSxS183niBPmqpJch/
	WGt1bIoioUKkzOZ3aySM5bTyKs2oaIPwFBqAPUT6KLU12kywiRJl96omNUZD1GDB
	BRgjAN5yAAP5b+WjjHn+A==
X-ME-Sender: <xms:mix5aS3mw98TK6Ce8BtDw-3p_Hte2Vgkx-kpWtI4jdC_GsMW1O39pA>
    <xme:mix5acEv4OHyTDMaoTEOTk9_pqJa8XrxsWowA9mjLEWi7c_rvFH-zsBpNmfYmkZ7J
    -Nv_LoXpxMf0cvs4qQ0IrIXhc-F_ocN47jTcNbzDs-e_UZDHINpUtY>
X-ME-Received: <xmr:mix5af7IMWnCOOkFyOk42DcxyQtuhjJWEoEJA-jFE3IOd4bDJ4SVS0fAldMBuOuh_IRrmlqSE4OEmphs3pZ-VcKH58hcM9PYJxMp8O0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptgihqhhsihhmohhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mix5aSvWDuzSasy8jOdMT_L9YQvOLK10ArGxOZLLDxFdWIYQWCplcw>
    <xmx:mix5aQ4IoT2LfMaV0pDKHiXTtATAVj-jg-hIQSuUjeFf-pQczLo9JA>
    <xmx:mix5adVPS8o1U6xLS3h33f5Mch84B7VdmpLHdBe4AEeUE50_G_TV7g>
    <xmx:mix5aS9vEaJbff2W5kwZlLvXTqn18TdoTT1APQ6zJx5ofBLy2k40Cw>
    <xmx:mix5abbYzOTnVie9rotSjWTn6vENOk5VKd-Yzbx7psqQ5PgnS1BdQu-N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 16:22:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Simon Cheng" <cyqsimon@gmail.com>
Subject: Re: [PATCH 2/2] checkout: tell "parse_remote_branch" which command
 is calling it
In-Reply-To: <fa7f1648-3cf6-4e5f-bee9-fb5e8700d01d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 27 Jan 2026 21:35:43 +0100")
References: <20260127192936.904719-1-gitster@pobox.com>
	<20260127192936.904719-3-gitster@pobox.com>
	<fa7f1648-3cf6-4e5f-bee9-fb5e8700d01d@app.fastmail.com>
Date: Tue, 27 Jan 2026 13:22:32 -0800
Message-ID: <xmqq343qg38n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> +	# DWIM
>> +	test_must_fail git checkout trunk 2>hint &&
>> +	test_grep "hint: *git checkout --track" hint &&
>> +	test_grep ! "hint: *git switch --track" hint &&
>> +
>> +	{ git update-ref -d refs/heads/trunk || :; } &&
>
> I don’t understand what the purpose of this is after `git checkout` but
> before `git switch`. I can delete it and the test still passes. Is it
> post-test cleanup?

Just in case "git checkout trunk" that was expected to fail still
creates the 'trunk' branch by a bug.  I do not want the failure of
the next "git switch trunk" to be due to "hey, you already have a
local branch of that name", and make sure the failure is from "you
have two remotes with trunk, and I cannot tell which one you meant".

>> +	test_must_fail git switch trunk 2>hint &&
>> +	test_grep ! "hint: *git checkout --track" hint &&
>> +	test_grep "hint: *git switch --track" hint
>> +'
>
> Maybe just the positive greps are enough. I read these a few times
> because I thought the order was wrong, i.e. that `hint` was overwritten
> before it got tested. The regression that they test are unlikely and
> these negative greps might not make immediate sense for future
> readers. I dunno.

Possibly.  These tests to expect concrete strings in the output are
already familiar with how these output strings are built, so they
should know that when 'git checkout --track' appears, it is very
unlikely that 'git switch --track' would appear there, for example.

Thanks.
