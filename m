Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40447496D49
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071966; cv=none; b=p9UD6nrElEiyyc+whkzIjE+SXtLvlKOV/Jfoyn6/dlvtZU1+aSWDlJYRrGC4zdNaOniQUZATFKBHQZ50ihQm6kBTXrq8WQ1PZtTU2dGaq8/6gNxYsjZ9ju9VEXt2ZTu6bP3G656Z3utXcrM7G0jhtlONzJgq1vBTiiw5o2w+X94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071966; c=relaxed/simple;
	bh=IJwg2zW83/f6qYKjbHXZefw4KVFOx1mVhm3RI8wVrKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j1W9VGw/vZgMg3Kv11itv81IbcIIwj1eqAdmIKgJvsyQuc2RzV1ZX/iu0pexI5uK62yFKX1J4t7reUPJXtPncvIpFWJvUdjWUPKgGVm4AmeaItY5vmKyyNV3tZBZcXiibS6+WF4cMYhi60gL7R5KeDo8TPDqPtvQVRh+2/rBhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ix5txTQ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w8wVJR5H; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ix5txTQ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w8wVJR5H"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7695514000FE;
	Thu, 10 Sep 2026 16:25:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 10 Sep 2026 16:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789071958; x=1789158358; bh=ZH2sTDvSuP
	SRROWaSjLFUs9JBzZ6fnyBpin45ZbyGh4=; b=Ix5txTQ7AxtYcAc9S8Hi63VB00
	1u08iK9aj7LXINWP9pqQ6G56k4YJMbzhfUnRC4OnvySSsEqq7p0m76xLrE73DAe0
	lLCly1jfVFD0JW9/qB6NlBnAZz2vdRMcj5xvxjOsOrOXml4jWa6LYGcL8YBrQnYv
	xkzgQ8T8F3GcTe0+2T+k7syZbojvesHpVdCCWSQ4EyEX0CU4X5oIV2KHkfaUSw7I
	Wp814ykR+GyV8AeMX//1NAp05WHKXY2iWc/bLwOVo2NhWu6AAb+RF1w3f9MKAxcG
	Ck0BRg+G78oBkQl32TYsb+GoxtY7eH9ehSwrlbBJE+EwfVJulsBJknltuYLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789071958; x=1789158358; bh=ZH2sTDvSuPSRROWaSjLFUs9JBzZ6fnyBpin
	45ZbyGh4=; b=w8wVJR5HlKqG1CksSlM2oB6RyBnI5eOY4it905Wm6uxMFpjqzSR
	0Ap+ZmKSRpb4R5cB6P4MpQZKfSCHjoxdfVWdkNzX92hE7Yta0jhp9d9KtRPPe55F
	+kUBXvMzI0CB1osd901GstBIFNfni13TiINAmThfFkbiK+K7vcKbeeZvwF17F6kN
	ERkWsuTa8e3dAr2APCCruAo4Vosq7smlLVH0fvedAftiCJ3+XpY63nxzc1/5fOxY
	kAtG5Hlx7SniOpGwlHy8u1Qydq2wmkkihcL/2vMiN/a6f19cELvMDKJzcwAtMgd4
	JFMNnwNS0jFCrHKVY+9Rcv7h2mWKhdgJ7Kw==
X-ME-Sender: <xms:VhKjatgkDqZHZ822wWvcocNT2XN1tvuMyit0AcgXhsNupix2wO-KCw>
    <xme:VhKjalsBsaf-nxpZvnyZ_rh8l3V2zcqY_RNhMgURqQ0xS5BTb-dtxNZmxHAtfZmZ1
    OAURKIxhhcLgZysv_CLsr0PBPAMh78jblwTHG2sQT2K3F5e_ZbtRro>
X-ME-Received: <xmr:VhKjam6wPODb2Fy3ko9-EyYNOO8Mor5CorcL8xX6WOQ61HXfjhi1xKAG895FxV4U8mP00GvK_EGBn9tiCXmk0tcNC5v-AY3laFUX>
X-ME-Proxy-Cause: dmFkZTFgXQQNDlkTdhIu446sCbjxVF46Dex96OLgjs1A5gNluMG0yHVFczD2c3gb+0HEQo
    kDjEhj24fk287xCGMtiQ2Q+QPfFAbSl2eAaCI9Lspp0kRC/xiEtz1AELrk1zcLdO29ZvgQ
    kZtQIQgq/q36s0j/B3RZpPNXSObmF7WrffgB08Ou383FcA1uwm5SunQC8gsS0YSYkFzAze
    unKGAtIGDW6mdIUI5f2uaun17KUcNvaOSMMbp4LfZFWOEHk1GQvGBmho47DPt5yKlwO1in
    URGYq5vQQsMWXNBrE/6YzF4k2iotH5ISUx7lb0wDhINDIjNU3j3zloeeFHFbExOlq/EgOM
    T2RvAPzQRhL12CmEJ0sj8qeSmsqbupVDHyZuc9mP1JIanGm1ngDzXl82XalKIqzWJMc0Sb
    XKIFFdbyqn+OmJVui/KiL75F2SS1HEboAMEdEqyctu7iF1ajqXS5bLtVS1wSaojQvHKUYK
    kI0G27/Wgxi7l5BeFanhKQtMmljTj0zGy0RdpdFqC68Qq2G6uS8pezIdIsUTFMtbUURk0n
    3F8dUMq6Sm4OZCK92XY8A13434xpUPIefgP50z506Vew4o0bUQMpSZ9m+IssHJCVxmj3W9
    QuE89YlldTm5CKWlwBUuRtvCOzzHiraEuZh+6dCsVnQdmtpbJ4M4vC3mnhVQ
X-ME-Proxy: <xmx:VhKjapNir-2o9gym-F8DYEZiAuv8kPZuJno5Pz6gpAOOYTDGmsb7UA>
    <xmx:VhKjasvZNobE_oLJqo9nivD_SqvG8mgcZQDZBJYqH3FSeZQ5A17OpQ>
    <xmx:VhKjakY8W819eo1TgKsVKeWp4BjrBij33W-S-THcUKlHZP4ZJvHkQQ>
    <xmx:VhKjamwEkLquh3V_irrqKIg3NxfrWlIwQ-OofUY0dPEap8yPkHU6Cg>
    <xmx:VhKjalzafOrx7PmxUzg-BjhLVabqvni3X2qScPGt7IlMyPdNnyivRjmH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 16:25:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>,  git@vger.kernel.org,
  ben.knoble@gmail.com,  gitster@pobox.me
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
In-Reply-To: <20260910201111.GA919731@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 10 Sep 2026 16:11:11 -0400")
References: <20270829004959.90983-1-ub4nal@mail.ru>
	<20260910085353.109373-1-ub4nal@mail.ru>
	<20260910085353.109373-3-ub4nal@mail.ru> <xmqqzexpf78k.fsf@gitster.g>
	<20260910155247.GA251185@coredump.intra.peff.net>
	<xmqqpkyldke1.fsf@gitster.g>
	<20260910190345.GA903701@coredump.intra.peff.net>
	<xmqqh5jwevbm.fsf@gitster.g>
	<20260910201111.GA919731@coredump.intra.peff.net>
Date: Thu, 10 Sep 2026 13:25:56 -0700
Message-ID: <xmqqcxuketuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I'd be surprised if anybody really thought carefully about it, though.
> When I introduced advice.* in 2009 (geez, has it really been that long?)
> I had assumed people would just set it in their user config. The actual
> "git config" command advice came much later, but I don't see any
> discussion of global vs local in that thread:
>
>   https://lore.kernel.org/git/pull.548.git.1581311049547.gitgitgadget@gmail.com/
>
> Amusingly that thread also touches on some of the "could we just convert
> everything to advise_if_enabled()" issues we've discussed here. I had
> zero recollection of it, despite participating.

I do not think I added much input into the topic at the
philosophical design level---just the usual usability and
correctness review.  No wonder I do not recall anything particular I
contributed to the discussion there ;-)

It is very much understandable if we didn't mean the "use 'git
config advice.foo false' to disable" as a cut-and-paste ready
instruction, and rather meant as a general instruction that any
intelligent users would tweak for their own situation.  And it is
not surprising, from such a stance, the 'git config' hint would not
come with any scope indicator.
