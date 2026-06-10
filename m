Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A56307AF0
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130611; cv=none; b=P+S/urzOYW7hOSD5x+UvvdoYj3J708JrFTsfQM3G2DabNtibO+roYlnPYNaBMjfPqPx2k3IPfrR8ndDUS/ocXh6REhNEHsFIcKWLLyCmWTzqT76vApyCPlkO8/GFKkV1h7NeMGIzeCX9LFMcY6DklgcJZbp9h0Y4DN7xiTMb/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130611; c=relaxed/simple;
	bh=AzBb/gNbeUEdaorIqU3OLzNrfOm2LFJmHQNQQJ6hlZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rcnOMkZlJtULsKg8kTPtQgvZWmLDSilyHKtToj/oMOxPslYXfEZadNAj4L/MuDo19MDNkz/ZGC1C49huMk18QvkKwqyQplVgqEM0mjSNgHc/zzhQoNsKh/cZbHYEGnZSmbzLCgV3Rb6yQZQdojY+TTvglO5JxmIqmPXRnXPnv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DYOZk+zt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NfmphBDi; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DYOZk+zt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfmphBDi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A8DDEC012D;
	Wed, 10 Jun 2026 18:30:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 18:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781130609; x=1781217009; bh=QDRDkp+5aU
	0rw5mD6c/hWVjVSDU4++3eeW2J+ZDtsRo=; b=DYOZk+zt1y8Xm2+gpQmWrL1tn5
	/eyEMQNJV9DC7K31MCR/XibBV8NZVEIY9ZqRijwmvhYXfPylavKsw3WMt3LAItDy
	0kEE7Xqv8Vv0JJJAgjueW6xWsaGxmgyqZp0ZkmID1kaQQ8YCXfGKV+KL3d5VKjjW
	1xReu4pP+ddU1WX8HmYLOD4JG6A8bimdNzXRWzI42D+ecZtlb+DUS39jmFaIVon1
	itV0A/i2l9r/BqoLUOnwmI0DNV+zNrrxwq8icnbijXqCCRM/gQlKuB1mcKuCwmEz
	WhIhe8pWJZ7LvRt6DOnZJc3r++mPpuUxPCfqHUaNcSRMmsiS7IuW6sm1+zkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781130609; x=1781217009; bh=QDRDkp+5aU0rw5mD6c/hWVjVSDU4++3eeW2
	J+ZDtsRo=; b=NfmphBDiI/vinJT7/4lvdgM3LjYWgenYDT+MnZCBao7UlaCYU6V
	D7UhVD+jzGDNvLMYgZyYCyYzPss/pfqL13+nru1v/aONxCYo21iOYuw+Qg4qmnal
	0E3Mnf//03+etPxixOplTk3/10y1eOFW90OmuXtK4A2FesypLgytEOA0XFbbwhkb
	pNoUupFW41ws2EiYXexE+bkf8Fv6jx89LRJyrk4sZF08cSF1bDPafLVhE4vXwOd4
	8O3qFSY56c1DhYk59Ay7R8ntAlGoUqhjJP0c8gGSGbcqsi1e+3vcBu+Q2dTgGQb8
	/zTxt5ZyJjwGByjHGxX3nQDTgVFz87OUIvQ==
X-ME-Sender: <xms:ceUpakJp3GRmmPVFi1IfBYjh2uVAeIDpCoFVhGc8BvO3h0eSaJ3yFQ>
    <xme:ceUparLdcKAh8v7IRMf2nCdxV4t60MJqsN6DduFqwf25wTIIuErny9DAkPAHjb8p8
    5W5tlOLKOvih07rCsTKYFetm0bLqLHXNkgOKLwcOn-W_F0qyj92HAo>
X-ME-Received: <xmr:ceUpaptePuG8fFvwMeYlYmHPOhVdeu-I-DhLrTZbp9Ss8szD-AAq6poI1XdsimYQSgCvmbVyzav68y5Riot3QivzMJgQqgvlySU7>
X-ME-Proxy-Cause: dmFkZTE5eZpAPPT3A6FAtXXtmZbiBihqjK69CN7JJadMccmrEPMGiYWlxeSq/iL71ohNkC
    h29hpkRQFFMCZAI6/nKA8Y+QvPAyuD/dPACLf9NLdsudgxd2pEt0ceT54FHxheytuP+O8V
    uw6cGx39aBUUgZ8hqV6pj5szQGvGAUIA12rvcURQTu6qE7iFMsMvh3kbLTOpdcO4Ic5Imt
    T7lcflzgvYuH6B+q+OBWtAAI1JgBZ2KfLq4W6x5KBc/37CiWUw2MwQgbSGhfrOri346Z9I
    WTPkd9MwW8nA948/wAw0pLG00OmMCVxfF88o83viP+fFsUBP1d/+c8gfHjd4ch5kJ+aha3
    4+g0rzi3zelVsWC9U6IbxxA5+qkatwf3cBaAtNquv+uNEZoevx8XMazCYCzPmCAFnfyVAY
    9c/zmwNpT5/rot5vmnbjR3TkCOkku2T5fYdd/7KKpsd0fNK8OXfiVE4KjjBEVFZPGbvBle
    fLeo3W652TTk02MdNEd1NofXq4ft+1mssa+qUKDkDHY+XtrzRm37mWbE1qAPxHrDheVkN8
    HwOOx8aZrpQHNYZww/UgCMrsV5zcCbDxDDfuXQ7LCUzpSkwaM2Cv6uEHMDkVdxqPaTrXyo
    JODOFVKHN30oaFVZk4I4C49sB7Ad8/8/ll2nbjZHrVa5N8tYUbQgcl5tdJ1g
X-ME-Proxy: <xmx:ceUpagSYkWp9qW8eYDmn7zjlslAMqPMOV3g3BdsK5TlvHbeg4UaVJg>
    <xmx:ceUpanOHgnfY4GJ4qAKo6duCgbr-FIGPbiy1Nc4WNky1bxu-wfxHog>
    <xmx:ceUpatZL3w6_E_DYtnYSnTmc8TU7LVtUnghkRsaw0oxOPUv6muokqQ>
    <xmx:ceUpapyhaPhjug-ZwirT8alYcQmSr-5soydA5ft-lVwJ3VuYzSyOUg>
    <xmx:ceUpaoU8LuGpHMrMtkQrvnXxoSAYSt63gMMRwoRxuvAqcjLdQSN7djQj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:30:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 6/6] SubmittingPatches: note that trailer order matters
In-Reply-To: <trailer_order_matters.8f9@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 11 Jun 2026
	00:22:49 +0200")
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
	<trailer_order_matters.8f9@msgid.xyz>
Date: Wed, 10 Jun 2026 15:30:07 -0700
Message-ID: <xmqq8q8mt4eo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> It matters where you put the s-o-b; it should be last. You are signing
> off on the patch as well as the whole message up to that point.
>
> This also makes it clear who added what:
>
>     Acked-by: The Reviewer <r@example.org>
>     Signed-off-by: The Contributor <c@example.org>
>     Acked-by: The (Late) Reviewer <late@example.org>
>     Signed-off-by: The Maintainer <m@example.org>
>
> The the first ack was added by the contributor and the second one was
> added by the maintainer.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/SubmittingPatches | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 3d2e9ecfbb8..2045708bdf5 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -490,6 +490,11 @@ particular are not used in this project.
>  Only capitalize the very first letter of the trailer, i.e. favor
>  `Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-By:`.
>  
> +Note that these trailers should come before your `Signed-off-by:`
> +trailer. You are signing off to the patch as well as the message. This
> +also makes it clear who added trailers when multiple people have signed
> +off on a patch.

Perhaps first mention the underlying rule that they are added in the
order that helps us to understand the chronological order of events.
That would avoid giving a wrong impression that the nature of each
trailer keys determine the order of these lines.

Thanks.
