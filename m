Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964C28373
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831177; cv=none; b=lfbCIdTdzgNRGHiKdO5UMXT5orR7W/vZjhAOesXH5bWOFdU4F/RMbdmIUMaKaOuOXfT82LLIa0ySbxmytk+JBlgIqin4Usy/lCwHdciwQgpUij2r41btm/jriGGrMseg5b8xWuZwu//5D1+c+yTUYM89NDj6HMwC6HgQcEGL8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831177; c=relaxed/simple;
	bh=pxC+SoTlOPkhPTrwm4vkgW7JUI29W4fdF9z2IPExdtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJH3OsHBl000/b+foqoAWx6Ddr2ZkffQzz17a9gQtdGIR3DWQcrIDQ1CSn+DtG/v4vhiI7zgaQtbgvOg13Rqw8O9iJMcPtL2b50hkPHSXPQ3zCLH0wqj8yWrGTcEBiaDdk9ecfIe+PM24qC5ITMbCyScfsm6ZHMrW2+7/dNq8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L4mxhfh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHNPqET1; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L4mxhfh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHNPqET1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70CA425401F9;
	Wed, 16 Apr 2025 15:19:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 16 Apr 2025 15:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744831174; x=1744917574; bh=WGTZTi7EOg
	IAlKL2JN6t8Pf80/3ghfFs1Qzmj+r0tJk=; b=L4mxhfh4dBy/ff/LnIBvx5vl2t
	KEit5YZdWLXLpEZ+o+vzp0siR4C+SFbWVaFFlTkabc+DedruMp0EOyHuHInEaC1g
	hjZD3bSSLJXs/U/fDFUCKSrDvAK1uKl5qZLnCXBPr86jtv9G9isrAmnswH5/Wo4j
	IwUSNva1l/E/jfiNJrinzqDJAQh6NDQX93vYl5VtHT4MdBBawi7OR4xXJcNNKWs0
	xbrJKBnnZUYxtSJpE679yEj+m1TNie9hnRZ1BzRnWBw2NNG8H+Ggkc/xR/effbra
	YnDweSV+8R0zXfM8uhzIIwOaHyi2Gl/St7iax/h/CVMzX8IBh30iHLTVJZqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744831174; x=1744917574; bh=WGTZTi7EOgIAlKL2JN6t8Pf80/3ghfFs1Qz
	mj+r0tJk=; b=iHNPqET1jiR8/NpyDn2K/PqDx7wgEi+7VfPmN0xngIi7IPJArFK
	Uz3gkLg+VPviXEZetcZfQtZSivR7dyrJTGRxhgzq+6Onpg2xU43SM3OQtj4Eif0e
	8OC5f/h34qkE+vOZI9EKSvDTD0QDgAY10YgnkR0QBvl2SQ2cmksKoJ321/2VFoaU
	63/D9Gs/sFU5C+kQNDDpKKEaa4bUrzMPE0kR1rqLcey+d3uElFKzwJrfVuFy5LsN
	eyGBlLzXv9d0nwDCa8M829ltnu4BWwx8Dx3n8YavjpbGpxWKYKn/yi0zzVhHzTG1
	0TJ7V0Z35paEGvBtbp9WxC3kDIcTdfDXpeg==
X-ME-Sender: <xms:xQIAaL02ZwQf-dJ10Hoz21gJFfimWAMlVm4MBrt6ExkJ4wYYyG7D4w>
    <xme:xQIAaKE4Uj-WdirY7SgTvbtbEcf_-dnIQCIoaUFpohrQyQGVaONk-874WDSIjrCDg
    ASXdSs2t2faYSz_Sg>
X-ME-Received: <xmr:xQIAaL4ar54wDqM2oRASHrYefRGf2Y0LieKWDawYQmD4cJYVbvHYa2XLrA5n2lgyr3EiPNXYfsRI9kHZpCmQWwNAAMHwZcbfiCKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtph
    htthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdr
    uggvpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:xQIAaA2DoJIPfEMrUq0vcqnINRpM3jAMaXQpD5OmvE_xtfy2drZrVw>
    <xmx:xQIAaOE-Vfa_G1NyCtBg7kQU1AilHoVyfdJvhjBGHWx6Uc3gSmvI-A>
    <xmx:xQIAaB-IHA8DzPdD8bUW6OUsWXRBW8iX2zrBRlAZ4sWEz7SJ4v6-fA>
    <xmx:xQIAaLlgo-JPhhbfITgyp0uogx_mtbAydHGGosO3PplrwM5bYlDTQQ>
    <xmx:xgIAaFmGC99w9CdYNq-RKooNURKOAvXAPI6dce1JZ0BXDWlZ9yX_KeN8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 15:19:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Todd Zullinger <tmz@pobox.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Derrick
 Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 7/7] parse-options: introduce bounded integer options
In-Reply-To: <20250416-b4-pks-parse-options-integers-v3-7-d390746bea79@pks.im>
	(Patrick Steinhardt's message of "Wed, 16 Apr 2025 12:02:16 +0200")
References: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
	<20250416-b4-pks-parse-options-integers-v3-7-d390746bea79@pks.im>
Date: Wed, 16 Apr 2025 12:19:31 -0700
Message-ID: <xmqqsem7hq2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In the preceding commits we have introduced integer precisions. The
> precision merely tracks bounds of the underlying data types so that we
> don't try to for example write a `size_t` into an `unsigned`, which
> could otherwise cause out-of-bounds writes.
>
> Some options may have bounds that are stricter than the underlying data
> type. Right now, users of any such options would have to manually verify
> that the value passed to such an option is inside the expected bounds.
> This is rather tedious, and it leads to code duplication across sites
> that wish to perform such bounds checks.
>
> Introduce `OPT_*_BOUNDED()` options that alleviate this issue. Users
> can optionally specify both a lower and upper bound, and if set we will
> verify that the value passed by the user is in that range.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  parse-options.c               | 40 ++++++++++++++++++++++++++++-----
>  parse-options.h               | 52 +++++++++++++++++++++++++++++++++++++++++++
>  t/helper/test-parse-options.c |  5 +++++
>  t/t0040-parse-options.sh      | 33 +++++++++++++++++++++++++++
>  4 files changed, 125 insertions(+), 5 deletions(-)

It is certainly cute, but unless there are plenty of existing users
that use OPT_INTEGER() and friends and perform bounds checks
themselves, I am not sure if this can withstand YAGNI criticism.
And this step being at the end of the series, plus the above
diffstat, tells us that there aren't any existing users converted to
use this new mechanism.

OPT_INTEGER that wants to track percentage may want to say the value
is between 0 and 100 (inclusive), but instead we take it bounded not
to exceed 100, without lower bound.  Without a real callsite, we
cannot even tell if it is acceptable compromise for the sake of
simplicity to forbid 0 as lower or upper bound, for example.

Thanks.
