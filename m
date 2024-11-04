Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759A1B0F3E
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722627; cv=none; b=vCb3zdOL//odfEcU7IOdQ18BUMEyanEmw11cZyEXIiknQTE+ACpNZl7idGBApjTtgsnaNTOlC1IcEPyeIlRIucqXVGOTddoCsR0vdya8c9lA7J7WBA6T9Hq0YulAEdxqcZhSNAZEAwIhGnWK6xdzy94WzdVJ8hWdBUwxipQvtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722627; c=relaxed/simple;
	bh=3E21Rhj8WJIzIP9aFKMxxIFI1Bh9XAl0290HHX+ZAKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnVvNQ94n1ay7/19EHJXbYMTue3DJ5n3S59gT/2v5fFA+tLhYkh0ruhGFTNW8mqGX8DhYkpx4BpmH6k8HrTux63p7WbXcXCw4jgJQSRzpeQekaDeGiFmy2vCvX0prMeOv2G2l+hBhuLQQaJRA3jopm2aetJxFcyzaNEFa1CpkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fH/qYqJ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HqNrvBU6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fH/qYqJ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HqNrvBU6"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B76911400EC;
	Mon,  4 Nov 2024 07:17:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 07:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730722623; x=1730809023; bh=nzM/yY+5n4
	tCnY77yJH7UXRhfzBW9rFVvzSCH8euTXI=; b=fH/qYqJ5eKWRb9ki7fR6URxUu+
	8ayIpBiTh33pFGGiHNmfyR44Ei1ES8ebJIz5qFkKHfuLFsX3YCi59nje/Y3XMWV1
	fuZ37CYaAKvd1f073nTKPRkWKAs54EfKScjExYGmPJ7BcCiJMXv3C7Q0h336Vvuw
	twjsFzR4obPmgvmRMDgfGGG450KIZso9cLzLgPbZSQRCrDxj5xqC5IBOcVU6jd6V
	OQ7BN3GOAWBkTsDuLyxaATi4mzyr/GmxN2NiEEQpBbobQ1x9AC97HGl9cOQf0E6Y
	hr6bdj9UEpMg8sM9fpkUO8F1hfnq8hLNrevCkJ+/OkzIzfLWOG1CdGO6j6GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730722623; x=1730809023; bh=nzM/yY+5n4tCnY77yJH7UXRhfzBW9rFVvzS
	CH8euTXI=; b=HqNrvBU60fi+Pzjmg+QZza227KrmuuVsFgQUanS6LGUasWgAy84
	CbAejMbXXV1+QkdcAzm2ceMFCgobK6jgyZAezILzXGp8bHqx5QAyEg4zkPtwgFou
	vUtQ0lv4ZVZ33e9KOIxFUfxs6fnc63AFse+TMxfW9T+IAN2HAS76TW9ywyjmFnR4
	3NeoQoAWzR2aC7E1TKV+v6srXmZK/4SnA/B647EPqijmNnpg0fhvA8xlE1vNJtEP
	afQfUtbf2LTNH8t4AWa8jDQLilI05EHsDCxQ2vhDkn6m5tMnBBXE5xQY3cZYCrlA
	YVGoAZA2a6WZm/kiBrhY+qCcZjACjKBh2zg==
X-ME-Sender: <xms:PrsoZ2Izew5ZRKP0bu10HfEpbdDN9TY34J9tWl9RYjXGFfDMR04-Uw>
    <xme:PrsoZ-II7Xxw13y2g2O0Zm0z2lD1B3fcTW1OBs0fFhHjO2C6-7ysH2e_cVm1onO8k
    5ljm2coVFxNfwHFYA>
X-ME-Received: <xmr:PrsoZ2ssoEq18C3GvrhPdgH99c_EoPv4WGbTNvkucEUB_TjCnXynym-ey1juJhMIxP6hTvtH6mSbncgDsY7z7u8uLvAFvbu3I10lKmiscJEjRMkulA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvshgthhifrg
    hrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgih
    jhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:PrsoZ7Z3oq_89gFjzwp7m7pac5SuQgHvs3eGJV8_DSaDknOiRufOQA>
    <xmx:PrsoZ9ZAxiu_WQHrb4T_SarVQTZcHrdmo1mnWn5GY5ug1MOX2jFO9A>
    <xmx:PrsoZ3B72JuAAlrhkttFl-auO6Q6aEnfoVOGmomhQb1XTvtNb2HLxg>
    <xmx:PrsoZzbA8DcgfccjjxZcxZaT88qLgozt5Y9OC6pQaoSLjvRRlNnA8g>
    <xmx:P7soZyM1hFfiWavG2D8olw0oHpGgqe8k91RF7Y7eQnCDpWw4oHkHOq4N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 07:17:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d854e2f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Nov 2024 12:16:38 +0000 (UTC)
Date: Mon, 4 Nov 2024 13:16:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Eli Schwartz <eschwartz@gentoo.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <Zyi7LdvpFx2pDDIy@pks.im>
References: <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
 <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
 <ZxjmTbATU7usHcqQ@pks.im>
 <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
 <Zxn1HWg7KxZwBy9h@pks.im>
 <787ef076-ba72-4a0d-bfd9-1f79de4f4039@ramsayjones.plus.com>
 <Zxsqr3X4FAWfy0HP@pks.im>
 <48a506c1-67a8-4ac1-9a2c-392125bb0944@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a506c1-67a8-4ac1-9a2c-392125bb0944@ramsayjones.plus.com>

On Fri, Oct 25, 2024 at 05:36:00PM +0100, Ramsay Jones wrote:
> 
> 
> On 25/10/2024 06:20, Patrick Steinhardt wrote:
> > On Thu, Oct 24, 2024 at 06:34:24PM +0100, Ramsay Jones wrote:
> >> On 24/10/2024 08:19, Patrick Steinhardt wrote:
> >> Having a quick squint at the failure, it '# failed 1 among 397 test(s)'
> >> which was 'not ok 391 - correct handling of backslashes', which is the
> >> only test marked with a '!CYGWIN' prerequisite! ;) So it seems that I
> >> am doing something wrong, which results in the prerequisite not being
> >> set.
> > 
> > The CYGWIN prerequisite is set depending on whether or not `uname -s`
> > contains "*CYGWIN*". Does your system maybe pick up the wrong uname(1)
> > binary somehow?
> 
> 
> Yep, I suspected that I knew what the problem was, I just had not looked
> to see if my hunch was correct yet! :) And indeed:
> 
>   $ pwd
>   /home/ramsay/git
>   $ ls -l uname*
>   -rw-r--r-- 1 ramsay None  11K Jun 28  2019 uname.c
>   -rwxr-xr-x 1 ramsay None 167K Jun 28  2019 uname.exe*
>   $ ./uname -s
>   Windows
>   $ ./uname -a
>   Windows satellite 10.0 19045() AMD-64 Windows 10 Home
>   $ uname -a
>   CYGWIN_NT-10.0-19045 satellite 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin
>   $
> 
> As you can see, many many moons ago (28 Jun 2019 was just the last time
> it was updated/built - I suspect it was first written in 2006), I had
> written my own version of uname. If memory serves, it was actually for
> the 'msys' version, not cygwin! ;)
> 
> Anyway, when the test executes my PATH starts:
> 
>     /home/ramsay/git/build/bin-wrappers:/home/ramsay/git:/usr/bin ...
> 
> It is not immediately obvious why '/home/ramsay/git' is in there, but
> if I move my uname out of the way:
> 
>   $ mv uname* ../src
>   $ ls -l uname*
>   ls: cannot access 'uname*': No such file or directory
>   $ 

Interesting. I guess that `find_program()` finds some of the required
binaries in the Git directory itself, which sounds wrong to me. I'll
have a look at this.

Patrick
