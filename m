Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87157393DCC
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755984790; cv=none; b=rOLs7/K2qa7RvWri3Bi9tzF0xwRzLqQeKqqjdxlORSjH2lBBnQE31VxrOvlPF91k6dxVODPMqE46sz+QgUscWp9s8S5xl18WM//e5FY8witzcXszFn7OCbf5q8W+M2X6UlrEZTeWl/ktgStN2MCfjfh3ckUOFZ19bJZVpWrR9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755984790; c=relaxed/simple;
	bh=tAcBQI2dkod8SokFjAGRGMtTjAb/g1LFONsFzOJGHjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZDcRf00uqdKCaUJFHmm7hLcjV7s3dhebc5qGWZ0RqeX+KP8n2fGlUxVRaXKNiqvlLQKerYx1WP3T0z6Bfa0/g6Xmkd81LkXegZWyjPFfIN0RJYBWM1R7Tuku3xSUo0CZY/xM3TmZXVw99siOguWsfSYZ3oc3A6bneSuYb15ugHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XmMg4nUh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CQ+GnLmg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XmMg4nUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CQ+GnLmg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 872A07A00AB;
	Sat, 23 Aug 2025 17:33:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 23 Aug 2025 17:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755984786; x=1756071186; bh=SYoku9Bb4a
	NE/rBsoKmM6lgeOqynytNnhleY63xTCiM=; b=XmMg4nUhg/XHeiMc55IKVWWURs
	+NwnfstKZrAmuPuEWXjx1TwoJjoa2Gyssub8li0Pd7cqSLApR3AuRl6V4Ke7XMv/
	YCmQqYd3kakLjslR4ksSEPx4VjEfUSw+B060WbTKkxf9MOZbRea0ofoylNxvzRy7
	QZfFw6yal5XH633Uw3thR7F4/WWq9kqu+3JpMAR1AIKfr/Ox9z/tNEzsRE8rqTaL
	2J1pSvIzsBd6V4FPBOjsSrNG9B4LRlHKhV/W7PSQNf3hn7JLSkhjgzOMG1JBd6uS
	3DLGV3vwWgeEbBKj6nMrP5WLKqbWXi0fY7W7A7Oo0MLuXUXTVpRSOpdcSOhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755984786; x=1756071186; bh=SYoku9Bb4aNE/rBsoKmM6lgeOqynytNnhle
	Y63xTCiM=; b=CQ+GnLmgpq5sUWWh11OAB9p2+rv0GCbuEaI9cwItSm1SyH0Ojpr
	fELZMSWHSVcJm6axs2z8S6O2pKT6L/fU7uRpzWHiQm0Z9tx0j3tRl/ARPYHn7KBW
	P53vRElYylq78V4PRkfpP4wiAl0hkX0AKnujUfD3Pu+oBAePQnCqDYcYmg205Kgw
	qaGod9U1G/Wx0ZhFmaFaCXCOIbLTJyDzKhy5R+YZCAdYVc4owVdOQR0ESFbNO7YB
	MOF6/KgpxSgMBLFz7YLOcuh1w2an13XOXKIdwv4C8yRm2hkjAHsNLNIdsGDeoT06
	SwPBBwQ/ubQLAcpvCHKfE6pd7eOW1eKH0lQ==
X-ME-Sender: <xms:kjOqaF-fWgY7_p5sC26O9HD6YyLROxtChjnao8QkaXoKR0Odn8-QNQ>
    <xme:kjOqaCKQHLaYohGzRswJgXVHjd7vuf9M_rGp9woj4HQgX-LzRahFZFZcvZA6q2bWB
    S61aZyUM3Mhcfy06w>
X-ME-Received: <xmr:kjOqaDda7XIGZlv919O5Su4aBmDkJ-Gzr5oM4kmh130a7O1jwFAEjmu_ovFr4HJ4OLYbyjPzcOaIv9lrXhBPGbCC7VdCe48I2Z7R2Yo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieejjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptg
    grrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtohesfhhluhignhhi
    tgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kjOqaJ-iRnGHvpgCAPvDceKP_WuFGdmOwgP1imiUA_wOBdO7d6DUXg>
    <xmx:kjOqaIo28gzgAGrvgesGLjtcX405msio0gnjYQH46k7iGXa8hkTQdg>
    <xmx:kjOqaGCrYSF45gBeYe3wb1oG4njHW7ZYzzGA09fTDUOKq7lmkDlDmA>
    <xmx:kjOqaCw83DELWic3Dyi_s4KvjUBTcLFxU37WrRAKQumjPK4tgvfG4w>
    <xmx:kjOqaBndESo0SXvceYdfP1LyKxHzwyGnYY_fCnWI-2aBHMAycA3tDudl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 17:33:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  Nicolas Pitre
 <nico@fluxnic.net>,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] progress: replace setitimer() with alarm()
In-Reply-To: <86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org> (Johannes Sixt's
	message of "Sat, 23 Aug 2025 18:24:57 +0200")
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
	<86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
Date: Sat, 23 Aug 2025 14:33:04 -0700
Message-ID: <xmqq4itxvi3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> We use SIGALRM to raise a flag that tells the progress code to act in
> some way. The progress code does not act asynchronously, but only when
> there is an opportunity to look at the flag, i.e., it acts synchronously
> in response to a third party (SIGALRM) that told it that it's time to
> act.
>
> But we can change the progress code to do the time keeping itself.
> Instead of looking whether a flag was raised, we can let it look at the
> wall clock and check whether an interval has elapsed.

Yes, the use of itimer to only change the flag without doing
anything funky has been a very safe way to use signals, doing only
absolutely minimal thing in the signal handler.  Having to rearm the
signal in the signal handler in Carlo's patch made me feel dirtier.

But looking at the wallclock once every iteration of a busy loop?  

Operating system folks may have worked hard to minimize the cost of
system calls to gettimeofday() in order to help applications that do
so, but I somehow feel even dirtier to hear proposal to do so to
replace a signal that we set and forget, to be reminded once every
second.

I dunno.
