Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088F27D776
	for <git@vger.kernel.org>; Fri, 16 May 2025 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422647; cv=none; b=LTfRq5KSmB9Iu/A66whfD/r8qLXx4KKSOAmoJMIIjJvkuM+jVE902KS+4h2PqbOUlEelxokcdqLtHdC0FhLGSrlJB21KD4L/RgHhXlZ2T++RQhQOF5RDLQ8M2NLlEZe/ptryP6XNcHzq8pjWh7UBpDJVPaTsTnYyxneD3dvoakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422647; c=relaxed/simple;
	bh=86EjQVH+B3fqA+qSlZX2C5hP2a9P5/9NxafK4wVJhos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lfY2+Bl5Zw48pWXEpLyhox0IdkwXSJFojpI1MkF12tCsHSdeupb/PUBXW697dA8RWHNyXuIcjP9VKSwA1e7By3UYJ2CvnEXo0Gaij+gSzPObuNSHy5uZQ20QPutnOuCM9qVwW43FOGpTQdUa//oY5n6uhgadqQJJ/cY2W5ZQyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=evcuUuJh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=snI+Q8HO; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="evcuUuJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="snI+Q8HO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B42012540101;
	Fri, 16 May 2025 15:10:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 16 May 2025 15:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747422643; x=1747509043; bh=IGrKkSr6Uq
	zXfO/pPAwZPMOJ7i+0KiYuPzhmsPGKmeA=; b=evcuUuJhOYHhQkQFUOmmjDgV3W
	KnOO5FMWEEaeJ4sH0b3ei7F6vzzcgCwS+WCWTIoSCmiDFMY9JR+ARAC6/YfWEmFe
	7zGRbD+tgmottcppYjR0yF0hK3KC9eedr6j3TCMj1+CgKWBerGHTglUfbLqruBNt
	rtSho37EHIMX/LCIwWzqDk6sydaC3vTF5+KwolRHmyBPhV6NzZ0t4Xbv9ZyEO2R6
	r1N84q3K9Rq+8O8EclPCgL91sv0XBzQh15Nr4yu4MZlzo4otgMp4FrcUitRJhqV0
	gCHr31XRg52wzs/St1v9c9LCAB+CeNs4UchJVUNfcx/sPfdkbpi109Na9j1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747422643; x=1747509043; bh=IGrKkSr6UqzXfO/pPAwZPMOJ7i+0KiYuPzh
	msPGKmeA=; b=snI+Q8HOpigiDetctcm5dISd6JzJztnqeDQbtUhYxwVepzDnNXi
	EM/qw8o7GyRIKYh0x0sLzPUtr434wPJlClyndRyT3EWuDwxzNqnDKIFAwarv7ygm
	ybC0NyqKlag4Jw40uBnjhTB5YmcCaeMA4A+QRkkXkQN+OwneRvawB8q4SRfu9WZF
	Y8osNMsDk4gU1LxvGCimiFmFEJAHA1BcayLCOXdpXtC5pcXmb6n8jvWiCIFcXDlT
	Hb8DYEdzbyhn1Kv8gwwk1gGREvZT3LXA6opaZxtkWuK7vn3tfCWprUNmEuD92VIz
	72dp0T34Q0hx+LWtI6mApPr3DViTTF/jlZA==
X-ME-Sender: <xms:s40naOgp3elCn7SLV_Emq1HBanoiEYbEE93o0B7Djl00gw6FwqQJWg>
    <xme:s40naPBjp2C2eazvnMr64DuXR7VPW_480ggMJI_O0i3XT4rI_A_lmLzJoMM13wmnH
    CFx5XKyAUHO8IyjKg>
X-ME-Received: <xmr:s40naGGFr8MnjSuGZwOmUsrlRJ41dku5RE0NqNyNOFMAo5SZmWjpfoe0nFJX-V29H0dZA0aNDl5bWRuROaR7zs3Uqy5G9eRYNsd4IQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:s40naHRc4FsuZXggxCEu8R82Y9aXdRrsfcBlft4mqXDoYBoV9lA5uw>
    <xmx:s40naLxZy8DitOaOg1uZaFgOp_3VFid5fv5IPaWmOgOF7dl2HO7xyA>
    <xmx:s40naF65aguaEFJw7DCv0MkWbTt_NcZxxgyI52rLKxGVa2SB773w7g>
    <xmx:s40naIzyQJjCKqw8pzj8llvE6W7vTUjpiSjwlNIrPTozcx4YezsUZg>
    <xmx:s40naKsbLbpBhCAwQ1AIpg8O-37T0wrYIhxbqvUQSyIZWHjtcpAG1qvJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 15:10:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] stash: allow "git stash -p <pathspec>" to assume push
 again
In-Reply-To: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 16 May 2025 15:58:29 +0100")
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
Date: Fri, 16 May 2025 12:10:41 -0700
Message-ID: <xmqqtt5ktlqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Historically "git stash [<options>]" was assumed to mean "git stash save
> [<options>]". Since 1ada5020b38 (stash: use stash_push for no verb form,
> 2017-02-28) it is assumed to mean "git stash push [<options>]". As the
> push subcommand supports pathspecs 9e140909f61 (stash: allow pathspecs

Can I safely do "pathspecs" -> "pathspecs," here?  I found this sentence
hard to read without a comma.

> in the no verb form, 2017-02-28) allowed "git stash -p <pathspec>" to
> mean "git stash push -p <pathspec>". This was broken in 8c3713cede7
> (stash: eliminate crude option parsing, 2020-02-17) which failed to
> account for "push" being added to the start of argv in cmd_stash()
> before it calls push_stash() and kept looking in argv[0] for "-p" after
> moving the code to push_stash().
>
> The support for assuming "push" when "-p" is given introduced in
> 9e140909f61 is very narrow, neither "git stash -m <message> -p
> <pathspec>" nor "git stash --patch <pathspec>" imply "push" and die
> instead. Fix the regression introduced by 8c3713cede7 and relax the
> behavior introduced in 9e140909f61 by passing

Hmph, is it too much work to have a patch that only fixes the
regression and another that extends the feature on top as a separate
patch?  Not that I am opposed by the new feature, though.

> PARSE_OPT_STOP_AT_NON_OPTION when push is being assumed and then setting
> "force_assume" if "--patch" was present. This means "git stash
> <pathspec> -p" still dies so do assume the user meant "push" if they
> mistype a subcommand name but "git stash -m <message> -p <pathspec>"
> will now succeed.

> Tests are added to prevent future regressions.

Nice.

> +test_expect_success 'stash --patch <pathspec> stash and restores the file' '
> +	cat file >expect-file &&
> +	echo changed-file >file &&
> +	echo changed-other-file >other-file &&
> +	echo a | git stash -m "stash bar" --patch file &&
> +	test_cmp expect-file file &&
> +	echo changed-other-file >expect &&
> +	test_cmp expect other-file &&
> +	git stash pop &&
> +	test_cmp expect other-file &&
> +	echo changed-file >expect &&
> +	test_cmp expect file
> +'

OK.

> +test_expect_success 'stash <pathspec> -p is rejected' '
> +	test_must_fail git stash file -p 2>err &&
> +	test_grep "subcommand wasn${SQ}t specified; ${SQ}push${SQ} can${SQ}t be assumed due to unexpected token ${SQ}file${SQ}" err
> +'

Good thing to test.
