Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED528E2E
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605554; cv=none; b=EswvozoDzX/IhydomHQ4Wg83j+CfA2ge+wDqx6hpMhBT98mazrXkXqEYrqdmj6QBqU6dr6SMnSiYff4tvd3P9BWpaeTR0uMEA6UQGWDmYLF0cGemPE560R3MYIAB70KGNMyUDmF42pqyEvy3V7yiohGqaLSBjnLpINwwSRRRAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605554; c=relaxed/simple;
	bh=ON98vn4IuCQ+cNwMljpv7qxBmXFY/i1m8yuINfcLTAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RG5zEmU+iWc1O0hLb23S0idzWZda49WR54Cu97fZJbYEVo9EOsMR7ZxcfEIZNKKmvNjB8MVGA17ikn9Rf9T0eSNCcaZDLVCBqok5dw8G8QeHMDdcYifPplZ0QuOJ98pronp7KITZwWFheSh75L79nG+uy1qblE7plX1ZSQyF3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bre6wnuz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bre6wnuz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B81751CBFA6;
	Thu, 18 Jan 2024 14:19:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ON98vn4IuCQ+cNwMljpv7qxBmXFY/i1m8yuINf
	cLTAM=; b=Bre6wnuzuWqIfbEYHN/MUH3Dj/zpph3j/5VNu1eg+X2RgzmZcEBgQx
	sT4KFZRHm9xa1kMvjHK7xwT+cDJih3XYNxyrc3IhnGfFSylG1Jwi124fylx7tmzV
	jCYrrzNihGcY5d7TOCylrkFK7mVsMqVgBJd6SSaFhd1pJj/j5U2zo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B057A1CBFA5;
	Thu, 18 Jan 2024 14:19:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DB101CBFA4;
	Thu, 18 Jan 2024 14:19:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] builtin/show-ref: treat directory directory as
 non-existing in --exists
In-Reply-To: <87le8nqc73.fsf@iotcl.com> (Toon Claes's message of "Thu, 18 Jan
	2024 09:24:56 +0100")
References: <20240110141559.387815-1-toon@iotcl.com>
	<20240110141559.387815-2-toon@iotcl.com>
	<CAPig+cTRHHJ3pzWJtVJf8rKhvAJFYqrO0JsyTRTi6T5s+gznDg@mail.gmail.com>
	<874jflfc26.fsf@iotcl.com> <ZadzwA6vNnRPbKYh@tanuki>
	<xmqqmst3tv7j.fsf@gitster.g> <87le8nqc73.fsf@iotcl.com>
Date: Thu, 18 Jan 2024 11:19:09 -0800
Message-ID: <xmqqsf2uqwk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 75878708-B636-11EE-8CAF-25B3960A682E-77302942!pb-smtp2.pobox.com

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Yup.  The patch looks good.  Here is what I tentatively queued.
>>
>> ----- >8 -----
>> From: Toon Claes <toon@iotcl.com>
>> Date: Wed, 10 Jan 2024 15:15:59 +0100
>> Subject: [PATCH] builtin/show-ref: treat directory directory as non-existing
>>  in --exists
>
> You have a duplicate "directory" here.

Yikes.  I did notice a breakage in somebody's mailer that inserted a
SP after the first dash in "--exists" and fixed it, but did not
notice you had "directory" duplicated there.  Thanks for noticing.

Amended.  Let's merge it down to 'next'.

Thanks.
