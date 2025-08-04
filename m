Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938810942
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754334867; cv=none; b=FLcOLnddThqYxlYKi4F4fs2TQz3ZQX5yu40ssQ4y2ZFNeHHI+oFmECKXFblXJf0iyyDn4illcEFJ0x0S09f+Ut52vhqAkXhZXDVJbKMTHLgXgDFJFWZuVCh0dSImdWbwd422UZXLCtm67he7gjXbPPTrQJxWdKxQ6dacppst6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754334867; c=relaxed/simple;
	bh=fmgsqzh74rGbUXZG8GX09Vc6TIzHieVEN8P1hQUJwY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJwEq0RVC/eq5zzv91hNWLn1bzFO4J2sRSROiNJ93M0nAU3v8CQYwyZSJfxsuRr9tdgrnSE+CVjgw6nu+BtP6ILCp+q+oWhNcnKDTwbkOGHVVN/sU+NJiKU/Wyp/5xfAAKuZhiusn3YMyWVQ+tYi0FQm5ArnL7yumPfUgdoMg54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EoIyAHcd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/nKZVYQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EoIyAHcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/nKZVYQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A83501D001A1;
	Mon,  4 Aug 2025 15:14:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 15:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754334864; x=1754421264; bh=v4zxeF/knQ
	TEDpggpg5zhiscN6G0g2VNrIfmn4rpFiA=; b=EoIyAHcdraZKXYpCiwoIbV+y3e
	uIxSlzt8rEVsdZQwM++621J/gPgN4IY9Nm6iOwDph7g7EMrPQq1bfNPrzrPL+NKT
	e/cjyYAGzAnxOjCOOcAMItRK9M9XPi6K5/xBlojbIRQDvdSAQ9TWn2IMhpzINgOI
	tIEB/8x4Srk8ElsWypVTKVITpfsNUoGo4/BgTx9UZx8lcAwnHzY5WUKbsT3KVN0u
	qWfe9pH65r8mXIuyeuuIm2ZXZkcWwTwpocGeX4NELfgpS4uboInKsOSCbcrklDeI
	yYd++2ISWQ/eTBvecJ7kaqUkiyDHgvHeT+OoClkSlBosJODZAswB2L5+Oe5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754334864; x=1754421264; bh=v4zxeF/knQTEDpggpg5zhiscN6G0g2VNrIf
	mn4rpFiA=; b=e/nKZVYQNqly9UNnLmleyOfcZowBLA8dYV6yxk15Vp8OvLVe26j
	YGyON+FEx6SU8rzKEdXnWe/If8aXmdBmpo89JfGZ+dTSmnhvR94gj5uA1NkRQfzm
	mBS9WHRZj68cJga/PnIPraLeTrETwiUVDTu7ZkV1KbvhIlWpFP9moFo9E+Wc4qPV
	OhcQYX5LVXjYhM7zj8EBk7vxyA0zjYVy6X3CzO+ziYodxgnoMYwy1RhP2W0N0KpD
	hSPrlWOGGQHIeyhPPZTcQRV8oVaS2vtpPnCaC05dRZ6RjFZBnh0NK67mkuIerVPr
	YSJHLh/A3e9HXSJHt+be5MbQNdM+A+PRGfg==
X-ME-Sender: <xms:kAaRaJnVMGcCPQa4YiPowLyoRPpEv0Id7Ad6pOCM-P8DTAioG0ozNA>
    <xme:kAaRaPZ1qNTqpxnuguEP7z24emkHkNjoiBrwv0xujQgDvmlnCH5Vrvfp7yHYVZb_2
    pX-gzwI32SuNVhXAg>
X-ME-Received: <xmr:kAaRaMNLndFnBg4P9lQyM9iHCe-MH5MNRr-SkMrn9Ph59dQovRPBiZjNaKPI7uTK056rYr-30IhWfBGr6V7t8AIzWyOlE8k2iv8yLXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:kAaRaMapDzEpGMRlmdKfi6YtgZ9rST3kojctVOG_Mvvwdgy5D0sBgw>
    <xmx:kAaRaC17UXukOUI1jDPVVLqSuFeUXPgIiSvQQL_A2dsQ2ajphWnosg>
    <xmx:kAaRaKfzwtHw9AlDRYhAJWbNk2pRwrTIeqWJKlvyzpT9N7mVaXU-kQ>
    <xmx:kAaRaLGuCgKUIKcLYwA31rurH1U3CXi4sjUtcCDpuQtU4nW8iVbeCw>
    <xmx:kAaRaOcIJyih_3LCUU4dOb8SzvRClLiULvH39EPnNngXFE3iIgaGN7jx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 15:14:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/stack: fix compiler warning due to missing
 braces
In-Reply-To: <aJBNHzE3RQBZZTcU@pks.im> (Patrick Steinhardt's message of "Mon,
	4 Aug 2025 08:03:20 +0200")
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
	<20250801-pks-reftable-fixes-for-libgit2-v1-3-f446e1c33cb9@pks.im>
	<CAPig+cSeYUenjTm54higv6ANCOw0RJsF1hevS_p71=sH3c+E+Q@mail.gmail.com>
	<aJBNHzE3RQBZZTcU@pks.im>
Date: Mon, 04 Aug 2025 12:14:22 -0700
Message-ID: <xmqqwm7i527l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, in general I'm also of the opinion that we shouldn't bother. But
> in libgit2 we have pipelines that use such older compilers, and we don't
> want to drop those for now. So I think we should treat the reftable
> library specially, doubly so as this is the only instance that causes
> problems.

Hmph.  Shouldn't there be some kind of "shim" layer where these
things are defined per project convention and/or toolchain being
used?  So when building for git proper, you'd use {0} just as
everybody else do, but for others your include file supplied by that
project would use something else (like {{0}} in this case)?  That
kind of approach would be a better solution than open coding QSORT()
in the longer term, for example.


