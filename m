Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91317266B5D
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868806; cv=none; b=t1JyK9oyQffivTMFqVg0+0Ff864g3cIEhnitUf0+hh7RLeolo5OU5mAbFzBe2d+EkCp/iFRxFO3BFIlOLXuVoiKbW8/EFcE0809uIGzfPptlY/ctMUzCpiHautI3rZ9d8+VZ+BAJvcsGAt5QD9LlvuStLEfHzzGzAJh+Lkykiak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868806; c=relaxed/simple;
	bh=n//fW9/On5LsGqvMf0HaTm3/zlRFziUNms+iq+hedIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fRyTrle+i+0Jbb8Xxdu96DoIqp2xkLNCz8parmNjG/ykkm6I71ZnXgUa+I+84q8DrHI2lreHIQlIFmagUnRJSHHAQKi3OwVuPGkKqs0e0F3RKtkY4EDq/o+AXVnLC59SJqWRzo+UcjWeECYhIpA8dW7v3iAzKnzwqeo7hyCR/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jk8DT/vy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLMfRKq0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jk8DT/vy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLMfRKq0"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B7531382D03;
	Thu, 13 Mar 2025 08:26:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 13 Mar 2025 08:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741868803; x=1741955203; bh=fobzM5yqZh
	ZnN2A2Q2yEZFQpXFnGBdhCodrkbLzZGCE=; b=Jk8DT/vybzIHKuaKw5l5U+u/WY
	qKBQ141y82XsPQG1UL1ZBjWWhqDPFQxsZJKWamreQt+GpU5o4prs6CYLBe9MwiSa
	Qpkoxan9VLM+rWhJZ71VaYWYJP/GxqMBOVQHSv9K1Lvzs40pjUL+LajfLaL1WyKy
	U9DxGYWmWJkKHmrrrJ0JaHI6pCHDQ7Oeu5sVpSI9mFSxspxdiVjADeKO7XV61G0a
	UlypT7pNmGvcStIvF5/hHPcM2Y34v+JBbM4sVS6XHG0H0bN4tsCLeI+5GZR49Hbv
	B4MACEQ/rIiy6+0/FLRz4KzgB4c5ngDOBhUgFL/GkjCtEBvzKJ09UJb/4OSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741868803; x=1741955203; bh=fobzM5yqZhZnN2A2Q2yEZFQpXFnGBdhCodr
	kbLzZGCE=; b=FLMfRKq04EEHQ/NkJYWgSDf0OCo+2/YnhxaKCAi8VNjFssresj7
	/7GwiI3b6F3dd+9UOn3fLbEvYuTs4mcrjnn42xgLSEEJ5bryDxxWyhUG2LuaPoqL
	dw8LUeotnCsT40j+nXZ6JocdH01zDqrNZvjEn7v1A1ZvmTQEU6xLv2xoqpZMNzFh
	6qWCra2wiI8pqCRsrlsxP4iF+QSl/fZDwdHtNfCiP9p92t3RbCJTaB75yOx2dmfb
	K7zihj9E7f3kVkjeq2BGTGI9UF+CUnXipHsCwhG702a4Kn3BJy9avylY0qmV2bFu
	bReuT0IGecFLEMyB3wvWDwpRbyAkzVIa6Vg==
X-ME-Sender: <xms:A8_SZxAKI8igVcmo9hJ7i0S7TCD80mBH8ePsLBZtjfodYodBZ_ER9A>
    <xme:A8_SZ_jEqyDwVFXHvYRCshYLMIOmaaUbLlva0_NxqoQRYb2bLP4Ijh-VGKsOAhMpa
    4AWOURORNCvfgBA8g>
X-ME-Received: <xmr:A8_SZ8kFGthlOcnuLXFJ4GgGGeZCciyv3TEglsyuJ3Irm6dguNirmn19BwJRwbnJcSm9pPS76aqDpyj0fbS_YK8XnoCy4yxk_tgv7g8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhoughorh
    hovhestggrrdhisghmrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:A8_SZ7x4dkwlb74S3s3PMpukXWkzEDZUzn2yL57tYIErXxCgAzMN5Q>
    <xmx:A8_SZ2QUfpDnctMqZ4YsCTCg_A3E7cMkVibjRtI65PVx3_6-EaekJw>
    <xmx:A8_SZ-YiF9E0Rmyx3GtQ1c9VAPekHMhADT_Kv8XFoE26sLkmXyi1Vg>
    <xmx:A8_SZ3QR2uKM31MLehQF5UI-ECTkOM1KD0roYz69mlsx5i9922HMUw>
    <xmx:A8_SZ1ETp1Hbm7vNrhrycpjaMjP29kBDyoDpNW3k8fWPiLOuLNOPxDRZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 08:26:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Igor Todorovski
 <itodorov@ca.ibm.com>,  Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 6/9] fetch: ask server to advertise HEAD for config-less
 fetch
In-Reply-To: <20250313054644.GF94015@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 13 Mar 2025 01:46:44 -0400")
References: <20250309030101.GA2334064@coredump.intra.peff.net>
	<20250309030847.GF2334191@coredump.intra.peff.net>
	<Z9H//JHtYTGqHI3n@nand.local>
	<20250313054644.GF94015@coredump.intra.peff.net>
Date: Thu, 13 Mar 2025 05:26:41 -0700
Message-ID: <xmqqbju5ru9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Any reason to use a bona-fide "commit" here instead of "test_commit"?
>> 
>> Not a big deal either way, of course, I'm just curious.
>
> Nope, I mostly just reach for "git commit" without thinking because
> that's what I naturally do while debugging or exploring.
>
> But since you asked...;)
>
> I do find test_commit a bit bloated in general.  It takes several
> commands versus one, leaves cruft files in the working tree (that you
> need to care about not using again, lest your commit fail with "no
> changes"), and by default makes tags that sometimes cause confusion
> about fetching, reachability, and so on.
>
> The one thing it does do that git-commit doesn't is increment test_tick.
> That sometimes is important (if you care about traversal ordering), but
> usually doesn't.
>
> So I dunno. Maybe I am a bad person for not using test_commit by default
> and we should have a style suggestion there.

FWIW, my assessment on test_commit exactly matches yours.  The cruft
files it creates are often not what I want, the tags left by default
are even worse, and the only good thing about it is the tick support
but even that does not make much of difference in many scenarios.

To its defence, I _suspect_ the automated creation of default
changes were useful back when there were no "allow-empty" support.
But I think it outlived its usefulness.
