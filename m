Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F794354ADF
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736591; cv=none; b=DlNTBoRPtC6bFUAe9FiA5sP3vKScsjal671RNiuyrxs4B2WXwj807HpCZANXhTZMcDefpRZytWon4DPFst76Br8KR+LcZzxfziT+M7v4D5kOPfJ8nT/oOi9dRe7NNCZSnLHG43cGl+4W37zpXz4l98jhRNlj3JwXu46HZCXcoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736591; c=relaxed/simple;
	bh=+G/+Chh7/503VBd0wZlcRwb3gmn+xRG/2vccSyw7Jk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=crgkK3fKXUPC926d0XJkyefotAzKLHXPh8owWPm8VUR8omIpET6hB52TVzAPafme27LHh+l8ANiMNwxXl8mphooVhrv51+bBgUgc0J6Or31pHrTfddS7FFDhAoKZJxg9MQhoD/dXUbJROUzfCWnxTPmWKQGX6IWI3VGUbf4Z4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IFTk5JeL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDQc8t8x; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IFTk5JeL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDQc8t8x"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6F187A0134;
	Fri, 17 Oct 2025 17:29:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 17:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760736588; x=1760822988; bh=XnBkFEepeb
	V1lmD+3vkMPCaX/2d/82JXiKyh/vdLkmI=; b=IFTk5JeL9x2Jp8vLPTFStjJDYo
	kWiCvhicyiWhA+xFlH0MNVaBtxqcLuEQqY7p639Hi6hwIJxJpZJ4rQ4+kYRr4rOG
	tEz8Es6YIEY6zaj10QksVsuHbhvQkmmpTJO4+cSWMy6tZBrv/dycvqj7/RAE7Xwj
	J5iBbY7O5zYRKXnEXKIj+8/6zhBeir3na7SKFCIR/V1QaYR0Uss1sSUyuHK92mlk
	HXuwpTwB9nkzWGAkCAtGVLATKS9MtVZmS4P0V8SJ0wf/kda3K/JbW8ZWf4NNxo+E
	XbsXQ9u0EPZc61hIycIZ0Db8yUqiRgQtU1C5ZKDBkzzxQHHB6poEmgY6U/Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760736588; x=1760822988; bh=XnBkFEepebV1lmD+3vkMPCaX/2d/82JXiKy
	h/vdLkmI=; b=jDQc8t8xgAVRMoo1uSx29WSdYjNsvDBKkt63I+vu/FzDXI+n0ne
	tGCJ7Xl2KWJzS5G8usodEMnAEpz3Q5wdKaRxFEUIHKO9CNS6wvNSs8fi/kKLPFDt
	svADftAUL/MTNwJ03rC65c4FQJ8p2QMpqTl7BrmGV5I2ZQzNSyGPBJfz1bfYxXYr
	fCnb7vAN4cP+7P2b2bFgnuCuJ4R0jIwrDd0TUyhD1rpow5Z5B5fWwXEchoWGIKUt
	+9vYVYCXQCm7eOE/VrIl6fzLhHvPqIdKGp/sLlmXmRLN0Y4a6UD2EHc4JpdcAbA0
	qidcpdlcZsaok2cGoT9X42mYv2cWBttHneg==
X-ME-Sender: <xms:TLXyaFIW9J5bijkITFi58ySkE8njoyhL5Yg6Y0i0BPOglcC92rHxfA>
    <xme:TLXyaIkkZVsDpWZfYRir1fwa3-iiZC_mlZKR5Nekqkv4lUtWkYbY9gAnVcSO-LDh_
    k_4cFtdQ-lpCNtOHsdJh3vMvYHXIZrOnqoklcktcwp_n0-PInMH4w>
X-ME-Received: <xmr:TLXyaLGsrXlthvby_rjzaNSZgGSwYRAf75Rfn86hL9yQKGqduSdfABGHvbhNT2LPwvm6xD4wnwEL79MOLXPHg-q8X0dqZJ0MfQ0P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvlhhohigv
    shhpsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TLXyaAEREHKN02VnFYQltEIPxNYPSXUaQXJEqc4H25c-SMs4yxCcFg>
    <xmx:TLXyaAOfa_WEAFKywFmA0CcHnfHf2m4vfb9liTOiRQo648ClJYaaKw>
    <xmx:TLXyaHHnBGtsJKFD0C9EUwPj5zW7AgETUr6iLQun29r2w9kv_KT2Dw>
    <xmx:TLXyaPMaBcFpx0-QLzHIl882TTas80VGPA_pE2vGuD-X90otRfbxCQ>
    <xmx:TLXyaAl0kQXOa5g2b-pxG1GL9PE135uI-DnZ02ItRNHMxz5RN4y0udF9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 17:29:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: El_Hoy <eloyesp@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Making git grep ignore binary the default
In-Reply-To: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
	(El Hoy's message of "Fri, 17 Oct 2025 12:00:27 -0300")
References: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
Date: Fri, 17 Oct 2025 14:29:46 -0700
Message-ID: <xmqqsefhxlmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

El_Hoy <eloyesp@gmail.com> writes:

> I've found that there is a flag (`git grep -I`) to ignore binary
> files, it works great, but I've found no way to make it the default.
>
> It would be great to have a config for this. This way a possible
> implementation implies:
>
> - Adding a config `grep.ignoreBinary` that defaults to false, keeping
> the current default.
>
> - Adding a flag `git grep --include-binary` to revert the default. But
> maybe the `-a, --text` flag already does that.
>
> Also, maybe the next git version (3.0) can default to ignore-binary as
> a better default.

I am tempted to suggest not to do any of the above.

Simply because we have never needed to do something similar to "-a"
and "-I" that we added in early 2006 for the past nearly 20 years.
Also because GNU does not have any such thing to force "-a" or "-I"
as default.  The biggest reason is that it would be surprising if
such a change does not break existing scripts that have been written
by people over the years.



