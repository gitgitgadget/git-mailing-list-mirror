Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7602D8771
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764983160; cv=none; b=hVf+seOiPAKyoIAUqv/Awx/wgwi+O21QMRzxBcaNq58WOhYT/deNpJcg3MsTIgsUN8tU+VNEkuk+lfxap+Jidkwalsx48xMJUEONHUSA+d0iMEVbu393itAa0Uhij38fp8wiWAj2Jm8M87MI/FGIDTnnoVJEWgE0PmZPmpYTPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764983160; c=relaxed/simple;
	bh=Z0q5Ix2devXP0ypU2rFLOzfg/tPDyAXViklIt/PXGHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iH0xUHL5s5WT8Dr6egXNt6F8dtkg+0r2EBQOyRtiFLVQgvMMfn+WnG4s/jeRPZ7yyfykighFMrwZgHT7/RGzya8jXYSeuwMXTfsrXSjk8VD4KhdYPv6nT9KbKJo48StbdHOROebINzOLCU1NZmspVkGdpzNnV+mhvN53hypXUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D6YOUemR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cR0ColBd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D6YOUemR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cR0ColBd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CABC51400227;
	Fri,  5 Dec 2025 20:05:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 05 Dec 2025 20:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764983156; x=1765069556; bh=bK94HGo22A
	CUQQOCSShCQW63QVYwLjdaaVhBIifi1X4=; b=D6YOUemRFldQWibR0P2neqQmIh
	rzYVDSxRULEeTiwMvWlVt4IUG1IAEI5uGh+od7/5+58MhIx5YF1BaQ4Wmdonkl52
	dodClhEGZC4sUexnfAJc5FViqOsQks1k0JMEdLmCk268yNDHUFWX3Wfot82kJ0n0
	SZ3TvP8sceDOyYWgfqD1pyJyD+1MmYx/DTC8nP5/p/1T5Hs0P82DghNpWPdr4lBI
	C4k3eSd4MQ9r1RcM10UvgoVNMLqXTWq9VXau9DlcPQT0X9tIQ0NYyr0DyPni7r/U
	xn3lEFlDayvvlFyZ/bnWtlBgB5+Hy8QjN0vjM+Ax45Fa53qkMtlHrP177Vng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764983156; x=1765069556; bh=bK94HGo22ACUQQOCSShCQW63QVYwLjdaaVh
	BIifi1X4=; b=cR0ColBdPspsiNl8e75PiHxhMds86bJWFq4sZ7ZuVJzI1vujxh3
	8SAbKNzNWlb6SkCDQj/e07Lf8dNI2gp4XQryV2uM0v0LcrLod3xeL93Y85dH7BgS
	dzI8tzxbnfP4pvbwo7LGGXZKBhFVtsMzGJGCYLwv+rU47WO+w7Wf27CfWQgRYPe0
	9rTUzh+T/4l4YMgIu+nyH9PNjauMB3U5Bzh5JDJe1eAYdAff3/5dgaz00/Q3mkhR
	TYHB0EwoDLGKFXUUovOPvF4IIoAt1kv4rdNX/FMLffdsaTvuBF3kvz0pJHsPwh8v
	CGuTViWfzR9AkebHNLQROmCu/lG+E6I+NHw==
X-ME-Sender: <xms:dIEzaWP_Tta88WbIEUwJ_UaucmxkMDIykcCNGuOhAlbvwsTqXTZKnA>
    <xme:dIEzab9viOWQcNI18bHx3aaWvJlDS1T_Nzf_7bJ-XF7HypccZOPq_eB3iPxRXM68K
    lYCbC_l4F1iyksOABVed4micB-srVPGa2bTALSeGH1SFfz9123LAw>
X-ME-Received: <xmr:dIEzaSQ8e2NkIuOtmAvNctwiv6_l-Z-yt6MbwAgoA5corfYDM87FkBdK5JAykw1pQds2Jgsgpl9yy52aBK8XQk-Gw1pBcXWNJA6J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dIEzaVkB0ZVlLA3BKDbnrqvyQWYzaY9XHlL5LjmwDnb40TgNA5YysA>
    <xmx:dIEzaaS-gKpN9qj9P7ov9nKTBkVS-C3c5CxO4-SSKnswPNYgYprGUA>
    <xmx:dIEzabPR3oka5gSajVGnzJAHkZcsfSQsz0YoKl98nuvR7viheNmI5A>
    <xmx:dIEzabUuNffoZTlUNbLdbjiSje4amMd-dwQ_uNb9Ly07qmGH3yDHjQ>
    <xmx:dIEzaY5ecSXJKfqwBfeoxb4X_R8LqvjA_gtOF60F70FBmxdw5SYaj0FN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 20:05:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 05/10] t0301: another fix for Windows compatibility
In-Reply-To: <8129143e-79fb-cadc-8f88-9c8daa73c317@gmx.de> (Johannes
	Schindelin's message of "Tue, 2 Dec 2025 12:14:09 +0100 (CET)")
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<c59a5f24789cff55819caf92d828256f2291b3ff.1764440906.git.gitgitgadget@gmail.com>
	<xmqqikescar1.fsf@gitster.g>
	<e355d80a-a0e9-7795-06cd-1b8acfa6c7c8@gmx.de>
	<xmqqfr9t8flg.fsf@gitster.g>
	<8129143e-79fb-cadc-8f88-9c8daa73c317@gmx.de>
Date: Sat, 06 Dec 2025 10:05:55 +0900
Message-ID: <xmqq8qfg772k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> It means that we are punting and are not proactively helping future
>> developers who may make the same mistake, but we expect it would be
>> rather rare so I am OK with us making that trade-off.
>
> Good, then we're on the same page regarding this approach.
>
>> But then can you dial back your condescending tone against those who are
>> not as familiar as glitches in the Windows port of POSIX shell
>> environment we use for tests?
>
> Please don't read more into my words than merely a large frustration with
> the state of Git's test suite.

Well, the proposed log message is to help future readers of "git
log" by explaining the relevant background of what motivated us to
make the change.  Knowing that you were frustrated may make them
sympathize, but it would not help them make robust technical
decisions when they need to further change what the patch leaves
with us.  At that point, telling them our intentions would help them
avoid breaking us while making the end-result fit better for their
purpose.  Do we want them to be extra careful not to frustrate you
specifically when they make a follow-on work in the same area, or
something?
