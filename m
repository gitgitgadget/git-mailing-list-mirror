Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC130214B
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773970255; cv=none; b=XzVXGao1aFxwInhrc9Wb9kzdb7Re+hchAzNKKkr/jUiyejLo/BVboX9dxSmL6ZpJc4nujyFy033b5gF56SRqwAhySTgosCij4WenWz0qNMYtwD+IvK2F05uAVrE579o9k+kk7pD/UK3jweb+UJEW5BmxrkRUOr7O2yC70RQ7obs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773970255; c=relaxed/simple;
	bh=qwueRNhDA1KEX9T+OaXaXYf7+h9DUC5joApGQyrXz8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZennxbtoFEiX0gc5vlrhGS5IuERxnW4fbI8Deob/0UMN9MA0V/Ns4gopKfG34xT5VWH75I/KQyNsJ1k3y7gu2lUrotDsaAAQ6XeDn1Gs6IBMvkrGU2b8zyaFOsjc8bs5Tdr2OXmD5oWetsDRSQEJ4BC00u+WhC5g8FVBh4B7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fd7ScGGe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dp1iPfc5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fd7ScGGe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dp1iPfc5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11EFC14001D1;
	Thu, 19 Mar 2026 21:30:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 21:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773970253;
	 x=1774056653; bh=ONsv+DsbOmV17sh9SdM6uJ6dB1agAR/On0mMNZx6ueI=; b=
	Fd7ScGGeif9WV1oe5qxcErYnjrzuP8rKxPNgtiaJoXz6vWrwyXNkvU1cFHo5wac2
	JQlbONnoM6GEed1k8hai2Y+S1LRf6P9acIBxs85lMRGCI372OEoLHnljlJ2gkDjZ
	FCGOp/ZN0WW95lkr46te8xByJjOG2jurMqM6epEod6uxviuLvD4Imo1fFxALj3rv
	gUl1R93BE2IqrDnqW9991kGIR7oLtwptMY/1oHudXyDThyew9Ww08Gev07tiGQzZ
	KCw0GzXyXAEx2hhv9uPUsTAGz1LMN/k+83GE8HF7zMOs/5IdPTQJjPe2yqeZyhIx
	ZkJt3DuUfKVDzAthJyqwfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773970253; x=
	1774056653; bh=ONsv+DsbOmV17sh9SdM6uJ6dB1agAR/On0mMNZx6ueI=; b=d
	p1iPfc5FR8VQP7Nn2p3f6JtGYew3Tyb7Y/uL/xQEkHQkpxb+96HalQ8lvBiw5q94
	KwB+jjAwQQRqQzLsd7bQDtj/q66pDc6Lu8s7PAa9W1HYTn6udw/WXLTVNfhCCg1j
	gb7sQ5H6rUpybR8T/8Y3iE7mzNwbn0DXHqDNsv1gtR6rF3c9nZsnJDQ87/gXBgGT
	CWtDthvJwIJkAkIaGYDyjHqghQGgi6WYKiN/Cus7UkdCvWFbSWOQ4JRXYFt2cbmQ
	bNm6fybWsUANeh6O1kPi84TCBeQaQBUryeZVI495T9XCz3oJfpb1lB/DBl++e5nm
	jp8bEERBCEONn0AJEk1Eg==
X-ME-Sender: <xms:TKO8aYr76afjlXBvZW1_7jtpBgDUg6ce2tCMaXZrN6D9NNCflEDWTg>
    <xme:TKO8aWENqPddZ0tf08BIXvxctSkr7W9tC6WFN7DHWOJCB4QGXD4CpOpc5j03o2PXO
    cKFopUu0GNqRKzAOMceC6EfDnftbjmPivoObv7tCQ9LbopqjOPHGwo>
X-ME-Received: <xmr:TKO8aangfBauo4tWsqDmxfro9NSwuwdqWM0ww-O9R0paiCAwY02CwxjDepP6D3tHIaqSSQdhVvnUrvTlDrMbvsaduYaL4O4wDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepueeuvefffeejffeihfeigeefhe
    dtfedvvdevfefhkeeljeffjeejfefhueevteefnecuffhomhgrihhnpeifihhkihhpvggu
    ihgrrdhorhhgpdhfrhgvvggsshgurdhorhhgpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TaO8aZkBmleXN-tklIwmGUmKn_qksG7S8uGchoZEbsUcRvnmaygTag>
    <xmx:TaO8abufbzso7Ww56gYb79OYtpK1N0ibBNasx2giNvo1MGEvsg_oKA>
    <xmx:TaO8acmF_gxuPoO73AXdMGDbOP8b720Xk10H7X-HnjIs1gfAF4RMbw>
    <xmx:TaO8aWuWsEXoIs081yuilfGAxJDdgWX7qHc1aXWBTsfaqxg-XN6baw>
    <xmx:TaO8aevhspO3eI9T2KHGFlwmwtzsjQYT6t_WLBZpNq1GLxCIIVme7jjr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 21:30:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] regex: not all macOS platforms seem to have REG_ENHANCED
In-Reply-To: <6cd35848-a234-40dc-bb87-4c2cb7eff52c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 20 Mar 2026 00:11:43 +0100")
References: <xmqq8qbnigxp.fsf@gitster.g>
	<6cd35848-a234-40dc-bb87-4c2cb7eff52c@web.de>
Date: Thu, 19 Mar 2026 18:30:51 -0700
Message-ID: <xmqqv7ergud0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 3/19/26 11:37 PM, Junio C Hamano wrote:
>> Earlier, 54463d32 (use enhanced basic regular expressions on macOS,
>> 2023-01-08) started to use the REG_ENHANCED option when ERE is not
>> in use on macOS.  The build seems to have started failing on
>> macos-14 CI jobs at GitHub, however, as apparently not all the macOS
>> platforms have this flag defined.
>
> Interesting.  https://en.wikipedia.org/wiki/MacOS_version_history says
> macOS 14 (Sonoma) was released 2023-09-26, i.e. more than eight months
> after the patch.  And the oldest regex(3) man page I could find also
> mentions REG_ENHANCED:
>
> https://man.freebsd.org/cgi/man.cgi?query=regex&apropos=0&sektion=0&manpath=macOS+10.12.0&format=html

Well, I have no idea where this breakage came from; it suddenly
started in today's pushout, and I do not think we have made any
changes on our end to cause it.

E.g.,
https://github.com/git/git/actions/runs/23315793655/job/67814861386#step:4:301

In any case, in the same CI run, a few other jobs on osx- that uses
the same macos-14 image seem to be passing, so I am reasonably sure
that the posted patch is a *bad* idea.  Instead of forcing us to
figure out why REG_ENHANCED is missing, it would just hide the
problem under the rug, possibly breaking a random regex tests that
happen to depend on the "enhanced mode" working. X-<.



