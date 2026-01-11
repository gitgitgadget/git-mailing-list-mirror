Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3AD27E
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768103880; cv=none; b=bJDrDmdPnwLms23npfb7XMeaMab4XQoB6bLq3mNsAWRP1eoDJmcICvThQxy6fujKIg+G38asbGEQ3oevkqb/yPd0ZYhbZKwF4vLdBdAUYwWHrQ2pkqDlrc5vEzBfAAsXzpv/ZDQtg/7JE2K/YseQFNDf3KknsQHe9bGu8aHMiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768103880; c=relaxed/simple;
	bh=6ZWOcNKYu0ArXSMrmNXN+5iVNCjAtPrGqDFbJxBivBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FL2V3e34v+4gEgri9DuHkXytc8G0ByWOJzDJPYDO3DtbLLlAYT4PEzaops5ZHDiAFhFpV/9yxybQh8XRMDay0aHYKUPwzl4ZKG6XTt1kA3zdINbjI77jM5mj/K9yNvhvvarjV7R/SGX6al4/N5oXWaoJuZ+vhAN4hmSWI2ikyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fspWxTCW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhHahOxi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fspWxTCW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhHahOxi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CEA11D00109;
	Sat, 10 Jan 2026 22:57:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 10 Jan 2026 22:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768103877; x=1768190277; bh=tYmfO57OtM
	7p3xX1gqG150f88wDkoVuKfuKGVU12qjY=; b=fspWxTCWCzajF8YH/d5SZEITJb
	KZ5OMajqdOtefYDFbA+G8/RjndxLZbCBf7oJqykAlzxSPfsKtAT/gXompRCU8BLW
	S2GhPVBxyB43lbYsa6KZNha+yq0UwRATOX9/E9qiubN7PgLi+WrT45u7YgK1UUA9
	apraTqkNSn47CILmCp//NCMl3T+65Jk9lWzsy/iq6HZOxJzJvF0wg+tP3li+jPWn
	zONgJrRktXO6A0zdE4F83t+KJveOcC1wmniRdzKpVmru+3EEwMp9sBsdlwuoNrCh
	wFyKVYXbevEdL8HIU3/5URtMAH4rNbSokac95Eq9VX0UFoCMCN6K07iPXZdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768103877; x=1768190277; bh=tYmfO57OtM7p3xX1gqG150f88wDkoVuKfuK
	GVU12qjY=; b=bhHahOxiUQc8elXtw4drusq2Gkh2P/aaaixkVrzg8QOob6rKMjT
	Y3cOhh9oA2WYVjvRRA0MnP+ER+HeRhnO3kclgxGfMD4fCctWLgkJDB7OSxJDdRC+
	zXnYsyqx2hnMkUbEB0hXM+pzS+WjGiJERNHFWQYRz01C3iSCXz2o+kAYj0+bKXDM
	aPHAhlLNy87BwCF4sMTpOhz3sN8UoOhbrM3hTGVLzhNXpjaa/kBVy+p5Q9PfJU3Q
	pkuhkEsQJ78mQgPNHgbQD5TupDaAxJUaHly+Z7RpoTRxta99wj56uVhwhWxmvOsz
	BzZ7BNOM5bPZeZVzX1VVDu1tXMuLIQmKZNg==
X-ME-Sender: <xms:xR9jaZHYt6YixElYkT4P6ySMZPjfYyUf-iWZa4OMPR0DflAjLK8TWA>
    <xme:xR9jaQ5cOb-U5Q1BDwZP788PEvMczwi1dSyTilSaHDs1RaJ3bGSwVzMpTk70scTKl
    kmRGn7sRWbmVTdqnv_Dq4wfsyR5gVE1-eEUinSZ8kMjwRqbCYda-X8>
X-ME-Received: <xmr:xR9jaeyaJnwkS7HsYTRfIlhbaYIs15tdRjwT5rWBbdqymA-sOtyf_o7THiJDYUtSczA8n8Wj8Yhp3IJ-FR758BAonyvgDoTqyuS8OaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudefheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xR9jafOzvBJfaBCxwPbU0JRpcxzejTaTT9_FDcB06-Tq6dLsXF9JtA>
    <xmx:xR9jaUkgiaM4KZiAd5j0GQsL2NwvpuEpr47koLY1c6o8g2eMDzfj-Q>
    <xmx:xR9jaUQLUvfKrgQzMs9vJFpIz0YRCPSG8dAc7fnyNIItTU6przFbNA>
    <xmx:xR9jaTXgxCfH-Nd8xCOtyd2--RO09uJ7E2lzRTgLFQpUv1L2QHErKg>
    <xmx:xR9jaZLz34z2f_6Mk-5qAAPycnMYWwBQvQq8M3SyU2y-zlKG0NSVEsY->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 22:57:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [GSoC PATCH v7] add -p: show user's hunk decision when
 selecting hunks
In-Reply-To: <aV_IGCld5T_dBxTs@Adekunles-MacBook-Air.local> (Abraham Samuel
	Adekunle's message of "Thu, 8 Jan 2026 16:07:04 +0100")
References: <aV_IGCld5T_dBxTs@Adekunles-MacBook-Air.local>
Date: Sat, 10 Jan 2026 19:57:56 -0800
Message-ID: <xmqqpl7grebf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> When a user is interactively deciding which hunks to use or skip for
> staging, unstaging, stashing etc, there is no way to know the
> decision previously chosen for a hunk when navigating through the
> previous and next hunks using K/J respectively.
>
> Improve the UI to explicitly show if a user has previously decided to
> use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> This will improve clarity when and aid the navigation process for the
> user.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> ---
> Changes in v7:
> ==============
> - changed hunk selection state message to reduce prompt width
> - Removed redundant `file_diff->hunk_nr` in hunk->use check
> - Made the prompt mode more readable by retaining the space before choices
> - set `hunk_use_decision` to empty string if `hunk->use == UNDECIDED` to match
>   the prompt mode.

The latest "was: X" does look short and sweet.

Let's wait for a few days to see if others have more input and then
mark the topic for 'next'.

Thanks.
