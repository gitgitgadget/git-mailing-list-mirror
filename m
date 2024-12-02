Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B82040BE
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148538; cv=none; b=J3qWSw2SmAXtr5mL8zXJWPuVOSdCU15q1/hHYNLkK71bYpU9dMCeoht5VMf8sFYvAOrQM837rmlw0168oVKNRUpd0MWFDJMWJpUhLEADjzKK5iL7GbVl7gzQE+2TLACXifwKE6PR3FxFEJ4akrk8H7kzt16IJ4CNE7qytl2GE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148538; c=relaxed/simple;
	bh=LiHDzkFHmvgNLdYTY1dwGAtoQisrRUyysEEuwAcvZSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPBKIdRXswP4NZQy8UidpyS/X6pOHQeo7GziCONzdLQ93qVN2qSh+Vw5+Wz+KIhHX2RuwYME32mvWDGOCRjQaum6/iOwHxGczhNRT4m4e40pUfu6xQfhwafdH90vVltd2q98rgB3VLG6dLmgLHqmBHUpky4sAdF9uOPou+eU9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UHsVbAsy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SLIjfb03; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UHsVbAsy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SLIjfb03"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 1050B1140164;
	Mon,  2 Dec 2024 09:08:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 02 Dec 2024 09:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733148533; x=1733234933; bh=5FXxB4mez7
	dhmCiH+zJZnXZ7yd21n9j4sxc9xmG2orY=; b=UHsVbAsyJVtwDl+j4EXjRf9RpB
	9awnlPBZwSblJ+TVb6ikonPcWGykq4smHrK3tC88UprcjHhGYX5IN6XaBbqOoyI3
	sVfqbZ2l96Law5dsut2hFNTkf9y8j30keX/kQKepNMRqF746R+oP0jPhqzNF2+Vb
	k6/uSv8rWif8HQNJuASYlDVaeTX6XClpH8cbmV2KPV2D7CJ/s+Ins4IUEZUDfBP0
	Wa/jkE4N68DKHGSzG1LFRegwFv6UrfrL/NeQvZUWgbU4UPdYOgUX1/pIoFNYIrY1
	PaH/rhD6CFpP+q8FYhrtGcqAQb+i9GeqwzOcquiUZ35lpG1SuwoviOiAf25g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733148533; x=1733234933; bh=5FXxB4mez7dhmCiH+zJZnXZ7yd21n9j4sxc
	9xmG2orY=; b=SLIjfb03Vl0GGiZBQRaXoFu66BqRF1N4kc16aELmBoX+iIy3tIC
	i1LJpE0qR2uYrgCNZog6Vsy5Zq/gN+LgEq8nTUqkIhDSKx/pVlSIzjCkGEVNERl7
	sv/Gov2XWvSx8tNcJxw5wf2fp5ZwNJTThoBSVQz5At8Fu3tznClQwVitG4Xl5kUA
	40y4cLwiCbgD7hHitnJyDrqeILFkQf0NA+BfzoZPB156HFX7aeGqVStG8lhbkdAt
	rSDek1IfRlgOw6qHTJodq9x0jC29gC32PwAFu+oWgT7ZUmkZYXG9Ojyuq2u3e1ZA
	l5nZfBK8PMHiTtXYQvaRcv1/VLUGm/Zj2iw==
X-ME-Sender: <xms:dL9NZyZNxYEkjjGoVeyqO7trKwZkeW9V6tEWbyYFuu3FcDCroCT4lA>
    <xme:dL9NZ1YZUN9Mas-hFlNjkLucA4m1wnuU2Ay7S65H0YGu7rulZw2I7bMyY9ipMHp31
    JKcbqDKSzL2V6NnlA>
X-ME-Received: <xmr:dL9NZ89lhvJVCGAeSbTkJXBTfes2ntKH2IdCdnuiwYYB8eUl9MhQeysXVzyZkUmFsopyDEu2P1c2MwRWE_Ax_KeJyMNXTE5aFNzts7RD4MiF1TQwAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeekudeiffegjefgueeuffekieeggfevhedvjeehudekgedt
    hfffgeetffetgeejvdenucffohhmrghinheprhgvfhgpphhrvghfihigvghsrdhnrhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhushgv
    rdguvg
X-ME-Proxy: <xmx:db9NZ0q_aKRtFq_kkknVor-5mTuHv2Nf9s6Guwc8vRz_P1ALadCy0A>
    <xmx:db9NZ9qy8dxd7nu2YrAOB0obmi3Bl97XxCMsKqRSXpU2OB0IghwJAQ>
    <xmx:db9NZySfd6fIH4UCwrkfbfjJRhiWKY-AHkgt39g-d1KCf8pggqB58w>
    <xmx:db9NZ9qrtibxm9u2rFP_U8jbnhJd2aQTA80ZjjPrDtxFwPICe5JdHA>
    <xmx:db9NZ-kbvAMt6RT3rSWcUBIHfYaDGhbUGal9v7PTw5rzvDYDhgJlCCxt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 09:08:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 596890b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 14:07:34 +0000 (UTC)
Date: Mon, 2 Dec 2024 15:08:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH v2] builtin/clone: teach git-clone(1) the --revision=
 option
Message-ID: <Z02_YwCgHp_MVj3M@pks.im>
References: <20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com>

On Fri, Nov 29, 2024 at 01:00:42PM +0100, Toon Claes wrote:
> The git-clone(1) command has the option `--branch` that allows the user
> to select the branch they want HEAD to point to. In a non-bare
> repository this also checks out that branch.
> 
> Option `--branch` also accepts a tag. When a tag name is provided, the
> commit this tag points to is checked out and HEAD is detached. Thus
> `--branch` can be used to clone a repository and check out a ref kept
> under `refs/heads` or `refs/tags`. But some other refs might be in use
> as well. For example Git forges might use refs like `refs/pull/<id>` and
> `refs/merge-requests/<id>` to track pull/merge requests. These refs
> cannot selected upon git-clone(1).

s/cannot/cannot be/

> Add option `--revision` to git-clone(1). This option accepts a fully
> qualified reference, or a raw commit hash. This enables the user to
> clone and checkout any revision they want. `--revision` can be used in

s/checkout/check out/

Does this have to be a raw commit hash, or do we also accept an
arbitrary committish like a tag that peels down to a commit?

> conjunction with `--depth` to do a minimal clone that only contains the
> sources for a single revision. This can be useful for automated tests.

It's implicity, but automated tests in this context probably means CI
systems.

> This type of shallow clone could also be achieved with the following set
> of commands:
> 
>     git init the-repo
>     cd ./the-repo
>     git remote add origin <url>
>     git fetch --depth=1 origin <commit-id>
>     git checkout <commit-id>
> 
> Unfortunately, this approach uses git-fetch(1) instead of git-clone(1),
> and only on git-clone(1) the bundle URIs advertised by the server are
> used. By adding this option `--revision` to git-clone(1) allows us to
> get the same end result, while benefiting from bundle URIs if advertised
> by the server.

I'd claim that this is not only about enabling bundle URIs, but also
about making this easier to work with in the first place. The above is
rather on the complex side even though the use case at hand is not all
that esoteric.

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 7acb4cb17618c6cbee5d6ebe41a53be03ebfaa6c..2a3f6d9deae4b817db50d8c4e555a6f33b8296f1 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -218,6 +218,13 @@ objects from the source repository into a pack in the cloned repository.
>  	`--branch` can also take tags and detaches the `HEAD` at that commit
>  	in the resulting repository.
>  
> +`--revision` _<rev>_::
> +	This clones the given revision, and that revision only. The argument can
> +	be a symbolic ref name (e.g. `refs/heads/main`), or a raw commit hash.

Nit: while I know what you want to say with "symbolic ref name", I think
it's a bit awkwardly worded because a reader may confuse it with an
actual symbolic ref. I would just drop the "symbolic".

We should also clarify whether this accepts tags that peel down to a
commit.

> +	Unless the revision points to a branch (i.e. ref starting with
> +	`refs/heads/`), the HEAD is detached.

Okay, makes sense. When cloning a tag or committish we wouldn't know how
to name the branch, so we instead put us into detached HEAD mode.

I could see an argument that we should do this unconditionally even when
cloning a branch to simplify the UX by always doing the same thing, no
matter what the user has passed.

> +	This option is incompatible with `--branch`, `--mirror`, and `--bare`.

The restriction on `--branch` and `--mirror` is sensible: we ask for a
single commit, so neither of those options would make sense when taken
together.

But why can't we pass `--bare`? That only controls whether we have a
working tree or not, and a bare repository can have a detached HEAD, as
well.

>  `-u` _<upload-pack>_::
>  `--upload-pack` _<upload-pack>_::
>  	When given, and the repository to clone from is accessed
> diff --git a/builtin/clone.c b/builtin/clone.c
> index c0013c75cdc7672abced893c36d2aaf4ff246045..0b118388e059068e78ac1eff4c0a9685a1c4e26b 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -69,6 +69,7 @@ static char *option_template, *option_depth, *option_since;
>  static char *option_origin = NULL;
>  static char *remote_name = NULL;
>  static char *option_branch = NULL;
> +static char *option_rev = NULL;
>  static struct string_list option_not = STRING_LIST_INIT_NODUP;
>  static const char *real_git_dir;
>  static const char *ref_format;
> @@ -141,6 +142,8 @@ static struct option builtin_clone_options[] = {
>  		   N_("use <name> instead of 'origin' to track upstream")),
>  	OPT_STRING('b', "branch", &option_branch, N_("branch"),
>  		   N_("checkout <branch> instead of the remote's HEAD")),
> +	OPT_STRING(0, "revision", &option_rev, N_("rev"),
> +		   N_("clone single revision <rev> and check out")),
>  	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
>  		   N_("path to git-upload-pack on the remote")),
>  	OPT_STRING(0, "depth", &option_depth, N_("depth"),
> @@ -682,12 +685,14 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  			install_branch_config(0, head, remote_name, our->name);
>  		}
>  	} else if (our) {
> -		struct commit *c = lookup_commit_reference(the_repository,
> -							   &our->old_oid);
> -		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
> -		refs_update_ref(get_main_ref_store(the_repository), msg,
> -				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
> -				UPDATE_REFS_DIE_ON_ERR);
> +		struct commit *c =
> +			lookup_commit_reference(the_repository, &our->old_oid);
> +
> +		if (c)
> +			/* --branch specifies a non-branch (i.e. tags), detach HEAD */
> +			refs_update_ref(get_main_ref_store(the_repository), msg,
> +					"HEAD", &c->object.oid, NULL,
> +					REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);

This change is a bit surprising. Why can it happen that we don't have
the commit now?

>  	} else if (remote) {
>  		/*
>  		 * We know remote HEAD points to a non-branch, or
> @@ -889,7 +894,7 @@ static void write_refspec_config(const char *src_ref_prefix,
>  	struct strbuf key = STRBUF_INIT;
>  	struct strbuf value = STRBUF_INIT;
>  
> -	if (option_mirror || !option_bare) {
> +	if (!option_rev && (option_mirror || !option_bare)) {
>  		if (option_single_branch && !option_mirror) {
>  			if (option_branch) {
>  				if (starts_with(our_head_points_at->name, "refs/tags/"))
> @@ -968,7 +973,7 @@ int cmd_clone(int argc,
>  	char *repo_to_free = NULL;
>  	char *path = NULL, *dir, *display_repo = NULL;
>  	int dest_exists, real_dest_exists = 0;
> -	const struct ref *refs, *remote_head;
> +	const struct ref *refs = NULL, *remote_head;
>  	struct ref *remote_head_points_at = NULL;
>  	const struct ref *our_head_points_at;
>  	char *unborn_head = NULL;
> @@ -1345,6 +1350,18 @@ int cmd_clone(int argc,
>  
>  	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
>  
> +	if (option_rev) {
> +		if (option_branch)
> +			die(_("options '%s' and '%s' cannot be used together"),
> +			    "--revision", "--branch");
> +		if (option_mirror)
> +			die(_("options '%s' and '%s' cannot be used together"),
> +			    "--revision", "--mirror");
> +		if (option_bare)
> +			die(_("options '%s' and '%s' cannot be used together"),
> +			    "--revision", "--bare");
> +	}
> +
>  	if (reject_shallow)
>  		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
>  	if (option_depth)

We have `die_for_incompatible_opt{3,4}()`, but don't yet have the
eqiuvalent for two options. I know this has come up repeatedly during
reviews. Maybe we should finally add that helper in a separate commit?

> @@ -1387,7 +1404,27 @@ int cmd_clone(int argc,
>  		strvec_push(&transport_ls_refs_options.ref_prefixes,
>  			    "refs/tags/");
>  
> -	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
> +	if (option_rev) {
> +		refspec_clear(&remote->fetch);

Why do we have to clear the fetchspec first? I would have expected us to
skip over any previous steps that may have populated it when given the
"--revision=" option.

> +		refspec_init(&remote->fetch, REFSPEC_FETCH);
> +		refspec_append(&remote->fetch, option_rev);
> +
> +		strvec_clear(&transport_ls_refs_options.ref_prefixes);
> +		refspec_ref_prefixes(&remote->fetch,
> +				     &transport_ls_refs_options.ref_prefixes);
> +
> +		if (transport_ls_refs_options.ref_prefixes.nr == 0)
> +			/*
> +			 * We need to talk to the server to determine the hash
> +			 * algorithm, but when no ref prefixes are set the
> +			 * server announces all known refs, so ask the server to
> +			 * only tell us about HEAD.
> +			 */
> +			strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> +	}
> +
> +	refs = transport_get_remote_refs(transport,
> +					 &transport_ls_refs_options);
>  
>  	/*
>  	 * Now that we know what algorithm the remote side is using, let's set
> @@ -1461,8 +1498,13 @@ int cmd_clone(int argc,
>  		}
>  	}
>  
> -	if (refs)
> +	if (option_rev) {
> +		struct ref **tail = &mapped_refs;
> +
> +		get_fetch_map(refs, &remote->fetch.items[0], &tail, 1);
> +	} else if (refs) {
>  		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
> +	}
>  
>  	if (mapped_refs) {
>  		/*
> @@ -1495,6 +1537,8 @@ int cmd_clone(int argc,
>  		if (!our_head_points_at)
>  			die(_("Remote branch %s not found in upstream %s"),
>  			    option_branch, remote_name);
> +	} else if (option_rev) {
> +		our_head_points_at = mapped_refs;
>  	} else if (remote_head_points_at) {
>  		our_head_points_at = remote_head_points_at;
>  	} else if (remote_head) {
> diff --git a/t/t5620-clone-revision.sh b/t/t5620-clone-revision.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..833438e46d1c648ca46cf9d0a2948aad261c7f89
> --- /dev/null
> +++ b/t/t5620-clone-revision.sh
> @@ -0,0 +1,97 @@
> +#!/bin/sh
> +
> +test_description='tests for git clone --revision'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +TEST_PASSES_SANITIZE_LEAK=true
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit --no-tag "initial commit" README "Hello" &&
> +	test_commit "second commit" README "Hello world" v1.0 &&
> +	test_commit --no-tag "third commit" README "Hello world!" &&
> +	git switch -c feature v1.0 &&
> +	test_commit --no-tag "feature commit" README "Hello world!" &&
> +	git switch main
> +'
> +
> +test_expect_success 'clone with --revision being a branch' '
> +	test_when_finished "rm -rf dst" &&
> +	git clone --revision=refs/heads/feature . dst &&
> +	git rev-parse refs/heads/feature >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual &&
> +	git for-each-ref refs/heads/feature > expect &&
> +	git -C dst for-each-ref > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'clone with --depth and --revision being a branch' '
> +	test_when_finished "rm -rf dst" &&
> +	git clone --depth=1 --revision=refs/heads/feature . dst &&
> +	git rev-parse refs/heads/feature >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'clone with --revision being a tag' '
> +	test_when_finished "rm -rf dst" &&
> +	git clone --revision=refs/tags/v1.0 . dst &&
> +	git rev-parse refs/tags/v1.0 >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'

Is this an annotated tag or a normal one?

> +test_expect_success 'clone with --revision being HEAD' '
> +	test_when_finished "rm -rf dst" &&
> +	git clone --revision=HEAD . dst &&
> +	git rev-parse HEAD >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'

Ah, interesting. So we can essentially clone whatever the remote HEAD
points to. Nice.

> +test_expect_success 'clone with --revision being a raw commit hash' '
> +	test_when_finished "rm -rf dst" &&
> +	oid=$(git rev-parse refs/heads/feature) &&
> +	git clone --revision=$oid . dst &&
> +	echo $oid >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'clone with --revision being a short raw commit hash' '
> +	test_when_finished "rm -rf dst" &&
> +	oid=$(git rev-parse --short refs/heads/feature) &&
> +	git clone --revision=$oid . dst 2>err &&
> +	grep "warning: remote HEAD refers to nonexistent ref, unable to checkout" err
> +'

You probably want to use `test_grep` for these.

What makes me wonder though is that these clones don't fail, but
generate a warning because we don't understand the ref. I would have
expected us to either bail out completely or succeed and end up with a
well-formed repository that has the commit in question checked out.

> +test_expect_success 'clone with --revision being a tree hash' '
> +	test_when_finished "rm -rf dst" &&
> +	oid=$(git rev-parse refs/heads/feature^{tree}) &&
> +	git clone --revision=$oid . dst 2>err &&
> +	grep "warning: remote HEAD refers to nonexistent ref, unable to checkout" err
> +'
> +
> +test_expect_success 'clone with --revision being the parent of a ref fails' '
> +	test_when_finished "rm -rf dst" &&
> +	test_must_fail git clone --revision=refs/heads/main^ . dst
> +'

It might make sense to also `test_grep` these error messages so that we
know to not fail due to unrelated reasons.

Thanks!

Patrick
