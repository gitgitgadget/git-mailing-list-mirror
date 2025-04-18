Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D077215066
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745012675; cv=none; b=sQVpV2jOmWo3tR2JvHVpyRUBxUT1BEUoKSH3G51wc79A73p3rTLRiyUGLYG14/lpfIbVVvMDKCWA2eHjY+uVYRdlSiDC3o3ZvZh2HAwmHTpAf62b/WPj+/qIxf7E2ajiCOQiB0U+6UuJzbBhaJQ3A+LbV1wr0I5TrGTIchXX8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745012675; c=relaxed/simple;
	bh=8ncvx7V6YHRCdLT6or+itpMQPLC3QGOwj3GFZ18QT14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzCnvi97UdqquL7MwOIlarV29qXjsWqXWh2rxGZCBja1fmDs8yPaEnt9Nenancy6d/Pz/8P7R/eD7HPjXrzMrjqV+C5g3FXhhft3Qh9gCIxiQyeVJIzzUZDgzFoFOB642AYkTnKhwUnBv2LQettIenNTHkhsQbjkYQmpzKt77Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vmC4g8P4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qhkKsQXk; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vmC4g8P4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qhkKsQXk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 127041140262;
	Fri, 18 Apr 2025 17:44:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 18 Apr 2025 17:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745012672; x=1745099072; bh=8ncvx7V6YH
	RCdLT6or+itpMQPLC3QGOwj3GFZ18QT14=; b=vmC4g8P4+Epp9j6XIJ8DEKsRVz
	fmXpEzocXuJZrorlPORTnw+Hp/otmeAcVj0Dn8K0svTtcMNq52Mix3jGX7+02f8+
	jF1UhiRbw2PULUcECO9MNQQHPNdgL7nkqnnqjwFLvtrhflgDOMQ780nNTtlqHzPO
	QCiIrV/RjXKLWCiikbt6t6oNg3lHiiGgAHW6ZfyGZiJLTc3qSkJC25Wpa0YRJIGc
	ExwrGVDeq+ZUTiCzKH1TdRCOwstWMtGRzXL5im7PDKSDkYs+nFKNUowamWwokAh0
	rbHE+8dNAdLYMhkdFFXab/hSfr0njjXb1Fk57eaLE+5Q58GI2KGSg2iicrsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745012672; x=1745099072; bh=8ncvx7V6YHRCdLT6or+itpMQPLC3QGOwj3G
	FZ18QT14=; b=qhkKsQXk4lpHY9LpvshP1mHuur54eiCjR2yapKDuioSg9U6KW0j
	tsn0fE+Rp5eDj1o68FaJIuTr05AmLNtK+ohqgnRVfwzZSd4+0snCJ90GatvjGTZX
	DCMjmToTkbnja5StLINDBeTgBTjXgr2D1pwvVUYsUkQSqQGaovsa3v27sS/TGozK
	VABhhlrQdkoS4fH72QJsxfdBE/CIu/9A0Ow7hdMl8MTOyA09ChonIrhk04N4PIf/
	ZpVX5G9a0V2sOKJpFpYqh7tbXgVgNchJU9tJ2olEcagLNPuS1IE5PiwlnW595O48
	oJ+OVLenY0VMcoN7O1Qbmgqjlusb2UA+qVA==
X-ME-Sender: <xms:v8cCaFzu_o2BqLKSOKFVcJlCkGPBMMBqqJPRmfV7s3_xtS7CDD3hyg>
    <xme:v8cCaFRBeEwb3Aqi_hNcufBa_xsl4lLZfIatj4AECYAFxx3am68hN3-8g0qL901KJ
    ido-_C36xfwJ7AVuA>
X-ME-Received: <xmr:v8cCaPWgtaI23BC69lqzPePRQees51Y2F-6rL4YrMtFUoB3_hMcXIz4bk9PTDmdsVnhqcYDTqZjufqWI7o2bckF6UXUra56Yv7yE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopegrnhhthhhonhihfigrnhhghedufeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v8cCaHgSsZKqctS2nH6tbuHJDA27pHmG1mLUCxfIHa63XyZxqixVHQ>
    <xmx:v8cCaHBx4N73d-fzZz4jg3eJId_UyBW4YuGFsxV5o7sm_XJTkDHtKg>
    <xmx:v8cCaAKJob9KIotlrbEEXNyApDEHIqY_GxUma0s-2OWHAQ5qi95Ltg>
    <xmx:v8cCaGCzVDWPT9h-kUYDM3rdJasznd6S4GCSdQX5zVfbWl9P-ZZWXQ>
    <xmx:wMcCaN54c7LHH1j1V7_KN-Fozs0v9VGEJwLdRZH-FH3PPhHjORr2I0GZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 17:44:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Anthony Wang <anthonywang513@gmail.com>,  git@vger.kernel.org
Subject: Re: aw/t9811-modernize, was Re: What's cooking in git.git (Apr
 2025, #04; Tue, 15)
In-Reply-To: <xmqqtt6l9mlj.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	18 Apr 2025 14:38:32 -0700")
References: <xmqqbjsxkn6x.fsf@gitster.g>
	<20250418213531.GA89733@coredump.intra.peff.net>
	<xmqqtt6l9mlj.fsf@gitster.g>
Date: Fri, 18 Apr 2025 14:44:30 -0700
Message-ID: <xmqqmscd9mbl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> So I don't know if git-p4 got smarter, or what. But we should probably
>> back out at least that part of the commit until we figure out what's
>> going on (where "we" is somebody who cares a lot more about p4 than I
>> do).
>
> Yes, and there was another breakage in that 2-hunk patch in the
> other hunk I sent out a fix for a few minutes ago.

We seem to have quite a many ubuntu/linux test jobs, none of which
failed due to the obvious syntax error in t9811, which probalby
means we are not running p4 tests at all on any of our Linux jobs.

