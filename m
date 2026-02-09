Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA272EB5CD
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656734; cv=none; b=EWkFYHg8VJjGkwEYvTAgAMQ/tCcZmnk3rwYFrP2+tjUSmllvnN2xeFclei5iGWVtZBm2EgjZyeK9h0o0nlVHz50m76QLfJq72AzVkhwmsWAX7FW3nU/AFDL6Uoov7zKj88uTTFK65NcZnr077914C+4Nm5ge2gbIlxe9PgeONNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656734; c=relaxed/simple;
	bh=AV/8o+ee7pawwEe2T4IwmsrBqpH7Yo/vomJAEl5R5Uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TjYRrr90DV9S5vSZRHTlUq/fyqRWCkocdGqWwLilCpz04xDs/6tff5SGbUgHhfRhLy6Bu/xHcd0FpElKj8+FA1HrsQJQCTf39AjkX9lFGOt744T75NCu1LMaDZpxNOGTvI7nAyKQ6SCtTaNZSX26ht/bMG/gMPddnDzDEeQaYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g3GHU3g1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jfgtMTE6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g3GHU3g1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jfgtMTE6"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E88517A01BE;
	Mon,  9 Feb 2026 12:05:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 09 Feb 2026 12:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770656732; x=1770743132; bh=AV/8o+ee7p
	awwEe2T4IwmsrBqpH7Yo/vomJAEl5R5Uc=; b=g3GHU3g1KyslleOC3GXMJc8sNN
	1cYXs1FCJbdcRICmibEhr5n46hO315wXmI5Ovo6jprhUVo0yCvuskKZIVY8DYVYZ
	yJUTqFHs/F9iJZQjd43Vq7+SsijK0JpAZ6cF9MjsfhhUlVJV4W3PLfJ+tAJHuudB
	OM1hjTwvPH7WTfHBs1lhm3PkikHDc8uk2os0Ftq9YUFDfm9gW1ipG8uRAX1EjobR
	yRH/ra9c2LMhO1YNZBku+tUU6l5vEfNIK2lpN4FT+IHfEShrIBXTbJn0HCP8lgHl
	jzzCKDuzV7KllAUjs+bNpEYbe99eJwrCe8YjYK1Go/i8XoVu7IRY0CuMuT6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770656732; x=1770743132; bh=AV/8o+ee7pawwEe2T4IwmsrBqpH7Yo/vomJ
	AEl5R5Uc=; b=jfgtMTE6MSx0pPjjiAzclKK3Ck01ONqwxxhLJf/uZ5XEM2ly+E/
	zaYtxchwPAvjtEbgEt/wPoptUxUW/DlsM6nisRzGMrJlmtVdlYwgVLSuaTWxa/Cu
	HKtki13kYqmHZbjEgapDESKWWm5+4k8NrDq3NK3sOPMQPf3PkDvDRjTZdhYRLg4a
	I74ADjxXCVgrBfTm6m4mPsC9LZaKJFqTn288Bk+tDm0LUkL2hCFogjP1IUe3Szw1
	hNcmhkH0MUvO4rs2IWWIg9GlzbUS71d3qTLyx4KzMk+zHJydYqZuQDXR766PJQxc
	cROyef7swwAyWYx0paieTWE4hrWDep1Hr7g==
X-ME-Sender: <xms:3BOKafcc0WR4tPEemcAxJQH_UW3mwDNfL--mMSaKjleoWvfz7VaThA>
    <xme:3BOKaY6ANKq10_byw-Cdlh_FDFG9Wq6kG5i4N_oi7mbw1nzeeTesPXt16acbU1b4R
    rPnQQQKN-IgvIwtoC_CE2dVlWVvNY0nBFx34LyAcuhCgs16bO8ICA>
X-ME-Received: <xmr:3BOKaSWrhZOFQ5vQwY7ZFUNV3AghycYmXgHF7jUloJLSQXwR223LenHO5qNGYsv0XA_ProQ3JGf3gosqceKz6l1A9wCwzHCKSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmjhgthhgvvghthhgrmhes
    ohhuthhlohhokhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:3BOKaX6Mtqf2Ngc_Jo0B5SbknVylOJbA4l3PBXxNcL-9u3mkLwrD5w>
    <xmx:3BOKadrUkJkW79u1eSHaQ-lDYcFzlLAMq-rc6bjEWc6V96BEErbQrQ>
    <xmx:3BOKaambDla2AT_nIf80UIEeHupOK7ZY0L-Nnw1bbGZTUAWLDKXPag>
    <xmx:3BOKaZOT5t_8HO6zSa-Dlw2eDDzChibpWGcOJPQ8DmNvmQ1j_0zOIw>
    <xmx:3BOKaSqD1fDkHUaiWXKZAeOSZAZAtlRKD7jui-UonOCWW_1XnCE0beLX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:05:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  Matthew John Cheetham
 <mjcheetham@outlook.com>
Subject: Re: [PATCH 0/4] trace2: add macOS and Windows process ancestry tracing
In-Reply-To: <56c1a7eb-a645-4453-8024-b320c1ebd55e@gmail.com> (Derrick
	Stolee's message of "Mon, 9 Feb 2026 09:48:23 -0500")
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<56c1a7eb-a645-4453-8024-b320c1ebd55e@gmail.com>
Date: Mon, 09 Feb 2026 09:05:30 -0800
Message-ID: <xmqqo6lx6e5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> Furthermore, let's refactor the Windows implementation to align with the
>> Linux and macOS versions - by emitting the ancestry information as a
>> cmd_ancestry event. We keep the older, custom data_json event type on
>> Windows for compatibility for consumers of the TRACE2 data that use the
>> older event.
>
> I appreciate this compatibility approach. I mention in my patch-by-patch
> review that we should eventually drop the old mechanism, say in two major
> versions.
>
> The code looks good to me, just a question about the testing and some very
> minor nitpicks around recursion and strvecs.

Thanks for a prompt review (and thanks for the series author for
writing the patches, of course).

Will mark as "expecting a hopefully minor and final reroll".
