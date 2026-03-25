Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F723AE87
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468852; cv=none; b=nhyN9S7YJS/8o87qDn39XrF6lwWyYcavtKW/eCnwFXVaEjV67/jzyC08cbCsXjCSkLzLdbhQcj4aNEFLLSxVyoDsKcdr/AQjYnraUp1gq7+Ex0Cjb3X4Pt+12rwVCDQskN4Z9Cc11HtpxeIjS0PAJUa99/iFmaFEankkUDMpgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468852; c=relaxed/simple;
	bh=KCVAm3d82xuIQ2TAi1CLy2iYuXPgwW1WTxOQcTK0Fg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eGa+dMNsFgYzik9CNTQrmHtkFTpRplP5VnFPTuhP/odrW2Xkc4G6Vh/QNXlsvylYAuUBIcCyQDbYEOednpLnntgImRG0B/0E2Eqa2F23Od+OGex6n4Kdsd7JYMp0i3NP0ZtlV/WGLB4ts+yUHPG9iydqCPyCT/29V4BOQOF6oog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PLJ5XuzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CC/cCBS8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PLJ5XuzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CC/cCBS8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 207BAEC0260;
	Wed, 25 Mar 2026 16:00:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 25 Mar 2026 16:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774468850; x=1774555250; bh=O8LibyGwCl
	XTwy4GP1GrFnpj7+zPuJ9ApwwRGKwplPY=; b=PLJ5XuzEIvxC7Y7mtmb6VyQyFn
	aXjhcFZNgsnnkki40666W8IKnUiZOzYNAIAia5R8kC3204eSV61/7MDE4PDdsxEc
	e30qHXeEEhpVU1MgMdp5el6HChgTyOTZ9amHz5W5M6V9Od25VJjkL9ED8l/7umBZ
	WDJSlM6K7zWEDntoC9CQvK4HtBT0g2FAceZYVAGABGlv1GGpL0MIuuRdUFB37sr0
	K1L+alyYrgeVVEUj8KZp83824bv8ZuJEjoS5pvJ9k0iwrKmzy5PjXhWUFII5U1Im
	fqGp0kRa8vrHqJEClo40qqpBIMTU2UZWrXB3qzCj9ktsND/n7+a2nMACDv/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774468850; x=1774555250; bh=O8LibyGwClXTwy4GP1GrFnpj7+zPuJ9Apww
	RGKwplPY=; b=CC/cCBS8g+QCMO363DrdZA8nFGXBDWHyvq1Mjw64fVvcB0vLe9Z
	mUdTa7z3o7hQiORkjchB8fLdDlSWaORmYyII0LZVUJIBRt6IeOvMQ2Uiqxt5mEgM
	THb5gnupVhyftLZ6ZVMZt6++bbHEawpvLccRPttY26YxfF6XqoxmfG3Jxjq4S14d
	nz9dFMAwyQPDIrOvbUPR8Vn45viLYBG0XhIdOV5rXUFmrVjoktGkiogvq1OoEVlk
	squaZ93Xa9ewQ0exobCkPcZtbJVStqRkzIaqoqO4GNvExD1w5B6+Sn5WEyDdKYtS
	G8dEusBaIWU4GkTPc7FYbEqnA4ArMOoLscQ==
X-ME-Sender: <xms:8T7EaXkqhlfgcqLUkUDUzGnY_6jipd85Tt-q1NPEd-o71VX5_0QpxQ>
    <xme:8T7EaegMRtujKZ9PcA5StjOADjX6BeX-2gLd4Wj8osWanqW_uelIO0PtmC2irZh7q
    tTa8UCOmw7u0Y44mvtnxcQpdHQjUFuJfLssLoIQo6jgG8IDDOJXdw>
X-ME-Received: <xmr:8T7EaXdJD6udE1irUHivkD7zrobbpjSxB307Q2-fkzB64jDU9s7m0dNaSvV97YTawadqa_Cz6Knx13q0CnNa2ZV5E8Xt-hmG7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtg
    homhdprhgtphhtthhopehgihhthhhusgesphgruhhlihhsrghgvggvkhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8T7EaWihJGHFN45syrWQZdCV-Ju4SJ9NIpit0oPrVr3kgcusNKetXA>
    <xmx:8T7EaXz48ac4-_Qmk6FJhlV575MYXUKdaGkXqwcHStUrMzywThW7mw>
    <xmx:8T7EaaNTxhDNiBvz6ngQtbCzRhhEz0WuWvl7KA-9O1XbN-xDiB5lxQ>
    <xmx:8T7EaQWF4tVYVmSptF8k4B7p-mKgj2Tjcn8z0f7dCqIfnBxLgeM7Dw>
    <xmx:8j7EaSsEiQbGvA84UZsJeI2c41FYto7v_ZDZApcV4J5ZspskA2ifzskK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 16:00:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, Patrick
 Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Paul Tarjan <paul@paultarjan.com>,  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v11 00/12] fsmonitor: implement filesystem change
 listener for Linux
In-Reply-To: <aakyzGksiC2fhhiD@pks.im> (Patrick Steinhardt's message of "Thu,
	5 Mar 2026 08:37:48 +0100")
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<aakyzGksiC2fhhiD@pks.im>
Date: Wed, 25 Mar 2026 13:00:48 -0700
Message-ID: <xmqqwlyzsmq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Mar 05, 2026 at 06:55:00AM +0000, Paul Tarjan via GitGitGadget wrote:
>> Changes since v10:
>> 
>>  * Reverted pre_exec_cb callback back to simple close_fd_above_stderr flag
>>    per Junio's clarification (same as v8)
>
> One ask from my side: I would welcome it if you slowed down a bit with
> sending out new versions. Sending three different versions within a
> couple hours without any reviews in between makes me pause, as I have no
> idea whether the current version is good to be reviewed or whether I
> should expect another 5 rerolls.
>
> So please take a bit more time to work feedback into your patch series
> before sending out the next version. It's totally fine to wait a couple
> days between iterations.
>
> Also, could you please clarify whether the patch series has been written
> by AI and if so, which parts of it are?
>
> Thanks!
>
> Patrick

The topic went totally silent after this message; is this topic
still viable?

Thanks.
