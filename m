Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943518027
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663828; cv=none; b=A1D3Qg2kAjE5aubL2A7H5M40uFl6VnwKVPsOD1fXympSEjFy8mcK8Cx0I+vDSaUVbZ478CpO6/1EADBFtWEx+X+Bd0UIgVB1UYYbxQLtKhhS/ObuV8LmpWid61YNkje59bQbfX+RjVb8OvWz7Ee67ak+TZXrMCpK9WTE83j2nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663828; c=relaxed/simple;
	bh=05kcAQD/PwuR3hmhS1FKzlNVrTYTbf2v9g7UzbPAwZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tI5Cejhi6K2m1qIusZG/NyeQEvdbHYp6wa79I3vVnvG2/KMyGRFXwjgjx2Hr2DGjx1VkG65sdL1YCodo4CU507ZO4RsAaLVGnZszLs7ty5+pbj4oDapVRoUSdkB+3WHVzZagtF34UPWbcw0teknjWDRkqCqCqgeiLtkqjimArWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hG9jvsyO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DmUmcUHl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hG9jvsyO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DmUmcUHl"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C42A1380298;
	Fri, 11 Oct 2024 12:23:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 11 Oct 2024 12:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728663825; x=1728750225; bh=9pQoHak7Ko
	h+Bzd2rEiXG1SHeZiz+6qPYlpGNXXBqeU=; b=hG9jvsyOyZT7OG+dCHLe4C/tZc
	d5bm+IVN6A5dsoJBgvMSAoJ2Ues5r0nJq+ld5Ea9YZQfbOASixPYErzZp2IwjwWk
	LchhVzs34RuR0MJ+J2ceUkU05prmud7jlyNMRg3+C1XIHP1yXdXMxJstY3SQcra8
	Hh2IFXtL/unIbxfEwNgU38lHG/1JStbmy/7BWhzpjCaESeVRTjZleaKGWLTvNeDt
	b3TJxWTuR+6vhxv6D5wEntlLctbrZDmXBLf6loyXRDInCKxezfer1uLB+CexrhgT
	eBIS0CqkRozvfQ2vaNBzpK3BCIDMc0cP6/uib1mDWB0cF0IZtk/JH5ZfrOcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728663825; x=1728750225; bh=9pQoHak7Koh+Bzd2rEiXG1SHeZiz
	+6qPYlpGNXXBqeU=; b=DmUmcUHlhIxwwJ8YLZjFO8y2lXYJYolPbLOVztRcmvBM
	ecqhPY8fU4Bs2o/WwKW1BnwkBYlDBDwRUfzVOIs/aN+jFNi/iKgDX1G+WJLPaN7c
	VCscITgcFfCCBNY58sU2BFnnAqVMbx5dC9u4l4VNBXe0z+j5WwOld5yfq4za0HF3
	VCJBz5upA+bR6eugnRvvIiRm99SGrcXt//qHNLLvmc2KEJHhnS1ZsCQVDvCCcPWt
	bXW8txZfWtlT8xlTk73cgKictM+cGPJl5prjXneKoUbKg7LXSQOs3miAQiQV9Hq2
	RPtQ1J4e8jJ89my7LlJWX6PabHz4xpTLPnMoxRtETg==
X-ME-Sender: <xms:EFEJZ6modGVDPC7Qtc5jt3T6PYrzL9spiHVw46sUM12TUzbZQz_Z0w>
    <xme:EFEJZx3C9VNDJa3mghCivPduGF60uadS2ATKwqfrvuF1vsqS_3KtLJmyeb8d_krIF
    OWMC54sRG_xHqtT9Q>
X-ME-Received: <xmr:EFEJZ4oMJpxO-RrvN9zCxqMHvywH_2RkcuaV5njwiaLaimmjULLO-S1PFSU1rOxvf7WeX_-vRGOwl7NQNEND800ySD2jSI8OLvxlQ3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EVEJZ-m-kisGzRJ7q82htu0_cnfeD9IbdR5D_Yv2VAaYCVEQYZ-pMg>
    <xmx:EVEJZ41jEK5IeIotUocJVJb30z_COKB6ghxKdnI9AKfSvsmZzRYFEw>
    <xmx:EVEJZ1utTWMtSDBxJAkLn83ICMbOHZlY94I9IeOG5_ihaxJvtvDEIw>
    <xmx:EVEJZ0UjVD5e3AFdoc0NIw14LDnm-qj_1NBmso3JNPGENpwy9ouYBw>
    <xmx:EVEJZyqK8SOtbxA2j9bTzG-eJn3-485UGlQj7hbhtgnOL2qSqeFO3Ppp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 12:23:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
In-Reply-To: <20241011080149.GA560372@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 11 Oct 2024 04:01:49 -0400")
References: <cover.1728505840.git.me@ttaylorr.com>
	<xmqqzfnblxdj.fsf@gitster.g> <ZwgJt19kWVRTQhld@nand.local>
	<xmqq8quvk8w9.fsf@gitster.g>
	<20241011075451.GD18010@coredump.intra.peff.net>
	<20241011080149.GA560372@coredump.intra.peff.net>
Date: Fri, 11 Oct 2024 09:23:43 -0700
Message-ID: <xmqqy12uhals.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Oct 11, 2024 at 03:54:51AM -0400, Jeff King wrote:
>
>> [1] I wish we had good names to distinguish the various cases, because
>>     the term "reuse" is kind of overloaded. The "slower" regular
>>     object-sending path may still reuse verbatim bytes found in an
>>     on-disk path. But this "blit out matching parts of a pack without
>>     otherwise considering the objects" feature happens outside of that.
>>     We called it "pack reuse" back in 2013, but that was not a good name
>>     even then. I don't have a good suggestion, though.
>
> Actually, confusing things more, there are really _three_ layers of
> reuse:
>
>   1. At the beginning of a pack, we can blit out the bytes for objects
>      starting from the beginning of the pack that are being sent (we
>      know any delta will be satisfied since its base comes before it).

Yes, I wouldn't be worried about that one.  The data encoded as an
ofs-delta in this section already point at their base correctly in
the original pack, and in the resulting pack.

>   2. After that, we process objects one by one, but do so very cheaply
>      by just deciding if we can blit them out one by one, fixing up
>      delta base offsets to account for gaps.

This is the part I said "we have to remember where the base was emitted
and subtract it from the offset of the delta anyway even if we are
reusing delta from the same pack, so what do we need a separate code path
for this?" in my initial response.

I guess, "fixing up" could be done by using the difference between
offsets in the original pack for this step, which would be an
unfortunate design that prevents it from getting reused.

>   3. Otherwise, we generate an object_entry struct in packing_data for
>      them, try to find new deltas, and so on. We may then reuse the
>      on-disk bytes after deciding they're suitable.

It is a bit unfortunate, if we were to trust the existing delta base
selection in the pack like we did since Feb 2006 [*], we should be
omitting the "try to find new deltas" step.  Perhaps that comes for
free as the object_entry knows that our object has a delta_base?

> We call all of these "reuse", and certainly both (1) and (2) are "pack
> reuse", but I think that term is sufficiently vague that it could apply
> to (3) as well.
>
> -Peff
