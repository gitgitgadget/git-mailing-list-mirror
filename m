Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BE3CB2DB
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422219; cv=none; b=PIZX3s/uoZzFrG/eZzYdr4ipNRxfey+dJWBzL0LCje/jhV/VEUDIP9xDmqjxAdFREWETWTQTtZoRi5H/Adzqr86bKojDS5tS8KitD6wB4C8iC4l5g1lTd6QceEvSd8UHp5+TMX+C/WubuzKGid5+7K4IEuQgpTPQrJm+Cwh62zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422219; c=relaxed/simple;
	bh=M42JnpT22AOGyFNBXVk2ZuZtDVMoPje2RRwnztyOB74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BMeHBt6KAeONxLIwOGVQVoS5v6V1R9E3XqGpxANoO7rRgaCmz2OsAxvQ1SLR8MqBkB9SZgkCo2UJVNEwtlOwdll1bYLrbIQM1hiF+jqj5KM5oUYAlXSB6T4nczg/HPtqZAJ9IR+Qner8Z9T9+xtPKsQInzP73GiqteUT9TX32rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iuBkWKHD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDw1DsSR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iuBkWKHD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDw1DsSR"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 16140EC0551;
	Fri, 13 Mar 2026 13:16:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 13 Mar 2026 13:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773422216; x=1773508616; bh=/w6zZdzQXm
	8ihf2qePCmyzOpDgTNEddRE9UXGNypa4g=; b=iuBkWKHDj8eadANu4JztOrvrfZ
	Jb1KF6hrUrsgJKkOr1UF/QEhJV24d8mycf2cJPbydr8jus6+orHTl9JS559g9IzS
	esCt6TYgwJ7ny6lI2gzPVESiEXA/wUmSTkh7gbT7QKNHPcOAHmTRytsrzXC/RK8J
	LfKUROnia85F3Y7yeJSUEa3Oah3jTL2s+5/cAEjusCslgE4VeKuCaqjTtTilmfcs
	agJfKHSOKwDQ7vugeOI9h2lVD+mWLlp3uIhERJTxMC+XYICahy+TsgtgK+t+CXg5
	ZrS8d0MUdSTm2P7baro4W8ugZ/zLkU7xf6PJzfhlucM0xBxiJK9DnZxkD/aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773422216; x=1773508616; bh=/w6zZdzQXm8ihf2qePCmyzOpDgTNEddRE9U
	XGNypa4g=; b=hDw1DsSR44Uz6mB6/c+7IwC+fXutuzv/+U4SkMI/KlsE+2/detr
	yPu4m1nVGveUQ/NTMnvhpgWZaF58ZvcoQCwGxrCBAfIofBqWRxHPDGqnWOE/ZkVq
	537Up8h800NsP6H945fnd3rU6PIh3NobQu0SujugXvYntrBLg6Em6qKJTvCvBO4g
	Yau208a2681mBXFJtgnDwuY3KVtPUHqfEtNbGeF+RoXxXVuN7Ysytdu1d5N36dBS
	FcpeuqpBYlKLF4oeRMMhsfl6Iv2niX20p9wmvb2BAF3yMlwWn7Miz32+BYKlOYrx
	Ir2/B/6PE4XfCiwWJKZQ8bixMENULj5mACw==
X-ME-Sender: <xms:h0a0aQCaGI8WNXH7wlpupcxhMctwIj8-SJ4ORGc6z4-oiGmlaMGeNQ>
    <xme:h0a0aZhSBGN47XD-EC5EQx_tem1i5tq8g8bOXzhIKoYheSA6Jb90IHNnXnSOMEmj3
    Cesi9-C-QERGWH9BBZqBaHayJpMrNCiZfHALptWJ-ReK0loszqq>
X-ME-Received: <xmr:h0a0aYnIFW2XjHOTvpIsBzngxwWydqfA488rgIcU-XrTbvpsVt1PPjxIF10A_7ZfgzovlaaU0Bhjw57qQLTJ_8pDdZGZsIxKVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:h0a0aVqG3YlOBIaHTYFhv6wRrhNNgC4nGaUjnrq4_Y-2JeDtmhrV_w>
    <xmx:h0a0aRFGQE6fjRBMT8kSjeb6DFJx8rYwVCHvopGWMoIkrfnM1GWvmQ>
    <xmx:h0a0aRxpk7QhyIR4Be1tihs_isDNoKZJVhGVs-0eCJZwgqdbXDF7qg>
    <xmx:h0a0aWr87Qj0pU64H70XnxBmKixNEb8GLkaHUGD0Y5dgq82LwkL2lg>
    <xmx:iEa0aQGUbEEF8ME5YFQfDeZxllpaPUh_9Ez_yGW9NRN11j-BIzG8c0VD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 13:16:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] checkout: add --autostash option for branch switching
In-Reply-To: <pull.2234.v3.git.git.1773393818235.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 13 Mar 2026
	09:23:38 +0000")
References: <pull.2234.v2.git.git.1773344022931.gitgitgadget@gmail.com>
	<pull.2234.v3.git.git.1773393818235.gitgitgadget@gmail.com>
Date: Fri, 13 Mar 2026 10:16:54 -0700
Message-ID: <xmqqv7ez6455.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> When switching branches, local modifications in the working tree can
> prevent the checkout from succeeding.  While "git rebase" and "git
> merge" already support --autostash to handle this case automatically,
> "git checkout" and "git switch" require users to manually stash and
> unstash their changes.
>
> Teach "git checkout" and "git switch" to accept --autostash and
> --no-autostash options that automatically create a temporary stash
> entry before the branch switch begins and apply it after the switch
> completes.  If the stash application results in conflicts, the stash
> entry is saved to the stash list so the user can resolve them later.
>
> Also add a checkout.autoStash configuration option that enables this
> behavior by default, which can be overridden with --no-autostash on
> the command line.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     checkout: 'autostash' for branch switching

Almost all of the above is now stale, as we no longer call this the
"autostash" feature.  It turned into a project to vastly improve the
"checkout --merge" option, so the proposed log message needs to be
revamped to match.

Using the autostash mechanism to simplify checkout.c is a great
direction, I think, provided we can maintain the high-quality
conflict information (branch labels) that users expect from '-m'.

For a new iteration that invalidates almost everything from the
previous round, it is easier if range-diff were omitted from the
reviewers' point of view (I am not a GGG user, so I do not know if
there is such an option to do so).  It is not a huge deal as we can
simply ignore the large block of lines as irrelevant ;-)

>  Documentation/git-checkout.adoc |  50 +++++-----
>  Documentation/git-switch.adoc   |  26 ++---
>  builtin/checkout.c              | 160 +++++++++++++++---------------
>  sequencer.c                     |   2 +-
>  t/t7201-co.sh                   | 170 +++++++++++++++++++++++++++++++-
>  xdiff-interface.c               |  12 +++
>  xdiff-interface.h               |   1 +
>  7 files changed, 293 insertions(+), 128 deletions(-)
>
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index 43ccf47cf6..1e8adf6ef3 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -251,20 +251,17 @@ working tree, by copying them from elsewhere, extracting a tarball, etc.
>  	are different between the current branch and the branch to
>  	which you are switching, the command refuses to switch
>  	branches in order to preserve your modifications in context.
> +	With this option, the conflicting local changes are
> +	automatically stashed before the switch and reapplied
> +	afterwards.  If the local changes do not overlap with the
> +	differences between branches, the switch proceeds without
> +	stashing.  If reapplying the stash results in conflicts, the
> +	entry is saved to the stash list so you can use `git stash
> +	pop` to recover and `git stash drop` when done.

Great.

> -+
> -When switching branches with `--merge`, staged changes may be lost.

Hmph, I have to admit that I never do "checkout" to go to a different
branch with a dirty index that does not match the current HEAD, with
or without "--merge"; in fact, not just "I never do" myself, I never
thought about what happens when somebody does so, so I do not offhand
know what the current code without this patch does, or what the updated
code would.  In "stash && switch && unstash" flow, the last "unstash"
is what decides if the original changes in the index is reapplied to
the index or not, IIRC, so we still may lose the distinction between
what has been and what has not been added to the index after all,
depending on the way how the new code does the "unstash" step.

> @@ -578,39 +575,36 @@ $ git checkout mytopic
>  error: You have local changes to 'frotz'; not switching branches.
>  ------------
>  
> -You can give the `-m` flag to the command, which would try a
> -three-way merge:
> +You can give the `-m` flag to the command, which would save the local
> +changes in a stash entry and reset the working tree to allow switching:
>  
>  ------------
>  $ git checkout -m mytopic
> -Auto-merging frotz
> +Created autostash: 7a9afa3
> +Applied autostash.
>  ------------
>  
> -After this three-way merge, the local modifications are _not_
> +After the switch, the local modifications are reapplied and are _not_
>  registered in your index file, so `git diff` would show you what
>  changes you made since the tip of the new branch.

OK.

>  === 3. Merge conflict
>  
> -When a merge conflict happens during switching branches with
> -the `-m` option, you would see something like this:
> +When the locally modified files overlap with files that need to be
> +updated by the branch switch, the changes are stashed and reapplied
> +after the switch.  If the stash application results in conflicts,

In the original text of this third example (and as I understand,
these examples are written to be read more-or-less independently),
the `-m` option was explicitly mentioned to make it clear that this
"conflict" situation is relevant only when the option is used.  In
the updated text, it is not.  We should mention `-m` somewhere in
the updated text as well: When the `--merge` (`-m`) option is in
effect, _this_ happens.

> +they are not resolved and the stash is saved to the stash list:
>  
>  ------------
>  $ git checkout -m mytopic
> -Auto-merging frotz
> -ERROR: Merge conflict in frotz
> -fatal: merge program failed
> +Created autostash: 7a9afa3
> +Applying autostash resulted in conflicts.
> +Your changes are safe in the stash.
> +You can run "git stash pop" or "git stash drop" at any time.
>  ------------

Nice.  It may probably be on a bit too verbose side, though.  The
fact we are creating a stash entry or the object name of it is not
interesting to the user unless there is a conflict, so I would have
thought we would not say "Created autostash" at all, and the last
three lines would be replaced with something like the following
and shown _only_ when the application of the stashed changes did not
succeed cleanly:

    Your local changes are stashed, however, applying it to carry
    forward your local changes resulted in conflicts:

     - You can try resolving them now.  If you resolved them
       successfully, discard the stash entry with "git stash drop".

     - Alternatively you can "git reset --hard" if you do not want
       to deal with them right now, and later "git stash pop" to
       recover your local changes.

> -At this point, `git diff` shows the changes cleanly merged as in
> -the previous example, as well as the changes in the conflicted
> -files.  Edit and resolve the conflict and mark it resolved with
> -`git add` as usual:
> -
> -------------
> -$ edit frotz
> -$ git add frotz
> -------------

After resolving and adding, they need to do "git stash drop" it, but
other than that, this part of the example is still valid, isn't it?

The improvement this patch brings in is that the user now has
another choice, i.e.,

    Instead of editing and resolving the conflicts right now, you
    can clear the slate with `git reset --hard` and resurrect the
    local changes, safely stored in the stash at your leisure, with
    `git stash pop`.

> +At this point, `git stash pop` can be used to recover and resolve
> +the conflicts, and `git stash drop` to discard the stash when done.

This is not giving a wrong instruction per-se, but my suggestion
above can be used to extend it if we wanted to.  It may make it
easier to understand to the readers, or it may make it way too
verbose.  I dunno.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 1d1667fa4c..d3b3b815a7 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -17,7 +17,6 @@
>  #include "merge-ll.h"
>  #include "lockfile.h"
>  #include "mem-pool.h"
> -#include "merge-ort-wrappers.h"
>  #include "object-file.h"
>  #include "object-name.h"
>  #include "odb.h"
> @@ -30,6 +29,7 @@
>  #include "repo-settings.h"
>  #include "resolve-undo.h"
>  #include "revision.h"
> +#include "sequencer.h"
>  #include "setup.h"
>  #include "submodule.h"
>  #include "symlinks.h"
> @@ -845,83 +845,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  
>  		ret = unpack_trees(2, trees, &topts);
>  		clear_unpack_trees_porcelain(&topts);
> -		if (ret == -1) {
> -			/*
> -			 * Unpack couldn't do a trivial merge; either
> -			 * give up or do a real merge, depending on
> -			 * whether the merge flag was used.
> -			 */
> -...
> -		}
> +		if (ret == -1)
> +			return 1;
>  	}

So pleased to see so much custom code getting removed ;-).

> diff --git a/sequencer.c b/sequencer.c
> index aafd0bc959..72f0afe609 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4677,7 +4677,7 @@ static void create_autostash_internal(struct repository *r,
>  					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
>  		}
>  
> -		printf(_("Created autostash: %s\n"), buf.buf);
> +		fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
>  		if (reset_head(r, &ropts) < 0)
>  			die(_("could not reset --hard"));
>  		discard_index(r->index);

Is this change something all the callers that passes control through
this part desire?  Don't some of them want the output go to the
standard output, not standard error?

If we are going in the direction I suggested above (i.e., be silent
about our use of stashes before it becomes relevant to the user),
this part may have to become a conditional

	if (!silent)
		printf(_("Created autostash: %s\n"), buf.buf);

or something, where all the current callers before the "checkout
--merge" adds a new caller would pass silent==0 to.

Whatever changes this function needs, it looks more like a separate
preparatory patch to me.

> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 9bcf7c0b40..9ace3962ba 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -171,14 +171,14 @@ test_expect_success 'format of merge conflict from checkout -m' '
>  	test_cmp expect current &&
>  
>  	cat <<-EOF >expect &&
> -	<<<<<<< simple
> +	<<<<<<< Updated upstream
>  	a
>  	c
>  	e
>  	=======
>  	b
>  	d
> -	>>>>>>> local
> +	>>>>>>> Stashed changes
>  	EOF
>  	test_cmp expect two
>  '

Historically, 'git checkout -m' provided the branch names (e.g.,
"<<<<<<< simple"), which is very helpful context.  It would be great
if we could find a way to pass the branch names through as labels to
the stash application.  It may require a preparatory change to "git
stash apply" to allow customizing the labels---the underlying
machinery at the lowest level does have ability to use labels the
callers want it to use, so it may be just the matter of plumbing it
through the callchain.  I didn't check.

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index f043330f2a..5ee2b96d0a 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -325,6 +325,18 @@ int parse_conflict_style_name(const char *value)
>  		return -1;
>  }
>  
> +const char *conflict_style_name(int style)
> +{
> +	switch (style) {
> +	case XDL_MERGE_DIFF3:
> +		return "diff3";
> +	case XDL_MERGE_ZEALOUS_DIFF3:
> +		return "zdiff3";
> +	default:
> +		return "merge";
> +	}
> +}
> +
>  int git_xmerge_style = -1;
>  
>  int git_xmerge_config(const char *var, const char *value,
> diff --git a/xdiff-interface.h b/xdiff-interface.h
> index fbc4ceec40..ce54e1c0e0 100644
> --- a/xdiff-interface.h
> +++ b/xdiff-interface.h
> @@ -55,6 +55,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
>  void xdiff_clear_find_func(xdemitconf_t *xecfg);
>  struct config_context;
>  int parse_conflict_style_name(const char *value);
> +const char *conflict_style_name(int style);
>  int git_xmerge_config(const char *var, const char *value,
>  		      const struct config_context *ctx, void *cb);
>  extern int git_xmerge_style;

This may be a useful addition, but it would probably need to become
a separate preparatory patch, possibly with its own test.

