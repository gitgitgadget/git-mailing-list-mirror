Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0716CA23
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626233; cv=none; b=i2GN+MNLnb6rYLawc/Q+Fi48AdzxYQ2s1knnLEpQIBXK7QjMZPLdGiK1PbO/+8j68PtUrNoSCyD66KtQQ4/FcPYr0q8fMQTkvZW3Hih19l56eR2DkhrBjjdSNvtceKePqDyqDYqiMb5GaJIqU0N3sJEY+pYBq9l72WeDVlbFKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626233; c=relaxed/simple;
	bh=h0awISYWaYDa4hJkNA8LAtnhqVvkU2v07WBsVQ+0UJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oqJ2O7Bs8mz7EVtyzYJF2HvT4xSB8IsnfRkpWaesWP9cRj6l4Qu6sLMZy5bsBD/Otmal1YQXQtpTprzr6J3ActMevNHa7DPIGy1LUWiTL/sNmyq+c4ePBK+1JEd5AU+A2cX9NtVQI9u3tK9xacP6yRO6KVEKmcr586fvKmbaJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tqGYWc3n; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tqGYWc3n"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 54D0D19F84;
	Thu, 18 Jan 2024 20:03:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h0awISYWaYDa4hJkNA8LAtnhqVvkU2v07WBsVQ
	+0UJ8=; b=tqGYWc3nk4Q8gmRn82KwUbrjFls/ylFTq5OP0rSniwqVSIPwEsrSK9
	GJnIC4F98lSFS5w57tQmIKXpqXAFuGQFt7Omby5PXVcY1L5nkgEftqDSBMD085fL
	pW4UFKAnDA9Qu9/ZVZ1onNmUCGFm9ITK8+bMRbaATRe/w9nSEQaaY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CA9819F83;
	Thu, 18 Jan 2024 20:03:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D469919F81;
	Thu, 18 Jan 2024 20:03:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 07/10] trailer: spread usage of "trailer_block" language
In-Reply-To: <9183990583f9a591c79301a20fa327462bb50cf9.1704869487.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 10 Jan 2024 06:51:23
	+0000")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<9183990583f9a591c79301a20fa327462bb50cf9.1704869487.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 17:03:46 -0800
Message-ID: <xmqqttnam8wd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 99D524C8-B666-11EE-AC95-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Deprecate the "trailer_info" struct name and replace it with
> "trailer_block". The main reason is to help readability, because
> "trailer_info" on the surface sounds like it's about a single trailer
> when in reality it is a collection of contiguous lines, at least 25% of
> which are trailers.

Together with the introduction of trailer_block_{start,end}()
accessor functions in the previous step, this sounds like the right
thing to do.

"info" is a word with so low information contents.  At least "block"
would hint that we are talking about a block of text that makes up
the trailer attached to a single commit.

