Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592C332907
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695152; cv=none; b=UIrg2dw+wrhJ5LeFxzJf1h1H1wITggmLpm+XKjehLaK/oN4ilpvHGMQb/wfCvw1MDHyvOoGPsCTk8CJ5To+chLz08ed7GPV1xtPgqqdOAMebuyi3BxbcCIHx4FdlPIgMQXF0v/CyC+gX6JR+qrswQNts11lQlBga9+GyMCAC7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695152; c=relaxed/simple;
	bh=oHHgKadwTRFo5sEoHaft+1XWHJVILJXWaO2H2Bk6nEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eEeW7HPbpt1o8I50DoHyoBQry2L0OC/nChZ6ldS0mFQKrCxDrGf9+AnF/9HCOx0XpQBjDAhU5GEI/N7G98yZzlQRNAXU76QxzM50K6uoj2bPBwjOeHyH5fi3sISzomavxHnYsWye9TjfgLs29d5w/EV5e8+KNQ03nqNbH4kNQ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eqfaj4Lj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J+Z2k4lF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eqfaj4Lj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J+Z2k4lF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4AFC314000E3;
	Tue, 25 Aug 2026 17:59:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 25 Aug 2026 17:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787695150; x=1787781550; bh=7sml0PWl8T
	GOVpEZosw3/O3ioXLOLglvzEt164bGuKY=; b=eqfaj4Ljqybo1/pPKN+wF7lR1T
	Z5HDYpyTLosQczcdKa1bGxC9j1Z4gxRiuwtxWm1PW80nIPsahsRfNIYwe5fbEMJ5
	hNEKxJNlY9PdOVgunuXiOuuKwArNOJEOlCqkkQuF/enXDWs+9W6gKZoahSdzOUUg
	Q5Zi39lv/c9n/8uygecAl8jMzq6qfn5m+SMHCvjb9iYGE9Cw3e9QLKUWAyfrclOs
	ce9LCJOHBv8DxTUOMWKGlwYzB4rQUwXAlnincFn+syoUm479g5s69czLUZfNc07q
	ycJpEwP5Ne0uesIwPzVe2kMX57+K84yFmXWkz5wpNNTYt+OjPa8YAASz7axQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787695150; x=1787781550; bh=7sml0PWl8TGOVpEZosw3/O3ioXLOLglvzEt
	164bGuKY=; b=J+Z2k4lFLWtqap2NA5b7Mz4CMyZhDqBekHnSRNR/TWDFFZqQO8t
	M3OmL9jqr7/RhaGHGZ7bT/UDbj2wIEXWjLe9t5ci1750h32eSKWzP5W7heeIAgvD
	v1mpP2p7N8i7gNuDQRHgYAFnNjUc5AXN1oyoFy9TtAzt8QMNjXeNvGpjzi4lP0vH
	Rx3iYhPBepwuST11to9Lrk2H63XGe9zd/sXXG6Mwqt/XWJIPoPrs8WUuO1tWc9Fu
	24imlgc3S+ZW1bp1qC1LleY2h/+G+3+U7Pk0tLMEQB8yMLpTB7ZOVGVJNZAK6IMg
	4TxEJHkMB0SE8SSBrbw6YoKKNMymebUx8jA==
X-ME-Sender: <xms:LhCOapJ3TSlLIkvpkwmWlwexvwcM8arWDrCY59IjvcqqgTPz98Bg3g>
    <xme:LhCOasLVL2nYnvAvRx0vd8TZ-lkzT-R2djOx4j05JB7UKC-1qywukHDoct5CTdi7d
    NzsEEZKhEPAHtGtTNLxlV03Ssyaa_jBljT4BVe0zEUIlFeagrt6IQ>
X-ME-Received: <xmr:LhCOamtdLHyM6FfDMBLMAMrqrJ3i7veHuML4WMm2sS_UhN451OBnfFsIJ84YIBY8PfH9sWC4AhGeAIrFbeLoIkBX3EXoYx30Yw>
X-ME-Proxy-Cause: dmFkZTER5Xx7PLcil4ZuKT7RamUWpOMbyW55mW6vxYiJxio14AqJd5H+t3ZBcLc0bHPq1q
    +yWD46oxGk02SLrN++0uBL4QzZ3LH3G/CY2b5cIxIyBAVILlcIahdO/VLbdKsJTEORaMey
    yQioKakxEawYZCysU/HV+7HjiLLrl1m7PaH2ru84bltEm09dfvN8TCWeqI3OlB6/fdxfXE
    56uIcz/NnLd3NNdyT6YM/OKtJOp9gLlmtcWbyMjy54nh4CyAUm2f3Av8yukwIObhFZ31sL
    MGiu+xf4BllrigTRVLuBUoTSBcqo4hWO59KKoncFCaPK3EjQu3XsD8Kd0LG106NqEtn7tH
    n+oYICXEhBTMlagEihrlMqEAvwBLx/68yXBEcF0gbmXblZZqpEt9Nj1NKbddHEw78/0+BS
    wJsdUF2JjijEob6YSAPkMGOmh06QuohIa2Uu9oc/6mqROQcbPA+Qi42M8y+innRBxSgI8P
    to5l2CyM/hV7pqYxy24huDTv7hofi3gpPqOmidhscNwveNT4I4m8JPfXyduRM+2iTQPriC
    zBFN300wSUOmtk60VnP8uuCrnHWAQdceJrjHDAHshnIlpGDPuCULIZf0Ycha3w9jwlFmse
    TmPRoJivVs3gx5tWzv11cdFxEdFqnejFALbI+4PsHAocqwvaE8X4hywCJrYw
X-ME-Proxy: <xmx:LhCOapT2lXxg0mUVTtgf8Of31PqZ7hqtEWHm_8pwZNK8Q8qcFB7LuA>
    <xmx:LhCOasMqFB3mum_74eZu0kyDofH5C1D3tAsg2AIfV2k9xexBAR8Ncw>
    <xmx:LhCOaua0W1TrHOn56kxEMmHU13AEcnSuuiMfGbQ2DZ-gSdi12ZwMnQ>
    <xmx:LhCOamy9hQ9pmRRwMCs0lZ4kHHgi5Y__MpKTexC9iCbShohhYYojoQ>
    <xmx:LhCOamNXl3B-x5ajmSfLZZqLXiiZEmkxOuXdIkbNVGCeAthJOCAXgZHY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 17:59:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 2/2] branch: protect local upstreams from -d
In-Reply-To: <d3d7a06e3d6f0c7adf9739ca496ed4012e261ac1.1787693117.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 25 Aug 2026
	21:25:17 +0000")
References: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
	<d3d7a06e3d6f0c7adf9739ca496ed4012e261ac1.1787693117.git.gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 14:59:08 -0700
Message-ID: <xmqq33w1lv4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A local branch may be fully merged into its own upstream while still
> serving as the base of a surviving stacked branch. Deleting it with
> "git branch -d" then leaves the surviving branch with a missing
> upstream.
>
> Use the existing stacked-branch protection after checking every
> requested deletion. This makes multi-branch deletion independent of
> argument order: a branch that fails its safety check remains available
> to protect its upstream. Allow -D to override the protection, and allow
> a complete stack to be deleted together.

It may be a good thing to optionally be able to do this, but
changing the long-established semantics of what the '-d' option
means would lead to serious breakage to the end-user workflows
people depend on, I am afraid, and...

> -test_expect_success 'branch -d other@{u}' '
> +test_expect_success 'branch -D other@{u}' '
>  	git checkout -t -b other main &&
> -	git branch -d @{u} &&
> +	git branch -D @{u} &&
>  	git for-each-ref refs/heads/main >actual &&
>  	test_must_be_empty actual
>  '

... having to adjust the test command sequence like this is a very
clear illustration of why it is not a safe thing to do.  Our change
just broke what the user wanted to do, i.e., removing the branch
@{u}, which they have happily been doing with '-d' while guarded by
the original safety feature '-d' already had.  Now they have to use
'-D' to remove it unconditionally without safety -- that is not
exactly progress.  In addition, depending on the version of Git, our
change makes 'git branch -d' behave differently, making it less
predictable.

And no, a configuration variable to tweak the behaviour of '-d' is
unwelcome here; it would make the behavior of the command and the
option even less predictable.

