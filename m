Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933733C515
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444912; cv=none; b=A6n1lcZPPwTOTH5mQpHzH1reYox4QOqowVIc4xnCeSUrxzW00ZiXn7jLtlRuHLz8KEt1cwhs26Ynp8kbArDmCGWZ9b7rfYE7K7kOAGe4YjnJ0TKvVOWSxZUEuwigOliN1Wm5M6c8v9qnK9tE2Y9rlIKqits89jBl2V49NIfFO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444912; c=relaxed/simple;
	bh=IxRq6wy0iO2NGzdDHZfh95JamaMEgdsKlFiIS/talnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiTQKIF9FMnBZvPqBSoop98LOUL4uBxVyx1MZMMFmvNPiA1y+UgbJwOEW02kyY/AeYSErgCDfJ9zC7O/KZPRCOGcZRvPhovnvUfbypGrBBDGWsU7mMqOOjVMgsiVWKyWOXMN+UkuBJTjBOhNgWWSRKAAvHjzEE/6O0WPddNoz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jqHJxdTo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QgrZnn+j; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jqHJxdTo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QgrZnn+j"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DEC81D000C0;
	Mon, 26 Jan 2026 11:28:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 11:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769444910; x=1769531310; bh=IxRq6wy0iO
	2NGzdDHZfh95JamaMEgdsKlFiIS/talnw=; b=jqHJxdToqn9QXyCtx0AvrAdHEJ
	TS8fglJHc+cEWIHh8CzdFMa6GWjYEyAyrJg5ObqLOBWSpTChkmQoNGC7hOjzy8Gh
	pMkKdQWYgqtZ8oK6Eb6B+3T0mwBbLOG+BZC/rWJFjDRpnB/xeLIwqi4Jq82iUEeS
	HJ96MF0P1Yh5W07c4ke4n3naTwaoyojBAeRVE5nfgvLuEQuVPOo7d6AnwhQdfwWe
	hVvytRon1sb9plKkSd6RX6elbnUFJrBeoJnsJUeAqqYwS5P2aA/Xcu8bf+eGQ2zu
	rDdpnlZSPx9O9qovksgmwApd7IO5X+Itv40LP6vVNILGPHY3VAGYFXDxaRtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769444910; x=1769531310; bh=IxRq6wy0iO2NGzdDHZfh95JamaMEgdsKlFi
	IS/talnw=; b=QgrZnn+jY1A9/TkWHJK/CijPTdYgtHhqN4y/D1iEPrg5mMFFy0A
	JfMtBr5QNoKQdXDS6MSPHSn36LJ8Rku2t+GxNU+6eNIiS4qmdnCujDWC5ApIuRaH
	Yek0eevNRXK2JFrt4cwwvk9RtDgEeeslz7NW0VB8q/sbd49R9paUthcnVlQL5/oS
	CZxUv2BBjkxrB07dDYNWBbrrD21SC7zngcSnJxkFKY1zwlqFuvwfci71yZzLB+iw
	PNtSCJGpJ85aN1z8u0HeQrtkj84Yy7lug1MSmyzInMm56IPk6gsZHJvO0IX5EVDV
	+7cg0QLOzhSZN95n+Is5+OSPM6E3C4s3/5g==
X-ME-Sender: <xms:LZZ3aeYGkVBGSQTTorbQLxE3GtHeugUi14KDUp49Y5a8GlY5bwuzXA>
    <xme:LZZ3aY2LzBvYo_78yjgsVp6TTCdqWGUYDDyTs26kMMhWRnIiZ_Uat71w0Z1ZZnXSC
    et-4bL_q-XTwHYqNVPNGhc72vsIRjexozgcZnPn_Wx88YQM-6UKWw>
X-ME-Received: <xmr:LZZ3aWUh8rvcoF28w97qu1ysi1c4Qvsc4Y1zelf8SE67zl_NaNz6xqjKn7gxUrH22ROCPExLVSCyA2ROwwNrfXvBFFPDRgo75UMb23s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:LZZ3aaV5_9dZ0pPzct75IEvmNuhlMWbCQiqWwcJlz7KeQP9T6oI76A>
    <xmx:LpZ3adeEjiPKpLyHbx0J-VW73SdTExu8oKAsm0uncENmkf2Q3G1vHw>
    <xmx:LpZ3abU6zSGeuaRC_Gd8sUB-V76ZOpHh7iOpLcSB4pgFnYll00ubKA>
    <xmx:LpZ3aeemz0k-jJErbD7UgGchk6LdZRc9lZZ93VIMFCR0GVNoBhb-Aw>
    <xmx:LpZ3aQ_EvRSu0Dllp_h4UMc5LZFPb-tu-jD8dQdbAc2WkVVvAyzH1Wan>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 11:28:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] Small fixups for `OBJECT_INFO` flags
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Jan 2026 13:17:40 +0100")
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
Date: Mon, 26 Jan 2026 08:28:28 -0800
Message-ID: <xmqqecncjq37.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Surprisingly though I found out that this breaks tests, which of course
> puzzled me. As it turns out though, we were incorrectly using a couple
> of these flags for `odb_has_object()`, and the changed definitions had
> overlap with the existing meaning of other `HAS_OBJECT_*` flags. There
> isn't really any bug here as far as I can see, but this is only really
> by chance.

Great findings.

> In any case, the first two commits fix calls to `odb_has_object()` that
> used invalid flags. The last commit then removes the gaps and converts
> the flags to use an enum instead.

Nice.
