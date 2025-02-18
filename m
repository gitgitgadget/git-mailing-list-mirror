Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45526F45A
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902598; cv=none; b=TOAQpMNpHbABnSfnLr3h1ndYYFh/J3SXNkoPlRgbu6Vs4uYcNhR/nPvrShHEQqjaOdf6LskSbiU3wgehHbn5oGU7DY9o9sTrLs0XNKtfYtF0cxZBxHtG+2hdOChHwka3v4GpPOLQ8RNAF9Jjal5y73wgwoa9fD4Wb8DkGJSCWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902598; c=relaxed/simple;
	bh=PuAUyyB9Aq9PvbIdUUKzimQGxhijVU1jcYVqNJfavu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nj0ntcsV4UnlUzWsjBIcAuxVfDqHNnAAKqWAHhfNf9RP2RgId2J2mX335WOwnvnLAPiMzRrrazX0tjkroetOjpw0Eurlvt2CjmO1Yeuh/WXu9WyB8uY/R+y1Gw2nwHmIhEhPdvOs1skigUJM5zsn0P0GNZtDYMh0VitsjyCqcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I9V93iQU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxRZL+Qc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I9V93iQU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxRZL+Qc"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CA3C254011D;
	Tue, 18 Feb 2025 13:16:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 18 Feb 2025 13:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739902594; x=1739988994; bh=p8gaVYWger
	uxcknBwlWxrhscWwQTXsDrkQ88UNDp1EI=; b=I9V93iQUzYso7zuTnWfuk0xRAc
	sZ7Ge93gw+l0sSHg4VwDhO7z12KPSzGD/CydKsqB5DEkt0hV3uS2VUP4s5NIIa5D
	2MRCxvGXfMgoiY6R5k+dYFZMmWEO8416KA0GLQM+NIr5zagSBpPV6LUWa5Exi3JO
	1Lxz+mK1QEWtZdx57BjWQQfr6MbvojkPc3HhN6CMbqtOMX52SP7sZZ5V71Xo5QQ/
	joypPhFHLdUE48/myWIRkQa8yNRPHDCgO7Ncog98Oi3Y7EgRwLYLs9II/aXQmrw7
	Ito2Ig++uucnhsGVmvoVbPwAjXvvmpGctCF8T1ORRFfZ0Iebyjm5cXZLBYjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739902594; x=1739988994; bh=p8gaVYWgeruxcknBwlWxrhscWwQTXsDrkQ8
	8UNDp1EI=; b=WxRZL+Qcd+2+aa7sctat6krikMc4I3IB/m/jVx3jUt6Radu53LM
	+JOqAtNdmDSX7HLlqfRX5yWmixeVsxYt5RXhAkIf1pkvphZypFLkeIgk5/mWZmOR
	hN62VKpxwNqnV7Ql4NnMLMv93oF4YWH53+PxXcTqv6GvIRYrL/7b0d4j8+c9Ihzm
	4FAkfwbkz9wQimkVU5RH9rgDpRCKt1KXS5uHhktAm4N7fUeXnHiJJBwd+I7Eo4DQ
	6spEnZU1obmWiPpo4YkambFO8CEPLj3FsO7EySbGa9SvxPQCwLznGGlghdFpEXQw
	IhBW630YnZRHf0N5TyWeXmCP4MUzXkZeC8Q==
X-ME-Sender: <xms:gs60Z1TVlZGjWlWsnS6KMAb8pET2tYLRMfrZC8FnVwg38teiaC-RwA>
    <xme:gs60Z-xo22O3KDcXqTa2prMAg3IfKRdcfPHM37pQWYE5wkBsn43d_Gp3hskwM8iAV
    ws9_oZqt3LkmRjFig>
X-ME-Received: <xmr:gs60Z60MoP2NlLEbytU7qd8tLn114b_GP6D5UPTr05ux_ND_L8DGmkCEFUJIBi7zYZ47EWvBzLogBhQF-ruFED2D4smrNxDH6EoUQIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtvggsthgvnhiiiihrvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gs60Z9A_6MKckd2PTs7xuMistM7KVPjkiSSap4uHo5XF4FfUFhUVcA>
    <xmx:gs60Z-jPOxa4at6P7yV-suEAjbEh-tlnFvPj3IsCJjJpn280zpM5fg>
    <xmx:gs60ZxqSCI8MJXlRHUiGJ55WW16eFPm4d9tjEJPc4C8k5xk7esDx_w>
    <xmx:gs60Z5gif0iUDcWLU1yEwn7VrUE_Cl9QQ4K8QHNwUqKhm5H1l1xWPw>
    <xmx:gs60Z2dsyQup_6zepc9GWhCk3LNJoCnOIYvKTjelwZ2COcp6I_bG36Ab>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 13:16:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jared Van Bortel <cebtenzzre@gmail.com>
Subject: Re: [PATCH] diff: don't crash with empty argument to -G or -S
In-Reply-To: <20250217175759.1576684-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 17 Feb 2025 17:57:59 +0000")
References: <Z7KX2y-dXaZuPrW4@tapette.crustytoothpaste.net>
	<20250217175759.1576684-1-sandals@crustytoothpaste.net>
Date: Tue, 18 Feb 2025 10:16:32 -0800
Message-ID: <xmqqbjuzxgn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The pickaxe options, -G and -S, need either a regex or a string to look
> through the history for.  An empty value isn't very useful since it
> would either match everything or nothing, and what's worse, we presently
> crash with a BUG like so when the user provides one:
>
>     BUG: diffcore-pickaxe.c:241: should have needle under -G or -S

I agree BUG is unwelcome.  I am not sure about the value of
forbidding an empty string (I am sure about forbidding NULL,
though).  

If an empty matches everything, "git log -S" would skip changes that
would keep the number of lines, right?  For the history of a project
that keeps track of source code, such a "feature" would not be
useful, but I can see a complaint by somebody who may want to keep
track of a "list of things" one-item-per-line, if we had been
allowing an empty string.  It would be a regression for such a niche
user.

Luckily, since we have stopped with a "BUG", we do not have to worry
about backward compatibility in this case ;-)

> Since it's not very nice of us to crash and this wouldn't do anything
> useful anyway, let's simply inform the user that they must provide a
> non-empty argument and exit with an error if they provide an empty one
> instead.

So I'd say that it may be a bit premature for us to declare
"anything useful", I am perfectly fine with the patch given here.
If somebody who wants to maintain a text file, one-item-per-line
that keeps track of a list of things to omit commits that do not
change the number of items, they can drop "&& !*arg" part, tweak the
message and add their own tests, once this fix lands and the dust
settles.

Thanks for a quick fix.  Will queue.

>
> Reported-by: Jared Van Bortel <cebtenzzre@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  diff.c                 |  4 ++++
>  t/t4209-log-pickaxe.sh | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index 019fb893a7..c89c15d98e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5493,6 +5493,8 @@ static int diff_opt_pickaxe_regex(const struct option *opt,
>  	BUG_ON_OPT_NEG(unset);
>  	options->pickaxe = arg;
>  	options->pickaxe_opts |= DIFF_PICKAXE_KIND_G;
> +	if (arg && !*arg)
> +		return error(_("-G requires a non-empty argument"));
>  	return 0;
>  }
>  
> @@ -5504,6 +5506,8 @@ static int diff_opt_pickaxe_string(const struct option *opt,
>  	BUG_ON_OPT_NEG(unset);
>  	options->pickaxe = arg;
>  	options->pickaxe_opts |= DIFF_PICKAXE_KIND_S;
> +	if (arg && !*arg)
> +		return error(_("-S requires a non-empty argument"));
>  	return 0;
>  }
>  
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index a675ace081..0e2f80a268 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -93,6 +93,22 @@ test_expect_success 'usage: --no-pickaxe-regex' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'usage: -G and -S with empty argument' '
> +	cat >expect <<-\EOF &&
> +	error: -S requires a non-empty argument
> +	EOF
> +
> +	test_expect_code 129 git log -S "" 2>actual &&
> +	test_cmp expect actual &&
> +
> +	cat >expect <<-\EOF &&
> +	error: -G requires a non-empty argument
> +	EOF
> +
> +	test_expect_code 129 git log -G "" 2>actual &&
> +	test_cmp expect actual
> +'
> +
>  test_log	expect_initial	--grep initial
>  test_log	expect_nomatch	--grep InItial
>  test_log_icase	expect_initial	--grep InItial
