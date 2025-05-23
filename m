Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98C156F5D
	for <git@vger.kernel.org>; Fri, 23 May 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036434; cv=none; b=c70wYlb/tFIFiQ2SIFAXib+kOHkBogUwZ048nuk2CpdmRgmsyJxWAvDiylCGCfNiiIbu0UtxxVm0eYMut8cqfbYV9QXKqI/eKuAZ+WbdpU1BsqSZNz41w3vVRY/egmwkdFEyPKvLvnSNmfvfqSiofxUY+Tf6O4j1Wy9fRGlovKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036434; c=relaxed/simple;
	bh=Uy/+Im6Vk5E4NvvcXPM6ArU79vbwMwa4ccAwWF/1Cik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ka3A732jI1v6zdK4d8VYBvAqgS6xJQjz3GfuqEpA9g838IJdtehSOkC6QRVbSTqUlT2Slj/ewT/wzTq02H83mZNdOspGJQXhV9sVLLT3r8kgpVPX06BENpGh0obR/Q2j0exMiQaR2hOSotzcJcmF53TiMIw0KrctePrVjFMAE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iRPMzt1a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zu1ENuh5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iRPMzt1a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zu1ENuh5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CBD10138012C;
	Fri, 23 May 2025 17:40:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 May 2025 17:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748036431; x=1748122831; bh=7izpRgRKy2
	enbs126EkVS8sisj9zdHuwqm6ibH9uG2Q=; b=iRPMzt1aqkXFuV0d4JXY++wfs+
	T7qe9EXZ0l1ZuP5/1/sSEKLWEYvbwng17oYEM5SThh18rXq2M6ZVY9rXC11j+ltT
	rgByLFQI+opvRtRiiTBY4aqsEHBT8Qgk4uK02ETPhjgjXA5yYWa+QhXQ7QDfkDZV
	mwV7aIvoyJG4NrB905T5rxEp9goM7LKM/AHz6O13sVYj96L9sV5Ub0a0Nmz8FJdP
	xF/M071CHwF6WLGIXmnPmWstwJkUP6bkwQ71N89fETo6sd4dvUuNALNJLVraAjfk
	nKVdYztdH8xV27+uIJlx9hxHXmBJ//yXbdX5pG8pMl3FGoB6h8qVR7BY8GyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748036431; x=1748122831; bh=7izpRgRKy2enbs126EkVS8sisj9zdHuwqm6
	ibH9uG2Q=; b=Zu1ENuh51ltvh1tUSDyUKst26VBfnTvEHeMXJgJg104v6c4zOe1
	BWHcnKwPG7FnR6QbUEBWMD8d9XQnvDQCWYSIqvkZ733VkDbWjlujthnqeKeBs3SL
	87mePv3iyUCv1EvJpn4/sy5fmF34UbBjNgc9d9wxyCUuzzjDf77Sn6ZFo3yMwLS1
	4zmuKaFMUl70cjXPzEuW4qo48zlZo1wRd9YogyX5MqWG7NsVq4EAPIGkB3hlVGxV
	N1wayA2weYKQ2DcPR9gZ88EnQHuBLzuWxapeSqQ6YZ/STJYFwhn+SjzzcnaeshKh
	kHCjakncHc7TVxV9K7t828pGZ6RqC7UA9dQ==
X-ME-Sender: <xms:T-swaBxTmlbsKla6tkGCv9fWwwJWBbNCaEvj8UGEczy9J3lH3Mcpww>
    <xme:T-swaBSnJrRabA9pWt1OQPu0-ht0hfLHFII2HjxISRNh-ZbQs83x7CSbRtDY-MZ2L
    RIZdw30dLw1jWpudg>
X-ME-Received: <xmr:T-swaLVzYcTFBJAWOyyOTH21cC-kVgNKw-Tf6xxYja_Nv252PaQ1PC8MJCMprKwui_UEP0KqEuw4796UQBnE9qaPDH6-mWQ5zhFh_Gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelleehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfet
    vdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:T-swaDhOMhF1oS_XRx2cPRpw5Ug8co6yS0Pd88sW1mMCtxPpmVu9Uw>
    <xmx:T-swaDBilWwD_qDhN3ItKxHfhJz_fPSuwOu1ifd9zDQ6mUQaeQ5oVw>
    <xmx:T-swaMKK-BbLn64BqdYxcisTUr0Lo8ZrGE9wkBEjpsm_9Qc7nLJF3g>
    <xmx:T-swaCDy8q2w8nQMy6ClMNH52Y8-6C-cpWwf4eIyphZWNgVu8KxF8Q>
    <xmx:T-swaI9XlRcYRXAA4xpFkjEmtbdVfjthvO-Qs_rxwgDAX03gfPCj9UC_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 17:40:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Teng Long <dyroneteng@gmail.com>,  "D . Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 8/9] doc: notes: treat --stdin equally between
 copy/remove
In-Reply-To: <3e8ecf1b668277988cc5d166586105d1d5018366.1748028010.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 23 May 2025
	21:29:54 +0200")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<cover.1748028010.git.code@khaugsbakk.name>
	<3e8ecf1b668277988cc5d166586105d1d5018366.1748028010.git.code@khaugsbakk.name>
Date: Fri, 23 May 2025 14:40:29 -0700
Message-ID: <xmqqecwfvwdu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

>  `--stdin`::
> -	Also read the object names to remove notes from the standard
> -	input (there is no reason you cannot combine this with object
> -	names from the command line).
> +	For `remove` and `copy`. See the respective subcommands.

Let's phrase "Only valid for A and B".

Otherwise, looks good.  Thanks.
