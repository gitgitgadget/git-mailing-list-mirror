Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31433D1CD4
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945768; cv=none; b=AAnNXCB8YR17yagaZgunXbIuJ/Bnw8WKvMB0MDNTDglWawLxRmPKn7PzskYhXe4+R+9rf8NCNBPoP+VELGavznSUbY2Wy736LPcEZ6VP3SoN0VQj7xT7OWH6HSwl7J03axQOUvn0x+nspfctCkzcL+foFAtJHiCyfi7anFqYDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945768; c=relaxed/simple;
	bh=k0nVRPT8El9OpP7o9FJ3QKVSi8zsCGJbGyFtrNi0niw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A3O7j3RDBzwvVxvaZz+kPLxyJZe97eW28n1RCOCytgyRItpA/KU9BApcVspa9PwbfCbtu53Hc/kVu4ciiwL6k8IaHc7JHbTICeHPm518wRtOmp0txHznixv8fHMkv4UAX3sA+lW1PM099obfZFdYfdwWGoIDkdm92aDUJiTra6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DGxiPe+k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isXeQiEc; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DGxiPe+k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isXeQiEc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 70E1F1D000D1;
	Tue, 20 Jan 2026 16:49:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 16:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768945764; x=1769032164; bh=L/F4HKOLUE
	BQuzDU2/7SMwLWIVoZJuujIlr4abhfTK8=; b=DGxiPe+kBbss95LV+RVD/m7j8/
	QXQHkOBIUtj4mf4tBGy7PUTjidL0a7rDR9lE2NDKD7RxN5jv8CIHPxuj8guFQVre
	iY2oimxZF8MQSUIKxwLGMnLs2z7c6d7HEfyhItg/cRtAYrOD2mCS2RU28eTS7APs
	J03VY7kODDk8yc9IjzWjZo+Yy1LHGEa+dcGBEe+jjc2Luq1GO92VHRHP9Uh7CBMZ
	UsBUr2PdKIyrl2frWrDMJb81y52Xp0M/hv4CNP8qQeUir8D3pKXebn9omZZPs+WU
	mFtXtBu+pyHMp5cZ1yuXWTCPZu35YsTRmA7DkwYZ+Kjs7d7iSW1vo762ZSlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768945764; x=1769032164; bh=L/F4HKOLUEBQuzDU2/7SMwLWIVoZJuujIlr
	4abhfTK8=; b=isXeQiEcVCK6lP9QTuuA+1vUmFuBU57q6QYG76MkYoi1KQkh6Bi
	jNM2afocLAuPlZathNoR1ygQJEtvhspm2b4WEPxUpAebVfZeWQx/VicO4fM3v9dT
	cgGXii/Qhae/K2DyldPIThJITisdyQvx4HdzCBwVorSnJ+xla7Jy6PhZW/nh+Z+X
	UN+vW8BnDwx0odRo1GYrEM77BEITMI4SHRfNQvJFWG//K+EwFSaR1Wgj6KJ+CBHY
	yq/neeK6U+NPNllcEG4OdUn6zeCbBnJ6DnnNDBRhBdP8+l0QmPFS7WnjDQL+M2RW
	OPiFMemCkhPbwtaj9+fAlmYpjZWAzyja5BQ==
X-ME-Sender: <xms:Y_hvaYXA1OtiqX9iAweIK13OMKBpaBIC24LFLNuWy6QSyUU9t7moww>
    <xme:Y_hvabpxku3SAXKJ5BjURv_Eyz3-ev2R8i4enYW_P19H9M-QX3YD5xY1VXQhH_rWX
    tSLqrJIOaoM4hjzco-R5dABC3OyRI80VprOpZThwY3xrluynj80kg>
X-ME-Received: <xmr:Y_hvaSlGjHBsCCjpr4NzPn0WlZdz6-lVrsa55r8qIcgsfnNDPQOTkSxF8LkqqxpUg_clC7kcbv8Fg8d1HlQnUOwpwai5RWbrNETUMvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtth
    hopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Y_hvaT3Td6P2eeyt5iag_ny5V5SeDFQIRZYJs1OPXTEpyMDDb3nPAg>
    <xmx:Y_hvaXRNSAz1PcuTysposLI7tsjFIyjdxqLZDe0svwyghCedrw87dQ>
    <xmx:Y_hvaUwwBxA5UMqtkp4CQxqQSC-BKLzR0AISBt9brerAlb320Bc8Fw>
    <xmx:Y_hvafAoRznuSkWYIEss6IQetj8l__6S0-Ith3N2KkEwGFIwH4Epig>
    <xmx:ZPhvafdBeS55j6OIAgCEJ9cGkeLfrt_oDr-u5sn3yGk3bkHPZokFAFcK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 16:49:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Elijah Newren
 <newren@gmail.com>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] replay: drop rev-list formatting options from manual
In-Reply-To: <xmqq5x8w2t3o.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	20 Jan 2026 07:37:15 -0800")
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
	<xmqqldht2fgd.fsf@gitster.g>
	<CALnO6CCaVdJQ2xSPfvxQzVCfPsjbWHhMFUiLoiPQtVn9MeKFOw@mail.gmail.com>
	<xmqq5x8w2t3o.fsf@gitster.g>
Date: Tue, 20 Jan 2026 13:49:21 -0800
Message-ID: <xmqq3440x8da.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
>> If I've understood all that correctly, then I have the Python version
>> installed for building Git and it understood the syntax. Given that
>> the Ruby version is newer, I think it should also work against the
>> spec.
>
> We have CI jobs to catch the differences so hopefully we know soon
> enough if one is so badly broken ;-)
>
> Thanks.

We didn't have to wait for CI jobs.  You can try

	make -C Documentation lint-docs

which reveals that somebody is not expecting these multiple things
there.  I think Documentation/lint-gitlink.perl needs updating.



