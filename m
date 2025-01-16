Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42825236A79
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068064; cv=none; b=hZmx7sRLpkze3LpCsFwInxG+Tpf0xCe5J+S/Yp2CJtOm5rVOxCmfhl8ZIgP2w8yjx0B6FwNbX46L8wfQcqqekFHF8N1w/gduE6YN4SxgPtv6ZoD9yB+KMelAtNwLW0wBvJ3cXifYGblBkTcUVezqBTZgtoDoddGCE3T1jK69dQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068064; c=relaxed/simple;
	bh=6giCUlkrARL1ATf1RC4U9RxC3jPJxi/r4Op6naE9+fE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ma/V0zX4CxSQlqjTCLKct/DxGqR2sSuINdVNN0jWrdj4kClTNkbJGSs5v2tSGKy3CCieiRZ19YzEFt4IQguEAV62jaVQUwVvdOY/arnETDdSbHQDnraa6+YBgCbWqjFFudjpBa7RzLY74NUzK7SsNCSPd9cIa2p5tpYMcswQJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kUuPK6/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oFMJ8VF7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kUuPK6/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFMJ8VF7"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FDFD1140157;
	Thu, 16 Jan 2025 17:54:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 16 Jan 2025 17:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737068061; x=1737154461; bh=uM+nYvQJzn
	rpf8TqhjZcXy1mMjKu1k3gcocAP4klOeo=; b=kUuPK6/ug/OUQmRN21rtC7JKis
	hODO4KRFQ9UWd4yGlqXNLMNBuk0TD5U0yGj5QqdXw8C2bZzWRVdFOWEkN3cjgg1n
	ZgXqHtz0Yg3PtUSFjOAcNu/xnyksDng656IPTsIVeE1715XJ22sm+q7HPnwhxkF8
	wMUQ8W5zmiPIVeTJRGmvOTuAZyhvFGcmMr9tIqjbbnQCZfYal1Y/FrRKbxRi4NKF
	xWHVrnQPRAkVC5Oz1lnPL5FeQHv/Tr9NByGBWm2AnJO1W4eC48DDqbbbyl1cOkUq
	XCrzQ+ZCpre9q43rBuXqNJ3BVeM0iDU6TL1IAxoB1tultUtOOLthlSpYfOhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737068061; x=1737154461; bh=uM+nYvQJznrpf8TqhjZcXy1mMjKu1k3gcoc
	AP4klOeo=; b=oFMJ8VF7iN1VLwKsMvvd4VXLyNbBtoNO2mj1TLBGumciFKPTQXv
	32gV/AKGzDN/WXDIBuOHjKNuDGNDIE7iTB8Hrz1GeC53UyIxYMl2scebyEvOfOyP
	aF/+HxIYoBIveCUh39LVlkFuBw81VkNa+N4bD4x9b3O3Oc+y+Cai1xcAwmk6sQLQ
	T1NZpVvCV1XszR8Ab2au05+Nzt8PcSWybvzDmGzYf4dNfDrBMv8ceEaqFiNa+iZc
	GZcn6EwSU4v7EXySjbOaD+0S/dHbYG0Z78XoovP3a3/9racdnPokuQjapPH0iqXw
	GtOr/Od+82hwfbgrS1oXgLo/CI3Ft3hQ2YA==
X-ME-Sender: <xms:HY6JZ4uEyvxDWhrNO3tNqoKTJc2xDUaSLaomcjhu8NYyMRcPvhLAjQ>
    <xme:HY6JZ1dtaZelCJswqwDREpLg50oA2iuW8SGr67zlPumSZVLuqJREKyczYXHQEzmme
    Uej1PhHah1LKa51Zg>
X-ME-Received: <xmr:HY6JZzwQtGXwkT603yhc1BI9DY4zwk3pEcQuVaquup1922DED4rZ8Pdj33fnLcLDx1M7565K3bOMdIZk8S1ajR_6k8XaAmDyfUcx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeivddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HY6JZ7M9dFi4XKQr5G85XiVouLLyyCLyITPpLqPJHlALF5fbbeuKEA>
    <xmx:HY6JZ4_bNHCuHvCFi2u4nanZqw-96L0bkm6Q0ZS1sMhn3E9txHio1w>
    <xmx:HY6JZzWSfi7K5KD4v5lxLxobkUCZ0t0DG1-YIYkKuPARs2BoRM_EEw>
    <xmx:HY6JZxdwubQyR9QzcYQIGMkpyoXeYY0LiiLNZBUhuxBMR9dbbhq1zw>
    <xmx:HY6JZ8ZKykkOw9RsZmE084Q4ZhwUl6ov967_BiEcCHR0FKtCJYmz4Ppv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 17:54:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH] grep: document negated line-number, column long options
In-Reply-To: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com> (D. Ben
	Knoble via GitGitGadget's message of "Thu, 16 Jan 2025 22:20:41
	+0000")
References: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com>
Date: Thu, 16 Jan 2025 14:54:19 -0800
Message-ID: <xmqqy0zanzdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
>
> I set grep.lineNumber and grep.column on in my user .gitconfig;
> sometimes, when I script over the results from `git grep`, I want no
> prefixes, only a filename prefix, or only the matched text. I usually
> comment out the relevant config sections or use `git -c` to tweak them for
> a single run---why? Because `git help grep` doesn't mention they can be
> disabled any other way!

While I am somewhat sympathetic, I'd prefer to see it done in a more
centralized way, so that people understand that *any* Boolean option
and associated configuratrion can be negated by prefixing "--no-" to
the base option, instead of having to learn "Ah, today I learned
that --line-number can be negated with --no-line-number thanks to
this patch."

>  --line-number::
>  	Prefix the line number to matching lines.
>  
> +--no-line-number::
> +	Turn off line number prefixes, even when the configuration file or a
> +	previous option requests them.

So, this is not quite welcome for two reasons.

 - We do not want to see us keep repeating "configuration file" for
   any negatable option, as it is common to all command line options
   and associated configuration knob that the command line option
   trumps the configuration.

 - We do not want to see us keep repeating the substantial part of
   the body of the base option by adding a separate entry for a
   corresponding variant with "--no-".

Even though an approach to centrally teach people that they can
negate a Boolean option "--opt" by saying "--no-opt", and thatn they
can negate a configured setting with a command line option is
desirable, for such an approach to work, the documentation must
somehow signal which option is Boolean.

The way we do so is by doing something like this.

$ git grep -e '^--\[no-\]' Documentation/

An example entry (this is from blame-options.txt) looks like this.

    --[no-]progress::
            Progress status is reported on the standard error stream
            by default when it is attached to a terminal. This flag
            enables progress reporting even if not attached to a
            terminal. Can't use `--progress` together with `--porcelain`
            or `--incremental`.

As nobody complains that "I cannot understand what --no-progress,
which is described in the above, means", there must be a central
place where we describe this convention ("git help cli" talks about
negating options).

So I suspect you'd only need to do something like this

    ---line-number::
    +--[no-]line-number::
	    Prefix the line number ...

in your patch, without doing anything else.

Thanks.
