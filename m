Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C661531CC
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284320; cv=none; b=gOjX+rW11orIPIapVK4l1UCXx+/SQnmTTarB0ey++jpuLW88Cy/3tO/5tQCdSRStqdV5BXN0T6s7joJLjuU9G2MIOqcMGbvvMz+XLQHqCSxd4K/vghRYT4cOxGn5JeNPmm/L061CXsB5psv+XQezG9djtRpVJG0zqIVgc/uOFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284320; c=relaxed/simple;
	bh=syX8XhzqhA4Rtz0Y30Oi7qbvI9wX9EFz7yEfgWNK9Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rytg1S4q3fog78h7xXReguDj6iTJ1pn733mTP80hX2hVoOiD7kBHG/iuwXPDZvMSGf53Qu8DOrqXO25uNjnOE9fnjkQ1uVhX2mbBJOKVnwa3tgsMTKt1srBtJe8/J2wnAfkx2uFI/2rsvs9KZvLKaCQu23C/v6xcnkxA2P4eEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WVSPov29; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YD8XIdUy; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WVSPov29";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YD8XIdUy"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id BDB3811400E4;
	Mon,  7 Oct 2024 02:58:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 07 Oct 2024 02:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728284316; x=1728370716; bh=g27g8qyDGs
	ekMX3YkmHCdzxTXWmt97plhEiI6CnVhL4=; b=WVSPov29FBgZsh5k77Ug7JOrK3
	pv2HOBflNQOqwY8TTA6vG3MlzBaBkZA3zM6Vh8F3TC1PQcFLYrnO8DItbvyGOZ/S
	6gKhbHgBArRAiEvTQn+wiibeSJHrs0n5poU503LEPEmPEW5nlOft9m04WPmlkRYd
	1xYnEkSRJXFcSNrQy3ygT472Ed8qKY3jRiwVhqevxycRC5Pkkzo8dphNroS5W6TJ
	Qm9xJ5KoPJK+8IByZnQqGOdZArAZapNYPvRMQnUjnhWvVaQnL2Vn9FPPSqsKQ6NE
	vvQMNzbDGiu1dQCnnNQJ2wPzCVja5EmazqyB8Zj8vAHvS9VISVyjR3BbpOiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728284316; x=1728370716; bh=g27g8qyDGsekMX3YkmHCdzxTXWmt
	97plhEiI6CnVhL4=; b=YD8XIdUy9EMbw52jhVA/4J6h6l6pGhyeoJKbOrLEwR/J
	7gWckg/IsuZ1mFMIvEAh/jUVcjM4mBCNqh29ntJeHYCJnQnmxq7iPH3TLYdb8NBF
	s2hmb1E029LlCLB/Kmgno6IB8qVYnJ5cOUv2BL5AtoQEeTdDIttblTI0eAApUCbk
	eZsDy+CgXGuH2/BKqAa9fJ2p4csVjpp5b7az02F9pXQa9iJJoNSOt3+EaHBG3kkM
	ZtNEuqG00DwIf4J3Wol+/oaJqKqtz/lOZswcGVCs+BDdzXKG3u7t/YdUQZPqmoIz
	Bk25zWuxW1DPvr4qWi0B8CkONNAsYD85gIyPqpdO4Q==
X-ME-Sender: <xms:nIYDZ8cUoxc5KsQU7QAJTg3HWjGvRDkEDpOTDoroJaIhdg0hgdglvw>
    <xme:nIYDZ-O-hJaDkF-VA5A0kLuu05hawrT94W6x13l9pLEyvuAm6ikrbhtDE9PKu193p
    HXALaaRCPHuvJO-3A>
X-ME-Received: <xmr:nIYDZ9iQqSTdJhgfMIkD75AOdUiLz35_eHxVzQre1Lc0yekDNukaNEICsAUD_U_m0HYLzBbiVYCawFWNzTjmPKuWcE0KCUZQ0R3-ixBYv_N8KepeMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtieduleeu
    lefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nIYDZx8oWBDxnKNv6_6mYvh3VewXOg_jcsknb1PxOYQrbjunednoiQ>
    <xmx:nIYDZ4uzbEQ0aBaOJXfPP1NXfNBYEZdig4zKtPeVe1oWzNizzn6tsQ>
    <xmx:nIYDZ4HwoVqVD1hflgoKlYOykIUQPG4mwt_d6zHPoQeJUYwiJTW-Jw>
    <xmx:nIYDZ3PekBwQ2wtNrBRptXoq82UEQqHvyQmi4lxr8rYYrhmjHlbMXw>
    <xmx:nIYDZ6KoZpG505qFrTVVWT7WiU9aqRvyF0QQNJF09c9c6dMAPTfV_x3b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 02:58:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 69165fc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 06:57:34 +0000 (UTC)
Date: Mon, 7 Oct 2024 08:58:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/9] builtin/refs: support multiple worktrees check
 for refs.
Message-ID: <ZwOBwxiSZpxJlsfT@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-jkFE9NN30uDl@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-jkFE9NN30uDl@ArchLinux>

On Sun, Sep 29, 2024 at 03:15:26PM +0800, shejialuo wrote:
> We have already set up the infrastructure to check the consistency for
> refs, but we do not support multiple worktrees. As we decide to add more
> checks for ref content, we need to set up support for multiple
> worktrees. Use "get_worktrees" and "get_worktree_ref_store" to check
> refs under the worktrees.

Makes sense.

> Because we should only check once for "packed-refs", let's call the fsck
> function for packed-backend when in the main worktree. In order to know
> which directory we check, we should default print this information
> instead of specifying "--verbose".

This change should likely be evicted into its own commit with a bit more
explanation.

> It's not suitable to print these information to the stderr. So, change
> to stdout.

This one, too. Why exactly is in not suitable to print to stderr?

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  builtin/refs.c           | 11 ++++++--
>  refs/files-backend.c     | 18 ++++++++----
>  t/t0602-reffiles-fsck.sh | 59 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/refs.c b/builtin/refs.c
> index 24978a7b7b..3c492ea922 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -5,6 +5,7 @@
>  #include "parse-options.h"
>  #include "refs.h"
>  #include "strbuf.h"
> +#include "worktree.h"
>  
>  #define REFS_MIGRATE_USAGE \
>  	N_("git refs migrate --ref-format=<format> [--dry-run]")
> @@ -66,6 +67,7 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
>  static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
>  {
>  	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
> +	struct worktree **worktrees, **p;
>  	const char * const verify_usage[] = {
>  		REFS_VERIFY_USAGE,
>  		NULL,
> @@ -75,7 +77,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "strict", &fsck_refs_options.strict, N_("enable strict checking")),
>  		OPT_END(),
>  	};
> -	int ret;
> +	int ret = 0;
>  
>  	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
>  	if (argc)
> @@ -84,9 +86,14 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
>  	git_config(git_fsck_config, &fsck_refs_options);
>  	prepare_repo_settings(the_repository);
>  
> -	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
> +	worktrees = get_worktrees();
> +	for (p = worktrees; *p; p++) {
> +		struct worktree *wt = *p;
> +		ret += refs_fsck(get_worktree_ref_store(wt), &fsck_refs_options);
> +	}

I think it is more customary to say `ret |=` instead of `ref +=`.
Otherwise we could at least in theory wrap around and even land at `ret
== 0`, even though this is quite unlikely.

>  	fsck_options_clear(&fsck_refs_options);
> +	free_worktrees(worktrees);
>  	return ret;
>  }
>  
[snip]
> @@ -3600,8 +3600,16 @@ static int files_fsck(struct ref_store *ref_store,
>  	struct files_ref_store *refs =
>  		files_downcast(ref_store, REF_STORE_READ, "fsck");
>  
> -	return files_fsck_refs(ref_store, o) |
> -	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
> +	int ret = files_fsck_refs(ref_store, o);
> +
> +	/*
> +	 * packed-refs should only be checked once because it is shared
> +	 * between all worktrees.
> +	 */
> +	if (!strcmp(ref_store->gitdir, ref_store->repo->gitdir))
> +		ret += refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
> +
> +	return ret;
>  }
>  
>  struct ref_storage_be refs_be_files = {

What is the current behaviour? Is it that we verify the packed-refs file
multiple times, or rather that we call `packed_ref_store->be->fsck()`
many times even though we know it won't do anything for anything except
for the main worktree?

If it is the former I very much agree that we should make this
conditional. If it's the latter I'm more in the camp of letting it be
such that if worktrees were to ever gain support for "packed-refs" we
wouldn't have to change anything.

In any case, as proposed I think it would make sense to evict this into
a standalone commit such that these details can be explained in the
commit message.

Patrick
