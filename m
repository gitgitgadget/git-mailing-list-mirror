Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74DCA20248
	for <e@80x24.org>; Fri,  8 Mar 2019 18:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCHSBj (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 13:01:39 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45714 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfCHSBi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 13:01:38 -0500
Received: by mail-vs1-f65.google.com with SMTP id n14so7163387vsp.12
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IrJ3m6J15b15aypphNZABIQd0sOQB2KuscQVw0zq/tQ=;
        b=Z2t0yx5YqMO3niFEO82QRO6DedP060x41vR0zTiM7udG1OTXZBJtXpgbl8KdT2PPvc
         /2CmflKVcIC0lFpDTZ7w77nQgJTHmXkdkLmEl8x/5nBg4VA+PF9v5CZCm3fyGYv79CQw
         3yT6lE353sQPnEDPVYCMlzKMHIDS+kdbUoOx3gE1tvpPM1XwG426j2fGhE2UoAqaeBEZ
         a+Kr4q+OBS3Dx8G5sqYpqxXzo7kzBae+hIo4xsGm2gNYjvmiPxBQ1HhLU2oLxuSlmaaX
         lRNe/Gqq0Q4U3O5ZKwX+ag/gUpGPmZ7zXnkYkr21gIs0l+7ijjXRDOXgqi8yje1djIMg
         ObgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IrJ3m6J15b15aypphNZABIQd0sOQB2KuscQVw0zq/tQ=;
        b=Gdh9gAJpqAcAFqrkhyPmRqTQEO+pmKhEeQq0OKz3q/tLbgXicDoNMZkfZnudLq5wQL
         SSnTtN56jKSnd6J+KuFWM7P9mKyY9+yEHjkOsqobm69qHK/ncAU3Op945Oed034eiRre
         rtWJ9ak+bCeEAvE4snT0LcDrJDd+rtTOH8d10YZLi33hkxODOPhs2qmJRPs90HuKpE6y
         N+UW4a8/mDvO03M/uwtZMbv12vmTy+NaOrG1xJQ4kTe6I8QzW2C2bAzzVOZZzASE3KMu
         y/nPdoL19KmtDZvvFvE50ywGSe6MctXbzD5eE6sSoPhPnbMTu0ywI7yDSRgdH0PmD3UE
         G+HQ==
X-Gm-Message-State: APjAAAUIRX4OsfznXkm92ApixTJ1VSezZvPxnFg0nMdyU3yelmZwk4o1
        jbhMPISRQdwrLXtKoYVWZS/N1fmEgspfEliXzZA=
X-Google-Smtp-Source: APXvYqyjaArwS53dRoafijVSn90KBKdxwPzWetH+DxOgZrNse9yBW27QOgsV7qY/NC7Oij7tr3wPX0r6QLKSN5FKhbE=
X-Received: by 2002:a67:3052:: with SMTP id w79mr10472764vsw.116.1552068096830;
 Fri, 08 Mar 2019 10:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-2-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-2-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 8 Mar 2019 10:01:25 -0800
Message-ID: <CABPp-BFXZMorrHph3hGFnqfceHs68byWNgffNKGp1ov6X5-o5A@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] checkout: split part of it to new command 'restore'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for working on this; overall looks really good.  I've got a few
comments here and there on the wording and combinations of options...

On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
> +SYNOPSIS

It might be worth adding some words somewhere to differentiate between
`reset` and `restore`.  E.g.

`git restore` modifies the working tree (and maybe index) to change
file content to match some other (usually older) version, but does not
update your branch.  `git reset` is about modifying which commit your
branch points to, meaning possibly removing and/or adding many commits
to your branch.

It may also make sense to add whatever description you use to the reset man=
page.

> +--------
> +[verse]
> +'git restore' [<options>] [--source=3D<revision>] <pathspec>...
> +'git restore' (-p|--patch) [--source=3D<revision>] [<pathspec>...]

So one cannot specify any special options with -p?  Does that mean one
cannot use it with --index (i.e. this command cannot replace 'git
reset -p')?  Or is this an oversight in the synopsis?

> +DESCRIPTION
> +-----------
> +Restore paths in the working tree by replacing with the contents in
> +the restore source or remove if the paths do not exist in the restore
> +source. The source is by default the index but could be from a commit.
> +The command can also optionally restore content in the index from a
> +commit.

The first sentence makes it sound like two different operations, when
I think it is one. Perhaps:

Restore paths in the working tree by replacing with the contents in
the restore source (and if the restore source is missing paths found
in the working tree, that means deleting those paths from the working
tree).

> +
> +When a `<revision>` is given, the paths that match the `<pathspec>` are
> +updated both in the index and in the working tree.

I thought the default was --worktree.  Is this sentence from an older
version of your patch series that you forgot to update?

> +
> +OPTIONS
> +-------
> +-s<tree>::
> +--source=3D<tree>::
> +       Restore the working tree files with the content from the given
> +       tree or any revision that leads to a tree (e.g. a commit or a
> +       branch).

I think that's a little hard to parse.  We may not be able to avoid
"working tree" vs. "tree" confusion, but the spelling of <tree> feels
like it should be a separate sentence.  Maybe:

Restore the working tree files with the content from the given tree.
It is common to specify the source tree by naming a commit, branch, or
tag.

?

> +
> +-p::
> +--patch::
> +       Interactively select hunks in the difference between the
> +       `<revision>` (or the index, if unspecified) and the working
> +       tree. See the ``Interactive Mode'' section of linkgit:git-add[1]
> +       to learn how to operate the `--patch` mode.
> +
> +-W::
> +--worktree::
> +-I::
> +--index::
> +       Specify the restore location. If neither option is specified,
> +       by default the working tree is restored. If `--index` is
> +       specified without `--worktree` or `--source`, `--source=3DHEAD`
> +       is implied. These options only make sense to use with
> +       `--source`.

Seems like this contains a minor contradiction.  Perhaps start the
final sentence with: "Otherwise, ..." ?

> +-q::
> +--quiet::
> +       Quiet, suppress feedback messages.
> +
> +--progress::
> +--no-progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal, unless `--quiet`
> +       is specified. This flag enables progress reporting even if not
> +       attached to a terminal, regardless of `--quiet`.

I'm assuming this means there are feedback messages other than
progress feedback?

> +-f::
> +--force::
> +       If `--source` is not specified, unmerged entries are left alone
> +       and will not fail the operation. Unmerged entries are always
> +       replaced if `--source` is specified, regardless of `--force`.

This may be slightly confusing, in particular it suggests that --index
(or --worktree and --index) are the default.  Is --force only useful
when --index is specified?  If it has utility with --worktree only,
what does it do?  Also, what happens when there are unmerged entries
in the index and someone tries to restore just working tree files --
are the ones corresponding to unmerged entries skipped (if so,
silently or with warnings printed for the user?), or does something
else happen?

> +--ours::
> +--theirs::
> +       Check out stage #2 ('ours') or #3 ('theirs') for unmerged
> +       paths.
> ++
> +Note that during `git rebase` and `git pull --rebase`, 'ours' and
> +'theirs' may appear swapped. See the explanation of the same options
> +in linkgit:git-checkout[1] for details.

So sad, but yes you need to mention it.  I'm curious what we say for
cherry-pick; it's not clear to me whether people think of the current
branch as "ours" or the commit they wrote themselves and are trying to
bring to this branch as "ours".  There are probably examples of both.

Not that I think you can do anything about that here or need to change
your description.  I'm just very sad about --ours and --theirs in
general.

> +
> +-m::
> +--merge::
> +       Recreate the conflicted merge in the specified paths.
> +
> +--conflict=3D<style>::
> +       The same as `--merge` option above, but changes the way the
> +       conflicting hunks are presented, overriding the merge.conflictSty=
le
> +       configuration variable.  Possible values are "merge" (default)
> +       and "diff3" (in addition to what is shown by "merge" style,
> +       shows the original contents).

Should you mention that these are incompatible with --source and
--index?  And perhaps also make sure the code aborts if either of
these options are combined with either of those?

> +--ignore-skip-worktree-bits::
> +       In sparse checkout mode, by default update only entries
> +       matched by `<pathspec>` and sparse patterns in
> +       $GIT_DIR/info/sparse-checkout. This option ignores the sparse
> +       patterns and unconditionally restores any files in `<pathspec>`.

The first sentence is slightly confusing; it sounds like you are
saying what the flag does rather than what the default is without the
flag.  Perhaps:

"In sparse checkout mode, the default is to only update entries
matched by `<pathspec>` and sparse patterns in
$GIT_DIR/info/sparse-checkout...."

> +
> +--recurse-submodules::
> +--no-recurse-submodules::
> +       Using `--recurse-submodules` will update the content of all initi=
alized
> +       submodules according to the commit recorded in the superproject. =
If
> +       local modifications in a submodule would be overwritten the check=
out
> +       will fail unless `-f` is used.

This suggests that your documentation for -f/--force is incomplete.

> +       If nothing (or `--no-recurse-submodules`)
> +       is used, the work trees of submodules will not be updated.

This seems slightly awkward.  Perhaps "If `--no-recurse-submodules`
(which is the default) is used, the work trees of submodules will not
be updated.

> +       Just like linkgit:git-submodule[1], this will detach the
> +       submodules HEAD.
> +
> +--overlay::
> +--no-overlay::
> +       In overlay mode, `git checkout` never removes files from the

Why are you talking about `git checkout` here?  Shouldn't this be `git rest=
ore`?

> +       index or the working tree. In no-overlay mode, files that
> +       appear in the index and working tree, but not in `--source` tree
> +       are removed, to make them match `<tree-ish>` exactly. The
> +       default is no-overlay mode.

A minor comment: This seems slightly weird because it feels like you
start out with a negative ("never removes") and then describe the
opposite option which adds another negation to the negative.  But the
wording avoids an explicit double negative (which is good), and I
don't have a better suggestion for wording here.  Just thought I'd
flag it in case anyone else reading over this notices it too and has a
wording suggestion.

> +
> +EXAMPLES
> +--------
> +
> +The following sequence checks out the `master` branch, reverts
> +the `Makefile` to two revisions back, deletes hello.c by
> +mistake, and gets it back from the index.
> +
> +------------
> +$ git switch master
> +$ git restore --source master~2 Makefile  <1>
> +$ rm -f hello.c
> +$ git restore hello.c                   <2>
> +------------
> +
> +<1> take a file out of another commit
> +<2> restore hello.c from the index
> +
> +If you want to check out _all_ C source files out of the index,
> +you can say
> +
> +------------
> +$ git restore '*.c'
> +------------
> +
> +Note the quotes around `*.c`.  The file `hello.c` will also be
> +checked out, even though it is no longer in the working tree,
> +because the file globbing is used to match entries in the index
> +(not in the working tree by the shell).
> +
> +To restore all files in the current directory
> +
> +------------
> +$ git restore .
> +------------
> +
> +or to restore all working tree files with 'top' pathspec magic (see
> +linkgit::gitglossary[7])
> +
> +------------
> +$ git restore :/
> +------------
> +
> +To restore a file in the index only (this is the same as using
> +"git reset")
> +
> +------------
> +$ git restore --index hello.c
> +------------
> +
> +or you can restore both the index and the working tree
> +
> +------------
> +$ git restore --source=3DHEAD --index --worktree hello.c
> +------------
> +
> +SEE ALSO
> +--------
> +linkgit:git-checkout[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index 8e91db73ad..ffe7e4f58f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -799,6 +799,7 @@ BUILT_INS +=3D git-format-patch$X
>  BUILT_INS +=3D git-fsck-objects$X
>  BUILT_INS +=3D git-init$X
>  BUILT_INS +=3D git-merge-subtree$X
> +BUILT_INS +=3D git-restore$X
>  BUILT_INS +=3D git-show$X
>  BUILT_INS +=3D git-stage$X
>  BUILT_INS +=3D git-status$X
> diff --git a/builtin.h b/builtin.h
> index c64e44450e..6830000e14 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -214,6 +214,7 @@ extern int cmd_remote_fd(int argc, const char **argv,=
 const char *prefix);
>  extern int cmd_repack(int argc, const char **argv, const char *prefix);
>  extern int cmd_rerere(int argc, const char **argv, const char *prefix);
>  extern int cmd_reset(int argc, const char **argv, const char *prefix);
> +extern int cmd_restore(int argc, const char **argv, const char *prefix);
>  extern int cmd_rev_list(int argc, const char **argv, const char *prefix)=
;
>  extern int cmd_rev_parse(int argc, const char **argv, const char *prefix=
);
>  extern int cmd_revert(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 4903359b49..11dd2ae44c 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -37,6 +37,11 @@ static const char * const switch_branch_usage[] =3D {
>         NULL,
>  };
>
> +static const char * const restore_files_usage[] =3D {
> +       N_("git restore [<options>] [<branch>] -- <file>..."),
> +       NULL,
> +};
> +
>  struct checkout_opts {
>         int patch_mode;
>         int quiet;
> @@ -1528,3 +1533,24 @@ int cmd_switch(int argc, const char **argv, const =
char *prefix)
>         FREE_AND_NULL(options);
>         return ret;
>  }
> +
> +int cmd_restore(int argc, const char **argv, const char *prefix)
> +{
> +       struct checkout_opts opts;
> +       struct option *options =3D NULL;
> +       int ret;
> +
> +       memset(&opts, 0, sizeof(opts));
> +       opts.dwim_new_local_branch =3D 1;
> +       opts.switch_branch_doing_nothing_is_ok =3D 0;
> +       opts.accept_pathspec =3D 1;
> +
> +       options =3D parse_options_dup(options);
> +       options =3D add_common_options(&opts, options);
> +       options =3D add_checkout_path_options(&opts, options);
> +
> +       ret =3D checkout_main(argc, argv, prefix, &opts,
> +                           options, restore_files_usage);
> +       FREE_AND_NULL(options);
> +       return ret;
> +}
> diff --git a/command-list.txt b/command-list.txt
> index 13317f47d4..b9eae1c258 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -151,6 +151,7 @@ git-replace                             ancillarymani=
pulators           complete
>  git-request-pull                        foreignscminterface             =
complete
>  git-rerere                              ancillaryinterrogators
>  git-reset                               mainporcelain           worktree
> +git-restore                             mainporcelain           worktree
>  git-revert                              mainporcelain
>  git-rev-list                            plumbinginterrogators
>  git-rev-parse                           plumbinginterrogators
> diff --git a/git.c b/git.c
> index 39582cf511..6d439e723f 100644
> --- a/git.c
> +++ b/git.c
> @@ -558,6 +558,7 @@ static struct cmd_struct commands[] =3D {
>         { "replace", cmd_replace, RUN_SETUP },
>         { "rerere", cmd_rerere, RUN_SETUP },
>         { "reset", cmd_reset, RUN_SETUP },
> +       { "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
>         { "rev-list", cmd_rev_list, RUN_SETUP | NO_PARSEOPT },
>         { "rev-parse", cmd_rev_parse, NO_PARSEOPT },
>         { "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
> --
> 2.21.0.rc1.337.gdf7f8d0522
>
