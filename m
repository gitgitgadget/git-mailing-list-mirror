Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2867F7C2
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595465; cv=none; b=dfo+v8H/p85nSo4LsS1nqD1ibyZS9t6GtXpHKFsiaQzWmrHvj8Gf2d/3ppdQH4thR2teUDZA4sF/SdEPFscyTXCYHuvqMTHfIWRAz1ZFczoQwEvMPV9YhimZdPq7rfLjtZKb/MZUqGQ0aDQaJ5u8gePB64KM/Aoj+TUAUvc8d7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595465; c=relaxed/simple;
	bh=YG4fuaBzccLu7wopdU8+ZuEeomZYzGb2QfmgKnfDynI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ox0OdFyCf/SsqARZ1O0KzRbcuauTy4KFDRPZAIr/xq7Xm4xsNcjQNgqllhTjdvdAcqUR7f0QMjKyu0Ai6USqfSiC0fo9HGINNtLTBq97sm6JfWptZOH3NpfeeJ5ce+4FPCw2AoEWiuMUMgy2tqrfd9ZURgv6Y5nEh2IO0EvpnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OAaV3U21; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OAaV3U21"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3A291F32C1;
	Mon,  8 Apr 2024 12:57:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YG4fuaBzccLu7wopdU8+ZuEeomZYzGb2QfmgKn
	fDynI=; b=OAaV3U21jy2igH++rrQWzrIWIB6QTz8y+ilwVBRve8SPwL2b8OZzs4
	q0fCvaOEVjs6pbvch47uq1RVOxsk+GZQjAWQ5hWVZzAU0SZaeD/keXHqoaUkKmBo
	aIbFyuGvQqwdUGIjo8U+jzokEsrvr8t+kNaCXHa/HMh0939Iso68s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A07F1F32C0;
	Mon,  8 Apr 2024 12:57:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F64C1F32BF;
	Mon,  8 Apr 2024 12:57:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Chandra
 Pratap <chandrapratap3519@gmail.com>
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
In-Reply-To: <20240407012844.GC1085004@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 6 Apr 2024 21:28:44 -0400")
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
	<20240402204153.GE875182@coredump.intra.peff.net>
	<c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>
	<20240405191714.GA2561807@coredump.intra.peff.net>
	<xmqqedbjtqnr.fsf@gitster.g>
	<20240407012844.GC1085004@coredump.intra.peff.net>
Date: Mon, 08 Apr 2024 09:57:41 -0700
Message-ID: <xmqqo7ajdc6y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1D1E6366-F5C9-11EE-8646-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>> We should still be hesitant against the practice to the same degree
>> that we are hesitant against struct assignment, especially when the
>> struct is of nontrivial size, or the struct has a pointer member
>> whose memory ownership semantics goes against shallow copying of the
>> struct.
>
> Good point. There are really two thresholds: is this something that
> should be totally forbidden, and is this something that is generally a
> good idea. I think the answers here are "no" and "yes" respectively.

I agree with your conclusion but I found the above a bit confusing.

Between "totally horrible, do not even think about it" (0%) and
"that is of course an excellent idea" (100%), you want to have two
points "might have some merit but not acceptable" (33%) and
something else that is less than "of course an excellent idea" but
still acceptable (66%)?  I would not phrase the last threshold "is
generally a good idea", though.  "It is not generally a good idea,
but in this case, it is an adequate solution", maybe.

