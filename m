Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D8226CF6
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327667; cv=none; b=KRHOkArUDe4aCPazA09sBfwsev6zQqHoPwwD/7QEAo79wrCRfglgtQb9/sUeVI/9v1HEFmdE3oALhgp/6R6VrbFSPxwfSJFk7gKyy14ha0USRx6/hU26G+IpoZighbYp3eicOfU0pZncO2ZT7LsV9Xn2NbFx45sxd7uW+t9632Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327667; c=relaxed/simple;
	bh=GqBxF8mL1vGW6hSbjczMmAALavXy9lHr2j6mmvj84ZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hafP0M8iW9saVrj8yXDv/q8VaFRk1GOWAAytesfPwaJajaGqyg/FUvDexFbt1w3NOmcedD+zFzxnepKJ0Q/3y7oMiisMs6uDdrv8t4yiTJcW0u27lYUaTOKfxBfav9UY9+1x/TuQm2Ootz/tZvyfJTlRI8o0yB0gLX8XUEFNZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MvotMKGw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJb0mJFI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MvotMKGw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJb0mJFI"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A743B140018D;
	Mon,  4 Aug 2025 13:14:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 04 Aug 2025 13:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754327664; x=1754414064; bh=B9IilIUMPm
	45MDtpLlstOUKdzR4zICNbWHe+feK16CQ=; b=MvotMKGwcW3JhrbmBDE6Hh+Cpr
	IKHnX5MWWceSqWIBqXFQ/Om6tf867hUpgZIXxy97GaF/JzZbAWiueJnVi+bBfuPD
	UY4rMFMgIYYYcDscrCpncESLdGBRth8VOMiRaBjHku3hZT0n7K30mLmTTrxsj6Db
	l4BOd/+HO7y3tt22fJ4VtX8zQg3ccnHn1oj2YZa7ykTEb9LEhkackSr35HaI/Ai+
	iNra8jUg9nOXhulNo2uY2zfiv0W1px64hxSR/KSwMj+D4PKkr5XdGAcDsAf7yOr5
	CEOiY7493WDtEEwq+gbT43YPshg6QEtPiVbeyo8QXGU+QDQV6FXuQ+c5Xe0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754327664; x=1754414064; bh=B9IilIUMPm45MDtpLlstOUKdzR4zICNbWHe
	+feK16CQ=; b=OJb0mJFI7OsWeZ7y+PpoqzumVjHU/TSTL1duJFNjgzWvmCtY/09
	p9UeRl+ih776V+gT22bOIn3i4HynZeF+Fcv8H/PUYRtUnGPNoMdj5GidVsrHKgzd
	j334JI3BI+f5yV0SZTaYjWzuWnENv9Hqr2b5habVE7Ungt83l3BEczAoq02D97By
	5E83Y6+Q1A29u4KEs8brJ86y7atvpk4wjeoLce6tbfxRo97Xc1D3CF299ZSBQRQg
	eR8AlvP4ydnMbrj9c97UHGZVjDrHHpAq+jcg+m36uFTY6eXbbzgL4GeVB+oHW/j/
	1TYdSkvMJPxNlWYzUVwULjugH/ytMWMOaCw==
X-ME-Sender: <xms:cOqQaCxXsSl-ZTlmEHrZrjpfZA9N_ifMOsSHZmL5kGyzzqtlGLhU9g>
    <xme:cOqQaJ_eCQ2blPR6Lr5CY1hrlO8rQLbWY-jIf0qIrs9vBKNXJBYLZ4yoc_n2V369w
    eFxBXEqyPYAw7M_KQ>
X-ME-Received: <xmr:cOqQaAylP7jSy3OrhYIkrKrJzdghywFdN5rVyaBFWPO7f7TACDqPrNGHC0nmR6OWNCWfE5RMMHfeXz-rcWLLVHoFFCdvY9N2nqvykPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepthhooh
    hnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:cOqQaBrmj4yZv6WvQAGgkydmFtl-q70viBFoxhY7a7htBSvLCtYZ3Q>
    <xmx:cOqQaJrM-qbQ9HDqAl8eVZwR9MYBMbSjiJEBx2weR9sCuOA48wUxFA>
    <xmx:cOqQaJDiUyrnUPR7yc3U1b-m-19vC8kq7hhWm05IPe37zb0ghuaveg>
    <xmx:cOqQaPvnduLBWAYQtDRfPvG6uOJG8YQlrruMQsOfVjJPshpDkmMUUg>
    <xmx:cOqQaMIcajQTOgQY2PWppcKL8kTgKkvqcWHZBujbtf-Q_8irEYCrR-CQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 13:14:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Derrick Stolee <stolee@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Jeff King <peff@peff.net>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
In-Reply-To: <aJBUWveulX7HKAMY@pks.im> (Patrick Steinhardt's message of "Mon,
	4 Aug 2025 08:34:02 +0200")
References: <20250716133206.1787549-1-toon@iotcl.com>
	<20250730175510.987383-2-toon@iotcl.com> <aIsQWcHf82ipHoWf@pks.im>
	<87ms8jui3p.fsf@iotcl.com> <xmqq34abm0iy.fsf@gitster.g>
	<aJBUWveulX7HKAMY@pks.im>
Date: Mon, 04 Aug 2025 10:14:22 -0700
Message-ID: <xmqqikj357rl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 01, 2025 at 10:09:41AM -0700, Junio C Hamano wrote:
>> Toon Claes <toon@iotcl.com> writes:
>> 
>> >>> +-t::
>> >>
>> >> -t, --tree-in-recursive::
>> >
>> > Sure!
>> 
>> Clarify *what* you do to trees in recursive by giving a verb, e.g.
>> 
>>     --show-trees-in-recursive
>
> Ah, that's even better indeed! One question that this raises is whether
> this option then should continue to imply `--recursive`. I think it
> rather shouldn't with this new wording, but don't feel overly strong
> about it.

I am somewhat indifferent.  We can call the option --show-trees,
which I suspect would make it more consistent with ls-trees, while
making it a bit more confusing at the same time.  I dunno.
