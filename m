Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69655145A1F
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717230; cv=none; b=XMPHRwuvcxrHcrJkoSuqN4OspCLLfpBZpy5TDzFj5fhg7schAWlTZ3TV6ZTRuG0LjsrL6okxOotpM3str/O5mutwQua235D3fgHmUKNs8aWMTjJvICqO1CBB+9YiS184ACzO7UhINXNg4jU2g7d6v1WGODU27PalLzL6M0yzDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717230; c=relaxed/simple;
	bh=tr+gWI1AwwNBelU5yny5LxZ7qzmKcD/xfnEFRDGKqtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h2ND5hK5JqMWOH0gMFOHRr3Z1Od9hPR//VlA/lXgGlXWdLzBgDMg0qXEJbYExo014GYWTBT2wd5ti5hdEXbjI3j4PnZ6EWy3Dzbpi59/Gp0WjIP7urhuBMdPQA6GvGf0boOBlsl8je+Hn0FXKZcnZfq1DNZC4YuX8sZ/k0tXW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bltBPLUx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sh+Xq2AA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bltBPLUx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sh+Xq2AA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BEA1FEC1192;
	Mon, 28 Jul 2025 11:40:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 28 Jul 2025 11:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753717227; x=1753803627; bh=ZcyQItXxyy
	qRcyKZ+wGXSDepmFELyHFdjeTjQaZZFo8=; b=bltBPLUxGLz2EGcU1zmRaBtxHZ
	+cp204Wd74IM15FyoH51eC02z3uXNq0iDu9Li3/0gAmpRyNRUsWePXy8ps6F023x
	6xiaX5CULhMHk/dqjxQmBVKIlKrZJTPaiPP/wsVEtcr3h329kV07jIRmpkaf0pWs
	hbnOp81FFLbznu+snsCt33kY+852pxHMg0afLZCdz+FjBCXw8z7SkuTvfXuW4K45
	oETib2jw4xzZaXRdx/DcRU70g2o6Hicj2i6H7zJ6kNM6LLV4LOCAWZ4rIfU3Tyhv
	Ol26oRAomuZblxn8HqqyFP5Aj/cfySW84UyFZDPRqhlPCfrt6gnDCeDujOOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753717227; x=1753803627; bh=ZcyQItXxyyqRcyKZ+wGXSDepmFELyHFdjeT
	jQaZZFo8=; b=Sh+Xq2AANZFj4WcyVZD56uIjfoK+olX1wXSk/BsMB7+bHtBnbzO
	5YRb0mkmGw/dTfkWaIURSzcwKSutzJJyYIbVK3FSITFw9RHAHApe2FLot0hz85yW
	v/DJYVHE759aTao/dETtu3CnxfIElho9buJoXbOfmXpUJLkjXPsTmPpMUfhLyLGL
	OIxxFn/TU4qDZw2VSLOANoNyS6sRXX74YoP0bxaWXX92DSE8z4WC5lRTy/yB/aPv
	R7EWx+HFpEZNQ9OqdKnE20evPrnHMHPvdxsaXPj7UE+5gmpP+FCEjAwZX9tIEpr8
	8JcgnQzu2ZgnxkW4BYdTDWkZjunoimGZxUQ==
X-ME-Sender: <xms:65mHaJl-DVL1t4TpHQ6jQB2sIj1UK1b1TNgta0deYmXeMes9hJvK7w>
    <xme:65mHaPZqcuCqPd3RWGsBwbyaL44em62ohuqaM6ecPuOX9pBkrMp_2u3IfDiWM-wyT
    5ENJgO5CuiETPzPyQ>
X-ME-Received: <xmr:65mHaMOcuCTZE3u2HDPNFIfoTQq7_Vx_RRRyMzQBvFlrylDqiFmtmCsP1k0nh3ZvKMS4CgVqoCJQXllf77kOPowBvAmB2t5i0HlL6H0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohephhgrnhihrg
    hnghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:65mHaMYmd8rVoPsmYyZRNXpVlWOLBznSHdZ6USUh-DrCLcn6012bSQ>
    <xmx:65mHaC20rwJ9PBf9hgqrJU3-Heg0_PL7gfBO6toFvMS7kVXIl42wDw>
    <xmx:65mHaKc4F6h7U0RJvTZB-FLMrZ2nwmYNAH0Yshwck-e7YKRUlcfiKA>
    <xmx:65mHaLEP6pW3IGcGLNI5nkW-ThS9W1h6e8OcGgrWBk2IFoSoh74Pnw>
    <xmx:65mHaOx-JTbWnKiUYcexcIZS2MShSS2WC0rayGnChkj4b70xCsHZu51n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:40:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Han Young <hanyang.tony@bytedance.com>,  git@vger.kernel.org
Subject: Re: [PATCH] blame: remove parameter detailed in get_commit_info()
In-Reply-To: <aIcSYs7LxkJeRA-9@pks.im> (Patrick Steinhardt's message of "Mon,
	28 Jul 2025 08:02:10 +0200")
References: <20250728035548.94277-1-hanyang.tony@bytedance.com>
	<aIcSYs7LxkJeRA-9@pks.im>
Date: Mon, 28 Jul 2025 08:40:25 -0700
Message-ID: <xmqq4iuwxr12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jul 28, 2025 at 11:55:48AM +0800, Han Young wrote:
>> The get_commit_info() function accepts a parameter that can be used to
>> stop the commit parsing early.
>> However, none of the callers use this feature, and testing proved that
>> the performance gain of stopping parsing early is negligible.

Is it negligible but measurable, or negligible and unmeasurable?

> Funny enough it doesn't seem like the `detailed` field was ever used.
> `get_commit_info()` was introduced all the way back in cee7f245dca
> (git-pickaxe: blame rewritten., 2006-10-19), and even back then all
> callers passed `1` as the `detailed` parameter.
>
> So this patch looks obviously correct to me, thanks!

I am all for simplifying.  It is great to see us lose more lines.

Thanks.
