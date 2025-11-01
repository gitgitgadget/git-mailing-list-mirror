Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312B1D5CF2
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761995919; cv=none; b=ZQBrowFF9nEPqm3iB0Bzpiiu0fYsgiHtiihlTBXJYc7S+H3ukmdMf4a/6dJS2n81dIjJ2wYdJpZ+DAeqkUFhYZuhULYI/gXjjR5oJLjmVgUEZeNmTZHyTAWQBDMcnlEihuRjQYOGcpBtKBO1UzDL5ukXeBYbf9CAuaJ4e910Mbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761995919; c=relaxed/simple;
	bh=LgGca6fDLcA4dT+/eG+pHQa14lYYhp7nljTxi7XfJtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FzWYU2aMVQh2uVg+nLhH2TtljcvsPLuoVAyJKcJUi8dGzdjh/vTTuyEe421A+Oud6l2fgS/SP7Xwa28v492EAP8Kjdjaf8b75ayjuLiC/If6s3gi8IgCNclHRObqPWNsSOPefsdLRd2KnmttcMu5+K2pGZwxVl2lOZVdMAM6mNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ALdMkM09; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tSBCixr3; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ALdMkM09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tSBCixr3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CBD5E1D00183;
	Sat,  1 Nov 2025 07:18:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 01 Nov 2025 07:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761995915; x=1762082315; bh=9I/HkmJogO
	KHYeVS/nsGquD0ppZz0PNIrPsczy21B4U=; b=ALdMkM09+c64k2hH2uKIiJRvfC
	Zih6ZrGJDqoHMyGhLI/BzydE3fBnCZS4uZPIo/nYaWeyDi/nYvqWCaLQQYtITlaw
	Qk7We7ovqhjinrdZmuNFsb8zc+gmoitGCIqeFpzZJyb0bJGIxP6R1sjrrAG/5P1z
	asCHh6M/KtLFbE40fUlkmC/Gkxty6TVCW2u3U7J91vpcMiKbVniXEC8wNY2+BqsI
	ej22MDyWNySxiSOE2NBCIve1hWn62x8qTfSIMthqIYR+r9XIHHCkDsCVV2DwRiWg
	VvVlU5LTojBECKWyjhf9HRbSFtt3XImZ4tN2mcTw67XlNZ3K/cdGYP47wC4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761995915; x=1762082315; bh=9I/HkmJogOKHYeVS/nsGquD0ppZz0PNIrPs
	czy21B4U=; b=tSBCixr3UY7ppDwq9lUQlj5/F5MG5PzrckqrLet1RJkVB8HCYmQ
	um2Tz1o/HpFVHfbNohrFLpoRLoS9TQ/hoCpfgtdSlqbZKjl52yD1TNZ5xe1/SwP0
	qvONMS7X879fDKc5/XwT50EFryEYI+QBJe/g0QZelLXC278/IZVQR2gmTNnaAToo
	ek8Z1z3vpwCCr7iTn82fQQtRdw7MF4r09KIFViNZGR4Jgo8VAL/bhq7t674hKH0u
	/QhyA9z8rQ8TM7Wocjp3XgI1M/PAaiPFtkU/iFsgyvu4gUeNGg0VrEKSPIDsSubH
	sWborSE4cmm2XzB3Ys4PzBoyp2FYs0pN53Q==
X-ME-Sender: <xms:i-wFaVBhzPgXI79nCh9TH_niqUO3XMIFAI7gOo6dB4ihM_nlhj65sA>
    <xme:i-wFaaY1YL8zUFhu0MtTWzYiysx5JiTlFKzS5V4022Au_sX6F_1-1_shrT36LAiGi
    VyLqsoPcCQhg5pB1jqtb1fgeBNd2DGY4ixMZd0uTBEUXqytCnEsK_c>
X-ME-Received: <xmr:i-wFaY6ORPgswK-LW17XtsOolIpSGV3Ac13WnE6Ytua8BMMFPSQdb6gzyQjFXZYC8BSPSrc73S4tBYrqEIdxFxPsDifnEVc3suvr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurghlshes
    tghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:i-wFabZwzWF_Uz_STdlrpp5KhkSzDBxKh7zID2brwBGuVkOaDdBMhw>
    <xmx:i-wFaXg-mig5aYSwHoROA9Zx8ccbKjPR_kjNijID8guIYNgC7iLLzw>
    <xmx:i-wFac_CaIh_ezGgp7GUyMVO-yZI4V1N8eJGpvAGEML0su51hGGN3A>
    <xmx:i-wFaSo0rqL5WwU3gjy2PNa5169DcilgfghNkKQQFSiZoSowfHOgjQ>
    <xmx:i-wFaaO-jp74hcNG6rJNu6x3n4XAdzgWTrAlTJNy5Ia4rFeTfl_Us7Zz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 07:18:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 10/14] rust: add a build.rs script for tests
In-Reply-To: <CAH=ZcbALuWqaAF21Dho38xJpoaa66Hzs-SgBV4HhywdKopCgoQ@mail.gmail.com>
	(Ezekiel Newren's message of "Fri, 31 Oct 2025 16:43:53 -0600")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-11-sandals@crustytoothpaste.net>
	<xmqqms59acak.fsf@gitster.g>
	<CAH=ZcbBYRiceXQ-9FNq0aK0WzN4nDhqonaoafweStC37mx7JBA@mail.gmail.com>
	<xmqqwm4d716i.fsf@gitster.g> <aQMFFZ_uDZxHvExW@pks.im>
	<xmqqsef07avt.fsf@gitster.g>
	<CAH=ZcbALuWqaAF21Dho38xJpoaa66Hzs-SgBV4HhywdKopCgoQ@mail.gmail.com>
Date: Sat, 01 Nov 2025 04:18:33 -0700
Message-ID: <xmqqfrayxapi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

>> Mostly flexibility.  If we do not value it, then that is OK, though.
>>
>> And personally I would have to say that "meson rolled everything
>> into a single library archive" is a bad excuse---whatever came later
>> doing things differently from the incumbent has to have a good reason
>> to do things differently, or it is a regression.
>
> I don't understand why "Simplify Cargo's job of linking with the build
> systems of Makefile and Meson" Isn't a good enough reason by itself.

Was that the way it was sold, though?

    The motivation is to simplify Rust's job of linking against the
    C code by requiring it to only link against a single static
    library (libgit.a).

was how the original cover letter sold the change.  In addition, in
a later thread, I saw this:

    Like the previous two commits; This one continues the effort to
    get the Rust compiler to link against libgit.a. Meson already
    includes the reftable in its libgit.a, but Makefile does not.

It led me into (incorrectly) thinking that Rust toolchain you are
using for your series becomes very cumbersome, if not impossible, to
use, if we try to have it use more than one library.  My job as the
project lead would have been to decide if maintaining the separation
of three independent libraries was worth the hassle.

In other words, I read it as "We have to do with a single library,
due to limitations of Rust build infrastructure, and that is why we
are merging logically three separate libraries into one in the build
structure in the Makefile.  Meson based build happens to already
roll everything into one library, so we do not have to do anything
extra to implement this workaround for Rust.  Only Makefile side
needs this change."

If I knew that dealing with just one library was not a requirement
placed by Rust (and apparently, what brian did in the series under
discussion shows that it is not), I would have instead suggested to
fix the Meson based build procedure, as I do agree with the idea of
"simplifying" to avoid having to deal with 1 with Meson while 3 with
Makefile.  But I would have suggested to link the same set of three
libraries on both sides.

The fact I was (mis)lead into thinking that the only way to do so is
to roll objects from three logically independent libraries into one
(due to limitation in building Rust part of the code), when the
other way, namely, to keep them separate also in Meson based builds,
was also perfectly adequate because there is no such limitation
placed by Rust, is mostly what makes me react unnecessarily
strongly.  Yes, I am upset.

When there is no strong reason to be different for a newly
introduced thing (that is, Meson relative to Makefile), it should
avoid being different to avoid breaking expectations (e.g., we'd
have this and that .a files left in the build directory to link with
objects to produce "git").  So "I do not understand why keeping
three is good" is not an argument.  The Meson based build series
needed to justify itself why rolling everything into one library was
a good idea, but it seems nobody noticed the distinction back then
when it was introduced, and you do not have to be retroactively
defending that mistake now.  The same about position independent
code generation (I do not know if it hurts performance very much
these days, but it used to introduce measurable hit, so the benefit
needs to outweigh the cost).

In any case, it has sufficiently been long time since we lost the
other two librarres in our build, so changing it back to use three
separate libraries would be yet another breaking move that I do not
want to see---unfortunately it is way too late for that.

So brian's patch in this series may need to be rebased to a newer
base to expect a single library, I think.
