Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C233C188
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823325; cv=none; b=VgbXpl5rSaObLjmWMZMMs0GmUPr7vTU6zlcad+XXlaXuVX9mNbOVin6o21xgw8K8ao7SFXeh57LZj6t1A/Y4iIKuLBS6lXhBExceVx15Z37TTW+1DxswQlONgyTypB6CHC+Lc2MjrZktZbjUM3RR1Ad2KPW0o6bravWunI8ONHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823325; c=relaxed/simple;
	bh=KtTglE3ij3v9fVihtWKBOfwMblm3/8YfZL6maK3fmd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKoAD1DqQnrKy0tykMGHFwX7BjpOzDeNWwU6yWUeeDqiMgJ/xEMc6NlbNhTIOsc52ivmLTw1/crrbWkMwv+pcEihNzHFAXs6mSgez7ij95RgrWaP1eb+Zh2SkplUa8guT1ERrXKfVx8A+MBgMeVU8VACPrk4/5cC1SG1NKNfJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=W2eg25N0; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="W2eg25N0"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id yaKVvpZWUWlIOyaKWvhBWL; Fri, 06 Mar 2026 18:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1772823320; bh=Kh596J6KuAB5y7wAeoVcNPC8Ftab9OtS15umzQOyzkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=W2eg25N0itxNZtayBUK4yCbKRSamXb5o5andoODun3H+7vswrHh7fIvsSNlJUHciJ
	 0/+/glKASJR28/7e0VlsloUyxStZ5gtk9XAheoGzo9l9YRz03luGrhokVMtaKB9HOk
	 mxET0vHkytnAoGMoi1m+9GIq013bSX/IFZYyesqQ2FcmVNe9ZJk0b2+BPqtcZgwpmW
	 bwuqHw02nhzlZ56i+Jq20xDgtnKcS5hy3iMhSJqk1I6/mtT9EBz5NIfSPkZ524oXR7
	 s4l7tDEq2e8PpteYH3E85M14bQlcsAKKxU8VQgrvmUXBSupNAxnZC14Les6hGk/Wtv
	 Rilb9Ixwi1DUw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=atcRCjZV c=1 sm=1 tr=0 ts=69ab2318
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=pLag_ZRrtG5cnYjjjQgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <c3e66e36-cba0-49d3-b2a6-d65367f4be0f@ramsayjones.plus.com>
Date: Fri, 6 Mar 2026 18:55:18 +0000
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
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq5x78249v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBw2UhwXVGCW2K10xvHOhMjjx6W64R6HNmPNjxiLC0Epcx8irf8f7PD3np+xWpjgrB5Um0syHoiUCFlXwdsH50OUJMofZUD5pfxNz1GdvbO73X6fD7K7
 8VgCCPi8c++/cJ3Fz/4CuM9d6kQMQK5SmxvhoxK1LCA6jPMaIuc0RJJJFzi7nj4rz67n33+VzwPYme/YSf8h4IzGu1cQVylEahU=



On 06/03/2026 6:37 pm, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> When compiling with the NO_MMAP build variable set, the built-in
>> 'git_mmap()' and 'git_munmap()' compatability routines use simple
>> memory allocation and file I/O to emulate the required behaviour.
>> The current implementation is vunerable to the "double-delete" bug
>> (where the pointer returned by malloc() is passed to free() two or
>> more times), should the mapped memory block address be passed to
>> munmap() multiple times.
> 
> Sorry if I am missing something glaringly obvious, but quite
> honestly I am confused.  Wouldn't it be a bug to call munmap() again
> on the same region of memory obtained from mmap() and then already
> unmapped by calling munmap()?

Yes. The (second) call to munmap() with the (already unmapped) memory
region would return -1 with errno set to EINVAL.

The emulation layer does not detect this situation and simply calls
free() on the given pointer. Hence the 'double-delete' bug.

> Or can the emulation layer cause such a second free() even if the
> munmap() is done once and only once per memory region obtained from
> a single mmap()?

No. If you only git_munmap() once for a given memory region, everything
is fine.

Thanks.

ATB,
Ramsay Jones


