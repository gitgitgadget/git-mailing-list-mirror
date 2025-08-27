Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F50189
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252886; cv=none; b=T7qeyiy7IfzFlyU2XHTVTUM+A1Wvq+uoEibMUj0jd3fGwHf5qpVIVOjotuvHaKH2StTgqcTYJqxO/ivfOQduvxVNdPzhd0MEEc6/YhAYznqr+XEmYI9QOL/s3jolWWCzsLw0zyxzDpUUVjKoiZ//cGhyxuT1Jexa8vizgltnsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252886; c=relaxed/simple;
	bh=x+ZkeAmzyFTBgEiXWeTuMZHnUuxQ8LF4MnrJhDmRWv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mTh3+tbEte7ZGVF8X0rWB3v9x67PlPhyYY3MkO8FnSvTaqliJldWy2cGC46+4CDrHLueg1hWocYyrWjU4+Y4nnOUTGLHsDn8qmdD7+JSxaCXJPhISM5tZIkxY3l7iuAceB+buOfQr1NBKiLsH14I7B19LXHVKOo7qGpf/YY76tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RV1x/jRl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nY8oGOu/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RV1x/jRl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nY8oGOu/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C5C7140004B;
	Tue, 26 Aug 2025 20:01:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 26 Aug 2025 20:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756252884;
	 x=1756339284; bh=/QiTufGTtXebLBMQwiplrQtAY0hOIR+wa1s7WJbx9ZY=; b=
	RV1x/jRlQJA2qRvc/bWfZFg5Pr4Tw8RB3Vf3ag1ts3llfsuzwr3bAoM4BV98NitK
	EPf3DZ5223ZMAqhG4V6oLqKqG+4ZxeLJ40dSj8/3vK8qhq1kRDbwjAdosWoJUjuw
	H0BkiagkyJELVdVRh0agcO1SWCi17ZLQm0i+zENTM6f7hMm8dqJQ/ZZhO/UmwS5H
	iVhiQYSJlxYrks9x9tV1m4XR7GT5PU/EwxvvO5NEuU6YvS7JEE6O6sYt0LbdX43C
	pOojRT8bmAK4ByzpQrC83/VX1NvjaYjVhHnFGKm7UdK192RE4K1GTKxPN0Y8fDqL
	qXEQkxUZAXz0A9nDjZ8Qfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756252884; x=
	1756339284; bh=/QiTufGTtXebLBMQwiplrQtAY0hOIR+wa1s7WJbx9ZY=; b=n
	Y8oGOu/5actxboGtCKsSIyU6RqPIg9i/N6xegWwfa2lv8u6wDq3dycCvf/HDabr9
	A2E6giOVoteA/4bOGYmXTMpZxJo5JRjWITOEF0r9tkOVqo/gswaSJA5U0/6hpOvw
	JJETZLov8Wb5GPeWzMCVfvPd+0cQLZ6zNbcdtA3IU7944kP3aT0u/my23jeJstHN
	ekMyQiPCQQWT2ylsnHXOemr6oW4Xpzpk4ZfpJ0EE6yxHmi6iYFwAuM0Xp3SmUMCm
	EMjFosuZ8Zn9qBsHZ7WSTc+P+ZqiigiNLwcaQ8kOxKdyz0RVsv1nejud54iYQCfa
	PmpyJGII6CkM3GZV/e3sA==
X-ME-Sender: <xms:1EquaMRZr-6Ce85WMS2LI3ccmFwQHsldbt2JdXeBVu2iAZLNMaqF6Q>
    <xme:1EquaDxu6FhH3BF-b94EQFBv8YfBD4rxLwozx5HtxtHE2LyLs29IourYfZI7uGrhQ
    z9WriaxEvvMy6gYnA>
X-ME-Received: <xmr:1EquaAdmj32zCo4VDglpvxt0hSFa2EkEZtFGWmMHOe_kAt9ppIN-iyVl2GEK_icOIVm-UGxrMfBd_Iz9l7bsA2SsJJRgUqpRLuC5UgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeiieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1EquaOO45Ez2xESlosdLa11z_4d0u-PGC7UYnw0jHIk1S3_LprOgpg>
    <xmx:1EquaDv7hQl4692BCUhlGPPqdCwYx3VlxdDpTz6R3ZURLTgIQD95ew>
    <xmx:1EquaHDa2mSwNM0FlBHzTZYyr2oRsKlR-LlMCfXe4F95RHh8sgOASQ>
    <xmx:1EquaKZ2zZeED72TqEmbx-6-tz-brRz2Ove_VCzoLfi4Mjp74Sx9DA>
    <xmx:1EquaKlPmoY1Vzr1VWETBrfFdhI4m-bM4SnAV27X4Sz9wNBWmUVJR9F6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 20:01:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: David Aguilar <davvid@gmail.com>,  git@vger.kernel.org,  Ezekiel Newren
 <ezekielnewren@gmail.com>,  Josh Steadmon <steadmon@google.com>,  Calvin
 Wan <calvinwan@google.com>,  rsbecker@nexbridge.com
Subject: Re: [PATCH v2] Makefile: build libgit-rs and libgit-sys serially
In-Reply-To: <CAO_smViX+EVyq5AzO3dwfcBGdenuZ1w89ksse=6MXYv8xi+q1g@mail.gmail.com>
	(Kyle Lippincott's message of "Tue, 26 Aug 2025 16:48:07 -0700")
References: <xmqq7byqkp3p.fsf@gitster.g>
	<20250826233525.2635432-1-davvid@gmail.com>
	<CAO_smViX+EVyq5AzO3dwfcBGdenuZ1w89ksse=6MXYv8xi+q1g@mail.gmail.com>
Date: Tue, 26 Aug 2025 17:01:22 -0700
Message-ID: <xmqqh5xtfx9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Kyle Lippincott <spectral@google.com> writes:

> On Tue, Aug 26, 2025 at 4:35 PM David Aguilar <davvid@gmail.com> wrote:
>>
>> "make -JN" with INCLUDE_LIBGIT_RS enabled causes cargo lock warnings
>> and can trigger ld errors during the build.
>>
>> The build errors are caused by two inner "make" invocations getting
>> triggered concurrently: once inside of libgit-sys and another inside of
>> libgit-rs.
>>
>> Make libgit-rs depend on libgit-sys so that "make" prevents them
>> from running concurrently. Apply the same logic to the test invocations.
>> Use cargo's "--manifest-path" option instead of "cd" in the recipes.
>> ....
>> +       $(QUIET)cargo test --manifest-path ../contrib/libgit-sys/Cargo.toml
>> +libgit-rs-test: libgit-sys-test
>> +       $(QUIET)cargo test --manifest-path ../contrib/libgit-rs/Cargo.toml
>>  ifdef INCLUDE_LIBGIT_RS
>> -all:: libgit-sys-test libgit-rs-test
>> +all:: libgit-rs-test
>>  endif
>> --
>> 2.50.0.7.ge90cf88798
>
> This version looks good to me, thanks!

Thanks, both.  Will apply.
