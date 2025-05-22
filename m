Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D861DA3D
	for <git@vger.kernel.org>; Thu, 22 May 2025 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747878736; cv=none; b=fIHWP2Jy9Vya1RXAKWSiLsGTWZHZgDbkOqSRbMUrow6Ch3cyA1bJkiTCEK2BBKl7Aqgx01I13pss3YA1BkF80dMGmnRu/XegkKSxd7m0SygN0lVMb0RF1QsZOlhJdNZ7Uq2QTHzWiBjcniOwDg3D6yzrDyeH4B3DE5GRiT9AYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747878736; c=relaxed/simple;
	bh=tSmnGXYWJbTKAn94iuq90UXVwPIUczwDP6l5VzwlUNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVXlycNw2l6WTki7PvvFiajcWyCjF3EXghSdHI+2d037x3GgSPwZDS7zSYsJt5TEetZAeV6B3pwnxRUTN9tQgSeEB+GQAdj7G9PdshyhoYd+mnLolFwJS4c0dVuI8TgZYrOqCsPePRLnzMWkwyWj1DUHQoibdGn6HxQsvA3/9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NHVV5DtP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JykfcZfH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NHVV5DtP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JykfcZfH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B75D1380468;
	Wed, 21 May 2025 21:52:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 21 May 2025 21:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747878732; x=1747965132; bh=M4hdDMBeFr
	3Gi3+9T/7kABCx5lWUXCpEYHFvRDDS8N8=; b=NHVV5DtP/oL+bxL4Slau8v0Pxz
	4N//f0S6eQAMASgRdRPlPgNyJj1xsWtrxlYU7SbokGpaoIGig9b8V8gDUcJGghss
	srjZ7Ha69EcmGOHLB+AXiM3BJsoSvQ+7HHhV9MZvqCr/tHnmRf6hUD1eFTXCGw7z
	CyEUx0Or3P5Xy34JiX+frWHqvJUcwoAUoulJbtb88u8gg1jRGmTw/f9vrha3cI9j
	9gHMb/T9cANawzzUistfIxO7odbZlg+P4X/WQnG4Tdp5IYLP4PVibiC16ZFt+5NB
	h0be6lfoLokFACNV5KKIj6RUTRElyvyUnkWcewm3QZ45rb+HQElDCRQugszQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747878732; x=1747965132; bh=M4hdDMBeFr3Gi3+9T/7kABCx5lWUXCpEYHF
	vRDDS8N8=; b=JykfcZfH2oWPOvgOmA/atQcOPGL+udC9clAjN7r2Qol5NK41Vj0
	MAjn2K7X576A876cJHrv4w/R/xevQ0YSbDhYttMuypL8WZB9z7qz5DYmbm8yuw3L
	sGN3MF3nkOba9dwcDDB1Fs/6h7uYGDZ1HDd6zRD0d7WAieZgCJuMIc/4OUm3s8Ut
	NwzH0XrLQP0kaBlWEtxnWxWoPCo7kp+/h05rLT9b1SWHCyuIPp5yy9q3xLiH8Zjv
	xjfCtkSObSYIQhs56CiToWGRMPNVgha1CNoDwKXzOr9h7Qic+/OpK9Z0r2J6DkLc
	RRjifKSzIOlMXLp/cjZDVjqUe2WjHu1UX3w==
X-ME-Sender: <xms:S4MuaPTJUzCxtJQPSHfsBbE-xnrk9L8p6lteYNpAK5SbApoJCGDRMA>
    <xme:S4MuaAxRBOgVgvqxhA6u4Sl6g5-WO2cbc0v400VjnehKfTHL-VsSULCL8kezwy_by
    OEThF1frFOCQPHSpA>
X-ME-Received: <xmr:S4MuaE2iF8HnLUsagvNjtp02kt6BIOpe9Biv1apLaK5yRk-HmC7lH5n2I2-NzsE-4VABkQaUvAz_V0csr6rUlwXMFngTWMyZNyPsHQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegieekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeu
    ieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkees
    lhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:S4MuaPC0wBwid3TSdukT-7ntsqTd7s1O_pT3EwOzw22WByTtUsM0EQ>
    <xmx:S4MuaIhuIIpWb7I12yHE4U80NPSo76Q2qFHKNbcwJ3zKfRDt0-85MA>
    <xmx:S4MuaDrcY0mqiNSQyou0JtjdU8Qejl-pELtj4fTcmtqjcAyGdW2Wfw>
    <xmx:S4MuaDhydrvhg-PPy-d3RLy9hSamEmVpxXZmW-Y7RtsanA0JWvB8og>
    <xmx:TIMuaFSEgmxgFLJyZRra3X315NtgpadSPDEVsU3X9BmmquY8KKtbrqOy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 21:52:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Add git imap-get-recipients command
In-Reply-To: <xmqqikltaghp.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 May 2025 12:52:34 -0700")
References: <PN3PR01MB9597D5EBF0A8D91737E4FE52B89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqikltaghp.fsf@gitster.g>
Date: Wed, 21 May 2025 18:52:10 -0700
Message-ID: <xmqqfrgx76ph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Again, the description of the "tool" in the first paragraph was so
> sketchy that I cannot tell where you are gathering the To/Cc
> addresses from or if the tool is using only the named message, or
> considers messages sent as response to that named message, so it is
> impossible to give a meaningful response.  We cannot tell if the
> tool will be useful with given information.

I almost forgot to mention a few more things:

 - Perl dependency is something we seem to be avoiding these days.

 - Adding new things to contrib/ is also something we seem to be
   avoiding.

 - If it is only to help people to contribute to this project, I am
   not sure where in the hierarchy in my tree the tool should go.
   If it is to help people to contribute to any Git managed project,
   then it can be thrown into the same category as git-send-email,
   though.

 - Doesn't contributor side of b4 [*] do more or less what you want?
   If you find it lacking, it still may be a better idea to extend
   it instead of starting from scratch.


[Reference]

 * https://b4.docs.kernel.org/en/latest/contributor/overview.html

   Admittedly I do not use the contributor side of the tool,
   although I often use it for maintainer's tasks.  b4 knows the
   threading, what set of messages in the thread represents the
   latest iteration, etc., so it should already know enough to find
   out things like "who reviewed the previous round" that would help
   solving your "whom should I Cc this new iteration of patches?"
   problem.
