Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C928DF21
	for <git@vger.kernel.org>; Wed,  7 May 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645650; cv=none; b=DSckAFBHSs7hu6U86AH4nCFowbzcBOzEpyPmwD++16nXYQEPL+SdqxXlgLAwgfxXMW49w2J+rPBrjC8K9KAi2WTzk1tm5wgiCXThLrfTjYF3Mc4ZeZsP5HpP1K5IuY8WX45VFjmE+rScc8w82QgfXyk743HKwfgB8359d0ip+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645650; c=relaxed/simple;
	bh=H+TOht/JefV21b8Yj+V3cdR4d+lzfGUTRxvjdtNk6Z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G3Qg59ca0R+m0/1/Kd7ph8CelJ9VaKQdB81ILJCOlaArKgz4g2lYGNmo+GMY7JJJdtRKhN4mN9h2qLsgw0bOZ3ixEtswkUD4DQULHSV3mjKeflYHXgRk8Jc2RpS3oMYKQC/LaEv0YMMBWhVXAjtaG3WDk8AfzcocS4JCBKGcri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SEpvcPh5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DSeaBiOQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SEpvcPh5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DSeaBiOQ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 58360138010C;
	Wed,  7 May 2025 15:20:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 07 May 2025 15:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746645647;
	 x=1746732047; bh=OmEC/XwBlhgLSNeiDUWjxk2FgzrYPkk6s1GRfhVBZLU=; b=
	SEpvcPh5l3yQC/p+LMrLSLgXbixgL7YMCcheFnkyxI5Gqx4DrhT2b9MSNpr7FEjw
	y/cZiLDqivxwcrrUuoD6Osef6QrCZ+Jo3t9jsgfI2i6YgFSLYJBMnLx+zvsSBMQl
	/nvgf8GFOye3ORuV7K0Tl3BirWYnEHYgue00nXcOSbBOcNVmfyeS/D/HVGd0nyA0
	CEtm/C3gzTA2D0PtI6Bou76GiBEi3oWvfV7HNzNH0OcOfXd6Ys51fd0UK09smWSi
	OkRwcBMzMYaF2YfhdX7GxdrBCT418DNLh65QZZAR5gAOocSBc97NpEdJDVOWk/4f
	HVPqG/jXRyBKejkWqS5kJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746645647; x=
	1746732047; bh=OmEC/XwBlhgLSNeiDUWjxk2FgzrYPkk6s1GRfhVBZLU=; b=D
	SeaBiOQWRFdUnpJIJv6AfLSyFwYnwmeLHjO7ii+/4h5uxmnj90DDIVQhBcyw49Qb
	beJFlJUV9yx0rTzrus3bkv7pO7rDjjgWB9/4UWXpAQfID6Xr5qFlz8motags7o/U
	3wcmZT7D3NCsPZATXEBnS804YjXfCTIDVDSLmmVEOqIrasuVNXycgqg7CFQlFX1o
	Su+zrfkt1s8UsmMHNyfX/6MvIGiRuGtMN0H0O1bP3M96cJsqzPdxIN5mB+FhJiD3
	x7olrJ7JpnyjfUk18EkLo16g8uOxUrapaZQK2WqG9kVb+QA3e+cyUTxc+VxygFNg
	ZXNCVsL/eUhqc1AA/xYCA==
X-ME-Sender: <xms:jrIbaPYtOeiHAMp3kKxAsz3P7xLaM2xBfyWVhi4XWOUUDeSrFxCviA>
    <xme:jrIbaOaxYTo0HMrDVqDY8zDMrNzuTe4WWDZDeCxbHuDLyGhMrzlCmfCVTLGcqT7ty
    dTQdDk9UkD68s4Fvg>
X-ME-Received: <xmr:jrIbaB-71QxxCh7qO7a9-Aum_QCug0W8ukFLs9FKcZfE9wmxES4Ov3FdCa5vHlX3D5beGzddycD75vnsLND30Z581bfVcWyEorlZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurghmsegu
    ihhnfihoohguihgvrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjoh
    hnvghsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jrIbaFrylSSSROpcRqwg7DGeArxhgFb_GnKt6ffWaTtkgalpMjSJ0Q>
    <xmx:jrIbaKrQ0P5e0DdHMZYL9usFjjLuKYi75Ef1S_RFWCwVNtqO2kFEAw>
    <xmx:jrIbaLQwAGSmutXTiUWCbtnXW4qa8zi5g38GMmFeKkP9rhSZfnd-7A>
    <xmx:jrIbaCoGZDBK7PTCohyWEc5hQtJLkLxw_YxfXVXOiigb8iGucpzJFA>
    <xmx:j7IbaHpusL-UGBHSnIeD3BF5qBsXH91U1kVTO-jyeCvI9yZP65sCSyLt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 15:20:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Jeff King" <peff@peff.net>,  "Patrick Steinhardt" <ps@pks.im>,
  git@vger.kernel.org,  "Adam Dinwoodie" <adam@dinwoodie.org>,  "Ramsay
 Jones" <ramsay@ramsayjones.plus.com>,  "Taylor Blau" <me@ttaylorr.com>
Subject: Re: Comment trailers vs. bracketed lines
In-Reply-To: <ae56dc14-bbae-4d5e-a890-20735131d484@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 20 Oct 2024 19:08:24 +0200")
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
	<658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
	<20241018052952.GE2408674@coredump.intra.peff.net>
	<71e8e44e-dbf9-482e-a351-3a82aa1ca5dd@app.fastmail.com>
	<20241019212135.GB589728@coredump.intra.peff.net>
	<ae56dc14-bbae-4d5e-a890-20735131d484@app.fastmail.com>
Date: Wed, 07 May 2025 12:20:44 -0700
Message-ID: <xmqqv7qcb52r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> I think in the usual trailer order, it would be:
>>
>>   Signed-off-by: Ramsay
>>   [jk: add commit message]
>>   Signed-off-by: me
>>
>> but I didn't want to forge his S-o-b without asking first.
>
> I’ve seen those brackets in the log.  They used to happen with some
> regularity.  At first it made sense since you need a free-form area to
> both comment and tell everyone that you left the comment.  And a trailer
> doesn’t make sense for that, I thought.[1]
>
> But thinking about the signoff requirement: you already have all the
> information you need from the next trailer, namely the signoff.  In
> other words this:
>
>     [kh: Added tests]
>     Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Has the same information as this:
>
>     Comment: Added tests
>     Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Because the signoff order tells you who left the comment.  So I was
> wondering to myself why this uniform approach wasn’t used.

Simply because we already saw another project like the kernel use
the [initial: comment] convention, I think.  The "25% rule" was
originally added specifically to accomdate this kind of comments
frequently used in the kernel project, if I am not mistaken.

We see too many 'jk' and 'js' in the project so the initial may not
be all that meaningful if added and it usually is obvious who did
what without, but even with three letter initial,

    [khh: Added tests]
    Comment: Added tests

the existing convention is still shorter than with your "Comment: "
prefix ;-)
