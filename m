Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449682D8DBB
	for <git@vger.kernel.org>; Sun, 24 May 2026 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779627239; cv=none; b=KfOnJc5n/OH5G8fXcqx5nxu7vHQIWK6Ywz8Uvbhapyqo3O4sklsiVH3G4owz3CenI+t1Ouxj+7ktT7GA+KJqNbnOs1jl0lIpuBuRZPqcqmbkdndNP6rS5B1qFWU4mFioy4Lfw7kZ9ZwyCpWXJmd9bSe0oubIF/gb1JLXGJM0fsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779627239; c=relaxed/simple;
	bh=J+lERM48a7FMEtX1YDHSieJNTbhdzsnjHtCHcUvFQVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ScWSPuFwtQxJDijKy3HmRv1KV2M7aYIJVTcUqU3+b2CWShDUcHsnAEjhsbAuwI8R9PVTBkyzTBdlUWVehs9NqrhaDEPFYnmS78aGu/xmqjAR/tic5s/EmONKkSOyyuWAWAmzqXcS+HvW+OwTKpUZcXA6o21eEQR8se2IoQtuIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pl/rladM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FppZ+Cmc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pl/rladM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FppZ+Cmc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E7621D00026;
	Sun, 24 May 2026 08:53:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 24 May 2026 08:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779627236;
	 x=1779713636; bh=pC/ynFwtNzS7mRatxtssyrIVsI2O0rVVgS+upVs9EXQ=; b=
	Pl/rladMyiAxB+cLWVhJGQ6tJIwnYLlz1Kv/j9I/JmcmGnf7GvYtUn6rfwLM6aaq
	IH2e/vvD6Ewps04jXT//G7njrlieHINNNhDyNj9GIlNDG5J9NPZQ0lQuwNYWMEDY
	Z7uIVtS3xsChVA6h0bUDUGzqQSciJUudjmU70ruvMIZ/ENOo+MNYqY+ybecdLZvR
	amDzG74RTY07iMqhZkMeLj8w+W7WppNkgWBCZ6PAmod5uDZfUE9csgXe3TN9b8xi
	bzJieOKLBt1U4QgfVfXIGD8Bsl9xODxTAeXlcKJY5YZzDCspYcQn46AMeA6zRBLz
	VPCZGY0LoRCrVEbO32P4Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779627236; x=
	1779713636; bh=pC/ynFwtNzS7mRatxtssyrIVsI2O0rVVgS+upVs9EXQ=; b=F
	ppZ+Cmc/4rFCpm/rvTQKnDcw/Psqz2AH7lZypAlXsP2K3IUj2SokY+sQ6jNIkVUj
	4e5yZvkwJUtYTxvE1GbqOAru/ll5SmDSAxiEnVmHm5PVHGmP0U9TA9JjkcfgfIb4
	vpBNgTsh7c6rpWMiki0REzg/Eb7NOcIB6xij0Zs2g8LTRYl7DBavSnuwBUa4EK52
	hWBjFUab6rMF4kwy9XV2cZhP9b2dOzCCQGqgzOLPD66ItA5/JqhWlDcS0//om8Lc
	jW1wvSeUxe1ky3dzk1QiiSWKUpI9MvtHxCsgCKDtEcXLwyMCMQ6BqEK/31nBSCLl
	Duo67ae7oEVa6tvBEYLlg==
X-ME-Sender: <xms:5PQSavqulR5hfIW0RHXJnkAnBvVxppJHfEhNdFTMR90JqrHbxvDGnQ>
    <xme:5PQSagrdlv50_WaoNw-h6XdfmFJqVf9_Hys_MeLulV9JXSL7Lxll31MWlUxKkWjde
    9efPeB_lMaxKjq32zRNjQIvb2a0gTNLe9xqT3Rnrv6X_7WGWFKhVQ>
X-ME-Received: <xmr:5PQSahMn9c9_03Y3vCo9R931ZkkpX5YaW2RmdmrlkYGPAtrCz0N5QnGQneQQH1WqH1G4_JcvZFPUzoPvAzK0N0PDIJO85ECMYF4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheehleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhkrgesshhpohhtihhfhidrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5PQSahzDICUWSKfcBOA18NR-O4q0mNcCNBwb-RkSB2aPmq9xFiBExQ>
    <xmx:5PQSaqtwTxHmoUwlizn4EtI4acmH2c5IZNVMLWJfSkhO32Hxd-YM0w>
    <xmx:5PQSaq7oRjRus-7Sdu2iINOC0ssLBNg7l4GXUTQAciwJdirS8Ue7mQ>
    <xmx:5PQSapR5kOOxAMyQ8tDXZ1C4S5_UFeV34B7fgAIt4YVm2omfzEAi1A>
    <xmx:5PQSaiWVpYW8ivb0T2o1ITCUH1WjjtVutZk0--Qqsw70T0d7F81jkHBW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 08:53:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] fetch: pass transport to post-fetch connectivity check
In-Reply-To: <pull.2123.git.1779625693328.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Sun, 24 May 2026 12:28:12
	+0000")
References: <pull.2123.git.1779625693328.gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 21:53:54 +0900
Message-ID: <xmqq4ijxhst9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> When fetching with a transport that sets `self_contained_and_connected`
> (as index-pack does for self-contained packs), check_connected() can
> use find_pack_entry_one() to skip connectivity verification for refs
> whose objects exist in the new pack. This avoids sending those OIDs to
> the rev-list child process.
>
> However, store_updated_refs() never passed the transport to
> check_connected(), so opt.transport was always NULL and this
> optimization was dead code for post-fetch connectivity checks.
>
> Thread the transport parameter through store_updated_refs() and set
> opt.transport so that check_connected() can take advantage of
> self-contained packs.
>
> On a large repository (2.4M commits, 374K files, 10.9K local refs),
> fetching 200 new commits:
>
>   Before: rev-list connectivity check  22s,  total fetch  36s
>   After:  rev-list connectivity check   5s,  total fetch  14s
>
> The remaining 5s is spent verifying refs not contained in the new pack.

Impressive.

The check_connected() function itself is a battle tested helper
function, with the optimization that originates in c6807a40 (clone:
open a shortcut for connectivity check, 2013-05-26), and then
polished in 26b974b3 (check_connected(): delay opening new_pack,
2026-03-05), allowing available "transport" to be taken into account
does make very good sense.

The other call to check_connected() that appear in builtin/fetch.c
does not pass opt.transport, either, but this one checks before we
even fetch any packs over any transport, so a tweak similar to this
patch would not help that code path, I guess.  In fact, many calls
to check_connected() elsewhere use opt that is often local to the
scope, that do not have transport at all.  I wonder if there are
some of them that benefit from a similar tweak?

Thanks.


>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>     fetch: pass transport to post-fetch connectivity check
>     
>     We're working on reducing git fetch times on a large monorepo (2.4M
>     commits, 374K files, 10.9K local refs). Profiling showed the post-fetch
>     connectivity check (rev-list --objects --stdin --not --all) dominating
>     wall time when there are new objects.
>     
>     While investigating, I noticed that check_connected() already has a fast
>     path for self-contained packs — it uses find_pack_entry_one() to skip
>     refs whose objects are in the new pack. builtin/clone.c passes the
>     transport to enable this, but store_updated_refs() in builtin/fetch.c
>     does not, making the optimization dead code for fetches.
>     
>     The fix is a three-line change to thread the transport through.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2123%2Fspkrka%2Ffetch-transport-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2123/spkrka/fetch-transport-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2123
>
>  builtin/fetch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a22c319467..647fd1c30c 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1213,6 +1213,7 @@ N_("it took %.2f seconds to check forced updates; you can use\n"
>     "to avoid this check\n");
>  
>  static int store_updated_refs(struct display_state *display_state,
> +			      struct transport *transport,
>  			      int connectivity_checked,
>  			      struct ref_transaction *transaction, struct ref *ref_map,
>  			      struct fetch_head *fetch_head,
> @@ -1228,6 +1229,7 @@ static int store_updated_refs(struct display_state *display_state,
>  	if (!connectivity_checked) {
>  		struct check_connected_options opt = CHECK_CONNECTED_INIT;
>  
> +		opt.transport = transport;
>  		opt.exclude_hidden_refs_section = "fetch";
>  		rm = ref_map;
>  		if (check_connected(iterate_ref_map, &rm, &opt)) {
> @@ -1432,7 +1434,7 @@ static int fetch_and_consume_refs(struct display_state *display_state,
>  	}
>  
>  	trace2_region_enter("fetch", "consume_refs", the_repository);
> -	ret = store_updated_refs(display_state, connectivity_checked,
> +	ret = store_updated_refs(display_state, transport, connectivity_checked,
>  				 transaction, ref_map, fetch_head, config,
>  				 display_array);
>  	trace2_region_leave("fetch", "consume_refs", the_repository);
>
> base-commit: 6a4418c36d6bad69a599044b3cf49dcbd049cb45
