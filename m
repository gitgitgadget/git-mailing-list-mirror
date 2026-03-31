Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22BF23507B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928482; cv=none; b=beDEt+FvGWLjcvXkvRAQsDM1R3Z/K42LoU0NNhI5gLiADC4A3YovYzDR1Ojp+ExtAkRH0InmV9h6xEBUVv+ZLAxXbFVqwhn1zLmex3Buvqp+HoUmgLyYkHXAuKErLthH58jwLZvlJkmaTOz3Vl2QEtomifExrJGNa0KR3xFMeII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928482; c=relaxed/simple;
	bh=VO8sv7f9DYqa77srnGqm9YQqEpOm8LGsVSgClLmvs7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y1eTAp615l/cGvzeZs201XmFpMjC/Pc4NyReQwYNitKyfCoAKKkXkyZ8/N6+23l5BlUpP6er9+EO9mQI2L168hXjZ7Qq+5ZS8vyyJLJIsj4ydcDpHKKLnJUwfrpp6Fz9zsgEIBKRjee0xQ2WdUeYd/qP/xuEMzE6u4BnisVETvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C9v1Xr7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4CB/q/E; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C9v1Xr7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4CB/q/E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C581D7A02BA;
	Mon, 30 Mar 2026 23:41:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 23:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774928480; x=1775014880; bh=T315izE2ez
	GG6Eh/6irY0T4kqexmhv0owC7jEzeYRY0=; b=C9v1Xr7QRYWjvcLQylkhhPU7WK
	hTe46DJHFRtxVpjbzk+q/6ScyEtD/Yrs4qpMa0EaR4kc66xoOw4QmkbRZzbOKjBH
	ioQvd1iXYKrb8QfnCgvAabvcjOTAl0lhSXMbCyjhTChsiA4LrZRL2GPmWHFXMI4W
	Bli8tb5KP9QCwX4ufFXjGmlBEm7NtCk1LHm0jck0sGdA7ylNXqJxKxCP1ashYxHr
	sgBvE/YCvDnIDAw5Q3Cgo5Ow+xnGbm/BQpnLvkSCHjbCkf5idweiKO/7bEQIkRfj
	Lh2PwB5+7rnVplH54/jQNxcsYhBkU93pOqEKt4FJOB3f10wN0K1wSstgp/AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774928480; x=1775014880; bh=T315izE2ezGG6Eh/6irY0T4kqexmhv0owC7
	jEzeYRY0=; b=e4CB/q/En8PswqqR4H4Pc/aIhJLEJmLPFBqaO2eZByZs44mr22D
	QAJQFwCh6WVr7zffIc5Uh5liEKQaICxBWCNAafKgA+IDdPrVihCJt46F4NcdWGKb
	FUiFLBKg1zAipNMM7uYqsd/3qGC7l9XJX1xJcH+eJTFLybsLnouQVXzFjJ3k40Z4
	nMlh+xmP9SK2zLK0swJJNTs9WFsz/vqzZTPEN73zYFyR4ngFoulsP25c6XynX2ci
	PX/puPs4PL9GHqHbEknxTZ7l7cXJzlwe4PoPGsLNNbaqdHk4b8bMv3U2zHGZUqC9
	TDRcG6lKOk4vdUfEneKZBuUBGjVhuP+qjHw==
X-ME-Sender: <xms:YELLaY4d2_UZfLjsVz2Hg7j9XGV8jjLBzqaockmeKcYV4K2Gx1XkyA>
    <xme:YELLacItj-yEMVEXvlEvFjxVdqPkUl8UYWt1wsm-KjcW8rHS2wm5-dUDXAsxffdEb
    w1igi8khSEsP416N_YThtkfjpS-INym9ZkpNhl9-PashgYFVlC->
X-ME-Received: <xmr:YELLaZujLrKq6wcr_4Vtc7RzP1bGp1Sr1b7zIFqxo_q8f7isTmiAIDUY31HRB9mUmA2u1vMn4ffKmq3ifWtmq0B-TKiPuQj0tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YELLaTJZbJDvgV--0DL4UpXQSKH1oLbXhubrilYFrDzozeVY_1Utuw>
    <xmx:YELLaa-6EbSI7dwKS7bBLTkJzRmewU5oO7sGj0vZI9lHP6u4hK-OgA>
    <xmx:YELLaUwW58Z320x45nJ1NewEgTcJz4h44Ntmk33E-umhVIEoMU2nGQ>
    <xmx:YELLaf4hVzj2e1j7iklMZ7DiAlf2xcawzaj7zLIkmiyC3bV4NNt7oA>
    <xmx:YELLaZxzqxLtUVR7SB1V6GzS-meLs5fJWWEKVBfW7rCbCnDh4s7mJb6h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 23:41:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  christian.couder@gmail.com,  ps@pks.im,  toon@iotcl.com
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to --batch-command
In-Reply-To: <72543649-7994-4220-86fb-e3c84faf0b6a@gmail.com> (Siddharth
	Asthana's message of "Tue, 31 Mar 2026 07:10:35 +0530")
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
	<20260329082808.12609-1-siddharthasthana31@gmail.com>
	<20260329082808.12609-2-siddharthasthana31@gmail.com>
	<xmqqtstyf4lj.fsf@gitster.g>
	<72543649-7994-4220-86fb-e3c84faf0b6a@gmail.com>
Date: Mon, 30 Mar 2026 20:41:18 -0700
Message-ID: <xmqqbjg44qe9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

>>   * Can we somehow make mailmap object itself slightly smarter so
>>     that it knows if it has already been asked to read the data from
>>     its sources?  It is a pretty dumb string_list, but from a cursory
>>     read of the code flow, it seems that mailmap.strdup_strings is
>>     initialized to be false in builtin/cat-file.c and then one of the
>>     first things done in mailmap.c::read_mailmap() is to flip that
>>     bit on, so the "yes" part of the parse_cmd_mailmap() might become
>> 
>> 	if (yes)
>> 		load_mailmap();
>> 
>>     with the helper load_mailmap() that may look like:

This part was a bit misstated.  What I meant was more like

	if (!strcmp(...yes))
		use_mailmap = 1;
	else if (!strcmp(...no))
		use_mailmap = 0;
	else
		die(_("misconfigured"));

	if (use_mailmap)
		load_mailmap();



