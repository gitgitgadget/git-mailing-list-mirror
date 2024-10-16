Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76C54F95
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093393; cv=none; b=CEDZ6QGTeGangyA2nD/L8kec+JfhqnWxWfHs+pZdOSEpmMGDMgqWoqAKefMMen0/aAzBOovY8B5wnGL+60hJRyQYjZcrKV7DAAXy0pz9BM7G+vCqCNLdoC5LiRHsJcVs+N7k5t1tY/ytAlKjJDEXBzZyLef3EJDw/VB0WDYVs/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093393; c=relaxed/simple;
	bh=Zb95AdUiDLb9mSeACFHwNl3mhc4eakSHNNTy/QsuhRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN5Y741GXJF8RkwEM/3nnJLn9AY1j+17gLuV5JSmjubz3UmSor6gZ+JDTCNhk/fOgYBe1ZSKR1UrxBr5TZs/HIeNAHgmgVa9WHtkqZ3RxgzmqbmEjQxEDawDFuW0Y33GTpkyqdplNWFhByE0/ewczvN4I25SMGJ4PtGFUWst6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ZEEN2SZ0; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ZEEN2SZ0"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 167ytCFJyAMas1680tdAdv; Wed, 16 Oct 2024 16:40:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729093200; bh=Ulj4m6tMb2xqKqUfpdFZwO88ChQcNhgWH2Xtia0Vj7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZEEN2SZ0tiSUuw/TvR83xRCWIntgLkFiRNJDVpUojb0t3z5u8HofBIvMT+6XM5T3c
	 02ntmludmNYZK86g1U4ZH6VwFQa4qA+hBBDYvytrmBGKvDw5ZW0cXKdt+p5chDdi+w
	 sT4Y0Sw29qqvyilMvtdwsTDmteGVOMlja6YO2VemDwffa9r4nkdtiallX73S7Cqy9D
	 lgih0uD50KXuTKXxjJHkE/c9s4qVPw6rQTltMDNGgGF+V2C5iA5T9vT8PTkOiFXfDp
	 /yIgo86coj147cYB/yVPoTrJNTLdAixPDJG5R5hp9wL/nmRNPUC5tz/jWLEqFyDn01
	 hHQpfP6PoMBvQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JP6YsNKb c=1 sm=1 tr=0 ts=670fde50
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8
 a=tc2-vZgwHu0GPeYY48YA:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <5056cadb-b8c8-4704-a508-1c7036559526@ramsayjones.plus.com>
Date: Wed, 16 Oct 2024 16:39:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <20241016145539.GA703747@coredump.intra.peff.net>
 <20241016150922.GA1848210@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20241016150922.GA1848210@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEh896ZBY+yKJ+SiADuT3Wy8/5vkL9XA8H5dqYlyeEQ0p0Wgp6cihw0HQ9E4e0kR6+KNIhOd9ereZPd2DBhrfXpSXHtMRF/Ez7tBImvfruLbnoer3ff4
 pfgriVNL7ZqY3xOGbF6ey/pbglLV1KtAbHaCTJTWBOBMBX/icz63MmYpACD2OOBE02qBXfd8yegaInz2OevaKB7eytwwjLVl5rw=



On 16/10/2024 16:09, Jeff King wrote:
> On Wed, Oct 16, 2024 at 10:55:40AM -0400, Jeff King wrote:
> 
>>> The logic is broken on Cygwin though: when a client asks the daemon to
>>> exit, they won't see the EOF and will instead get an error message:
>>>
>>>   fatal: read error from cache daemon: Software caused connection abort
>>>
>>> This issue is known in Cygwin, see for example [1], but the exact root
>>> cause is not known.
>>> [...]
>>> [1]: https://github.com/cygporter/git/issues/51
>>
>> I don't see any details at that issue, but I'm not sure how it would fix
>> things. From the client's perspective, they are going to see the
>> descriptor either way. Unless there is some magic that fclose() does
>> that a normal descriptor-close-on-exit does not do.
>>
>> That "Software caused connection abort" thing seems like a weird
>> not-standard-Unix errno value. Searching for it mostly yields people
>> complaining about getting it from ssh under cygwin. :)
>>
>> If the magic that cygwin needs is actually "fclose before unlink", then
>> that is in opposition to other platforms (and I suspect would make t0301
>> racy there).
> 
> This all seemed eerily familiar. Try this thread:
> 
>   https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
> 
> It looks like the conclusion was that we should adjust errno handling on
> the client side, but nobody ever followed up with an actual patch.

Heh, our emails crossed. Yes, I was hoping that, given that Adam had identified
the cygwin commit that caused the regression, some resolution on the cygwin
side would fix things up. I waited ... and then put it on my TODO list! :)

I did look at the cygwin commit and it wasn't at all obvious what happened.
In fact there was a comment about making sure that errno values didn't
change as a side-effect!

Sorry for being tardy, again ...

ATB,
Ramsay Jones



