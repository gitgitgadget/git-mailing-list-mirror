Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E834204E
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799600; cv=none; b=D9zXgMu4KXCiyH8fPzq4929aF6Yf/LYXDvcwlothtrRXj4veOBHU2xfi4OqoJL/6RB3WYq4g45r/CFKVz9gUs/nboKzsKjWpl63Q0XTz3ZSa2q7vkJEwEZbRIMvuUY2wSUpUNW7hZ82nY6PJV4IaalsU4XojqQLnlkVTVTC/Sg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799600; c=relaxed/simple;
	bh=tJyGmJibJOJsmVOfh1jtQlSHAxPX08eELkCvg0fpEUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZVArPaAYS8VQFBLi3phI3719/Ql3JTqgQBCN/zDDYvrr+3uSsBH4t9jtzEnChjx+UrN2reLLyk4mMZrVotWKyKU/9oLZIrKQkgnEsuCVYvWqwobrqki+OMsiSd/RNYjxkarGCExYCLro9OENTbwONvUUyRqMfUh/u7Q5Kw25378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i9HzwQFc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kXlq2vSo; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i9HzwQFc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kXlq2vSo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE21A14000D4;
	Mon, 10 Nov 2025 13:33:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 10 Nov 2025 13:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762799596; x=1762885996; bh=vWu4bTkC+d
	TK5yNFoheuZIygQxJt+b/1KjzH8Iq+pi8=; b=i9HzwQFcVvJZlOsJUvTZExh2df
	6pUkMuK+S0ryL+ZwiYmJwjE7QxnDAO3e6E1nuv6VV0Ru/EHnK9Y/u/g9EJf4X0Qt
	gUUzWC53Te69A+FP4fiCldJh6nJ+HApT7VhBwbfIZIxFhOacqb+VaPZBLyUkC1iK
	do+zjQCnuNs0G/MPvJCKhGWKY99XAB6KMtgvnQuaoPtY2XOXMIMcEfZp7hTylwnn
	RjA4/vKhNRwFvmOoY5Q/TtqybNFD7NeuxyzVtA791uONEnTxOyxENfrVKMWfqq1u
	LSLLDltyLPQ2BiK3lB/cTP5uJPLH96O5KcM5s2/KIqSmLujMBOYQXn8JPSfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762799596; x=1762885996; bh=vWu4bTkC+dTK5yNFoheuZIygQxJt+b/1Kjz
	H8Iq+pi8=; b=kXlq2vSo2MIQ85JftVlP5iTSiwwhETOUlEqhZN0gU/wd1fc3Tb1
	gpfyvjlrdAGuJ8D0L6xHJFodhWkPmJdfv9lb3ozeO6PPIc8DMKvKN8FAAQqSSNnr
	E0em9yxVlT9+SGV/NQI66u1OsZTZZBp0HX2aH+VgM6lURmOYuKFT9z1cA230vSEM
	jZDikQy1Ot3SVJl2+Ha5atNW27po+qNhc0nbcUGynnK5O97NnCiPpPX+vKf8+5mZ
	EOpEuaGyk11HQxRiygQsCnkGjuiVmsMbvfg1cj2dmB7nuy61m+nz7Sd4/Bp76hjs
	tSJ7SLlFisc+L7NBG+Dm+GeCj7PDUr4ZlUQ==
X-ME-Sender: <xms:7C8SaYwC7PSvV1S0EHcjpKJTiOWiHCnWWMjKbdPxWVAr_xJL9VRuXQ>
    <xme:7C8SaTSeBXeflZl4d53gF0UraXYiewLf_G4KP-qBVrpSsW-UYHMLXLjF98nFaZDk8
    -eLoUcsTdmeN3tqswvwq01u4YR3ioUu-FpHUp6l5orfayiKT5W0ug>
X-ME-Received: <xmr:7C8SafUhYRf9O9X4msaDSjfBuGyk0H9Ife4pgPzi8KPsAoNliXBiA3Ny8HjE9LFX3bJpLf6-LYT-Wcal3R487_-vtwCMDWysSaJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:7C8SaVah2dXeBA0rUDkwMNYBgNc85AwbpJkobjjWPGppQw60-GRnLQ>
    <xmx:7C8SaV0rJpH9WBdRitiXUmKMR4jAAbaHAJW3wJk339SYiXwHT_2Ksg>
    <xmx:7C8SaXhSiAbaqT8ypORAEOLIETHV2XWR5izEiBiORSmQ1HrcsjSEiQ>
    <xmx:7C8SaZYAruA4ERCziNIhv15Z9hgto5cMiJ8SNP6mBbp8q5yc70w7DA>
    <xmx:7C8SaW1s8eR5za8c9pn9LHGR3f8YKtau-JHwWRUJnMqFpljcoopAgTaa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 13:33:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 07/12] diff: update the way rewrite diff handles
 incomplete lines
In-Reply-To: <0b0181af-e63d-4e5a-9e3c-822f866df88d@gmail.com> (Phillip Wood's
	message of "Mon, 10 Nov 2025 14:54:45 +0000")
References: <20251104020928.582199-1-gitster@pobox.com>
	<20251104020928.582199-8-gitster@pobox.com>
	<0b0181af-e63d-4e5a-9e3c-822f866df88d@gmail.com>
Date: Mon, 10 Nov 2025 10:33:14 -0800
Message-ID: <xmqqfral20wl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   		endp = memchr(data, '\n', size);
>>   		len = endp ? (endp - data + 1) : size;
>> +		plen = len;
>> +
>> +		if (!endp) {
>> +			plen = len + 1;
>> +			pdata = xmalloc(plen + 2);
>> +			memcpy(pdata, data, len);
>> +			pdata[len] = '\n';
>> +			pdata[len + 1] = '\0';
>> +		}
>
> I think it would be clearer to refactor this as
>
>   		endp = memchr(data, '\n', size);
> -		len = endp ? (endp - data + 1) : size;
> 		if (endp) {
> 			len = endp - data + 1;
> 			plen = len;
> 		} else {
> 			len = size;
> +			plen = len + 1;
> +			pdata = xmalloc(plen + 2);
> +			memcpy(pdata, data, len);
> +			pdata[len] = '\n';
> +			pdata[len + 1] = '\0';
> +		}

Perhaps.  I'll try and see if I agree.

Thanks.
