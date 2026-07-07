Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60568382388
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432024; cv=none; b=qhwFAt2JYH0u5RNX8XbTRYSb8DLkVaqR4zt5QR9OeMT5xG9e/VEdKDcdTyDyElLjWWqnI4rGF5JB2hRjYWpRJXSm2dFDm7QsPha3DYGbx1sMAP9Gqo4n1u9AMIqoNCobBMwZdl+EtlEooycq6j1jTMHsT6agBMEa7AmMUX0SRcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432024; c=relaxed/simple;
	bh=4JdgKsI3dXOQdTIFNG9UnSDh0xbsCQfOyV8OyR371jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaG/iZPvsZkpX91nkxdo0sCAvj+NzFWsJdQifWHUQEHaXlnUQx2VdDLQm7qnR9nhgAQYmdUcrstekYxs4ca1Cv3G7K9a7+YR69MoR1wM2x6DmPkYLJejy+kzDKyXKLlAOtvkRKOLgM+epkucUw9gotdO7iD6l/McEmAHwWlv/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dKCC+z/G; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dKCC+z/G"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81d2b54fa70so2206117b3.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1783432022; x=1784036822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RI9mKnLArrlAtiJCTyt5FVlJoAT6jHxkiikpnAxmelo=;
        b=dKCC+z/G5034UGKYkLCmzOKX70BkpmU3wzh/CAso8SiioNlD1Z83ROZjCDiQWkEy4z
         KA7r+mqFlxU3yorSkA/DuyweUk/gysst5fBbymU5+5wU2T675Y13YOIJANFgH+PCh7vX
         M/WOIAX/6RN2+i2AkvZ8qSffWu7CfW1mkEkhqUP+ohqYoR3hmSJcwUs3QBQgdHusO9B5
         NlQBnkdgG0I6uEIWClE4ovVbtPAkdZ/Dg7Cf78fn5OapAGL2YLInHUvxXqLAyRSwkene
         aGZ0AYpzS2w90jsD6z+/X486DeUU3IpId2njxehoI+wymx0+d9+qSqDeihlHuZpfLX8H
         vXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432022; x=1784036822;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RI9mKnLArrlAtiJCTyt5FVlJoAT6jHxkiikpnAxmelo=;
        b=fjgQST7l+TVjr/nX/RyQx6wdKaw83N1clR4rwmLMlfHoDsUHzOFvl+g9zqDmiy+onW
         IjZ9CqymN+1SOuNDAF7EspCuC/6KQxMYoMBop7cc5LEVf/o7Dxzh7TglZRNBpDseBw4d
         gY2PsFcRuRiQklZq7PHrKdwcfY7iUSaMsrldSD0dahTQFnCOt4WXX/ycOF0AHKC8l+bH
         td8b7hqwoPyni8+prrhNSXRZlkDDWsFiDmkRG76z//1UwPAGMP1ahCQPrs3cZe5FFFc2
         L0qg0LvLxOvjx+Gsibisz2XWAStZEdTe2bt38+i+u3XEVI18H/7cKaEJ+KRUY/hIDHxy
         qm2Q==
X-Gm-Message-State: AOJu0YwrrBBTRMwzQjBbBTzPJAV7rWoi+V5/HcHcV9M20N65PcI1pttH
	RPNwl7/Yztbfqm7Kis2gKbY8zUAtDQdVhNXqFIH7Zf+B3+Ec4GWxdKHi7mTM0pp/shk=
X-Gm-Gg: AfdE7ckPbt6wzZXJvxRwL/epUz5zfJFlVgctWt21i+IsZRDypJDul2l1oE1GSv0wHJQ
	iZdqdYGJLEM2K7R9c8BfKKbHCPVOojMNfaZllttmte51cljeEgZWsBn+z4NdaVjEo89zc93yshD
	fNqNfoxaznN2C1kMD8R0/I1BKElvYzMiv3rRgOkpd+dLi3LI1ciDu57bA8kOFCOBsaoHB06igo9
	FSkcaVbw3E2fCkRz4j+Tf8iLqg0WZEEG6lIDyT+qkxImrf/igl0kfgrUGCd5hX16Msmvmrr7MUb
	IYcjN5Ys0G3LPjAZxWYwCrpix75mPKZCJiNxZMDNkvQpCgrSpMoE2O/A8M/p+vnOwC0SL3r2x13
	poRvONmW8eP6eHaeUXPfTtx15fCBxT4/GDGzZAwpKUunj0kS+QCIS5H6qVdtGs3RG4ScHssvWdA
	pPq8osH8ZZR1G9/Rhdt5g+6n3R4C5zlfpcp4oD0kwG2t3GYO+SMPHfL9adBj5MXyrFARe9xj+S9
	Q3tkfBmljkYU+QmjOT9NfmzRgNyaZtrPh+dHkDUB24WKc02Fx7305XPJAkfxgR1FcQ3yz38uYC/
	SRrWRw==
X-Received: by 2002:a05:690c:6111:b0:81d:26f9:bc85 with SMTP id 00721157ae682-81d26f9c09fmr3850597b3.45.1783432022330;
        Tue, 07 Jul 2026 06:47:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81c9267e3f7sm5596507b3.47.2026.07.07.06.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:47:01 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:46:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
Message-ID: <ak0DUx5Y/5y1OINz@nand.local>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>

On Tue, Jul 07, 2026 at 09:59:42AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
>
> Add a step counter and trace2_data_intmax call to
> compute_reachable_generation_numbers() to make the cost of
> the generation number DFS observable.  This exposes a
> regression introduced in 199d452758 (commit-graph: fix
> "filling in" topological levels, 2025-04-07) where
> incremental commit-graph writes re-walk the entire commit
> ancestry instead of reading topo levels from lower graph
> layers.

Makes sense.

> Add a test that demonstrates the problem: with a two-layer
> split commit-graph, writing a new incremental layer for a
> commit whose parent is in the base layer walks all the way
> down to the root (7 steps for 5 base commits) instead of
> reading the existing topo level and stopping immediately
> (1 step).

This paragraph only describes verbatim what is already included in the
patch. I think we could easily do without it, but I do not feel so
strongly about it.

> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  commit-graph.c                |  5 +++++
>  t/t5324-split-commit-graph.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 801471a098..4e39a048c4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1653,6 +1653,7 @@ static void compute_reachable_generation_numbers(
>  {
>  	int i;
>  	struct commit_list *list = NULL;
> +	intmax_t steps = 0;

Any reason that this should be signed? Obviously in practice, I don't
think we're going to wrap around with a greater-than-INT_MAX number of
commits here, but perhaps we would at the very least prefer uintmax_t.

I guess trace2 only has a data_intmax() function, so perhaps the point
is moot. Regardless, it seems that we would want to have a convenience
wrapper to be able to print out unsigned integer values which are
otherwise un-representable as signed integers.

That is outside the scope of your patch, though, so what you have
below here is fine in my opinion.

> +		# BUG: topo levels from lower graph layers are not
> +		# propagated, so the DFS re-walks from base-3 down to
> +		# the root (7 steps) instead of reading topo levels
> +		# from the existing graph (1 step).
> +		test_trace2_data commit-graph generation-dfs-steps 7 <trace.txt

Instead of writing "# BUG ..." and then an incorrect assertion, I
would suggest that you write the assertion you expect:

    test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt

, but mark the test as "test_expect_failure".

Thanks,
Taylor
