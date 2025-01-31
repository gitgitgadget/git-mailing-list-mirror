Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D2482EB
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738354822; cv=none; b=YbWWvcmy5ZOASyJS5pqNc8Q3dGANsf4RekidwNbRiBYvufyzlxY8A/kw2a3uOUWWTDnTkeMTdGRa2BlDslbL838/ZQQwAwaOITlYP5wuWo3lJJV4Xsocv7RYme+1pFcE4Neu/Vtte4PoXDt5qw7dawNR9Os0ZeT+VMBGz0onN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738354822; c=relaxed/simple;
	bh=W2xGSoCyDahG2ZMLM4rqbmhRg2GC/INVyqNefrQwZDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rrToUczlUenD35SHmLvJEBiJsKAhHBDBnISsk45j4hPHTpuiSUJf5mA4RJenaeJmDdpTNJMgflLDD9C/9DrMp+145Vr98ljfyjmXFm0NA4pfnPHIk2MKktOJy0FlyAtqDxR2jhkvAMUWzp4bldlsirSNzL/Kw8lVCJ6jwaZqEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=md1ZiR+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nqda1jfO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="md1ZiR+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nqda1jfO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4529C1140102;
	Fri, 31 Jan 2025 15:20:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 31 Jan 2025 15:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738354819; x=1738441219; bh=xmjgY7ck9m
	qgVwQsBa5DQNTr4s4QAVx+ovxEWFC8lLc=; b=md1ZiR+Succ1fOsJy3qICQzB7l
	sY61R1E0cc68EKO88piiVExJJxJsr/9vqeOgMsRbCMpbG23CK9jh761KMRT8RdwQ
	Yra8vREiQrNEoQCswSP0RHtFu2SkD6oo2eYNjX0dSNOyMyDkR+VPCIajGtrQSoCQ
	mAYeKlb5cnAm33TlJe0MZZ9MdFXCxQP6WeyaVdwV50Pdq/Ht+/cOyDd03CHpSt1D
	dmtk2d7tr1Eamcbz6op5oLSFBQjPY1YF/CbHrNPsbGPMa71C0jgU59iweywp2zmG
	75bRmvo7DcWrUcGhF9UX/o23vojT5MXeq2Ur79gTDxCBxqtktyn794w8El/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738354819; x=1738441219; bh=xmjgY7ck9mqgVwQsBa5DQNTr4s4QAVx+ovx
	EWFC8lLc=; b=nqda1jfO80D2/C/hJ5xkGzKzQOaCLnMnxE/TMYZx9r1IySe2sDI
	3frAQsC683OAlX99hCRbiNZnBwRzdsTH1KXIuU3mEJBOOsY+CV837n2kOLOFnMt3
	3nRNhX9M/PPD6P0pOHnUHX9G+wDR0z/qg2Jt9FXgz1MmAapJ0wS03hmACBC1+Cc2
	ZlrUGsUMr+VIcDfYL4SE7rVkKLpHo2qBO/tyF/gy3/HnlZoD89vUHY3gLiD+5PMJ
	Og0nEI4fIO88ybVYkzg4Ujry6LBUxVBFCThM+ef5DLCtf9vfMuybS0jPWtHIA2lg
	itAwpsT3A70dQvcJCiD6fM0b0DLcRaV8DxQ==
X-ME-Sender: <xms:gjCdZ9p32LJ72gZ-0STnwPDQAYdlwzsiVMuaU72zPbRdyWP3xiAlSg>
    <xme:gjCdZ_r_xnL1hhWR4qI4aIrd-RHm6tqsd4hybmx2LbgYGRM51CLrTvtgGfj8URapK
    ph-qddWpvFStfysaw>
X-ME-Received: <xmr:gjCdZ6PxjWZVIgssUeqSaYa7z0Lez8J1ePGwPAwsD5KXMaYMHCAxm0ReyuBwzIxbUkSnmDqwtCsW8enb-V7q8ioK7g0RgmVHU-u1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeljeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhlghgrrdhpihhlih
    hpvghntghosehshhhophhifhihrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehlrdhsrdhrseifvggsrdgu
    vgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gjCdZ47Ar5Kw7cSPbK3hUUr5NtHih4MSbFTKImAwG0YD6jWDi0_7Bw>
    <xmx:gjCdZ85UAD_OzUfZTFyuehdF7M8SkFAzpt36c6cBw06fwwgiMwo7-w>
    <xmx:gjCdZwjMI3JAO-L01sqhl7yEukeMDjK8CuFb84qaH7_uYJ5thnWOOQ>
    <xmx:gjCdZ-6gijwraAiaZsD-IpLXL05ngLdhQfCoDqfaOesiaX0RJvIkSw>
    <xmx:gzCdZ-uIePtGMiIVXOKDMgvtCSrtPHX0iUoYu5IUZ9A6korVVD9VQeMI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 15:20:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olga Pilipenco <olga.pilipenco@shopify.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3] worktree: detect from secondary worktree if main
 worktree is bare
In-Reply-To: <CAFLeGL52tKmurpAHymk42Y9DGazbK8nRdtWAoyzW85eMDxJQhQ@mail.gmail.com>
	(Olga Pilipenco's message of "Fri, 31 Jan 2025 13:11:00 -0700")
References: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
	<pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com>
	<xmqqcyg294ft.fsf@gitster.g> <xmqq8qqq943u.fsf@gitster.g>
	<CAFLeGL52tKmurpAHymk42Y9DGazbK8nRdtWAoyzW85eMDxJQhQ@mail.gmail.com>
Date: Fri, 31 Jan 2025 12:20:17 -0800
Message-ID: <xmqq8qqq7n26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olga Pilipenco <olga.pilipenco@shopify.com> writes:

>> Perhaps the logic is clear to those who diagnosed the problem, wrote
>> the patch, and reviewed it, in which case there is no reason to
>> reroll.  Perhaps it was just me to whom it was not obvious that
>> the purpose of "is_current" check was not about "are we looking at
>> the main worktree" but was about "if we are not in the main worktree,
>> we need this extra check".
>>
>> Thanks.
>
> You did a great job figuring it out and I agree it's confusing at
> first, but we tried our best to make it less confusing.
> `is_current` check is actually not necessary there, but having it there saves
> extra unnecessary calculations, also describes & fixes the exact scenario
> that didn't work (not being able to see main worktree as bare from a
> secondary worktree).

If I had to do a great job there, then the code does deserve to be
explained a bit better for later developers who wonder why it is
written in the way it is, perhaps we a single-liner comment?

Thanks.
