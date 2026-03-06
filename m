Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759F24E4B4
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819357; cv=none; b=tDZL0a36TV4QrYJg2shDvaJC8dXEN9KluB6Q/rqUqdGebDRx3R9bKFjIh25i3kyS9rk+siNo7A2KiNE34gXdCaMmnJw4nSRWiq2w0NLabIo5ydwDcsuvPhMb2BYVZiXErFli91ojp9cybLe53UinFy/alBv6Y5RpJ1Fq4xdJ6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819357; c=relaxed/simple;
	bh=433udbNXRREBmGz/srYpo+5GWftabUuOWuwUHcIVAcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8cDLUh0gIifqDb5zEDOjax7/SrAwAjYkQ29XkM0gpf+QjZvi7SGEgqO6uLk4VsmO1z2YYKvL4Amd7KagaAlekteXm2PQYOwM26FjFCN5t+XLWvqbFNNH7+0HCnBX28iN1MJDDPXvSTx1EwIU0iXJ8UBX+IUAwCASU1lPsSU00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=a5tnVwua; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="a5tnVwua"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id yZIOvpMXfWlIOyZIPvh1l8; Fri, 06 Mar 2026 17:49:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1772819345; bh=idjHgE8bZi71kn47F/as6TqMaeLk42ii5EVOI++L/8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a5tnVwuajVfTWLTTBihc0i87TrSCYwGuR3IMlhKuJVor1NgyWzPJSLDzosHunBZ+x
	 7ZrMmUoCAJhwjj2wZOk6MOVsSUfnCEyWoCJcimmFmMqqT2TcIexMpZsa1k6hm83Map
	 RYhgxoly4tJfJH0tt5QL+b4nu4Z5ctUz9pA/A13Rq13PFSBkjeQ6plmcHdHM09Qphr
	 dz1SLdzHzIZ/kINFHoxTh1DcuOQDY3xtw1ew59ys9nU0S+p9QhrGajli6bYBUhzVyB
	 tsLLNIJEaby1fLgQHTJACSIYVljhCUzBD9RX2I5+bSF5GBdyZUpzgi2LPdEIczgdoU
	 q45Kj07XBAClg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=atcRCjZV c=1 sm=1 tr=0 ts=69ab1391
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=Nlkkc2UY74WT0v2TqgQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <aa83861a-cc0f-4fc2-9599-182dac8b4e9a@ramsayjones.plus.com>
Date: Fri, 6 Mar 2026 17:49:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] plugging some mmap() leaks
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
 <20260305220214.GB736322@coredump.intra.peff.net>
 <20260305230315.GA2354983@coredump.intra.peff.net>
 <9137fd66-9ac3-42ff-a892-1b6f20b49972@ramsayjones.plus.com>
 <20260306162106.GA3483423@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20260306162106.GA3483423@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDwyhwWv89+5ROTOq611HeuQ3ITAD5BqWgt6X8R+wyEMSjz5sN//nujF64Q0xvrsKL92VkE0Ki8JRP4mJX2+Q1BqU+ri0vVghRPlei3UPLKGZimaNvIw
 57/bKxKM5dLDR7NsmF9QkoHg/rGjFBxzH+RimmXIvrqNPMvMvMMh++FqphDNdczuMium/btslbGjMjSexOFzT0Kl98RYPiapXW8=



On 06/03/2026 4:21 pm, Jeff King wrote:
> On Fri, Mar 06, 2026 at 04:37:49AM +0000, Ramsay Jones wrote:
> 
>> Many moons ago, when the cygwin build routinely set NO_MMAP I had an
>> valgrind build of git fail with a 'double free' caused by a call to
>> git_munmap() for a pointer that had already been git_munmap-ed!
>>
>> In addition, the failure was not reproducible (or at least I could not
>> find such a test). This was at a time when the testsuite took 4+ hours
>> to run for a regular build, let alone a valgrind build. So, to try and
>> pin down the failure, I created a debug version of the mmap compat
>> functions, which I ran with for several weeks, without failing ... :(
>>
>> It just so happens that about this time I was also testing running the
>> cygwin build without NO_MMAP set. This was a success, so I dropped
>> the NO_MMAP investigation, never having found the cause of the failure!
> 
> Interesting. I guess a double-free via munmap() is probably a
> harmless-ish noop, rather than a heap corruption. I could believe we
> have such a bug somewhere, and it may even be racy (e.g., if it requires
> reprepare_packed_git(), or maybe even has to do with stat freshness when
> diff.c tries to reuse working tree files).
> 
> We've been testing ASan builds with NO_MMAP for a few months now, so
> it's possible that might help flush it out. Though if you ran into it in
> 2012, it's possible it has since been unknowingly fixed. ;)

Yep, it was before 2012 and I suspect it has been 'fixed' (but could, of
course, still be lingering ...). ;)

>> Subject: [PATCH] mmap.c: log mmap() blocks to avoid double-delete bug
>> [...]
>> In order to guard the implementation from such a calling sequence,
>> we keep a list of mmap-block descriptors, which we then consult to
>> determine the validity of the input pointer to munmap(). This then
>> allows 'git_munmap()' to return -1 on error, as required, with
>> errno set to EINVAL.
> 
> Gross. :)

Heh, agreed! :) There were several reasons I didn't submit it in all these
years.

> This is a clever workaround, but I think we should consider it a bug if
> we are calling munmap() twice and fix that.

Agreed. (I just wanted to bring this to your attention).

ATB,
Ramsay Jones



