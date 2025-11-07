Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C7184540
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530784; cv=none; b=d8Q8/xrtC9idUZpfMBo/uFsTJSnw0lfUg5MVEIGzkwzuC30IbIiEGbxx0aH3UoB5UYhZ1MI1ex42HcdTmfQGpSrThjYqiwLbakwW0qty5yRwFKhNfKAqcIFgNvWw5YrUrDyGIgAGtvE3igY8VFLfqFgVZLcch+jwei8fwQTK0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530784; c=relaxed/simple;
	bh=UNi44+q35WOzYrfXfYxmIKHQOHE+gl6AOj0GCMhmcCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gF02fhwtP4MrozqrOywKKT6JrbBJCLclZ9SaHYrBD2at/E6nwXTmdj+3rOlqvuByxhZSaU2N1SZ+my97SaGQ86kmJbupEk+YYKL3FQa50Zj1YNk3/VcTnJrgjYEZQtQqGtkmQSbWMG0IPbV/i050ZR+CYOXY9qlxEMHUBnA8aNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CygI5aKz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fRVbduiJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CygI5aKz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fRVbduiJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A6ACEC0180;
	Fri,  7 Nov 2025 10:53:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 07 Nov 2025 10:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762530781; x=1762617181; bh=VDuUxXsl9Z
	tHXuA9WwP2I0siMMxZpWkuvuyI1kCwosU=; b=CygI5aKziNgnbeVpgbnN4AnOZV
	mK3I4r7Aa9V+DgN52rWpLfyvsc16efR+low1CT4x1F6AQxOD5D0KEB/iZKtzl6oD
	7DuQ+5DAj5PGht7CYkclB2cZ9XHHTfc6h1IZP031Q1iSrst7W5JedkXZduFAibZ1
	Z4cHsbFKglsmsxYRggnt+HxOl4T/qcZdrJs/s+s9iBKAPfbJ8EUtm93Ftpwc/QZs
	HwH8/KtY8m+MZdJOqmngOH0ptPbsPzPGG7Vmpey9AT+78PHaRiWcfyy3mZosuFAd
	gRTzxFQnlyfRBGwH9XFJ56xmXhRZ4G+0NK50opy4PKO0KhF0WXtYIhwuW3OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762530781; x=1762617181; bh=VDuUxXsl9ZtHXuA9WwP2I0siMMxZpWkuvuy
	I1kCwosU=; b=fRVbduiJo0W4zU1Y4XssP6+i6q3Gpi+6my94skCqi7DCZFEqN/V
	AGyNoWL+KhQoAUjeDuH62C1s8KM9XFet/UD1/Ufi0uld32bRCebj810NLOqo06Mk
	tQZZDnX5UbGDAeK0dJVuhgz9vJbHk2cf1Ik68bWpfC/9eZswoSzA6+RB+k3N6SM1
	PHI92KJo8pVomDUx49I/M4YWUTMnRuiiHlZQIL8gIBYPlp8+vpCbxr5ziGaY7nzS
	HjqPADvyH72lm2iXla5s/6eaQxRXAq3TjKRR9vH5pZKglSxVRXQQJzIzmc6yBndp
	k7nKrJUNfTXhucZNzBgOhYG1fmZygK2DG1g==
X-ME-Sender: <xms:2xUOaVpAcmtRXJkZgx7TTHAmJk7wa8KNP9yF-NnQWVS1M4gB_G-dug>
    <xme:2xUOabWD37uWxpnuj0EEvhvbsXHKCHtyj2wEkd_gA3h6vP0LmS9Gkd12PODcLygMb
    LmTwnwFrn7YLc4RQxpP7Dp1GKCh3mi89IErMPflMksltHsIcBUKthY>
X-ME-Received: <xmr:2xUOacAMH3guhqw9F3iXU5IPvUhFckyogwOmnqcz1d4ZUhAEKNo-eV_TDvGD4qpUKULR6jgNPpI41izKWejxtMAgFs9PEniFWPdF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledttdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnthhonhhinhesuggvlhhp
    vghutghhrdgvuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2xUOaX1dmi8Al-IYuD0ZZAaEF0rEGaqJ9cq68NN3pah1sWkXTc1lfw>
    <xmx:2xUOaW3rafDPT6pzVBdIzW1nxEQ51U_jyKp1Gs9C5IuQT5zHa_1GoA>
    <xmx:2xUOaUBKSaRlJm8HdauNqjql2ktlm6XiEbpUPhxY5Wdf_ZS94SmxFg>
    <xmx:2xUOad6T8swXjuFVttNnOG1y-DaIlK2eECSDvrS0EYBn3M5ARu7goA>
    <xmx:3RUOaU1ep6E9oWkFLBLUHzTXVi_Kmiz29nESwODqbpT-ag_rvk8RIA8T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 10:52:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH v5 1/2] xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
In-Reply-To: <e81a5d2bd23add19e04184f6b37910bc89a514a5.1762468914.git.gitgitgadget@gmail.com>
	(Antonin Delpeuch via GitGitGadget's message of "Thu, 06 Nov 2025
	22:41:53 +0000")
References: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
	<pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
	<e81a5d2bd23add19e04184f6b37910bc89a514a5.1762468914.git.gitgitgadget@gmail.com>
Date: Fri, 07 Nov 2025 07:52:58 -0800
Message-ID: <xmqqh5v5hmat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Antonin Delpeuch <antonin@delpeuch.eu>
>
> The XDF_DIFF_ALGORITHM_MASK bit mask only includes bits for the patience
> and histogram diffs, not for the minimal one. This means that when
> reseting the diff algorithm to the default one, one needs to separately
> clear the bit for the minimal diff. There are places in the code that fail
> to do that: merge-ort.c and builtin/merge-file.c.
>
> Add the XDF_NEED_MINIMAL bit to the bit mask, and remove the separate
> clearing of this bit in the places where it hasn't been forgotten.

Makes sense.  In other words, lack of any algorithm-mask bit means
the code uses myers.

> diff --git a/diff.c b/diff.c
> index 87fa16b730..6ce3591c5b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3526,8 +3526,6 @@ static int set_diff_algorithm(struct diff_options *opts,
>  	if (value < 0)
>  		return -1;
>  
> -	/* clear out previous settings */
> -	DIFF_XDL_CLR(opts, NEED_MINIMAL);
>  	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;

The comment still accurately describes what the surviving line does,
though.  It is borderline if it needs commenting, but the topic of
this patch not being "remove overly obvious comments", I'd probably
vote for retaining the comment.

> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 2cecde5afe..dc370712e9 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -43,7 +43,7 @@ extern "C" {
>  
>  #define XDF_PATIENCE_DIFF (1 << 14)
>  #define XDF_HISTOGRAM_DIFF (1 << 15)
> -#define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
> +#define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF | XDF_NEED_MINIMAL)
>  #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)

Given the definition of XDF_DIFF_ALG(), I wondered how it is used.

    $ git grep -n -e 'XDF_DIFF_ALG(' \*.c
    xdiff/xdiffi.c:324:	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
    xdiff/xdiffi.c:329:	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
    xdiff/xprepare.c:170:	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
    xdiff/xprepare.c:171:	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
    xdiff/xprepare.c:396:	sample = (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF
    xdiff/xprepare.c:417:	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
    xdiff/xprepare.c:418:	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&

They say "if the specified algorithm is (or is not) patience (or
histogram), do this".  Now the original code, because the mask did
not include the need-minimal bit, would have chosen patience code
path even if xpp->flags had XDF_PATIENCE_DIFF and XDF_NEED_MINIMAL
bits set at the same time.  The code would no longer do so.

What is keeping us safe and not making this change a bug is that
among XDF_DIFF_ALGORITHM_MASK bits, we intend to set at most one of
them at a time.  I wonder if we want the command line option and
configuration parser to have an explicit check (and BUG("")) to
ensure this constraint.

Also, in the longer term as #leftoverbits clean-up, perhaps these
bits can be removed from xpp->flags and diff_options->xdl_opts, xpp
structure can gain a separate member that is an enum of the
algorithm names instead, and XDF_DIFF_ALGORITHM_MASK can be dropped?

Then set_diff_algorithm() we saw earlier can become

	if (value < 0)
		return -1;
	opts->xdl_algo = value;
	return 0;

And since there is no "clean out prvious settings" required (now we
can simply overwrite), we can truly lose that old comment once we do
so.

As a part of this topic, I think that a new code to sanity check
that there are at most one bit in XDF_DIFF_ALG(xpp->flags) may be a
good safety measure to have.  Moving the algorithm bits out of the
flags is a larger change, and it may be better left outside the
topic, but I do not personaly mind seeing such a clean-up included
as a preparatory change for this series, either.

Thanks.

