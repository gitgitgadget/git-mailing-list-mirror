Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AA35E95F
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839510; cv=none; b=FtVUd+CC8lcVQT/cloDxKqfN6gWaOyEGQgY1mOVTmcWrsjcjBdo74qSPQkoBu3UaopCxMv1g76fc4DOqQ9XDvJLBx8oOs8tvW7UM5LzjlDG5BUnNOn3vcpuqyBCGwVWPrfe4R5NG5I25RRsjk+oAjjVKxkFECTm7cnp3rijVYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839510; c=relaxed/simple;
	bh=BrdAxDJM+tstKS/Xrv9HgXzVZx23ivBKQeeXkEm7Qqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvavWrSW0/bSNvjOI+xKAUuXETQm+3CterF1weZWURtB2dwhmGYq/50F43LUDEJYpQMxExH4iWXotQU8HFaPQ6XDLPPp4jHRmRWARCIVoszo7tbclVHDF3g15DYeg8L7yIkuOSS5g8dKI/Ux6DVIwsBWU9uFD5R8KAaziEr9JWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=XFTySKev; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="XFTySKev"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id yeXXvqlXjWlIOyeXYvhyP0; Fri, 06 Mar 2026 23:25:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1772839505; bh=pQe2HVAfOKF5J9phdZV4/wQXw8HtHmdxXPYtLA0BDF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XFTySKevAadW6CeMFY6+Gu0oS8g6fjQekgNJGvSET+4vPFHM7rlRekBMms2982cfU
	 6PEVavN8CgA+UH8IF4FOHnnObjzEMvMcXm0KF6S6lhO3rfO0a8VheKdZZjOYa8JcRT
	 m19T6TZd0piIF34INvHMtz/XiM68Ro57R3sY2sVZ0WaCLBpIIteZRncZuSGggjMMMq
	 Jir6gExJ00d1Emc1sqHzWEAd4CT1LlJbGLG3SqRdX8T3cRuPaHyhE9nboNw4lmOrbN
	 e4k0EeQnw++QXuLfyoRclPDrDS79DaCagvHXyUdB7M8j/bE9mAf8CZfGC+JBZDTO3B
	 wMLNGQXch4nsg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=atcRCjZV c=1 sm=1 tr=0 ts=69ab6251
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=k4n9109sd3l8oj97RxIA:9 a=QEXdDO2ut3YA:10
 a=7KQvLkYc767Ca53Ssl81:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <c3ae9ff6-8577-48de-8473-9ec8d22ebc71@ramsayjones.plus.com>
Date: Fri, 6 Mar 2026 23:25:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] plugging some mmap() leaks
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
 <20260305220214.GB736322@coredump.intra.peff.net>
 <20260305230315.GA2354983@coredump.intra.peff.net>
 <9137fd66-9ac3-42ff-a892-1b6f20b49972@ramsayjones.plus.com>
 <xmqq5x78249v.fsf@gitster.g>
 <c3e66e36-cba0-49d3-b2a6-d65367f4be0f@ramsayjones.plus.com>
 <xmqqjyvoy5p2.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqjyvoy5p2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGWmx2DOl/WturaBBtdKGgAptBNaNUNi+nwOvUBK7oWN0wi23hZRGeJyH52+5qPotCbOpUEDWrPgNb3qr7/YPoUsg0U7IhNh1xsZYFT6SqE88EbQEfLW
 1IjWVg+y/px1vbsbW6eraQ5s9cbfAj/M67qms/46zXSc/xSkXJPWsnHxoGaIGTDxOawZq/ALrSwK3MY2PXF9tndyRNzBNSDH1xU=



On 06/03/2026 10:05 pm, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 06/03/2026 6:37 pm, Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>>
>>>> When compiling with the NO_MMAP build variable set, the built-in
>>>> 'git_mmap()' and 'git_munmap()' compatability routines use simple
>>>> memory allocation and file I/O to emulate the required behaviour.
>>>> The current implementation is vunerable to the "double-delete" bug
>>>> (where the pointer returned by malloc() is passed to free() two or
>>>> more times), should the mapped memory block address be passed to
>>>> munmap() multiple times.
>>>
>>> Sorry if I am missing something glaringly obvious, but quite
>>> honestly I am confused.  Wouldn't it be a bug to call munmap() again
>>> on the same region of memory obtained from mmap() and then already
>>> unmapped by calling munmap()?
>>
>> Yes. The (second) call to munmap() with the (already unmapped) memory
>> region would return -1 with errno set to EINVAL.
>>
>> The emulation layer does not detect this situation and simply calls
>> free() on the given pointer. Hence the 'double-delete' bug.
>>
>>> Or can the emulation layer cause such a second free() even if the
>>> munmap() is done once and only once per memory region obtained from
>>> a single mmap()?
>>
>> No. If you only git_munmap() once for a given memory region, everything
>> is fine.
> 
> Hmph.  You make it sound as if we have some code that calls munmap()
> on something that we are not sure if we have unmapped just in case,
> trusting that it won't crash us and instead give us EINVAL, and that
> is very much deliberate?  Unless we have such a code, bending over
> backwards to track what has already been unmapped and return -1 with
> EINVAL from munmap() for a second call is of dubious value, no?  I
> still must be missing something...

Sorry to confuse you, I'm not trying to, honest! :)

First, forget that patch. It was not meant to be applied by anyone to
anything. It was just to (hopefully) support the explanation (to Jeff
specifically) of a bug which happened to me long ago.

In particular, valgrind demonstrated a bug, which has probably been fixed
in the intervening years, which directly implied that some code called
munmap() on a memory region which had already been unmapped.

Given that this was on cygwin and, at that time, was built with NO_MMAP,
this meant that free() was called twice on the same malloc()ed memory.
(Indeed this is what valgrind reported).

If you look at the (currently 31) calls to munmap(), only one seems to look
at the return (in refs/packed-backend.c:183). So, calling munmap() twice
on the same memory region will probably go unnoticed when NO_MMAP is not
set. I have no idea why munmap() was called twice on the same memory region,
since I didn't track down the code responsible.

It was just an FYI about a _potential_ lurking bug when using the mmap compat
routines.

Have I cleared that up, or confused you more. :)

ATB,
Ramsay Jones


