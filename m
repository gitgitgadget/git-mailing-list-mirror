Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3C30DEB7
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053284; cv=none; b=T/mEb1jhPNz8g6HEi+msQ2Lben7hNIT3688wF0sXV9akVP2UMdMxzziNQMYDRXZaf+UOeX9QPgjX+bWOKI1OZ8HJyl3nAQdoJ6/Atcdfs3pMdil+XtCd6uG4KC9ZhAUyCaso2kvsxgb/GMfuDpC8EsWi4N/6FcG6H/R4Irwipes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053284; c=relaxed/simple;
	bh=LkFouZE7DpcPh4I0iKZ0Q+FBPaFi2ecxeDuOcQNDg5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cFQj8/B98OV2ErvpshY4dIfmWRN1Bgy7in7p6ysYhvGQqrveq8jenTzS/zWlBkYWxI+GXYyy2KoRy2GXLPJq0F6MYA/XtuZpXS+5pbjy9HMPOTgR6fQ/rqUTM1CZRleCrqICPP/Lzo1s1sFN3GLnXOk47jzWhccAKE/kyHnrzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UuJDqRNW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PI0DAn6h; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UuJDqRNW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PI0DAn6h"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DD23EC0674;
	Wed, 25 Feb 2026 16:01:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 25 Feb 2026 16:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772053282; x=1772139682; bh=v+gN2J8Gw0
	UNOrB3IzOX6Mcgnowod21mm/EaYV7mGl0=; b=UuJDqRNW7/KkwjfgDdwWX8mLC0
	0nHLp56/bWuPgWigOd/UXYq3iEEdpvEfBWhwLARGp85fCZ+rIb+OC4C6ZytjB6oR
	aJdMx3oGyzLacHWNwHfvb4c/I+OuRGjNEvZ+OHgQtgXm0xpuo6P2ls6qShulRErl
	NIeXvDLom+7Y+vNclIQX9L0PARUNR+11fgk7XGfYayySECTqs/erAGHxzQKsxu1g
	/dX6zhKqJ/LHqiBt/Jf0/Ya8sZsYyPiCuhTHUFUYlhxVW7kl3Y7eRo2LFiV3VRaV
	c9/KlpXB29jFUPXcQ5th0rW8LJ52UUQiniExJumzooPhTIeBExuatMOM3MKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772053282; x=1772139682; bh=v+gN2J8Gw0UNOrB3IzOX6Mcgnowod21mm/E
	aYV7mGl0=; b=PI0DAn6hsqkDrNWew9VICIsLNrgdTSCPP3jBtZdLwkagQ/fN+aP
	YBe4IrM4DFP62c+kaNFPLP93qNi2/U2WSN31JMiaxLua4g5XpdoCaXhQlKnZi6wl
	n9HBjzn06bBCPWFb1yMSNoGpH9whWiKYoAXfll+qdljt0wbnc+FxyTyiqReW0NwD
	RSgunzQFuBEE6mfyOHc4vY6te4djaOXwobgEhqpcAYkuGlfdt9+5nAdQ6ZJr8F5E
	qdPncoSXMd9L1X1S+YrUbBX7IDbuo5O7VDIgaVrtO0RXG5LdMOPcB05BRvk3iCwN
	4JAltVd0bSgcR6i9W5Wrowd9KQ2myT2qeOg==
X-ME-Sender: <xms:IWOfaYE4RInnHNnWCnwP7oAyRf0vUONiTlxUHPA62-2qK3VTlVsMvA>
    <xme:IWOfaYPb6MxyVKIWUpTsdEKOn1x0OgySDt43QQkQiu4P0-BRrtGgoCCweOhUTDMDs
    JC_qM1AJN8gxQO_lwks4_gtuWaEeFIxQ9rsilgCb9f8j_Z8MzfqBw>
X-ME-Received: <xmr:IWOfaae7Mw4Y9w8Gx9YAXepvrabe8JopJaKjO8atosWlWdhsA_0pH8laq6RjgFYjPChEJvaAwvA9OAK0C-AM3jWIZVt2b8ItDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvg
    hkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IWOfaVsaNNzh5M7IBE1Bk_KmTzizAmoZX9GVtgcWVrVDX27iovqShw>
    <xmx:IWOfabm31vzfNHfaJOxRGAs1z7vdv6poweBpVeDDOZuLgOTOpLVKxw>
    <xmx:IWOfaXzJBGFi5Z8RIMR-mFm7eVi0HZDiHK-URmXya1ftzr06fNuCFQ>
    <xmx:IWOfadN5mDio9gYODC9vGni9a8O6C9xHtRhTHqYHjjJZeAECRGIa8g>
    <xmx:ImOfafJzaWA7hhNf7FZc0WuveMb3dvfpBLkkwd0jsjI-FZ8O0w8O_6by>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:01:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v6 01/10] fsmonitor: fix khash memory leak in
 do_handle_client
In-Reply-To: <4d4dec8fa161926e6f6ac822aff0db35353705eb.1772050636.git.gitgitgadget@gmail.com>
	(Paul Tarjan via GitGitGadget's message of "Wed, 25 Feb 2026 20:17:07
	+0000")
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<4d4dec8fa161926e6f6ac822aff0db35353705eb.1772050636.git.gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 13:01:20 -0800
Message-ID: <xmqq4in4a673.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> The `shown` kh_str_t was freed with kh_release_str() at a point in
> the code only reachable in the non-trivial response path.  When the
> client receives a trivial response, the code jumps to the `cleanup`
> label, skipping the kh_release_str() call entirely and leaking the
> hash table.
>
> Fix this by initializing `shown` to NULL and moving the cleanup to the
> `cleanup` label using kh_destroy_str(), which is safe to call on NULL.
> This ensures the hash table is freed regardless of which code path is
> taken.

Makes perfect sense, the changes to the code matches the
description, and the difference between kh_release_* and
kh_destroy_* in khash.h is exactly as described in the log message.

Perfect.  I wish all the patches posted here are as easy to review
as this one ;-)

> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>  builtin/fsmonitor--daemon.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 242c594646..bc4571938c 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  	const struct fsmonitor_batch *batch;
>  	struct fsmonitor_batch *remainder = NULL;
>  	intmax_t count = 0, duplicates = 0;
> -	kh_str_t *shown;
> +	kh_str_t *shown = NULL;
>  	int hash_ret;
>  	int do_trivial = 0;
>  	int do_flush = 0;
> @@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  		total_response_len += payload.len;
>  	}
>  
> -	kh_release_str(shown);
> -
>  	pthread_mutex_lock(&state->main_lock);
>  
>  	if (token_data->client_ref_count > 0)
> @@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
>  
>  cleanup:
> +	kh_destroy_str(shown);
>  	strbuf_release(&response_token);
>  	strbuf_release(&requested_token_id);
>  	strbuf_release(&payload);
