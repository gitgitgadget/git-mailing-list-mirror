Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BC2BEC5C
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613621; cv=none; b=Rm1etPcEsKJZNR8MjXXUVjhwcE3jnlngBceaHUWD++e9UwX12BYyQFrQp52QJ18dvqEWllTmsm1CA/VceHCUMSnNMnAsDVgPPfh1/3rLW5wmEthFEhWgrhc5F9KXXOIncmpZSXQ1EpGSaURQnLQr8Xk+vYQf5hWHcU2RGZ2il14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613621; c=relaxed/simple;
	bh=8vl4tR++jpOgjf6P9+HuLhlDVQsN85x8WrC3mldcGuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LZHr+ZMeUgyabv9svk/aEUwDgK4iIAN1jHR1mnn3hlgItwGD4YWVfuZORL6Y7pyRpwSp8Y+R+l1I/7Y1GzEIWBLilMChTmeEOvRMDaBxMRPpmPyF/G+lFb63lu+2qLMzWvH+sXkhqZqwwr/WqcEwrKn1ZU1MdcO3gnJDJdrh2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cuk6ZiHq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQQynh6y; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cuk6ZiHq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQQynh6y"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 257061D0003C;
	Tue, 15 Jul 2025 17:06:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 15 Jul 2025 17:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752613618; x=1752700018; bh=8vl4tR++jp
	Ogjf6P9+HuLhlDVQsN85x8WrC3mldcGuQ=; b=Cuk6ZiHqIDXONjLrrnFxLuX801
	mfPKz4pfOUWM4izRLKd0q7Cvmtq7/lN2I+yb/NZ8hKaofH2CEsg81a9jzqcZZ+WO
	oBt8Zs8TYkeflemXpCsOuAqBxeAUUSQuHOQPvL+hdhhRjcvc6C/sGIEdcGcvNIZR
	uaWPHsb8Od124QwSANUczY/OyCLoD20Riancw2D070GbXGFFqTHyk/s3IGgkqgX/
	nzH5ti7OtnIjpXQviTfMFDqnlcaLi2iKKxoHoiIVZUiL/tNAyl8jYJ0/8+vH9Y2D
	W8UlM8WTM6oQXGZicPBcEbB+5/9pNXh1eDjRTMCbsq+uEIBm/x9Ol467rFog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752613618; x=1752700018; bh=8vl4tR++jpOgjf6P9+HuLhlDVQsN85x8WrC
	3mldcGuQ=; b=WQQynh6yC5SvdOBiQ/nHP+rjDM6ACmWfNlgdmE1cRz/vrymoWTi
	aLR6sX2l5GafqRS5BJom+w23V1RpBS2EW+QZ+utLir8mS5JPs88ERH3gup5aN1Jm
	12SwgKXJ2I7MISSim9en1hezu9BS1PZk/72zHXaswdST23thNcytjNG4KO2ljf0d
	sR5NQ/gu9y4acxezDjNIET2jwuEubfnlgZ1JyTlXI2Qu6vBwVNalWRYBWpARg8vC
	o7zTRKg0voG7ij5pgIp0IZgDG6M8DyTm1cwsqXiFfFYj1uTbK5fl8K4kft9w/wtw
	uAJ1ZIZ3YOB1ckJfuqsreXeIZbE0H9v38bQ==
X-ME-Sender: <xms:8MJ2aBB4vLGhmeSWQrbsz-JrI2ja-r63ABC9_eo3V5rxA_xHpT3GbQ>
    <xme:8MJ2aEsNHLjvTDXug4Q7a6Po7QSnci35gfgzwNzocLFz6V69rB5lvjvI194syPq4l
    zK5MJcXe_ZGm0kJKA>
X-ME-Received: <xmr:8MJ2aNcIv8NgdvlV4wkG7MpAghYwuIgBWOfMXSTKWHZEA8lUa5F3UxWC2B9_mpWxKmvzJvQXP-noj7MSxuMn-_yJAQXrY2s663iAtco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8MJ2aB8-PxV5vXcuxsWMN5VGOdg6844OzbGmySs36xGewejaJbpqZQ>
    <xmx:8MJ2aIQtBTeXg2bRxTg7JrR5YfD_8lj6R_qdifJXCm99NoJtRrIvig>
    <xmx:8MJ2aCrO5gjCQvVWCU1bz1tfK1a-sBQfuvhIFBMuZWjDPjiaUi3noQ>
    <xmx:8MJ2aFk5xK9opR5E-hTBjZcnWt77dIGF3AxrE2uGdEkXGYWM6mnY6w>
    <xmx:8cJ2aNwFRKZbfJvYx5UE3xpaIheq4t1JTB-qEWufWczlIgmwv2-sPe-z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 17:06:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Elijah Newren'" <newren@gmail.com>,  "'Phillip Wood'"
 <phillip.wood@dunelm.org.uk>,  <git@vger.kernel.org>,  =?utf-8?Q?'Ren?=
 =?utf-8?Q?=C3=A9_Scharfe'?=
 <l.s.r@web.de>,  "'Brian M . Carlson'" <sandals@crustytoothpaste.net>,
  "'Eric Sunshine'" <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] C99: declare bool experiment a success
In-Reply-To: <000001dbf5b5$8b316f00$a1944d00$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 15 Jul 2025 14:23:14
	-0400")
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
	<cover.1752587571.git.phillip.wood@dunelm.org.uk>
	<CABPp-BHoTxT1UQtgy2bH=mc1re_LPngKX-50GPh_wbtMMZZpyQ@mail.gmail.com>
	<000001dbf5b5$8b316f00$a1944d00$@nexbridge.com>
Date: Tue, 15 Jul 2025 14:06:54 -0700
Message-ID: <xmqq5xftgo41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> bool is not standard in all c99 implementations. I have to #include <stdbool.h> in order to
> use this type. Please make sure there is a mechanism for that.

Given that <git-compat-util.h> unconditionally includes
<compat/posix.h> and <compat/posix.h> unconditionally includes
<stdbool.h> even in today's code, that should be OK.
