Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7166DDAB
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362843; cv=none; b=hGVFUUR1Qqe8dsJAnQMr4sLX03SlCco12MBxERfbpW8q3nZsEiSJIDAzoViWuq5sptUT0fORTxR+njcipX1v6n2FdEuDV5gaZQ2kRJnrSQcVxij9u5zy0tCWj1wbyg+irkit9RmraLXHkt2hKWElSe0E+IbJPsVJSVZvZlQd46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362843; c=relaxed/simple;
	bh=Nr/kG9hBRAxTzPlOmxdP+DYn02j3AQVqkxvrSyY7ldQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WOyhML3klK2wo32PkiTZukCYD4YMGgp+bw16quljiwd8sTel1A2XJR1sG8ea0OrfyaVT5RaxkyL+HbPJumjLm53ZeVBuhHlJIvOVG788Z4B0ekNh4JtM1h6UF8NqJg1HNiy+w25lmzkr6B0VNzcOhlbRQoS9+ufGdA0SWx508uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NsjI+Zyg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nMpdSbHS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NsjI+Zyg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMpdSbHS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 00BAA1400106;
	Mon, 13 Oct 2025 09:40:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 13 Oct 2025 09:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760362839; x=1760449239; bh=PEYIfFqqoG
	COra/KvK4hTPHkOE/MhjwlK8PmSF0V2zI=; b=NsjI+Zyg48sb+Gm+O981Pm1urX
	RjwQLu30dWPJPuYYmlSVKFp5eT2+upqBlJq42cRRzNOqcenUS94BOopVsVEQGyGo
	8fTd107fcrWB+sloQsXa0+po3Zq9us8QkcC5FTWWE2uxSrClaxjKPS7NPzajbUvA
	9QxJLe4FtjZc/X6+V5jw8oxbt8RHj3Gbx5FEL3y/2BAHbtUDPhDQqnon8RSoUutQ
	o11QwNSBu3vP5bfwy+cyI8o1c2MbepkxrffTg9NbwP/f2LilCJnE3ObNith0trE7
	ihFU3c5JN31sGo6qE0MV7DqC9yWUHuHgmF0THmpoWEt09DhWehQKCv6EKyTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760362839; x=1760449239; bh=PEYIfFqqoGCOra/KvK4hTPHkOE/MhjwlK8P
	mSF0V2zI=; b=nMpdSbHS98fj2vpJDz3C9krFmZDkSHPdZcqNrDOFP1au517cKjJ
	WLAWJvrP3RRMFxQ3tVUV17sqqrrpNtwb+4Wro8k9NrokaNlDkwVCwWo7Ju9ypMho
	zT3mCJ2K0cBdQdPwKvuz714D22VnjI83W7NPvOWelrGDd8oBdoNf40xEbQ3vH3da
	O/nXq1po4txI3lD8QEqr6qebNz/3uBMU5f6LfGicjPrPwBsUqh34HHlF8+X8paWJ
	KthT+xi+ZLqBkuHIWylvKo3SQJmpYIn0kdSnh1q4RAEdJY21+PEE8CQbkmUcIYav
	vPe1koNMxKWEVbXKOUIy4b6IrfYwA84tA9w==
X-ME-Sender: <xms:VwHtaDe-_vMssvuZgxam-CBsJ9PyG4QxelJoxE1EFCj8TAPtD7_R4A>
    <xme:VwHtaAMoPzI6Ur8X1rvoOR2i5_p0cXD_DojjZwoT-srOvfuXMyH6wlOvRpy1NlQle
    aD_1c1lqcA3Nr8zvqCOjTcDs04PXM7NTzqTgBJmb5QL4H1XaYZtpw>
X-ME-Received: <xmr:VwHtaBjJhA2hUDvfPt2-ZfprjtLEwVuCxB8wKS_rX6dwWTM1jdOlk83WOArDSj3j34uw0ijRcSzS2yMuvtf9YBS0qN5rDpo28oTa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VwHtaD09dRlqtENqyVjXiox77YcnhkUu1mumcs4IYs4VrKhl5Cvl1g>
    <xmx:VwHtaLgWbTNhX0OA8kyhhmjFaO2aSsYke0LtC145gpkIMrhgrsBC-g>
    <xmx:VwHtaDdKErgzTtUCpeIWaSN_sh2oeTsUeP29V6GaXJ1GHwDarvY13Q>
    <xmx:VwHtaOkWFnNLBxXnNIyFI3beyReo8LuRcnvdfIRtrU-y-h4gRVe1AA>
    <xmx:VwHtaFA9fQojyMPO3RW4FDeG3TkeTl7GVtgOplnPi0ddPTCOaRH8n8fp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 09:40:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
In-Reply-To: <aOjsjpE1vuFUXXbh@pks.im> (Patrick Steinhardt's message of "Fri,
	10 Oct 2025 13:22:54 +0200")
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
	<20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
	<aOjsjpE1vuFUXXbh@pks.im>
Date: Mon, 13 Oct 2025 06:40:38 -0700
Message-ID: <xmqqwm4y538p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>>  'git pack-refs' [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
>> +                [--required]
>
> Hm, I'm not a huge fan of that name. "--dry-run" might be a better name,
> but on the other hand one might expect that such a command also yields
> information about what happens or that the compaction should be
> successful.

I had the same reaction.   First I thought this would make the
command fail if the requested action cannot be done, as it is
required to fulfill the request, or something, but anything user
asks to do is by default required in a sane world, so it does not
make much sense.

If I understand the motivation behind this correctly, we want a
cheap check similar to what is implicitly used before auto-gc kicks
in (i.e., asking "do we have enough loose objects that makes us
worried" without actually counting all the loose objects but
estimating the number cheaply), but "--dry-run", while being much
better than "--required" to convey the intention, has an extra
connotation that it does a much more thorough job than mere
estimating---doing almost the same thing as the real job but without
leaving any lasting effect on the data---which makes the word
inappropriate, too.

Perhaps "--check-" followed by a word specific to what we are trying
to achieve (e.g., if we are trying to see if auto-compaction is
necessary, "--check-for-auto" "check for auto compaction")?  I
dunno.

