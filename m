Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4A2D248E
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636505; cv=none; b=HBQK2bDJhLvEzjRA9NIJSEnfJETq5N/g7ge9W+EFlYyeEweqARjHVUGgcrAZJtB72BgyJgCT7BE5Z7/CXPPa/BsJfilcpN2CHAfndIrpBzQMr8SW71KrOU18Y/i13Gu0KaHjV6Cyl4kUxX1Ag3/Ct/+3k2cPXg658sYxfGti3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636505; c=relaxed/simple;
	bh=GKrQaGNpCC1BhLlrpfR2ADmgAva8eZReUfA2TPWJwSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6u269d2ijiDM1H825YwFSVL6gFHQSjGOjt6adUT3ws7TOMcLKWT9mnNZUmDOB4gmlhwl+nj4ZajztDwfUWfdpj5DwZbdOLV16Y6fNvl9tJXD8No9Xt4gVi/P+XoLk6QTbYuZgtkFafCDkn3RMqGT/I0VtREsoFlvM0+9DO5Xwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fP7HJHCg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnDIGAKf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fP7HJHCg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnDIGAKf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 49D04EC0410;
	Tue, 28 Oct 2025 03:28:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 03:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761636502; x=1761722902; bh=I7/bWl0mDE
	4xGI8jN+0+yNsbXPwwTouYwo+buCDd60s=; b=fP7HJHCgtMOJd+x/4IIWSP3qvh
	J3Tb51xFkjGx/A3CRXnqNqahjo78hOuiHgqXKqXsMRmcUppiOS5upQOM50EU7xJ1
	CcfwKVYX6HpdaxZcEmEoahd8a6IhnSvk67Yis8i0HHxkYh3bOOP3Ep1HcByFojo4
	X8QVddTzgoEydQj6bFvcul9dRAXPU/NJ723Aqgot2mS07r1S0iv2HaAygDYjcvSr
	Qec0yTCgzxVpMsvDXDBM3GzxsY/gYs1ISpD7CgXo0lkn+GDnuBCMYbtvQotv94Gh
	HZSJ0nKex3YBJjupC53YxT+9TVSsVWeWZt5P8u0suo0DTPN2b58x4gXuxScg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761636502; x=1761722902; bh=I7/bWl0mDE4xGI8jN+0+yNsbXPwwTouYwo+
	buCDd60s=; b=JnDIGAKfFuO2tZpZmQ/L+WcATHrQA7b3XhsNXZgok3oAWoA5qZ8
	2StgBjepQMU56GHNgXKXBd2674pCEdXjIIEcpE3BhgiGlFba+KVW3sOuQeYkhV7D
	AsXWafpOOG8swY1oeIk2g1xIBQWixjWuiQWcPux0Eg2Pp6diw5UKVOpOYutCAejG
	riz7lwyfbnScvNGf9JBG2gwybulxX4EzW3MqBJugwjY3opuHQDJGITSJGzSFJYjj
	yspvOaB7inoL8XZH/BHIM40kzK4bicy4L2x7GI79IzwcT0/0DJx2AD8ZE1tvKuox
	AbQMJd35ky4kFqkBk0dwNUuF1efnuvSCD+w==
X-ME-Sender: <xms:lnAAacXESTSaA3s9AcUUsISyy_GM0B-3tFKaEUiLlZxpHwBoXcI_OA>
    <xme:lnAAaYC9n3eCWJwsGKhdCTgi2chHr6zsoSxxh8VcNXG0LU6nnD9J-wba9qqJwP0UK
    NHoxgnpmYpeq27ZAfmxgn6uh_yDVmDxjZSIv94oroRkYLI1rzQebco>
X-ME-Received: <xmr:lnAAady3wlnx7EOA57emYf4Knj3oy8jNwW2Zml4DSyzk-MkLM36aTtQhVaPD2scZjt9FJMf6LrtAWQ-OGCEGiLsCa_E5DojIq_W8AWCI8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmh
    drsghoshhtohgtkhesshhhohhpihhfhidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lnAAaVB0slioOFtQXUztyTssCRkJlD-tg-p9d1TCyek6bHiWMExVmw>
    <xmx:lnAAaabhnBzLAThDjL4DeBezLK0FfwIPC5azydNonPgXRt1FbNO3kQ>
    <xmx:lnAAadi4ICWih02KY3t4zjwFaNpImFQw2I9tI0o2e7rtKhetbRESyA>
    <xmx:lnAAac7N81k0MYWo4lWKRfBYK_eOvWhZqqLdjWXcfOASVPXC8g5Bog>
    <xmx:lnAAab4YNbW7nD2QT_quiNSnwkBUeZRoDvbNj646A3N-tjlRjdTVLJs1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 03:28:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d40ec7a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 07:28:19 +0000 (UTC)
Date: Tue, 28 Oct 2025 08:28:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sam Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH] refs: support migration with worktrees
Message-ID: <aQBwiE-bhqcaSHG_@pks.im>
References: <pull.2077.git.git.1761589580028.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2077.git.git.1761589580028.gitgitgadget@gmail.com>

On Mon, Oct 27, 2025 at 06:26:20PM +0000, Sam Bostock via GitGitGadget wrote:
> From: Sam Bostock <sam.bostock@shopify.com>
> 
> Remove the worktree limitation from `git refs migrate` by implementing
> migration support for repositories with linked worktrees.
> 
> Previously, attempting to migrate a repository with worktrees would fail
> with "migrating repositories with worktrees is not supported yet". This
> limitation existed because each worktree has its own ref storage that
> needed to be migrated separately.
> 
> Migration now uses a multi-phase approach to safely handle multiple
> worktrees:
> 
> 1. Phase 1: Iterate through all worktrees and create temporary new ref
>    storage for each in a staging directory.
> 
> 2. Phase 2: For each worktree, backup the existing ref storage, then
>    move the new storage into place.
> 
> 3. Phase 3: Update the repository format config, clear cached ref stores,
>    and delete all backups. On failure, restore from backups and report
>    where the migrated refs can be found for manual recovery.

Makes sense.

> This approach ensures that if migration fails partway through, the
> repository can be restored to its original state.
> 
> Key implementation details:
> 
> - For files backend: Create a commondir file in temp directories for
>   linked worktrees so the files backend knows where the common git
>   directory is located.

Hm, okay. Not yet sure why we need this, but let's read on.

> - For linked worktrees: Use non-INITIAL transactions to avoid creating
>   packed-refs files (linked worktrees should never have packed-refs).

Hm, this is unfortunate. The reason why we use initial transactions is
twofold:

  - First, we want to avoid creating loose refs, only. This is indeed
    something we must not do with worktrees, as you point out.

  - But second, we also want to skip pointless checks like the conflict
    checks. This results in quite a saving.

Would've been great to retain the second property, but I guess as long
as we only do this for worktrees it's okayish and something we can worry
about at a later point in time. Better to migrate the refs slowish than
not at all.

> - Filter refs during iteration: Linked worktrees only migrate their
>   per-worktree refs (refs/bisect/*, refs/rewritten/*, refs/worktree/*).
>   Shared refs are migrated once in the main worktree.

Makes sense.

> - Write per-worktree refs as loose files: The files backend's
>   transaction_finish_initial() optimization writes most refs to
>   packed-refs, but per-worktree refs must be stored as loose files
>   to maintain proper worktree isolation.

Isn't this roughly the same as the second bullet point? Feels like they
should be merged together.

> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index fa33680cc7..f6a3bf4f03 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -30,7 +30,8 @@ COMMANDS
>  --------
>  
>  `migrate`::
> -	Migrate ref store between different formats.
> +	Migrate ref store between different formats. Supports repositories
> +	with worktrees; migration must be run from the main worktree.

It feels a bit weird to single our worktrees specifically. We don't say
that the tool supports bare and non-bare repositories, either, so the
only reason why we'd have the note about worktrees is historic legacy.
How about this instead:

    Migrate ref storage between different formats. Must be run from the
    main worktree in case the repository uses worktrees.

> @@ -95,7 +96,7 @@ KNOWN LIMITATIONS
>  
>  The ref format migration has several known limitations in its current form:
>  
> -* It is not possible to migrate repositories that have worktrees.
> +* Migration must be run from the main worktree.
>  

I'd drop this bullet point entirely, as I don't really see this as a
limitation anymore.

> diff --git a/refs.c b/refs.c
> index 965381367e..0834329e5a 100644
> --- a/refs.c
> +++ b/refs.c

I'm sorry, but this is _extremely_ hard to review as we're changing
almost all of the implementation at once with random changes left and
right. Furthermore, I feel like we're getting way to intimate with the
different backends here -- that shouldn't be the case though, the logic
that is specific to the backends should really live in the backends
themselves.

The way I'd expect a series like this to look like is to have commits
that:

  1. Do preparatory changes, e.g. teach the files backend to not create
     a packed-refs file for worktrees during migration.

  2. Pull out the logic to migrate a single reference backend that we
     already have into a separate function that can be called in a loop.
     The end result should be a function that accepts the old refdb as
     input and that returns the new refdb.

  3. Implement the logic that calls the function we introduced in (2)
     for each worktree. This can be done by iterating through all the
     worktrees, calling `get_worktree_ref_store()` on it and then
     passing the refdb to the new function.

> @@ -2974,8 +2976,296 @@ struct migration_data {
[snip]
> +/*
> + * Create a commondir file in the temporary migration directory for a linked
> + * worktree. The files backend needs this to locate the common git directory.
> + * Returns 0 on success, -1 on failure.
> + */
> +static int create_commondir_file(const char *new_dir, const char *worktree_path,
> +				  struct strbuf *errbuf)
> +{

I still don't get why we need this. We should have access to both the
ref store of the worktree and the repository, and both of these are
handled in the same process. So there shouldn't be a need to propagate
the commondir via a file.

[snip]
> +/*
> + * Returns the list of ref storage items to backup/restore for a worktree.
> + * Main worktrees include packed-refs, linked worktrees do not.
> + */
> +static const char **get_ref_storage_items(int is_main_worktree)
> +{
> +	static const char *main_items[] = {"refs", "logs", "reftable", "packed-refs", NULL};
> +	static const char *linked_items[] = {"refs", "logs", "reftable", NULL};
> +
> +	return is_main_worktree ? main_items : linked_items;
> +}

This here is what I was referring to as "too intimate with the
backends". This logic should be entirely self-contained in the backends,
and it already is for migrating the main worktree. We have
`ref_store_remove_on_disk()` to prune old data, and as the new ref
storage is written into a temporary directory we don't need to enumerate
its contents, but can instead move all of its entries into the gitdir
directly.

I guess the reason why you have this and all of the following functions
is to create the backups. But that logic must not live in "refs.c", but
it really should live in the backends. I could for example see a new
function that moves a ref store to a different directory.

An alternative would be to not do the backups at all. We only start
doing "destructive" operations when all the new backends have already
been created, so the last step would be to rename everything into place.
If this operation fails or gets cancelled we are left with a broken
repository, true. But the data is not lost, as we can in theory continue
to rename the remaining data into place.

So maybe that's good enough? The user would have to manually restore in
either of the cases, so we don't really gain that much by having a
backup in the first place.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8d7007f4aa..6be56274d3 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3210,11 +3210,13 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  		string_list_append(&refnames_to_check, update->refname);
>  
>  		/*
> -		 * packed-refs don't support symbolic refs, root refs and reflogs,
> -		 * so we have to queue these references via the loose transaction.
> +		 * packed-refs don't support symbolic refs, root refs, per-worktree
> +		 * refs, and reflogs, so we have to queue these references via the
> +		 * loose transaction.
>  		 */
>  		if (update->new_target ||
>  		    is_root_ref(update->refname) ||
> +		    is_per_worktree_ref(update->refname) ||
>  		    (update->flags & REF_LOG_ONLY)) {
>  			if (!loose_transaction) {
>  				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);

This is one of these changes where I think it would make sense to split
them out into separate commits so that they can be properly singled out
and explained.

Patrick
