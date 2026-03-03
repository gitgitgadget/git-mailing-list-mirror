Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56123382392
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579208; cv=none; b=P7z+80vXmn4f1ycbPxQW+0wcUTqB7fZaggzGUa48l1qsFxslYw5EMWNaMTQCdvE87aPCmENOrWgqFN+jZGzaGfQOTpoupHO0O7y4vS2582dKkytqWfCpYaZrJaFGRC4DweACZVsh+DMopNPrkL6He3Z3vTFUhvMXlYEY8GIpaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579208; c=relaxed/simple;
	bh=JffFeabt56W8wlqgETA871bMamNCcjhWFWEOqstHSqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfsZ+0bAgS5nWzIfN7Jn1ZZZz7DhTbpeSoufH4pTb3F77WFGqD1IPnTj5FEJknAV8iT/41vfQYXpQCK26IMkEi7BPKKmohUMv+IYJGUreHi7V60kV+Om1tIxuBf07IM/bROp+rRbKTCPkDwLleX7EDA75yxq+G3Ku/Gtvlgz7rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MYin5+TN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUqzlWuR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYin5+TN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUqzlWuR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9A2B14001B4;
	Tue,  3 Mar 2026 18:06:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Mar 2026 18:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772579205; x=1772665605; bh=BU25xNUK/i
	PpR7aWpezT0473rTWAYYxebAwvZukkFic=; b=MYin5+TNYYzGLw9VD3WleVwgR4
	dwGvWgoItBDeYnuSgjPhW7IsScl3D1GIQFE55VbXO9/SEcMYprC+b3H1hAWiT9Dz
	S05hf12UqoNvswBBsghLxWQIqVzZRF8tt8OWdbgKT7LhOAxOJ4wEvS/bGRtBf/oH
	VcxOPRLts/PeRh069XT989GQqjJW8yVj6h2+gIlC3liQBewK48ol1MIUjPo+M6Xa
	nLOaDOzg2j59pjj/3CyWFhzpSeWIhvMbP3snyoyvWw0rfCf1c/FmxBJ0mmKXw1XO
	LtjkRsU8estfiHCzrWqkVpU3zVbWEPgLdV/Rz67L8MJlNuxfZtvgF1GQZAWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772579205; x=1772665605; bh=BU25xNUK/iPpR7aWpezT0473rTWAYYxebAw
	vZukkFic=; b=gUqzlWuRQ9yAfQsz/LZt/kmnHp49ql2xdtyw5S7LyOtvx/RVfSw
	ZiQ27n4hVpuzITp0cDNqBV7cZYVuIoSI7GEkJy8r0+7rKAuLHy9f36E4QWYLQUrI
	uIqmrFPPy+jgXgRgUHakQraxdwrQACcaXvHPKqMMWBDJRvEKDMW4xQqgFNn3MtZp
	B6wUzWskMMJJfcw57iUJjYrNmXiB34iTGzzSjp+/aaPJdkhuLRqZ1I7G0jh/00IX
	bVTABbdAe/xmgBZwVuOHecvtxcYk3ekmqHwH3k2VbDC1DYP7GR6/wPKMWkvMKpxT
	gF+/BfpTGbiytazyZb+vEhQhhcwb2LAWW2Q==
X-ME-Sender: <xms:hWmnaWxiBbvhNUslbaabICkv5L2DHUFy4MDKJWTQsPOinQh2LaSnlQ>
    <xme:hWmnaZSwdj7SDTrjSccS11M06Esk9-95FRUJ565q28jol7EjqF06saoCAVRpTt228
    VNcfeanc3KhVLjgfFmdmHVs1LGzFkly8rD-zLwIRWoXPNxr4JeGug>
X-ME-Received: <xmr:hWmnadU0iMnrt2jyD_ycWsdNMhILqQk487ti9bcvy-L1li84cmeekN4DJI0vjwXDIdqYrdfGxJ5WpeQeB40zb5DnSjGHkzfrWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhgrnhgurhgrkhhrsehpmhdrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:hWmnabbq8XEoRyq-fKRjC4ExVgkkMozbDvNyNRdt6js6c6-Oy0dD4A>
    <xmx:hWmnaT2p6b036DWopN3XhUm0nrzQYYUwAMjjKAmFJiERcGV_tkxvEg>
    <xmx:hWmnadgqXAMBY_0WDEXeQth6C8jsiQu5WzX2zADBNpyzwja2uOamiA>
    <xmx:hWmnaXZhx5PAF-TrhsYZ-7ugRdrBZu9WI31ywWQCm66ne6BCYHkivg>
    <xmx:hWmnaYgHc7PQVMqmz1UQn1KGs0LswZ_1iqLDUHgHjSB00SHNFKiOPU8l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 18:06:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Kethi-Reddy <chandrakr@pm.me>
Subject: Re: [PATCH v3] add: support pre-add hook
In-Reply-To: <pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com> (Chandra
	Kethi-Reddy via GitGitGadget's message of "Fri, 27 Feb 2026 05:54:52
	+0000")
References: <pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com>
	<pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com>
Date: Tue, 03 Mar 2026 15:06:43 -0800
Message-ID: <xmqqy0k8a4xo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> "git add" has no hook that lets users inspect what is about to be
> staged. Users who want to reject certain paths or content must
> wrap the command in a shell alias or wait for pre-commit, which
> fires too late to prevent staging.

I do not think the above would convince readers that "preventing to
add" is a worthy goal in the first place.  If you "git add foo" by
mistake and wish you had this hook to prevent 'foo' from getting
added ever, you can easily "git reset foo" to undo it.

> Introduce a "pre-add" hook that runs after "git add" computes the
> new index state but before committing it to disk. The hook
> receives two positional arguments:
>
>   $1 -- index path used by this invocation (may not exist yet)
>   $2 -- lockfile path containing proposed staged index state

OK, perhaps.

> While the lockfile is active the current index path remains readable
> and unchanged, so a seperate copy is unnecessary. 

Unless readers may think that it is needed to make a separate copy
in order to prevent "git add" from happening, and I am not sure why
we would expect readers to do so, this is not something we need to
say here, is it, even thought it might not be telling any lies?

What is more important would be to tell readers that these two index
files are meant to be read-only and hooks are not expected to modify
them.

> Hook authors can
> inspect the computed result with ordinary tools:
>
>   GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD
>
> without needing to interpret pathspec or mode flags as the proposed
> index already reflects their effect.

Good.

> At the finish label, write_locked_index() writes the proposed index
> to the lockfile without COMMIT_LOCK so commit_lock_file() can be
> called seperately after the hook runs. However, do_write_locked_index()
> unconditionally fires post-index-change after every write, and ...

Are these implementation details really needed to be described here
for future developers to understand what this change was while they
read the "git log -p" output and find this commit?

> the
> existing test suite (t7113) asserts that index.lock does not exist when
> that hook fires. Tying the hook to COMMIT_LOCK would suppress it for
> other callers that depend on it after a non-committed write (e.g.,
> prepare_to_commit() in builtin/commit.c). A new SKIP_INDEX_CHANGE_HOOK
> flag lets builtin/add.c suppress the automatic notification on just this
> call, then emit post-index-change manually after commit_lock_file()
> publishes the new index. If the hook rejects, rollback_lock_file()
> discards the lockfile and the original index is left unchanged. When
> no hook is installed the existing write_locked_index(COMMIT_LOCK |
> SKIP_IF_UNCHANGED) path is taken.

IOW, what does it help the reader to read the above wall of text?

> The hook gate checks cache_changed regardless of exit_status so that
> mixed-result adds (e.g., a tracked modification combined with an
> ignored path) still run the hook when index content changes.
>
> The hook is bypassed with "--no-verify" and is not invoked for
> --interactive, --patch, --edit, or --dry-run, nor by "git commit -a"
> which stages through its own code path.
>
> Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
> ---
>     
>  Documentation/git-add.adoc  |  11 +-
>  Documentation/githooks.adoc |  30 ++++
>  builtin/add.c               |  47 +++++-
>  read-cache-ll.h             |   1 +
>  read-cache.c                |  13 +-
>  t/meson.build               |   1 +
>  t/t3706-pre-add-hook.sh     | 289 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 381 insertions(+), 11 deletions(-)
>  create mode 100755 t/t3706-pre-add-hook.sh
>
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 6192daeb03..b47751acca 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [synopsis]
>  git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
>  	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
> -	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
> +	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize] [--no-verify]

Avoid making the line that is already overly long even worse.

> @@ -42,6 +42,10 @@ use the `--force` option to add ignored files. If you specify the exact
>  filename of an ignored file, `git add` will fail with a list of ignored
>  files. Otherwise it will silently ignore the file.
>  
> +A `pre-add` hook can be run to inspect or reject the proposed index update
> +after `git add` computes staging and writes it to the index lockfile,
> +but before writing it to the final index. See linkgit:githooks[5].

I think the above (as with everything else you wrote in the patch,
including a part of the proposed commit log message) stresses too
much more on the implementation detail than what would help your
intended readers.  How about writing it more like this?

    The `pre-add` hook, if exists, is run with a temporary index
    file that shows the result of proposed `git add` to inspect.  By
    exiting with non-zero status, the hook can reject the proposed
    changes.  If the hook exits with zero status, this temporary
    index file will become the final result.

The readers do not have to know 'lockfile' or 'final index'.  They
would want to know how to accept or reject the proposed result.

Or we can leave all the details to linkgit:githooks[5] and say
only something like this

    A `pre-add` hook can be used to reject `git add`; see
    linkgit:githooks[5].

and nothing else.

> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index 056553788d..657e14d306 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -94,6 +94,36 @@ and is invoked after the patch is applied and a commit is made.
>  This hook is meant primarily for notification, and cannot affect
>  the outcome of `git am`.
>  
> +pre-add
> +~~~~~~~
> +
> +This hook is invoked by linkgit:git-add[1], and can be bypassed with the
> +`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
> +`--edit`, or `--dry-run`.
> +
> +It takes two parameters: the path to the index file for this invocation

Elsewhere you called these two files "arguments" but here you say
"parameters".  Let's be consistent.

> +of `git add`, and the path to the lockfile containing the proposed
> +index after staging. It does not read from standard input. If no index
> +exists yet, the first parameter names a path that does not exist and
> +should be treated as an empty index.
> +
> +The hook is invoked after the index has been updated in memory and
> +written to the lockfile, but before it is committed to the final index
> +path. Exiting with a non-zero status causes `git add` to reject the
> +proposed state, roll back the lockfile, and leave the index unchanged.
> +Exiting with zero status allows the index update to be committed.

Good write-up.

> +Git does not set `GIT_INDEX_FILE` for this hook. 

I am not sure what the point of mentioning GIT_INDEX_FILE here.  If
the user did

    $ GIT_INDEX_FILE=.git/alt-index git add files...

the "git" process has the environment variable in place, pointing at
the file as _the_ index file to add to.  We do not unset and
unexport the environment variable before invoking the hook, do we?
We simply do not do anything special or strange.  It makes it less
confusing if we refrain from saying "we do not do this unusual thing
or that special thing", doesn't it?

> Hook authors may
> +set `GIT_INDEX_FILE="$1"` to inspect current index state and
> +`GIT_INDEX_FILE="$2"` to inspect proposed index state.

Explaining this one does make sense.  "current" -> "the current"
and "proposed" -> "the proposed", I think.

Somewhere around here, it would be necessary to say that these two
files should be treated as read-only by this hook.

> +	int run_pre_add = 0;
> +	char *orig_index_path = NULL;
>  
>  	repo_config(repo, add_config, NULL);
>  
> @@ -576,6 +582,11 @@ int cmd_add(int argc,
>  		string_list_clear(&only_match_skip_worktree, 0);
>  	}
>  
> +	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
> +		run_pre_add = 1;
> +		orig_index_path = absolute_pathdup(repo_get_index_file(repo));
> +	}
> +
>  	transaction = odb_transaction_begin(repo->objects);
>  
>  	ps_matched = xcalloc(pathspec.nr, 1);
> @@ -587,8 +598,10 @@ int cmd_add(int argc,
>  						  include_sparse, flags);
>  
>  	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
> -	    report_path_error(ps_matched, &pathspec))
> +	    report_path_error(ps_matched, &pathspec)) {
> +		free(orig_index_path);
>  		exit(128);
> +	}

Hmph, we are not releasing ps_matched or transaction and nothing is
leaking (the on-stack variables do hold references to these
resources).  I do not see much point in releasing orig_index_path
here.

> @@ -598,9 +611,35 @@ int cmd_add(int argc,
>  	odb_transaction_commit(transaction);
>  
>  finish:
> -	if (write_locked_index(repo->index, &lock_file,
> -			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> -		die(_("unable to write new index file"));
> +	if (run_pre_add && repo->index->cache_changed) {
> +		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +
> +		if (write_locked_index(repo->index, &lock_file,
> +				SKIP_INDEX_CHANGE_HOOK))
> +			die(_("unable to write proposed index"));

As we _may_ allow the pre-add hook to reject it, we do not know if
the index has changed.  So delaying the post-index-change hook until
we know for sure that we will commit to the index change does make
perfect sense.

> +		strvec_push(&opt.args, orig_index_path);
> +		strvec_push(&opt.args, get_lock_file_path(&lock_file));
> +		if (run_hooks_opt(repo, "pre-add", &opt)) {
> +			rollback_lock_file(&lock_file); /* hook rejected */
> +			exit_status = 1;

And then we ask the new hook, which may reject the update, in which
case we leave here.  Otherwise ...

> +		} else if (commit_lock_file(&lock_file)) {
> +			die(_("unable to write new index file"));
> +		} else {

... we commit the index file to the final place and then invoke the
post-index-change hook ourselves, as we told write_locked_index()
not to do that earlier.  Makes sense.

> +			run_hooks_l(repo, "post-index-change",
> +				    repo->index->updated_workdir ? "1" : "0",
> +				    repo->index->updated_skipworktree ? "1" : "0",
> +				    NULL);
> +		}
> +		repo->index->updated_workdir = 0;
> +		repo->index->updated_skipworktree = 0;

Doesn't these two belong to the "run post-index-change hook" block?
I think all the contents in the final "else {}" block that you
copied from do_write_locked_index() should be refactored into a
small helper function and called from here and also from
do_write_locked_index().  Otherwise, you'll be forced to maintain
the details of what needs to happen when running "post-index-change"
at multiple places and they must be kept in sync.

> +	} else {
> +		if (write_locked_index(repo->index, &lock_file,
> +				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> +			die(_("unable to write new index file"));
> +	}
> +
> +	free(orig_index_path);
>  
>  	free(ps_matched);
>  	dir_clear(&dir);
