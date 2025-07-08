Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2C12FF69
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011912; cv=none; b=oycuzuh3ilPiH7M10SN/rElivIGCiMT9OZv1G31ERxhvOJOKc9LdFLVqJjtBgWDOCGygrrxN1nMjMlV14I6S5FFOjraNdhsDDvAKnH/o8Fw8C6PzqgLDTFUqIugXmRTnS9TQDAcBpAOZDF18mUymVXi5KCp2+Lu5DiGza3j+cUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011912; c=relaxed/simple;
	bh=qr/tKGV0fIRK2ovjCLdX2qbUToNKzY4oLfTh+Rmfqxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kCc2LBqP01VJKGOOiU6xORvGPFVeqDlJ0Q1EFIHmCyBSE+YTFELJPgGScV5kKfsIZJFU5Ahqv556usX8WJCTPp8qjKsrp4vvPt2G7+j/iSb2dTZO0wS0o4RLiA4FrWTkTAWOT+Yj4t18d3UdFVZ6SfEJ1Cro4ArnL4gGnUaCj2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N7aCBIu4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIYdm9U0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N7aCBIu4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIYdm9U0"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8100D14005D5;
	Tue,  8 Jul 2025 17:58:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 08 Jul 2025 17:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752011909; x=1752098309; bh=fKg1VX/fvi
	56sJtf8EI5E9SctXkz9M76zZ2XxHP2qVA=; b=N7aCBIu4beca+83FyHCBvGGCIA
	gvG8yk/Y1efdqgzNW1nJCUn/a4zXxFpgGHdx6No0k72XV+C3NtCLEJJwVDJQ9V9v
	fYM5O7Z713nRtfYYzr5WxGxIwbpBfwwFufU9Sprs/CL7z07VM+oxRYhZShPMAC1U
	eQAG1KODQ6XU5KoWfMC/KJ2IRHBhIMT8pZICNVqroLS9i3d3DeSYI9DqRIBcoQwE
	MxQ8xWyLkJvhvTJqx1wwZIBLKXFa9UQrmSAYdNPNepXFyet5j9NbdBRcEyqhDNY+
	TzRtVR77lJbw/4vOa/Bq77bRV/+Aw6/kN/Y1FosI1w7XjUJC5b5KHHcFOYeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752011909; x=1752098309; bh=fKg1VX/fvi56sJtf8EI5E9SctXkz9M76zZ2
	XxHP2qVA=; b=KIYdm9U0suQlalA1+fxAT11kklbxiTWeWm5ob10s4lB5n77ib8V
	yt6S7wr7BPHbHbckAsjJoIlIFtmfBZLu+XRWPDvZ3GYhqMJ8awbQnCz4bpUg+WVB
	r2FyIoePrAwgGqWgmfUmJrle9ZiHEJ5z7wKNh6zvYBkeoIFUYO9U9T1d1i4JGr/F
	9P+Z9EBPp1xo8Mg+rJEL2B4MqfBajFME7igSmJ1zTvJ5i0Dxn2EJq3AchgCEUFnv
	ia28Cm7vXJoqrTCQEX36IGosxX1oJ3WApi3y5xsOPSj49EMlTRPejq94B4AHb5Xj
	YGJa812/9PDO1YsSOi546eRkvMUSbLGtPQw==
X-ME-Sender: <xms:hJRtaK-F2Vwhv2w9sulMw4JvnUzMV1XigzIWdBbw9UL-wnm6hotriQ>
    <xme:hJRtaHn6Kn3_E-el83XbCzxD-R0v7I-owu6sXZiqy36V-49PUrSsinCvyMvLCk_90
    EZ2IomJ0yuTvMvpDQ>
X-ME-Received: <xmr:hJRtaPwQbstnStN6HT1XDVz7vZPw0-SBEl_B8wh5fvDEyvggLQu9HNzDbU0bSLeEeEO5p0TBOLGc8K0a0CCKxp9kX9AY7udj2c5Pedw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hZRtaB7T7zJy0SYVQhFboc1Quwfo7N4ZQQVQepyo3SXYePSG5z6txg>
    <xmx:hZRtaPWNE90PVvbxZM3C3bDNGERswbdvvU9x9kQ1z5jBxMus2bRSmA>
    <xmx:hZRtaJKLwM_yGZJN4t2hrk88kXupeiBHfLuEpy5C0ixzBwy3Vp_F_Q>
    <xmx:hZRtaBuAxDCDPBO1kHBchow8x1tWv3dDixEqITkpk9No7zhArRgTqA>
    <xmx:hZRtaBRo1z8JE3t7k1ApIaiDDB3SrNhD26ouZCcsSW_YN4fsS7y8XiYh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 17:58:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <20250708091738.4072857-1-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 8 Jul 2025 11:17:38 +0200")
References: <20250619133630.727274-1-christian.couder@gmail.com>
	<20250708091738.4072857-1-christian.couder@gmail.com>
Date: Tue, 08 Jul 2025 14:58:27 -0700
Message-ID: <xmqqv7o2s5to.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A recent commit, d9cb0e6ff8 (fast-export, fast-import: add support for
> signed-commits, 2025-03-10), added support for signed commits to
> fast-export and fast-import.
> ...
> It could be even better to be able to import more than one signature
> on the SHA-1 object and on the SHA-256 object, but other parts of
> Git don't handle that well for now, so this is left for future
> improvements.
>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>
> This v5 is similar in spirit to v4, especially the format of the
> "gpgsig ..." command didn't change, but there are a number of
> improvements:
>
>   - All the signatures are now exported. On the import side, still at
>     most one signature for SHA-1 and one for SHA-256 are imported (and
>     a warning is still emitted for additional signatures) though.
>
>   - The code makes sure each signature ends with a LF character. While
>     this is not mandatory, it is encouraged and makes the output more
>     human readable and 'grep'able.
>
>   - A test with both a SHA-1 and a SHA-256 signature on the same
>     commit has been added.
>
>   - Some tests check that either "sha1" or "sha256" is in the "gpgsig
>     ..."  command instead of matching "sha(1|256)".
>
>   - The format of the "gpgsig ..." command is better explained both in
>     the commit message and in the fast-import documentation.
>
>   - There are some typo fixes, lines wrapped, and a few other such
>     small changes.

Thanks.  Will queue.
