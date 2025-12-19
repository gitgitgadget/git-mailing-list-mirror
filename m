Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61811219A7A
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766119481; cv=none; b=B4XC39VSDarZnRljTqXmE1UR1OSLGKJ88j/qR02iGAZtsQ4KRZsufUXfuYfU/UDl7rArQjT1DJ4xRCBPbqz2wtKZudbfd9B0tnxCyJ8udcSeJmdUnG9eI8/P/VV25xBo2dQBA3NJX/ztwnNStrVZBLPvt0fBFFU7MMzotezs6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766119481; c=relaxed/simple;
	bh=E8xYC9aqjeJaWjJpV6LjIFtVErKnkidorB5GKqJgbaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gwgiCQtFI2gLpFlrkzsPB8dDlKi2MLesYriHVIpVVwm/YjhLfeSwWQ8XmiMxyKAFu8A/I1zFFX5YDhkSqKoNQ2itsm7RFHra8OF1WIMvxSJbybNx2SUx9/tLBUwRQTgra77vlCrkWRk5r8vDz+pX90gKNxZaYvRHwstslkylzNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mgi5hAON; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rGKTGGoW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mgi5hAON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rGKTGGoW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A5737A0081;
	Thu, 18 Dec 2025 23:44:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 23:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766119478; x=1766205878; bh=e4kkLziHuE
	LHZ136GIjF4DLi/xV1jPd0elS8WLwo9a8=; b=Mgi5hAONLEGSwot23NTpDGrc35
	MHWOQF04nabQggHx7fGGdfhkUxiKqISOlzP2HIY2CpI1J8WiXbW8YNnzHxjElGif
	c6QBNQBTLC3uHJ5OcVG0sTBbdW6JkmP7BwD753OJz/Csh3LEV2k3dZ0UttfV0ESa
	CzdPao7cVhoUpAa9IZ+utMo2JIT2QHzYL9M/hPUsgZ8USMAUlWeIDLoxgN+rb8fN
	sk1qoGl/yRZ7BCFKuauTIIeBtia19GvE99lZ9h1SS3hbe/EFEWIDcwmUp3a+B4Yp
	o1TH+2ZhdLiFBbFectoRCCQP8kNW8TqkHTvfo3YwvEOVOdB0jNPqNKwJDcZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766119478; x=1766205878; bh=e4kkLziHuELHZ136GIjF4DLi/xV1jPd0elS
	8WLwo9a8=; b=rGKTGGoWChKwRtG9uJJX1i2VeiPw/y0xfqfasOZtaefoj5vzYD+
	+wHNvRZLRhJy/I8ZxgUTT/VWz9g3wpomx2hp3Hn80RCv+PgkRKESyhiaFaUTmSF1
	+jf5sxL/Gl2FryRPlgH0dBtJZfPa739uP9tKbLdNvxdQrzMbpI1bvGmxaUc9AL6V
	YH3GLPcfJ9hjS6bw8jAz+ZbYTM/LNSFvjuRRHtXCIylpHFZvnoKz3j6fCF1J8jqX
	XmHYX6BHtSg+RkUplGSHBukB5uu4nOchQHw+xVnQ3rvVUM4SYR/ESc5A7OgsJ41n
	GiDBe3J95dkOPOC97kLSmwngRrM62PM+PKA==
X-ME-Sender: <xms:NdhEaWRudsWvXkbDl5eDzzpJHqvxtOmrg52gw9e2LvMifP9dPVD41w>
    <xme:NdhEaSq_9xGyKaHo8mv9YdhBP5TYwb4E-jjG7r6L2JNgBgUquKC5waD8RI4mZ9vyZ
    DTvArIh8m6GQiD7DVvU4o8GoLc6gfLtCjiMyMuQgQpOhqV9BF--xw>
X-ME-Received: <xmr:NdhEacKzBoYINzynzFDyjpT9qND0KKuwLRgjSn-XSekogZgBwlqRFhq_MJ7afAP03Wsl0eOriDYmPf_GTIDWUVezNWq1oTkl7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NdhEadr_0455K-8vBc3llDAsHZoUv2EN_3PDLmmeorOdo-1SEJgA5g>
    <xmx:NdhEacyIL2aqsTXEGX1Lu-F3beZVPpDDBxOmI1YPNa3rjZdiaC6fDg>
    <xmx:NdhEaZPgMD83IIgESep2Lv3dkGVQ1YIfY9pkS5wgdJ0m_1EO4Fe02Q>
    <xmx:NdhEaZ74UKkJKUkgketn93MFqo9TAf_26AN-K4NWmugy6Io0qSUPZQ>
    <xmx:NthEaY725D7DhVOZpg__fic2Ep62685lvSXhZQHOceP4NhbkaIFvXAyp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 23:44:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] replay: drop commits that become empty
In-Reply-To: <375adc4e941f3bb22a2b12ee26a083951ed724dd.1766076625.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 18 Dec 2025 16:50:26 +0000")
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
	<375adc4e941f3bb22a2b12ee26a083951ed724dd.1766076625.git.phillip.wood@dunelm.org.uk>
Date: Fri, 19 Dec 2025 13:44:36 +0900
Message-ID: <xmqqv7i3w05n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> ...
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> Changes since v3:
>
>  - dropped "--only" when creating an empty commit
>
> Changes since v2:
>
>  - added a couple of commas to the commit message as suggested by Junio
>
> Changes since v1:
>
>  - modified test to update refs as suggested by Elijah. I've kept
>    --ancestry-path --branches rather than switching to --contained as
>    I think it is useful to have test coverage for those options and it
>    means we can check that empty commits are dropped with out replying
>    on --contained working.
>
> This patch is based on ps/history
>
> I think dropping commits that become empty is the sensible default,
> if it turns out that some users are relying on the current behavior
> we can add an option to retain the empty commits.

Thanks.  Will replace.

But I am not sure what the next move for this topic would be, until
the base topic ps/history is sorted out.  There was a discussion
between "it is experimental, the early adopters should be prepared
that the behaviour can and will change" and "the behaviour being
questioned is so fundamental in the workflow, it is impossible to
fix retrospecitively".  
