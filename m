Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44CF4C8F
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363962; cv=none; b=ek5Qk0Oqp+umNhBhvLf8kw/pZOtuabR3mwLAzX7PNt2EittXCOmYvwbxERRBUj3QAyERbpSZn0FtDHPN2oI2raj5+nfzGcsHoIrM/fZEssa8dNsI4LY6NQBNOiO3D3Xuo5QHsGFib8vbOLME0ySIQ8PDY6M6CRMQ+H7Z7Y+y3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363962; c=relaxed/simple;
	bh=985pyhkC5Ld6KoyCzJXpxUePsmtYFEyGjNTASQ0dq5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrbzTy2jMMiEW6WBOV9v0h3k3omFNn36LhziITKcj9bA84dJfIwel15CMy/abf9OXXAKmBSsoQonT6n9Fmc14XMeILtaiMbW9uKeuSeqsB6PhQtZ/nOTKzwkUpnzIpPtMjUZvVpjdBu++pfzcT93p6qLIjqkePGeRYBuvbxVarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M1b9RZKJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JN8nVAiU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M1b9RZKJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JN8nVAiU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A7CC1138028B;
	Fri, 11 Apr 2025 05:32:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Apr 2025 05:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744363959; x=1744450359; bh=vQekjg6H/0
	JMFyLQnHdG/8iupf7MzzF27MuZV86xd3M=; b=M1b9RZKJR+7MApXogPedIcS952
	D11O0jea3O4ZDvl3Bv645iuhp+QjQUGfrdBVLobrwsdfAK/VdH63wHtRkT0KaW5C
	QOI0kZCdvVRgJRvYxt/o1JJrC3rEH0FBOdO71Gsadl7v1shR6pAlhAArwi2xe1SI
	P3Aqi9jJiZX6ciSa2p55F66nLSf43BsEDpQTgBjZaBnn1MuT8swRBm7PUIs19axJ
	TD0/4L5BU054mrFsAMU2RFbHqDDLIzFynTsG2tUoFcOlecwn5hLqRRqIdLNtbn0P
	lX9wlgN0d2CGSRRxB2NUk6qR6CSuFZm5ORLCiU7OiM7WhBdF8mSQFdxo2SVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744363959; x=1744450359; bh=vQekjg6H/0JMFyLQnHdG/8iupf7MzzF27Mu
	ZV86xd3M=; b=JN8nVAiUqj9ZF12mHwWvJkTnsDPkkhPtKm4KAvsjHz1PwXMXFvU
	afgj+QYedOpiIgUjeKwBTnfgEtbp2dzzsUWXZcDF14/FFRIoi4BXk/NSIVKS5w7K
	RgXgAiUvRhZhrACaJkKUnx/ZwbkiktyfUHHnZRdElIkrD05pgLTwOH+lb1giWE6e
	yABaJmKfEYjHLlkFotESKfxT5lAe1KaWhRVCjNaId9aVgGkf9E0FneBanianmWza
	MuzngSSLNFTnXbgYbuhshhlIXYWagMgQEGBaMEWEgq8/V5oWIRUq0tEb+Htj1vr/
	coRz+XaKpd8m8tdValY8J2m/gVX7tyDZ0fA==
X-ME-Sender: <xms:t-H4Z-f8CfUMIcIyariopCJjtpcoe1-PKBa9JfG-MkmqCW-k1H8nkQ>
    <xme:t-H4Z4NUYg1s2UaLcHAfIWjjzjxz-rZtO0nu9ncm955lCxDEWyQHDgTkzMPbWIuD8
    5B1MGAZkDgdR_MRGw>
X-ME-Received: <xmr:t-H4Z_gF8IRrowsQ7UYrsgNcu-BtMDGvFtFXFx7XrUi54l5--yXcZEp6tyk9kqvdEhHXUzJ0dHm2-NXrCeSc6lOxxHPz4MU6ZeHpw0fWlJZm87k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnheptdehheelhedvtddvueejieejkefghedttdfghedv
    veehvedvheeukeeliedvkeefnecuffhomhgrihhnpehrvggrugihrdhpshenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    hhrhhishhtihgrnhesjhhohhhnshgvnhdrnhhopdhrtghpthhtoheprhgrmhhsrgihsehr
    rghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsghhrghtvggrrhhnrghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:t-H4Z7_GEhXMUpEDp5njrciJ8zd1qwL2WGociOCH3plgwi5sETU3jw>
    <xmx:t-H4Z6v95e06JAkO9-__Tt5F9RbrIBpoDbYSJHwcoeTWgWOew1oNyA>
    <xmx:t-H4ZyFAX5Gox9ZTawzb7QfelgdcPlQuMV_wyTfS2qj4i_tvw3HHpg>
    <xmx:t-H4Z5OFNajjmr3qwxnI2xkNYJHFaZiTq29CddK4X7fzTPF7SVPBeg>
    <xmx:t-H4Z-2LtsslfnKnZ68XgZpyxO4v0n5xM5c7CQC2PhG2HZiwlHLnaime>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:32:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e410ace (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:32:35 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:32:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Arnav Bhate <bhatearnav@gmail.com>,
	Christian Fredrik Johnsen <christian@johnsen.no>,
	=?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Karthik Nayak <karthik.188@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: "What's cooking" interim report
Message-ID: <Z_jhsVJi5U0qinbp@pks.im>
References: <xmqqy0w9orsn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0w9orsn.fsf@gitster.g>

On Wed, Apr 09, 2025 at 04:10:00PM -0700, Junio C Hamano wrote:
> [New Topics]
>  * ps/object-file-cleanup (2025-04-08) 10 commits
>   - object-store: merge "object-store-ll.h" and "object-store.h"
>   - object-store: remove global array of cached objects
>   - object: split out functions relating to object store subsystem
>   - object-file: split out functions relating to index subsystem
>   - object-file: split up concerns of `HASH_*` flags
>   - object-file: split out functions relating to object store subsystem
>   - object-file: move `xmmap()` into "wrapper.c"
>   - object-file: move `git_open_cloexec()` to "compat/open.c"
>   - object-file: move `safe_create_leading_directories()` into "dir.c"
>   - Merge branch 'ps/object-wo-the-repository' into ps/object-file-cleanup
>   (this branch uses ps/object-wo-the-repository.)
> 
>   Code clean-up.
> 
>   Will merge to 'next'?
>   cf. <xmqqsemiteot.fsf@gitster.g>
>   cf. <CABPp-BFv_WGVUexyQBHkCcyO0N+UQCcJ3eM9Oh6bP_ZCUkaxLw@mail.gmail.com>
>   source: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>

I have sent out v2 just now to fix a single grammar issue in a commit
message as pointed out by Elijah. So I think it's ready.

>  * ps/refname-avail-check-optim (2025-04-09) 1 commit
>   - refs/packed: fix BUG when seeking refs with UTF-8 characters
> 
>   Incorrect sorting of refs with bytes with high-bit set on platforms
>   with signed char led to a BUG, which has been corrected.
> 
>   Will merge to 'next'.
>   cf. <20250404205740.GA780449@coredump.intra.peff.net>
>   source: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>

Yup, makes sense.

>  * rj/build-tweaks (2025-04-09) 13 commits
>   - config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
>   - config.mak.uname: add arc4random to the cygwin build
>   - config.mak.uname: add sysinfo() configuration for cygwin
>   - builtin/gc.c: correct RAM calculation when using sysinfo
>   - config.mak.uname: add clock_gettime() to the cygwin build
>   - config.mak.uname: add HAVE_GETDELIM to the cygwin section
>   - config.mak.uname: only set NO_REGEX on cygwin for v1.7
>   - config.mak.uname: add a note about NO_STRLCPY for Linux
>   - Makefile: remove NEEDS_LIBRT build variable
>   - meson.build: set default help format to html on windows
>   - meson.build: only set build variables for non-default values
>   - Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
>   - meson.build: remove -DCURL_DISABLE_TYPECHECK
> 
>   Various build tweaks, including CSPRNG selection on some platforms.
> 
>   Comments?
>   source: <cover.1743859985.git.ramsay@ramsayjones.plus.com>

I'm currently traveling, so I didn't yet have time to review this. But I
do plan to do so on Monday.

Patrick
