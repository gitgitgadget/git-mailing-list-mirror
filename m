Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ECE33B96A
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589726; cv=none; b=iK+wCc/7cEhi0BRkFbvD1jY9J0z/MiPstnchdv3qxAJZCyVF04RSmxcRcRboeEw6njedcRqH/yq1kXof6lo9Hiq7SYsPpPKKBQX/c+7w45cgUCzW1bZwDumgatIRzcsTwSU/l1XHmOZwz6Vv9mWbcv/D57yQrbdDFjneb+T9HYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589726; c=relaxed/simple;
	bh=3IZKKn9MDRW7+ti0nDwk5qhN3MSHiYEoi+rel5+3pTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L+F0K9I/hFGy+ddL0yDr3DZ8PrlmdRx58RtUbaBJ72T713SUhzUV+QcMLbQ5QCAu/9JiB9ovs/4UMt36iEuJToxNgXr7y23N9E/sYvzHMql3GkiLp51mi2zvJrjtnQTFQuMOYwBhsEm6QzPdyUualOtWdMEt+wnU/Jzw6YF587g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jnel0r7o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ecmQbYue; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jnel0r7o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ecmQbYue"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A8C4140006F;
	Fri, 16 Jan 2026 13:55:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 16 Jan 2026 13:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768589724; x=1768676124; bh=IrYx6Ax+3u
	cluGW0JMOXiPlBbWVanhlNVi/q13d2hMo=; b=Jnel0r7oQtW34WnxBlYpEbMKQ1
	bTalL9KXauuxNb5G6TDyCXXmfZa9GGSs+F9mzR2yuWaWulPJxfgk7NV1mfC91+T4
	MbTBwb230RoJTMplvfakSMBD8/HooFxIKnVlYEp7vkSDWHH5iTw1ElE8N1v/fNpt
	rGOedWHi6hmSzuTHHZhuKfQAN3rhfaSAB4gdIu24y0Qt3w11ShjCkwH+4Aqg+r83
	TYDxsPg3cUMl5Z78GfXGrGLprkxuKkocMbx5Z6YUxu50RdvBGeLmt2L5xqQ2QS6o
	+0ujp2eFKaLuKm/IQnTHg9wKTOE7SwJvEix6J6qKDaw/6Ikez9G7odnKAE5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768589724; x=1768676124; bh=IrYx6Ax+3ucluGW0JMOXiPlBbWVanhlNVi/
	q13d2hMo=; b=ecmQbYuedGLYLBX/ufhEWhY6nCwOcd/QV3m0uicX3jsLHoYBx8c
	g1Skcb3pagwWyQOOLnyXIV7FwGxMrnkk+mBFMGHbHlPhajaD5pQGHePEuM4Nqd1M
	NWgM60lzPzaxeU6syQqylnr5PmHpeB3BSG7dQLprz5vh7pWlarsYCITxoPJCqFbH
	4ygglHRNrzNGbi6RuFgxjGRGBjTrjVeKxnolsD9i2h+TixQP8OZCj7ycuPqFiuIg
	Xf3lJZGjcHmzIyLdxNBvYndJPAsPsQZ36nCBx3iqY5VtWkU48sugY17IVV3DJyKq
	C0/p32IsvP48YdQbGcz/q2WQgnjoWNSYKpQ==
X-ME-Sender: <xms:nIlqae7sABDCuDNQ3ut5nNVXCD1Fqcs2IijZEaKbea8oWxwbKrga3g>
    <xme:nIlqaeyb14-K3SlBW9ECGc-bUGK5KIlE294bnRu64ZJLzO4iaNa03n5HZp6KyKNaY
    sPhuZ-DvYrWRMHIZ3o_2z8ujtV0vAB0rtP8ifFZqzHAhuok5Jv71g>
X-ME-Received: <xmr:nIlqaVz-hf1mX8NmO4QYbnPrH7h964ghJDtuek-FwdIRM9RIp2VTcF_dMNTTZqNbjGj6dBSaIL6WQhtWx_yj3ccnV01hFVf4f8cjlUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepheekueefheegiefhveevteeugeduueeftdekveettedthfejjeffudekjeei
    gfevnecuffhomhgrihhnpehflhgrghhsrdhnohenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nIlqaWwfBR_knuZ1NAmv0AopDzzRlB9gf0-2fneWXp1Lv0rKLzPz2A>
    <xmx:nIlqafYlD6S51SsxMLkHkDs1kpBelwZiOmgH3XSufGdXPF6F8ZGNQg>
    <xmx:nIlqaXWHUs1DqtqSMlm47yxyfurpoG1XyfvwHRxTiOjtwUgSxuVILA>
    <xmx:nIlqadgS7D0ojiQOS06coAjLL1cnemiGBF2Y2Sv82zC9S1S49YxpoQ>
    <xmx:nIlqaYMer5VbB2rlfdMN3vOeqM_lk8FSSXTyP4R4MLUVKYB0wHDY-1kZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 13:55:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v2 5/5] last-modified: change default max-depth to 0
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-5-79e44f2806fe@iotcl.com>
	(Toon Claes's message of "Fri, 16 Jan 2026 14:22:53 +0100")
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
	<20260116-toon-last-modified-zzzz-v2-5-79e44f2806fe@iotcl.com>
Date: Fri, 16 Jan 2026 10:55:22 -0800
Message-ID: <xmqq1pjp8k11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
> index a3992db3f2..57136baf3b 100644
> --- a/Documentation/git-last-modified.adoc
> +++ b/Documentation/git-last-modified.adoc
> @@ -27,6 +27,7 @@ OPTIONS
>  `--recursive`::
>  	Instead of showing tree entries, step into subtrees and show all entries
>  	inside them recursively.
> +	This is identical as setting `--max-depth=-1`.

When I heard that the default value of max-depth will be 0, the
first thing I wondered was "how would I spell unlimited in the new
world order?", and the documentation for "--max-depth", not
"--recursive", would have been the place I expected to fish for
necessary information.

Over there, there is "A negative value means no limit", so saying
"identical as setting --max-depth to a negative value" here would
match the description over there better, or the user will be left
wonderign if "-1" is merely an example that is negative, or if it is
more special than other negative values and if so in what way.

> @@ -36,7 +37,7 @@ OPTIONS
>  `--max-depth=<depth>`::
>  	For each pathspec given on the command line, descend at most `<depth>`
>  	levels of directories. A negative value means no limit.
> -	Setting a positive value implies `--recursive`.
> +	The default depth is 0.
>  	Cannot be combined with wildcards in the pathspec.

> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 842700bc6a..a10e711beb 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -481,14 +481,10 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>  	lm->rev.no_commit_id = 1;
>  	lm->rev.diff = 1;
>  	lm->rev.diffopt.flags.no_recursive_diff_tree_combined = 1;
> -	lm->rev.diffopt.flags.recursive = lm->recursive;
> +	lm->rev.diffopt.flags.recursive = 1;

Hmph, so this will always be recursive?

>  	lm->rev.diffopt.flags.tree_in_recursive = lm->show_trees;
> +	lm->rev.diffopt.max_depth = lm->max_depth;
> +	lm->rev.diffopt.max_depth_valid = !lm->recursive && lm->max_depth >= 0;

Not saying --recursive would keep lm->recursive==0 and non-negative
value of --max-depth will flip max_depth_valid on.  Saying
"--recursive" or giving a negative "--max-value" would make
max_depth_valid false, and it allows traversal all the way down to
leaves.

It may be correct, but feels quite convoluted.  I wonder if we can
get rid of lm->recursive altogether now as a clean-up, and have
"--recursive" truly do what the documentation claimed is equivalent
earlier, i.e. OPT_SET_INT(0, "recursive", &lm.max_depth, -1).  Would
that simplify the logic a bit and make it easier to reason about the
logic around here, I wonder?

