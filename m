Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70A30C375
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820138; cv=none; b=iGhEtWpy9l70E3DMZQYHvcj/08NDDXwU73/7TPcLHa2O1mPEH9gANOqKLZcufx3Cqyq7lRhjjgLO3DS9Lpzkxi63V/724bTjo+t9GieA66Je6lmJQrbDIcX+46iESMi7Ege69iyncnpFzH0Kli3w4FZMGPlSBfAUefU2+uSl0rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820138; c=relaxed/simple;
	bh=islPjBzJ0xjX/cZ+CBtLcQOIY7RAsErpRuk7fkM4kNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vq62JSl16/VNVL9pdWeRefj1cI8ugMIQQvgdU74JWGr9DsIKHv0TYcdAVZePaeS+kl5tvjBebTEwPmItHp57W4pD1fbnS0bcR1cKqztMpX2bLp2E0a24BxGeAaWQ1qZV1Uw+HA1prfJUgU21wHSMHeNl4bE8VdRCoHrRLbOrdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lGLyohjl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LiWzy9iQ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lGLyohjl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiWzy9iQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 867EB7A00B0;
	Thu, 25 Sep 2025 13:08:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 25 Sep 2025 13:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758820135; x=1758906535; bh=islPjBzJ0x
	jX/cZ+CBtLcQOIY7RAsErpRuk7fkM4kNg=; b=lGLyohjljcsp1BfAsikMts9rUK
	mW5s6sh6tSKNzpU6jAM0fak6ktdmlQof05/oM0B38B1CK2VjE4jURir6UJ0UIe/g
	EWE8F91oJgCPD7iGs7tQT+9enuiq+W+HLaXlaUYa81LrKdkMhTod4ditNFh4/3dc
	4R/r+OP4WmwQwcrP42ECqAq1WoG/2fKU/hlm6ukmqrGpirA3W8IXi+uwUq0f3xfn
	GdTcl7dzbijVjEgX/oHhhdfgPDsjvMKNmVCVFv4FQ+H9+Fqwdy+qkz7QYdqjcdvK
	WsXHT3ctzXfK8C3IpKON1GiZ0YxXjMcp1xDsrjDEPwuNGXjZ6gM43C4k2Wpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758820135; x=1758906535; bh=islPjBzJ0xjX/cZ+CBtLcQOIY7RAsErpRuk
	7fkM4kNg=; b=LiWzy9iQ/GZpAEO8iEBiqM6G2zAtRNyBcsXSvPlXwQuPBMkaf6B
	yjFhBX+lU7TCtaTOOtx6Vx42OAcAM+8d42TMsHB0fXr4Bh0V+KfQOoeQqwvzFhFE
	yuhoiHo+f5MfsUnfIPEqxNoy4eZ8E3mwHt10fec4QsJIivmZHcAT/QXEPKYMcJEw
	dmqPTx6f2XvAewloRVnOT1BkHKSe/VP8mtnX6svXYfE7TO4IXAOcTGC3jv+aBtUV
	a3zlAXvxCNcXWkch+V6qpMjv40HaNL0CnxdWYi86jCkPoTAERoJzcdJxUK+5oFjZ
	mt/KTP0/8aM245S9ACkFCRg5JBaA7PLOiqg==
X-ME-Sender: <xms:JnfVaLZvawvAS3IFYBwxh2Agg-VwtCF_riaMusmQARYRrOKAMN5p6g>
    <xme:JnfVaFUzFMLJuEFa6ZHzz9oIABVr4CRnpPapctsEf63D5fBZk-qL9GwMS0KvwFT2y
    rSe0CsrhQOExowt87Pzk6B2XY6ld8KZHFZBoopSLu8_mC61LWhJlA>
X-ME-Received: <xmr:JnfVaM-vHN_udErIfY8fKGVse9PKDFb0L6OBOg0885tN1MqLOh-TxqShUxqcA1tRUt91BknUchCq3gRFFwedX6MrgXAI6RrLLu_X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhesghhithdrshhtrhhovhgrrdgukhdprhgtphhtthhopehj
    iehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JnfVaG_ZzFgEuqhLIKF1ZliZrNE0TX-QpgNZGclSTNrrmPZnz7C-9g>
    <xmx:JnfVaEQqKnrQ4gTBx7dZq0Gk7HyGWNqcJxDJLUxbi0TxtQ9stvnE3w>
    <xmx:JnfVaCeFTGMGn9fJom-UGX8ppE-hiNm-VAwrBFC6ZIQnyTVzaeXIcw>
    <xmx:JnfVaACQ3uA64T8aTKf5wOZAOtTTgHo-L9AVtsZtnBcbp7Vydy1gyA>
    <xmx:J3fVaAPcDjfR4q-FHYj39HpClMDsi1dG461yrJagTcaI8I4tG3s3B8WH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 13:08:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Mathias Rav <m@git.strova.dk>,  Johannes Sixt <j6t@kdbg.org>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
In-Reply-To: <12659f80-2934-4158-9a22-7a4c11060679@gmail.com> (Phillip Wood's
	message of "Thu, 25 Sep 2025 11:11:56 +0100")
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
	<xmqqldm4onma.fsf@gitster.g>
	<0a14a93e-7da2-43e1-9d71-c58a69c7a4af@kdbg.org>
	<7de3da11-6191-4fa3-bd0d-842dc45690e7@app.fastmail.com>
	<12659f80-2934-4158-9a22-7a4c11060679@gmail.com>
Date: Thu, 25 Sep 2025 10:08:52 -0700
Message-ID: <xmqq7bxmh32z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Mathias
>
> On 24/09/2025 16:21, Mathias Rav wrote:
>> I have never used the "amend!" autosquash feature and I was not
>> aware of
>> it until I stepped through the code in sequencer.c to implement my
>> proposed change. I think the `git commit --amend` manual explains quite
>> nicely why you could want to keep the author of one commit and the
>> message of another.
>> Before discovering "f -C" to achieve the "fixdown" behavior, as
>> Hannes
>> describes, I used "x f" to invoke my own single-letter shell script to
>> achieve the behavior I wanted, and I guess I am fine with going back to
>> that for the cases where I want to preserve author dates (which, to be
>> fair, is often not that important to me).
>
> I'd be happy to see a patch that implemented a new option for "fixup"
> that copied the author. As the discussion that Oswald linked to shows
> this is not the first time someone has wanted this functionality. The
> issue is that we don't want to change the existing behavior, not that
> we don't want to support this via a different option.

Yup, thanks for stating this more clealy than I would.
