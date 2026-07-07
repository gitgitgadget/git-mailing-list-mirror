Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757743634B
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443362; cv=none; b=UsEsRqt3zn7CEvks3qnpqV0oVCHunS6m8pzO6w+d+mY+9s41AyIWcCfrYJOgXn7s0GLtJ1Az4qec+bqB/JNt2kfPi0NdcVEycCISuuOns21u1c39A+6HCS/win3CSbA/dG8TvblNAWTrF3vTRcRJ2Dy2zcU0GjB97P98L1EbK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443362; c=relaxed/simple;
	bh=cdqmWjFK8RXIuh98Hs5JDMI9F0pyxOX2oJBvhCxZg3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8RXn6TGk9SdkptK4FjByKJEQ10ngg8msqMqdidfvNuhGHJ72MUWU2GSSX3KU+mIzGJxiJizubyPclaKW012qYWA/F4GiHk/uljVAtwNxq1az5SZLRRx00uWdH4xoO2mrljqg/GwSlt/Q1sVkdZHXNG6ZWmDrrClqQfwpvl34OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JtIuA4eB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M0fK6uyK; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JtIuA4eB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M0fK6uyK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E3FC7A0135;
	Tue,  7 Jul 2026 12:56:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 12:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783443360; x=1783529760; bh=QR46mo2RoP
	4gNOGI9pneQlKFqpialtqVnhExoHNxb9s=; b=JtIuA4eBimJuCTZoje5vhKkpPh
	sjCnBsUkv3X0Ohna5X9SMlPghoGJkm2yw1IL3KE/+aHoPZPWZMXFD8fJdncFtDam
	7KKlJojSq2h6tmE4H4xTbuFux/BOoczQigzVQvUv6yRBc2otIaLTkb9aE+YntmJK
	LStAgjBssq+g/eS807Lc/SB+pY9VgeozNHsraQBdlB/cLx3dz1qixPyTPwE/Bkgq
	zlv64M3WbdHNFUlxA74ldYG4cG9L42BeW3YgtG8zKofb4AdTJGk4+Bc3iE2+HoFh
	pGUdbxUOJNhBqVEKDHwpoV/vfSlvdaEX1UTBc0XhcTJ2PLqc70z7NOrj0+hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783443360; x=1783529760; bh=QR46mo2RoP4gNOGI9pneQlKFqpialtqVnhE
	xoHNxb9s=; b=M0fK6uyKMUV7WhQOFqhwWqbpQTNbo26VJVg2UsiauUI/B9aasWU
	dGsv1yDOsjQ2WvwTVGcCqSl15kD3QP00kJhxMZcz05IBoTn+Ku8pMI4uHtIsvf6T
	8sAf+/l1Cb4KPziO6ZvI4rAyZqanCOJuyOT+fw06+5IhHP/c6aGYDqSYOAJTPcGI
	JjK2urdu0d5bPEssRRdpqRCRDZkQbom/NVG/M+6RFblQj1w8H0uv6lt/1ZlQmk0q
	sjOlKhooHCkaEqQR22y06utS+B95eB6m1ZfXGJdrwrM6Mi5Jjod0SaoCkwA8gk7F
	WnhW5eclXrxy0Un8/+Wgjbqaky3jjKSiMFQ==
X-ME-Sender: <xms:oC9NasNHnQg7piK0YFu5eXJH5o6B5Kokuz3YsqYtA4tj8aKpo1eRuQ>
    <xme:oC9Nap-AY55Xz3iOejLbUWmX3JpICqjfFs0yHi9X-w8F3VtCPKiyysvlan987UyyZ
    BeWKuIl1QmbCAmooiFk3jCQz8BBg3-gDqYSesu6Y4HVMze-nd-H>
X-ME-Received: <xmr:oC9NaoSrariOChxIfGC33UrgSfe8Jw-J9a_4kchd4hWBs3TFmPjglZxArnboWyQwZpu9FNkFWcIdeOkT2oJV_RHGPmHH6FNyKNcil3o>
X-ME-Proxy-Cause: dmFkZTE9fvQbfFMuyDk3p1hfCFQKo3+ERvBfoaVhuKgd8JNvyb/3HGy/6T3lBZTWJV5CIe
    ROYom4+6qAfd4OQyGx2WdV5WdJYlzmUJvrWJ1ri/aYTCULnJU4bN7xPKyHSFQKUyxkEAVg
    U+5aO1CJLRIIkuw1OeVKebmz7JPpZYyDAPPy83LAjnSUx83EBHOdaoRJiTnA/7dddA8iok
    1ELdLYh/5O++60sPthfhiK8QWg2BOs2lFl4vVdaBjjh11EXG6YIcwCCeeiz0CoFzpoFEUT
    5Cksk0SHZwH68JidLBkZyDMIEpKefiryTnA/cSs/1Q246LT/Bq4U1HcdohV9Pkt8IMlKBq
    qaPqLp7YzDWPf6ZoVffMRwoT0GJkh952hUDiGe45nJyZRBlNK0x+YZpme2VubvBnWWwNGF
    65iSBXzzHgtWZCM5AOHrOrJUQw8spfd+aJglVP/3bZpBigcxc3Lof8MIzZIqtXl0pYgfBK
    O7JoMPt40bBJ8RfzEtgVrgmmpk8IlFg5qfX0T7OOG33efPaMUiperxSdXBatD33EHkE8UI
    vJJI/Z2bQJr/UFmiSjwrcCHRPj3aNj2Cxjcr+Ai6//xcHLhpGjjqzd/CHloQ6JYpVxUqII
    nD3sV3MAhh9OMtFiGv0xH90dbffybPL06Ff9sA5QpkJw1mYYVLKUEDAaE4kw
X-ME-Proxy: <xmx:oC9NajmtU8raAEteT0rdLcUq1S54-95ciTc5eKkLOflxGt_0TmiTVA>
    <xmx:oC9NagQtDx_R5kbXkPW8dkaf8TFgLMrrsyNbiGf1ltFc2p5sNDwxNw>
    <xmx:oC9NapMQLiIAhBKUOpNN03nUtspbGI-iejHpO3MSIsLzXTC2Yxjmfg>
    <xmx:oC9NahU08DmxP7D0_QPjG_CdmdncYnE8J6cqK7rHIBmOHNCRkVKXUA>
    <xmx:oC9NaqYhkHsgE4Dla43JkHvzoSXWev5tLiEqtcvODPANdsCv6HmdEuKe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 12:55:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
In-Reply-To: <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Tue, 07 Jul 2026
	09:59:42 +0000")
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
	<b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
Importance: high
Date: Tue, 07 Jul 2026 09:55:58 -0700
Message-ID: <xmqq1pde7n8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> Add a step counter and trace2_data_intmax call to
> compute_reachable_generation_numbers() to make the cost of
> the generation number DFS observable.  This exposes a
> regression introduced in 199d452758 (commit-graph: fix
> "filling in" topological levels, 2025-04-07) where

Where did "fix filling in" came from?  Are you blaming

    199d452758 (commit-graph: return the prepared commit graph from
    `prepare_commit_graph()`, 2025-09-04)

or something else that happend in April that year?

> incremental commit-graph writes re-walk the entire commit
> ancestry instead of reading topo levels from lower graph
> layers.

> Add a test that demonstrates the problem: with a two-layer
> split commit-graph, writing a new incremental layer for a
> commit whose parent is in the base layer walks all the way
> down to the root (7 steps for 5 base commits) instead of
> reading the existing topo level and stopping immediately
> (1 step).

OK.  I expect that [2/2] would update this exact test to demonstrate
that with code updated in [2/2] the extra walk will no longer happen.

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
>  
>  	for (i = 0; i < info->commits->nr; i++) {
>  		struct commit *c = info->commits->items[i];
> @@ -1671,6 +1672,7 @@ static void compute_reachable_generation_numbers(
>  			int all_parents_computed = 1;
>  			timestamp_t max_gen = 0;
>  
> +			steps++;
>  			for (parent = current->parents; parent; parent = parent->next) {
>  				repo_parse_commit(info->r, parent->item);
>  				gen = info->get_generation(parent->item, info->data);
> @@ -1694,6 +1696,9 @@ static void compute_reachable_generation_numbers(
>  			}
>  		}
>  	}
> +
> +	trace2_data_intmax("commit-graph", info->r,
> +			   "generation-dfs-steps", steps);
>  }

Pretty-much trivial addition of a trace element.

> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 49a057cc2e..f9c57760f4 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -718,6 +718,34 @@ test_expect_success 'write generation data chunk when commit-graph chain is repl
>  	)
>  '
>  
> +test_expect_success 'incremental write reads topo levels from all layers' '
> +	git init topo-from-lower &&
> +	(
> +		cd topo-from-lower &&
> +
> +		for i in $(test_seq 5)
> +		do
> +			test_commit base-$i || return 1
> +		done &&
> +		git commit-graph write --reachable &&
> +
> +		test_commit extra &&
> +		git commit-graph write --reachable --split=no-merge &&
> +
> +		git checkout base-3 &&
> +		test_commit new-branch &&
> +
> +		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> +			git commit-graph write --reachable --split=no-merge &&
> +
> +		# BUG: topo levels from lower graph layers are not
> +		# propagated, so the DFS re-walks from base-3 down to
> +		# the root (7 steps) instead of reading topo levels
> +		# from the existing graph (1 step).
> +		test_trace2_data commit-graph generation-dfs-steps 7 <trace.txt
> +	)
> +'
> +
>  test_expect_success 'temporary graph layer is discarded upon failure' '
>  	git init layer-discard &&
>  	(
