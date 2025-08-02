Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B3A920
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754152453; cv=none; b=p5gSG+AWw8YSETDLCsm9Vwv5JyQ+546GT70TltLpZ8LnAXubZ8nwCGr+AM4zHmktBkk22uF7HvyQe70WN5uw1N71x6ytSoGEIMB1ycc7H539dsz5Exo7ZQt8xqzfDDgtnrhfHTWx9cZ3yr42UBw7O+940XBOiTChmVHMeLeXD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754152453; c=relaxed/simple;
	bh=+codMXA2/MAoK1GeTIkQJ/KBMW+1/ie6uLlAdOYmLgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uedu5XG/WiBs6LkEwQXBftEzP0t3ACUQ9JOmgfK5CD6RyhOTId7J8/G8Nrgrijl/4mmm6p0NDCvd0kY81hfhsBUIwEm6kKaJaVcOVw6RnEdv4Sz/IGOz2xQ18QiXETQiMgK4/EL8z6jjYikjlH9Ypm1ISaqvBL5kvOjZnKX0mWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WeKaG4yq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYUQy8lD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WeKaG4yq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYUQy8lD"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CE92EC144F;
	Sat,  2 Aug 2025 12:34:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 02 Aug 2025 12:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754152450; x=1754238850; bh=Wq/1uOKhEo
	z+I91F/lPPnEGKdDPWAI0ERukhsr/PlHw=; b=WeKaG4yqdwty7pz1NnW3yL4bDS
	muiB56ponPQ50/UUuxJNP3RxRJn4u7yrmRlhyJTXa1Lmp0eXYSieCONV5H2b2g/C
	MTAn1TkhYZ+IfRv+pXpuAhSvjg++IyVDHgh3IZ11guLZ1wTYsyk33eOPZsrebO/d
	FuVbtc6N546O4i5kJep9s2mdOOjo0OWK4NPn/3sMjFOA2dqRUU7R8ubr/gVxfrDm
	ZLioTKm1OIG7bezODPYnXWQZC5Zp8PEy3eVgprPqZkwkK+oCzBqyNEgwyFtx3IS6
	pQ0f0Ps5hm43Zbh0fe8kYy2jc+IGQYjrS5YPmDnuJ88Bvfy3BwRAELMsHQqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754152450; x=1754238850; bh=Wq/1uOKhEoz+I91F/lPPnEGKdDPWAI0ERuk
	hsr/PlHw=; b=VYUQy8lDy7xWQ4Gi4Yw9gX5IJnM0+HCH3RF8/bYMsCGDOVjNt3+
	6quRUIZ+qqy2hIiMmUmn41hzCRobr9ZnlqQmBE6fg6NxujvpSODDhxnaKTAUXtWb
	yaiPcsl1VqqSAmjnsm5dPPedf/CynE+GqLweYpBfYX7j191Bk1zZd2qZUGa2S6N3
	zoEqa0NP6G75kxrlx8b/Lz9yeO+yykinQh9L27c1UksxElOFKLLedvA1B9n+V1Tn
	nJHnfLR17zzUG07V7yeRr6+M623si5UmDsVz0OmmdZh/gF0MEUO8wX+Kct7x6Gk3
	+wz6OiuuWu7pUPD2CB0XkkYNW78ued9iKXg==
X-ME-Sender: <xms:AT6OaDxjD6-9KorDZNJeNRYDGA4Ra44cSNdfkPXnOu2Ik8j_OcuNuA>
    <xme:AT6OaOgwgxTLi_TpPjJcAh3TccyuHDREFV0HRWgbBH-WrMNlSlssze7RDuyosRnTb
    QsDbyKuiYga8pDGnQ>
X-ME-Received: <xmr:AT6OaGzGdshQp3NPXdssDzmGJD4qVwhKBH83zP3pJ5Vi6KZ1LgAlUNu04zpeCdhkaffv3GSmdwNMORpUcgST10PqcjCbhdiWIDDAdiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdejtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AT6OaJL_yA7sas1YBJuae2AJdqy6_bSl7PTEWUFV5aOfIw4uUh68kQ>
    <xmx:AT6OaFR-WyLcd0aiiKPJZyV4m30_sImCDdMzHShDZIZgaG5dDxH6dg>
    <xmx:AT6OaJpLt49eIPi2773wy2b7Q8O3BRhl_Th4xqaj6NSyAf2JUoNOOw>
    <xmx:AT6OaCpNHoBwXa_j5IZVmhvLKNDhmo160wpm3XYpOz4Ata_KteKSmQ>
    <xmx:Aj6OaKlITLQd7qTNXvB2eMfC-V3K6fpWT4KsLD9TXGOD630UKJX32TSy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Aug 2025 12:34:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/7] string-list: align string_list_split() with its
 _in_place() counterpart
In-Reply-To: <20250802082257.GA3711639@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Aug 2025 04:22:57 -0400")
References: <20250731224607.3942417-1-gitster@pobox.com>
	<20250801220423.1230969-1-gitster@pobox.com>
	<20250801220423.1230969-3-gitster@pobox.com>
	<20250802082257.GA3711639@coredump.intra.peff.net>
Date: Sat, 02 Aug 2025 09:34:08 -0700
Message-ID: <xmqq4iupk7i7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> You must know by now that writing "some unknown reason" in a commit
> message is the best way to nerd-snipe me. ;)
>
> It looks like 52acddf36c (string-list: multi-delimiter
> `string_list_split_in_place()`, 2023-04-24) modified the in-place
> variant, but left the original alone. It was needed for the in-place one
> to replace strtok(). Probably the original _should_ have been updated
> then too for consistency, but wasn't. The motivation isn't given there,
> but I'd assume it was some combination of "didn't think of it",
> laziness, and not wanting to update all of the callers.

IOW, it wasn't done for some reason that is still unknown ;-).

> I don't think there's a need to re-roll for this. Mostly I was curious
> and thought I'd share my finding on the list.

Thanks.  IIRC, the multi-delimiter capability was used only in one
unit test or test helper that wanted to split at any whitespace.  As
it did not look so important, I could have unified them in the other
direction to only support a single delimiter (i.e. reverting that
commit you found), but I think the end result of this series would
give us more ergonomic API that we can apply at more places than
before, so I am happy I didn't.

