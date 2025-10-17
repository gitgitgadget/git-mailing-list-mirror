Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA51271449
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732400; cv=none; b=jntz4qDQCrNnJ50OMB/kzqTXaJkCQVDJJVke+po6d9YrO9vsmjbqmz9iqGO1v9sJuiuOKfIHYy7XmP4P/BFwFsmOdO/j/nmWUw7ivkT61CZFN71ct/mTMOw0uwLB0jhOOuHXrqO9wKEcEbHcG7HNCVAdjnkgEepjKW77zsaLdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732400; c=relaxed/simple;
	bh=88vpCrAb/58VaaZESsdSa+M112VHjGzyNt90fE3hfrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WniB8yTcfWvm/l/3BN+hSQDCgH8VNLPhEqw6yp6NKJ+kWCq9ZZeoPC9BY+N2Mrvci88HqTaviHEt94hCUWDuOU9yoXRtdlGzok0i8PhHSLGT8R//nVrGEeB4agmVuWkAUhxTKf1MB1v0ygUqt3p5NS0e7r+dCr4whxE7pPRhHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DAJf5Y/q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJUtD7/z; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DAJf5Y/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJUtD7/z"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AD6A51D00107;
	Fri, 17 Oct 2025 16:19:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 17 Oct 2025 16:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760732396; x=1760818796; bh=dTgKUN7h0H
	xL46dmq0dLIemRgUikmd/9uxAr9wdiIyA=; b=DAJf5Y/qR5VkevTUzA3vGfq9pN
	roWGrNwiGM315F2PrPj1HpWTYwTg4q4ySO2sAGjyKptD2rGDitJJ1sNVVhISymoD
	cXuN3erDEYAoOX2XojWzAvdzrB+wR6dDHxs7YNPVEQW+6ZafHS1PqXVEuUR8vr/f
	q1kal/xC3blqQ4QTo0lvIm1za/6UpPE3iFFdhM/mAqgPBWuIZ3290jqprHl5nHOE
	/tnFl7FGCFmLCViKHW79zHUyW5qLpTfRV1VRwIZQvhZThFvgTMX5z4BUNXtGEPmi
	CIS34h1DnnCAyDNNxafyO+rGUpwq4Hp+Crgp7ZQ8MUjIqMLvpansmV2LXlCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760732396; x=1760818796; bh=dTgKUN7h0HxL46dmq0dLIemRgUikmd/9uxA
	r9wdiIyA=; b=CJUtD7/zyd7PDfKwrTYAGwv7PiCidVLtwTYu2ePV+r+gA/Ow94t
	2uPlcf+6AZ630Ef5vNN5KV3M0//jeLafAsxSYpeqGZdWrPI4d1ekkSqLt1TDz2sj
	y0ygdXtSf8BH9HoDN1P/krdWf9SAsvmCOtg+iC5BZd6o7ojInTL0pQTc+t93Uw+W
	KyTzDUYASb2h34myo0sPo9Um/W0OVhCiruoraHgtGaNFQ44wt8e2ZTozE+dJ452p
	rh5Jrjh3fZ27JIGe6SpXhWNCqqT4g0al4+D64TD6tYOmkCbH6JkgKO4K0FljPmLQ
	vI8b41/w/PAp2dyC3Wsg2krM2cUr2kn1R7Q==
X-ME-Sender: <xms:7KTyaFGIvw4E3bP3KViRhcj6rMn2p6DURIxU6Ann3R333KMrdqIftw>
    <xme:7KTyaFTv4dNjLqodDY6Sg31jquPqLa_XVOOh7T9ljC3K7av9cnnT3253BzG9s5jru
    QAL32bCQgfD1AuCMHL7u93YVw2KLnUIPioNxqW3erToe8M4m9f_HUs>
X-ME-Received: <xmr:7KTyaGLVsLtmkEPOBtXHly6oZ7aUXEU6vNLZFSlRSovGG2E1ZlOhTjlUaSvXG5ZfQDCB4lPWSpBvtLkZ9cAV7fyu1ogvBQo2fkvt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    ehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthht
    ohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7KTyaAbrJnufh-JBALF3tdSnd3bKAopo3eA7-7ItbhJsvpMGi5EkNQ>
    <xmx:7KTyaI9RhS9pQkSP3tOq3a2VC8T7xsameq--kScq-WnAgO7zWguHIw>
    <xmx:7KTyaBaijcNLNMqvpPvSkRV71IgYfo39UTTIYLbxStAl8keCyDMgGQ>
    <xmx:7KTyaMOb6krkFl3fDlpkK1OyHydB-70MvYOBc4HGcKHRbc9nX8hiPQ>
    <xmx:7KTyaAix_UzVQ7cTWPIMDr-Fu-dKrfXkp_5IUm0odg4Ys7gVCJb79Umy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 16:19:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>,  Lidong
 Yan <yldhome2d2@gmail.com>
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
In-Reply-To: <xmqqjz0tz6eg.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	17 Oct 2025 12:15:35 -0700")
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
	<4ff55fc5-7880-b8bf-257f-3186552e9c36@gmx.de>
	<xmqqjz0tz6eg.fsf@gitster.g>
Date: Fri, 17 Oct 2025 13:19:54 -0700
Message-ID: <xmqq5xcdz3f9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Thank you for fixing this so quickly! From my point of view, this is ready
>> to go. I will integrate this patch into Git for Windows v2.51.1 (which I
>> am sadly forced to release on a Friday).
>
> You may not want to.  I think I'll have to do 2.51.2 either with
> Peff's fix (or a rerolled version of this one if it comes quickly
> enough) early next week anyway.
>
> Thanks.

Ah, sorry for replying before noticing and reading your announce on
2.51.1 that was made hours ago.  It seems that you had a separate
reason to make a release with the CVE fix material quickly, so
please ignore the above.
