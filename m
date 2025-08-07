Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19B4430
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754602053; cv=none; b=qE+lP+CuvM+9jwQ+pGWstI3HvNcuhpaIiCprHDEotQuBBN0/UBsKtF6VVMaOYukyUVkAN/NwSkIvH5QWsIXMr4W4uXjDMk319qGN0U1Q9TeMWOFvpUJaqvkNYPod9dBw9N3GIEN+wBNmewBwZNfCpTGjcmuj1hGD9yNPW8KS68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754602053; c=relaxed/simple;
	bh=EScjM82dog/mxFdD6vlekJSnXdXFuWr3kk20aVxMd4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LR4kKa/xYP3jSqI/fye3MySkpNLkKPCWErOZe+mPpXVIzRb4QCdJOQ4AJzNSu+e66editXpb2J5RQdQnteJI1M6IVDUvL8s0aCsm3zg9m3/S74SnJr8dND6yffm0cDByuCmRhV8b75Ek9brDoOwnZjGkN1nW6gGvVpCPpBpKOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KS821TFm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=giOcP9gO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KS821TFm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="giOcP9gO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 395F6140011F;
	Thu,  7 Aug 2025 17:27:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 07 Aug 2025 17:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754602050; x=1754688450; bh=czAZ2+7Swu
	ju7kPERGFYqe/Tdec2DfMGbfCL7Av6AKg=; b=KS821TFmLAq3VIEKj1vwbJnnJV
	8Pn/GkNR6xSEXJYGbYmYEgbQf1lheX3yuLFT8r5UoEJVWWkDVHGpg4ecyLQO/wIU
	lwKz0OLevebhB9TOD3OZ8itjVIPpz5HhM4lFCsx8YC6c/4aw6Cuagnx06Z3tHEH5
	SkrUjuMHHiXEoldxdEpR9194HawyAiTH9nLjEzpE7K4XInmo9dC6sATfPhZxR6C6
	qiZdbIeH3calG/bw7HjthmZ1NFYvZ8Lkulh1ePKLLCZIuD8bgsI/IGQD+MoCUJgQ
	R2ErlfnHNtcF5WRpsM78A5JTtli396DSSjXJ+aK4r1d7c1O9H3kQcVUUknxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754602050; x=1754688450; bh=czAZ2+7Swuju7kPERGFYqe/Tdec2DfMGbfC
	L7Av6AKg=; b=giOcP9gOJVNnIlBamsPaLyHnaUKxgD8T99RRgViGogqbanxj/Xl
	/3d6IZ2wgUPRVv2gcnbpy6V5KJZM0tM34+EYZBr+lSZzCcKvxY0vXT0+ghHSRDOp
	PHuVq2iFnEGhrCBs+gTRUc/34dcFUQs3YzgEU2LBpZdlYCJWpWc5F4+oKVsrdy5I
	xmwu1fO0evhqaLMkDlBRZYLo0gf/Zzqe0D7iqVlMtXI+LKjN33bPNIu12DmYyr6X
	Qu87wEr+mTtrOkhXHMA4LoTZSdaagFbgRWr68r7zdUo79+ra21kdcszwwy2dd2PJ
	OgNWIjcTvJsWlEOawLs6vGtyoLimP9KVUKg==
X-ME-Sender: <xms:QRqVaNk0HfooASoviK0Skj-WuRUg_6kn_dd5nkG3dqJxeIZc6l-9mw>
    <xme:QRqVaBTRueppwowZTuAXhrAOa4losA7MmN7podL1_BibqfYKx5ud-6i85f8d6J2jM
    94ZFwU4qPTvuVHrog>
X-ME-Received: <xmr:QRqVaEFtU92dDftdOV4StbDlkJzOYddFNO1UBfhhhnKCxSW71E9rrTgNBqLtVlqxE6e9adbfkr-QDRcoTR3ah_2PXeP5G7bT0m5gtlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhho
    mhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhhisegrrhhnvghsrdhsphgrtggvpdhrtghpthht
    ohepmhhitghhrghlsehishgtrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QRqVaOG5D62ARgAND8DqKo45OODqNF7s3QeZK3ckoEN4oEaRn6CWbg>
    <xmx:QRqVaKRpTtnGVAGLwFZluZL04Lp5w9Y6re_1rWBsSXsO9nlCOljTOA>
    <xmx:QRqVaHLJhKKBMYnC9H_kfLcbnqHGlYYvf0u0AKRjaftRcgN-sk7OFg>
    <xmx:QRqVaNY1bA-1hw4fmKrlQgG7NHzORl4CYx6UQ5jO4wBp6ONT_T6wmw>
    <xmx:QhqVaDryx54K7O-NllMiXWdbcI0hvEJyYCe_M7NcEKHBCO_2c1g9jMxy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 17:27:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  hi@arnes.space,  michal@isc.org,  peff@peff.net
Subject: Re: [PATCH v4] diff: ensure consistent diff behavior with ignore
 options
In-Reply-To: <20250807020643.40213-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Thu, 7 Aug 2025 10:06:43 +0800")
References: <20250806123306.25532-1-yldhome2d2@gmail.com>
	<20250807020643.40213-1-yldhome2d2@gmail.com>
Date: Thu, 07 Aug 2025 14:27:27 -0700
Message-ID: <xmqqldnult4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> In git-diff, options like `-w` and `-I<regex>` require comparing
> file contents to determine whether two files are the same, even when
> their SHA values differ.

Let's see if we can do something to clarify "the same" here.
Perhaps

	... two files are considered equivalent under the specified
	"ignore" rules, even when they are not bit-for-bit identical.

> For options like `--raw`, `--name-status`,
> and `--name-only`, git-diff deliberately compares only the SHA values
> to determine whether two files are the same, for performance reasons.
> As a result, a file shown in `git diff --name-status` may not appear
> in `git diff --patch`.
>
> To quickly determine whether two files are identical, Add helper

Following the above, perhaps replace "identical" with "equivalent".

Also, ", Add helper" should be ", add a helper", as that comma is
not finishing a sentence, hence the word that follows it is not at
the beginning of the next sentence.

> function diff_flush_patch_quiet() in diff.c. Add `.diff_optimize`
> field in `struct diff_options`. When `.diff_optimize` is set to
> `DIFF_OPT_DRY_RUN`, builtin_diff() will return immediately upon
> detecting any change. Call diff_flush_patch_quiet() to determine
> if we should flush `--raw`, `--name-only` or `--name-status` output.

Also the implementation details like the name of the .diff_options
member and the name of the helper function have changed, and the
proposed log message should be updated to match.

> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
> ---
>  diff.c                     | 55 ++++++++++++++++++++++++++++----------
>  diff.h                     |  2 ++
>  t/t4013-diff-various.sh    | 14 ++++++++++
>  t/t4015-diff-whitespace.sh |  2 +-
>  xdiff-interface.h          |  6 ++---
>  5 files changed, 61 insertions(+), 18 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index dca87e164f..3bd432db32 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2444,6 +2444,15 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
>  	return 0;
>  }
>  
> +static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED)
> +{
> +	struct emit_callback *ecbdata = priv;
> +	struct diff_options *o = ecbdata->opt;
> +
> +	o->found_changes = 1;
> +	return 1;
> +}

OK.

> @@ -3709,6 +3718,7 @@ static void builtin_diff(const char *name_a,
>  		xdemitconf_t xecfg;
>  		struct emit_callback ecbdata;
>  		const struct userdiff_funcname *pe;
> +		int dry_run = o->dry_run;

As the "dry_run" variable is used only once in this block, we
probably do not want to add it.

>  		if (must_show_header) {
>  			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
> @@ -3759,8 +3769,11 @@ static void builtin_diff(const char *name_a,
>  
>  		if (o->word_diff)
>  			init_diff_words_data(&ecbdata, o, one, two);
> -		if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
> -				  &ecbdata, &xpp, &xecfg))

Instead we can check o->dry_run here.

> +		if (dry_run)
> +			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
> +				      &ecbdata, &xpp, &xecfg);

We may want to leave a comment to explain why we ignore the error
return from xdi_diff_outf()?  Perhaps like below?

		if (o->dry_run)
			/*
                         * Unlike the !dry_run case, we need to ignore the
			 * return value from xdi_diff_outf() here, because
			 * xdi_diff_outf() takes non-zero return from its
                         * callback function as a sign of error and returns
		         * early (which is why we return non-zer from our
			 * callback, quick_consume()).  Unfortunately,
			 * xdi_diff_outf() signals an error by returning
			 * non-zero.
                         */
			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
				      &ecbdata, &xpp, &xecfg);

I am undecided.

> +		else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
> +				       &ecbdata, &xpp, &xecfg))

> +/* return 1 if any change is found; otherwise, return 0 */
> +static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options *o)
> +{
> +	int dry_run = o->dry_run;
> +	int found_changes = o->found_changes;

In this codebase, these "original value of the variable X was this, we
tentatively save that original value away, tweak the variable X to do
something, and restore the saved value to variable X" variables are often
called "saved_X".

> +	int ret;
> +
> +	o->dry_run = 1;
> +	o->found_changes = 0;
> +	diff_flush_patch(p, o);
> +	ret = o->found_changes;
> +	o->dry_run = dry_run;
> +	o->found_changes |= found_changes;
> +	return ret;
> +}

In the previous iteration, .dry_run/.diff_optimize was set and reset in
different places; doing it in a single function here makes it easier to
understand what is going on.  Nice improvement.

> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 8ebd170451..b56a79d979 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -648,6 +648,20 @@ test_expect_success 'diff -I<regex>: detect malformed regex' '
>  	test_grep "invalid regex given to -I: " error
>  '
>  
> +test_expect_success 'diff -I<regex>: ignore matching file' '
> +	test_seq 50 >file1 &&
> +	git add file1 &&
> +	test_seq 50 | sed -e "s/13/ten and three/" -e "s/^[124-9].*/& /" >file1 &&
> +
> +	: >actual &&
> +	git diff --raw --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >>actual &&
> +	git diff --name-only --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >>actual &&
> +	git diff --name-status --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >>actual &&
> +	! grep "file1" actual &&

Perhaps use test_grep helper shell function, i.e.

	test_grep ! "file1" actual &&

> +	git rm -f file1

Is this because later tests will break if you leave "file1" in the working
tree and/or in the index?  If so, we should use test_when_finished to make
such a clean-up.  If you insert

	test_when_finished "git rm file1; rm -f file1" &&

at the very beginning, before you create file1 with 1..50, when this test
piece finishes executing (whether it completed successfully, or failed in
the middle of the &&-chain), the specified command will run.

On the other hand, if the later tests won't mind whether "file1" does or
does not exist in the working tree and/or in the index, it is common to
leave it behind without cleaning it.  When running the test script with the
"-i" option, i.e.

	$ sh t4013-diff-various.sh -i -v

leaving the files that were used in the test, without cleaning up,
sometimes helps your debugging of the test script.

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 52e3e476ff..e7be8c5a8f 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -11,7 +11,7 @@ test_description='Test special whitespace in diff engine.
>  . "$TEST_DIRECTORY"/lib-diff.sh
>  
>  for opt_res in --patch --quiet -s --stat --shortstat --dirstat=lines \
> -	       --raw! --name-only! --name-status!
> +	       --raw --name-only --name-status
>  do

Wouldn't this make the "if the option is marked with !, tweak the test that
notices these two equivalent paths are not-identical" extra code, whose
beginning part we see below, unnecessary?  The $expect_failure variable
would always be an empty string, so "different but equivalent" test should
see "git diff --exit-code" exit with status 0, right?

Other than that, looking quite good.

Thanks.
