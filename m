Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03B34D3B6
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287993; cv=none; b=VwetWl72lzzku+Bzm7HNQ/npqoKYXWF4V0gwgVUIZRNcMeT4xnNmV0cxyxlaoxQ2R6ZAV0BYOnmdaK50ZD0CGZK8m1+yeRNPJsytMcBoZSebzDEnnxPkiclwQexmGCIlnOts8fu7ZeeqqtMSCI8e9oYiQki3p/OCiKuIMqPtv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287993; c=relaxed/simple;
	bh=FfA1swbZePCnKwtaR2CEjvv/ibIYRChxHIY+kbeQ5yQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gnMfYNeWC1Iewrcfsob6wDtmc3rl4PtnVt9iDPLr1bdfc7IFQYw6QA1Ty3eDu8vanNO7zpK/LHpFYYUQdMH+X3MFP85dgy7leeQICPcLER3RroRapPikc+lKLHgK1ZFmlsp2HNp6H8ke80IlKWVG2XswKazz9eQKgP3HiLWGh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cBTcHSWe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ghl5fEX/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cBTcHSWe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ghl5fEX/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B57114001B9;
	Tue,  4 Nov 2025 15:26:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 04 Nov 2025 15:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762287990; x=1762374390; bh=028f2IcR5m
	4wf7AOrMbJHB726mtJVnDSCG3oK4r1nM4=; b=cBTcHSWeZWzdQlfctNhbbz62x6
	UBjzmgf2fxVbHK6NYggrPk9hc97qIcQzrj4lf8n1vMT0MsiBVU9gsXbyKdZZE7kA
	bEBi9fh6rzoiB2M/xwW0BowGgFc37NXGDNd18gffo9Yft+JqfDcvnU+Z4RgaHrFN
	WayA/wlYSL3/SpT7JwBZupvWqbOAseWXhPIHT0jH5BNyDFmHXjdrjLam2i7SEOpF
	Q+UCTb8cjnGH4CNv2uF/tLlmQNrYDVLRapeVzRxzkb+gNc2pc+1H8utiIRLBEzRq
	eiOZPM/9GHUIN2AwInoHMg06J0ps7u7s4ZrH80/Yohjj90OuST87WWm8A6Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762287990; x=1762374390; bh=028f2IcR5m4wf7AOrMbJHB726mtJVnDSCG3
	oK4r1nM4=; b=ghl5fEX/rvzBkExsJ6pyjg5bGltA8+hsBn1lEc41mULl83IqYBL
	abr4MWgn8DB75XJHRgZXMzefc4fhW56VYWXV5jNG4A8qG+Ve6/fCBdU2wqf9oPfZ
	BeRV2Wlghvdugs3foQD9/iJ2h8iTng3KD1VD4/LAsSHkA+2WoQKbC5dELAybNnLA
	JZJ4KrgnIkjRH5iLQnQVE+iaKe/kvFxZkE6BoxoJ4/46VU9po/sh22XKLlR+DIaG
	CO2RPFrhDxgrVF6BEExxijZ8kUDyB1ZwKSL5FYkrnviJSCx4r+jPz4SnF/IxrWIj
	Z4r/xdg9e3h1vnHZ3gj8ltU6zKzcjQQEAsA==
X-ME-Sender: <xms:dWEKaczHuDkn83GpZY7I70kwV4RnSNP_q_RcNjy4PeyYmpD0a7p6qQ>
    <xme:dWEKaXJAa8oG1hnlNZ4uEf4W8nY9DInhJ6iuBGf5UgQrd5vu7fZSVsTjauO_hd5Ok
    3Gp2PspvZej01Y6ztN14dRtcFLPoHybrRfW71fRSOCB_JUzqwDzgw>
X-ME-Received: <xmr:dWEKaWpvu3PjHJOfv-RmPJ4R5qw-uvQzDVdwNNooZdlibo2tPldsjcxtyTfwegaTryDOndQkfdidz2inwwAnj38pRdoO9RQ3nIsS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dWEKaWLWQNRmepDZHOsAuKlFMPoJy_V7goBnh7O9kx0LTy6_sP54yA>
    <xmx:dWEKabQQpXON68uo8WJgeK_jt9B0FaQXuU9cnPbOLMnaeWnOtdBT5g>
    <xmx:dWEKaVsuNgzoW04Y_yStlba1wbh6PTr15B9ILhUE6HIH4DOVPy7r-w>
    <xmx:dWEKacbG1NxgNnlfYjZPmTuCec45DaFuiSBbd3NE2IEivm5-PC1icw>
    <xmx:dmEKaRZHxMDrDHrnAkqSDYqtvqe5-iaOBUx21FE_qSkWaSEfEPsnPYfr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 15:26:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v2 2/5] reftable/stack: add function to check if
 optimization is required
In-Reply-To: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-2-303462a9e4ed@gmail.com>
	(Karthik Nayak's message of "Tue, 04 Nov 2025 09:43:57 +0100")
References: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
	<20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-2-303462a9e4ed@gmail.com>
Date: Tue, 04 Nov 2025 12:26:27 -0800
Message-ID: <xmqqcy5xpmrw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The reftable backend performs auto-compaction as part of its regular
> flow, which is required to keep the number of tables part of a stack at
> bay. This allows it to stay optimized.

Sounds very sensible.

> Compaction can also be triggered voluntarily by the user via the 'git
> pack-refs' or the 'git refs optimize' command. However, currently there
> is no way for the user to check if optimization is required without
> actually performing it.

Sounds very sensible goal.

But where is the existing logic to decide when it needs to
auto-compact, performed as part of its regular flow?

After reading "the reftable machinery already decides when it needs
to compact and does so" plus "but the logic to decide is not made
available to users", I would have expected for this patch to extract
such an existing logic or otherwise make it available to new callers
so that things like "gc --auto" can call it, but the diffstat shows
mostly additions, which does not give readers any confidence in the
new function that answers "do we need compaction?".  It would give
_an_ answer, but there is no clue if the answer it gives is the same
answer as the existing logic that decides when to compact as part of
the regular operation.

I am puzzled.

> +int reftable_stack_compaction_required(struct reftable_stack *st,
> +				       bool use_heuristics,
> +				       bool *required)
> +{
> +	struct segment seg;
> +	int err = 0;
> +
> +	if (st->merged->tables_len < 2) {
> +		*required = false;
> +		return 0;
> +	}
> +
> +	if (!use_heuristics) {
> +		*required = true;
> +		return 0;
> +	}
> +
> +	err = stack_segments_for_compaction(st, &seg);
> +	if (err)
> +		return err;
> +
> +	*required = segment_size(&seg) > 0;
> +	return 0;
> +}

Specifically, where is the above logic come from?  Is it duplicating
an existing logic but that code is hard to separate out into this
helper?

>  int reftable_stack_auto_compact(struct reftable_stack *st)
>  {
>  	struct segment seg;
> diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
> index a8b91812e8..b8110cdeee 100644
> --- a/t/unit-tests/u-reftable-stack.c
> +++ b/t/unit-tests/u-reftable-stack.c
> @@ -1067,6 +1067,7 @@ void test_reftable_stack__add_performs_auto_compaction(void)
>  			.value_type = REFTABLE_REF_SYMREF,
>  			.value.symref = (char *) "master",
>  		};
> +		bool required = false;
>  		char buf[128];
>  
>  		/*
> @@ -1087,10 +1088,17 @@ void test_reftable_stack__add_performs_auto_compaction(void)
>  		 * auto compaction is disabled. When enabled, we should merge
>  		 * all tables in the stack.
>  		 */
> -		if (i != n)
> +		cl_assert_equal_i(reftable_stack_compaction_required(st, true, &required), 0);
> +		if (i != n) {
>  			cl_assert_equal_i(st->merged->tables_len, i + 1);
> -		else
> +			if (i < 1)
> +				cl_assert_equal_b(required, false);
> +			else
> +				cl_assert_equal_b(required, true);
> +		} else {
>  			cl_assert_equal_i(st->merged->tables_len, 1);
> +			cl_assert_equal_b(required, false);
> +		}
>  	}
>  
>  	reftable_stack_destroy(st);
