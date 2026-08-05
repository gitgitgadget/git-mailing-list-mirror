Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0E358D37
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955217; cv=none; b=emOGWKEJTfCKYZAAS7NQ45NCA/9TO1/MKXcSHteZ1+Qx0yM5uPS2UurPddRYBucWJeKkxafneoa+C+5INLfVnAY8xKuxJ8yq2meDpnKjUzwkk51UJQSPaEsyEt+AAcMeKS4AJPsvfsQNfdMRCYoCVXsonM08XxftRHKSC37PvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955217; c=relaxed/simple;
	bh=QoG03z0kai5wR+4aFWtluBNhe94AngVFtRfjnU5MmfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVKcfOKLxkhOIvAWke1cRGzMJ2EkFmEEe/TGtkyFaT3MkSlwN/Bl8gFoVVdQQJ1Ibjpn9qVDGlAc7cLu4Yt8TCh4Kkr/Vm4H1DwHe8Vi3yHbH8SeROxjEqOwwho+NDleIpK6u8+sNXeP1caIWqOcI4JbTMZSnJ5G5hSsvAu/rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=myu1YFog; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dpnLw7T6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="myu1YFog";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dpnLw7T6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 063347A015E;
	Wed,  5 Aug 2026 14:40:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 14:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785955213; x=1786041613; bh=tJBFvwQkcD
	OcBB1YXQJAl/Dw2HauPPIWDwAM6ebG2zw=; b=myu1YFogX41B7Wr6i3JcxfWQ6r
	cITrMUb3kHXPfD7JQ4jftT7786MYxYQFTn7sInXx9mq1sPINI1jnQscUU5wr5Ult
	h1ocUYICoNsRMifBgkubE/stO8oxrNhj2yINsbg+qzXdln/w6LioM9IiiVO+SzgF
	+97Gtl2ZzvPNAZiRuqPsUP54nKGkSm28PRbdCh57xlfa2frPdt/ukEx0upWO+rc/
	BgrGoDUWfHsX1FJNwQ9XE/8ETmbKW22XslqFHM00FoxlKfhs1q75AbH75MEHUf1y
	foXWPeZ83tfa6IB7uD1gQCbGXGLBLN1NMl+ADcY4nc/SvcXt0L2UdSIEV4Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785955213; x=1786041613; bh=tJBFvwQkcDOcBB1YXQJAl/Dw2HauPPIWDwA
	M6ebG2zw=; b=dpnLw7T6vmo8r68MC234to1Q3bqHX22UdBBkaX8MhoB8l3wdKHm
	Cyiv8/m6uOzltQZW3sq3Fxu3qAqfYT/XrsrbylHaLDLmT6eNjfagvI9dRXMgjdaf
	f1a4SgRFcCCO4SUU0uw7uiR18CEflM5vRyPd18NUsjgPo9j42p+gyRIbcUow9NMI
	CUlHjx2jxWjF0mpDwNBLmNo6SvYVJvRlx3/Yi82DbmMSrL6gnFUjBY2WckGzWVvg
	DXgPX1j+9cFycDolZ2kkbPxSoVH1/vSWqJ8dqtUchqgZVmNb3thkeTDPZDD+aOzl
	tabfxTZzFldbqh2jevfJe/Bo25JD3jBihKw==
X-ME-Sender: <xms:jYNzapz_LRHebwuLDuAQmOw7XfXgSJPl33WEmZSush3_elnkkJR67A>
    <xme:jYNzasX-gMB0aLu1vX70LZkHwxNWB1TyEXUSlRlgjNGrJ10hVT8SWWrbDca4oZJki
    EkGKpNPmW4ynrhhlZhRp0DVuLAzD1M8lP9EkAQ4K72I6esrhwcyo-U>
X-ME-Received: <xmr:jYNzat9Pi-s5lpO8gqiPQgPFrTlgEreYjaRbGMy2FBzlDLY_R1mfToDhUVugHLziL_WMgSUfTsM-TmHbKNEK538s47oDqHX_sA>
X-ME-Proxy-Cause: dmFkZTEhGj9YjsRSgAtaE9+MMsshqOVo6E4ogJTgr2kd8yb0uJUZ1HxJ0vjjJGUVdhhBKa
    IfpvlOa4WWFY+cLON9x9FZ5ucKe5Dz2zeRjPDeR6IK7SfgAtgQOsImCoznBPeUTglytGdZ
    nsjpeidlNbKBnpoxGnYSZcEOdqqsFceEO6RpEiho7Q/D4tRZvCiMhq7ol+RfAA6b6ERX7f
    BAadLNGWATM/pn4CqT/ogeBQd4XpvSrEfJs4TskfyWBdH1MTQuOQ2A+/yPkfgtLfPmTAG0
    XKqgl97swtKz8BEjJzryI1F01Xsm9Fa+IxkTVm/shljroNMGdiiMXYqF2mGy65wAyTXrMT
    +7JB/kEojedl1MBREU2X4tBESxJLJm+8SfJP4b5iSd2hlDd0nBrY7jzGuNPIFx57P1cMr9
    uB5xKdmArGA2jdAJ75GC/oWtrozGArVGc3g2hkKPIhVfvJxfBNmLse13uvwAU85897kiwY
    hLLDubzbyiFoDic6NJ4tak3PjgDvLb6ZmHfe44yZo1iKgKdvNxw8Y9C2eqtFFmu8ltystx
    D4N4KR8DpevjyQ0uRMAJzmKkqUmtZ36TXEW3vKMog2uxIVhlZbIGa2WnIK+tfUmRE9cyw/
    0poDgqAshZ6+f7l5NJQgXOHVjEn6ouBEV63TmWHYgrCI3NpBuVjrFFOlmcHw
X-ME-Proxy: <xmx:jYNzanvTqVCRVOItZlXmq7qDtf6ZkoAC0BbrOIiXC7sYV4_0aKhj4w>
    <xmx:jYNzal32cx__gwqJwUaDw7-9YyCiI0nd9jPuTnEYuDQhLEUMLAiWzg>
    <xmx:jYNzakSE5RmLy37f8T05ExT_FU54n7mMkLXeDZA_P9Esc4PNCS5LkQ>
    <xmx:jYNzahcruatM1lSYux9yWUYlJY4BAFja7Svz79p88R03s5FcGdpb7w>
    <xmx:jYNzal95hDFI02KBa2ak-W9SC1S7w4yh5O253HokPoKrzUfbANmGhyhb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 14:40:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>,  Ben Knoble <ben.knoble@gmail.com>,
  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
In-Reply-To: <2952d9a7-c7c0-44c0-a321-7ddad6497a6e@kdbg.org> (Johannes Sixt's
	message of "Wed, 5 Aug 2026 19:55:30 +0200")
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
	<f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org>
	<xmqqo6fso2s8.fsf@gitster.g> <anL0nIk6uzkYR9Oc@pks.im>
	<xmqqy0ekr0bm.fsf@gitster.g>
	<2952d9a7-c7c0-44c0-a321-7ddad6497a6e@kdbg.org>
Date: Wed, 05 Aug 2026 11:40:11 -0700
Message-ID: <xmqqpkzwpg1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 05.08.26 um 18:36 schrieb Junio C Hamano:
>>>> I think Patrick's writev(2) follows the pattern our previous compat/
>>>> routines have taken.  We use real writev(2) where it is available,
>>>> and in the fake implementations in compat/ we have comments that
>>>> essentially say "the real function offers X, Y, and Z, but we only
>>>> want X and Z and do not need Y, so this implementation does not
>>>> support Y".
>
>> A different way to put the same question is "what is Y in the
>> context of the intended uses of writev(2) in our codebase"?
> The Y that I am thinking of primarily is the atomicity guarantee:
>
>> The  data transfers performed by readv() and writev() are atomic: the
>> data written by writev() is written as a single block that is not
>> intermingled with output from writes in  other  processes; [...]
>
> (See `man 2 writev`; this isn't spelled out explicitly in the Open Group
> Base Specification.)
>
> This is basically unimplementable by any emulation that has to call
> write() multiple times.

Looking at hits from 'git grep -e writev seen', the only two places
we use writev() or write_gather() are:

 - fast-import, where we write out concatenation of the object
   header, the payload, and the trailing newline in three separate
   buffers in one go; and

 - sideband, where we send the length and band designator in one
   buffer and the payload in another in one go.

Neither use would work at all if we had competing writers working in
parallel to write to the same pipe, regardless of whether atomicity
is guaranteed.

I think it is OK to explicitly document that any writev(2) emulation
is allowed to be non-atomic, and it is also OK to declare that using
writev(2) in this application to allow competing writes to the same
destination is a bug.
