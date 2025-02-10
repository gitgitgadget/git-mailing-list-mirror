Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1B243946
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203339; cv=none; b=uHFxHsWQxAIWyDHGlK8WbiZRIgtshiZ9ElsgomFBHWkRRyKtzkTzCEqqdRT0BzSeKqe0Ru6a8tAzMJYpP/lb0NLTThtWpsj0WXA4BizH9qb8QpYMMEq5g83FxIKoZO2NQAQyZ8dOlWnFW3uUFZD5BSF3S0ZLzjkVM5qduAWizx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203339; c=relaxed/simple;
	bh=2Y8+63ViCTER1VX3iX40ZkIQ3uAmal0AG4f4NXI+STw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rcp8d/lwPt5mhYMidWqxnEa9NS2piiw77SwYvzvw3Pqs6vG7ECtTmrGFSLBmOHmifsZEGKOnjlMJI+AjPj4J4pGZX6o4HKGVQAYMgi6IwUNGtdDN1Thtg9aFhi3yOGopXIYVPFnc+l3P2qiWJZdIRm7kvUcOSrFRV8ghbtWmQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZfT8rw+4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+abLEvF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZfT8rw+4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+abLEvF"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CDCF11400CE;
	Mon, 10 Feb 2025 11:02:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 10 Feb 2025 11:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739203336; x=1739289736; bh=DbgPjjOFuO
	uAsHpvMtDcZxnvxk6I5FmOzxlcyIOVMTY=; b=ZfT8rw+4+5FNfe53G/puiO3xEk
	VkMW4KWe+h39c8jKSluzHbBZeGS5aq6XbJX4IpUwFaq8avtaVJmD29uSigGGTfTz
	otDiKPwbJcglSFcG6WTgRIe+701YOFX/QjlqoSeLEvNgAMggGdKSnqhfNWyEAPf3
	eMs4ODiVhTCVjRNKgd1LSsmTs/c3pockR4FWVqPFu0b4metNzVHk8vG2d5Tbir+D
	WgvhwhLIsU+dKGNETbasFBbsRh4YPbysEw6TTcuOEl5S25mtV6A8FZbmN5WzXEZF
	OU0hlpCLnxXDoxVFKY8b92o16KzviOTN0dwLlNndmUSQs1KmhKv/9Bxm1m5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739203336; x=1739289736; bh=DbgPjjOFuOuAsHpvMtDcZxnvxk6I5FmOzxl
	cyIOVMTY=; b=T+abLEvFy/IpNq/9RmIT2T2UJiXLQAJKzlRqAT0eU3Ht7Gtk0IJ
	rkL/MAo+Oz2ZNP4wnvU61yY3QkUh2HYtnd6gCjPH4G+PrLP223zq4qgI56ozTZd5
	EffxYrDl8p5Pv5ehbI7LVDneS669NV3ZO4VN+1j0BwsmITSqMFP07OrYlCU8+sDE
	hQEeNZ5La0PRfnbEwL2XHOmNsf4fd6zdYm91IPm5teHZYlaoZh/54XtK02EQIVdQ
	GUMW2k/8FkOajJJTEYZEdYpURhRq+V7DOBZ0Xb4B8PcV5Wo51NrPa4d3FI3G+boQ
	r6ysfLoGdTatabq7A0ayM4nQkcnwGn3EVYQ==
X-ME-Sender: <xms:ByOqZ7FPsEpCfnPy1A2cZn6SuVj38vpZs_bAPGguRsIrYUBSawORlg>
    <xme:ByOqZ4UQzXFVe5wY0QAInIki1LQw2nRv3x2buPDcRGqPHZ6U4GtCip4fezasSi334
    rRkz8jojBqbPurHoA>
X-ME-Received: <xmr:ByOqZ9LeIzlhnJ9tEZxXP_6zIS3FXoIy4E7S372OXFm8XvItvmr_7oxeCFD7mkldrTICnGRd6BW0toPwuYOZ1nA1Uvx8eGqzhB6D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepfhhorhhivhgrlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:ByOqZ5H38VhrDLuxa7ZjjrBnJO9sNKJ3ihF2jEGrZXhuA0Pi9KzNmw>
    <xmx:ByOqZxVzYne7wi3ZWKnSojiehDNtjadzxs-IprTvy8EI7laj2Ig-LQ>
    <xmx:ByOqZ0N6khaZD9G5Iqf9SAu-79W5BzqQD3vkmCcPcKyV_wKvLU0NRQ>
    <xmx:ByOqZw3Sl3h3TpMCQe74HAAd5Oqt4IT9_GpVNHFJBVg2i09QmuSb2Q>
    <xmx:CCOqZ0TFKBFtA1pEtMxfU6zly6OyqQyuLfNNGsign0JKU0ItEi2nI-Wc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 11:02:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Emily M Klassen <forivall@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] revision: fix missing null for freed memory
In-Reply-To: <20250208061702.88469-1-forivall@gmail.com> (Emily M. Klassen's
	message of "Fri, 7 Feb 2025 22:17:02 -0800")
References: <20250208061702.88469-1-forivall@gmail.com>
Date: Mon, 10 Feb 2025 08:02:14 -0800
Message-ID: <xmqqtt91dbzt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily M Klassen <forivall@gmail.com> writes:

> Subject: Re: [PATCH] revision: fix missing null for freed memory
>
> "git log --graph --no-graph" missed cleaning up the output_prefix and
> output_prefix_data pointers. This resulted in a segfault when using "--patch",
> "--name-status" or "--name-only", as the output_prefix_data continued to be in
> use after free()

Rereading the title, I cannot make sense out of "fix missing null"
and guess what it wants to say.  Is "null" here used as a verb to
mean "to assign a NULL to a variable that points at ..."?

    revision: clear graph callback upon "--no-graph"

    "git log --graph --no-graph" first populates the .output_prefix
    member of diffopt, which is a callback function, to compute
    "--graph" header, and then discards the data the callback needs
    to compute the graph header but forgets to clear .output_prefix
    pointer in response to "--no-graph".  At runtime, we end up
    calling the function that we should not.

    Clear the member to stop making callback, and for a better
    hyginene, also clear the pointer pointing at a freed memory.

or something?

Other than that, as I said earlier, the patch looks good.

Thanks.

> Signed-off-by: Emily M Klassen <forivall@gmail.com>
> ---
> I previously reported this a few hours ago, and ended up digging in and figuring
> it out. I'll make sure to bottom reply in the follow ups to this patch.
>
>  revision.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 474fa1e767..84cb028e11 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2615,6 +2615,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		graph_clear(revs->graph);
>  		revs->graph = graph_init(revs);
>  	} else if (!strcmp(arg, "--no-graph")) {
> +		revs->diffopt.output_prefix = NULL;
> +		revs->diffopt.output_prefix_data = NULL;
>  		graph_clear(revs->graph);
>  		revs->graph = NULL;
>  	} else if (!strcmp(arg, "--encode-email-headers")) {
