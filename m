Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFE23D7D2
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125621; cv=none; b=XAUe+MqlgXfIr5Y3b1SoKvNyxWSGNLUFfwR4MTAmc0iNUDoKpXH0kGtCE/CCnvPz1/JyySXqfIZCar+ZlzmQVvckKpuksUNwv+W+Rtfo0ZjQJ0DKpHFdgTSilkzNDpaig1j6PrROdiWjJV2IiaiQduAD+suPL2Fm3m+3CTECBpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125621; c=relaxed/simple;
	bh=U04KFcpusYB76nqDOvePQHthCWXXfb5JsvaI64a2AjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bElHPVyO5krlyKmUohp7w+wmgQJGi0G1N0uFi5o+1u1WKzmMwhhsMIiwIuJh2oxcjMufRAIwmV/aQQTrtaReGtKDNg2ZUEAhoDCAAsG0v2ZT9B9R/6JG3NHX/6O5Bzkk1wb7BRDEBKn5fhVK0lrQWV50UsGhwOBs3vnW9ct1Sv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ejgHLIWO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0tUmN17; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ejgHLIWO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0tUmN17"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 990DC7A01A7;
	Fri, 10 Oct 2025 15:46:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 10 Oct 2025 15:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760125618; x=1760212018; bh=OLe8Mioqyq
	QrSib+NdZAZ33hU7mTy+oYKBZYUsoPt8Y=; b=ejgHLIWOgQdsf6oxiV3SqOIHXv
	ZwRv579eMeaeYB0ZVtoIer4ao9eN11eyfglzSS7wOOghPiaDeDebVnQQYo7QimXc
	iOD5EqoCjiPSCDZgRW52RB+N/9iERSQSGotmZgYRuFbcXzv5Q8TDr+8E8IHAYpfj
	Ck3jtD9q0zOBLi2wsEqXvrTNGyjLVhOKDmKqKVMGr7lZyLz+uBK9ez5rcP6NhYfD
	PvjrAlQ0DI0M+lqRdTBJ1xsLwj2vK+cLOYO5f89XFqXn61lkkd1zgygnoyJUgEKT
	K/o3Dh/zNGIYFhWRHtg/6K2ZmU13yf40/5EqrPVvsrQomvkdWCvWLtIFNnMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760125618; x=1760212018; bh=OLe8MioqyqQrSib+NdZAZ33hU7mTy+oYKBZ
	YUsoPt8Y=; b=W0tUmN17wyfiK/45UTMwXaui2LAARX1PWaCJ32iw3Qqfiqyj9rn
	n2/29CxRlOtE0w3BpF3H1QYcn7xn5Bu4OxGfbqeaX5Hm7VoLsBF5by+04brp/H48
	VmbNniUssU4FopyMoAq28DeHEtf/EY3E5KZjwlngOnM0uAgeHhWY6K/qdzG0PyUf
	StAecv2wWHmoA5cLyhNOwIMIgtgMA0B/BtDhVqkkmrj3aSrBLgmRQUXMZYSuti6S
	PZLQfvnClP1i5GJRXawCEWl1luJW/hZtINDGKiJPy3x2SwzmZe5W1cm2c7NFbMjr
	FKxjP/KuI0KKNOmj+CcvXOPkHeBA2Omw9ZQ==
X-ME-Sender: <xms:smLpaPDTSCLupdIep5UP-FoiyS92qgGx2XaDihOrWA2daoKZBF7zJA>
    <xme:smLpaMid2usPyvU7wPXwy_Wjd0cOl2hi0vTzwG0286BydR9j3r2ZzBXs37SFXVhNi
    L_Omi02dOX2Q6czuWPRg2IX-R0yccARGBMxEduegey_LSKAuv2U>
X-ME-Received: <xmr:smLpaPnrICgQsddmd-Lfu7JnOqPxydRzZeTwqdUJRQYE7AQnIrDg2hamgAgPVP2TuE0CIsUkwop11RY5gjKHNAC53NtznZmSLHe1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhlihhpseguvggtvghnthhsohhfthifrgdrrh
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:smLpaAo9svrKtgq0uwoqPTYafGmBgpbm2taJ-cl5BGqsFnWYMQ88sQ>
    <xmx:smLpaAEvNH8NEO2H7nB29yeMB-7mKxxocAwCyEkeiEcOR1yBWbQ5jg>
    <xmx:smLpaEw39YxSWTuQj0dy29HQGUeW_L03JH2Z-yfBSh9MwQqdpVX7LQ>
    <xmx:smLpaNrmEb4C6w1Ou6HBPJC-bUbTJgWtDRPMccBjBW2QZLQ37VaqkQ>
    <xmx:smLpaHy4CFD-p6C4F9dc7BpUnhvSMnm-o7hRgyGZgEeUIKz0UWt_lULs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 15:46:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philip Patsch <philip@decentsoftwa.re>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 1/1] docs/git-blame: describe sourceline and resultline
In-Reply-To: <xmqqldli8vr5.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	10 Oct 2025 11:19:42 -0700")
References: <20251010152204.815520-1-philip@decentsoftwa.re>
	<20251010152204.815520-2-philip@decentsoftwa.re>
	<xmqqldli8vr5.fsf@gitster.g>
Date: Fri, 10 Oct 2025 12:46:56 -0700
Message-ID: <xmqq7bx28rpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps this is easier to understand?
>
>  - 40-byte SHA-1 of the commit the line is attributed to;
>
>  - the line number in the file in the above blamed commit, where the
>    line came from;
>
>  - the line number in the file, where the line is found in the
>    stating <rev>;

Sorry; "starting <rev>" was what I meant.
