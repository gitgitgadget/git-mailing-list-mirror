Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49B1EE003
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265174; cv=none; b=FFAFBUc6C6gZf6RbNbtzknley/KHckTvVf7r5uIMwCqh6R4KfmfUqkEQJ2qxmgQvGDXTrIxPXjvtnBNsQWD4kxflmrmiDFyNMjk3+l7iWonFkLOlecvMCJneJ1tae5oyGzM8hjCxBNqxEztIvcoKgkA3+iVUwqBx9Mj6UiY9dQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265174; c=relaxed/simple;
	bh=10ptWFIAnsk5YeOwxFBZN+Pcxjms/z5yMe11y886FeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZKW+K7C+dVCAL42T9up2yeOQUhFYEqkXpxoLW2YE4N2HKz0uQEuB6k2SYEpAOk+IDTLrKwVF4zpNn3+/e9mw+WXf+IhwqH+D9794NhCIGlOfGtBSL5dLRalHHwi1ctKE2B/plw584o1//o/RBtlNQyp2MuJChH3rzP+pLhdF0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UuCMhKst; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZjFGbDrT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UuCMhKst";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZjFGbDrT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B66725401BE;
	Tue,  7 Jan 2025 10:52:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jan 2025 10:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736265171; x=1736351571; bh=eJREoEhlsK
	ZnCdZFk9F+XrgBagCxeLfTLrpov7p4JD8=; b=UuCMhKstndSSTnOTsltKnkQPwy
	qfs/Dmo6hmJIc8zrL/B9tNkFVgUlup4r5/OJZ4BX+vfhkRIAEyccxetZXba2jUfg
	OQCeOevgeata1qMENYk5zxyAVJ05CTYzT6Z/VigxLqVtVfL87aISXAEmy6Ypb9m/
	wlIGBLUEIdyDw8uqqIrQJq7BW/fbew4qWots3u+V6L6qJDlfv7kRZNKqqSbanJAB
	/0JSBu+2iQ0LufAOPX6GlvgarIToLpiQXrx/7fllrI5rs+38IG7VmwKqwCe1ZVeG
	AQTE8CqMNd7eCuMBRbHeehIkzSyaoD4lROaAZqt/4nQXAs8h02qVI5s7zQzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736265171; x=1736351571; bh=eJREoEhlsKZnCdZFk9F+XrgBagCxeLfTLrp
	ov7p4JD8=; b=ZjFGbDrTqJXtIYdYwOhWTiASgb8b2frzUB/2jwpMwkcjZTOxgXN
	RS0eK9zpnXhJ3YpvWQZRsp6s+6xaoG84Ph1wWkIVOENvz7fvYqPM4OMZxXwQmFVj
	MXX0liJO6SSb3nXoG9hpKaKTuBb4CY0XPHWJ7rNTW/0K38gCVOz357fKzHevhhuo
	9UEgnlksAYUyKjlGfbABuSXJnXo7W+oP+C1IxVszQZ0LkprJVywOt743h7FntrhI
	7EM0X9Zm7TsjBJq/gRYh+TO5NDX+UuWaF4wX54n0F/dgr8P6WGriEo8nAlmG83ZO
	KThmGztWGae+NQ0oHe5wsIYmP3xcZxUHIKg==
X-ME-Sender: <xms:0k19Zx0GLedC4YQBMbw3XnY4BVCYxs5KJcC5uFoV6wuuu_bUPfZfMw>
    <xme:0k19Z4HEW_ILSYel5ektKsKrLRkfS5mSc4WEfWuubJcVuMBPEE22UyHxtEXnyc4xT
    X5Qc0LQ5j3C1rxt-g>
X-ME-Received: <xmr:0k19Zx7p6p8_Cg8cIkc5v8GfbmGeOcVGj4dVGeINbV3Ojsug_B5Ehlp2L-qyTxImeSSU7-wHc_q1E5zsjx-Tm2d8uw0xWySFW84L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0k19Z-2hAVWFn8CD9Dh9T5lFPM8EZ0wEEyOosSQkyA1FXg4kooCkEA>
    <xmx:0k19Z0Gk7LHt-Ij7TR_68lENdrll1JRrfB2hPThKoar5xf_4Aj18Fw>
    <xmx:0k19Z__xJqhB4I7ThDPeU9LL0f7u0vXdoPr_ASx0tqgzE9jBNMhP-Q>
    <xmx:0k19Zxm1sUHDN3XzTtaHkyJ7_vjP25tqAbFief_0iyc3WEE2khLSMA>
    <xmx:0019Z54sDF2C3F5teuV2QPKWZNPjjYIY2HEIFMIFNoUbg14bVNCjQoNY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 10:52:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>,
  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/10] builtin/fsck: add `git refs verify` child process
In-Reply-To: <Z30XXCel6Fd7Thp9@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 7 Jan 2025 20:00:28 +0800")
References: <Z3qNUizvHJLgMx1y@ArchLinux> <Z3qOM5M1ioZ0Px4T@ArchLinux>
	<xmqqv7urwpu1.fsf@gitster.g> <Z30XXCel6Fd7Thp9@ArchLinux>
Date: Tue, 07 Jan 2025 07:52:49 -0800
Message-ID: <xmqqwmf6vcxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

>> I've resolved it in the latest integration after pushing out the
>> 2.48-rc2 this morning, so there is no need to resend, but please
>> remember that it would be a possibility to rebase on top of an
>> updated 'master' *IF* the other topic graduates to 'master' a lot
>> earlier than this topic hits 'next' (IOW, until that happens there
>> is no need to rebase).
>> 
>
> Thanks for the careful notification. I'll watch this.

For future reference and to help those who may be reading from the
sidelines, it is a good practice to see how your topic interacts
with other things in flight by making a trial merge to 'next' and to
'seen'.  It would give you an opportunity to learn about what other
people are actively doing in the project.

Thanks.
