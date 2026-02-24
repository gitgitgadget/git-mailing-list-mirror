Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23871D61BC
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911840; cv=none; b=KNiSUmkxftaT/B49ECzBLiTge6wV7edna9l1U70h3YVcL2rQS4JLuOd8pN4Ql6xKx6keFMjD8akS/U7MNlZcHGdudisGJHka5tavw3oLmHW8T4mJOJocVE6KPqUwhMSxaDyaUg3YrAjb4igN4q8TLjnJjrE9wzQSLrmp4WjU+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911840; c=relaxed/simple;
	bh=T1LG0fHOvR2qw/UArjokfKDEGiAwOtGKWEXZ5gxWAMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vFnjclXdyOv4A2717+3tVqD+aQarT0HKdsZt5aATb1PIkIwHF0mIiO3Zb7LMospYkk7s9CskQFIdyBzcTYYNye5EKKjc4sY4FmOkbJnVG7466mVBVlxaix8k9tuqx4ZhhHEo8NFxMFfLwMohYu6G4GTTY5prhHn+jbs8iB2i1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BZQWP2Pw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z4PgGiDI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BZQWP2Pw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4PgGiDI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E786C1D0019D;
	Tue, 24 Feb 2026 00:43:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 24 Feb 2026 00:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771911837; x=1771998237; bh=bzzbyE4rH6
	zIROF0UTgds97GTuWgQ6HwKbuGugiubnY=; b=BZQWP2Pws0sQ6qJrDQf3FkSSJo
	TAQb1OPoGw04SdAG9HOxIC68elgfzKCVobrZ9XB8r/jh5s5W5n7lxDJWSw3bclSM
	0xu3Oz2RSd/6zR6jNb/nOK03CYN8BXdqkvvw/z2ffKJ4vhCW4iveXLmY0pBs2625
	05JQNqy40816FTRoOjf+yjjneWXiDqIiamoLcphKGL0RMKJJTzuYEJunlz44ikZS
	uPA8iv+2NG/ZbAaF4aL/omJvQKxG1Sv+3MCu6Wy2RYRZl/IFLdhPTKPiPMHz65my
	gWKIuUxCid0lsKZYSCQM16CsmQ2Ax9MGmQNiLbSTWPQZ4LZo/a1kB2hcTpsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771911837; x=1771998237; bh=bzzbyE4rH6zIROF0UTgds97GTuWgQ6HwKbu
	GugiubnY=; b=Z4PgGiDI9SwC28eWhBHM557ymFQ9ysAdhdQvaYgH4XfD/jlFv3l
	DyKAW83Z/2TsVOIwlQFf8ChlSdv02XtelvLW/3+bb7yAFI+3AalefTC4QtG0ca0Z
	4lYm5hEKnJWm3eUPih7eqh9j29pdOW+fEHplQyEQCBPlDRvWAyH/uL8MTq/lBxq1
	YAi0QtPoVv3qrSgFGLD2ol50p+BiQ0kw+9mCtPr3RX7LwcMCSrt7xk2JaUp0mIj4
	ZXXSKnnGXm7mGsRaEfoeN3P2Ep/uBqow1x9iYuGSDw/2br5NEbTqoGKjwj+2zSis
	1jW9QC1YOUxClQEE42nIMf4yYuvKOa0O5zw==
X-ME-Sender: <xms:nTqdaWPUwkbmPKAYzYQ2v0hC0wuWYGFftXqERyGk00iQdg8xy7oCyA>
    <xme:nTqdacZX24LdO6sFS7xuU-UYenFIzDQAK2OBfMQ3-GXIa7vPaTmmd4s-48xaZo535
    Tg6yeaMiIJgHUtQASAzvD1a-P_qT7PwYdtb7PM1C2z1rnGzLRMvtw>
X-ME-Received: <xmr:nTqdaapLRptiQ3wh8YHR99ps0Ynmyc4BzxTAK74Bbci2Ew8t-Hote6-GiXJX4EM4KwuPdCtUEoTg6yKbTaV4QLjyWEo0FbfvCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhrvghn
    iihordhpvghgohhrrghrihdvtddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:nTqdaQZ3a1oW3udU_DGgxokqRyjA43sbkn8iyZxc6OXLDNw5_y95Iw>
    <xmx:nTqdaSSNmmQCmfCIkGiZ9-WQ0n91Yp363yN1Bu6Fo0W0a9dN15EXkA>
    <xmx:nTqdaX7xXRA7VSFySX2Wh6q6bEGXoarqdlY3c4oHjwmyfdGdjGKWTg>
    <xmx:nTqdaXwQ8rCt9NIOZO2LLLYcvcwNAmo7P8yZspxXHGFN989N5yDpiQ>
    <xmx:nTqdabQ4hHxvkB_zT4JgS_NPmFxbbHsJOEJqwXT7T0hD452ZcLFAfJA8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 00:43:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 2/2] t4074: add test for diffstat width when prefix
 contains ANSI chars
In-Reply-To: <ce251505932712839dcaabffcd1762760439edff.1771895921.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Tue, 24 Feb 2026 02:20:30 +0100")
References: <ce251505932712839dcaabffcd1762760439edff.1771895921.git.lorenzo.pegorari2002@gmail.com>
Date: Mon, 23 Feb 2026 21:43:56 -0800
Message-ID: <xmqqikbmk86b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> Add test checking the calculation of the diffstat display width when
> the line_prefix contains ANSI characters.

Hmph, who stuffs the "line_prefix" and with what?

> Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> ---
>  t/meson.build                               |  1 +
>  t/t4074-diff-stat-width-with-line-prefix.sh | 42 +++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100755 t/t4074-diff-stat-width-with-line-prefix.sh

Do we need a brand new test script only to host just two tests?  Is
it too cumbersome to modify existing test scripts that already test
"git log --graph"?

> +setup () {
> +	rm -rf * ".git" &&
> +	git init &&
> +	git config color.diff always
> +}

Why?

> +test_expect_success 'check width with max name-width' '
> +	setup &&

Why?  Shouldn't something like

	test_config color.diff always &&

be sufficient?

> +	touch "${FILE_MAX}" &&

Use of "touch" when you do not care about the timestamp of the
resulting file is misleading.  If you only care about its existence,
do something like

	>"${FILE_MAX}" &&

instead.

> +	git add . &&
> +	git commit -m "init" &&
> +	echo "text" >"${FILE_MAX}" &&
> +	git add . &&
> +	git commit -m "text" &&

OK, so we have two commits, one adds an empty file, followed by
another that adds one line of "text" to the file.

> +	git log --graph --stat >out &&
> +	grep "${FILE} | 1" out
> +'

Use "test_grep" instead of "grep" to make it easier to debug when
things break, perhaps?

It is unclear what we are exactly looking for.  What's the failure
mode and how the miscounting of the width of the line-prefix
contribute to that failure?

We have two commits, "log" without "--reverse" would give the
creation of an empty file i.e., "file | 0" first and then one line
addition to the file i.e., "file | 1 +" next.  We only care about
"${FILE} | 1" existing in the output and we do not bother checking
what comes at the beginning of the line before "${FILE}" or what
comes on the line fter "| 1", because we can detect the breakage we
expect to see only by looking at the middle of the line?  How would
that work?  The test deserves a bit more comment to help readers who
wonder about these things.

	Side note.  I think I know the answer to these questions,
	but this project is not about me ;-) but other future
	contributors also would need help when they encounter this
	test and want to learn what it is testing.

> +test_expect_success 'check width with longer name-width' '
> +	setup &&
> +	touch "${FILE_MAX}+" &&
> +	git add . &&
> +	git commit -m "init" &&
> +	echo "text" >"${FILE_MAX}+" &&
> +	git add . &&
> +	git commit -m "text" &&
> +	git log --graph --stat >out &&
> +	grep "${FILE_LONGER} | 1" out
> +'
> +
> +test_done

Instead of doing the repository construction twice, you can see the
same effect by running "git log --graph --stat" on the same history
with different values exported on COLUMNS environment variable,
which I think would be easier to see and simpler to debug.

Something along the lines of ...

    COLUMNS=80 git log --graph --stat >out &&
    test_decode_color out >out.decoded &&
    test_grep "^<RED>|<RESET> ${FILE_MAX} | 1 <GREEN>+<RESET>$" out.decoded &&

    COLUMNS=79 git log --graph --stat >out &&
    test_decode_color out >out.decoded &&
    test_grep "^<RED>|<RESET> ${FILE_TRUNCATED} | 1 <GREEN>+<RESET>$" out.decoded

... perhaps?

> +# The terminal, during a test, should default to a width of 80 columns
> +FILE_MAX="filename-with-exact-length-to-take-the-max-amount-of-space-in-diffstat"
> +FILE_LONGER="...name-with-exact-length-to-take-the-max-amount-of-space-in-diffstat+"
