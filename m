Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402532641CA
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024409; cv=none; b=tV2q3/b33f6MeDyxcnvSXf1zsB7W8PzXVSu2D34xsQl4xtL17hYDWK4ZGA0jngD4C0Pho/c1ytIlSjvLCVnWP+xv24jUlYxNnppugjvgJ7QYtGl+Z4UpFPzVwM9HHkGG7EvCTNZTjoVf4cDbwTM5wva8/4wV2dhZrOjpxDq4ZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024409; c=relaxed/simple;
	bh=Jh1dMXDOUHQfqNHXq7D/WkwjPRCoDzR0i+C5Tn5W3+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V3AzKRguB0LSQDXGikcRBacaFl8+Ef3z2czsEg/7a2Hze9gR7lL6dwnR1BJU3/FZmCFVxBZFojALyXbWYC51rqUnFJ834rzL259dxM31DMflsEyhSZDFom8Ey/XFWd17hU5rC+8tzYYr1j6QYrejAiD4gJDeGLURl6xUyJ3B5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q4Q0V8sU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBTCccJp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q4Q0V8sU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBTCccJp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 605897A012F;
	Fri, 20 Mar 2026 12:33:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 20 Mar 2026 12:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774024407;
	 x=1774110807; bh=DYh/bWOLVo18FO28E5CIi4/lKqeF+oyovCUvZlyus8g=; b=
	Q4Q0V8sUpu+p4qQTOyUzRAODx+GsJkfvikkBfevvFvVixHSCjzlIlndUh4bua+mi
	cwlcBwnJ79QbzB5I0WiKytuWjKXmisVkRVV6/LUDCp7dE35pREtt7bi9GMKiJQ+K
	aMxOffWXvhW0mmVMJOt4eVpgQSkpTdRBcVZOmPMw8A40I5ziqfWqLJwSMU6T4mw5
	s74GusinhXqKJH0e6HZUW24aJEm8tdNklJTr06zXumBppOPQ4gMQYJHkaq4Tpxxn
	zjipIRdJeqPq3XqF8jacbryQalN37WGdHhhYgEUER7M7TdH7U2Ix0NLVrh99Cads
	vbL0KbGA9Ruib4jrJcjTMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774024407; x=
	1774110807; bh=DYh/bWOLVo18FO28E5CIi4/lKqeF+oyovCUvZlyus8g=; b=I
	BTCccJpVjp5jMZXwKcSXnm2klW1eU4VeEEuxPffEN9AhHBKv9NIZf6usbKJKcOyf
	/geFXfFkjFRRTnPXU3FtMpGJSRu2VF23RIl7HM4JLsjY0Nu4ZecU7v66OWMvSEQe
	K/ikWx3OmaSZCOnDLmMoI/hP+zkzKhF81CNnydZYlhNwvClXkJbLa3e5GpE+GJAZ
	kwdxV8qZgD5Hy62V/jgWKkJo+CaIF368RijSHjlT5SQVXRn6NMLsRyp7mJjKecFD
	kqfMNdKeBtI6N/8qlGvMfadB9kE0UoWYgQQoQky5Hk6io+yw/aGtbM7bjDn0fU5n
	ApttyL4j9mD0h12DjYq/w==
X-ME-Sender: <xms:13a9aQ13_kD9_gmkj0Ti7XwPTWqEiLTCcv9c94M1oxgD06OVvTLdwA>
    <xme:13a9aSEfebQAELMYYofF6lkoD20ezcVCpxzQf8JPJ1rMRTp5MaIlKUf7gjjwqHpEI
    8Uc8GpXDyFFSj8uZnvnr0ANvTgJgM7Psbm3SuSl1ppFVoshl-DQ>
X-ME-Received: <xmr:13a9ad7032dgGjtb1BouU_rRj9mIg85Sx6sKa3mtIimRuF7iNGMI-SmlcOCIUwS1Tk6I9UGdhLNvmIaJuz1NAtGvZXsGyhQcGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:13a9aYvEIopzbcPuJ86gV3o0g28r2jAt0KnMHUsWje8nEU8XScJTsQ>
    <xmx:13a9ae7Gx3SlZOqd6JoO-V6CrYPR2JSKQTvlO_SjYsvh6cJlHpsoDg>
    <xmx:13a9aTXVx0u2qtk322MILrRgqBa20E3kLXecDbw6S30zKvS449vTAg>
    <xmx:13a9aQ95atimvvpiRUMBJTBZ8VeXtRcq_15gueJ2bYLHmaI7_NaYRQ>
    <xmx:13a9aWOQBGRF0yBrBr_r4mrRhbrBKYJZnWD_VyFLLTRE6afecvTAd3hP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 12:33:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH] regex: not all macOS platforms seem to have REG_ENHANCED
In-Reply-To: <5b8e24c2-452c-486e-a143-386e06a75e03@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 20 Mar 2026 12:12:00 +0100")
References: <xmqq8qbnigxp.fsf@gitster.g>
	<6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de>
	<77b6ec9f-46a5-1f38-9733-188e20da55ec@gmx.de>
	<d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de>
	<5b8e24c2-452c-486e-a143-386e06a75e03@web.de>
Date: Fri, 20 Mar 2026 09:33:25 -0700
Message-ID: <xmqqldfmfokq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>> The net effect is that `CC=clang` in CI now silently resolves to
>> Homebrew's LLVM 15.0.7 clang instead of Apple's system clang (Apple
>> clang 15.0.0, bundled with Xcode 15.4).  The runner image README
>> confirms this: the reported "Clang/LLVM" version flipped from 15.0.0 to
>> 15.0.7 between image releases, matching the Homebrew LLVM version
>> exactly.
>
> Good find!

Indeed.  So clang got updated pretty recently (CI runs triggered by
my pushing out happens at least once a day and yesterday was the
first time I saw this failure), and that is because Homebrew got
updated?

>> Homebrew's LLVM clang uses different include paths from Apple's clang.
>> In particular, the `regex.h` it sees does not define `REG_ENHANCED`,
>> which is an Apple-specific extension present in the macOS SDK headers
>> since at least macOS 10.12.  The Makefile unconditionally sets
>> `USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS` for all Darwin builds via
>> `config.mak.uname`, which pulls in `compat/regcomp_enhanced.c`, which
>> references `REG_ENHANCED`, hence the build failure.
>
> I suspect it uses the same regex.h.  The definition of REG_ENHANCED is
> gated by a __MAC_OS_X_VERSION_MIN_REQUIRED check, though, and that fails
> because __MAC_OS_X_VERSION_MIN_REQUIRED is defined as
> __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__ and that one in turn is not
> defined by the Homebrew version of clang in the runner.

> Or how about using /usr/bin/clang explicitly on macOS instead of any old
> clang from $PATH?  That would avoid user-visible changes.

If it gives us more stability of CI environment (one fewer thing
that can suddenly change the toolset), and makes the environment
closer to a typical end-user set-up (hopefully most of them would
use what is available in /usr/bin from there, instead of downloading
newer versions but possibly built with different/castrated set of
features), that does look like an attractive alternative to me.


