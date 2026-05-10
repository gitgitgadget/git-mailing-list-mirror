Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF518AE3
	for <git@vger.kernel.org>; Sun, 10 May 2026 02:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778380280; cv=none; b=FJONgI8QLELvcJxUfZaMNLH/4wRvj8LEWGwf5jnr/e4GzpIIn532mYWIw/HEYjiIee6oP9gWl7I+6ChOmEA6p/IY18ZnH7XAXYRMZzY3svCGzwx+OV1Q5gsvMysTExlvOZioIZzLm1Lkb7JGKsGqFSCyR7hsft2FzkBxUQjZJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778380280; c=relaxed/simple;
	bh=zhGr7DisXz/oY/KVcmWHy4AnSi7rqjBKBvJpYKyoOKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=alaAGLGSJZ+WoR2fwP7PFz8+PNZ9if28Begzf1FlaThFbDIhFTva5L56ZlKehDlD3UnZr5VrEPqM4RDVjZ3Fxya+1ILWrB2LqSh40gTMw2Tc7X4+4cblQzcb/A6UpPy/I9l73Ihsvq3wKoRiNsGuxv9A7Tv2mDlLDcsPwf/Cj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g5Ah5D7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NOEw7Rjp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g5Ah5D7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOEw7Rjp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFA571400051;
	Sat,  9 May 2026 22:31:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 09 May 2026 22:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778380276; x=1778466676; bh=YcjJQlwVTZ
	65i7oFmfe6jvIQIMGtYMdA9neFPgLBVRg=; b=g5Ah5D7dJ6LHkYd9ckFRqzPZci
	nZ3ret7ObZwfHMHbq+Tr4bWL4/ugJ1Zom04p6gLgZJ1FpOv07l05sB76e5D27fSS
	tF/PHL5IPmWj7ahHAy/IvMOQAvmHoBhYfCUMMFRqv2dN8vx5/6zdoHLoY5maRXdq
	dbgC64LSEtRYKDN8P4hM74v18R0Mloxs5GpJfLFhXXMUtebWnvEBfaicokSoCGJs
	vFxNiI1WOuwhMsB8Rl5MlM5yiGZZ6NVGTxvb18gf56H4xe8w/3Cn5KWJBnz71Oeo
	XsTz6iWVr1BU3mzjLQ45ctl7Tu72iJRrxKAYG1Apza6rGjG4YCtgjz9W6LFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778380276; x=1778466676; bh=YcjJQlwVTZ65i7oFmfe6jvIQIMGtYMdA9ne
	FPgLBVRg=; b=NOEw7Rjpo2ZJB+xtNJ9rV+TS3HQDUHAoqeIIawQ47CISW4mDa9n
	AlmlTurRqWJfS/JjD5abs7kvFCqWHlrbiFfb+YcOOL4TV6QPEKuAGMfExVC2Gjhj
	+5vHUk//DGQpO8vQypVG68tQhG5JStV4xtqrEEG78y0xRNE2iDytE3KHaJYgmQAk
	YXBAiAFoi4xG2X4BwYdKtmeXETvXNFQZjjslgUCnHpX0zgswomi7YhEXPev/S13e
	4G5E2yHFCn05FgD96bF5VtMx2X41wOLHDokAW9iMlfU86PoB/ePTM8gLRcLuLK2I
	EpFJYkdCpArD567w3NIGBj1cCy+0xllc2CQ==
X-ME-Sender: <xms:9O3_aSLso5SB9g7T7-jGg17BID66GUgziebP2flqg2Yf8NLBvsD5oQ>
    <xme:9O3_aRD9dtas0M3kRrhGo-1ov7Ew5HQjwlnUndAAndnN_pnvzUt6ZT2tr5ux6ltJQ
    v2oXzhOxhwOjGj0TptAB4F8VRB-1QqENsoBFNHOd_os2TB-tUxe-g>
X-ME-Received: <xmr:9O3_abCy2AV7dXCLnKOi58JHLF2uVsjF_vq2TZ7Ks0SIGhPIpladp7ZSeovgTRqYRwNXc6W1WvSSPbqNP9kc50qmncZdSV2iuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9O3_aTBfrw1l1JQPnk3h8EN240JBjOb8ecjQszIbRb7Gw3ftuSinxA>
    <xmx:9O3_aWpkhvjmaZvxQqQZIy4yAISLMI0qS7ezpVTM16M2YrDJT2DdKg>
    <xmx:9O3_adlWJBElapms3ueHprtUtVHWd4iPA_pcqNMZcnAIaATARGZvog>
    <xmx:9O3_aWw4xYajPRK1gO3e9uqYRxYwykypQTItptQ2iGWktzC9ihnzxw>
    <xmx:9O3_aZZRAR_s_oQn4EzyVY9XOAlTx1AQAbClOkjt-f4nZxg7Ge27yv9d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 22:31:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] mingw: stop using nedmalloc
In-Reply-To: <pull.2104.v3.git.1778244661.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 08 May 2026 12:50:55
	+0000")
References: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
	<pull.2104.v3.git.1778244661.gitgitgadget@gmail.com>
Date: Sun, 10 May 2026 11:31:15 +0900
Message-ID: <xmqqmry89erw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v2:
>
>  * Reworded the last 4 patches as recommended by Junio, in preparation for
>    squashing them on his end.

Thanks.  Applied.

