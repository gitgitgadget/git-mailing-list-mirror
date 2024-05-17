Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6912F5A3
	for <git@vger.kernel.org>; Fri, 17 May 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965182; cv=none; b=uT96GP+WAsAgCq8k8yea7MM1eNSxgOFY2tLPvqeItf2wDqe5CDNKrRrEXAWay94aTsUbeh7jDgJCo9s6/2bujSZeXAeD0DV0gwI6UmaDTk406GHOtPAbV515ykkUkHw3hA6tpyJpAM4uSFO5fmgxnBMU9FRwmyExfAA4r0V4HR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965182; c=relaxed/simple;
	bh=2GIdIf67lSItOhrdeNYfASR77+lzHThCjCN0PKEiRF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgNy3BCUIrHqqaOWo1uRB/ls6LkLSkmt8wB1abfFDjnaDy50mBQB6TWzqziBLaCIeAVyCaOh3Cy5awn6/rjq3xbEqNQhZto8QJjo1tMT9ePLuVs++0iY9Q7gc5E5EE/u8+GFRtfLfC41ar1FSboFL1TspUI2rvg5AuLSf3oITTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sxx39Xb/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sxx39Xb/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 433D92F297;
	Fri, 17 May 2024 12:59:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2GIdIf67lSItOhrdeNYfASR77+lzHThCjCN0PK
	EiRF4=; b=sxx39Xb/F3y3S64quGBb215qSz0T1l8mcohGE6d4RrCexOLHqk16K2
	xRnLhlr2J3v+F5KUfTE+cojoLLsd8lhdiC/AjayO8AS3Ru6JKV6u+cCjZ8xQMhEM
	Y8E8dYpEOYup9qgDKDywetU5hKTHO976vzavyeLbW5p58aryqpzIs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B8AE2F296;
	Fri, 17 May 2024 12:59:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD24B2F295;
	Fri, 17 May 2024 12:59:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Kyle Lippincott <spectral@google.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
In-Reply-To: <20240517081909.GB1517321@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 17 May 2024 04:19:09 -0400")
References: <20240509162219.GA1707955@coredump.intra.peff.net>
	<20240509162415.GB1708042@coredump.intra.peff.net>
	<CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
	<20240510220228.GA1962678@coredump.intra.peff.net>
	<xmqqseyp1dys.fsf@gitster.g> <Zj-pGGGJEXlH02nR@framework>
	<20240516071930.GB83658@coredump.intra.peff.net>
	<ZkXX5MlN3EbaMhNG@tanuki>
	<20240517081909.GB1517321@coredump.intra.peff.net>
Date: Fri, 17 May 2024 09:59:35 -0700
Message-ID: <xmqqseygjrwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D799E850-146E-11EF-A31E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Yeah. Combining orthogonal properties into a single job lets us cover
> both (for the common case of success on both) with less CPU. But:
>
>   - it can sometimes be hard to figure out which of the properties was
>     responsible for a failure. That was the very subject of the thread I
>     referenced earlier, where "linux-gcc" was "use gcc" and also "set
>     lots of knobs".
>
>   - they might not actually be orthogonal. If you care about checking
>     runtime behavior in the output of two compilers, then that _could_
>     manifest only in the sha256 code. Or as you get into more
>     properties, they may overlap in other ways. I think reftable+sha256
>     is an interesting (eventual) combo to test on top of reftable+sha1.

We could consider permuting, then?  If we (for the sake of
simplicity) had two jobs available, one compiled with GCC and the
other compiled with clang, we can enumerate other properties
(e.g. <SHA-1 vs SHA-256>, <reftable vs reffiles>) into pairs, and in
one run, GCC may be running SHA-1+reffiles while clang is running
SHA-256+reftable, and in another run, GCC may be running
SHA-256+reffiles, etc. --- eventually we cover all four combinations
(admittedly for different commits).
