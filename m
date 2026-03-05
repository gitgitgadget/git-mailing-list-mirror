Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE43644CB
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752458; cv=none; b=saMBoeRAh3w1h1aBn3Aq5riu2Bm9CxrDylmfUPpZj0H8MlymInypYKwGobABXKOsCfBJy69cY/tVPpZa+k1ZvLy/c6bULL1XqHtwS9dg7uLVe38R3lzmA7fLR03i48cEBalXiKhtyQGdHbP08b1xCfrnFTE1b1C01ZlC2tvcNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752458; c=relaxed/simple;
	bh=FcaLupnc5YsKVT6KddhisJGmktsj7M53LeJLoGRLpVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q4mZ+vvW4hg7wGyKJMZ3HHdak21P8nOY5GvbyJcIR5kwrnivOKKD5odum4zUAiHGEK2Za7Og4Acxb6WovR0PxUz02ouKxCj3IcSJxwzd93uwNOpshgtcdluU8LQ1upRo7SkIAT9hTq7oFCUWOrLwfCpha8BIAK0NImMDdLam83M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UnLbIk9h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NKZNAZaO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UnLbIk9h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKZNAZaO"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E78DC14001FA;
	Thu,  5 Mar 2026 18:14:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 05 Mar 2026 18:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772752455; x=1772838855; bh=tOee7JBXHh
	MXnNUHUpYelYxpTwHEJA8GlhYlDui1Ptk=; b=UnLbIk9h5UhTRevJ7huGBYJY4x
	g0ShTXnxq5Hd0Guo4tootdOeDKFxt/1tkHtRb6gd6MVBDPhjo2kMn1TE4oQBZYTw
	7+dX+jxb/aqijMvCbdG01vGRWAoLsNPBku0neqsgKiJVagETg5ezqxPQR6fTu9aT
	+dJ3VhuExG2anjLLMOZQj3t9PUMcISxh3EegmsRDJPexQSL20dtinzuz0DtjRoZt
	b+BUq82f5xLtuNo8svhwsmAh7P/QZmNcD2j7Yshhl0vP/NTRJqO67iJ0RMBd8p1e
	IiXcUGF8DJbkL8MKqx8Co1K6N1XaJPa1fzMQy7z2iAGJZp0Nv9rrqmPNaqEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772752455; x=1772838855; bh=tOee7JBXHhMXnNUHUpYelYxpTwHEJA8GlhY
	lDui1Ptk=; b=NKZNAZaOKPRIKtgkRvuBfsYRlnpD/R8/anrgG1p0QDVh3TgKVGH
	8BbAXVrSseahvemhFfgaiuQVvdF0wc9O6d89kr9dmFHP0YB39z8MMnoOf7hDBz7K
	wSYRjEjUG1aq8B2AyA69qadfrATVqEJHhKUxlpECOO4ChubGkt4ihrfAECtvGv5K
	Sv8kUSkNSnhejmUYatDo9Y/fFC6TeDJbdSr1WxnXgX03chORFMSOEMRYLkCbzPrs
	FMX7JzWh7aNUHwqtB3T/JYFxcc4Jn2mr/aaBJuaY/wrCokenVdF3b+cr8VqP+X7g
	nW9q4xtBeA65ztBxwpotPLtIrRnVKmvPuHQ==
X-ME-Sender: <xms:Rw6qaZfDFqKdL0TTXLqSYeHPqbJUnmLF42o8HbNHtO6vIDRFr6sc-Q>
    <xme:Rw6qaeOxzRtv5Hq4yxAoT-QJAXNSZ4fHv1YJpCiXVmDjBiDUGMaJ20Q-R49tNj-Z8
    HsrLzooKJI4e4YSdo_Cmb-61607bn31OtLzyq9xFfGhpmr4H0wKpw>
X-ME-Received: <xmr:Rw6qaXi9lOl9wJqXUOE0qd3WQJi6Lh6IyRDXxF50whcWJltnOEaM92IpBqjD5L_FMrPpyvLVL8wnCTyw4ysBmQASVZ7rkqyDZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehfrhgrnhgtvghstghophgrphgrrhgrthhtohesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Rw6qaR2KTqpGT-vcXojr5Wn3UKH89FiWMI2DKI52PBeZjc482gEm1A>
    <xmx:Rw6qaRgShDnzqu73ZI4H3EOSVRJdsxGxvZYd2O4sD5iqCcpUte9znw>
    <xmx:Rw6qaReSM_I1iabHpGboIMnsf-ZU1P0HMhbe6CmvkZKs7rLAowH4FA>
    <xmx:Rw6qaUnxVJzT_lTQudNlZuJHtBFw4j7aR81Az305jLTCWV-yC2WSyg>
    <xmx:Rw6qafQH_dbn9Npx4coEc7eJzcDA4wVrrBV1_MfOg08LOIlFt_nNBwUa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:14:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Francesco Paparatto <francescopaparatto@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] t3310: avoid hiding failures from rev-parse in
 command substitutions
In-Reply-To: <xmqqv7f927x0.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	05 Mar 2026 15:06:19 -0800")
References: <CAPig+cTHyB2sbBOELPb2=B5sU69OzSPU0JVn0p=2qMp=0=8vEg@mail.gmail.com>
	<20260305090602.22436-1-francescopaparatto@gmail.com>
	<xmqq5x7a3x9w.fsf@gitster.g>
	<CAPig+cTsYWVg0nrU7kMakOKQaqFSo=i_nZ=_YuCJK_hq5gdZPQ@mail.gmail.com>
	<xmqqv7f927x0.fsf@gitster.g>
Date: Thu, 05 Mar 2026 15:14:14 -0800
Message-ID: <xmqqqzpx27jt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> > diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
>>> > index 92a5951331..64c0a753ff 100755
>>>
>>> On top of what commit is this patch designed to apply?
>>
>> What Junio probably means is that you appear to have based v2 atop v1,
>> but instead you should squash v1 and v2 into a single patch, and send
>> that as v3 so that when the patch is finally accepted into his tree,
>> it will appear to have been perfect from the start (because v1 and v2
>> will only exist in the mailing list archive, not in the Git project
>> history).
>
> No.  The v1 and this one touch separate areas and can go
> independently.  The thing I had trouble with was that this did not
> apply to either on top of v1 (which by the way is already in 'next')
> nor on top of 'master'.

Ah, sorry, no.  I was utterly confused.  Somehow I mixed two
unrelated patches on this same t3310 script.  What went to 'next'
was the other unrelated one, and I did not even take the v1 of this
topic.

I'll look at v3 now.

Sorry for the confusion, and thanks for helping.
