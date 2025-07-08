Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D97206F23
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976918; cv=none; b=LZVq1F6u7SXapM3RXVoUIbVY1BpdKLlYXT+/bsBtQNG3b6JGoNc7VfOCqKut6rqmJj8LtoLafmAixE3dPlub8jzcT5Z46IGm6fYlp6GOHvWFoWIK+8Xc0RtjEEtAk6Q1R+w4LRE0BarBLwrGUIhfvXRNf2IuGD+Po5086wXLJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976918; c=relaxed/simple;
	bh=occ4ZnYgXRnYmcyfqDPaA6npjM2rCR+KWfgqOi/yjaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4Qhttmw2owvGYaMX4+D1Pi4u+/AS0XQhGLzPldaWw7oPgJ4oOLaDy9u8585pgYL+Wv4/yu7CGtKEwaST4JyjOYaBpUG2lfL/H/gJNZ+TNGIoUQlkflE+s3iOGYTftp5sduXC7O08Vq08x5N+rAdIWzSIvKlo8AzMpHMqLFzSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C5TEN9hC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I6+8SfTP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C5TEN9hC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I6+8SfTP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 09075EC0C71;
	Tue,  8 Jul 2025 08:15:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 08:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751976915; x=1752063315; bh=zVfUFzEhv6
	+Y8a2y8DPxdZvYccGMNQAHmpJTuNh1A8s=; b=C5TEN9hC4na/ki81J/A4a/JXIZ
	q0NxqgX6AQo/D7jLYi6UuJturMkj+JicbNlCKXR8tt3PQj5avScINCu7Ev9UpdIM
	YeRiFSaNO+bvpNE6EECU/oEy7dxArq9eAIf/dAFcbYXkJx+L9yn9Dox4W1cNQNLj
	AMhXUEb6JvVovqJNGOscsbu5BmefdZIFgT0BJXtmKHmUz5/PfhmHDNqWFqw4mDtm
	3JNMhZTguag1IgjFNK+rsQBiTbon8lKT+1BW0/j4nMH+4P9gT5F8C4pIhjBIxoRX
	5K7Ik6oa4wNH4zjKXUd6QOr4H47M77eLFLvgNHLblB445QgclISJgXA1q5Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751976915; x=1752063315; bh=zVfUFzEhv6+Y8a2y8DPxdZvYccGMNQAHmpJ
	TuNh1A8s=; b=I6+8SfTP8nLVTBgjCUMOQQR5MpvepFV6RaiFEdExzl6sEWerDIQ
	znY/IH2E8YfyQ/GTyQAMBBZHoZ+tNU1GqEj2JlmlN5iEycxGGIwyzGjiLPEwLt46
	eZnwdGwzZZeR6wO7Q6xmnQhga1d7V7PzPQOaebJRLRGUXSQ8z78RWN1zwSa9oNGm
	UXHkXWTQhtCqqdfEU2ui8mxU5SiNHJXJFqzDpNrZpJ2LuHOdGOhEWsgSY6IYrJWE
	wkdYZ7Gf/sZSnxgpwptDl+N+1fsok9shw9ofs5ITfrqHkswqIWhR+Fd++ix7rU+x
	C+OMHYkfKEJmUJHa9QxMwOrdVEUDQBt35Aw==
X-ME-Sender: <xms:0gttaBion6bAzpDwrL_jjiUdrP5EX14GQti8mfdBWu08SUMJ7mL1DA>
    <xme:0gttaBi1MswbCYFlhRxotllxLPxVCEFNVvTuAfEchxTmvTmToPrjyEiVErxgqMqod
    dtJwWlLzRndA6dxvA>
X-ME-Received: <xmr:0gttaHjVC8iOVpxT8XI076C-RzCfUj2lkZE4UM0SgJErbmMfyh0vSW1Q1fKLBISPSbE0FP_4OJnjSSKuoWWcCxy4QPbv_nfEtLbGkfTBHeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0gttaBJxid4VMLZggbyA3cK809e9jEYHz5X3YqXvPe_tg2UUBstsCg>
    <xmx:0gttaGGqrxhBIL3oO8X0JtsVEUmOwelxhqWA89P01aqDhxxAmagAyg>
    <xmx:0gttaFT5g9tOvngrw5w8ztILAAXdBLWngw4-plcM0y2NcmQVcLFnuA>
    <xmx:0gttaCfiE7J7zCNLkccKrjbRwvFqHCpmm1OAMeioXdcaElDe61nUaA>
    <xmx:0wttaAj9Vs0LEF9hWy0FX7dXa9FuAv2cg9rhiXLhX9QU5-9HLHvGEZZL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 08:15:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e24bb89c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 12:15:13 +0000 (UTC)
Date: Tue, 8 Jul 2025 14:15:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
Message-ID: <aG0LzlnfoQVDdetk@pks.im>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>

On Tue, Jul 08, 2025 at 11:19:52AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
> index 529a8edd9c1e..21ba6f759905 100644
> --- a/Documentation/git-sparse-checkout.adoc
> +++ b/Documentation/git-sparse-checkout.adoc
> @@ -111,6 +111,17 @@ flags, with the same meaning as the flags from the `set` command, in order
>  to change which sparsity mode you are using without needing to also respecify
>  all sparsity paths.
>  
> +'clean'::
> +	Remove all files in tracked directories that are outside of the
> +	sparse-checkout definition. This subcommand requires cone-mode
> +	sparse-checkout to be sure that we know which directories are
> +	both tracked and all contained paths are not in the sparse-checkout.
> +	This command can be used to be sure the sparse index works
> +	efficiently.
> ++
> +The `clean` command can also take the `--dry-run` (`-n`) option to list
> +the directories it would remove without performing any filesystem changes.
> +

Hm. This is somewhat different from `git clean`, where you have to pass
`-f` to make it delete any data. I'm not particularly a fan of that
mode, but should we maybe retain it regardless to ensure that things are
at least a tiny bit more consistent?

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 8b70d0c6a441..6d2843827367 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -924,6 +924,76 @@ static int sparse_checkout_reapply(int argc, const char **argv,
>  	return update_working_directory(repo, NULL);
>  }
>  
> +static char const * const builtin_sparse_checkout_clean_usage[] = {
> +	"git sparse-checkout clean [-n|--dry-run]",
> +	NULL
> +};
> +
> +static struct sparse_checkout_clean_opts {
> +	int dry_run;
> +} clean_opts;
> +
> +static int sparse_checkout_clean(int argc, const char **argv,
> +				   const char *prefix,
> +				   struct repository *repo)
> +{
> +	struct strbuf full_path = STRBUF_INIT;
> +	size_t worktree_len;
> +	static struct option builtin_sparse_checkout_clean_options[] = {
> +		OPT_BOOL('n', "dry-run", &clean_opts.dry_run,
> +			 N_("list the directories that would be removed without making filesystem changes")),
> +		OPT_END(),
> +	};
> +
> +	setup_work_tree();
> +	if (!core_apply_sparse_checkout)
> +		die(_("must be in a sparse-checkout to clean directories"));
> +	if (!core_sparse_checkout_cone)
> +		die(_("must be in a cone-mode sparse-checkout to clean directories"));
> +
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_sparse_checkout_clean_options,
> +			     builtin_sparse_checkout_clean_usage, 0);
> +
> +	if (repo_read_index(repo) < 0)
> +		die(_("failed to read index"));
> +
> +	if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY))
> +		die(_("failed to convert index to a sparse index"));

I noticed that there are several cases in `convert_to_sparse()` where we
simply do nothing. Should we check whether `repo->index->sparse_index`
matches `INDEX_COLLAPSED` after the operation?

> +	strbuf_addstr(&full_path, repo->worktree);
> +	strbuf_addch(&full_path, '/');
> +	worktree_len = full_path.len;
> +
> +	for (size_t i = 0; i < repo->index->cache_nr; i++) {
> +		DIR* dir;

Nit: the `*` goes with the variable, not the type.

> +		struct cache_entry *ce = repo->index->cache[i];
> +		if (!S_ISSPARSEDIR(ce->ce_mode))
> +			continue;

Okay, we only need to handle sparse directories.

> +		strbuf_setlen(&full_path, worktree_len);
> +		strbuf_add(&full_path, ce->name, ce->ce_namelen);
> +
> +		dir = opendir(full_path.buf);

Shouldn't it be sufficient to use `is_directory()`?

> +		if (!dir)
> +			continue;

This is the good and expected case, right? The entry is sparse, so
ideally it doesn't exist. If it does we have to recurse into to end up
with the full index.

> +		else if (ENOENT != errno) {

Nit: style. If one branches requires curly braces, all branches should
use them.

> +			warning_errno(_("failed to check for existence of '%s'"), ce->name);
> +			continue;
> +		}
> +
> +		closedir(dir);
> +
> +		printf("%s\n", ce->name);

git-clean(1) says "Removing %s\n". Should we do the same here?

> +		if (!clean_opts.dry_run) {
> +			if (remove_dir_recursively(&full_path, 0))
> +				warning_errno(_("failed to remove '%s'"), ce->name);
> +		}
> +	}
> +
> +	strbuf_release(&full_path);
> +	return 0;
> +}
> +
>  static char const * const builtin_sparse_checkout_disable_usage[] = {
>  	"git sparse-checkout disable",
>  	NULL

Patrick
