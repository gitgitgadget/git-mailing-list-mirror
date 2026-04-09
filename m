Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8D3932CB
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773911; cv=none; b=fDIe0jy33oYSMUUNkK1CrwaC6Nyv0l0T+s/pa0gioUU8NRPlRRmzNvadTLEltGYoiNKLzndzheOoXNPWx3zHKeSbjWemCXXi03EycTceSACKjzl9XMYOlJOvMIhkTOiFautHNa0qOPAOk4hH0Yl/KObn0uxP/5AnEJikqfgOXyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773911; c=relaxed/simple;
	bh=QBOCD0m3+8JWnQ0o0qQr3wYBJu2d37DzYxDHAB42tgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=blMFSGRU0vh04mM5uO+F7yAUq/jWmr8vNKqQ6AmvC4LVD01GLYle2Eu3Y1ll66SvZURlcYgTs6/HpBRYG13uONkSM8Ta9lb4/vxhscJozs+6lO0m9Pndm9DNdkRRmLnVOuzNtpOaZ+/fbfR1d0yeErlapPg0kbODN5qMX2DL24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HatmZjri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LsKc1qdW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HatmZjri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LsKc1qdW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 86D0D1D001A8;
	Thu,  9 Apr 2026 18:31:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 18:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775773908; x=1775860308; bh=THy6CJQREX
	+WPVgxTvLmmbg7uqlbAokraO3wjVrSElg=; b=HatmZjrinZvhKg9Hk/bUv9hnsd
	C7tZnQ7YTqq0ys25hES5gzpaRaCRRkLgdfSjqm0XIH/aX2K1SLVKWHgab1x6IIS+
	xCoBezUIg/l7V1GQ/d/KeZgqAxc4Vdd4Jy6Zimo5XT3D2oAYmQiwWVrxiJ+LeQRn
	KJJ1Djdj5XVuaZ1Jdai26Wqin1zDxCNWxtC/6fJa89bRJxHl4Z0Ew9QzsfKym32m
	hKaIMEK80qyovPTIR4Oe3Q7nW84HojWTN5uNOyedumoMLGLfFqSPynJ1+7VdoMym
	4LdyOTQo2SDLRyLxFAXUPGd4tm4leFBPHWv+YHtpYKmbeZd159/9dS24+d/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775773908; x=1775860308; bh=THy6CJQREX+WPVgxTvLmmbg7uqlbAokraO3
	wjVrSElg=; b=LsKc1qdWK+K+S4btlmrSVMEHk7eTgSJcC+dxpCyx34kLdxLyVGO
	YJDPMnJy3xKfZbEhkuMSEsB18MzNb99g2kY3TWOcG/akW4ChgcY7xvJPIGobXVKN
	RivCCYNfCoDMfUcIq3HRYtUslVM0LCvHc5nT3LZAx/QjlZzGtyeImpVfMXgzvl6E
	KQS5jSe9q2zLMuwIxMVYrAyy49JhFhXc3dUF0MqKH3arNHz+tby6gWHN/JyPBwL0
	zLB4N6lvUBXEXXkxNLsz2wZJs9QBckuIPohmt35xk76j5Taxctgg9jcyd47m1T43
	NJc0YI5mvmIIri1xicc0ePeTeVNja6dwGpA==
X-ME-Sender: <xms:1CjYaXfUZPCZ00B0YeifjfxvOFHPlOE3PHpi3qsWDHkg-oLIbNfhsQ>
    <xme:1CjYaUFHshzQzSQWUnTuEcn1GHdn_nmQ572jW0NsG3eoVfk4k2ok1cW8l-PX0wzsm
    lEb8Kp9BwUEq550hp-kdjgey_8dD4oWShT80is8NdcoW08rHo-O7g>
X-ME-Received: <xmr:1CjYaY1P6xR-5n7BJ4Go-P95nWgPtc2M5SY0HzU8Ybtb_deJijdGbpY4_oOB8jAHeCSmgEtnUbjRJSclE_qulrf4NsUlj3TCUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprh
    hssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1CjYaUm3RnM4-Ab_yK-1tzFP3QG9w2tMpZyrTtwvPJAQN1hoxYcn1g>
    <xmx:1CjYaQ9dKRhPxf0MSCYtzNla5PrDOYmTEOr4HA1ZTbVnsNVT6O-FFg>
    <xmx:1CjYaRpzCEMBAhnOi7Sr-dJH4wTTK40-aNvYPvlveFK-g3cnw8O9tA>
    <xmx:1CjYaRmmMyCpePdaEUtkBbMaDP83GClNnYbFWnCk6sB2A9q8h036iA>
    <xmx:1CjYaQ3kwYK5Qmd83sJryqKwDmaCx_pg8Q46LVjtQgNZ8I4FJTxkBQuO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 18:31:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: Re* 2.54.0-rc1 NO_WRITEV=Nope  does not work
In-Reply-To: <20260409222131.GA3130242@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Apr 2026 18:21:31 -0400")
References: <028901dcc859$d2419470$76c4bd50$@nexbridge.com>
	<20260409211049.GA3119065@coredump.intra.peff.net>
	<xmqqmrzbreav.fsf_-_@gitster.g>
	<20260409222131.GA3130242@coredump.intra.peff.net>
Date: Thu, 09 Apr 2026 15:31:46 -0700
Message-ID: <xmqqik9zrcj1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Apr 09, 2026 at 02:53:28PM -0700, Junio C Hamano wrote:
>
>> > Yuck. I think for 2.54 we either have to truly implement MAX_IO_SIZE
>> > support, or we have to revert the use of writev() in send_sideband()
>> > until we do.
>> 
>> Sigh again.
>
> Yeah, I feel the same way. :(
>
> I would be happy if somebody could prove me wrong, though.
>
>> $ git log -Swritev --oneline 8023abc632^..
>> 89152af176 cmake: use writev(3p) wrapper as needed
>> 26986f4cba sideband: use writev(3p) to send pktlines
>> 1970fcef93 wrapper: introduce writev(3p) wrappers
>> 3b9b2c2a29 compat/posix: introduce writev(3p) wrapper
>> 
>> Reverting them gave us the following patch relative to the tip of
>> 'master'.
>
> If we are planning to improve the topic post-release (and I think that
> is a good idea), then we can do a much smaller revert. If we just revert
> 26986f4cba (sideband: use writev(3p) to send pktlines, 2026-03-13), then
> nobody calls writev (neither the real one nor our fallback). The
> wrappers are dead code until we bring it back, but it may make things
> easier for fixing post-2.54.
>
> -Peff

Yes and no.  While excising know callers is certainly safer in the
code space, I do not want to hear about some compilers complaining
about dead code, etc.

I am preparing another set of integration to be pushed out, queueing
the reverts in 'seen'.

