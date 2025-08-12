Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84822F83A1
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022047; cv=none; b=Lkg/e8+rQJEuTHmT45xUqeDJyG+y0nvW7z/BHuUuTv1FREVIDNK5VnF5Wx6SQhcXAKJPI+rHqvO68jPyUeTrzkJNfE1DyPpJWQwzWJNxjZmSKuoG0o8KWyhop0ooFudKQbxgyqyUUT0Y+erl5t5Anz3RklBQKCulNHsyWmlbURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022047; c=relaxed/simple;
	bh=dSY+V6n258a91lERPft2qLUaaWgjnhudHGzR7+M6oc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQwjHP1E1sUEr8VpwV0mZTDMKgYt5SiQGsZ6sZeZCLC51OMust9H9gUahu9FVsfM1znwLuo0T6vCnPUJrktQrxXTLXalMonkxlyP/zKBmVLdFkSjLIursbQAvJLKxZC28FyOhm4VjDyzlIyVRh8q6aa8o1bP3fKDCYYLcGYvQtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xu8J2CuP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SZveKJS+; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xu8J2CuP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZveKJS+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C96CB1D000DC;
	Tue, 12 Aug 2025 14:07:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 12 Aug 2025 14:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755022043; x=1755108443; bh=P0rjnRnVw4
	ahHKgB+DXyt8gIedH5gpGPxzvUnM0dqdc=; b=Xu8J2CuPw6g04pL2FTwcgS8Ond
	D8ElGJKUHKfMWnDf7lqPEoVU6pKzaAtq7T/dxJ+MmuoJb1fOdePLh/TbOWz7zJlS
	GluD13U6UkhLmWZMPJjoQdaM6uwuJuN6LDqTuTeQjHGETZBZgsOpCuBK2smvJSgP
	YYYh+lugl5oX/DRNpXPRRHmp4uawwVeKnAJWAAbhZeEytYiFtoIYBzJNXsYVJ5rJ
	i2Pg5atiyLsXA17r77caqVovSXAQ+6lyhWmmQKSfv+fmxYpAXs1/bCjVYWjRLjLG
	mghn8b/PTTbZOf8g7zwABxHHCfY3hfB9yzP8lshJu+nSdElQ7NVtO2NdXOeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755022043; x=1755108443; bh=P0rjnRnVw4ahHKgB+DXyt8gIedH5gpGPxzv
	UnM0dqdc=; b=SZveKJS+U5eSBSW8pgglrwwOF8nWdaNarWySR80JscpDnRClmnI
	8wS4bvggAD1kQdR+5AYq/ZKiHmgYdic4xeoOWYFuNZ7F66JDGPvtqG8qbWD/eGUr
	JABj6Z2zWvi1Ng0XMJfAfVXHTgHWljAEhbO5YiC+7kDuKij7f/Oq6oz46gtk2XIm
	dzqCUx8EImpfyj8BeeBttsFw6df+5rNVeAmDdxmEOFBmNvlf4/mBw4815gckXa3M
	jrtT96XJwNYcYiV7fLjEfv4glrvx3wengPeVunVS9AnXvUDRZM2CaempLPEXdvNY
	oqvLHnzZB3nnl/HqhgqqHdgmLbikYmpPbMA==
X-ME-Sender: <xms:24KbaK2QZCpIB8Ja48B7_aWPcnQUX3fPPWxfJmoBjnKjdyXj59M88A>
    <xme:24KbaNx1-FrTttIHzyNAxSqd5y7BnLVSUPBotPoBdiK8WwgL8esb7xjL0DETjGc5G
    OfHyaC3CuxhObFJAA>
X-ME-Received: <xmr:24KbaBGrMqzRYVEddx_F4-8FmMqVKrdCwhUSe3pXrVmR04RMMFZKQ15ktKUjgRn6kudk8Su5vQADO04z9Dr2RkLxrtkpcuUUVNVPRg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeitdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:24KbaAZ8PZuKC2BihqUafHfnaHe0LiG1WBLFzUnNaWKONY6j29tlOQ>
    <xmx:24KbaDCO_VNpRL3leASMwkO-7qRFy72N9RaasduSkP2lMCCmD7V9eA>
    <xmx:24KbaImlXdMSheIudgXX8M0JUBvDn-uYsZn9bY3t7jTtRfvK1qW8RQ>
    <xmx:24KbaExPcR3qqvJcqQTY7Glr5ym2maFcsHfPW8h6gsq7EFRL3NARxg>
    <xmx:24KbaMYPY5Y4T3Bw3-6UuyDAUVe8gn8J1iA1ZV8veTBq6XxIhEgNvR5Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 14:07:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
In-Reply-To: <CALnO6CBqChfU62TJuk9mBd=gSbPKDEyBKv8r-rCygsRDD2yALQ@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 12 Aug 2025 13:07:48 -0400")
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
	<pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
	<07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
	<CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
	<84258154-322c-4ef0-9ebb-44858a5d58fc@gmail.com>
	<CAOLa=ZQwwcfEQNbZqp3o6YfTWMhUr=s0Vw5jP87pUELsktLRaw@mail.gmail.com>
	<CALnO6CBqChfU62TJuk9mBd=gSbPKDEyBKv8r-rCygsRDD2yALQ@mail.gmail.com>
Date: Tue, 12 Aug 2025 11:07:21 -0700
Message-ID: <xmqqfrdwtnvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> > Junio has already expressed a preference for "checkout" here c.f.
>> > <xmqqldnte6h3.fsf@gitster.g>. I think that is technically correct as
>> > "topic" can be a commitish and "git switch <object-id>" fails without
>> > "--detach".

I wanted the new documentation text to use what was already used in
the parts of the document that are not touched; otherwise we end up
with text that uses checkout in some places and switch in others,
which would invite confusions among uninitiated readers, who
rightfully would wonder what criteria were used to decide which one
among these two different commands to use.  And teaching that these
two commands are quasi-equivalent with possibly subtle differences
is not what the documentation of "git rebase" needs to do---it is a
distraction.

I do not mind a new proposal to do a documentation sweep, aiming for
Git 3.0 timeframe, to examine all mentions of "git checkout" in the
documentation and replace them with "git switch" or "git restore"
when appropriate (there are of course ones that are not for obvious
reasons, like the ones in "git checkout" documentation itself, and
possibly in "git switch" and "git restore" documentation pages that
may say things like "'git switch X' is similar to 'git checkout Y'").

But let's leave that outside this topic.

Thanks.

