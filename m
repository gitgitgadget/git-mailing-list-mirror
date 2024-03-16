Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7918C36
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710607855; cv=none; b=FCyQ/kxrFjlUceIFO09QMUle3X+NnPCrAuSfzzGJhai0XvCANUJqRcBnMbJg7sfyuRXGod3BXuQgMWP77kRNTOwBip1XWNWrqKPTQW43nqiqAdAohEa9TYKLzA09/C8XKcdS8nmqlih398zcCZlrQ/+WJXYY+PDo8W1Js4Bvjss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710607855; c=relaxed/simple;
	bh=OOqxBzj3uqmMts5FmeAbz4XSm9fnuyrOOhE28U1Lwf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KK40DmGjPlsFGZ9kbimE4qAHugUifo67p1n2m9bY5h5MKrQlJfwqsy3o/x40ugVKZkcrG1Qfn8xz5UuTX4+wDu26Yex1V1RQZGv36o2RJdF3rAXIUo8d8Nzkhq8KV78II/J0KzLNH89WmNOVfstsWy5eXg7LHSVd1hUr/CujWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=NQsZl/9t; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="NQsZl/9t"
Message-ID: <4ffc4ed2-0a18-452d-baca-6d72cc0ab2ca@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710607852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3pTKA3djWFyXztCi+3gcaLcUZJ0xjlCa0WwLy0Y2sk=;
	b=NQsZl/9tRtjEvzgG7pkCkNVCs7pTI43/T+7+ty9QLy9vzgk4gDxSy8OHJ3Y77lZBzuD1Mt
	KT1gFmO60zcx0eT5wl2nBQPA3cxAdrwopJ40M4K3nspTlfv08dPNgwqeZaAw9c4lTADtb1
	0znayZ/5QhzaLbb8r0fQ058l5dsIVx+q2q5EtYE+YYbdTBqLv1jlaFNVxjcDGOu/rTKtF/
	K2Yyd5OY5Vz/9sgzwWZ9aqqj65qUTynUIY109g40qIH5MSRWDYoR+cABb+wqynKXGDGnxC
	eK4SHDM2eYvBr5vLeNvlF5C15Z/CoN0fO40I1zHdr00SspAHFRXfRJ7prNvfyg==
Date: Sat, 16 Mar 2024 17:50:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Content-Language: en-US
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com> <ZfXCXAdlYdS/p8BC@nand.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <ZfXCXAdlYdS/p8BC@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 16/3/24 17:01, Taylor Blau wrote:
> Hi Ignacio,
> 
> On Sat, Mar 09, 2024 at 07:18:28PM +0100, Ignacio Encinas wrote:
>> ---
>>  Documentation/config.txt  |  9 +++++++++
>>  config.c                  | 17 ++++++++++++++++
>>  t/t1305-config-include.sh | 42 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 68 insertions(+)
> 
> I took a look at this patch and felt that it was all very sensible. I
> left one comment in reply to the sub-thread with you and Peff with some
> minor suggestions on the documentation.
>
> Otherwise, the code changes here all look reasonable to me.

Thanks for the review!
 
> Thanks,
> Taylor
