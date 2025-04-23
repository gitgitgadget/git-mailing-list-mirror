Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5992641F8
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440304; cv=none; b=WMSCMv0fwSKY1zCsVa5qtnD+UwKInIsUBuRa9UjtOLHYg5+49mKRfapeD0DNDM2Ggb/znGhco2vxGGzA6JoStGfWhcT3Gky4wo9wuojohClZJ00DWasOFmR10PWLyzMB+IQr0o7VR/e8CnStACI2rtwVJhdcGudr2+rrM5Krr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440304; c=relaxed/simple;
	bh=8UeKf+W/mIyyQRtwl7C7dMQq5RPAp3owMiIZq9AsD4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m0VkUN3uKn1+L0AInzKx9EXCkUPe/ssd3RvSjQMmgiTXgiBoKiRb4IS/WJhollQqXFs7A/ilI1RdblBTjs3ndBwsOb61pxEvj+decohIK9ijEqsn596YChdm94Qbxn5zTnX4QebTc1A8GNcgMo3HnVwAJLxmNN9ynEMld0RAdi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q+vGnBo/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmlF1jLH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q+vGnBo/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmlF1jLH"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 730671140170;
	Wed, 23 Apr 2025 16:31:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 23 Apr 2025 16:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745440301; x=1745526701; bh=UR4hovODbb
	Us5B8XdrwQq4Lqq+pkb+bVifRF9E0jRM0=; b=Q+vGnBo/S8blteUIBPVzcQlW6k
	CnDSa8TYXf/oZm7O4QuPmzsW6SGar6wlTMVwQY2v0InjO5XJzalPcJLTvmYEPuMl
	0WzDHhH+Y0t3kHxiPxVZHoZ6c06nXvMJPfWP7BDxC3Hl2os3I2Wo4d5JOfvAn0dH
	tZfOpit3EZxdKzbeAfDZsrbUgEQ7NO38sKI0fTiNmPoNGD4zbMLxip3uEt/Hb7nB
	x2GeyDayXe7NHSpm/lTB9hVJqE8udK3+goczfClWuAtqGx2JVrnsaBPRP8dVUmvB
	4cDs0nUJ27gs98+x/MSFe6KMdwB3ym/v1QFEHUGNP141y8Ix0Tsu/1CVkhlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745440301; x=1745526701; bh=UR4hovODbbUs5B8XdrwQq4Lqq+pkb+bVifR
	F9E0jRM0=; b=GmlF1jLHZRV6FW6V656wvQEIEG88Yk2iOd2D8Xbq+6twLWPHIoK
	g9FI55zskrKQ8XrZprjwOq8A4nWlRhvfCE8WWTMoXyT8GuKyHSUONccESiY04c9W
	WO2Jf7CGQ26dbVqCKpTiqwSopXpuL9yZ1A6dTGOiDtRaJhAwU0kyIk3mUVArSOkV
	nMiMJnQJddLKFgbPvpyVzHk1NdRi/59iMk4jJWLjpwj7Z7QVnW65iSmq8GSl3dK1
	afPL/lN5wsgxBntRVrkGAetFCx0PuaRKzzXaX/FWmvv45wLgMA9Nc/6U8dL1csLr
	YEzo9brvZnZmvSTtjoq8tG74UB3HAhZvQkg==
X-ME-Sender: <xms:LU4JaOwpL-Ap3xPzXxyefWl3W6SywvD7I9Aut2bV7Rperw9j0akp5w>
    <xme:LU4JaKT9RGkIQxNyPvjA7dqMDrqrPQhnBwEVHWC-6xZMLpCR3qrYn1vXRx71l4_je
    n4Wiy7Ts4DiYy4Zrw>
X-ME-Received: <xmr:LU4JaAWv0dCc9F4acfYleTw_aRx__Lr02us6XSf-QoUn5FKkDV2WXnep_EbtyoOnjzyDP-vvnWndmkHyMcYyRBG4Nixj-6V8ocJl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhoshhhihhhvghinhhrihgthhhssehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LU4JaEhvBUA2udWzl7IPECJlxl30nQ5xy5Rq31T0kmvR10SFH6I4bA>
    <xmx:LU4JaADW7mbEQdCMJs1ty_ekiNly9R8DFT9W0PWQvamcxmHdd89Jow>
    <xmx:LU4JaFK62zCxjHqdB5hovFR6lNSwzOPwFqWUy6Va8F4z90F1OZapeQ>
    <xmx:LU4JaHCSKYmmSwURDxTAfeWZj2sHnNfZDaGrsGveRt2MvdnhAgOxzw>
    <xmx:LU4JaAMo1wJrIJOCaDqveO0YuZ8L8OrqnJeIHpPFgBouqBrhSK3xw7bq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 16:31:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Josh Heinrichs <joshiheinrichs@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] maintenance: fix launchctl calendar intervals
In-Reply-To: <d5cdcfe0-5dd1-46ed-9860-a9949bd6b3b5@gmail.com> (Derrick
	Stolee's message of "Wed, 23 Apr 2025 15:25:11 -0400")
References: <20250421054633.231069-1-joshiheinrichs@gmail.com>
	<20250421054633.231069-2-joshiheinrichs@gmail.com>
	<xmqq1ptl76oh.fsf@gitster.g>
	<d5cdcfe0-5dd1-46ed-9860-a9949bd6b3b5@gmail.com>
Date: Wed, 23 Apr 2025 13:31:39 -0700
Message-ID: <xmqqmsc6wrf8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 4/21/2025 1:42 PM, Junio C Hamano wrote:
>> Josh Heinrichs <joshiheinrichs@gmail.com> writes:
>> 
>>> When using the launchctl scheduler, the weekly job runs daily, and the
>>> daily job runs on the first six days of each month. This appears to be
>>> due to specifying "Day" in the calendar intervals, which according to
>>> launchd.plist(5) is for specifying days of the month rather than days of
>>> the week. The behaviour of running a job on the 0th day is undocumented,
>>> but in my testing appears to be the same as not specifying "Day" in the
>>> calendar interval, in which case the job will run daily.
>>>
>>> Use "Weekday" in the calendar intervals, which is the correct way to
>>> schedule jobs to run on specific days of the week.
>
> Wow, good find! Thank you for submitting a fix for this issue.

Yes, good find indeed.  Tweaked in your Acked-by and will merge to
'next'.

Thanks, all.
