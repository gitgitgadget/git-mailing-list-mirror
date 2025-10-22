Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8DE3054CC
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169128; cv=none; b=rbQEyjwMqW350dS6yeM/fGC2tZhgIi5RBBuCTJ/xighIAFRhBHM+Pj/FSMlQO/5s+uH/Rcg8i+uiyRbZIcqfEEJzSMGmyttyup0yQ0BTQ1s1eXkiNu6dELG1wW9lA8Eo6IzxrEFtpDhgj6rQuckLz0NexVg4oX9rRNy8+7feTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169128; c=relaxed/simple;
	bh=dY1O6SncZ/4ooTDC1f3hbzlQKMdxQbaLrw+WzIkTGkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aaDu2m3OLiVh/XhvrQcb0gp9mJmpvVEhMBzhRGKvdKkwWvIbZ1XU8Y3k+fa09327bdoqM6rGAkQLRgYAyCu03FjThJ5/E3cUt9iU0uXNziX54bQPWqXwXPqK3opz+MLB41yntFVQA2oLeJHr4ZTLx/l2RSwSs0YiTivHe0WeOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AouRjJgV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KX2uajzq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AouRjJgV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KX2uajzq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 83512EC01DB;
	Wed, 22 Oct 2025 17:38:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 22 Oct 2025 17:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761169125; x=1761255525; bh=2KjJiv0sWg
	Q3nzvZ0yWmMalQNHggyh58PvAw/QHLBwk=; b=AouRjJgVfCGXsEJR0jsDQ92Ae7
	koXdIfPwzn4FLwzEqpi1LjfPho7H7WhofamVRaOby7DRM4SJphQFw2xqglpFEXA+
	/usk6YrWKKG+4q/GaPgjlvAz271igs1aFvo/jbIiQPRwNBy4vHCHfDDr+nJiQEvX
	RK/BJWWhcRLDs9M8TSJtnZGFEdUcNjx5Pt23lYD+YTpd4EH/t+4G38++woArAOgY
	ZSbsFZ+Szxq7NbrkE2V7IUxGQeVi8Eq2Xy9fTBZPlFvzuKj3g15EVyyIn6WeR18X
	RT8DodP00KkNapArHshjcxs2FNmsMzvRYG+9J4jtUfKgqCSSDXQJZxlEsFfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761169125; x=1761255525; bh=2KjJiv0sWgQ3nzvZ0yWmMalQNHggyh58PvA
	w/QHLBwk=; b=KX2uajzqEOssCf050HdgMulfrqbKCtu6xpvkuOUoqZs88nLUNrR
	rSJn2K30bDUXWbyhBQKeXlHoW8zzWAr61UlUuyuC8QlOOTXrvsk4kUjFJ0FH7eRD
	rXNcx8KZbow8sx1aWIIB1lPk39VRrCsky3JHLqmDNXNCXTCZeMNtYRO4h8BMzurO
	eIJy3HlSu2BI1DeKAE9aPvhd2DafXVIY8Xst2aFeM5JvnL+aNln/rYCiqlyfgefk
	CaYOVPibceNEJLqf13kE2gz17RZ+ukssSkRljLlfJ+lDFmawsZBFtivbGTeQfZt5
	FCnI3yIo1z97VlAm1hdB8XST63/RBrWIOOw==
X-ME-Sender: <xms:5U75aG_qH-3txTa5BsBq9DMjbCHcsO6ZpRX_Ir5mKkfXSopaCmdbJQ>
    <xme:5U75aNlxtx7z91hTBTAkh2jGrmzFJ-6fUIEuLuqqEJVodik5Cn_IOwU3Hcx7HZfYd
    Em-A9I7FB9eEJoBZ1sKWKn8QGx-xCBnNiAxFwDh-7zFU9lPIfyq>
X-ME-Received: <xmr:5U75aEUCg6kqX7p9SX7rHa7tt749c7O3omcAQF-v9Ws6WKoTX0sHMz3fa_I1pnBfUE1P2-KJ1-6yDFBJJiUwU3kJFM_j12E074LZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5U75aKEfD1Q0y0yL844jK4FL_haffYTk-rpHymtqMlNgC2VFZPhbqQ>
    <xmx:5U75aIfaXFwWnjX6pjqzrT9DxvAubtNzL9lvlDbN8GWUv0v43AhZVw>
    <xmx:5U75aDKvTkpp4gVJBNEusTU5yIqf9-CD8L392ksRLATf1uQDCLYjrA>
    <xmx:5U75aFHMOInYA0YfxYzJDb1BFom3ra1HDJX4_FBduSrvZaWCWkVRzQ>
    <xmx:5U75aBX1M4c1ypchqSI6fS--r9i0r5nYD4vuvWxcD_erhLaZ_OjBpP6H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 17:38:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/9] xdiff: use ssize_t for dstart/dend, make them last
 in xdfile_t
In-Reply-To: <CAH=ZcbBmdWCBh9zH1Y1JxcnNS-E9AU6Q4rRXPhMOtDBmkxLd8g@mail.gmail.com>
	(Ezekiel Newren's message of "Wed, 22 Oct 2025 15:07:40 -0600")
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<1fa9a7d7d1c309f2f651da351ba7bc0b36272d91.1760563101.git.gitgitgadget@gmail.com>
	<9eafee4d-ea94-4382-ada0-58000d229d2e@gmail.com>
	<xmqqecqww4u7.fsf@gitster.g>
	<CAH=ZcbBmdWCBh9zH1Y1JxcnNS-E9AU6Q4rRXPhMOtDBmkxLd8g@mail.gmail.com>
Date: Wed, 22 Oct 2025 14:38:43 -0700
Message-ID: <xmqqqzuuwra4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> In my compat/rust_types.h file (which was dropped) I defined isize
> using ptrdiff_t rather than ssize_t. Maybe that file should be revived
> so that we don't have confusion in code reviews when structs are being
> expressly converted for the purpose of Rust FFI? I'd really like to
> bring that file back so that everyone has a clear reference for how C
> types map to Rust, but no one seemed to like it except me. Maybe it
> should be an adoc file rather than a header?

I may be mistaken, but I thought that the latest agreement was to
use conceptually the "same" type in each language, have each
language call that type in its native way, and if needed convert at
the FFI boundary.  So if we agree to use, for example, 64-bit signed
integer type for counting things plus returning error conditions via
negative values, maybe C-side can agree to use i64 for it, without
having to worry about how that thing is called in Rust side.

I am not sure in what way <compat/rust_types.h> should be used, and
perhaps a documentation file may be sufficient as you suggest, but
in any case, I agree that it should be made clear to everybody what
C-types are to be mapped to what Rust types and vice versa, and if
some C-types have no corresponding Rust type in that mapping, or if
some Rust types have no corresponding C-type, that type needs to be
converted before they reach the FFI boundary.

