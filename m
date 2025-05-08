Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA422797B2
	for <git@vger.kernel.org>; Thu,  8 May 2025 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735660; cv=none; b=mGYEoklS50kk7YbVHb5AmvDqK5qtSCLORXWn+xbWx1qxm4uFg0a8pev2QaF6NkxziP4hP69wU7CphFVGiF1Acg9svlbNAgObx51kz459RJqWGHhDOo8FN+WGnkBsMjvmM0azfFzN/B8EvU3leCR0GiZwle/qZ6+lGViOVoXURd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735660; c=relaxed/simple;
	bh=tKhCWnqHmwJxuLIK1lw/aUOp8kAa6DQnA74Wmn+ygp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RLgDZILqsfpre/hWF0E0DDSXDHzg1DeAn0mnxohX8vVzHYe6uCM4oreDdrBpDiqBHWd7quOY6SA9BySxf/+LemhJGIbcFGz1rLvfH2NpxjQxoq8qTpjoU/DxGv1x0Qu3u1/zo2VGuGBmATjBZOZt7lJneEgDpHevTc8vcG7gVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eAa28cQa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uvvu182Y; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eAa28cQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uvvu182Y"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AC64F114010E;
	Thu,  8 May 2025 16:20:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 08 May 2025 16:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746735656; x=1746822056; bh=AFNHHkYXNb
	z8dxzwoEn5dobL55obeN/SuvcHyWkFvTU=; b=eAa28cQa3eW8K87sMRFciAmL2F
	/uK/ff01oR/UD6uS2yxazHJ85d9ezo5CZU8GNz1YyzreBw2xXQADSyTAaqkT9aqt
	G+KQRw/fJOu+QTCnFHpHYTA3R0FxgVAdDt63cbx10W6PwlJdICqa1zw7uUTtkjvX
	EMumlFUJCHwypOcsTKAtiYtP6GwGZ5kgoEY8Hidtt52vV6mUP9Ova810KENrDmdO
	q9PdcK8SK+7tEkq5FIy5HQnQekRiAT/hJZxPz713fCxQPqrYQi1shqPg8l+Fg4tx
	BYMAnmHX2yMCWltv6YTo9Aq9I7/4TWqGUnGDz+Xn2D3dhRIuQKHREca6zLcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746735656; x=1746822056; bh=AFNHHkYXNbz8dxzwoEn5dobL55obeN/Suvc
	HyWkFvTU=; b=uvvu182Y7ewye/2ab3zCdK/e8O+tdNdS7GxyECG2EyM7zoHfN3M
	cDVtwOovFYlphWuH1s+E/i/rfFl794kkFnWJFtOlm8ef3QjLreDck+qze7TLPueH
	GfasMbHltXpKWJ1OSJO80+jftUo5M6w/F2USOOlCZC1O5dt8mGTJnMLA7iIasBK+
	nJk+BNdktDibmIbCQxyvdk7mxL68ShRo0xSGNMY2NAmfIV1pt59SZrqH7DJdB9r/
	josTKlB8mpxPD2tB4ieHxTFGZFLcBbSQq1/vDoJ+eRjs2Zbz7X9NAzzrQwFHa0Vi
	CfYrUKozWXT0kEMLiXYbEchVSH41OrqWP5w==
X-ME-Sender: <xms:KBIdaABp_nZTPEDSII3lu3pXeMjYAjo8C7vmL9rQ2NGc2TC8XWADzw>
    <xme:KBIdaCjRnlAztgrmZT1m-QqT7E3UrYittihU8P9EOv9sFtM91AbQN2g54CsZAD2eg
    nGBS68Psvr9_XfL9w>
X-ME-Received: <xmr:KBIdaDlWyXsoQ3JtH46OmvdBR7Nk2fwOP86gxpWna0pbdYkaGdDuqG_pkv3dr4W-7u1Opb9ChGGzrjPttncW9gap5uaVc14iC6C5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KBIdaGxYoMe4jKBfaj76QoRMtzg8v9HYwgs2epakuitnwv6yQR4usg>
    <xmx:KBIdaFRyinY4L22Ep4DWmoW0RdhMyMJjtYUj0FIv4aTkg8_9DF488A>
    <xmx:KBIdaBbCAJp7jSvRxAihqRXRwmwP2l-_fEsnB3XMag__yt-eMOlEnw>
    <xmx:KBIdaOT4l7MtzZZZbpPfhCVR5RcPAuHWvYz7g48GzOcrHAqezHH8jA>
    <xmx:KBIdaGunLfHlzHB4SBNcc9w2xqdPy2NUxfgMFtO4FdT717MLvZewUdgn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 16:20:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/4] align the behavior when opening "packed-refs"
In-Reply-To: <20250508200802.GC18229@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 8 May 2025 16:08:02 -0400")
References: <aBo7OiCKHTyT4DzH@ArchLinux> <aBtzn4nwLsI9p5Cp@ArchLinux>
	<xmqqv7qc9grt.fsf@gitster.g>
	<20250508200802.GC18229@coredump.intra.peff.net>
Date: Thu, 08 May 2025 13:20:54 -0700
Message-ID: <xmqqzffm4zx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, May 07, 2025 at 03:51:02PM -0700, Junio C Hamano wrote:
>
>> shejialuo <shejialuo@gmail.com> writes:
>> 
>> > Hi All:
>> >
>> > As discussed in [1], we need to use mmap mechanism to open large
>> > "packed_refs" file to save the memory usage. This patch mainly does the
>> > following things:
>> >
>> > 1: Fix an issue that we would report an error when the "packed-refs"
>> > file is empty, which does not align with the runtime behavior.
>> > 2-4: Extract some logic from the existing code and then use these
>> > created helper functions to let fsck code to use mmap necessarily
>> >
>> > [1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net
>> >
>> > Really thank Peff and Patrick to suggest me to do above change.
>> 
>> This round looks good to me.  Others?
>
> I left a few comments that I think bear addressing (or at least some
> discussion).

I found both of your points very good ones, especially the "why are
we making an in-core copy anyway later?"

Which may probably mean that munmap_temporary_snapshot() is not the
helper function we want in the code path, so one of the preliminary
refactoring patches can be removed.

Even on mmap-incapable platforms, we have enough emulation in
git_mmap() and git_munmap(), and this code path that wants to read a
packed-refs file just mmap(), do its thing, and then munmap(),
without worrying anything about "ah, temporary, so we need to make
an in-core copy for ourselves".

THanks.
