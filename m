Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717029ACD7
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068688; cv=none; b=OHHdVJcXwEsQRUBOYYYTfnzgbvmIPKWyZhYeRJ4HhDPykuDVG2WM2kVsZY/zn2bACHgDuUyBuZlKNxGdoa+YZ3yPpVkt4h6EivvGiLphX6T1q5VAEueCiEl60hi2elB7jJqx90jwdU8b7X/axAQr9J3vazORaI2d6amMlp7xN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068688; c=relaxed/simple;
	bh=TBp8bgfQIHinFv1r30CNZ27TwxGoo2b5UD9oLGJGsj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lDJlI5fcYcI//Jxo6ROJ9mq7JsK2smnALibZN8lhe/hmOJarn5r1y8fCWqc9JWjOc5daczv8Zv01L5pN6uFQwAWXgZTZTr5Sbhctf6dcaFtw037BBHLDaew9S+HWzikCI153c5mTSU9sJEpLk9yV9zBI0LRLCYuhr9pUkWAYrIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OXVD/kTH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NdZzVvaM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OXVD/kTH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NdZzVvaM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 083457A0085;
	Mon,  2 Feb 2026 16:44:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 16:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770068685; x=1770155085; bh=bLn5POztQ6
	6eg/IqguOMhAAfKQR8f5TkDIS8Aat3M8M=; b=OXVD/kTHl0lj2G5sHvADsxkxLZ
	z1vjUvnKy26pAzyBv8TVS0cfFdpW2VKHkvRGI/yUXj6PQxhleVMjajAf6u+dWVfo
	yNHSAsABc5pyPmbjVnCuczMjzVKHsN3eoTLKk6a+bWVBOtfoivzg20aYAXpXaDuo
	xOBFPMRHmonpRaEhL4T7aZqYdRRipA+/DsAJIykoJ8k7P6u2QGyCky8DQ1iw3aQX
	NAUt/XLTUU3nbKZDulk7tDwPq8c5GppGUKnyN0yZa169lhTPI5HwfS/WfYxvw/ai
	9qIn0eFQ6xO6bcoas1/QbXUY4wJB3qqlVDc0vgDxcpz6fzVDQWHfW1gtdlrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770068685; x=1770155085; bh=bLn5POztQ66eg/IqguOMhAAfKQR8f5TkDIS
	8Aat3M8M=; b=NdZzVvaMHC+OarBtM1yD7NaJaKfnhYSP4c3MjyiYxI8BnUYNQ1H
	5RQDQNq9boU9eNmkCtd/ofvndO1eCN40vx9WeXYl9D0BRZ8BIZ5DiswXMQ3+F4Rx
	h4ukIa2Ipt7JSfymob5A6WQ4KvEUHxpVHDDhOwMKCaIy2mQsjpUSrRgMmgubEoJN
	mTJ2oHVKPLrgT94VQjE4PYmckQNHvtqT+OYIts0Cnf8XDPkF7glIfcUMGrKN3JRZ
	TROxNfs8INZ3KFB4r/+q+9K3hYGXc7I/LwaYTPQsheoGs78M0mcNnF4ygRTAzHDo
	YnNBmknvUfUqvYvXd/zsuAzspmW/vau0Htw==
X-ME-Sender: <xms:zRqBaYRTRvP1CU6E5R7DPzKGQ66tFTHCy1DYG00X6LgwJ_3LdINGrg>
    <xme:zRqBafGWlx2PaU6xob26klrojpHFkDNVsHJOC86i1wRtOsWxmwMOIDU8lXQFk-dCd
    R7O4iB4vdc5SuvvmTni3Iv-ml5IERpszBdde488-4elYFU7u08j5Q>
X-ME-Received: <xmr:zRqBadGZyVVW2kj35tEOJ5i8_e2gAcdMaqTcJ9Rf48kvm91Z57FUVPBAv1s7gylM3exH_fUBky7QI4j5DcITQV4oE-uYUwHRUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zRqBadRi5EDWIb6fbrR_Ucr6MUK4q2NPB4e-6VwxZ-Rn8ElJMHRivA>
    <xmx:zRqBaeICgdM0aFEjFOIiuXDEpQ6LVUBleu0SDOeiNgu-WfTgpj4UwQ>
    <xmx:zRqBaYZKq5kzQ9o-oa0ZHyvEnByc4oPDEAYZ7lRPx6ESKQZi8DVd4w>
    <xmx:zRqBaQ_7riVEHjxbHXSqCwUdDJvkIrMVrFlTZ_xw5ZPZ6zDoJ26J6g>
    <xmx:zRqBaTZcvV_mDT4oKzw3hhk1wk4_n9bMfZMRWVDzKdb0BUH4j2lUXE0b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 16:44:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: phillip.wood123@gmail.com,  git@vger.kernel.org,
  gitgitgadget@gmail.com,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
In-Reply-To: <20260202101445.13790-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Mon, 2 Feb 2026 11:14:45 +0100")
References: <d92bd08f-abee-49a6-89ad-3be5e0c06ad6@gmail.com>
	<20260202101445.13790-1-haraldnordgren@gmail.com>
Date: Mon, 02 Feb 2026 13:44:43 -0800
Message-ID: <xmqqms1qx1kk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> My main is a mirror of upstream/main. I never commit to it, just do
> 'git pull' to create releases.
>
> Also, I switch to it when I discover a bug on my branch, to try to
> understand if the bug is already on main or not. It's the baseline all work
> is compared against.

OK.

But for that kind of "I go there to see, but I never modify anything
there let alone committing to it" usage, detached HEAD is exactly
the tool invented for.  So while I can understand the allure of
always having my local 'main' be at the 'main' at the remote, I no
longer see this as a "must have, somebody would die unless we add
it" kind of thing anymore, even though I think it may be a nice
thing to have for some people.

Thanks.
