Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199B1C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 04:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKPEjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 23:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiKPEjS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 23:39:18 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47030F6F
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 20:39:16 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a15so20293863ljb.7
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 20:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJq5pnX/ECi+A3Zng3fOa2iJPNf5RGs4GhjqzpvyIvk=;
        b=ex1HpxYFAiDz0dDGc2jiHUVfMs+SaQgtQ1Ay3X13XgmipUqbiQFLzRUXGEQ+OZRs62
         +IsevDitJgaN2uMusQ81SolOTi4zP/UxVSameqoJZqjPll95DejuJjs/SkTioy4qIqS/
         qQV6Rl9gyel/l6FwTdQhuC2k9+Apn+tiUIdl7Blc+9tlk8o4j2OK7R4btPgctmP4iIT1
         CzrykjQNBzVyZWFrvZZ2ODcnpZ1Dj/UiB/m2ySFHpagT9d76gU7FuLwbkhqPgGh1knzL
         At8BzsTzBQa9+jVUM3B+tc5ly6ZzlBD5o758oOi6oPKTMj0QKSwk4TpAylZhTWb6NE0J
         6Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJq5pnX/ECi+A3Zng3fOa2iJPNf5RGs4GhjqzpvyIvk=;
        b=3sR9ZyNOq5AALsJupBFR+pp3jA3JLV+n6Bxwh2+R4MKAbOxJnRO83Kt4JyQseJ9qpt
         bCoFams3EMKSlSQ72FD0Dmj3UnazSX3jFwGfb4eme7ZL4/HU49WrwuNke6ZuH6wX63Lw
         807B+QaF4iN25gUpPCNPs8jlXrKnjTSLvcwMZtdppWw0IEp2jfcCCXizdZvYHzkNCq+C
         5npqmTEUXHvXWAlKZU6UqpICdc6XtlPAp7F3LkPxxRYhgwhZ6g3eEbLbPCRK531AuTEl
         gbU+1alZPQdCg/6rh5bAd8vaqU0FeKTZ7V5Sv/sQ8GfU6k7Fxje6aYF8imLRagWEAmAp
         y9Pw==
X-Gm-Message-State: ANoB5pkMD4SDjw0+i1cgwypQQskri7FCqE4NxnmSeOSTXOjzuRd3epxJ
        XLe/bqMzxYyUqcbxHdFRhbT0kL3/k3cEoDZYouii8lre
X-Google-Smtp-Source: AA0mqf7Of04NJt/yI3FCpHRYaaVE21I2TxaLY3N8s/Xrz+9ybaP5ZffQ/QkOpcpw0RGoOoK6vkBztE6tgR85JO5dnv8=
X-Received: by 2002:a05:651c:238a:b0:277:f7d:107f with SMTP id
 bk10-20020a05651c238a00b002770f7d107fmr7896144ljb.167.1668573554951; Tue, 15
 Nov 2022 20:39:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <f3345a9e-e7f1-4230-d30a-0608eb69513d@github.com>
In-Reply-To: <f3345a9e-e7f1-4230-d30a-0608eb69513d@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Nov 2022 20:39:02 -0800
Message-ID: <CABPp-BGHMsMxP6e7p0HAZA=ugk+GY3XW6_EaTN=HzaLQYAzQYA@mail.gmail.com>
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout directions
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2022 at 12:44 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> It also is a highly-requested document. Thank you for working so hard on
> it and sorry for being slow to sign off on your edits since v1.
>
> Today, I'm rereading the whole document anew, but I'll avoid any nits
> since I think you are converging on a solid foundation for us to build on.

Thanks for reading it over!

And sorry for my delay in responding; my Git time has been sadly
limited as of late.

> Mostly, if you asked a question in the doc, I'll reply. Nothing is binding
> since the point is to ask the question in the context of the problem
> statement and examples. We should remember to update this document when we
> actually implement the options, so the decisions are documented here
> instead of leaving answered questions lingering.

Yes, I think this sounds good.

> > +  * Do the options --scope={sparse,all} sound good to others?  Are there better
> > +    options?
> > +    * Names in use, or appearing in patches, or previously suggested:
> > +      * --sparse/--dense
> > +      * --ignore-skip-worktree-bits
> > +      * --ignore-skip-worktree-entries
> > +      * --ignore-sparsity
> > +      * --[no-]restrict-to-sparse-paths
> > +      * --full-tree/--sparse-tree
> > +      * --[no-]restrict
> > +      * --scope={sparse,all}
> > +      * --focus/--unfocus
> > +      * --limit/--unlimited
>
> I'm partial to --scope={sparse|all} (with the option to add another
> value if we see the need).
>
> > +  * If a config option is added (sparse.scope?) what should the values and
> > +    description be?  "sparse" (behavior A), "worktree-sparse-history-dense"
> > +    (behavior B), "dense" (behavior C)?  There's a risk of confusion,
> > +    because even for Behaviors A and B we want some commands to be
> > +    full-tree and others to operate sparsely, so the wording may need to be
> > +    more tied to the usecases and somehow explain that.  Also, right now,
> > +    the primary difference we are focusing is just the history-querying
> > +    commands (log/diff/grep).  Previous config suggestion here: [13]
>
> Personally, I think we should have the same values for 'sparse.scope' and
> '--scope=<X>'. For now, let's pick one behavior for the 'sparse' value and
> we can add a new value to differentiate between A and B when necessary in
> the future.

I think this is untenable.  For example, under behavior B:

   * default to --scope=all: diff REV, grep REV, log, etc.
   * default to --scope=sparse: restore, add, diff [without REV or
--cached], etc.

So sparse.scope=all would not yield behavior B.  In fact, there'd be
no way to behavior B since it is inherently a mix of different types
of scopes, as reflected in its "oversimplified" description:

   "Restrict worktree operations to sparse specification; have any
history operations work across all files"

I think it'd *also* potentially set us up for problems under behavior
A.  Behavior A is roughly thought of as --scope=sparse for everything,
but some commands ignore the sparse specification entirely -- commit,
fast-export, bundle, stash, apply, etc.  Perhaps those other
subcommands just never take a --scope option, and thus we have no
issues.  But what if someone asks for a feature where they want to
just apply a subset of the patch with "stash pop" or "apply", and
particularly the subset overlapping with the sparse specification?  Or
perhaps a user wants to do a fast-export of a subset of the repository
-- which they can already do by specifying paths already on the
command line -- but they don't want to have to type all the paths and
want a simple flag for limiting to the sparse specification?  If so,
--scope=sparse is a pretty clear flag that could be used.  But then
we'd have the problem that:

   * default to --scope=all: commit, fast-export, bundle, stash,
apply, and a few others
   * default to --scope=sparse: pretty much everything else

If any of the full-tree commands ever morphs in this direction, then
sparse.scope=sparse would *not* yield behavior A, and there'd be no
way to get it, because behavior A would also be a mix of different
types of scopes.

Personally, I can't imagine that either having --scope=sparse or
--scope=all be the default for all commands would even be a useful
mode for anyone.  So, I think the values of scope.sparse should not be
either "sparse" or "all".

> > +  * Is `--no-expand` a good alias for ls-files's `--sparse` option?
> > +    (`--sparse` does not map to either `--scope=sparse` or `--scope=all`,
> > +    because in non-cone mode it does nothing and in cone-mode it shows the
> > +    sparse directory entries which are technically outside the sparse
> > +    specification)
> > +
> > +  * Under Behavior A:
> > +    * Does ls-files' `--no-expand` override the default `--scope=all`, or
> > +      does it need an extra flag?
> > +    * Does ls-files' `-t` option imply `--scope=all`?
> > +    * Does update-index's `--[no-]skip-worktree` option imply `--scope=all`?
>
> Since the --no-expand option is rather new, and we have a big experimental
> banner on the sparse-checkout documentation, it might be good to plan for
> a deprecation of these non-standard options. We could start by making them
> aliases for the --scope=sparse option, but with a warning that the option
> is deprecated and we will _remove_ the option in a future version. We can
> document here which versions we expect those removals to happen.

I do agree that elsewhere aliasing flags to --scope=sparse makes sense.

But that's not applicable here.  `--no-expand` does not exist yet; it
was suggested as a rename for `--sparse` because ls-files' `--sparse`
option cannot be mapped to either --scope=sparse or --scope=all (nor
any other --scope= option we thought of).  The reason for a different
name was specifically that this option name didn't fit the mold and we
know of no analogous options anywhere.  --scope=sparse means only show
the non-SKIP_WORKTREE entries (which would exclude the sparse
directories and everything under them), while --scope=all means show
all the files (without the directories).  This option, in contrast,
means to show the non-SKIP_WORKTREE file entries plus the
SKIP_WORKTREE directory entries.

> > +  * sparse-checkout: once behavior A is fully implemented, should we take
> > +    an interim measure to ease people into switching the default?  Namely,
> > +    if folks are not already in a sparse checkout, then require
> > +    `sparse-checkout init/set` to take a
> > +    `--set-scope=(sparse|worktree-sparse-history-dense|dense)` flag (which
> > +    would set sparse.scope according to the setting given), and throw an
> > +    error if the flag is not provided?  That error would be a great place
> > +    to warn folks that the default may change in the future, and get them
> > +    used to specifying what they want so that the eventual default switch
> > +    is seamless for them.
>
> I'm not sure that we need a warning here. I think picking an initial default
> is good enough. Let's reconsider this warning after we have more implementation
> changes that provide a choice between behaviors A and B.
>
> > +=== Implementation Goals/Plans ===
> > +
> > + * Get buy-in on this document in general.
>
> Consider me bought-in.

Wahoo!

> > + * Figure out answers to the 'Implementation Questions' sections (above)
> > +
> > + * Fix bugs in the 'Known bugs' section (below)
> > +
> > + * Provide some kind of method for backfilling the blobs within the sparse
> > +   specification in a partial clone
> > +
> > + [Below here is kind of spitballing since the first two haven't been resolved]
>
> We can update this document as we gain clarity after the first few updates.
>
> > + * update-index: flip the default to --no-ignore-skip-worktree-entries,
> > +   nuke this stupid "Oh, there's a bug?  Let me add a flag to let users
> > +   request that they not trigger this bug." flag
> > +
> > + * Flags & Config
> > +   * Make `--sparse` in add/rm/mv a deprecated alias for `--scope=all`
>
> This '--sparse' deprecation can eventually be a removal, I think.

Sounds fair.  Should I clarify that in the document as well?

> > +   * Make `--ignore-skip-worktree-bits` in checkout-index/checkout/restore
> > +     a deprecated aliases for `--scope=all`
>
> This one might be harder to remove since it's much older. We can consider
> it, though.

Yeah, if we end up with deprecated-but-kept-around, that's fine so
long as we recommend the new flag over the old one.

> > +   * Create config option (sparse.scope?), tie it to the "Cliff notes"
> > +     overview
>
> Implementation detail: it might be nice to create a parse-opt macro that
> will read the '--scope={sparse|all}' command-line option but _also_
> create a method to initialize the value to the 'sparse.scope' config
> option. These can both happen with the very first implementation of the
> command-line option and all future integrations can follow that pattern to
> get both options.

I'm not sure how this could work, since `sparse.scope` should not use
the values {sparse,all}, and the correct default scope is
command-dependent for both behavior B and behavior A.

> Thanks for working so hard on this doc. I think this version is ready to
> merge down. Let's get started on this work. I'm excited!

:-)
