Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCB3CC9F9
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422452; cv=none; b=ccwe00stGDkFxRGdBn1jIQiwI8MadjspPMm0SGCe2Ipbi2GRrTBm916Z5GSfcKZjddgZvkYIyG3o1g7qto0jRce4QOGbQV/IwWaCKaksANGWnMe1tyUFplEuYHuVYyY6ucS/sN8qKkqgWjOCBN86zX+1dmpQxFmD8Rgrn/lRTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422452; c=relaxed/simple;
	bh=FJ06YzKv440cqxdLdjeCE5jK9blZ/FVsJo2B/lgXuwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iCg/BTrNEfkZNy3TeaolXo4l3P2KfB3og3xwZpY0d50RnvKPqBSAlM7fTF5XiG1iLWg0a7xgWJHX3kZAFTbYbL22UpilCpSbUOS3iadqHNolUtcWLCSuLdfpNVKSlxcFs0ugC+nCQKPmPS7FqRCS3n4wZinLVn5nNqY5o0TGJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IJ9JPC+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UeP7Odo0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IJ9JPC+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UeP7Odo0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 638EEEC0B63;
	Fri, 13 Mar 2026 13:20:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 13 Mar 2026 13:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773422450; x=1773508850; bh=kmDIN/pGfE
	8QpqMADOqYhWKslvaE5G8GNrcXVN397ns=; b=IJ9JPC+SlOjyg3InGbKcP4QXK4
	fOmxgjoHhFGcXY+N8yfifopvqqOlT+suBL7hGZP8Koq2gnfbIfiDrUKe5drtg75Z
	2OvxYSlUokvQ3vEyjAtebzeZ3QG1LlFX+78tDu3xcfwuqprZpg3hKUDgHM3UU+Kl
	jxPZNb2Wc9Gv3kJZhcPoozzJBHE+4vQ34ngxYxU6lXNeCfeV4fapJVx01Sqt0rAt
	7ktsP6TU9TOq/uo261FLBWzlXMX205epvf390BcIF8PuUxmqf0UmOLYByjcP06Sk
	HF12rgAasulhUxlAap2jQybstr2aSB6AkIKL/HenLTxBhuwh4Nn3IeTWizwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773422450; x=1773508850; bh=kmDIN/pGfE8QpqMADOqYhWKslvaE5G8GNrc
	XVN397ns=; b=UeP7Odo03RGVHv107jBq1RjMXId9YEJLcVtWzOsKckCahWhVZW+
	WCloj1Js8jGrKyAWObIGHH5D8sp8KzCK9N6pPjLD6OgARtw0lnANXlZCl64gTqZR
	rOLZNM0xpNtSZLVSf+aa3npT3nCeUsa/MaK8ERfBs/V+sSL/nZIkNxlVPrJFytv7
	4GfvSPVTxZH2OEJNWKOKBT7k8aSRRO/qDVlpTXw5HxgV9Xe/TvdKcyUH6s/AATzX
	jp13bK8sljm7jp8sBJOP2iMzLYTngY4gFQhJEESxH0c+iK8xMdgJKLEqWrY4TyLi
	LcNMB2vwjHdh0dLqNEilfHuPruGwHxLSrTw==
X-ME-Sender: <xms:cke0aVGTbbDJg8B5A--M_BzfWpRmRV6Hz5PkYxziqfhCr0l3EdGnFA>
    <xme:cke0aSzaceaBHf9G3SsTsR0xt7xaFGxE1xblXrctFz4Q0ilY8CuXURJhNa-XEXoQA
    lO4UZf4z7dLSZd1hTcLPpxwuFQUPJ4X8XeY2qjbWOA9ea2Ca09yNw>
X-ME-Received: <xmr:cke0aXnc-pS7CxJqNW9XV3wc_ddCyDxuqggPCW14mKNAVwv_OL0CFQYTx51M9TRKSBtIq3-Qs5PCZUmWYRUDJoXRsH-GZFET2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepsggvrhhtrdifvghsrghrghesghhoohhglhgv
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cke0ablk5mQ7ZEK4AvIQtdvvzKF6SfUR8r-B5TdOJRufmH7Iz0ZWXA>
    <xmx:cke0aZw3U8yCiooTbR3rRCIi6UrLmoarhb3vO72MZNCWbAlMd7byIQ>
    <xmx:cke0aQpMPV31QPZkDZodxmz0B6DdZNXV90GIVWsgdBa28jnaXTXuFg>
    <xmx:cke0aY5gcImAG_Ei9UCzyHbVSm4BAC76ENsml32olw-Fktvbyck18A>
    <xmx:cke0aU8NDLWTF00WONiMLXq48A1ZKOD3Q_pLKKl7yCS0_luUEJsFXmNm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 13:20:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 2/4] format-patch: add ability to use alt cover format
In-Reply-To: <1759c2fe-6e7a-41b6-9869-97544870ebef@gmail.com> (Phillip Wood's
	message of "Fri, 13 Mar 2026 10:38:05 +0000")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
	<225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
	<xmqq5x71gfci.fsf@gitster.g> <abLw6vUUh36zFK4n@exploit2>
	<xmqqjyvhez96.fsf@gitster.g>
	<1759c2fe-6e7a-41b6-9869-97544870ebef@gmail.com>
Date: Fri, 13 Mar 2026 10:20:48 -0700
Message-ID: <xmqqqzpn63yn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> It's a pain to have to prefix the format string with "log:" when we 
> don't require it anywhere else.

I do not mind a sort of DWIM similar to "log --pretty=format:%s";
technically, "git log --prefix" requires the "format:" prefix when
using a custom format (i.e., not the canned "short", "fuller", etc.)
but we DWIM when the string appears to use %-interpolation.
