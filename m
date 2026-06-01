Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556F3769E0
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315995; cv=none; b=RpXxZjwCz+7WJSLQI5iQpoGHb2q3IHk+mTDk3AXJGCQa7xDDtizqhOtUxW9cfbS1SUaxiVc6JaoDM1sGLFjfsebw9+Z/WtCNNRhstFAAcS+b2/A3EbXvM1c7DIzUpBnz13ACn9RFAig3RXxRWj4dZoFRiWHgYQMxjBHosS9jxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315995; c=relaxed/simple;
	bh=ayMdNpx77AlF6ERloC7MNuUbADiyqMlSHYz1CNP9NkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IK6g/HXTukT0jihI7IOju+72xO/Ma/L1OSFBvCoaH2rcKOnOBul08XnS+Qg4yKQciFw5FDQ+JmGIKbFXWtlhKUWGVOopIu1vd7amRyEbyqB4Hx5bNLbovPviUQr8M/XXR4V91DDUPIUbmLqsnsOmjDeks3t8C5gM//J6ztStRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=By0Zf3Po; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGeeCa1b; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="By0Zf3Po";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGeeCa1b"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id AE7C41D00284;
	Mon,  1 Jun 2026 08:13:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 01 Jun 2026 08:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780315992; x=1780402392; bh=XtWXuU8YFz
	zG6Z3nu/arWObjNMNNE1SEVJKKmml0De0=; b=By0Zf3PoEIyHGsFLiKW3VjSo7D
	6rFaJLwI+P2TgrIM1HaQXGwqlyGd04mOUI/bg/iGsZlI2+m4l3XiaNAWzFbOX0uR
	WgUVAV0v3uFWsUKnOr30I/2ADSHC7ihJlB454t3DAwmqHH9Vf8wNaXKziYIIe0+M
	vcoyydRqQPUBZR80MxBQxtXd+LpzuwQL4Y+sWaFy/vkY+rxq4AE5dJmRvlNAOD5s
	VOE+5ZiBe0r9HPjWgqC5Q/cTNPDr4u+uSH3swY+vyugZs80u4HnbMUvlzUy69SgI
	c2k6yxLXHc7RrQxCF0FX98yiWN3fHES0BERFhh1izbe45CpcU+BY6QOFaQDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780315992; x=1780402392; bh=XtWXuU8YFzzG6Z3nu/arWObjNMNNE1SEVJK
	Kmml0De0=; b=cGeeCa1bE5x0AhiyLcC9NcqOmFqOtpB4hUSpKcO6tV6Ewi+/ln0
	nhgodRi8inzAjLqPhjSnKqIsecSqAEqwvD3dATVbdoT6tleX7NOiV6hEuC5rFRPZ
	yF6Tg29RRiG3TfQhkkkf5XBFCJSDq/GPpJBKtZb/EIMb47ITk0AZYTcZ2p/k/yMw
	FjFu1bFwWrELjvmKQyPflvHe6N4pzneiK/nLV1DaUiB/b0n6xAE6CKf60k1R9ktv
	RiB8DhBCUyKyQutnmPpigux1A62PHnVjL/Uuch1ZPOhr4MJtt8hjIfuznt7RUMS1
	knVm0Do+dH3n+CxdW8RiXq4ICCFgF6qorjA==
X-ME-Sender: <xms:WHcdao7dDhBeFyJbaIUg-ymbCLZ0Bq_7L4cgj5__Lcaoms5n6JN2RA>
    <xme:WHcdag6qePdwzkk1EhBllcEFjA8fdBzTnTam37jM2zrY2jiZznH9slUVn7Liy7BiY
    os23uPou7YpFc7-2a-ZwCjvoP-60WzNMj-VK8NZglfyCPvte3bS1Q>
X-ME-Received: <xmr:WHcdascJ-x2d1Du7s8Ja0iY_OBCgsg58vVKTje3C_2iNgxyuyDLmtXarQWonHtawJnAevt-m4BaHL45D8z75X58VT3IJKOewXIlj>
X-ME-Proxy-Cause: dmFkZTEWuqhZpH8/UntuKwckz6UbC4Ici3sENfftLXxzMtC7HMqSo42CfWbS52gl7Risyt
    OZjKMFW3IIaLoQ5dR7ydlMeV2bRVmgw/4Sk1T6i8SJAPCezCo6h8QrpwSLFmvtk4ty4mmp
    yBZdGnBSJBJT/kMb7IbEa67hUXORAQkGvX4jEUE84JTZbb5IiyAKE9XH3aklzkW9/lyFKY
    BNn0xLztMVT9ezKJJ5csaapXOe5M+298qIRqC0vHz94N6Uv34Bibrzyre5cQXmh5JryTnn
    kCDel3MaM4mFrWKMwO/57Db7Kk3Q7U2gomnEQlVGlxscMgaU1b/6mQ9yxHfdbn1UXKgRhd
    HG7/nCF5A79RezxZuX6phhxNsdJdtTZfZV/I3txG08Q4C4oI7aHuENJjTfK+QM3BRe2Ytu
    Km+iBak76nTdaODba5rLr96gyADSSs3rh9j6thgEz7BZJ2DDldQ9MPuKfmU9tFGo+INyjz
    OkUKLzXspmcrHQfrgn5rxomxIUgfvPXN2+A4RCERt956WWXQfgy4IGOqlC3sD0oHWEqDwz
    9bOUSlEQr4qagOiNhL51iSbQ1KaKT4lTcXGyAo8uDm+IdBLlOqaL4W9Yh/E5mLqcwq024L
    RB2jJMnOt9ZSkmza0kHW7S2BwrooVjylh8EQaCxA7WsJOjrTlWN5jTAYiwqQ
X-ME-Proxy: <xmx:WHcdasABQL1ji7OfCWufe7v7KEImOEhhau9A1gPBdqszqM3gkunM0A>
    <xmx:WHcdan90FOBxui37_8wMzBs0xSu_DFbiMYKnLcZ-L8eBcAefwz0kZQ>
    <xmx:WHcdavIBCp82g2hg740P_RnWx5fH8tDjGS3ptDu5kHzFhATcGHWXiA>
    <xmx:WHcdaohTBeT6ouKHQY8_9O_0YKLYoaavgnY0Cqr6MzIIpDKD44nvDQ>
    <xmx:WHcdar-O-kgag__WU0m8-IyRIF7elycf5X6wuJDqz14t8djcZESOq-3F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:13:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/5] merge-ort: propagate callback errors from
 traverse_trees_wrapper()
In-Reply-To: <282f906d1b4767d95e2a66072c280c2294a93a9f.1776731171.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Tue, 21 Apr 2026
	00:26:07 +0000")
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<282f906d1b4767d95e2a66072c280c2294a93a9f.1776731171.git.gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 21:13:10 +0900
Message-ID: <xmqq33z65ui1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> traverse_trees_wrapper() saves entries from a first pass through
> traverse_trees() and then replays them through the real callback
> (collect_merge_info_callback).  However, the replay loop silently
> discards the callback return value.  This means any error reported by
> the callback during replay -- including a future check for malformed
> trees -- would be ignored, allowing the merge to proceed with corrupt
> state.
>
> Capture the return value, stop the loop on negative (error) returns,
> and propagate the error to the caller.  Note that the callback returns
> a positive mask value on success, so we normalize non-negative returns
> to 0 for the caller.

All makes perfect sense.

How would the externally visible behaviour change at this step?

Upon an error from the callback, we used to keep going and processed
other callback data in the renames structure.  We now leave the rest
unprocessed.

The caller of this helper would never have seen a failure, but now
they will.  Both callers, collect_merge_info_callback() and
handle_deferred_entries(), are reacting to a negative "error" return
well (perhaps because they sometimes call traverse_trees() in the
same control flow, which does return an error already), so
presumably there is no downside caused by aborting the innermost
process upon the first error return.



> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 00923ce3cd..4b8e32209d 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1008,18 +1008,20 @@ static int traverse_trees_wrapper(struct index_state *istate,
>  	info->traverse_path = renames->callback_data_traverse_path;
>  	info->fn = old_fn;
>  	for (i = old_offset; i < renames->callback_data_nr; ++i) {
> -		info->fn(n,
> -			 renames->callback_data[i].mask,
> -			 renames->callback_data[i].dirmask,
> -			 renames->callback_data[i].names,
> -			 info);
> +		ret = info->fn(n,
> +			       renames->callback_data[i].mask,
> +			       renames->callback_data[i].dirmask,
> +			       renames->callback_data[i].names,
> +			       info);
> +		if (ret < 0)
> +			break;
>  	}
>  
>  	renames->callback_data_nr = old_offset;
>  	free(renames->callback_data_traverse_path);
>  	renames->callback_data_traverse_path = old_callback_data_traverse_path;
>  	info->traverse_path = NULL;
> -	return 0;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static void setup_path_info(struct merge_options *opt,
