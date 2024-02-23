Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E35D490
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719231; cv=none; b=q8XJavE7bPs7Y497bTC+qisOguvAZMFU6a44WfbVua/zyX12LzJC5SilTSzf0wStARsNo+AEPIFrEAiED7Nb/OQHbgiGDa+fXGXKsT/5DHb1t0un3XZZDQBggRF7Nfu1lGapvNSiscLXXV3Ea2pYZ52mUdk8tjrVE6R8OCHbE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719231; c=relaxed/simple;
	bh=7dbURGQdL6qIMea9bntdGUrO2ixWOorVOb1+APkHlTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lrzFWfjxddubdkwrP/iViC4Y0eTfJTQVLavd+xoXxSdhAYJxU3618IfUtxmkC7zhMC7lJJ4v6bEl1ViuAzEXLKPhYAESNopa1RkJgAw5yVbYPwKgxoHl3iwu+Ycf2X2XJsTCPfEdCYVx2XW0CZN+W2vLIbUh1Zq4DM+sAFDMVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ppp06jKQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ppp06jKQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C73A2731C;
	Fri, 23 Feb 2024 15:13:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7dbURGQdL6qIMea9bntdGUrO2ixWOorVOb1+AP
	kHlTI=; b=ppp06jKQFunshyFPb8mjWQ7yaNpuqcuZrvrDZyJPaSGcA0tY3ccZtW
	+oPk+FxV36NkyG1MiGdkXzcmiF7kovUrYcpxrbvVnP/9sa8GXkoJh3AINxtdxMZU
	UH+2OHraYXMGB0tLnFZquAp03+aGzTbOb0V0pwZ+GMTwGuM8MZ+n0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 84F032731B;
	Fri, 23 Feb 2024 15:13:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B46AC27319;
	Fri, 23 Feb 2024 15:13:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 0/5] for-each-ref: add '--include-root-refs' option
In-Reply-To: <xmqqzfvrrpju.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	23 Feb 2024 10:41:41 -0800")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240223100112.44127-1-karthik.188@gmail.com>
	<xmqqzfvrrpju.fsf@gitster.g>
Date: Fri, 23 Feb 2024 12:13:43 -0800
Message-ID: <xmqqv86frlag.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0C3955EC-D288-11EE-9669-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Changes from v4:
>> 1. Fixed erratic whitespace
>> 2. Remove braces from single line block
>> 3. Starting the comments with a capital and also adding more context.
>> 4. Removed a duplicate check.
>
> Does #4 refer to this removal?
>
>  	if (filter->kind == FILTER_REFS_KIND_MASK && kind == FILTER_REFS_DETACHED_HEAD)
>  		kind = FILTER_REFS_PSEUDOREFS;
>  	else if (!(kind & filter->kind))
>  		return NULL;
>  
> -	if (!(kind & filter->kind))
> -		return NULL;
> -
>  	if (!filter_pattern_match(filter, refname))
>  		return NULL;
>  
>
> If filter->kind is MASK and kind is set to filter detached HEAD, we
> assign to and change the value of kind to FILTER_REFS_PSEUDOREFS,
> so it is unclear if the freestanding "if kind and filter->kind does
> not overlap, return NULL" was redundant or outright buggy.

Ah, of course this is simply redundant.  The assignment to limit the
kind to PSEUDOREFS happens only when filter->kind has all bits, and
after assigning a different non-zero value to kind, (kind & filter->kind)
will still overlap, so a freestanding "if no overlap between kind and
filter-kind then return NULL" will not trigger for such a case.

Thanks.

