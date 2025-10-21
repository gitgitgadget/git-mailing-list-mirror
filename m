Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53827F736
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079092; cv=none; b=quyLxsEDhOeo4CN9feDTOgRqQLdWf5AhNFFJfuxYb7hgJAQ9i2pBkNNlCwNiQeuHBH1d9b5NNSQNIK/zTnitFVpuBj41O1RsfAfsk0MS4iKvh0SykoamOMTqyg+KR2x7+Hi9IXQ0dgDby8P3HLdSsOQ2w3khuDrGffJCYOvvp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079092; c=relaxed/simple;
	bh=KUl7buSntoUHFLeTYSXI/EDhOH9w/lXCEw1AIvPEjYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t+foDbdpQgXFySlGIjeVCx0tpnZ+VEtkKdAWAGvHMkbRkiQAQ2hbmG0TsUMFH+Wo6xez8Ru5LHAZZhH/AuiTcAA39FtxGjHkD4ss240bNhCmvIY3KDtH8BcD3zT3NJLBggKgQn6NGd//gYpDteAEoHxhRl0rG8052yIFtFUqrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DRwA47EC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CjIdHKIL; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DRwA47EC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CjIdHKIL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DDF3F1D000E5;
	Tue, 21 Oct 2025 16:38:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 16:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761079087; x=1761165487; bh=w/NkuoNQDK
	rX7gs3bFayvLb6w0G+2X/v+CEK+u9dClg=; b=DRwA47ECCRjLakhgglkDML6uXe
	+DPSZLmx3QghnV2W3TuvQlTQw56pHX74cmbLtd4KJYUJcCQhVgBu3HnFEa1jECGd
	pN+eZ/YKt+beKwJGNhR8GTMubRQFNy7oFONVlpyQnkka25DCrhLl3Zp0rJiijgxe
	E0u6QfRRwOtOSx9Ho/AciTYRftmhI3kzLkpBpsm8GAPzC2Uer276f1mNqxWoflDd
	4a5cg3n9874CQzGyTuLhg6gktOngwBfgOQQXcjLIdz5K9Ab/UjZdUnMShRuO+mB8
	BLfSMHMbmZZvJ/xgM0CHtWq9tk2zPXqPLuqLWMskxWc7NmkkoyzOUO8sTxAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761079087; x=1761165487; bh=w/NkuoNQDKrX7gs3bFayvLb6w0G+2X/v+CE
	K+u9dClg=; b=CjIdHKILrD2ZQVEYfQX0LX/OtSbZh3SWIonRJrKAdEdXBLMapHS
	1cl6zd3dI+DjZ6Elv3gXISR7VJzZsS24Ec3C7E07I4H3o8/wSiiHS5gO5a92q5O2
	2NIpDCN1xlld9DH43CCaFJ34cuZSOnZjVr9DnUY/QzpfKO69cQJtr5pzwFCt6mdg
	FC1l4ck8ko1iTcpFIDVqIn1SK/z0K+1uR7rzkdck7kihbnVn+FArMVa+3EVGIAn+
	TT/AxchayVI3oQXSJBZoKQ2n9ydsYVOOo9Nj/7OjKvM6pcagZYQuA7o32mQPjNVc
	0+BoxvL10n8SVjF13v5VXVvlbHKe9M4tqbQ==
X-ME-Sender: <xms:L-_3aEmuNK8ZzYJ4YN6FQOryWtgZklMdzX0Eg9SuPjZHT_-2kBSh1w>
    <xme:L-_3aAayG1-omZSI0x2wBEaf8s0e-8eZKYohnwgyL_RSMONcukqUER3KGzohLFrRu
    phKE8LAG4MUQgrsqdjz00WuTxeBgu0goZ8IYL1ApAVO6BrA3yn0ww>
X-ME-Received: <xmr:L-_3aHFp6iU-Y032J_7Bx-b3cM0oytMbY2avkbJAt18QVukfYYo4tEg8sh077x5JQief-nJGpnqrpIWw7F94rGX-n-fZ1dSjB8gU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:L-_3aHZsKyKTvD3jf3YP2LXstMtkO68O1Kll9UbJ1jak_tsxUGykoA>
    <xmx:L-_3aDwK1TyTtxupZiM5Cj-akIvVzFojEeo_Io114KsVFasZ2k-Blw>
    <xmx:L-_3aBS7OZ41rtbESm2Zlbp5cC1Z89NxXkbn9HzW6DqQDZm9ku_PtA>
    <xmx:L-_3aIII2Z5HR3dFHCq6JlzyBjnQgzt-IUDTOarzMFLQCrNx2SwUCw>
    <xmx:L-_3aN18IhcSsMe9aMt0O0qYN7Ay9DS5bOsFtJRT5WimWZAALI0NvlOb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 16:38:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 01/12] wt-status: provide function to expose status
 for trees
In-Reply-To: <20251021-b4-pks-history-builtin-v5-1-78d23f578fe6@pks.im>
	(Patrick Steinhardt's message of "Tue, 21 Oct 2025 16:15:49 +0200")
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
	<20251021-b4-pks-history-builtin-v5-1-78d23f578fe6@pks.im>
Date: Tue, 21 Oct 2025 13:38:05 -0700
Message-ID: <xmqq8qh4uh1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/wt-status.c b/wt-status.c
> index 8ffe6d3988f..b66edbfca6c 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -612,6 +612,30 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
>  	}
>  }
>  
> +void wt_status_collect_changes_trees(struct wt_status *s,
> +				     const struct object_id *old_treeish,
> +				     const struct object_id *new_treeish)
> +{
> +	struct diff_options opts = { 0 };
> +
> +	repo_diff_setup(s->repo, &opts);
> +	opts.output_format = DIFF_FORMAT_CALLBACK;
> +	opts.format_callback = wt_status_collect_updated_cb;
> +	opts.format_callback_data = s;
> +	opts.detect_rename = s->detect_rename >= 0 ? s->detect_rename : opts.detect_rename;
> +	opts.rename_limit = s->rename_limit >= 0 ? s->rename_limit : opts.rename_limit;
> +	opts.rename_score = s->rename_score >= 0 ? s->rename_score : opts.rename_score;
> +	opts.flags.recursive = 1;
> +	diff_setup_done(&opts);

This is obviously modelled after collect_changes_index(), whose
callback this function reuses, except that the set up to prepare for
running a diff is different from their way to compare between HEAD
(or void, if root) with the index.  We also do not have to worry
about sparse checkout.  We do not have to worry about
ignore-submodule argument, either.

> +	diff_tree_oid(old_treeish, new_treeish, "", &opts);
> +	diffcore_std(&opts);
> +	diff_flush(&opts);
> +	wt_status_get_state(s->repo, &s->state, 0);
> +
> +	diff_free(&opts);
> +}
> +
>  static void wt_status_collect_changes_worktree(struct wt_status *s)
>  {
>  	struct rev_info rev;
> diff --git a/wt-status.h b/wt-status.h
> index e40a27214a7..924d7a5fa99 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -153,6 +153,9 @@ void wt_status_add_cut_line(struct wt_status *s);
> ...

Let's add a comment to help callers of this function that the
changes going from "old" to "new" are recorded as if they are
"staged" changes and recorded on the "index" side.  It can only be
inferred from the use of collect_updated_cb, which was written to be
used by wt_status_collect_changes_index(), and probably it is a bit
brutal to expect for casual readers to realize on their own.

> +void wt_status_collect_changes_trees(struct wt_status *s,
> +				     const struct object_id *old_treeish,
> +				     const struct object_id *new_treeish);
