Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753862C3245
	for <git@vger.kernel.org>; Wed, 20 May 2026 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242924; cv=none; b=O8kR2cfwqzEZcn02htnMgwBejSuh03mah3mVr7Ui9H2FTqmD33pFWzcv7qCzElP76kNvQgxliHfdJMBPe5bhFBQ9t3Z+ZmtVnX1Y8N/I206/9Qhcfy+gub0t+ohY3d208VYqe0SN0u57Su0OfrryeRcbpzQnQIEVFvvfho2Fasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242924; c=relaxed/simple;
	bh=EmDxhFWiGVfbgKDSkPhJtppQqp8jWDwiD6mQj2pyvNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2fBiKhq5I5M81nrdD4StAljedPHhporjoQ0MSLMukG3hm3FliuUm++Iu0rJHLczCwYDUyZ/XgcqLsyPyRdoZp0zy/VEbLZzkE5bdP6iRTqAul8hgxp84YAe1j9Ci0ytr80SLzbS/+r2tjZ+FxS//worcBa7wo3vqNFKpoYx528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v4FlPWbV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iW2Bsp74; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v4FlPWbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iW2Bsp74"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 35CBD1D00081;
	Tue, 19 May 2026 22:08:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 22:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779242921; x=1779329321; bh=BgC+33krVn
	o065lylNjvNLajSxK2ZOW5f8gF+z3gf+w=; b=v4FlPWbVTlkU+h6yZDz/jULt3U
	c9IliPwNca3i2m6P3DijYnJQH+/e2BU2ff9AEwevR4uE35qiY/yhu1Wyqrh3nKrU
	jFdGyLm8qTmuZ6wEW/FKHpni4n0gQ8TSs4dC3+c0cfBoLQ1Hy2F8yXiCHlN6tDTO
	/+EbSsCW6Vs7+A7Xrj4eqxmc71u6G44k1NGY5zCuaiMp6xmeCORnfhfuE2SPvNnE
	hB8qp7CtcqZRVSGFiq9DtqGaqjRczdVlFicjAOPwY4OgtXeGxfjL1d70pkZWiD8a
	t7OINqteg57wr4iriw/w+mCcoxby4EC6PZ+eZm++tD0w0g+GarpWKzlV4RRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779242921; x=1779329321; bh=BgC+33krVno065lylNjvNLajSxK2ZOW5f8g
	F+z3gf+w=; b=iW2Bsp74I1MNgqD8Jpd/h61W9aC11/h/ZKBMOWh6eCBtEzfHs7F
	A04EYpRghkW12QcLpLRDPNJKYR4XeRdmQld4qMaVPNH4THZIJ4J8ZGBLfb35sQ4J
	YYQrFnGbtSwYpM22KjeEZQenh4yvjz1GMvMgTY31okFZd6o7S0vleCTZQGcUKCnt
	lIEf3VEzDA2Kye8VQsmuYgnTAL4IOBtgkaNzqOgwHGFi5O+IWH1f2pKkSiks/LWO
	sAHjcUJ5Z+MiluSDbx6Wx7vWU7BBzerRObxksOT9f6X7EvF15vDmSF151I+B5SU3
	Eqb3+OqnZTBqjlVkVPo5TcsPeq6flDrpdHQ==
X-ME-Sender: <xms:qBcNauFbsGHwkhj4CMmeZDnwmMeShbrAGaWFUa4ApiLscTIfJmK3Wg>
    <xme:qBcNapVi-FBcI7CH_iMFdDegt5a0hddMwKM_t-HWy4LRv1BPAsB1GkcoOI30rZX--
    cK8-vNrOiD-YKm6jkPa96yZrFrJCcdW2KTmfp0lnJCvZUMBFeQZkEk>
X-ME-Received: <xmr:qBcNauxl7uGMTflYkNc6UdHCsDssizxxFr3_CyOErVqSy0WToh20HED5W6AYGHNG_KelXM7cHnvcRmxRpgA74w_hp87QVDCarg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeffeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehtrdhguhhmmhgvrhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehvugihvgesghhithhhuhgsrdgtohhmpdhrtg
    hpthhtohepmhgvsegruggrmhhjrdgvuhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:qBcNamRrW-CSs9WT2ZzX2QTSLnt7_SPqZmPGyMtLrSN3_VibrPdUvA>
    <xmx:qBcNaijiW-SxN9I0DIxoDsU1Oy1QFLU3hvaAl-o7MnK0Cyws1DjzSw>
    <xmx:qBcNalkb4yeZLr23XQf5aEUNerheRv4OpKmXpQBT7ahCcdheKNfcYw>
    <xmx:qBcNattvbvGciPp-hmmMQ6EDuNl9rQuEt3ecDJgiX6Y8tktRU7SlXA>
    <xmx:qRcNaod79dLYqW65wnxzJWPGlaLeo1bNFC1-Zmwf0yMqvUokOnG7XO2n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 22:08:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Thomas Gummerer <t.gummerer@gmail.com>,  Elijah
 Newren <newren@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Victoria Dye <vdye@github.com>,  Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH] stash: reuse cached index entries in --patch temporary
 index
In-Reply-To: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com> (Adam
	Johnson via GitGitGadget's message of "Tue, 19 May 2026 12:43:25
	+0000")
References: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com>
Date: Wed, 20 May 2026 11:08:38 +0900
Message-ID: <xmqqse7m6deh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adam Johnson <me@adamj.eu>
>
> `git stash -p` prepares the interactive selection by creating a
> temporary index at HEAD, switching `GIT_INDEX_FILE` to it, and then
> running the `add -p` machinery.
>
> That temporary index was created by running `git read-tree HEAD`.  The
> resulting index had no useful cached stat data or fsmonitor-valid bits
> from the real index.  When `run_add_p()` refreshed that temporary index
> before showing the first prompt, it could end up lstat(2)-ing every
> tracked file, even in a repository where `git diff` and `git restore -p`
> can use fsmonitor to avoid that work.
>
> Create the temporary index in-process instead.  Use `unpack_trees()` to
> reset the real index contents to HEAD while writing the result to the
> temporary index path.  For paths whose index entries already match HEAD,
> `oneway_merge()` reuses the existing cache entries, preserving their
> cached stat data and `CE_FSMONITOR_VALID` state.

Clever.  As the fsmonitor_valid bit is in-core only, updating the
index in-process would be an obvious and probably the only sensible
way to preserve it.

I however have to wonder if simply replacing the external process
invocation with "git read-tree -m HEAD" (i.e., oneway merge) gives
a similar speed-up.

> This makes the refresh performed by `run_add_p()` behave like the one
> used by `git restore -p`: unchanged paths can be skipped via fsmonitor
> instead of being scanned again.
>
> In a 206k file repository with `core.fsmonitor` enabled and a one-line
> change in one file, time to first prompt dropped from 34.774 seconds to
> 0.659 seconds.

Interesting.

> diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
> index 90a4ff2c10..4b3241c8cd 100755
> --- a/t/t3904-stash-patch.sh
> +++ b/t/t3904-stash-patch.sh
> @@ -84,6 +84,24 @@ test_expect_success 'none of this moved HEAD' '
>  	verify_saved_head
>  '
>  
> +test_expect_success 'stash -p with unmodified tracked files present' '
> +	git reset --hard &&
> +	echo line1 >alpha &&
> +	echo line1 >beta &&
> +	git add alpha beta &&
> +	git commit -m "add alpha and beta" &&
> +	echo line2 >>alpha &&
> +	echo y | git stash -p &&
> +	echo line1 >expect &&
> +	test_cmp expect alpha &&
> +	test_cmp expect beta &&
> +	git stash pop &&
> +	printf "line1\nline2\n" >expect &&
> +	test_cmp expect alpha &&
> +	echo line1 >expect &&
> +	test_cmp expect beta
> +'

What I read from the proposed log message is that the change is
purely about performance and should not change any behaviour.  Why
do we need a new test in t/t3904?  I would not have surprised if we
saw a new test in t/perf/, though.

Thanks.
