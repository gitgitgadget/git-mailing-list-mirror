Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4A314B85
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482013; cv=none; b=qOQU4ekG5SUO7LVvmaPu1Y6DvCI6bUWOX8GAX9IaIlrjKlszl01VkBY1Tg88vr0f7Brv97N55ulrZiEw1DBxl79UwoU+YDCYNc3SbZ8bbO/6U0KtTh579EXKz/QCsUCvmBHORDAqy3BlpnYfGvp54YoV3RJNM5mxc1P9jPiYGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482013; c=relaxed/simple;
	bh=Qv181jjEFFOYsDcL803I44g414B7H9hLU7goBrMhT3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ozze24QHx1n89QlTK9PonemgkXjhmV5z0Ib1HuAtJzGYiQ4LVZm3i399jF4vr5pS5+aR2X7WvyWHs/jtL0CAA84jgdgiSKxIAD3ycSC4jd+MEW5teDhr8M4SaDGdz6B8RNyfjwg7fsKXrCcE5KsnFChr9kPQKyQ6/5g1aZqv+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oZmctF6A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMhzkOyk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oZmctF6A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMhzkOyk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6AAD87A00CD;
	Fri, 29 Aug 2025 11:40:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 29 Aug 2025 11:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756482010;
	 x=1756568410; bh=9Pbduont8jVzZfV76gAWTtYiUxdapeghLXxcDDUz4t8=; b=
	oZmctF6AVZq/8E+XHVm+RKH3xNzFksFJ23Vj5QqI8PhImPD6y6kiVlul/ns+egHS
	xoajEf29UMf1yN15IbECzMKT+P9VnceLrGGNF0sxKFoER90ypChfL6S7ECQ62DGL
	qz+IEVphJU/ZpviICRHo7crllFD8bZQyn+0ZieXLMSz6Xc7oIgv8IDPf7VBfWM2p
	/aY50Bp+1Mk7z6whAhQgQ7hughTOjzn/Zn9c0YLQPbzQZWAdaNIeX2g6ahDwruWx
	8LvO8wAFsSfXNpRpcrT+NCqiPO7yxPmOxL9tNK48ZQOq0OpmML0E37vHby+2vWLQ
	dU+tW0+ab4jw03ccU1snJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756482010; x=
	1756568410; bh=9Pbduont8jVzZfV76gAWTtYiUxdapeghLXxcDDUz4t8=; b=E
	MhzkOykyDTbWRPTOTiQ09dr794gWmMcnVtTRTwh4mPMZRxQSPYzQOqYXnU5osSdQ
	ZI70snPjTysxgW8y0LC7IuE4zAyyk6nffJFM8mwSLZbDgFi149Nmx0VipkQCBwZA
	cb9sfo3TG97Kxj5r5GC1+GGvg4HuEky7dS5GUZ2PCafyV8fwJc9SSKkVpt1/t2Tg
	Q7SuqK+kbOgAe8FzRA7HoQnT/Z7yvOFe31DRoY9tslnbSJGfkq67l2z4v6LhGWDf
	KzqftSthenyG9MjuFenjReJBtUoJHbHIm6kcYGCT3wpiRFDDG1DN7jcmOhtB1vay
	MeSIBdudMKOj0+UVOWj+w==
X-ME-Sender: <xms:2smxaB-96oobURnaDT9YpfL-1JNm1ubYu_2pj0Q724QQSPTiswGVeQ>
    <xme:2smxaBPzguluQDHE978rvaHwLOZDPsYY3J39hr8uwErwbeMsSUQPg5VSSEOsRUkOp
    Bld_6CHIeCOqc-3_A>
X-ME-Received: <xmr:2smxaFe7SSgQDXEMztgX9hnq7SM6Aa4yUhttM00CEUPMmvqfvnYXuaAVFmQ-FrVxN1pRB2merPEQ-c8z3pGu1KEx-YSpb1dcUGdQ9CM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehptggrshgrrhgvthhtohesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2smxaAWr_sB2f7DPVTLK-u1p8GjpzzJ-uGjMTpbvmSo4R3-DIpsL7A>
    <xmx:2smxaNiorfxiNujBQ_Hxt1eD_VGgF9kMueCBgbkJ6AVxsWRcRJZefQ>
    <xmx:2smxaP87_Oijq-JLysMBMriZrl7NNEeDzaUuMybK4ehFb9VeylJ39Q>
    <xmx:2smxaPbm0TlikrGFebz9NfHxaOtEtPYTSWCzvn7N2ideghzmXt_OKw>
    <xmx:2smxaLsECukQoEybtgsxy0Vh-YTLGRTQyl26gqpT0KCWVW7ctiDUBWJG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:40:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Paulo Casaretto
 <pcasaretto@gmail.com>
Subject: Re: [PATCH v3] range-diff: add configurable memory limit for cost
 matrix
In-Reply-To: <pull.1958.v3.git.1756465231183.gitgitgadget@gmail.com> (Paulo
	Casaretto via GitGitGadget's message of "Fri, 29 Aug 2025 11:00:31
	+0000")
References: <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
	<pull.1958.v3.git.1756465231183.gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 08:40:08 -0700
Message-ID: <xmqqecsup25j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paulo Casaretto <pcasaretto@gmail.com>
>
> When comparing large commit ranges (e.g., 250,000+ commits), range-diff
> attempts to allocate an n×n cost matrix that can exhaust available
> memory. For example, with 256,784 commits (n = 513,568), the matrix
> would require approximately 256GB of memory (513,568² × 4 bytes),
> causing either immediate segmentation faults due to integer overflow or
> system hangs.
>
> Add a memory limit check in get_correspondences() before allocating the
> cost matrix. This check uses the total size in bytes (n² × sizeof(int))
> and compares it against a configurable maximum, preventing both
> excessive memory usage and integer overflow issues.
>
> The limit is configurable via a new --max-memory option that accepts
> human-readable sizes (e.g., "1G", "500M"). The default is 4GB for 64 bit
> systems and 2GB for 32 bit systems. This allows comparing ranges of
> approximately 32,000 (16,000) commits - generous for real-world use cases
> while preventing impractical operations.
>
> When the limit is exceeded, range-diff now displays a clear error
> message showing both the requested memory size and the maximum allowed,
> formatted in human-readable units for better user experience.
>
> Example usage:
>   git range-diff --max-memory=1G branch1...branch2
>   git range-diff --max-memory=500M base..topic1 base..topic2
>
> This approach was chosen over alternatives:
> - Pre-counting commits: Would require spawning additional git processes
>   and reading all commits twice
> - Limiting by commit count: Less precise than actual memory usage
> - Streaming approach: Would require significant refactoring of the
>   current algorithm
>
> This issue was previously discussed in:
> https://lore.kernel.org/git/RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com/
>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Paulo Casaretto <pcasaretto@gmail.com>
> ---

Looks good, especially without the reordering existing entries in
the options list.  The authorship information above looks much
better, too.

> @@ -40,6 +57,10 @@ int cmd_range_diff(int argc,
>  				  PARSE_OPT_OPTARG),
>  		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
>  				  N_("style"), N_("passed to 'git log'"), 0),
> +		OPT_CALLBACK(0, "max-memory", &range_diff_opts.max_memory,
> +			     N_("size"),
> +			     N_("maximum memory for cost matrix (default 4G)"),
> +			     parse_max_memory),
>  		OPT_PASSTHRU_ARGV(0, "remerge-diff", &diff_merges_arg, NULL,
>  				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
>  		OPT_BOOL(0, "left-only", &left_only,

Among existing options (an excerpt from "git range-diff h")

    --[no-]creation-factor <n>
                          percentage by which creation is weighted

    This controls how correspondence between commits on old and new
    branches are computed.

    --no-dual-color       use simple diff colors
    --dual-color          opposite of --no-dual-color

    These control how the findings are shown, by painting the lines
    in distinct colors. 

    --[no-]notes[=<notes>]
                          passed to 'git log'
    --[no-]diff-merges <style>
                          passed to 'git log'
    --[no-]remerge-diff   passed to 'git log'

    These control what text are used to represent each commit and
    participate in comparison and display.

    --[no-]left-only      only emit output related to the first range
    --[no-]right-only     only emit output related to the second range

    These again control how the findings are shown, by omitting some
    commits from the output.

So there is no perfectly logical place to place the new option, but
between diff-merges and remerge-diff somewhat feels a bit odder
choice than other possible places.

Will queue as is.  If some users find the location in the "-h"
output too odd and disturbing, they can later send in a reordering
patch on top, but I would think the chosen location is good enough.

As #leftoverbits we might want to

 * Group range-diff specific options with OPT_GROUP()

 * Instead of having to match the full NxN matrix, perhaps reduce
   the matrix by keeping the most promising M (which is much smaller
   than N) for each N, or something?

but that (especially the latter) is totally outside the scope of
this patch.

Thanks.

