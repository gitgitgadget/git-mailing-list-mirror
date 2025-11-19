Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC8364049
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563470; cv=none; b=bUtNZ2pdQBDuBJ0Bgr6P21HlUf1QotQYlQNVASvVyTuHjux3x9G/QzwVnRKFpxYJOJWcfOvjaZ37g3oKn/a5zyzMg1QFOGPN7w9LgGgHkkw8F8RCkNlOpOOZOA+RTPPqQt5e0IZbcjR1yDyIGnqKdjrZGnwjjfIFn2dAMiNLu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563470; c=relaxed/simple;
	bh=bboG0YNdHNFYlJZAXK+AR2trlVQw7eJv/gRwfLVKJ4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oyn4/NjUXmMI8oHT9nCC6fFUoFdFCeHkWu2/f4h7XS+rppUyNrxXM1uHq1oxfUSc3D5kHRagUOcXzMqdAn9LAL0OMLVjNb2nh5c5w96GHI2XIv6IjFpaXGkhHcTdEKcn96cO1pP1yNGGQXSQGuIKtsXBbQa8w1uX4l3WvUlQgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zvxt1E/F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJokrOeG; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zvxt1E/F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJokrOeG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 80F487A0030;
	Wed, 19 Nov 2025 09:44:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 09:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763563467; x=1763649867; bh=0plmZbtbGS
	RuuH5e4eOHqksD9cWN7qUoI0ic8s9riW0=; b=Zvxt1E/FcV+lazHtz3zfZ3vci0
	Yn8DyjGlZ6toF2TPpD/mqdIEuJkInzX8qD5aDjlVRjEXLgodkGFvmMLvGxNNT3wn
	bZV9PbnGd6bKJmVNtSNEPe7LA3JZ83BeLZYKvO4yK3U7O9oYiZycdcu5ZijaPuFV
	uh/625bpX845qqUIfzItI96i0mbYJsspWff3HoqScNYB6o5U5cV39EQjhuroWcOG
	W6zrA+zhqkYg/YALoxxG0AgRHTPGlmoZcNgtpxGi8VTHVWRAjbCGqOPSUrpl9DFB
	IPJyfxBngJ9cpwF1dTq8heZQi5E1T0t3SQk35hylfSgWSKW3zpiVH1SBeD2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763563467; x=1763649867; bh=0plmZbtbGSRuuH5e4eOHqksD9cWN7qUoI0i
	c8s9riW0=; b=AJokrOeGJFuzT1gMj0jTL0+fF8pnEED5R3Tv70kqR3yT1OhlWll
	QlxkTI4WLLmyL/ISUko7Oe8zyr6ekzTH5o4PzJoHtPqwanHmwEJ4PCiGWlqy1cIJ
	oqGEJ/Ki0iPCFhpHLRthidAHr3/4DoUUyVPhDZlNtrnnoXkLL1LRAas9qMOyEIFJ
	am05/iPVkC2rNpLkv5+sC4wBVtIWejtiHPCpcXDDnXxlPZ+3g0GXwASn5cGXVElc
	Ff9vdyGjFiu74pPIFP2wFQiPLbOlf/Kol0643s7iEgiEnrIJpDku327EMwKzTnWA
	NfrT36oHjqNPi6jA/cHgZb14BpG626XHSQA==
X-ME-Sender: <xms:y9cdaUEtahCgebRYiCbJNo5B7ytB8SO4GbDbDxxwtCusiUOstORJkg>
    <xme:y9cdaSg5CKBuzwrA0baKdj8Q9q9rVJ9bPRfhQHpTJvcn8du9Zc3PgOHj0v__Wk3RD
    nDADN87bajOkbOh0FF7k8vfsOI0rJcQxqmvgKRZwuSTx7rkOTRreg>
X-ME-Received: <xmr:y9cdafBDcsiR3jFlKvcPZHghtCZluOBIFI8zim8totsCfthJAl5atkIXJ4qeYGdIpZm1GY9Zb0ikMkGcfDFX0BlPd4sTAi3f-0Zn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeggeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peguvghlihhlrghhfihusehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopeguvghlihhlrghhfihusehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:y9cdacTds0X1gBp8jlzJoubpDFZycqgMUTwsZDZ1PtB4N1kgT0iWeg>
    <xmx:y9cdacVkN-I9oXC4vAOj1AtfUh3SuliiQkRsEUx67IqFtcwq51keuQ>
    <xmx:y9cdade62FhBWR6aU7EeiJfOK8POCfqQlqXMJSCCUFysF4mXEaxD9w>
    <xmx:y9cdaQJt5UmXdO0TzGc8jCxjSWvrq0ufbIVz3nm4cKNmrlJjlHTauw>
    <xmx:y9cdaZou6a7fn4usAqaXdxBmDEwgETWtA0gIuWXukuuKHuQ8F9vu9hP5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 09:44:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Delilah Ashley Wu <delilahwu@microsoft.com>,
  Derrick Stolee <stolee@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Delilah
 Ashley Wu <delilahwu@linux.microsoft.com>
Subject: Re: [PATCH/RFC 0/4] config: read both home and xdg files for --global
In-Reply-To: <pull.1938.git.1760058849.gitgitgadget@gmail.com> (Delilah Ashley
	Wu via GitGitGadget's message of "Fri, 10 Oct 2025 01:14:05 +0000")
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
Date: Wed, 19 Nov 2025 06:44:25 -0800
Message-ID: <xmqqbjkyccae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> As reported in [1]: `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config` are
> both valid global config locations, but `git config list --global` only
> includes the former in its output.

... while "git config list" includes both, which is an inconsistency
without good reason.

Thanks for addressing this issue.  I haven't had a chance to look at
these patches yet, but both analysis and Glen's outline for the best
approach presented in the thread [1] do look very sensible.

What is the reason behind [RFC] in the title?  Are there things that
are iffy yourself in the patches that reviewers want to pay special
attention to?

Thanks.

