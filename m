Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5382F3E
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121481; cv=none; b=HJEmvhesftB66A2zNbvAIwYL0EQWxF/gsWZVutTazBWlWlH6IuOb7x5hzfjGELoSdEFy9uKBRvmClcjCrOqqmlHjfomqRvB0wFY33ZSGK8Ban/2bgLkIbEJMekL3/qrK52BsTWVAjnKL/wydwx5l9fMYTtKmVhUGf9cuupn9qMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121481; c=relaxed/simple;
	bh=VNMcKqjZuGiQFsy9H+fmytwcRrBlax68r+fln6vW65E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YrLqxkU2ZGp3DfM48TiG4uUYeEn3lAydhyeJvVf2b7zoIK+G1w9dlWd8zCWYZNxi0vhLrz6IBnp+kdthVYmBOqDx+tIZcH8fn4RWVzDMhcdp5sf9ynwFEEOUX9vT3Ba1HR5PxbfWyL9sTOn9VUiQxi3vWeuK0sMI+qBk/M7Ic/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fWPbDNep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tq/3kJ7Q; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fWPbDNep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tq/3kJ7Q"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 30D211D000F6;
	Thu, 10 Jul 2025 00:24:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 10 Jul 2025 00:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752121478;
	 x=1752207878; bh=oLW/XZN8vaR/q+f69dJ8JFSXkqgb+GpQHYLUK2hd69g=; b=
	fWPbDNepqLv4Auaxa8sHdEz+5xU8bmLy7d2q9exxqPogRrBmRzXyhNTO9TxEDu4l
	MEF0fF8cyjuu7yL5+6xTR+F8bzpC2/Aej/lB3B+ZEeUCkIuGn31D1HYQYdVyLOmQ
	oQwktqnO46c2jq9Qt3aPS0BuQ3IkPfL3jPHI+9WBzE7IlDjZWUBZ3obbeOtFVbpE
	Zr/ZnASDE+dwB6Tyyba/1EyiBSAnZhCzyaPqK4tSbNQ6NFNRFMgNXQ+WlQXrvad7
	Horcy3605CR/JVVeQYqyKTMeg1vhpsCQEGKCwzDywEYHn6MCkS6Uce2+WjPP6wob
	N2MVXGUUH03qz5FHuiDPVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752121478; x=
	1752207878; bh=oLW/XZN8vaR/q+f69dJ8JFSXkqgb+GpQHYLUK2hd69g=; b=T
	q/3kJ7QrG1HjPqrYCa9cdPvL6NrZKYKPVFwSOSINtcmqTje32MJRE8thXdy/hB+Y
	um1MxB++QHCBYIa00c/cAjJ2S9HDrNPvY7ZVhJAUXaVmSzZ/0NV1Hva72lI7+8MM
	UMWJWw64hy0odmNwB0gzqjscxVA4ZfnR7ygkkm7W1aLwcH80hhr5Atlnfvxsuhw8
	ug4HRjfmLOdsaZXI3PvDU/OwptEWcL4R884xHP8QohX79QfLol3kxnz1Q2j41gm0
	Q0LPnm4LI9JFuC0nNpYvsZK1uzr7+LcFBEeeS7j1KbiVyVSKPOYfw7wF/5zBdvn8
	1xQoCQEBU3plTr6uCLxpg==
X-ME-Sender: <xms:hUBvaCl84Rah4mgTnNdheB4OcSmkdvvSLAJsZM0TLs-nDrO80KOzAw>
    <xme:hUBvaFVGbfq_Oac1vWMxS__kkWgvjycT3duVEXq7cgbq3wLoi2Xs1STI28EEZHg8F
    Im7sK2ewqgOLy9pnw>
X-ME-Received: <xmr:hUBvaHF6tN83oSiywJFvgnQTOF3NaxesR5OG45ip6rNIY-Y0FVWYn1QnTq5nlwn6Q-jf5pwXOEOoTuKERrT6AC3AN57pENFuvWdtdzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hUBvaBdlG3lE4S-WZUNrBmuBMiWFsZtDv-CktXv3P9ba_gIc4a7FtA>
    <xmx:hUBvaIIOrVS4GFZxj_biycoofaA6Fy77jMiPwTACY8yrCcFdocbiYQ>
    <xmx:hUBvaGFByfpY0Lw_T99FSsUVT2Q76q_6g9aBqNI5lWNoJshYKzKY6g>
    <xmx:hUBvaLA9S_OkEmRaU0zioJy9enIHsteqhn1BgTaAEbLeQSjHt_MwEA>
    <xmx:hkBvaKg7ao8zA4wuRCHMwyy8kfArhSLlEOmuFv5ju5soEkY-8F_75GUV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 00:24:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
In-Reply-To: <CABPp-BHRf52jD31ioiDj_j9eOkZk0sHxPUi1ew=m3UPd+N57OQ@mail.gmail.com>
	(Elijah Newren's message of "Wed, 9 Jul 2025 18:05:16 -0700")
References: <xmqqplebzgm7.fsf@gitster.g> <aG6A19ZgxwpdJuow@nand.local>
	<xmqqecuoap89.fsf@gitster.g>
	<CABPp-BHRf52jD31ioiDj_j9eOkZk0sHxPUi1ew=m3UPd+N57OQ@mail.gmail.com>
Date: Wed, 09 Jul 2025 21:24:36 -0700
Message-ID: <xmqq4ivkad17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Wed, Jul 9, 2025 at 5:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> >> * tb/midx-avoid-cruft-packs (2025-06-23) 9 commits
>> >>  - repack: exclude cruft pack(s) from the MIDX where possible
>> >>  - pack-objects: introduce '--stdin-packs=follow'
>> >>  - pack-objects: swap 'show_{object,commit}_pack_hint'
>> >>  - pack-objects: fix typo in 'show_object_pack_hint()'
>> >>  - pack-objects: perform name-hash traversal for unpacked objects
>> >>  - pack-objects: declare 'rev_info' for '--stdin-packs' earlier
>> >>  - pack-objects: factor out handling '--stdin-packs'
>> >>  - pack-objects: limit scope in 'add_object_entry_from_pack()'
>> >>  - pack-objects: use standard option incompatibility functions
>> >>
>> >>  "pack-objects" has been taught to avoid pointing into objects in
>> >>  cruft packs from midx.
>> >>
>> >>  Will merge to 'next'?
>> >>  source: <cover.1750717921.git.me@ttaylorr.com>
>> >
>> > I think that this one is ready to go. Since Elijah and Peff last
>> > reviewed it, it hasn't changed substantially (other than a few
>> > bugfix-related changes that were discovered while rolling this out at
>> > GitHub).
>> >
>> > The series has been running on GitHub's production infrastructure for
>> > the last month or two without issue, so I think this is good from a
>> > stability perspective.
>> >
>> > I've CC'd Elijah and Peff here, since they were the last two to review
>> > the series, but I don't think that they have any objections to this
>> > moving along.
>>
>> OK.  As they both seem to be active, let me wait for a bit and then
>> mark it for 'next' unless we hear anything unexpected.
>>
>> Thanks.
>
> Yep, I think this version is good to merge to next; thanks.

Thanks.
