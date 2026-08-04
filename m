Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DDB429818
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877482; cv=none; b=CIDpsckR4nziHKmNKzY8Jp0VV5TTB7WmA3rfd4vnbmMVWVyT4lUmN2Hg0aigHUsngKwu2Z7QuRVRs0WIkpzQ6VCWs0YZQmv96s6XHbAcMKAEyhOA6OFhzdUUnIh+F5L68BAGnlYqTUFqlof2bMKiBLvXDi9bH+xPKCubY+1ywbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877482; c=relaxed/simple;
	bh=YPHS73QDtfx9XGagtJ65gwrgwSI3QQweRHJvRSyO8zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I/CR2/DyOq9IAVK92Etw1ymy9dvHnVbQU8wWWlB2d0c5XI+5yoAOXzYe558GfzArpWh0r+jb6zArC3hHqzVoRLfGS/NQTmkSLB2kugnXhmhLfMY5hGJ4xwGpdyaLokPrSMcwyMfjTxl0YVTek3jhkOCGnQXvt9IP+z8f+/BOfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QU1ecbGH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=enux/LGS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QU1ecbGH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="enux/LGS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 999AA14000EE;
	Tue,  4 Aug 2026 17:04:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 04 Aug 2026 17:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785877478; x=1785963878; bh=qyTX/rXiBG
	XT8uUbuhgkS74bAFclH1SSz4Iyz7QKEus=; b=QU1ecbGHxMqQuXgPl4GXFx2wUl
	neiGKMB7uFMFuwGjaikSwOAyXtxGvQfaRVMzs3rsIu5eodVpXbbh4HUPJFj+mKWo
	6BhAt1yV9qCdmmdPJlPBKPdiUaDA0CKD97QAf9ror+Yt2K7fED+UDicuRVS5rhbo
	nOHZ1CcKAANk6yO4l1JLKiLb9jav69iOATB716qIkIAWO1bt8G3vUUSde/cs226T
	cXCAto+bJucn7Wwa3RM+dczvvzJI5ngwXs00IifAqTqh+5RVDsGJAsrjNnHal+Ns
	3BeDLRmCaQiWtqcuTsB35YXLVwqUb4YzSO98qygOgYr3moIBE1MrwGPnfFug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785877478; x=1785963878; bh=qyTX/rXiBGXT8uUbuhgkS74bAFclH1SSz4I
	yz7QKEus=; b=enux/LGSoq3vvn+PRhMW2fgwHNxhDGXBZFfmhWHHh8C6AXjvwvI
	WJu7JvK1ubPXVDvjkymH56c5SSHDl1ClK7SKHYrc0RNSLkRuNl/+aR0GLaLqxyM7
	43Tek+mXYXxELkF0wq30gOGHRe81LtF7l8Y6r+ZoI5AZWascJ2/QGG+5D3EwCARA
	SX4DmZUcmzKTeOeMPncuoOO3YomnD5tvRLWN/hwM7Xpymf/nD+KoIMkMkMkLQ+2R
	x5XiweJAIuWx0aD70wsq5nJugRgM9TmFpgQe8tBXLvq3vsqTpY8MVxGn8wFn2Hpx
	ij+oncqZXwHWdJfabzQKPOMWhUcohnaRTUw==
X-ME-Sender: <xms:5lNyataALQ9YXgKm0fe5ZIXR9YBuslnNbeb2vFr9B7y3rWx2vUohSw>
    <xme:5lNyamojNrBKDn6MR1dK5kWSCDZ6DSF6LN1tzEnPaxqKgtEbl4taovRt7Az0OZa4O
    wRk2wdpxCwpY02g2qeuY84mLmyJLJBFgLh9SCtR6p3qQYundI8GWA>
X-ME-Received: <xmr:5lNyaiMs2ieFrGO5vARc20bqk6mBkL4trEvREn0av6yBYtaVU-6nJBtWmqAiS8Hw62UDIXSFEJzHe4PDs-Es6A-TKFz5gGYoGA>
X-ME-Proxy-Cause: dmFkZTF+OAr3V/pDUkxUV0BYUNp7la13/FaywWy1YRovURY1JKGA4PEBgLRsJ3OTNw5j8x
    NcERmTlw6isIcrYjkpXfq2IhjvhQmUd3CgDl0ooErklXFJYna7ThcS1qLV9CrXgFfVl1UP
    d74eIWXxVu5ZEVeKcwn0fOMUltYG+fvKwX/7sLZ64QNM5zBRQYuCTTz1aJgbHsFl4fjNB9
    +pFnV2wKLcPrPF5TP6/3i1y5Cz8PAiNKBXcCN0qwXeaWaCarb/Y519rTfIHk8/AYRoTHoF
    zf4kCrbHCJ7APDK5RmDhcARwz/4HtYC85SK5XK3d4LQbuauSjX6ef5yWWToAYgmQjYm+oG
    ceSpOhaKEXFuPDmsPOtVyjTpqnfaAx30u+6j2wVIagUl+AdIhzwPs60+sMYUV+7J2NvOAD
    rbkFYE0/dU/Dtm8A1f8VURo9NMzvykxryl12ocAqqBYvU1PA1KWy1rawFYWXgeYxvc1/VQ
    cLTmv6Xj+AaXEergHJC5Rx9b7vosdreqzdM9zebWJlY8reQfpy25VLpedE0ru0VPC9/vV+
    ML/cNn9/AZQ3Y02y5xPyFjB3PxrASLTystC6UM2kwa4ebEEPDZ81RY4cpe8dn2Tbzfp7uD
    lyN0AKjOIlm8lN5aFKEQlV/I2a6mQH1OrbZVBe8R+rZlMGOA4Ij+gPVMMouQ
X-ME-Proxy: <xmx:5lNyahqrf5TPLFNEtUdgK26WltP48gKfsaYwstGthn6jOcKeXBazwg>
    <xmx:5lNyancKwn0bjZNWVhCSLfQ_Ri532_yZ-v23TIW0n6os2nbuBVFPdQ>
    <xmx:5lNyanS-BgtVWmE3A_6LIWQ4gD67QKKklaJR4qxfNROkOW_2xk2Txg>
    <xmx:5lNyagarxV8zWJz3Vtl1cgHW4zeegmSyEPinojGb0wVTwGuZwOkNaQ>
    <xmx:5lNyapWg1XhnkQQrLbk3FlnR_w9Dp7hKPASoPxpTFiGOSopDoQnfaz6B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 17:04:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v24 0/7] branch: delete-merged
In-Reply-To: <0ea7bbec-3381-4bc6-99a9-2c3b5d1bfebd@gmail.com> (Phillip Wood's
	message of "Tue, 4 Aug 2026 16:58:16 +0100")
References: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
	<pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
	<0ea7bbec-3381-4bc6-99a9-2c3b5d1bfebd@gmail.com>
Date: Tue, 04 Aug 2026 14:04:36 -0700
Message-ID: <xmqqcxvxtx5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> As far as I can see, from here ...
>
>>       @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
>...
>>       ++	strbuf_release(&key);
>>        +}
>
> ... to here pretty much takes us back to V19 with the difference that we 
> only prune protected branches from the deleteable set after we've 
> visited all the branches - looks good.
>
>>        +static int branch_pushes_to_upstream(struct branch *branch,
>>        +				     const char *upstream)
>>        +{
>>        +	struct remote *remote = remote_get(remote_for_branch(branch, NULL));
>>       ++	char *push_refname = NULL;
>>        +	char *tracking = NULL;
>>        +	int ret = 0;
>>        +
>>       -+	if (remote)
>>       -+		tracking = apply_refspecs(&remote->fetch, branch->refname);
>>       ++	if (!remote)
>>       ++		return 0;
>>       ++	if (remote->push.nr)
>>       ++		push_refname = apply_refspecs(&remote->push, branch->refname);
>>       ++	else
>>       ++		push_refname = xstrdup(branch->refname);
>>       ++	if (push_refname)
>>       ++		tracking = apply_refspecs(&remote->fetch, push_refname);
>>        +	if (tracking && !strcmp(tracking, upstream))
>>        +		ret = 1;
>>       ++	free(push_refname);>        +	free(tracking);
>>        +	return ret;
>>        +}
>
> This looks good now - we map the branch name with the push refspec if 
> there is one and then with the fetch refspec.
>
> The test changes below look good as well.

OK.

I'd mark the topic as "expecting a (hopefully small and final)
reroll", perhaps.

Thanks.
