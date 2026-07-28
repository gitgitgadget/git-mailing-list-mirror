Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD7305E28
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278887; cv=none; b=feIiCvW5zzWNxeY/JzNE4cJmV/0aFIDUtMvXbTRSj+HXVi3HCD47EHACqtuQJlTgLFvwG0tQVTWCmsw2o9bOkc64kIk/dJ6iEYpmsql/NiNJWSlCLf6UbvmzOn6M0Bi+gUNN4++Vhs9BTTC7w8RWTyfBzhUWsFhq7tT72AsEKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278887; c=relaxed/simple;
	bh=P/iP132Afa6dD/0wqsXabLPYGUNvD900evu1DWoy4Qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5RhQz4hz9XPFWft0RjJ3ySYzzeRHQ6J22+xc2O+HhCdiLxKQh1ZPS7XpoSfXnSE6MimM3V/wsdPvd/frQWry+VFsHHZTWMBSygl0B/tyJVC9qM7Dz7ivqFZfXMqGqXuAihi+6EZQDix9lipDCzbfkrnp5tcNxYMcdAK0dzWvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VisEq3eQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3nQDg38; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VisEq3eQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3nQDg38"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 812457A04A7;
	Tue, 28 Jul 2026 18:48:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 28 Jul 2026 18:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785278885; x=1785365285; bh=sNPOc930zk
	OqlcqNBl013YkJc2jcE6Ss7NPeS8riEuw=; b=VisEq3eQUdH+f9pA4qDT/dHcQV
	cZLWEt+hQXPWWiG57VKVuBg9Ww0LusT/aNNls2Lf+tYNLz6H7SfQjUfJ7XAIakr+
	QZ4QxgclU1dWaiCF5rix8NEgu1vKs1rYhY1Mz5ckdpKOfBSveMm7eA8rjwW6niXJ
	Rfa2biPith2YaRu6eO8NpdyyOJW46MWR6BdvCs9Ug0PdnqCSDL8QedxmquAvTTDZ
	lJjDLX3jM/Ejl6ZXp7un2BIwIRicXUoUg0/f4soYU8K5J1R3IGGO6QaFRLjJiQQe
	AlGZVFDdbeufj0AU+taT7+jZVQbPmjDPj03guBHge/I2JkdEfh0BKi5O4gEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785278885; x=1785365285; bh=sNPOc930zkOqlcqNBl013YkJc2jcE6Ss7NP
	eS8riEuw=; b=i3nQDg38WKf2Rke8Z7ZxxMpWgiZcBmznXtyahM6WcHXbB7x/ONk
	NbP2/rb9aoOtnae66VeosegAFN1vBUE5WkIHwYWgSwLDIwkpBRi0pa2gY0Jn/wNn
	VlR1Tc23Z1RXmKtTsQgTZl/msNBaG/7B7soT7K1YPLm5d9d/fbE9tIjT73q0gBIY
	GjUnbyNFBmFXPohS4Usfn2Lv3dssXVJ1TNsO47Ldb7DYK6SLnaYYMkSfIok+aPe8
	FCd7wJ+Pkz+dwHDJheEmNbGrFSXYRiOGDBT23TBjIsowEtmLjcmWrhGaGFl/mXqT
	TbnHc10dM/f3xNqkCYP3iwSpAkzqfRYAR3w==
X-ME-Sender: <xms:pTFpassIpwHG_tS0OKIUxvIy5YnqBK3tNpgNFghEjBqfhaMMi0LJCw>
    <xme:pTFpagfhV05_eujBObuePJ0KBvNWV0EKmcPsCedmLHjiBnfE_OEhYuikhEV8jG1SR
    4o-6iWKgkSoZPtHECOwsRkWJRQzY2TaheWZoorjvyYt7I4LnRUGJ4k>
X-ME-Received: <xmr:pTFpaswn9UFEsiEPPM7bDiP6NEWR4QjXWmii9vT4o_v-6EJ5AH46Dk4KNjLFKweh4S_fDAOLbH3N4Hd9zwL7ilo9TCsXNC3XPg>
X-ME-Proxy-Cause: dmFkZTGJpfqgEUQyvlH7TS7xKWcZaFLbwVgqB5jidjiPKHb5YZivj9+ppPqUiY8mgH/tEA
    4E3os2Q88VkbzLLz5kQQs9jDS9hR4yPQKvPHv2K2Bh5h0f/fi0UcZg+HnhxWVyzsU//tjU
    O+4L2X7yvvxHeRieMCeN36HoR+cOECv9pjPHdOT9mPMsJfYa33qEx0APM/cACdLR4HiQE2
    HCIUIGTD01ABwkcC1XA0q2roWxzamrJT1iOHHwyfil3N8qrxITRtznOvjaUB8YM/NGclgm
    7cTw5NfOIhPyyjxI8uXw8Ey8ZQf88GSPDNf5yH18cXujtOpK8Elci1LZs1wTeMsRcFDrOn
    L31EOAvPW7oStYVwluAflMtG+qJ++zqyLtLGsqolpXNMWdHQvY/KjJ0T3M3QVjtqroA2We
    NLZapkN/6fDKBHmAWrjIAWZmyXTc+AMS1VJbLuLftPOVNxrp+3xYMFbtWmyQ35NQuVHTHO
    MY9/SvZgj9JHKiLQDtwCB0CvzSK+rRSZZ+GdjYTcD4M3VMRSNeJiucp51nUXWd2J+nE00F
    MpCKl7U74DqpEWalSC9LXzVcmrArFqrcQdi7CoUSMLrTz8vVKZnR7wFqS+LFPQOlzUVM9E
    otIPfMyKMNE8zShZhMyec9fxWoRxLegag9scdUNLCvguif0w+mYr8qaxDRBA
X-ME-Proxy: <xmx:pTFpauFHU8jKKab7CuIjHtpjGUXInwfo0uWrXHwMJTEKKoV7YFp_wg>
    <xmx:pTFpaoz2tiyEwMC5qxferl0m-a0BslOGgwrvLOi0DyNVUtKfrOJ1VQ>
    <xmx:pTFpansPD2t3sD-igekdljI_tTRKeNoMtPgdLXx1GhWAv7-DQUtXTA>
    <xmx:pTFpat0soZRDpvoASqLkxbs0STHJNJY7wNfts4wqQQABTTXe4-rbQA>
    <xmx:pTFpauu4FVKU1EvQRNHW_BdM7tE5EliJrdoJTFgzMS8qbILAS2JnWe8C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 18:48:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH] merge-base: add tests for --is-ancestor
In-Reply-To: <pull.2186.git.1784998828879.gitgitgadget@gmail.com> (Nikolaus
	Schuetz via GitGitGadget's message of "Sat, 25 Jul 2026 17:00:28
	+0000")
References: <pull.2186.git.1784998828879.gitgitgadget@gmail.com>
Date: Tue, 28 Jul 2026 15:48:03 -0700
Message-ID: <xmqq1pcmd93w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
>
> `git merge-base --is-ancestor A B` is used a lot in scripts but has no
> tests. Add some to t6010 covering its exit codes: 0 when A is an
> ancestor of B, 1 when it is not, and 128 (not 1) when given a bad
> argument. Also check that --is-ancestor and --all can't be combined,
> and that the resulting error names both options.
>
> Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
> ---
>     merge-base: add tests for --is-ancestor
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2186%2Fnikolauspschuetz%2Ft6010-test-is-ancestor-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2186/nikolauspschuetz/t6010-test-is-ancestor-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2186
>
>  t/t6010-merge-base.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Thanks, will queue.

>
> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
> index 44c726ea39..d28d9dab2c 100755
> --- a/t/t6010-merge-base.sh
> +++ b/t/t6010-merge-base.sh
> @@ -305,4 +305,38 @@ test_expect_success 'merge-base --octopus --all for complex tree' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'setup --is-ancestor' '
> +	git init is-ancestor &&
> +	(
> +		cd is-ancestor &&
> +		test_commit one &&
> +		test_commit two &&
> +		git checkout -b side one &&
> +		test_commit three
> +	)
> +'
> +
> +test_expect_success '--is-ancestor parent and child' '
> +	git -C is-ancestor merge-base --is-ancestor one two &&
> +	test_expect_code 1 git -C is-ancestor merge-base --is-ancestor two one
> +'
> +
> +test_expect_success '--is-ancestor self' '
> +	git -C is-ancestor merge-base --is-ancestor two two
> +'
> +
> +test_expect_success '--is-ancestor diverged commits' '
> +	test_expect_code 1 git -C is-ancestor merge-base --is-ancestor three two
> +'
> +
> +test_expect_success '--is-ancestor exit 128 non-existent commit' '
> +	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor one no-such-commit &&
> +	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor no-such-commit one
> +'
> +
> +test_expect_success '--is-ancestor and --all cannot be used together' '
> +	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor --all one two 2>err &&
> +	test_grep "options .--is-ancestor. and .--all. cannot be used together" err
> +'
> +
>  test_done
>
> base-commit: f60db8d575adb79761d363e026fb49bddf330c73
