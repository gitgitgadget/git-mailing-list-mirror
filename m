Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86083BBD9
	for <git@vger.kernel.org>; Wed, 15 May 2024 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715806218; cv=none; b=qhrDXdcbtUpg0eiU3e1gQlb7xYW9fvkleC5e2B+mL8jA7uRxo4z7ELz8H3WJkHIBsbw/EY2SIZvkYoOfUJJGdAlrUl7HBemAACZIOCKNz6m5rfD0Mu5kUmHSPd0eWZN6Qm9D1BiTwYAw+s+xWUNk5b2gF3BMoGBriioCs6xUVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715806218; c=relaxed/simple;
	bh=oJpuU+aAFUV3M3vgLYB19R8zJ+z+6R+PmUZlNeJPaOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i87kLgJTKkYniUBQxs4h36pCWIcxY9cwo4xLzpBVXcJ6jg714sN1+AAgn1jN0REfxRCUB0j4Y77x/CNgQjVJpPQlYedpWF7r4TKScIG+vvSbLj2pjKQIwuS/nTdvZ67ZCR7R7Y8BUUE8rfqmPQajjImFFZU1xIyRPWxgcFrGKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JDmLgKEQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JDmLgKEQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B1AC1F610;
	Wed, 15 May 2024 16:50:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oJpuU+aAFUV3M3vgLYB19R8zJ+z+6R+PmUZlNe
	JPaOA=; b=JDmLgKEQ7ZMO6+vEYYmd5wLM4DHcpJGzHbNLCUA1Q+4j00pGlINwqv
	McmUp9ubkB+kcFuXSxkiYcqqFJvF0HySdB5XcCuGeIOqj2JjxTxMxoQQ3ff4iPJQ
	PObf6zwKClIoziyi/vAEdXPGkJIKeAjt61vRkOT8A0ekn1MxkjTvg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 639C71F60F;
	Wed, 15 May 2024 16:50:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB2EA1F60D;
	Wed, 15 May 2024 16:50:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] decisions: focus on larger scale issues
In-Reply-To: <absdyh7wwpmzw67yrqa7c6ph4czekl2t2ro24muhk4k5pmqysk@b757bukiowtl>
	(Josh Steadmon's message of "Wed, 15 May 2024 13:36:42 -0700")
References: <20240510165526.1412338-1-gitster@pobox.com>
	<20240510165617.1412642-1-gitster@pobox.com>
	<absdyh7wwpmzw67yrqa7c6ph4czekl2t2ro24muhk4k5pmqysk@b757bukiowtl>
Date: Wed, 15 May 2024 13:50:13 -0700
Message-ID: <xmqqh6eyvlyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BAE5C38C-12FC-11EF-B173-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2024.05.10 09:56, Junio C Hamano wrote:
>> Remove "General Patch Series" section, as its contents should be
>> fully covered by the SubmittingPatches document, and make this new
>> document primarily about decisions at a larger scale.  Adjust a few
>> sentences that used to refer to an earlier description on patch
>> discussion to refer to the SubmittingPatches document instead.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/DecisionMaking.txt | 86 +++++++-------------------------
>>  1 file changed, 19 insertions(+), 67 deletions(-)
>
> Looks good to me. I'll squash this in to the next version I send out.

Thanks.
