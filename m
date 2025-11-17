Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE81FE46D
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763342412; cv=none; b=dfLk52IOz7jCLdFQpmaIaEoK3f4alGMwOmKPFU/+Zo9eIa+UOT6ZWbnsLsuqAF+Wxo0zgGczalTVCWj5agO9STOb20zuF9Gy2TDqQLgy4dmnDdTS7UkSaj4/jCULd6cfAhEqXweROl/i8jdQ1Dod7H8EcZ9Tw2YSioInDoC2Mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763342412; c=relaxed/simple;
	bh=uwQN50aVAarcndfYoV6O1Pj+7CzTxqne6BOjmBIqGjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLAAtRPlVt41m58lbXyQDYPzJBBGZQgSQkEps/9ETdScPZXz6Sz2i8xSRlvGj/LS4mfsmrKJAFmIRBaRgKyg20zimz8XuONC5KixjXFjYTtS+jHyq4WsKWDUUKxcamsi0I6K3TsvP/ARR9jEOWkMQ+tcBTM1lNd7vQTycHj4hfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kOicZaJw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hs9BTWa5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kOicZaJw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hs9BTWa5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7957D1D00168;
	Sun, 16 Nov 2025 20:20:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 16 Nov 2025 20:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763342409; x=1763428809; bh=rjiZQPqzxz
	kHwn6lhBkBQ0bQi+AZPA5LjF0ACsMYpS8=; b=kOicZaJwQK9Ks8LNVDN1l2k3ng
	oMSHVtkV3HVwA215lsv0TV4sM5iGddTq/TH30flBRzo30F9PGDqW15aZstCi/eV/
	m8X7mlDsZOfoU2Kp2RtrxmesgxkA1StD55XDI8yZjwSo/8bMi7tUVsCcL5HRf+Ki
	3jLUXhqci9vpSs71n4RxvPnesuEKJ4fpvFJr+beLDshvp3Zr+YBXL0XbC+SPQiML
	40WXdR+kPuX4SwqDFFZfxOAjOCsiij3WvdqFg1kTuSUF3ayTVt7Mghs3WD8BA4y5
	tVZjuTIaOpXZF2RhkAgzY5HUGBS/m4puqt+vKzJVdiFuy5E/GqHdHl71PUKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763342409; x=1763428809; bh=rjiZQPqzxzkHwn6lhBkBQ0bQi+AZPA5LjF0
	ACsMYpS8=; b=hs9BTWa5m+XPW+4O5XW69fpxregO8VSohT6zllnMqkvHzpHA4en
	vgBjQUn2NPDD+fyz7hWf5TygBy/aph9/3/1K3bL+XAQdHmCMYJdKioHQOtslrusm
	dPGQNy1XPUtC3wWE2IYNxm+h78Jy1LLzx5eERyvKSl810jHWohYSK2GqTwL41m88
	4IdvYh2rNWlU0emlt7SUtR4M7jJnqGy3gp+o8yyv3H4J2Ioni+P8HGHWwjoIDSSk
	HQfzLJ46d82pKdY23qyYCrRo2/fsTwDtbtlL3yda/GEMOenLhpq6VxeV5aUdLb6k
	y+lIEAhYRPP3Rbbh5Q5XRurpN3u21t3aZ+A==
X-ME-Sender: <xms:SHgaafdn4EiWHulZnyp-GvdqkW9LWNkbkCszZz1kOOXmLyIREjsOZQ>
    <xme:SHgaaYQvHd9N_Hr-dtH2mkHKOqNrzkv_eVpS3xlluhNC1fpfNxNsLcTVXLFTPnjjG
    PVBufcjBILD1v_9TjePXV4xGL5ey8KkLyDb4o6LRAxYpHNZrYyHOQ>
X-ME-Received: <xmr:SHgaaTKr69mQFmGcCH9ZXn6aIkK3W7OpPkINbU9XBXntkQu32BRaEEPx8Ra8KJFNsNGe7ofgl4gGuU6ur1w5fEakoEDc8TZX6HqJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SHgaadJHQYzK6wI9eCI4a63DXYgbW6zweD4Pz3IbAoR6y3cUManaYQ>
    <xmx:SHgaaWipqkObGksqRtPBSp5hqyKVXLAabvpehZm0GO8Ft3nsL4d0eg>
    <xmx:SHgaafOhL0I5tki31_TSTe9AZKy9_lb4GJrKDjMirzzRrFEBsq4HfQ>
    <xmx:SHgaaZoIR4la4bvv6lTBDBcHWpRJY-Za6rZkOwk_plijqkxqEg5bqg>
    <xmx:SXgaaa2Q2_LgjPuU6WCPVKmwVky9DdQS41duC9J1mtB9y8sI1WLOIbAy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 20:20:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,
  Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 01/10] doc: define unambiguous type mappings across C
 and Rust
In-Reply-To: <xmqqpl9jfdso.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	15 Nov 2025 08:42:15 -0800")
References: <23b7fd8a-2b50-4da3-bc8a-3727ee99654f@ramsayjones.plus.com>
	<5A740EE4-D545-4828-8D38-E0E5E9F87A3E@gmail.com>
	<a30ad114-61c2-4eed-a24e-033b3b9d6d0c@ramsayjones.plus.com>
	<xmqqpl9jfdso.fsf@gitster.g>
Date: Sun, 16 Nov 2025 17:20:07 -0800
Message-ID: <xmqqzf8la20o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Me neither, but I suspect it may mostly use of non-word "signless"
> that is the issue.

So, the patch text that claims C's "char" is "signless" still needs
to be updated, I think.  The problematic paragraph (with a bit of
rewrapping) reads like this:

    C comparison problem: While the sign of `char` is implementation
    defined, it's also signless (neither signed nor unsigned). When
    building with `make DEVELOPER=1` it will complain about a
    "differ in signedness" when `char` is compared with `uint8_t` or
    `int8_t`.

Perhaps

    The C language leaves the signedness of `char` implementation
    defined.  Because our developer build enables -Wsign-compare,
    comparison of a value of `char` type with either signed or
    unsigned integers will trigger warnings from the compiler.
    Avoiding `char` of implementation defined signedness helps us
    being a bit more explicit.

or something is sufficient?

