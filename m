Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117371FF7D7
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886106; cv=none; b=WWxCA4F4A4V+8nnApO0UggrFyWR3j2cbCcR82VoIYNx93UvpVcn+qH4kMfRfRRN/Sb3Ck8KTAIi5KLtWImTnFss45hpiozeaxu57P7OYoVyxGERCPo+aU23PHuFt6ckYU5XIT/wqW7EIPxO9r92C1QeeN0makCC8IrcJxh/njmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886106; c=relaxed/simple;
	bh=WZ5gq9RIN2+g9BAAxtvDmBgTC0xSPJmpjRmUO3AFlTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ajJNQ/k5ee9YSyWMC7/3Bs0jqtzRgPOB6Er+Qv6q41sH89sj2paFmpcE0wlzgejeiYVyHe6PxB08awCnwsBmobCkc2B9Gf4NXTtwlbSZ5mqfqupe5V/52mtysO6zeWiztztqp+FZyYDhsL8kVM7MOLsEnwdrRcBpv75cL+VxIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XYl8DLTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O88/UY7Q; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XYl8DLTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O88/UY7Q"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8B117A00E4;
	Fri, 22 Aug 2025 14:08:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 22 Aug 2025 14:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755886103; x=1755972503; bh=N7SMsnqK3T
	uegwqUu1DakQow6u7XoyFEW+MYCWdhkkE=; b=XYl8DLTLIGByR0A3ZVch2TlbM6
	3oZJ3AXqzYB/Ti+Yp/PcMZi+qc/xJzsWB/EAlQ2GCxJoF/+kJwNjxocK+CJ5HUVu
	8Mv6UHefoC0OVwI8wnbZKysyYgLBMod5DHKH1ymF5k+MlAXOaYeCEUnJr3jHmSi2
	JzvSfmVIcl5vKJgw9YK/L5TL/YKjSBwkxrpuisfHLGhfAer9ewiqKZgZ4ynicJ5m
	OCydoAI3PYHtLzHxCzA3DqqdSO4Gfck/ssX4EyVDhaVuxO2kRUmVOPk+r5dwusFI
	gLi7uGVqeQ5JgfxOYn3FIxcPWGVE7OXFgFWc//8WJUlrFeB2I+kwUkTThshA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755886103; x=1755972503; bh=N7SMsnqK3TuegwqUu1DakQow6u7XoyFEW+M
	YCWdhkkE=; b=O88/UY7QWnG6zB0GbhQqbqi3W6b17D8bSa1VyDRRnx2ezgensqS
	9MW5XwfvHJ+k87AeG5qqprxashMx14sdSuoxXG09jUJL5z67CYFvu6FnTsf3DXVp
	oK4MaFZ4QW5dv2tZyvTb1MzWPgZ7okDG0nulwDQ81jOvAW6V6fb9x7izkDXxKdMJ
	dush5fx/LNXJzcJlDC7ADgJ7G41JAudkXKq0dxDpSCYZ6gIoYTGLmOvcc4nZW97g
	34qRm9WdZmXrbH5LKsOvz7UNR9/+dR1hF4dXKI8PD/yCv4j/EHaYZpjWKLHqYd40
	YVofVHAcGEBien7xJKWoHKYSnsyXLTocktg==
X-ME-Sender: <xms:F7KoaBjn07tA4JTm4rgy4o8n6TEib0FQPx5eYDV7_McMaLjp3Y-7Ug>
    <xme:F7KoaAkD46LOOWvWznyn32RoZpnXdbqdb6grFB4xQE_eqEdZOSzRiQKThYBrQ781T
    xv1LIfrXcvcbWQXLg>
X-ME-Received: <xmr:F7KoaNpuzsLc_UpZ1CvnQG5ryhmMKnvql8pyYYPLSsWXKSBwW2Pd9mB8J0Et1HdHeiROt8q_r3_whiYIe0ZnlyVsbDWUBswTIU0ObR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeggeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:F7KoaJFEtlOP0Y4OytUl62h2Z-R9rOBKX63Zq_oehmTntURvjGvKTw>
    <xmx:F7KoaJzFd6iOtlm55BujFcu1xerYS0vEANsFNSiC3GN26mDoNZkeaw>
    <xmx:F7KoaOpeRFLphHB9ilw7_gD-PRlniC8IuVTLA5TKIVd-AkQ8pXxh6Q>
    <xmx:F7KoaDiMR_tmK64cgzFOORZ1frjMeMffRxFFqiXnX4l0FI-IPS6kpA>
    <xmx:F7KoaCTx0DLmKJuob9iNlSHQ7lUpctu-wvIBTHS210r-A0Q39mVTEcwj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 14:08:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH RFC 11/11] builtin/history: implement "split" subcommand
In-Reply-To: <aKhg8q-AAlsGDvFS@pks.im> (Patrick Steinhardt's message of "Fri,
	22 Aug 2025 14:22:10 +0200")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20250819-b4-pks-history-builtin-v1-11-9b77c32688fe@pks.im>
	<CALnO6CBuwDVMZ-QTay+PUiXKsWMsABJcs1pAB=uUXf7-DJ4Mnw@mail.gmail.com>
	<aKhg8q-AAlsGDvFS@pks.im>
Date: Fri, 22 Aug 2025 11:08:22 -0700
Message-ID: <xmqqplcnw7op.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Interesting. I can see using the original as the template for _both_,
>> or the first instead of the second. jj's split works a little
>> differently (especially with their notion of descriptions), so I can't
>> use them as a reference for the behavior.
>> 
>> I suppose this is one of those "everybody has their preference"
>> things, but I think giving the message in both new commits as the
>> template gives splitters the most information available when writing
>> the message. (Of course, in my editor, I can presumably do something
>> like ":Git show -s <split-commit-ish>" if I want.)

In other words, removing is easy, while remembering and retyping is
harder.

When I split an existing commit, that is almost always because after
doing too many things in a single commit and the time I realize it
is when I am writing the commit message.  So I would suggest to give
the same original message to both, to avoid losing information.

