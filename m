Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799F35957
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 01:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597156; cv=none; b=CwQn+03L5y5/B4yUxKtE4H30BIKtKuu2jEGD6GBVBPBbfgQ0t5QvLPwV9mJOS2xLp/qsabV2wYNu+AEZPv5kCsu5/J1TB4uWnCWfsfxzSrxTSK9CXqNlcN2CJi2kb2V+83NWep8obQ/T0WrUZqHZOTtWQTCyDj36vibHJGVltM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597156; c=relaxed/simple;
	bh=icN8ah49494jV+52gSMryd8OOHeQStnvZo1Uswpbfg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8KGRwwaEz7XDCe6YTZMq9vPSr9k3PnuKDsqMRGuBmsbYzTqK+3oNRRuMLGah0iRvzZ0i5WpdlTMF4Wtp2G0R2fXbPaj3uFVUQzGsuiqT17438ity0xkfdnemjxkdO9CG3lFginj7l6eE76jF2foPP1elmwecnzXzeT6a0LtOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tYg+kMWI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IsGMflwS; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tYg+kMWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IsGMflwS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 55D0111400B4;
	Wed, 22 Jan 2025 20:52:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 22 Jan 2025 20:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737597152; x=1737683552; bh=pHTNqoKO1Y
	ftynicvtx58DZa487mxPeKuL1YYTv70KY=; b=tYg+kMWI6Khl7kL9oIf+9gVxvn
	CLTivRO0l2FV+2sKP5Air6h18+F1H8Y7ERUPlYBjBQgBRU42GKr0Rt2IA9ZN/9Jm
	AY7DH2Krv9Sd+iiTZ182oHFLzRsdjTA7S2eJqhWwQDDqqQJaxcKnEW+NWc02di5U
	NTN+dq9ECVMnZaNJI4nougHtjHbfn/3IcvlSYKCb39GMH96vBgJrs2xg/pj3f0be
	rAM/gwDgc4aASmgouPG6Dk/ufoYI4d1vlgoS6k4aw2L6SvrtRom5XBQvBGad0I8V
	VyMraF22V/afi1wOU9oOSX4g2TuWJEVW0owy0dpfUcX7PfDhzIfo4XPaBSnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737597152; x=1737683552; bh=pHTNqoKO1Yftynicvtx58DZa487mxPeKuL1
	YYTv70KY=; b=IsGMflwSRsYVkup/sb6WPhd+RlD7rPAOkVbfhY5j0Cvgz+7vmsZ
	1FpWgtqFF/EkJlbBPX5h8sSfBjlEkYNNSwhkjzw3WTLvOz5QAEDALPJUelwSeRAF
	hqcmuK7QOpjQDVK0kR45/q6dbLennBFOI51BCZcFQQHxfX/OoVh6gniJFdfKIwBW
	9c8rQPHkcL+p47TCzUlrPabvTvWLoVeR1q2ShfdzdeJeIWywgwHCIu/S5Ybpkb8I
	VsV8J/rWCpVQ5LjzHi7xrM2Q/88AdLEiMb14pcuIcg4VzNGQ4UudzNVQiJ3MFrhN
	iSSL/r4EuUJLH3e1LXA6lVUZ7ugQIKupOQw==
X-ME-Sender: <xms:4KCRZ-xP0Y5kNjvBt7yma5vpMIBuOEVW-TmLaH2l9wxS098coelEkg>
    <xme:4KCRZ6Qrc3q-Fm2E35o_S43Tt0NgtY7hcZ7AMymIq3OLBgL8TO_04FK65zZsr5L24
    A5L4UUYpb3gid1rgQ>
X-ME-Received: <xmr:4KCRZwVFzwYy6ebDn_vY2KqB9ka59rjI-KS0-JBrRQ8h1STkm5z1YG8AmeqSiKD_TTtJEhBX1Ut_x9KODgZNEMm1NSPUGvPRTl-t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:4KCRZ0hNwlkQiEHVjC_2J6bGKLRbkkdaB32oIJ6hmCPw_qqh83e3gQ>
    <xmx:4KCRZwBczbNlYZ8aUYQ1MG_VWYDd1nQfto65bOZw0ZpABq1PUsI_Bw>
    <xmx:4KCRZ1LI_l8Fw_dK2xvO1kzOirRwyNxbJq583WLwJiB47WdXiXslJQ>
    <xmx:4KCRZ3CIqgH-bm_40H1Pdn3IYuBehDnvdbTiS_dDFu5hAmQg1wA9tQ>
    <xmx:4KCRZz-12r5Oj-wHEXdVmYy3SvzzcIr6Bcw10MarK5lXsT2I2Sb2Cs1P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 20:52:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
In-Reply-To: <20250123003613.GA3900660@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 22 Jan 2025 19:36:13 -0500")
References: <xmqqbjvyv510.fsf@gitster.g>
	<20250123003613.GA3900660@coredump.intra.peff.net>
Date: Wed, 22 Jan 2025 17:52:30 -0800
Message-ID: <xmqq5xm6uwip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Since this hit 'next', it made it into my Coverity runs, producing the
> small fixup below.

Thanks.  A greedy me wonders if things like this can be caught by
them a bit earlier before they hit 'next', though ;-)

> -- >8 --
> Subject: [PATCH] path-walk: drop redundant parse_tree() call
>
> This call to parse_tree() was flagged by Coverity for ignoring the
> return value. But if we look a little further up the function, we can
> see that there is already a call to parse_tree_gently(), and we'll
> return early if that fails. So by this point the tree will always be
> parsed, and the call is redundant.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  path-walk.c | 1 -
>  1 file changed, 1 deletion(-)

Nice way to use extended context to show why the change makes sense.

Will queue.  Thanks.

> diff --git a/path-walk.c b/path-walk.c
> index 136ec08fb0..9715a5550e 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -116,27 +116,26 @@ static int add_tree_entries(struct path_walk_context *ctx,
>  
>  	if (!tree) {
>  		error(_("failed to walk children of tree %s: not found"),
>  		      oid_to_hex(oid));
>  		return -1;
>  	} else if (parse_tree_gently(tree, 1)) {
>  		error("bad tree object %s", oid_to_hex(oid));
>  		return -1;
>  	}
>  
>  	strbuf_addstr(&path, base_path);
>  	base_len = path.len;
>  
> -	parse_tree(tree);
>  	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
>  	while (tree_entry(&desc, &entry)) {
>  		struct type_and_oid_list *list;
>  		struct object *o;
>  		/* Not actually true, but we will ignore submodules later. */
>  		enum object_type type = S_ISDIR(entry.mode) ? OBJ_TREE : OBJ_BLOB;
>  
>  		/* Skip submodules. */
>  		if (S_ISGITLINK(entry.mode))
>  			continue;
>  
>  		/* If the caller doesn't want blobs, then don't bother. */
>  		if (!ctx->info->blobs && type == OBJ_BLOB)
