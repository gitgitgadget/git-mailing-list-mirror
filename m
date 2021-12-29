Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F42C4332F
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 09:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhL2JkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 04:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbhL2JkC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 04:40:02 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A5CC061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 01:40:02 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z9so14164469edm.10
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 01:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKPalQWHSnfcqrkbSVGRxMz+w07THhxF2UyU/Y+aXw4=;
        b=f2sqf58O1o3er+fSsSJLuLu4zJ2dTNr04H0hVQSz5nYialca3ooj8VZsFhHqcqZymW
         dYe8HZus0V4gXzPXixQYTEb5IcHNcINtfE3/FFUVQ39hGQFE5czxhfumTIv1LARtyLMK
         fn5JaUjpWiPX3C5XgXO2vHshtJSQ3kq7pQjwE0nlxS38cvBXeNQUHxnbxzOVMZt2KVnv
         FJiHPvy+t0+Zh04naSh+z8T99iTSdk25/qYCkJe1fYVhqQd7SQeN11uqUdb1jdjBLQBQ
         f2BoJolKV3esow2aCtvIthpDwhBHj5GbNIeF509J8chGQFmxnm683p2Zkiiy4KLqJjP4
         EP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKPalQWHSnfcqrkbSVGRxMz+w07THhxF2UyU/Y+aXw4=;
        b=y+HkIY4SK3RWjoqVYNHIA6tbseG6C7DQtoVXmfoxUtuA4/YYpmmbO55hbJJDk3qn1u
         hG0Gdlj2cNYqrso/LYQeXFMyraRvCVuykB5nprIvIuQlLFFg4t1Qy85pI+noedQiS/ef
         TOJ/SEFY83rdHlQT2Z+knfSBdR/wbHUBqRDUk6swOb+rrQzzpp9CqdJEI9b4oXZ+FmRj
         fogH4dNMCDMDKriDlpGFd3wbjvGssM3EV1MdjzjcqTPM+NeStUGUrAwMEwIZvEObGlus
         yL6Wt5arUOQT1GLwva/Fh9VszJhhUiYXpkj3RnlIfYDjSqNM9h0aPqv0/tsmQVxi0jZH
         kTOw==
X-Gm-Message-State: AOAM532RQSgh55spB4HrJKteyWEArfw57ye/J2ySi6oxc6OzKXcFvuYf
        EmNIdGMz5zNiEIwQxahwAOVSsBh24FvMHImVSmM=
X-Google-Smtp-Source: ABdhPJwSOiJpxcrZe4M+JL/xe3vYhAE+Aao7JAajdgk76DQUgCsRo7s6cJllmM4K/KipJOlpbJ5w1pf52Je9ZjlYY+0=
X-Received: by 2002:a17:907:160e:: with SMTP id hb14mr20035755ejc.328.1640770800320;
 Wed, 29 Dec 2021 01:40:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Dec 2021 01:39:48 -0800
Message-ID: <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 1:32 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series is based on a merge of en/sparse-checkout-set,
> en/worktree-chatty-to-stderr, and ds/sparse-checkout-malformed-pattern-fix.

I think you mean es/worktree-chatty-to-stderr (not 'en/')

> This patch series includes a fix to the bug reported by Sean Allred [1] and
> diagnosed by Eric Sunshine [2].
>
> The root cause is that 'git sparse-checkout init' writes to the worktree
> config without checking that core.bare might need to be set. This only
> matters when the base repository is bare, since creating the config.worktree
> file and enabling extensions.worktreeConfig will cause Git to treat the base
> repo's core.bare=false as important for this worktree.
>
> This series fixes this, but also puts in place some helpers to prevent this
> from happening in the future. While here, some of the config paths are
> modified to take a repository struct.
>
>  * 'git sparse-checkout' will now modify the worktree config, if enabled. It
>    will no longer auto-upgrade users into using worktree config.

This sounds dangerous to me.

>  * The new 'git worktree init-worktree-config' will upgrade users to using
>    worktree config. It will relocate core.bare and core.worktree if
>    necessary.

This sounds like giving users an extra step to unbreak themselves,
instead of just having the commands do it.  (And might risk also
breaking things in a different direction?  I'll have to read over the
patches to see...)

>  * 'git worktree add' will copy the sparse-checkout patterns from the
>    current worktree to the new one. If worktree config is enabled, then the
>    config settings from the current worktree are copied to the new
>    worktree's config file.

This sounds awesome.  Wahoo!  (core.worktree should be cleared,
though, and core.bare should either be cleared or set to false if
found in the worktree config.)

...
> Range-diff vs v2:
>
>  1:  889e69dc45d = 1:  749ba67d21e setup: use a repository when upgrading format
>  2:  3e01356815a = 2:  61b96937016 config: make some helpers repo-aware
>  3:  ed8e2a7b19d ! 3:  e2a0a458115 worktree: add upgrade_to_worktree_config()
...
>      @@ Commit message
>           Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>      - ## worktree.c ##
>      + ## Documentation/git-worktree.txt ##
>      +@@ Documentation/git-worktree.txt: SYNOPSIS
>      + --------
>      + [verse]
>      + 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
>      ++'git worktree init-worktree-config'
>      + 'git worktree list' [-v | --porcelain]
>      + 'git worktree lock' [--reason <string>] <worktree>
>      + 'git worktree move' <worktree> <new-path>
>      +@@ Documentation/git-worktree.txt: checked out in the new working tree, if it's not checked out anywhere
>      + else, otherwise the command will refuse to create the working tree (unless
>      + `--force` is used).
>      +
>      ++init-worktree-config::
>      ++
>      ++Initialize config settings to enable worktree-specific config settings.
>      ++This will set `core.repositoryFormatversion=1` and enable
>      ++`extensions.worktreeConfig`, which might cause some third-party tools from

s/cause/prevent/ ?

>      ++being able to operate on your repository. See CONFIGURATION FILE for more
>      ++details.

So, if users attempt to use `git worktree add` or `git sparse-checkout
{init,set}` without first running this, they can break other
worktrees.  And if they do run this new command, they potentially
break third-party tools or older git versions.

Yet, with the very common case (in fact, I'd go so far as to say the
nearly universal case) of having both core.bare=false and no
core.worktree set, we never had any such problems with the former
logic.  This seems like a serious regression to me.  I'll keep
reading.

...
>      +@@ Documentation/git-worktree.txt: versions will refuse to access repositories with this extension.
>      +
>      + Note that in this file, the exception for `core.bare` and `core.worktree`
>      + is gone. If they exist in `$GIT_DIR/config`, you must move
>      +-them to the `config.worktree` of the main working tree. You may also
>      +-take this opportunity to review and move other configuration that you
>      +-do not want to share to all working trees:
>      ++them to the `config.worktree` of the main working tree. These keys are
>      ++moved automatically when you use the `git worktree init-worktree-config`
>      ++command.
>      ++
>      ++You may also take this opportunity to review and move other configuration
>      ++that you do not want to share to all working trees:
>      +
>      +  - `core.worktree` and `core.bare` should never be shared

I'm fine with the wording, but technically core.bare=false is fine to
share, it's just core.bare=true that is not.  (And yes, I agree that
core.worktree is never safe to share)

...
>  5:  06457fafa78 ! 5:  b200819c1bb sparse-checkout: use repo_config_set_worktree_gently()
>      @@ Commit message
>           sparse-checkout: use repo_config_set_worktree_gently()
>
...
>      +    Let the sparse-checkout builtin use this helper instead of attempting to
>      +    initialize the worktree config on its own. This changes behavior of 'git
>      +    sparse-checkout set' in a few important ways:
>
>      -    The fix is to have this assignment into config.worktree be handled by
>      -    the repo_config_set_worktree_gently() helper.
>      +     1. Git will no longer upgrade the repository format and add the
>      +        worktree config extension. The user should run 'git worktree
>      +        init-worktree-config' to enable this feature.
>      +
>      +     2. If worktree config is disabled, then this command will set the
>      +        core.sparseCheckout (and possibly core.sparseCheckoutCone and
>      +        index.sparse) values in the common config file.

Yikes.

>      +     3. If the main worktree is bare, then this command will not put the
>      +        worktree in a broken state.
>      +
>      +    The main reason to use worktree-specific config for the sparse-checkout
>      +    builtin was to avoid enabling sparse-checkout patterns in one and
>      +    causing a loss of files in another. If a worktree does not have a
>      +    sparse-checkout patterns file, then the sparse-checkout logic will not
>      +    kick in on that worktree.
>      +
>      +    This new logic introduces a new user pattern that could lead to some
>      +    confusion. Suppose a user has not upgraded to worktree config and
>      +    follows these steps in order:
>      +
>      +     1. Enable sparse-checkout in a worktree.
>      +
>      +     2. Disable sparse-checkout in that worktree without deleting that
>      +        worktree's sparse-checkout file.
>      +
>      +     3. Enable sparse-checkout in another worktree.
>      +
>      +    After these steps, the first worktree will have sparse-checkout enabled
>      +    with whatever patterns exist. The worktree does not immediately have
>      +    those patterns applied, but a variety of Git commands would apply the
>      +    sparse-checkout patterns and update the worktree state to reflect those
>      +    patterns. This situation is likely very rare and the workaround is to

No, it's not even rare, let alone very rare.  I'd actually call it
common.  Since 'sparse-checkout disable' does not delete the
sparse-checkout file, and we've encouraged folks to use the
sparse-checkout command (or a wrapper thereof) instead of direct
editing of the sparse-checkout file (and indeed, the sparse-checkout
command will overwrite the sparse-checkout file which further
discourages users from feeling they own it), having the file left
around after disabling is the common case.  So, the only question is,
how often do users disable and re-enable sparse-checkout, and
potentially only do so in some of their worktrees?  At my $DAYJOB,
that's actually quite common.  I got multiple reports quite soon after
introducing our `sparsify` tool about users doing something like this;
this is what led me to learn of the extensions.worktreeConfig, and why
I pointed it out to you on your first submission of
git-sparse-checkout[1]
(https://lore.kernel.org/git/CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com/)

Some more details about sparse-checkouts at $DAYJOB:
  * We have numerous users who used to have their own small little
repos, and want to still have that experience.  sparse-checkouts were
a way to provide a small-repo feel for them, and in particular to
speed up IDEs that otherwise insist on indexing everything no matter
how much we try to tell them to only pay attention to part of the
files (and similar speed issues with the build system since gradle
configuration is so slow).  They want every worktree to be sparse and
never face the full repo.  I talk about these users the most, because
we've mostly satisfied the other users.
  * We have numerous users who work mostly on specific modules, but
occasionally do cross-cutting work.  They will have most worktrees be
sparse, but keep at least one that is full.  They may also undo
sparsity briefly and redo it in various worktrees.
  * We also have a few users who work primarily on cross-cutting
features and just keep the full checkout and ignore the
sparse-checkout stuff.
  * There is also a special tool, write-locks.sh or some name like
that, which must unsparsify, run something like `./gradle
--write-locks` and other stuff, and then re-sparsify.  The tool does
not work without the full worktree.  Now, not all users need to run
this, and in fact most users who do probably are the same ones that
"occasionally do cross-cutting work", but it's a little bit wider
group than that.  So we have additional unsparsify/resparsify steps,
and it's further complicated by the fact that users may not even know
that we do the unsparsification and resparsification behind the scenes
for them (our `sparsify` wrapper has a stash-like feature, though I
think only allowing for one on the stash, which is called behind the
scenes.)  The write-locks logic is super slow, which kind of hides the
otherwise slow unsparsify/resparsify steps.

(For each of the above type of users, we have many folks who don't use
worktrees, but they're not relevant to this discussion.)

We also have third party git tools, whether jgit (usually via gradle
plugins), whatever IDEs tend to use (eclipse used egit, not sure what
intellij or visual studio use), probably various special one-off
scripts that read a bit more git configuration than they should and do
various tasks, and a wide range of git versions in use (though any
given user will likely only use one git version, and we are perfectly
happy to specify a minimum version for sparse-checkout usage).


So that's the range of users for this discussion, but I think we also
need to flesh out the caveats of your change since you missed a few:
  * Even if users haven't sparsified/unsparsified/re-sparsified in
another worktree (i.e. they have a worktree that has always been
full), the sparse-checkout init/set in another worktree _still_ causes
problems because when users switch to the 'full' worktree,
contrib/completion/git-prompt.sh will report it as sparse.  Users are
going to get confused and report bugs just based on their prompt even
if it's technically a "dense" worktree.
  * The cone-mode and sparse-index are also shared between worktrees,
which may not present many problems for me right now at $DAYJOB, but
could be problematic for other users out there.

So, here's the experience I expect from these patches at $DAYJOB:
  (1) Several users per week hit the case of one worktree being
sparsified when it wasn't supposed to be.
  (2) These users have no idea how to figure out what they need to do
to fix it.  The init-worktree-config is no more discoverable than the
documentation on the official steps for enabling
extensions.worktreeConfig (See
https://lore.kernel.org/git/CABPp-BGKyDJV9DP+igmCC_Ad0jgvb4aOAYpXWCbx9hW8ShhDQg@mail.gmail.com/
up through the paragraph, "Further, it's not even clear people would
look at git-worktree.txt.)
  (3) Even if they do discover it, and run it, it's an extra step they
never needed to take before.  Why are we adding a "unbreak these other
commands we want to run" step?
  (4) Also, even if they do discover it, and run it, suddenly we are
setting core.repositoryFormatVersion=1.  That scares me.  I have years
of experience at $DAYJOB saying that the tooling we have works fine
with extensions.worktreeConfig=true.  I have none with setting
core.repositoryFormatVersion=1, but now we're effectively requiring it
by your documentation.  I have no idea how
jgit/egit/other-random-stuff interacts with that.  I'd be willing to
do some tests with targetted users to try to learn more, but suddenly
turning it on for everyone in cases that we know worked fine without
it previously feels unsafe to me.  Maybe I'm over-worrying here, but
see also commit 11664196ac ("Revert "check_repository_format_gently():
refuse
extensions for old repositories"", 2020-07-15) -- it just feels a bit
late to recommend for users, especially when they'll see it as "oh, if
you don't want this other bug we recently introduced you need to run
this....".



So, I'd like to reiterate my earlier suggestion which would avoid
these regressions while also fixing the reported bug:
  * If core.bare=true or core.worktree is set, then at `git worktree
add` time, automatically run the logic you have here for
init-worktree-config.  Having either of those config settings with
multiple worktrees is currently broken in all git versions and likely
in most all external tools.  As such, being aggressive in the new
config settings to allow new versions of git to work seems totally
safe to me -- we can't be any more broken than we already were.
  * If core.bare=false and core.worktree is not set, then:
    * `git sparse-checkout {init,set}` should set
extensions.worktreeConfig if not already set, and always set the
core.sparse* and index.sparse settings in worktree-specific files.
    * `git worktree add`, if extensions.worktreeConfig is already set,
will copy both the info/sparse-checkout file and the config.worktree
settings (module core.bare and core.worktree, if present) to the new
worktree
