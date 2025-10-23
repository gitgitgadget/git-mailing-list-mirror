Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DBA24C692
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240732; cv=none; b=Q7UiTejfAL0R6xrN+570koPJUKX9HMHFVvL4pa6UQCxOV1jjxpN3lEGUNAuctzuw/88CDtB7dClEif5lYq5FDUg12kiSoJ5Oon6GF81gFmx/090W9BNLeMRwz2Wec17N1XLs70VqHZHjhSMBcWMGlTUut5vK6LY9x4fCR7UXUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240732; c=relaxed/simple;
	bh=EvCiO3RKXd+h5oX6s2u4eq+9lHeNO9k3z3MLpLo4olo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B4yLkGrVipWAD+Czu32+NGHXoiIrFWuTsIsw8wJK1u0mkz7973ifqppiId4VPCaTsylrdt0wxIEWFAtOeMJKakGTv+bxOrO17dIIg5Uzk7GMVktAR5rd1N//eNCAppRbvTohhFMGb5x8TMaQ76Uf8seEWQBTnuLZtczo51hVqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dEiuHUCp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GrIQvy91; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dEiuHUCp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GrIQvy91"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E5E3DEC0102;
	Thu, 23 Oct 2025 13:32:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 23 Oct 2025 13:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761240729; x=1761327129; bh=FXNzbbDayz
	fssrf59N+6O03/lfhoYt5BFWieSiK1ct0=; b=dEiuHUCp2kxbZa2U9gsd4iAxJ4
	SK5w64+zSs41dIxRFnXo/GTfDL1NjN0HsXEoGnpZ8HVIx3Fzcz8Mn6Z1ADGr7Gwi
	qhgsSSdugHYxOeHRz89pevkrtW0G2ERctjUDL8q0xZjlDgT/++JInTWz8EjNaaGs
	+lfGcvanv3mbsRRFu80l2dyfavkNGxH6BnZDafaMwh+xBX+dv7nb3Nm+ZThG/yts
	BjXyYQqzr/ZcIbRl0QLjPhr3ia1LnKo8v/jyqxVkMkdrj556T/1Gw/X0WZMKVGMN
	FKGICbdkhY2QsiQR3JWWp0XkbGdciWioDzTD+Bf7yn2bR7Gzp+M9zMvIhSHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761240729; x=1761327129; bh=FXNzbbDayzfssrf59N+6O03/lfhoYt5BFWi
	eSiK1ct0=; b=GrIQvy91JFrJ4ttIKdW+/Ych69cI1k3ISLVUAZdMuOhmarAb73D
	GT8nAYqLOhXmPOx0C+Ui/6km5ayFj23MJCc6qncpTVWRzi6kJhFRE4Xwdp4alc+F
	bkjE3QuK4mh/LDLQuFA77j7D24aLjZ+D/PZANXyts/uVrAOq0biueHtUQJwiNMi6
	Kq9KJBnrfP2dAG07xi45XFJUtxLK/mQHynO86u9ymZH7Lk//Tpqc28CS6GapFdkv
	h80Eg01dskLXM29uz/kQYpRqdLJeyg32Twcd5M9BHWtaUDutrfLVs0f4TfvABngQ
	A3HoYvQ6x4YY08z4fX7qd434glOa/aVWf0g==
X-ME-Sender: <xms:mGb6aGOm6cw2QAYp2wlPBBIKk7irhLixeUq0nFLRTNzTkmGXaGvG7g>
    <xme:mGb6aNLariqR1KCYo7WovknKAU6hl-NjAgJ3-nnBXs0UBCx4tQSAcpL2KR1Z2VSoQ
    pw1KJB69-wNeIyXTTzp9_gq5_i8AYshr6SdNKZ8nSn1E4_gx36gSg>
X-ME-Received: <xmr:mGb6aI2ZHqQzC3cCb3pEar72xExlbCkC10vmT5jmM0q4C9XEjj8KeuWaIY7ZGq7gxlIH8bw4aJEvcO0WmKv7ogYHcY42IeRdxDRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehrihgtkhesshhftghonhhsvghrvhgrnh
    gthidrohhrghdprhgtphhtthhopehgihhtsehsfhgtohhnshgvrhhvrghntgihrdhorhhg
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpd
    hrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:mGb6aBWVcJVt3DT5kGpsjwQpbVlY6wQUh8w-c6frZuAxQCCWFhRDLA>
    <xmx:mGb6aKObimPxp66wsEpJRmTT7ft7WOGcGd5vtQbRWOJ3x7PCF2C9ag>
    <xmx:mGb6aE2JAbUOWW7IJKUB3B3P57LqaxAOfgQWXyKrWREUPFvtmjiKzA>
    <xmx:mGb6aOS-yZsu1UHH0m0d4VMfkU6mgZldp94SI7wWFNPPw5x0DP83fw>
    <xmx:mWb6aCeSdSMXfK4dv-rW7JS2yfO_bed17XzMIVynwyxasbMfCIVWeZmQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 13:32:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Elijah Newren
 <newren@gmail.com>,  git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,
  Rick Sanders <rick@sfconservancy.org>,  Git at SFC
 <git@sfconservancy.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
In-Reply-To: <xmqqv7ki1xf1.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	13 Oct 2025 11:14:42 -0700")
References: <xmqqcyalm0mh.fsf@gitster.g>
	<20251001140310.527097-1-christian.couder@gmail.com>
	<aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
	<CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
	<aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
	<xmqqh5wbq5z8.fsf@gitster.g>
	<CAP8UFD1Bc0bRdty9O0et9T=UL9FtN-g_K3DYUmHUR31waTQ+GQ@mail.gmail.com>
	<xmqqv7ki1xf1.fsf@gitster.g>
Date: Thu, 23 Oct 2025 10:32:07 -0700
Message-ID: <xmqqfrb9v814.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I do not have strong preference either way.  Even if the wording is
> firm, it is really up to each contributor to honor the guideline and
> be honest with us.  You may see autocorrection in your editor fix a
> typo for you, and more advanced tools may offer to rewrite what you
> wrote, whether it is prose or code.  It is very plausible that,
> especially for simple fixes, the result may be what the contributor
> would have arrived on their own anyway, and in such a case, even the
> contributor would not even know how much came from "AI" or simple
> dictionary, or if that AI learned with things you should not have
> seen.
>
> So, I do not think it makes too big a difference in practice whether
> we adopt the QEMU with minimum rewrite, or the version you posted.
> As the one you sent is in line with what we give applicants of our
> mentoring programs, and it was read over by our SFC lawyer, I'd
> prefer to keep the version I already have in my tree.  Not moving on
> either, I think, is worse than adopting either in this case.

Taking time to discuss before deciding on an important issue is one
thing, but waiting for more input to happen and not moving in either
direction is worse than picking one and move on.  As I said above, I
do not quite see material difference between either one in practice.

I guess it is time to make an executive decision to merge it down to
'next'.  We can still tweak the language if we want, but it is more
important to have a written policy to reject materials of unknown
origin (whether it came from generative AI or not) than not having
one while we wish to be able to pick the best policy, waiting for a
better argument to come from somewhere.

As to Elijah's concern about grandfathering, I do not think it has
much practical benefit to make such a declaration.  If it turns out
that older "contributions" had added something we shouldn't have,
regardless of how it was generated (either from generative AI or a
human contributor typing while unconciously recalling what they saw
elsewhere), we may need to revert it anyway, so we will deal with it
when it becomes an issue.

