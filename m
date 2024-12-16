Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A807201011
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336103; cv=none; b=bRcZJmjI45aQ7vy0xOang9qwxAa+dcT3wPt48aFd+3BgFAVuS5Y6eJUqXyDfXAPBFsc7hzXXM21KJme84OlVJZ85XNwg8rutrh63gYm9gZ29TLo31tjSznFDXluMdNUdefrvHa+qO4519YJBaR8hr930TdtQBbdU2PUzA3RWu8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336103; c=relaxed/simple;
	bh=3X6JgEhlh558ze8wa4gd94SPo382GnznE6ypGGI5aVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3layV+U4ftHVJFnLh4YYDwbduEK5/P5LuQYTh9Ptc9OQS5bUSNg7paCr2QaphGOdiTaewvlZ5LpaRvMDMNi7hrR7R8pZ/CfAuPzj0ZaYDU55mH0v7sfMIENdRVxpYHNwyi7tAEk6LbtInGLsn4PgEjGH9ob+aYvO3K86y6Jrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BKQyOxW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fXWARkYT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BKQyOxW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fXWARkYT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B64A25400C0;
	Mon, 16 Dec 2024 03:01:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 16 Dec 2024 03:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734336100; x=1734422500; bh=CRqU2NDWiu
	N+T2uTN/fsGSTuaCE49DpltFWR32sBaj8=; b=BKQyOxW3fLfdL+57ganauNrOrT
	qvxpfh1mtsETsyBQRrpHdRG0HiBxCPQT6qYrMDohKK+75tclLLROgmZ1G8byV9d5
	nTTjhPkHTyE4Tye2qmd8Ppm9DpcrarHDCJ/u89ZcCagg2C4UlSx/R46kZhFGovo7
	9mrgarq5u1ySd763WEvYv7GK6QSMZcuVvCosLdCM4MkeJCdRLZ2BALMJ/6jtTVht
	aovUMvbwJ+IbAjnXkw+svev1ACPJmgYg2xpaQ7w1aQhS/8ZWtfCPHJxI51RM0gRn
	T/QpEz1OUfECdsMRh4/0f3fEWVRtIORSl++4dxmXNd8FyEJ7AIq+qXzRy8Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734336100; x=1734422500; bh=CRqU2NDWiuN+T2uTN/fsGSTuaCE49DpltFW
	R32sBaj8=; b=fXWARkYTVOVIAKr62iDmCsz4U2JAxHkmH7wHj0ULpk7C49xvl8n
	4DP5awOtGBgqofu6XUFaflQqj7ZjWRatHk+ejiieQuS36vAtlvv1pURGXGdSarI3
	Pwoq16goeUbsGUyL9lHOeaqx1fm69GGRDiuHwoiOfB8E7JMKvrnNXgFAI9q9+isA
	TT/pmyKorNqdUyv7uTtPxVgGWzuu7MDmDPuDWMW3rTI3Rckc6vmD9vs+r+Mhj2DW
	agRK51QtP5hMWMi3tMLJ5Wk6UmlBErrVTjcR95yThpotRRbKFrHXhKvV/chLHXqV
	YeZQ/K3ElUTag7fkmLdeFAr8wlT1wJigQQg==
X-ME-Sender: <xms:Y95fZ0S-Ye3GslnEtN7iOVaNPUjij0zt1PtJbo4aR6MrXEurQgNXVg>
    <xme:Y95fZxw3NYqg6PafxZlUjPUYcZnBe_RI8wuYD-qP3GbSZ6Bi_2fZ3oI2NqQb6giMB
    d3sDWf652Jn5eDKxA>
X-ME-Received: <xmr:Y95fZx33W7VqFtWCBQUL6p9BzWZY1TfXcXhlOTp4zucJ81Q8xBeNjUsON3tTMYtj1UZzctE-57BBtaLTVA1Hek7j0NjAHFKwOnmEziTUy4OdAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhn
    rghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepug
    gvrhhrihgtkhhsthholhgvvgesghhithhhuhgsrdgtohhm
X-ME-Proxy: <xmx:Y95fZ4CxyxEGj1YFVpxJbvijZ3Tq3CWoE8gMUU-5z7Ti20hYMvW9Sw>
    <xmx:Y95fZ9hXd3NyU9kJnHM_-YXdObL0vjrSnBkEI3OxTYD6-2DRnlD0AQ>
    <xmx:Y95fZ0oTwy4O-Cm-CCfHRQdTl3oZkfenb8edCJknuaELP9EAA60paw>
    <xmx:Y95fZwhEOZN19HAichLs3lKrmpW7AKNKb4oam3fe5sNQ3PjzQ5O6wA>
    <xmx:ZN5fZ95Ptd94dY-CX0aRTiREufRBG9Vd11owOKnTEGAPj_bnGTkaaDrt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 03:01:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81ca2dc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 07:59:54 +0000 (UTC)
Date: Mon, 16 Dec 2024 09:01:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik.188@gmail.com, Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/5] backfill: basic functionality and tests
Message-ID: <Z1_eUSGN3B13uGmM@pks.im>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <5728dd2702195b7ba3a208859f114e40ba2b6bbd.1733515638.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5728dd2702195b7ba3a208859f114e40ba2b6bbd.1733515638.git.gitgitgadget@gmail.com>

On Fri, Dec 06, 2024 at 08:07:15PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
> index 640144187d3..0e10f066fef 100644
> --- a/Documentation/git-backfill.txt
> +++ b/Documentation/git-backfill.txt
> @@ -14,6 +14,30 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  
> +Blobless partial clones are created using `git clone --filter=blob:none`
> +and then configure the local repository such that the Git client avoids
> +downloading blob objects unless they are required for a local operation.
> +This initially means that the clone and later fetches download reachable
> +commits and trees but no blobs. Later operations that change the `HEAD`
> +pointer, such as `git checkout` or `git merge`, may need to download
> +missing blobs in order to complete their operation.

Okay.

> +In the worst cases, commands that compute blob diffs, such as `git blame`,
> +become very slow as they download the missing blobs in single-blob
> +requests to satisfy the missing object as the Git command needs it. This
> +leads to multiple download requests and no ability for the Git server to
> +provide delta compression across those objects.
> +
> +The `git backfill` command provides a way for the user to request that
> +Git downloads the missing blobs (with optional filters) such that the
> +missing blobs representing historical versions of files can be downloaded
> +in batches. The `backfill` command attempts to optimize the request by
> +grouping blobs that appear at the same path, hopefully leading to good
> +delta compression in the packfile sent by the server.

Hm. So we're asking the user to fix a usability issue of git-blame(1),
don't we? Ideally, git-blame(1) itself should know to transparently
batch the blobs it requires to compute its output, shouldn't it? That
usecase alone doesn't yet convince me that git-backfill(1) is a good
idea as I'd think we should rather fix the underlying issue.

So are there other usecases for git-backfill(1)? I can imagine that it
might be helpful in the context of scripts that know they'll operate on
a bunch of blobs.

> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index 38e6aaeaa03..e5f2000d5e0 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -1,16 +1,116 @@
>  #include "builtin.h"
> +#include "git-compat-util.h"
>  #include "config.h"
>  #include "parse-options.h"
>  #include "repository.h"
> +#include "commit.h"
> +#include "hex.h"
> +#include "tree.h"
> +#include "tree-walk.h"
>  #include "object.h"
> +#include "object-store-ll.h"
> +#include "oid-array.h"
> +#include "oidset.h"
> +#include "promisor-remote.h"
> +#include "strmap.h"
> +#include "string-list.h"
> +#include "revision.h"
> +#include "trace2.h"
> +#include "progress.h"
> +#include "packfile.h"
> +#include "path-walk.h"
>  
>  static const char * const builtin_backfill_usage[] = {
>  	N_("git backfill [<options>]"),
>  	NULL
>  };
>  
> +struct backfill_context {
> +	struct repository *repo;
> +	struct oid_array current_batch;
> +	size_t batch_size;
> +};
> +
> +static void clear_backfill_context(struct backfill_context *ctx)
> +{
> +	oid_array_clear(&ctx->current_batch);
> +}

Nit: our style guide says that this should rather be
`backfill_context_clear()`.

> +static void download_batch(struct backfill_context *ctx)
> +{
> +	promisor_remote_get_direct(ctx->repo,
> +				   ctx->current_batch.oid,
> +				   ctx->current_batch.nr);
> +	oid_array_clear(&ctx->current_batch);
> +
> +	/*
> +	 * We likely have a new packfile. Add it to the packed list to
> +	 * avoid possible duplicate downloads of the same objects.
> +	 */
> +	reprepare_packed_git(ctx->repo);
> +}
> +
> +static int fill_missing_blobs(const char *path UNUSED,
> +			      struct oid_array *list,
> +			      enum object_type type,
> +			      void *data)
> +{
> +	struct backfill_context *ctx = data;
> +
> +	if (type != OBJ_BLOB)
> +		return 0;
> +
> +	for (size_t i = 0; i < list->nr; i++) {
> +		off_t size = 0;
> +		struct object_info info = OBJECT_INFO_INIT;
> +		info.disk_sizep = &size;
> +		if (oid_object_info_extended(ctx->repo,
> +					     &list->oid[i],
> +					     &info,
> +					     OBJECT_INFO_FOR_PREFETCH) ||
> +		    !size)
> +			oid_array_append(&ctx->current_batch, &list->oid[i]);
> +	}
> +
> +	if (ctx->current_batch.nr >= ctx->batch_size)
> +		download_batch(ctx);

Okay, so the batch size is just "best effort". If we walk a tree that
makes us exceed the batch size then we wouldn't issue a fetch during the
tree walk. Is there any specific reason for this behaviour?

In any case, as long as this is properly documented I think this should
be fine in general.

> +	return 0;
> +}
> +
> +static int do_backfill(struct backfill_context *ctx)
> +{
> +	struct rev_info revs;
> +	struct path_walk_info info = PATH_WALK_INFO_INIT;
> +	int ret;
> +
> +	repo_init_revisions(ctx->repo, &revs, "");
> +	handle_revision_arg("HEAD", &revs, 0, 0);
> +
> +	info.blobs = 1;
> +	info.tags = info.commits = info.trees = 0;
> +
> +	info.revs = &revs;
> +	info.path_fn = fill_missing_blobs;
> +	info.path_fn_data = ctx;
> +
> +	ret = walk_objects_by_path(&info);
> +
> +	/* Download the objects that did not fill a batch. */
> +	if (!ret)
> +		download_batch(ctx);
> +
> +	clear_backfill_context(ctx);

Are we leaking `revs` and `info`?

> +	return ret;
> +}
> +
>  int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo)
>  {
> +	struct backfill_context ctx = {
> +		.repo = repo,
> +		.current_batch = OID_ARRAY_INIT,
> +		.batch_size = 50000,
> +	};
>  	struct option options[] = {
>  		OPT_END(),
>  	};
> @@ -23,7 +123,5 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  
>  	repo_config(repo, git_default_config, NULL);
>  
> -	die(_("not implemented"));
> -
> -	return 0;
> +	return do_backfill(&ctx);
>  }

The current iteration only backfills blobs as far as I can see. Do we
maybe want to keep the door open for future changes in git-backfill(1)
by implementing this via a "blob" subcommand?

Patrick
