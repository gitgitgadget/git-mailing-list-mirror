Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748A2E36E1
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754354068; cv=none; b=Zn83LRjlPfh0a6BdY5M3c5Na7FgbQfcCqOQOX+BKy6gWXSDeqSRplby7bTrmi4/D3CoTne7lUyEP4ZTz1+T2twxIgbmX8cTx4gidqNTQq6Ggeo5g5MjgdNuyt3YN+pM0PZojS4eCvpao7v28v1Gw17esgIvlTUJG1fr3M7RPjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754354068; c=relaxed/simple;
	bh=JnD96uR7phOCbjaZJhGcwJWBET49ABhr2K+WRw+T2sc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nTF0YvuxSqbA55lLQogkY7Htuz4KqdQxiVxvQdyOimGW1aLXurs+bAz7Fu9vCd26UYRqOHfBDYMVrRIZIK4m9l8OdDwl9Yx975aSXkvEgHp8eW35i+JDxX9ArFAchPCOZD0HwVdgC8T2qnmyYv9GzIsJ2X9umTHMtMZncxbvMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q6SVsb79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNjwYoT1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q6SVsb79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNjwYoT1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D28361D000A8;
	Mon,  4 Aug 2025 20:34:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 04 Aug 2025 20:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754354064; x=1754440464; bh=JnD96uR7ph
	OCbjaZJhGcwJWBET49ABhr2K+WRw+T2sc=; b=Q6SVsb79PiWLzOyQ/WyEa6Orqd
	a3DPDj2b7T4prtQ+ceiC3cIuNmBjGdBS+6hbUUBpIhlxTKUproe7WWl8gwHZyKEB
	vbOcOFB3ZGCDXTM5nyPH635o21+VdOYbkbbSnwlaeHt1+/PNzr6h+cQ6MMCSwOYF
	EUwohjMNeTNA48khgR2BQNZwDzeCF5U+7kseO4P42j2lS5Sv0bepCkGGLRvrh43V
	NftgiWCNJjtKaQ1G7VwShoipk4roTqH+jGaax2JICgzebWpkKfbpZTEde4QuV5vg
	bwyTIh0zr5Uq1Jcc531jK1YWiiax+8fxbT0CcPISwDUOTDMXYVYrDFC4dYUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754354064; x=1754440464; bh=JnD96uR7phOCbjaZJhGcwJWBET49ABhr2K+
	WRw+T2sc=; b=lNjwYoT1Vis0WarzAYLvVFBQLxIjrtVe1LyPqLVVAw2GMfTVZYd
	hba8ANorRjTmVicebeL4V31QSlG3sBoSO2LvpuU3S3ACIfaVdO4mUJ7nbnOOH2Jo
	2QLW1jHdrT2DxcAdowl24acFdw+AgMxdHOngG9QjZD8NUPhdADVX7oUo8UPmlxcF
	yS7BXZiAA6Lpa9agPOY+A1iGVYrWuev0UQ+VB2JtwEH2wRzgzqVRvYbDQBb8+her
	q1plexHetwWtFZbe0mEjFxaVXAFsEQc15cVGvXyw2Y7JwmWPjJn2IV+Jrt19CT3f
	aX3WLwfKjOuGPMin1bWsP3O8a+84ugulOFA==
X-ME-Sender: <xms:kFGRaNfVb4uxIURxHQbKSXgisH5-v4RKUDnvSYxnkuJdHx2wY378dg>
    <xme:kFGRaFxE29pWvPkIpaIV19z3UiQttg8i4oqbwLsHL5JeCMwuNLfbERpG6sG3cR4L3
    Qw-RJyCeHnSOcnytA>
X-ME-Received: <xmr:kFGRaDHRttT9Qgodae1LKNw5hcyXpgvYLrvRJjILMGsd3dk8IrwFFObaHhQqXaX8uZByvszIoGr9UCBtut7pNZTYAU7R0sAx4NW6sJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kFGRaJxNNtb2E6WI5HMmPV4OYoYNdzPuA0SUrvIq7J1eDrkX3OKgIQ>
    <xmx:kFGRaEuBPyGvsWOib8Lvla66M4dIOqQOGRJRpchaglgDJ7gnV2dE2w>
    <xmx:kFGRaG2CQvnY8L1_u2lfi_2ZpjQfi8V38das_IEhZDq0Jv8blbhDyA>
    <xmx:kFGRaP9cKMCGcw_Teb2UfOGYUMBfG9wCIEj21-6Q-aJaiqjqlxNRmQ>
    <xmx:kFGRaPqoht8iZfuquQlpylLlCQgaFDMP23aZrH9-YY5VbQ7NVE0DS_fd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 20:34:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
In-Reply-To: <20250804154129.GC109984@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 4 Aug 2025 11:41:29 -0400")
References: <xmqqms8fbilv.fsf@gitster.g> <aJCBlnHp-db4Nd5w@pks.im>
	<xmqqqzxr88jg.fsf@gitster.g> <aJDI16RBR9QKdtW9@pks.im>
	<20250804154129.GC109984@coredump.intra.peff.net>
Date: Mon, 04 Aug 2025 17:34:22 -0700
Message-ID: <xmqqectq4ne9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I just left a rather lengthy review of the split-HEAD patch in v4. I
> think hit has a few bugs that we need to address.
>
> I'm not sure if the right answer is to just go back to the v3 version
> that simply rejected the racy HEAD update (since that's more or less
> what happens now and nobody complains).
>
> If we do want to stick with the "silently skip the racy HEAD update"
> strategy from v4, I left some fixes there. But I'd worry more about
> maintainability and regressions in the future. I'm not sure if my hacky
> "pretend the HEAD is this for splitting" patch is something we'd want to
> carry or not. But if so, I think we could at least get a little coverage
> in the test suite.

Between the "honestry admit we failed and reject" and "silently
pretend nothing bad happened", I'd have to say that the former may
be more preferrable, and I hope people would agree.
