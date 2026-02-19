Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D2341062
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514712; cv=none; b=Jr7Us/0kKhGOz8hPtmaQqxKeU/ugNMXVlcRHAFy0D1tjH8wkYTOU/k9B9P06Ld9Is0Ga0kePrvOp3udmxgnfgs/2WOSjD0XgpTtHxVwjK4fbo7KTJxI42XD+594RLYssrjVczDKNrJbIG8aM+uhPI1XWLJq8Kb0dU36kNpHPGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514712; c=relaxed/simple;
	bh=0qErYL+4YZUbr96bZEgbmRQjKwZXhvM7K2BR4qua1rk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=teLg3cXOzq6Hsqp8yZ8l5X0BK3im54hdhd5+4VLrDH3TFV8oc9GVQSjER4HN/De9XBaUFlkk/EXpDsAWLZC/aCBRwjccEtkxW62WAuH3LcmXVl0d+IlTwXcYQNhxcimdLetCyzMaI6RgzNn8Cv0D6iMt7jILD/uNi8PALlDu1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mGmYEiBc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BBUJ2SYO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mGmYEiBc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BBUJ2SYO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4B8D14001C5;
	Thu, 19 Feb 2026 10:25:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Feb 2026 10:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771514709; x=1771601109; bh=56s7cZLBU4
	lUh6F7fqOTFEkjgm+K647XHh8gHzQq9DQ=; b=mGmYEiBcgLXxOVZztxcGW9ktos
	U0ztsCNRJbAQMnFpGMglSMv0vornHlcBf/tVtfZag87BnUvOBFUBbANtAMD4YFdo
	gBHmnTa4+CIRxOEvjS2v4/ic9UqQtA1vzkTsSpGbwrFHqQrqb1fVIkRzaMZ/HOt4
	Wz99LsFY/NubzKmKL+5CVZ3GD9a0IE4uk/JONYJFuNUdV5Vblh4rHBG2pbry50op
	XT6JIVwdxW3+6+00yABX7dW2LzlEDHMZZzgXh7nlhy1V5yhkPwCCCqindf9TPZuS
	Vh1Ek2twaflqbUbSgZC+mXqY4JLXv0E9FNZ/HDQ71At53gGIjhK5EfX+I+Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771514709; x=1771601109; bh=56s7cZLBU4lUh6F7fqOTFEkjgm+K647XHh8
	gHzQq9DQ=; b=BBUJ2SYO7YfpHjH3K+8UwvE4O4jsqypxrP+yGPZ/uOUXulMuq1U
	XnEfQ5ZZ4LRi2xiEwCcrfXpsVrlykIQpIXuVkCnX6vxbVsOx3SMtDZHUYtYjpN5y
	g7nSAsYS2scLD/cvA/wMzxmcvQ3fJX9nfMK0JyO63J0M6DFNrdvaREXimjo6GIZ7
	JuIJvDnetKeex3wn87hku2I56RjtqD0M3hHxRrQbFMOF3nuYchEYoezSpdL7ZDXN
	oqP49gcvZ8/TDEM5VYj0zzRH7mIpW4BjRrkNMzJ7dUXWZzK8uPObau4tIPowHws2
	oaKwcF8CdmATfi15UyNty5yUtq83fX+HFkQ==
X-ME-Sender: <xms:VSuXaeK8LStO4cJGBYpKH3U4IphZ7UWorltbLCcZv-r_AcxPYoonyQ>
    <xme:VSuXadBesbGWds4t_ScjcsEpY-Py-po-GC4sCIrrjAsCIf3TwcaIyPURa3pL-LJRC
    e735wpz5_NI2nK64g5war-vbrtgXpInZzrrt6SQxZTZET_-coZ0dA>
X-ME-Received: <xmr:VSuXaXDRhm5ucBJqNZTCFBQNF_0_X47nCT4nHmuHW0LRr3ouE8oGyZOYJtBXkDtDItsVNmBmzvHJyzl1_HWCqUj9a547SC0YLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghruhesghhrvggvrdhnvg
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:VSuXafD2cujbNgiioYMxdOUj5JofJ2rNSn4LtEqPTXw4dTwBNRentw>
    <xmx:VSuXaSqBJD18GhFxSn8HDw0_xmBXxG8h_veXIfXy1PcSbVJLSm4O1g>
    <xmx:VSuXaZkUS1fhNdBBd78k0urBOF0qbdIDT3PmngnZ-9NOnDhAX1TD0A>
    <xmx:VSuXaSyDvqAq2rCxcSghTExaYjfrv9La2UkPp2YJ5JusDVT7RyxDvA>
    <xmx:VSuXabbqlskE_CzS4Xq-hIHCsxzognWEk4n_xnMbAA2smOovi6KYGsca>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 10:25:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3] osxkeychain: define build targets in the top-level
 Makefile.
In-Reply-To: <CAOTNsDzwb_k+FDBbfzf7z=X=zGhnhXb902Dx9JFGv_eLjza2tQ@mail.gmail.com>
	(Koji Nakamaru's message of "Thu, 19 Feb 2026 04:14:26 +0900")
References: <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com>
	<pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com>
	<xmqq7bsa7x78.fsf@gitster.g>
	<CAOTNsDzwb_k+FDBbfzf7z=X=zGhnhXb902Dx9JFGv_eLjza2tQ@mail.gmail.com>
Date: Thu, 19 Feb 2026 07:25:08 -0800
Message-ID: <xmqqh5rc7o2z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Koji Nakamaru <koji.nakamaru@gree.net> writes:

> Since .depend directories are handled via dep_dirs in this Makefile,
> how about the following change for consistency?

Sounds good.  Thanks for spotting.

>
>   diff --git a/Makefile b/Makefile
>   index 1c2019a4cb..47485004d8 100644
>   --- a/Makefile
>   +++ b/Makefile
>   @@ -2876,6 +2876,10 @@ objects: $(OBJECTS)
>    dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
>    dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
>
>   +ifeq ($(uname_S),Darwin)
>   + dep_dirs += $(addsuffix .depend,$(sort $(dir
> contrib/credential/osxkeychain/git-credential-osxkeychain.o)))
>   +endif
>   +
>    ifeq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
>    $(dep_dirs):
>     @mkdir -p $@
>   @@ -4066,7 +4070,6 @@
> contrib/credential/osxkeychain/git-credential-osxkeychain:
> contrib/credential/os
>     $(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security
> -framework CoreFoundation
>
>    contrib/credential/osxkeychain/git-credential-osxkeychain.o:
> contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
>   - @mkdir -p contrib/credential/osxkeychain/.depend
>     $(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args)
> $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
>
>    install-git-credential-osxkeychain:
> contrib/credential/osxkeychain/git-credential-osxkeychain
>
> --
> Koji Nakamaru
