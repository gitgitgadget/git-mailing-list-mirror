Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AE78B47
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589235; cv=none; b=FzmM51cb4CRE0NZSa9qliikfqhmLPNPGHU/etR2fW53jp7/IbaMhYm4EQ0+RevbTVjBdofp1yPmSB05IN178Ibc7yjXLGc2ShhORialD1jxewfjUVkxEkM8/XBEon/LBwqz7hGdGaQKeBxKW6otfxPLmRre3T7K1+6y0M7t0nqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589235; c=relaxed/simple;
	bh=nyPSRUwCVfr/aA3FFeJ9SHbZIVtZjHKsNr2SdgV/ntg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sy489aj7BB/UL6eiw9HmpQ7yVjqVfrK4eBPkQuIuMZlGL3zuPILnwU+R0esMWVqbzJv5IpOXb75wPbRsfWcn4Fe2vkuvQ713IVy4R6IyKMkt+Oed2SxBsihZIPh1/aCVzz1B2viLynIY/QpJhayKv201ahtsxQNCaJiacdXHccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=H0ITEe69; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H0ITEe69"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F1CE61F4C8E;
	Mon,  4 Mar 2024 16:53:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nyPSRUwCVfr/aA3FFeJ9SHbZIVtZjHKsNr2Sdg
	V/ntg=; b=H0ITEe69vMSaDW3zuFhs1fq776rR6ExR1vx/d5I6c8DiNMaa8kVrBa
	7zdcf5pQsetRV6UYIZOmDOPNnayyRbUPnu6HjHsr4aevlV5GFTG6Jy7I1lkoHjyw
	UsDz48pkPLK3gosADZyysWv0LOf4Ed8gMsAHkvYpi7cjMQUxb0Tec=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E90DE1F4C8D;
	Mon,  4 Mar 2024 16:53:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DA0F1F4C8C;
	Mon,  4 Mar 2024 16:53:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Cc: <christian.couder@gmail.com>,  <git@vger.kernel.org>,
  <johannes.schindelin@gmx.de>,  <newren@gmail.com>
Subject: Re: [PATCH v2] setup: remove unnecessary variable
In-Reply-To: <CZLA8TF4XG5S.KU06P62V03TV@gmail.com> (Ghanshyam Thakkar's
	message of "Tue, 05 Mar 2024 02:57:32 +0530")
References: <20240229134114.285393-2-shyamthakkar001@gmail.com>
	<20240304151811.511780-1-shyamthakkar001@gmail.com>
	<xmqqjzmhq2vb.fsf@gitster.g> <CZLA8TF4XG5S.KU06P62V03TV@gmail.com>
Date: Mon, 04 Mar 2024 13:53:51 -0800
Message-ID: <xmqq8r2xoe8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B08EB952-DA71-11EE-9789-25B3960A682E-77302942!pb-smtp2.pobox.com

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

> Yes, in the previous testcase we determined that template cannot set
> core.bare. Therefore, this testcase would be like testing
> --bare/--no-bare option, which is already done in 0001-init.sh and
> t5601-clone.sh. However, I don't have strong opinion on this. I can add
> it back if you think it is worth it.

I was merely trying to make sure that I understood your motivation
behind the change, which was described at the end of the commit log
message, i.e. "... and remove one redundant testcase.".

Thanks.
