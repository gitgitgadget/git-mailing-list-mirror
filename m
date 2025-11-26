Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750533ADAC
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182499; cv=none; b=Rap0Dty7nkRfnkNBFyD+RXYs98vZ+OO21E29zXba+DVOvLwfJPJOwvY94XRzwVkF6q83k9OHOIim5ULG5b714Y5cvB6HNKkuOPTkXSMdYy4LzKDwsZLlsm7pAfiohUUirbqmhdQGDqzZsDP2djKmSsaKeVLpqNDKj2xTRC08kSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182499; c=relaxed/simple;
	bh=AwP6eG8uRi7VjIaEcY3y+ZLUywQ3TCqqDQePqHle194=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JAg5aJMmZSTGOFLZII7VyB+M1LYb+/01l0GaGJXnx/za13U6l76ubt6mmAt8q4IUvxdUwThV1Kb3dKliYlSNRLiwpgLa/KBiX2sZwX7IX8nM4HoR6PpvYQ7hOwH4m/YNoCkBdRhqbrobcOgyXZxqjk4MapHLOCnwtSwSQl+K8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e6kyRGMw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiMomcEr; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e6kyRGMw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiMomcEr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFA247A010C;
	Wed, 26 Nov 2025 13:41:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 26 Nov 2025 13:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764182494; x=1764268894; bh=pBWIS5oI/d
	JmfOloVEIbz8DgQhEpVlg/F3Z6TPfx/y0=; b=e6kyRGMwTQRanD5Uk4LxGHJqW+
	jyil+0LbFCTZNEttJhGjJdSaHSG8PvKxoig+6AyvT5A+FgTyuVmDPtkuCxEoSM2X
	jehXF4qj4ABm7P2UcL38wFcpeGf8FZmpsJZPBl0H3+1bwQzPQx/0/eLvtHPfidXV
	DlBmdLPouU4AAy8V5tSlhmN+ImSaKH1gco2yk2igiqxI9L3Bwift213SBL/3AB9C
	UPQWyz04nC1BRuquYalDddw1PY/OFYah5eCpp7m5ApZKHX2UjtW8LhZWzBa+j/J1
	6F7jYVM/oe8TW2JXQ8AIpg/hMFTPRm0Ft0uuZ8sMCpuCXUdW2CvNB1ubBpTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764182494; x=1764268894; bh=pBWIS5oI/dJmfOloVEIbz8DgQhEpVlg/F3Z
	6TPfx/y0=; b=hiMomcEr1CMnPdC5mZyQrFo6GwplQUtA7ZiuXXERpNwUQsSJigm
	Hlj0lF1fCDOS4AYkg9EMrN0pYfCgyBbfIlVQMkLIL69z8jaHGaqepIbt1EJcrUKl
	F9BC1o/WuAll/towsu4PUGDjW/RKNHmZf8HjJoy/y89+pvmD6GwW9ijPYTpbvwVd
	PjBui9XqWh7slhVdY+l1vq6374L4fyFH/YFmDaDjQF4K+SbAvBZ5KGsYOsWWPQX7
	oBUpkYKfWYXUmFdDpQJ1owVYtZLGFNdFTmLz5l1wy4iJAu1hjrdsEcgSSGKmFD78
	y4dFy4rxf2NhIY+O9WGJ7r0DgIulJRriTHA==
X-ME-Sender: <xms:3kknaaQSTvc6VIDPUCbqMtkOCFda0UXqsFXq0HfLWhk9eaUEnM9p7w>
    <xme:3kknaU-PrQhWMuHrjCILGVwDTcK0JpoYlML0f-x6e8p3l2k7EfzFu9hCVFilDFzFy
    Kz-k_xKeBKcbwAfrB5TsHOn8hTVKaZ-LHJtFeeav0ylPLWduqCGYQ>
X-ME-Received: <xmr:3kknabOG5V4uzql57U2NRqIx4brOzJb0j4StX1wB6BZ4DYw5xmO5mr_nM2BvFYv9OD9A8bbz1kjCYo7EA9fgtBfIaL0TudC0GpYd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprh
    ihsggrkhdrrgdrvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3kknaVhr4aPfq1bx2laZMJEjdh8Q0hmL77RPkgmDBCT6UfboTLeWYA>
    <xmx:3kknaelXB3UefaQ32jDBypS8YdMgb_M-w9awZCIN6_A5WhehSBTk9g>
    <xmx:3kknaSNEyMYY1yrYZk5JV4oTBx1cutyvG7JXWbi2oLTAgGVp6vpuUA>
    <xmx:3kknaREGfP0m8a-BmpETqmWlvv_xPlW5ZPnVzMV9H82lUqOWvF-pLg>
    <xmx:3kknaRCut4L-cArfXB06-0TZDAlQAAn_9isyiyBV4-xaVUir94QARs7u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 13:41:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
In-Reply-To: <CABPp-BEF1RVs7n4xf6ihyPUmxrhgpG6VEpZLrX=MTgcBWBRbfA@mail.gmail.com>
	(Elijah Newren's message of "Wed, 26 Nov 2025 09:35:46 -0800")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<20251125170056.34489-2-siddharthasthana31@gmail.com>
	<d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
	<CABPp-BEF1RVs7n4xf6ihyPUmxrhgpG6VEpZLrX=MTgcBWBRbfA@mail.gmail.com>
Date: Wed, 26 Nov 2025 10:41:32 -0800
Message-ID: <xmqq3460ocv7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> I'm struggling to understand when I'd want to do this. Why would I want
>> to update 'feature' to point to the reverted version of its last tree
>> commits rebased onto 'main'?
>> ...
> I was going to say the same thing, but from a different angle.
>
> The sequencer in git is used for three different types of operations:
> rebasing, cherry-picking, and reverting a range (with a sequence of
> reverts rather than one big revert).  In replay, these correspond to
> --onto, --advance, and the new thing you are trying to add.  As such,
> it should be its own new mode.

This is a great comment that clarifies what the problem is with this.

> And yes, Siddharth, you were right that the new mode should be
> incompatible with --contained, but that's because --contained is a
> special modifier of --onto.  --onto, --advance, and --revert are three
> different modes that are incompatible with each other.

This answers the question I had on the patch perfectly.
