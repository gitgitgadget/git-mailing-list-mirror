Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8712E406
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486863; cv=none; b=YtZfdkOoHoitu4q0D5npcxeXxOz2M8EZtCycWfrM8ItlISy5me2Td1qvMeVWiwpfORMuSo69jflZBnNXKk/rQTgEkEs8cE+iaW9gI2etbgNZgpXXHqIMU/hdp46//000RAU310SrlRRdjFZaxNG9jC63JQ6t7C+4DGSBZ+3b8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486863; c=relaxed/simple;
	bh=S2dsJ1wpUtvjE2Z9fpzGfqN3r0b5N7r+ah5N4EHID9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KjgTYkuVOjFsst2GqMJkInflPn19vTuczzFv5AFk8MGKUm+rpMiqknyvWQPC4kGBXRE6zuPu57Dq/5VavmeeGt+DOJQHr8p1T2bKNYrk/l8yV4Gh7jZ0GaHO+znv9f3U03dl5ha7N5AymOCsHpVHn//+M6p4QkQLCSP6yBGUD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HAfCT27a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+M7drQn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HAfCT27a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+M7drQn"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F064114017F;
	Tue, 21 Jan 2025 14:14:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 21 Jan 2025 14:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737486860; x=1737573260; bh=ZcoaLmzUl3
	6aEgL/J0fInlfggszRP/hO9CK5+yjTiDQ=; b=HAfCT27ax7KDQswgPJv2FHmLFs
	NkL8JQa4/Igeziq5AcBlsNl/K/+QSnjelgz+0sLDodArzP2QBd3O/lE8GuXhU+vF
	Cbj18BTWkZm0r48wPSJb/Sc1wfP2LoGpW96tLHmqVPC+BbFwWmrc4/44qnDW3PpY
	aAa8G4O92fyRtVbi5WaLluJANLNM0q+Ov/GExFgpWRE3wKzh+8XO+LiL7Sg+TFdv
	LvN5Ekf9JvlwniBENqXQwMOZE3Wf7aCOtOkFecmFGWGauvo1JjsG+TsTfQkk0MN8
	Vkvwuw2hNB3S7Nhfyc2wxwWDlbQ1jz/32MQ8NWaL9bvTKONJ/2l8RyPOksHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737486860; x=1737573260; bh=ZcoaLmzUl36aEgL/J0fInlfggszRP/hO9CK
	5+yjTiDQ=; b=P+M7drQne5U+3eKLy2SozptWPuGKAIZoknQelEX7AZIy448leFH
	Rj6Xx4kU1FNwy/H3Z/MdwU7octSt7LhG7bZkvOLoM6BmzoG1DTj+HWwlesyQJHlP
	Ou7cxpv6CyI0NHDh0CwBo6ajRctsDWYgQtfFg4K4DXU8V7lCyTspeho1kHZ/Mmbu
	DihRWhwYnFBpP9JdzV8oovBj+HTLYOdEfzDNb1xnRWNfzePNc6dcF64YVRpofgRb
	s3dUjN7rXenzugxj6eTQoZbNKTIbDEaBopJ/ZaOadFjvoFZKKJUGvXf6iM9WTc9p
	BG9eM4YkzQjCGPjqKro0VcKDICh8oBx6ViA==
X-ME-Sender: <xms:C_KPZ4zk33xAKN1mKkjfjYTEW-lcFa5BJowJur7u3ZLa989gCkkyjQ>
    <xme:C_KPZ8QzsLOLQgQ4z_zTWqhSFzpOlbClPkSwx2Unf9TAzOoOGbZt_rRlZvR4Vc0jM
    YyjUeKSFUFSHqijXA>
X-ME-Received: <xmr:C_KPZ6V6mHhSoC8YKpSQ2gFdurLGApnZJqyLdBpe0DosC-72-fsvBmJVKHwDkFL9VoB0x9_2vZ1xRtY20bMnx6zsj5upmA3N0BrP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:C_KPZ2jiG8JiQ-rxv0cArCsWmKxXDc58juu1D0u_4Lsr4fmFiYz2cQ>
    <xmx:C_KPZ6CabNdIWsHneSvCFyggJgZlj2FfhlKM47ZwEXHZ0NY_9Xf39Q>
    <xmx:C_KPZ3IykBiigk-XmfrALpfPS7dC9oUixWU-3p0VWMJdBsp1YHzEiw>
    <xmx:C_KPZxB4bdJkcHb3IuLQHjvxgEGZeBdDttgQoYKRJs0S32XYIEovxA>
    <xmx:DPKPZ26cp1ZGbq5LzOY12OcubzFW2ofOR0Y8riEcig-9TdyavN2gAnXp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 14:14:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/6] version: introduce osversion.command config for
 os-version output
In-Reply-To: <CAPSxiM_9JKxu5QkxjHUFDM6cb5rSs400O72eYCiM8jHF9dr7Vw@mail.gmail.com>
	(Usman Akinyemi's message of "Tue, 21 Jan 2025 00:28:11 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-7-usmanakinyemi202@gmail.com>
	<xmqqwmethxyq.fsf@gitster.g>
	<CAPSxiM_9JKxu5QkxjHUFDM6cb5rSs400O72eYCiM8jHF9dr7Vw@mail.gmail.com>
Date: Tue, 21 Jan 2025 11:14:17 -0800
Message-ID: <xmqqjzao0yk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> That way, we do not need to add another mechanism that lets people
>> spawn an arbitrary command while Git is running, we do not need to
>> worry about security implications, and we do not need to worry about
>> people abusing the facility to throw totally random and useless
>> garbage information at the other end to make their stats useless.
>
> Thanks for the review.
> This config option was added at Randall's request.
>
> Randall wrote:
>
> "Instead of an override, what about a knob that specifies the uname
> command to use to build the value. Personally, I would use `uname -s
> -r -v` on NonStop to get the kernel version used in the build. The
> difficulty on my platform is that this is not truly useful info. The
> effective build OS compatibility version is in a #define
> __L_Series_RVU and __H_Series_RVU, so the knob might be needed in
> git_compat_util.h or similar. This comes from the compiler arguments,
> which are not yet captured."
>
> So, the difficulty is that the compile time information might not be useful.

It only tells us that uname(2) gives useless information on the
platform, but there are other ways to ask the system for more useful
information.  Isn't that the same deal with how useful information
is obtained from not uname(2), since a useful one does not exist
there, but from GetVersion() on mingw?  We do not have to spawn an
external process on MinGW to do this---we shouldn't have to do so on
NonStop, either.  We should be able to make a call into a NonStop
specific code you or Randal add in compat/ from get_uname_info()
to hide the platform-specific details, no?

