Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5352BFC89
	for <git@vger.kernel.org>; Tue, 13 May 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747161784; cv=none; b=ZrwZCQ8rInRs85CrL4UU4Qen+l72IgOzal0d9Uzl07+rhtmry0EtQ/4HIgTJEJVnQbB09QoD5axNjMb/BmJqWoRlMo7wgkxltphM8wMlIaPC/dwlRrdpJbKi/n/y8Y8Mkb/JDoNZK2TZ4YdMzLc37nTlWPcTTUFMt0Bu6a87nis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747161784; c=relaxed/simple;
	bh=TZc+GdYMFQT8q/YAshKiiGzOByNwWDLBX7Ni8orsim0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hLcWNL0++HlIoGe34IVOHdOfFU8N8/fIBI40MiU8BoLy5lM5nhoG+FonIC5jemDBvjk1gdDP3FOXChiboFgLIAWqhzSvHK/bccHJ7JjELHCxHFj/iO3j5YabEQj14Nm+qsdW7DYfDhwXiuW70yysVrg8d0H59KXEwPZjigtHvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jd+y9ZZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AVIUmkOI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jd+y9ZZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVIUmkOI"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D58F511400B5;
	Tue, 13 May 2025 14:42:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 13 May 2025 14:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747161779; x=1747248179; bh=TZc+GdYMFQ
	T8q/YAshKiiGzOByNwWDLBX7Ni8orsim0=; b=jd+y9ZZ7AfaivQXUR5TbrqVMgh
	jG4R4PXAMvk0VMe/CI00hxk2NezvyrVvg+ds3HbcUu/P6P17mcHT62iOFOVYexri
	wGw/A8vdFYopmhqS/8bMJgWopJgyG067eCXRwnzn2Jo/Jk0dr3B0aYoAVNNfjU8h
	6nQK+XTUsSvExQ8wV8WC1DzvbQeYx1ynBsgwa5UKOB8kk79orGB6QzlLeP5LSn7F
	ajwpMxiBdgs63JJsu16WHwlkCJ7Mvrt11kFdmFaJz6w62rNlWVFDLyL6HFfBFQ+X
	hJLbRd3WlARYNu6lLV4VFpM2HAe93rVjY7GjEgxSE5OpOlNfDVNaam8tbqWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747161779; x=1747248179; bh=TZc+GdYMFQT8q/YAshKiiGzOByNwWDLBX7N
	i8orsim0=; b=AVIUmkOIXZUC5FRXgBk/Dsk3ITVQWAEBQDqdwX7+3b0GrAq84Ge
	IxBCxUYRCMCUfmU61bmLFPf98NcV/O8BLT8LZdWnNOfXE+Hbg7Ymk71QrmbpAW32
	rDssy54BqCYOBCg8jJFzshUnZ9UsO1bnK+nbnlTTCw+1JD6ELuuxKEaJaj9mK5hh
	WteNjDLkmoqamtyG1+r4T3NxfmsSgEJv4AP/kZ6C4eiL726KjwYJytxSh5pLYEBP
	Y2TEhAYITCiqmPLiruHLpgTULLGCF5oQ3U3pVAUCRYT4RRrl3oCEuZPH3Kn6I0Ly
	KK//LT6Jut56WBHmYbyVnttxOPW9sy+6ZeA==
X-ME-Sender: <xms:s5IjaJfinoOK3IAt14tJBdI01J_im4svYl68yCEy7eipi6Y8NlS7uA>
    <xme:s5IjaHNAZOfJ8g-4Si29hbEXn_IHHYGfPqZQLjGPEemBknBIvdpi9dLNNIr3_bjnF
    9lOr1ntb9S8XcBPqQ>
X-ME-Received: <xmr:s5IjaCgb-7IjQDmYZToqKVsV5WN4lQqqU4nThFJ7gxIHtCkaY3RhlADJrp2V35eegEEASd1Vp-QIul2D74JDE5sA_zxgV0pZ0CDhiPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkeethefhvdduveevkeetieegteehtddt
    gfffvefhheehudffheekiefggeehffeunecuffhomhgrihhnpehgihhtqdhstghmrdgtoh
    hmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtth
    hopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdt
    keeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrghkvghrshdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:s5IjaC_sE81vg3o5ieaC6GYaaluY8AYnbfUcJTdhubV4Jz3ByA8p1Q>
    <xmx:s5IjaFuORfG5utBUqSeoJtEETigVDeIZS2L-fWBDmt1KMt7ookHYYg>
    <xmx:s5IjaBH7Td9Ht_7OApmh3HEf2OYoSq2bs5jMfjgdEcdzo4qDGpcJ6w>
    <xmx:s5IjaMO9Dshyqel_hzuKT0xpDgBhEXt6ABJzdqARSJt2drQszRSErg>
    <xmx:s5IjaLfJKp_PZQ0Ys9C6uavRd7m5db9KmXxHBDXaJNdg9zd73qH-L9N7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 14:42:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Julian Swagemakers <julian@swagemakers.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  sandals@crustytoothpaste.net
Subject: Re: [PATCH] docs: add instructions to use Yahoo with send-mail
In-Reply-To: <PN3PR01MB9597AEC10C20F4B06C4BE254B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 14 May 2025 00:03:59 +0530")
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597AEC10C20F4B06C4BE254B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 13 May 2025 11:42:57 -0700
Message-ID: <xmqqzffgfj2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> BTW, I could not get the source code for https://git-scm.com/doc/credential-helpers. It
> seems to be a page for all credential helpers.

Probably

https://github.com/git/git-scm.com/blob/gh-pages/content/doc/credential-helpers.html

See https://github.com/git/git-scm.com?tab=readme-ov-file#git-homepage--
for the general notes to get changes to that repository.
