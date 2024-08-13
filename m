Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A33184521
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541158; cv=none; b=QxYfI6Wk39W3phuVE2N9qSX43eHqcZDHG1SYVJxsQ4bQ2s0OId1TefziDiVnWJc3tCqDYihcF7FzXgH8cvrhxcU/hREycVyaz8TKcxJ9D4gUl2LVofvYF1OoWpF19tvf0YibuuuvzFqnpTEPlPYtL8xAj6em4QS7okk0gUGF4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541158; c=relaxed/simple;
	bh=F4jH6CRT/vroOHL7sCMDUwt+9DierHHEijeCMQ+HtNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZGEAxSByM/GJIVFoC3dsr18ywQ4NUQBEHt36D5sHE/5bQfvoP1K4Y75tMa/neUMp0GLnzWSDIEVExzESJewdqShN/G9nZsRcrRzBPTdzaMiGu3eyk7RFNF8tQyjZUjnKmjYPiNQ0v4+15Bv9/J+BoetHCtps0bwsqUnHkhJPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Phh91T1z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxV+xrz9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Phh91T1z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxV+xrz9"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 17166138FA55;
	Tue, 13 Aug 2024 05:25:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541156; x=1723627556; bh=051klr1Boj
	HW1ovFWBR0HjCxNL35F8IPUAS96Uc8wZI=; b=Phh91T1zzRgt7hUzyEdNstcSU4
	rE2LVoDfDb6rcV+tosWdU+AuzB7Zw2uPRcAe0A1GfAiOdp4Ly1ZkVjYxt/h9LOhw
	VEQtCr7i/AeJKBp1/B4ikP4/nbpG3VK6Xw2gZatpO83cVRjdY3t7hgch1Xzv+Wcm
	FF9oNLHPloGn1sMjv1N+8H3mzuOjhy3/6e64pmL28Z7ozM31o2+kGzF+o58iIlRy
	rWCiVCrgCYDi5vgxpyKQA2ja/AMgz8grrC0KoXgg4bbmsHJor38LBUPC623qC1ZW
	RjdwQ98WYtMmHvEGXEh0P8px58BtwCFQA36PR13bm56J+GePi1qJX1Re5GZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541156; x=1723627556; bh=051klr1BojHW1ovFWBR0HjCxNL35
	F8IPUAS96Uc8wZI=; b=RxV+xrz9UUgZ2zWLfjU+eg/wYaad4V/p5NDvsSZjW6fi
	xYwQbuJ1sTi8hhVbFJYHxyNEOsDvnrY5WxEnvd3CY4EhhrLF9Pjerw8mvMx9/h+B
	Y2l8bqNIjaYBUNUfP3x0H8GKXqEQeP/lBKddU6ZFiwFwVkqkislRYqKPiacB7yoU
	Lxeu+hUsv5Fp+bWmN98hmbiCRre2Qb5RDwZ4F5VKP2G1KKnX0IN4QsGOXb4kjSDa
	mb4ZrmYl1dlAI4LgQEfanb/UwfW1sFZInJ/8s4XklZ3O+a0gKQF24qpdGb3ujxF/
	qrbkUZlWF6nup9GlTE9Zy7GhlkvRqc/QckKkUiptjA==
X-ME-Sender: <xms:oya7ZnbqtOwM5JHs51YJfE9gZJ_wtYPV6nEhcVg-UzvuGNaXCNpvCg>
    <xme:oya7Zmb0axQRgYhdLBDNO3iZVHxGbCRVGwPGbzFWXMplJysfae-ATlk1i2dZ7wed5
    KR5ldP-4kl56enQqQ>
X-ME-Received: <xmr:oya7Zp8L82iR9dJ-DVXo639GNwfjVpC3tJu8aDsE0pUcozrmo3BxB5Q7oKGVFm7hQ9mBiVZ33NmN9xcTrqZE5uRYXzaTv5HjGeWn-Z2Ea_SE6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pCa7Zto4ZOlx3gl7Bj5IO5xDfk-SEA1QlnHPo-j7cVv-DGxZcE6ylQ>
    <xmx:pCa7ZirV-xvtAvdMwy0lRtov-NTNk1wK3NMJsMCFlcKDFgjaZtMMdg>
    <xmx:pCa7ZjQbXJsFZbmq5kiXx97z17eiNKwe36BjK6fqi2V1BfWqtdJIJg>
    <xmx:pCa7ZqreNYXszfJ1ds-5_-pnOj66sMlk9LOWJ32WQJu9wZUGhLth2Q>
    <xmx:pCa7Zp2duKZ7wycmtC3E3_5X3z8TkGvySywerk7y5igfsv2IKiL4vqVU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:25:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b776556c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:25:38 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:25:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/20] path: expose `do_git_path()` as `repo_git_pathv()`
Message-ID: <ZrsmoFK1nKzwSN2d@tanuki>
References: <cover.1723013714.git.ps@pks.im>
 <7ce3278f649ce70453242e5458d28c5fd54576ba.1723013714.git.ps@pks.im>
 <xl37sjpibmamkxdmpvfy44sijseuk5doizdlbnuodnbd6pdhxj@dws5e4wdu5lg>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xl37sjpibmamkxdmpvfy44sijseuk5doizdlbnuodnbd6pdhxj@dws5e4wdu5lg>

On Fri, Aug 09, 2024 at 11:58:31AM -0500, Justin Tobler wrote:
> On 24/08/07 08:56AM, Patrick Steinhardt wrote:
> > We're about to move functions of the "path" subsytem that do not use a
> 
> s/subsytem/subsystem/
> 
> > `struct repository` into "path.h" as static inlined functions. This will
> > require us to call `do_git_path()`, which is internal to "path.c".
> 
> So in other words, functions leveraging `the_repository` in "path.c" are
> going to be moved to "path.h". Since these functions depend on
> `do_git_path()`, we need to expose it. Makes sense so far.

Yup.

> > Expose the function as `repo_git_pathv()` to prepare for the change.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> [snip]
> > +/*
> > + * Print a path into the git directory of repository `repo` into the provided
> > + * buffer.
> > + */
> > +void repo_git_pathv(const struct repository *repo,
> > +		    const struct worktree *wt, struct strbuf *buf,
> > +		    const char *fmt, va_list args);
> > +
> 
> Out of curiousity, do we have a preferred convention for how functions
> accepting `va_list` are named? Searching through the codebase, I don't
> see a ton of consistency, but I have noticed examples prefixed with "v".

We of course have `strbuf_vaddf()` and the likes of `vsnprintf()` and
`xstrvmt()`, which indeed have the "v" as a prefix. But is
`repo_git_vpath()` better than `repo_git_pathv()` in this case here? I
dunno.

In any case, we already have `strbuf_git_common_pathv()`. So I'm leaning
more towards local consistency as opposed to global consistency. Even if
naming in our config interface feels like the wild west anyway.

Patrick
