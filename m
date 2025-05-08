Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CA266B6C
	for <git@vger.kernel.org>; Thu,  8 May 2025 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714395; cv=none; b=DDMVVYJNGVE5p1VeHyO/Xe0+i6MFOgxsSkbAN51y9Ffht0Nysg6TjCXg4ZSZKk9AvAoHySk09apspIL26xyiKzR3SatML5V4xYuqn/FwT9rsUEZI2snJqz4aeGKI7yo+3s83flCWyAbmdpuKzKp0DVz9I+ial1o5RmIJDHwam2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714395; c=relaxed/simple;
	bh=IxOGPjvFkiaNujaHmsGxxXSmVdzSyddcDRnai7MG+VI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xqob7QrPPWGOQ2Uv2JftLGcgQ0KFu2j5FyH6m5gaelDns7qrP0y0e3fAXJb9uSEImkzjTiJ20z/tLkuppTJtT1SiPU4Iu2r7QNdwj77HKEKEck9sjoYesxE3/wnKxeCnC4skbzdX4xdVJPDSEAexmj8cECnq+rWItZtDqC03Foo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EamGyxJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=liHSan5R; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EamGyxJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liHSan5R"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B884114010F;
	Thu,  8 May 2025 10:26:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 08 May 2025 10:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746714390; x=1746800790; bh=BcYhDxdPqk
	4IA1U/kvj7aSgQckPwNrAnA4Jbu84Er0U=; b=EamGyxJXA3vAzaZgww//QJC2Jm
	noXJHKXlpKF6YbLYfIoHDwe4U65J5KHNEYWTdVAfxj+QIqDUQ+qv7CRg2EohAL2V
	WZe+QbXsPrsubi5ncdoce284wCBluxNM0gjVUwWVBnV0ylgL/Ykyalh/GPW/6+x9
	KZZ6M2XDgUtPB0iDr6TAkd419EQYPH7wBOk1rjNwXU7gZOejlThCB5j42EGkKU+I
	c0sGNb7d3afWIhFDgzittYNYUan7baOpupTZZIlRNIKStImBUFMRPeoLJ3I6FBN1
	zAyh8m/NzbDGNyajnkNDuMgifaQ26dLZokyCtuJRCh+OSOe+wdXy70AP7zhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746714390; x=1746800790; bh=BcYhDxdPqk4IA1U/kvj7aSgQckPwNrAnA4J
	bu84Er0U=; b=liHSan5RgH15GeHovMutqManO9mSIlCIM28k/3x9VLgeLDrmrvU
	SwDkk5S1svKiWCQSmp0iAr5jhScnslIkp1CP3raFiD/ZCPssbfEqTliOnzwa3/LJ
	oqQM2WCg/cttUKvotR/ElCYaxbd1nwQZeRCLuzaoeCnWzDMb9NbIh1q5q3FVRVdV
	ryFvqVZQabFsHmtMw+VWrqZON4nMR5ubLhXfXFzaD1vHXWEEFJBIUmKgi+Cg2phm
	uxtlHCRxomOdhdTOANl8N4C9bf9KtneG1WZGksTTYtOJY3rpkzA6CEfmd4QrpB12
	FSs7wLaDZH4yvaUTRwh3EMoq735gA+PvHGA==
X-ME-Sender: <xms:Fb8caKziyKb0dzI5NBIkdEv1JHa3JnreQDaKNZ06CpRL-7euw7zq5g>
    <xme:Fb8caGQnteWFxaXSVW98sdPHkYgBAyYNeSj8dfhZq7711lXtnNPrwJSMDeW6Lq4o0
    wenQOdSp_giszCYCw>
X-ME-Received: <xmr:Fb8caMX1FY99mDkJANTCSEf76YGdj71ynCDgKb4iAoP3_Z0mFYvHgGNjjF2O_3QSQF2KRLhiCIdp5lAzVsGyPakk1v9eepVk8ybQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgtnhgrrh
    gtseigihhplhhinhhkrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopegrvh
    grrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:Fb8caAgPqFORFBhluG2WAmxhnyCjhFryHFmk_SVUZTnKTivK9oFFhA>
    <xmx:Fb8caMBas6M3wFuxxCbuKdv4JJA95nEd2T2E596eaNQIrPDSdxJFgA>
    <xmx:Fb8caBLAzIAn5JK_RtPdjysrIUvX-4E6dF0bl-30N-akNuE3etNFnQ>
    <xmx:Fb8caDCF8-qvM4PwFqEuapuSLnSW2J0EdVpxwjYBPnKq6J4jiOLCRg>
    <xmx:Fr8caLBZmCxEfkwac2n6P4K6qwOnTgrV_i7z6OrXwaAcrE5hz4jdRo5H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:26:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
In-Reply-To: <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com> (Marc
	Branchaud's message of "Thu, 8 May 2025 09:26:01 -0400")
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
	<69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
	<87ecx0ijqt.fsf@iotcl.com>
	<323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
	<xmqqjz6sb15u.fsf@gitster.g>
	<7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
Date: Thu, 08 May 2025 07:26:28 -0700
Message-ID: <xmqqldr789gr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Branchaud <marcnarc@xiplink.com> writes:

> This distinction brings up a wrinkle in my proposed DWIMery: should
> 	git blame path/to/file
> show the annotated blamed lines of the file, or simply display the
> last commit that changed the file?

I thought you switch to blame-at-the-file-level only when you are
given a directory (or a tree)?  "git blame path/to/file" has ALWAYS
done "blame these lines that appear in this file", and cannot change.

Of course you can say "git blame path/to/ | grep file"; as you said
yourself,

> 	git log -1 path/to/file

is so obvious, we do not need to introduce yet another way to get to
the same information, I think.

> It also occurs to me that
> 	git blame path/to/directory
> might need a way to toggle recursion.  I suggest recursion be off by
> default.

I do not have strong opinion on this part; I've somehow assumed
while reading your message that you wanted it to always recurse
(like `git ls-files` does) and I thought it made sense, but not
recursing and just showing a single level (like `git ls-tree` does)
with an option to make it recurse is certainly a possibility.

Thanks.
