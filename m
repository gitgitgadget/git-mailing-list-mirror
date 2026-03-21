Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38743238C0D
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774068868; cv=none; b=nYpZZKb5rHl9kRBT2VdI+VWBoYzbEReOXU2z2cFaIm7lEymLdVqhL2Zvc+NBaMLzHsrB5zUaPT4+JkRLViZD/uGUcIgEVhPMC+AyokHL4s6PtOkfh6LUKSiVRYFoexgWQ+bC9gNv1MzrKBgfAVdsWQJJc6bmEA0DJc4+t1fkjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774068868; c=relaxed/simple;
	bh=Wn47deLOGZ7UF79HWGZwCvOy1/8XpYfaI4Mu94NkcEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b85dAhJuvd+RuG8BRkLSuFGHlWSyTrC6UbmntgUZgfr1XWXcB2gW+g1tIIl+Dg+Q63thjIy2NTXWRwdPT5iP+XwXt4LglhPBCm6/5Xfw/A/pPhZ/tGKSvmSs7KwS+i1vB+cfD2r3f0P6vitGN57R/p/cnFj+JSF93L2w+wl5tfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S0bpt+DJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T5DiZfXv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S0bpt+DJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T5DiZfXv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 609767A014A;
	Sat, 21 Mar 2026 00:54:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 21 Mar 2026 00:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774068865; x=1774155265; bh=JSQZ7+4R7g
	suOSEY4U5KqKxFv4fN7PCp9ubzm2pqKu8=; b=S0bpt+DJoLp7dw6dFfYlb3MtfJ
	ZHB9cKmp4AP+VwsvEgTeV8G0mxlup+j5NcwnY1+JxNUqsEAivgDDfdmzlegUR/Hy
	qiHHnil/XgGd2xgdJYwQWe9XPGSlMuqqMyQI3Rwwy5p3BWmCciQ2x6Nqjei+KZED
	mfc83lnnN6FZads7pmLzwHToofpxkuZI/Jumh5brwHcsXQp1ggggno9EVD/0n5DW
	0zCk91p1hjDEcV9MRxiZeJOfEwa03zoZF+kfZY7Uu/JLsSrbJt2eQmhvrxXQr2H1
	NZEAHvKe4CYRwAhm8iYWTo+V7SsH0Nh+KGqf/FgHbGKlpW2RIj6yaYdhayKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774068865; x=1774155265; bh=JSQZ7+4R7gsuOSEY4U5KqKxFv4fN7PCp9ub
	zm2pqKu8=; b=T5DiZfXvRTX2+s9r5uNHqpikPaIJSevZTQVL5/hNn3WPHqtjnOM
	rvFfD/OuUBPrlZr0wSVTjVpBneiC2cpfYkhSEiX4BKwMXaBxqzoPX7Z97uJwKu5+
	xYEqS1tCHiH8/N9iCSFOX6wezJRysEhGkqUkt9b0ATqOP6vxIDqzBncP99kDu1ZH
	fyLrNQ3XwazsdZHBndVUOdOUWu4R2FgyKlu3msiV5JdD6OAHtJ9W4CnIZdot9Yyu
	alqYVOEFo9E0aA0fhBVjFpbYbIauuJ3SWJX3JS9n86EZdXQSQjwXvUksnuH1kXgS
	xdKhFVLJYd8S978MlJtH48MKKkxEErHV36w==
X-ME-Sender: <xms:gCS-aWlpByMmAGIXzOxZ2qwp--0KLjn2Rpt1UhDsv4xYuYVsdvqbgQ>
    <xme:gCS-aUse1eiIQMC7UID0YPm8SXyiTNskYmuIeD7NBiwoqlSFTid1eJdylGv9marRJ
    -5EYCGlsdSfElmj8tVG2Opy2Zwzp6oGBLP9IweOgcARC_uoa_thGQ>
X-ME-Received: <xmr:gCS-ac_aKzZjG4ueI8IkFu3qL-ihhPBogoMS0b3d70ETx44kEYur0-qeX9f8ba3GUrLxLCGjY27R1N9FE4x_X6L7rEWRwqoPQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudduleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgvrhhnvghlsehstghhlhgrrhgrfhhfvghnlhgrnh
    druggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhhrihhssegthhhrihhsughofihnrdhnrghmvgdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gCS-aWNOtzXIXks35_pg-O2vIOgV46hrP5ZD4a3J2hp3aQXHQFAs9g>
    <xmx:gCS-aSEP0-EAETDqn-sKgdR-DwDSGjYX_tvmVYzcNMjAO3i3YOQSqQ>
    <xmx:gCS-acRw3VrGUhN3AX3fKZynafpwXhYGWpol_YC_xTaLITc7Z0y_tA>
    <xmx:gCS-aXtjguY1I-x2rXZHYNOiW9TkOvGh4JLHFoJ92G-h2dnF8jXTqQ>
    <xmx:gSS-afqMu5Cr7ampQgM4vLW0MgRpaHjcfM0ZAH5BaU1e76sqTjJFkm1o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 00:54:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonas Rebmann <kernel@schlaraffenlan.de>
Cc: git@vger.kernel.org,  Chris Down <chris@chrisdown.name>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] bisect: use selected alternate terms in status output
In-Reply-To: <20260320-bisect-terms-v1-1-c30c9540542a@schlaraffenlan.de>
	(Jonas Rebmann's message of "Fri, 20 Mar 2026 19:07:52 +0100")
References: <20260320-bisect-terms-v1-1-c30c9540542a@schlaraffenlan.de>
Date: Fri, 20 Mar 2026 21:54:23 -0700
Message-ID: <xmqqfr5tdbpc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonas Rebmann <kernel@schlaraffenlan.de> writes:

> Alternate bisect terms are helpful when the terms "good" and "bad" are
> confusing such as when bisecting for the resolution of an issue (the
> first good commit) rather than the introduction of a regression. If
> alternate terms are chosen, the terms "good" and "bad" should not be
> used in git's output to avoid confusion.
>
> An old/new bisect should end with
> $ git bisect old
> [sha] is the first new commit
>
> not with
> $ git bisect old
> [sha] is the first bad commit

Well articulated.

To clarify the status quo, you may probably want to describe what
these custom terms are currently used for.  As far as I can tell,

 * "git bisect <good>/<bad>" that marks the commit you just tested
   accepts the custom term for *input*.

 * refs/bisect/<good>-<commit-object-name> (many good commits) and
   refs/bisect/<bad> (a commit that is the oldest bad one currently
   known) use the custom terms, which would show in "git bisect
   visualize" for *output*

 * "X is the first <bad> commit" report should but currently does
   not use the custom term, which you are addressing in this patch.

Do we use good/bad or custom terms anywhere else?  There aren't too
many, so it would be good to be exhaustive in the proposed log
message here.

> Using hardcoded good/bad vocabulary can give confusion about what action
> is required:

"can give confusion" -> "can cause confusion", or, "can be confusing".

>   status: waiting for bad commit, 1 good commit known
>   $ git bisect bad
>   error: Invalid command: you're currently in a new/old bisect
>   fatal: unknown command: 'bad'
>
> To avoid confusion, use alternate terms consistently across the bisect
> output.

Sounds good.

> Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
> ---
>  builtin/bisect.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

The changes in the patch look good (but it is hard to tell if this
is exhaustive, or there are places where good/bad are still used).

Thanks.


> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 4520e585d0..ee6a2c83b8 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -465,13 +465,16 @@ static void bisect_print_status(const struct bisect_terms *terms)
>  		return;
>  
>  	if (!state.nr_good && !state.nr_bad)
> -		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
> +		bisect_log_printf(_("status: waiting for both %s and %s commits\n"),
> +				  terms->term_good, terms->term_bad);
>  	else if (state.nr_good)
> -		bisect_log_printf(Q_("status: waiting for bad commit, %d good commit known\n",
> -				     "status: waiting for bad commit, %d good commits known\n",
> -				     state.nr_good), state.nr_good);
> +		bisect_log_printf(Q_("status: waiting for %s commit, %d %s commit known\n",
> +				     "status: waiting for %s commit, %d %s commits known\n",
> +				     state.nr_good),
> +				  terms->term_bad, state.nr_good, terms->term_good);
>  	else
> -		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
> +		bisect_log_printf(_("status: waiting for %s commit(s), %s commit known\n"),
> +				  terms->term_good, terms->term_bad);
>  }
>  
>  static int bisect_next_check(const struct bisect_terms *terms,
> @@ -1262,14 +1265,14 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  			int rc = verify_good(terms, command.buf);
>  			is_first_run = 0;
>  			if (rc < 0 || 128 <= rc) {
> -				error(_("unable to verify %s on good"
> -					" revision"), command.buf);
> +				error(_("unable to verify %s on %s"
> +					" revision"), command.buf, terms->term_good);
>  				res = BISECT_FAILED;
>  				break;
>  			}
>  			if (rc == res) {
> -				error(_("bogus exit code %d for good revision"),
> -				      rc);
> +				error(_("bogus exit code %d for %s revision"),
> +				      rc, terms->term_good);
>  				res = BISECT_FAILED;
>  				break;
>  			}
> @@ -1314,7 +1317,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  			puts(_("bisect run success"));
>  			res = BISECT_OK;
>  		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> -			puts(_("bisect found first bad commit"));
> +			printf(_("bisect found first %s commit\n"), terms->term_bad);
>  			res = BISECT_OK;
>  		} else if (res) {
>  			error(_("bisect run failed: 'git bisect %s'"
>
> ---
> base-commit: 1eceb487f285f1efa78465e6208770318f9f4892
> change-id: 20260320-bisect-terms-76036676769c
>
> Best regards,
