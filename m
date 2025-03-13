Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3101266B73
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872406; cv=none; b=nKEQcfg16Lm0oM7wL+Io2a4vdwelDaSa3HMUalBTEIPtXdrs2v8sww4OvcjO+X66CIedXWLoR0rwnqPmQy7zFGzk9Wd/8cixVofU33pZpEZGorPeI29zUAbErelbVwaJSRbn2bxTYE7btV0zkEcghjGqrGfCYe1hmDaaySqUmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872406; c=relaxed/simple;
	bh=mNdYotLFdlKP6f4J1hrGyz1U1Y/9z+cRgIiZB/1lGXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5z4RyZ4l+lcOY4CEHYtKFiaU92Siu3W8K/lLj3aQ7d1ao0LL9nq16bcGgHIxPkF/pfpq/ESpEGWKCxFgPAvBkX1GmjzvUNuXcjg6YPOc/YKZ5Od06UHfvHn8OuTATcRMyqNdHkacS2OtzLbScAOiuko7rRy9JHoR2aKkidc188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xKqboCXx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sw3Pmg+Y; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xKqboCXx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sw3Pmg+Y"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC73C114011B;
	Thu, 13 Mar 2025 09:26:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 13 Mar 2025 09:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741872401; x=1741958801; bh=p4zw29+TKU
	ioMYNFVWECwAs3EQ8KuFT88yazfM6h2Is=; b=xKqboCXxHCJGfFI2/m8n4jEHKs
	qB+56516ACKhb2H9joQz360ME+MLcx62ZVWUt6V87n9aQkA24ZZvMVQR/SLEa+iP
	F4XT9SW9OPh6NKjSyH1KC0o4Gf80ceqIQQBAlSZ4+iVe9qaugNzlVbaywMFoUI9h
	owu0f5sU6xgX8aGCGgrTy/azscwHGxtAHMpUQqsVsSPhncNZ2Nf9VXY2bv1KCBrH
	Y4xpmTT6teXJb7PqbzfpnbCyuhSZpcQJBjN1ogAxLkYrqVn1obY8IbndbILvhyvX
	pu8ag2r4VItOkCSEY8phb6UwuH3EPQUdgv9OH21vVlAV9O5NuqI1RDD6iQ3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741872401; x=1741958801; bh=p4zw29+TKUioMYNFVWECwAs3EQ8KuFT88ya
	zfM6h2Is=; b=Sw3Pmg+YeCo8YqF3h3ZAJ11YdgT0GqhQ6ONXnviSHBp1mq8HIt8
	z65zOYJIQVoI6ZUmmUanaCWyXBjuWYLJzJXFAnrc8W10NwvKneUO444lRaMuuLYl
	Q8xo3KASbMAa0+LK5SfASHEqkfidk+vqnNN6B19d3mAkv8smGymsKGG3VZFSgnhB
	52JJZG/92fdedMafNhVXUQ5RhyEKMA9FPgwI6sIVu/08L3u98KfZQZk9Tq1jMvnX
	PEDgMAeFf2D2MSApHJnz6iRCEa4Ya0sOVfb4YGhsQ6Gh3UBXpFaV1lpChKrM3Pa3
	kgtDqntPKeGgQr6hLb5ilRr+ymSHEY/R5Ww==
X-ME-Sender: <xms:Ed3SZ1qukNGOc1dq2M_fpr2VcALPqyu-LryZr4JKEI4J8Xzd6UoTqQ>
    <xme:Ed3SZ3o0LUY0r5PUJ47dgDiEryB0f41IeKgISsqv1_bFW3r7-Ge53psWzYu8WdaKV
    aSSeFHFlsQW0aI-XA>
X-ME-Received: <xmr:Ed3SZyNMPaIM30Oj9-9O779xUMWW99Pq7xCGcyZ8louifK_k7tsBy2W7_ULgPqQH1U574BMdHiv1HRTA_eLj8y-SAMGYiy6oC-c3NYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdektdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhoughorh
    hovhestggrrdhisghmrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ed3SZw5JqPXCzQxHxLK_4ZOtkMaZ0OscSZ4HrmCdD2m8ZL1sQHuY0A>
    <xmx:Ed3SZ05zdYPLeT9DLSJ7ROWhkUuOHr-shrbDzEdb9IJ3FCmEKLflsQ>
    <xmx:Ed3SZ4jIaO_UZXra9YWo7bRxNoauYTdJFAVTIejSa1SRDSL8-k_-Og>
    <xmx:Ed3SZ24jxVM18G39e6xpPCWihCqkbZhlbtpAqf7BCAPa1Y-6fOK6ag>
    <xmx:Ed3SZxteTsOUZ7Sfrxm-Ncw3yuYB7zfoPqToHxTwMf7Yl9g-8JPeI2fI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 09:26:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Igor Todorovski
 <itodorov@ca.ibm.com>,  Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 5/9] refspec_ref_prefixes(): clean up refspec_item logic
In-Reply-To: <20250313054107.GE94015@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 13 Mar 2025 01:41:07 -0400")
References: <20250309030101.GA2334064@coredump.intra.peff.net>
	<20250309030706.GE2334191@coredump.intra.peff.net>
	<Z9H+vWHFkATWNLxt@nand.local>
	<20250313054107.GE94015@coredump.intra.peff.net>
Date: Thu, 13 Mar 2025 06:26:39 -0700
Message-ID: <xmqq5xkdrrhs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> > +		if (rs->fetch == REFSPEC_FETCH) {
>> 
>> Do you think it'd be worth handling rs->fetch in a switch/case block? At
>> least that would allow us to catch unknown values more easily, though it
>> seems unlikely we'd ever add any :-).
>
> ...this whole thing is badly named. It is called "fetch", but the only
> two values are true/false. But for some reason we named them
> REFSPEC_FETCH and REFSPEC_PUSH. Surely it should be "type" or
> "operation" or something if we were going to use an enum and switch?

Sorry, I suspect that it is my fault.  I've never been good at
naming, and if the allowed values for this member are FETCH and
PUSH, then the member itself shouldn't be called fetch or push.

Perhaps 'direction'.

But such a name improvement is clearly outside the scope of this
fix.

Thanks.
