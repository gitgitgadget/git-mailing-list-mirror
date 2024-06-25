Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52AF149C6E
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719355409; cv=none; b=TwqL9jJt0H5OTArD7zizRJN0maB7qDlh6eluvD5l1hoE5ZQHAkGZDpjpNZJafFF+4n1TFbcAmM10v3JmYRmbZgCrKi5vv+vCRl8H0K+1RIZUF4NqAernHmwo5GsjCprsmSaHfaVQleXkkjAWchWR/Ot4hPgo9NI70faEppMy6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719355409; c=relaxed/simple;
	bh=4yk33Etr1XJhFTIvIOCW6lbhoKx7mUYJWK8Jk3SgNvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mvLw44ul8HVShTYA9k4xPbLY/VeaYKvCG4Eo20AyJyjISkQbQYnsMVfQGHtCpiGWO2oGUVmbqwISpfqE2An6tbLUR+ickgCxk0JHoHNSDN9ljUGVdyhu9w3RqLnUUionJdCrHxfHvH7JCTDezMykm/PCG5J2e1M62yOL/1Q68eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KqLFQLJX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KqLFQLJX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60F762924A;
	Tue, 25 Jun 2024 18:43:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4yk33Etr1XJhFTIvIOCW6lbhoKx7mUYJWK8Jk3
	SgNvI=; b=KqLFQLJXR409vvN8esacHK19fORp3MWrYXyx/h5PFKRWQFLEf0Fxbs
	l0kE58Xpg3/Hb454hyjenGkBXcRB2jg2kdH2AyehyYTZTWMF9B2xwbZHpA/Pqe89
	CMauMoT/KsT4RnkoBRK2aTqyBukNAJa5vdqyxBfxvXX1xJn1FkXyo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5822329249;
	Tue, 25 Jun 2024 18:43:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C812D29248;
	Tue, 25 Jun 2024 18:43:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Tom Scogland
 <scogland1@llnl.gov>,  Tom
 Scogland via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] archive: document that --add-virtual-file takes full path
In-Reply-To: <xmqq5xubfjuu.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Fri, 14 Jun 2024 11:40:57 -0700")
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
	<pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
	<bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
	<95B94723-BCBF-48B4-A02C-A5C61FB060DA@llnl.gov>
	<01b21870-b37e-47fe-9bd7-225499ae5eaf@web.de>
	<xmqqh6dvflea.fsf@gitster.g> <xmqq5xubfjuu.fsf_-_@gitster.g>
Date: Tue, 25 Jun 2024 15:43:18 -0700
Message-ID: <xmqq8qys7iex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5200D81C-3344-11EF-8811-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> It has been a few weeks since this discussion stalled.  Let me make
>> an executive decision on the direction here---let's keep the behaviour
>> and align the documentation so that we won't break existing users.
>>
>> Thanks.
>
> So here is to re-ignite the discussion.
>
> ----- >8 -----
> Subject: [PATCH] archive: document that --add-virtual-file takes full path

And it seems that nobody is interested in the topic all that much
anymore?

I've read the updated text once again, and didn't see anything
glaringly wrong, so I'll mark it for 'next'.

Thanks.
