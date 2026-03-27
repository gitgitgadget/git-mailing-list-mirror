Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF55349B12
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635122; cv=none; b=MLYk2L7ZeHx+M3oXZalhgtCn0b/Bt+QKhC/w+P6whL19iXBE2fDdpzSARwAhM89OPkgJkWAjEar78JK/pJC6mqS0NCipM90ysdqMCyQmfL9Fbtys37LMj2LCNgr3vNO2ugKJuTjMv/HbQEcfB/NXVJQWOMeMepVBjdQa3S7Ftok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635122; c=relaxed/simple;
	bh=blvUupJHBFisBNIYPiQUpgzns/wokucbB1A/teNFuV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r06TWy2ETojA+uvAEZdZbImVcOF0ZcEMHwNnpsGCMl9dzFEcsA3vOeHUlJ5hWSISvsxa9/N39nsb+9gPNxqDkM46LCC2kYUSO1IVa0pIcOmPYr6eUhtCRZwwF1m3welcOGRojH+FaSIxVE3SjOtm/Ez2ZHxP9v/Pu/8dwXM+IcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wpg6ow39; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lg4YCxr2; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wpg6ow39";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lg4YCxr2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 894A91D00124;
	Fri, 27 Mar 2026 14:12:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 27 Mar 2026 14:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774635120; x=1774721520; bh=blvUupJHBF
	isBNIYPiQUpgzns/wokucbB1A/teNFuV0=; b=Wpg6ow39DDvo/yuYK2zBtwOPHb
	rTJ3oIIb/Ch+EM7Cbp2rVEA8ST2tqbEdAEeE8TEvKGazVEF2PWyyfgivZObMm0V4
	EWpRRQGjkKamQehOVdVb8Q9xWsIYaVG1ap3aNtK5ZSto6GloLot4N/+lGfCYpK5O
	LYGA2+1+oJ23vDAr+6EZoCMG5vj0xGHB84B8f5+IXxOVENqs2unT623yIzd2r6xr
	E3gSMJ3N17qZ3ej28WWIMmcPohmiDUIyGRODgP8Ft+jcXvL90QoPnPM7dtYI63jg
	pG+jTIdePARzSDG+rmjTB0cfBt6NKynVUofnQsOBzDq0hoLCv1bxW9u/Mj1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774635120; x=1774721520; bh=blvUupJHBFisBNIYPiQUpgzns/wokucbB1A
	/teNFuV0=; b=Lg4YCxr2XyJ8SwHeze0M4sgCF+Dzz3emSbCq6O1MgPw+VdxHvU+
	Yxus5dkAySQdVZi/+Esjym5aj5SqIrvsrCWA6r28JXWpNpZrOrCicfK55eac14qE
	rT2FqigwwfU6m5UY0obwPkC7qrnqowx5K4FY4iWs+iDkHQmxdEjVh25lNlmFEvXR
	zbHkW+3I7JBAGdjwbPWuM8/S3MQZnsUUNDvQtzLe3QjlcESRmmsO8XrCemgZQbVS
	ylPNXHliu6Y7Ftn/BeAZhtAo8DGRpHHfb7PnrxqVDDHEvm7O3Yam+5RMf3jjiSzD
	Rfq5SLi1sSr2yhbmwMpzHyOLGh2ZLBvb3Ow==
X-ME-Sender: <xms:b8jGaUyEc0Aq-p1erlroa53zpMP3tXGnmt8nIfmR8RMGRP7cnqbJRQ>
    <xme:b8jGafRcSnvSBZFprrCgimLZwpOVsr2U2lMo7yIzrm4dG07dv8D4juEMmMc-S0K7R
    0Ziak5AjRc7A0QuyuYM0Ye96nDT50bzsvbU3Su4SJ2mLx0cR_hL>
X-ME-Received: <xmr:b8jGabXZBgXv_vezc5oo2gMTSlT1dOBGOkXTB0BBIqKIUKX1yfMjZlwAdpAuerRaPddzfgBVnaOY7ljD2-gAgnZlTFWdQ74xmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b8jGaRZef80hMUwY0OgEcdD8w5_Kk8AA8VPdiGoEzholAqLXTz_kvw>
    <xmx:b8jGaR0JTGvsgB6JpCF2chdefAPuT384qLaubkJkB42uXkwB3NlcTA>
    <xmx:b8jGaTg94tr3YF4dvuUl2nL6H5OWU3ca5WvyZFU15YQAdTZO-uPIVw>
    <xmx:b8jGaVZ03_wr5f5WtPITfaAguAwoQMpogdC4VhdkUOu07Y7ZIQjsEA>
    <xmx:cMjGaSSsrgy1_8SVkd_Uur-bx2CJIRYvCzzL1MTNM3l13dxEvx5ViOT5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 14:11:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 01/11] test-lib: catch misspelt 'test_expect_successo'
In-Reply-To: <acY3haGPHPLSfalj@pks.im> (Patrick Steinhardt's message of "Fri,
	27 Mar 2026 08:53:41 +0100")
References: <20260325062114.2067946-1-gitster@pobox.com>
	<20260325062114.2067946-2-gitster@pobox.com>
	<20260326040828.GA686242@coredump.intra.peff.net>
	<xmqq8qbesm1r.fsf@gitster.g>
	<20260326172920.GA2447148@coredump.intra.peff.net>
	<acY3haGPHPLSfalj@pks.im>
Date: Fri, 27 Mar 2026 11:11:58 -0700
Message-ID: <xmqqldfdjg5t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Let me know in case you get worn out by this though and then I'm happy
> to take over. I like to have a numb task every now and then where I
> don't have to think much, and this here very much is such a task :)

I've stopped merging mine to 'seen', as I did not mean to carry it
all the way to the end anyway (I do not have time to wait for the
tests to the set of tests I run regularly with cvs, svn, and p4
added), so it's yours if you want it ;-)

Thanks.


