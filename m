Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC6170826
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927034; cv=none; b=lo9xtDK0NGZxcSMSPvNVOFPu0duSDxW2psYACs8wXvuHuBGnMwUI0iXQKp0JmGDNgC+PDl8oOWkfYFAjPqG8IjbgB6p8q+jKm0cMxRHnt+A1ZNUx4rzYthnJVrLivnsnOYlxSv1ePf1mWUMpoOOcBU3PTB/MxAF0A/idkvskQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927034; c=relaxed/simple;
	bh=hQaayyqRcRLpSdBiv4T06tRk3JQjOI1+f9ubDOzktjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WmDiCAuIQ3QCYE0xU572d30V6pFHfDLXrF6ZeGeWT24sihWWcxD2EYpc4Htm7pXyZozhM7sNk3sp8u8l84vHFwr2rkoTvw6RQHCWSiAr1wwLSugUCrUgU0aVc0BD5FbfwpV9ZX50fb+BTMCd37Wz2E22HlMXjfO+M5NlW7A77+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CPmMwBNH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0lBNWEE; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CPmMwBNH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0lBNWEE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F34A1D001B0;
	Fri, 31 Oct 2025 12:10:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 12:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761927031; x=1762013431; bh=LPZsrlpGKP
	MGG4/DnQydbHAL3uaxqUpRriX8XZfenPs=; b=CPmMwBNHWphWSSx1VnACpsq4Pf
	r6aIrXaRCeRc7+raLDXPtxvR8HuCnWqwvCeiTDUiIR03GR6egI8Er/78d5ZpezAf
	O/z6/k3mZkE5RO/cuxYbSwnh0dV7hnFkqDO/BXuXWrTAGcfQ1O0PyQhN8tWT1P0N
	Lj/E+MbSLmBsFCF0MXRehmP0jloHtwB1ZWjCXIGDhtxFPGXffnssrwepsLM9SRbB
	geDtnsmH3HFW6O7J97Bu4H2lms67dmnmIlmOEalHcV3pC9duRY76aS9wxwAXKrkO
	479IagyM3dXy5JwYSKV3/MzJv2t36XFlD7VPD7NylHDF4eeMUETQ7vShwtpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761927031; x=1762013431; bh=LPZsrlpGKPMGG4/DnQydbHAL3uaxqUpRriX
	8XZfenPs=; b=h0lBNWEEk2T4QYVRysITlMh2YTvynK6PDFSn+uqQaOR3cEEzr9f
	KpSzsJHg6X66h8TQSOKoBnYNps4PHUhTKtwoc1ED1eQT2XNw0XKvlRklwZQLHoEU
	ukdUM4U7OMJnUB15Bmno/n6fsF3U/lkYgGCf+3T+FpQHgjVuruUQcFqbknuqnpk3
	2merw+dKF2wX3oApVHNGS0gZpJX5FtTJvuZZrgl691QO9lSFzsKdn6CunoOdU573
	ZJOeK1SPhEPi/zV6AiKuceLvq9t4dtz+0WY4Vp46gxTtuleqC3VpPVbtiGPt8XpM
	zTgy2Kb8Uri3TWvCAe3/9PXLkXh/Xo7rKNw==
X-ME-Sender: <xms:dt8EabBoICun36RbISRNWryLYpChdn1yQ7TG3awlFu3oVggnS0Otyw>
    <xme:dt8EaYhzSQC_DQuK0HNFzuHPZp8Rx8QxJVSiSbD2FSf3tcOyv_PvvU7joDaSBGRaF
    sRzb6ENJ3iaZeuQWY2JUPdq9wIKUUt1ps_5AMCte8wcYIzIDznVbg>
X-ME-Received: <xmr:dt8EabluXPwiHl6Qe6bA2PTRqjiglZ0GR461Dt6JiNxO-Z9DSSgtk_CPBXS_BYGk-DxZKmRJIwcnx6zGIQblNWYwHvp0u6d7qMM6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieelleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dt8Eacpogdg_7GAs4TIwxjym7_rAWHga7gyXzJOyutNs7MLIJ-39cQ>
    <xmx:dt8EacFPuObZ33hdMnGt924boiuE3mPoGtrC9BjnBJMgsBYTHE-ChQ>
    <xmx:dt8EaQypowYuG2VfnIOM3ZXopYBELRdvNsoKkGVWz4G1UqrcJZLTcA>
    <xmx:dt8EaZrViqTqwHWsAdyF5b78eeE1xHL24cyHeXDvFdxERYsQdYhS0w>
    <xmx:d98EaTHW_kjujlsGPrXcx9ClZxH-JGtnEZMYWh7owJsf3DgHwmuzrDsA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 12:10:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 05/13] object-file: introduce `struct odb_loose_source`
In-Reply-To: <aQNMwve9sUP-QDN6@pks.im> (Patrick Steinhardt's message of "Thu,
	30 Oct 2025 12:32:18 +0100")
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
	<20251024-b4-pks-odb-loose-backend-v1-5-1a4202273c38@pks.im>
	<CAOLa=ZQdit7N0aQWyqYHAoO6nuXaU3QqZbQmsbp52jW8C-zbzA@mail.gmail.com>
	<aQNMwve9sUP-QDN6@pks.im>
Date: Fri, 31 Oct 2025 09:10:29 -0700
Message-ID: <xmqq346z2gsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I wonder if the naming should instead be `struct obd_source_loose` that
>> way other backends (if added) would be something like:
>> 
>>     struct obd_source_loose
>>     struct obd_source_postgres
>>     struct obd_source_mongo
>> 
>> This is easier to read and also for autocompletion it leads nicely into
>> the 'obd_source_...' namespace.
>
> Hm, I see your point. I think that "loose source" flows a bit more
> natural, but I agree that the above is more accessible in code.
>
> Before I change this: does anybody else have an opinion here?

I have a slight preference for what Karthik suggested.  To me,
"There are three variants of odb-source, which are odb-source-A,
odb-source-B and odb-source-C" flows more naturally than
"odb-A-source, odb-B-source, ..."

