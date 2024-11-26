Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E601CD2C
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640587; cv=none; b=WG083smGOJQJRF7kkpSWtyQCwXHF7VLdAS2KFuYvc5hi6oKqRVGwSpwpdmhk8jdJcVsxrNjf1grrnqWhpgvydwEbfxWa5bp9zmQM13OAThFil9lpuBJX8WdHX+8FaVV/fGClO8/vIV5s7d8KGXd8n+6chkVVy1/ENtUophxaxcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640587; c=relaxed/simple;
	bh=bkp3nw5cR2r7hRVxmM4AC3iYi4PD8rqR0CfSENo3GXw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6TGFT3YCNxpU0fEb5CO+tImA5mmDy3BjhTNBiLZscCKuZn2Z7RafrDTdWbIJ4SVbo8mcqfKXEoWnDtzXe/qRDS4jPhH/rfJc+dQrpktEz2Uv+qyRghOQ1tSnt9C5Y6dbS3LJTb2EfNWlUSlspnrKKpoAcABwSDz9+Vc7sM230Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mnSqKgxv; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mnSqKgxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732640577; x=1732899777;
	bh=F4XOxzHdldQhJ8tA4zW8sblCWZTzItX75YWGlUR/jQQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mnSqKgxvOFzRT/W1sBKyWH5LZwXSzH81AbvcGak5qndTXUoiNjRBfTFBZLB+Vp4KK
	 R0D1l13HLHeZbB4TZas1wE0sEhlTXZWM/gMAzkNZrC7UROSiDk6VtP0F5QNuMcY7/v
	 Du3VuYGz7wky4GbBf11uA6XWOfHvXzpIVfrWpjzyk9Yb5IUqygPMDbHyMgYhbuyQyL
	 OVf6Q7Yo2y2maKXMO7JZuw1DpdVYArSzR1sjjsfdZoHdmAi7KddG+xWHQ40URDEooG
	 e4TYr1ZeMbETBfoxYa3s2uL4aQgdww30jvrHXoDJl6MndgX6r4HLsgo5h1vMzD1VdI
	 GZbDpXqzM+BbQ==
Date: Tue, 26 Nov 2024 17:02:42 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/8] Allow relative worktree linking to be configured by the user
Message-ID: <D5W9TF80TCN0.19T8NJTHY4VGW@pm.me>
In-Reply-To: <xmqqv7wazfex.fsf@gitster.g>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me> <xmqqv7wazfex.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: d20992b0a5fedecc5d23141c6cb427fdd188015e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Nov 26, 2024 at 12:18 AM CST, Junio C Hamano wrote:
> Caleb White <cdwhite3@pm.me> writes:
>> Changes in v5:
>> - Added docs to `--relative-paths` option.
>
> You already had doc on this, but the default was not described at
> all.
>
>  --[no-]relative-paths::
> +       Link worktrees using relative paths or absolute paths (default).

I added a bit more explanation instead of just directing the user to the
config variable (I originally had docs, but it was requested that
I remove the duplication and just point to the config, however, I think
the changes describes it a bit better as well as gives the default).

>> - Added test coverage for `repair_worktrees()` and relative paths.
>> - Move `strbuf_reset` call in `infer_backlink()`.
>
> This was more like "revert the change in v4 that moved it
> unnecessarily", no?

Yes, that is correct.

>> - Cleaned up tests.
>
> Yup, there truely a lot of test changes between v4 and v5.  Many
> tests now use existing test helpers, which is good.

This is the majority of the reroll. It seems like MacOS doesn't like the=20
`test_config` helper inside of a subshell, so I had to stick with `git
config` in those cases.

>> - Slight stylistic changes.
>
> I saw many changes like these (the diff is between v4 and v5)
>
>  static void repair_gitfile(struct worktree *wt,
> -                          worktree_repair_fn fn,
> -                          void *cb_data,
> +                          worktree_repair_fn fn, void *cb_data,
>                            int use_relative_paths)
>
> which looked good (the original had fn and cb_data defined on the
> same line).

Yes, this was brought up in the previous review and I decided to make
the change.

>> - Tweaked commit messages.
>
> Updates to the proposed log message for `repair` step [7/8] did not
> really "clarify", other than helping readers to see how messy things
> are.  It said:
>
>     +    To simplify things, both linking files are written when one of t=
he files
>     +    needs to be repaired. In some cases, this fixes the other file b=
efore it
>     +    is checked, in other cases this results in a correct file being =
written
>     +    with the same contents.
>
> which may describe what the code happens to do correctly, but does
> not quite help building the confidence in what it does is correct.
>
> Suppose that the directory X has a repository, and the repository
> thinks that the directory W is its worktree.  But the worktree at
> the directory W thinks that its repository is not X but Y, and there
> indeed is a repository at the directory Y.  That repository thinks W
> belongs to it.

That's a bit of a confusing scenario, but I think this is what you're
trying to describe:

    Repository X ----> Worktree W <---> Repository Y (Case 0)

which is not a normal case (but I'll get to that later).
Most of the time, a repair would be performed with one of the following
cases:

    Repository X <---> Worktree W (Case 1)
    Repository X ----> Worktree W (Case 2)
    Repository X <---- Worktree W (Case 3)
    Repository X       Worktree W (Case 4)

that is, a repository and worktree have valid links, have valid links in
one direction or the other, or they have no valid links at all.

Before I go on, I think it would be helpful to revisit how the repair
operation works. There are two loops in the repair operation:
1. the `repair()` function iterates over (via `repair_worktree_at_path()`)
   the given worktrees/paths (or `.` if no paths are given) to potentially
   repair the `<repo>/.git/worktrees/<worktree_id>/gitdir` files
2. the `repair_worktrees()` function iterates over all the worktrees
   defined at `<repo>/.git/worktrees/*` to potentially repair the
   `.../<worktree_id>/.git` files

In Loop 1, a repair is performed if:
- there's an absolute/relative path mismatch
- the worktree `.git` file points to the repository, but the repository
  `gitdir` file is unreadable or does not point back to the worktree
- the worktree `.git` file does NOT point to the repository, but an
  inferred backlink can be established (the worktree id in the `.git`
  file matches a worktree id in the repository's `worktrees` directory),
  and that inferred repository does not point to the worktree

In Loop 2, a repair is performed if:
- there's an absolute/relative path mismatch
- the worktree pointed to by the repository `gitdir` file does not point
  back to the repository or the file is corrupted

Now back to Cases 1--4:
- In Case 1, the repair would not update any links (already valid).
- Case 2 is most likely when using absolute paths and the repository is
  moved, but the worktree is not. The worktree `.git` will be updated
  during Loop 2, however, now the repository `gitdir` file will also be
  written with the same contents (a no-op) to keep the code simple.
- Case 3 is most likely when using absolute paths and the worktree is
  moved, but the repository is not. The repository `gitdir` will be
  updated during Loop 1, however, now the worktree `.git` file will also
  be written with the same contents (a no-op) to keep the code simple.
- Case 4 can occur when using absolute paths and both the repository and
  worktree are moved, but it can also occur when using relative paths and
  either the repository or worktree is moved. Both linking files need to
  be updated. In the past, the repository `gitdir` file would be updated
  during Loop 1 (from the inferred backlink), and the worktree `.git`
  would not be updated until Loop 2. However, now both linking files are
  updated during Loop 1 and the repair is complete by the time Loop 2
  is reached.

> If we examine X first, would we end up updating W to point at X
> (because X thinks W is its worktree)?
>
> Or do we make W to point at Y (because Y thinks W is its, and W
> thinks it is Y's)"?

A repair is always performed in the context of single repository,
therefore, if operating on repository X and the worktree W is found to
be a valid worktree for X, then yes, the repair would update the link
from W to X so that Case 0 would now look like:

    Repository X <---> Worktree W <---- Repository Y

but again, this is a very weird case---the most likely scenario that I
can think of is that a user copied a repository (with or without the
worktree). The `es/worktree-repair-copied` topic added support for
repairing a worktree from such a copy scenario. However, I did note[1,2]
that the topic added the ability for a repository to "take over" a
worktree from another repository if the worktree_id matched a worktree
inside the current repository. This can happen if two repositories use
the same worktree name (I usually name my worktrees the same name as the
branch to keep things simple so this can happen if two repositories
create a worktree for `master` for instance).

I recommended that worktrees be created with a unique hash/identifier so
that the worktree_id is unique across all repositories even if they have
the same name. I was planning on creating a future topic to address this,
for example creating a worktree `develop` would look like:

    foo/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-6b3d7b/
    =E2=94=94=E2=94=80=E2=94=80 develop/

The actual worktree directory name would still be `develop`, but the
worktree_id would be unique and prevent the "take over" scenario.

> Either way, I think the comment is trying to say that, if we decide
> to make X and W belong to each other, we'd overwrite links from X to
> W and also W to X, even though the link from X was already pointing
> at W and the minimum fix we needed to make was to update the link
> from W to point at X.  Overwriting a link from X to W with a new
> link from X to W is a no-op, so it does not seem to help greatly,
> since `repair` is not at all performance critical.  The correctness
> is a lot more important.

Yes, you understand this correctly. The repair operation is not
performance critical, so I decided to keep the code simple and just
always update both linking files. The same `write_worktree_linking_files()
is used for all operations (add, move, repair), some which require both
files to be updated, and others which only require one file to be updated.

>> - Updated base to 090d24e9af.
>
> This made it harder than necessary to compare the two iterations, by
> the way.

My apologies for that. I wasn't sure what the procedure was when
a dependent topic was merged to master. I figured it would be best to
rebase onto the latest master.

Best,

Caleb

[1]: https://lore.kernel.org/git/20241008153035.71178-1-cdwhite3@pm.me/
[2]: https://lore.kernel.org/git/r4zmcET41Skr_FMop47AKd7cms9E8bKPSvHuAUpnYa=
vzKEY6JybJta0_7GfuYB0q-gD-XNcvh5VDTfiT3qthGKjqhS1sbT4M2lUABynOz2Q=3D@pm.me/

