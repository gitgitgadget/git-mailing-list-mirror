Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA13C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF21120575
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2bx7otb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390784AbgEMUWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732650AbgEMUWK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:22:10 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48EDC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:22:09 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ep1so602290qvb.0
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnXVa+/aXQ/G5qRlbN8fqjWUI01+OlYzOKxy6ClmA08=;
        b=Q2bx7otbTz5ULb5p21CUHWyKT5ki2nDspDS0sY70MfHB/x0XreWlF27XLbFj+7hf5H
         VOwFBqIcZm3VTxZ5tE3pYfUJk4OJ5+IoT+cLZI51hPA0EFatr4kYdtaFuGGMR6d+KxZ2
         6RDw/JtmK7nJTn3uCaRYudyM+SP8a/l3rNkiC0a2F0PUSyZNspWfFx0f9oR/nty7paCE
         2RCAnbEoufqGE7Ak6WFnrljbbTPNQljo275tWZneUUBQOzcSDcyZ5VrKnTMLt9UhkD30
         r2r+Ma8dFRavR73N9EvEEEPowIjgot1ep6faE0bwf1LJc/cMSk4KQGepgcb7dNw12BhL
         Fgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnXVa+/aXQ/G5qRlbN8fqjWUI01+OlYzOKxy6ClmA08=;
        b=QEF+wT4eq7zPyV0VqtTc3bISQVkgl+ymFtXiWERJ6QAoUKsTbkJ1CPztYESgD6sTXY
         tdbINLZJMDkpIJeIVUV3R8++gN4FEprHAqP2wXsQ0j4QzdgWS9uGbuuOUOeDrT4trBue
         g3wuX+pXhKuBvtWDcY6ORr4Ypkv9dOvl79MfE5LtBR0qrdi9oFwiu1ZokiyxWkum5fzO
         CT5Wfx8AdK/4/Q3wodRhKtpln0kNJsmxvH46suxU8yFNlP5qfR1VJkGPwFqYr7LvG3Ym
         03EHVe0QPpRswzy071qhtrjR9FQ/624Op7lsJMwJpvIooD7GjEeSJm0/8kdbra3jvovB
         cVUQ==
X-Gm-Message-State: AOAM530CGCfPHCLc8sBEaPZe8Pey7Ihl10UMyPj7/XvSvxoG9abHRjEE
        xLiOXqpEf3JbPfe0t3o3exh4+4a/uk64YdNFEsbGnw==
X-Google-Smtp-Source: ABdhPJwWirlqTdnGxLEG9m/terzB6MPs2pcloMToH7o0UsPZ6b8/pGoZzgX3J9+c+ZvOiRhOLR34HAW8qfsZO9NYHu8=
X-Received: by 2002:ad4:588b:: with SMTP id dz11mr1412841qvb.226.1589401328709;
 Wed, 13 May 2020 13:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <70ab1f03dd5413256166bf9db47be47b746ea6b1.1589302254.git.gitgitgadget@gmail.com>
 <xmqqo8qsc1it.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8qsc1it.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Thu, 14 May 2020 01:51:59 +0530
Message-ID: <CAKiG+9U_KCSD=Y4dTAbBRvBxnmpHL2Gw6jPZ7Pv_ZnR3Y6yB6g@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] Introduce CMake support for configuring Git on Linux
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 2:29 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > To make this a little less awkward, the Git for Windows project offers
> > the `vs/master` branch which has a full Visual Studio solution generated
> > and committed. This branch can therefore be used to tinker with Git in
> > Visual Studio _without_ having to download the full Git for Windows SDK.
> > Unfortunatly, that branch is auto-generated from Git for Windows'
> > `master`. If a developer wants to tinker, say, with `pu`, they are out
> > of luck.
>
> 'pu' or 'next' are not to be built upon, so this is not a good line
> of reasoning to complain that generating only for 'master' is bad.
>
> > CMake was invented to make this sort of problem go away, by providing a
> > more standardized, cross-platform way to configure builds.
>
> I think everything above this point (including Makefile, autoconf
> etc.) can be replaced with a single sentence
>
>         The build infrastructure for Git is written around being
>         able to run make, which is not supported natively on
>         Windows.
>
> without anything else.  That will flow naturally to
>
>         Add a build script that uses CMake to help developers on
>         Windows to build git.
>
> and then you can continue the current state, like this paragraph.
>
> > This is only the first step, and to make it easier to review, it only
> > allows for configuring builds on the platform that is easiest to
> > configure for: Linux.
> >
> > The CMake script checks whether the headers are present(eg. libgen.h),
> > whether the functions are present(eg. memmem), whether the funtions work
> > properly (eg. snprintf) and generate the required compile definitions
> > for the platform. The script also searches for the required libraries,
> > if it fails to find the required libraries the respective executables
> > won't be built.(eg. If libcurl is not found then git-remote-http won't
> > be built). This will help building Git easier.
> >
> > With a CMake script an out of source build of git is possible resulting
> > in a clean source tree.
>
>
> > Note: earlier endeavors on the Git mailing list to introduce CMake ended
> > up in dead water. The primary reason for that was that reviewers
> > _expected_ CMake support to fall out of maintenance, unless the
> > contributor would promise to keep an eye on keeping CMake support up to
> > date. However, in the meantime, support for automated testing has been
> > introduced in Git's source code, and a later patch will modify the
> > (still experimental) GitHub workflow to continually verify that CMake
> > support is still complete. That will make maintenance reasonably easy.
>
> I am not sure this belongs to the log message.
>

Will remove it.

> > Note: this patch asks for the minimum version v3.14 of CMake (which is
> > not all that old as of time of writing) because that is the first
> > version to offer a platform-independent way to generate hardlinks as
> > part of the build. This is needed to generate all those hardlinks for
> > the built-in commands of Git.
>
> This does, but I do not think hardlinks are not required for our
> build.  On Unix filesystems, it is not just possible but convenient
> to use, and that is the only reason why we use hardlinks.
>
> If hardlinks are possible but inconvenient to use on Windows, you
> shouldn't force your target audience to use it.

Another alternative is to use verbatim copies, but this increases the
size of the generated build artifacts considerably.
Hardlinks are not inconvenient on Windows, CMake 3.14 gives a cross
platform way of generating them.

>
> > Instructions to run CMake:
> >
> > cmake `relative-path-to-srcdir` -DCMAKE_BUILD_TYPE=Release
> >
> > Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
> > compiler flags
> > Debug : -g
> > Release: -O3
> > RelWithDebInfo : -O2 -g
> > MinSizeRel : -Os
> > empty(default) :
> >
> > NOTE: -DCMAKE_BUILD_TYPE is optional
> >
> > This process generates a Makefile.
> > Then run `make` to build Git.
> >
> > NOTE: By default CMake uses Makefile as the build tool on Linux, to use
> > another tool say `ninja` add this to the command line when configuring.
> > `-G Ninja`
>
> I find it curious that from the instruction, the most important
> platform, the primary reason why we are reviewing this patch, is
> missing.  Don't Windows folks need to be told how to run CMake to
> build?

The instructions are the same for any platform. Just like ./configure.

>
> In any case, all of the above "Instructions" should go at the top
> part of CMakeLists.txt in a comment, and not in the log message.
> "git log" output is not an easy way for your target audience to
> learn how to use what the commit adds.  Think what they need to do
> when they discover there is CMakeLists.txt in our tree in three
> months.  Don't force them to run "git blame" to find this commit
> that added the support.

Okay, will add some instructions on top of the script.

>
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  CMakeLists.txt | 528 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 528 insertions(+)
> >  create mode 100644 CMakeLists.txt
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > new file mode 100644
> > index 00000000000..73703bd321f
> > --- /dev/null
> > +++ b/CMakeLists.txt
> > @@ -0,0 +1,528 @@
> > +#
> > +#    Copyright (c) 2020 Sibi Siddharthan
> > +#
> > +
> > +cmake_minimum_required(VERSION 3.14)
> > +
> > +#Parse GIT-VERSION-GEN to get the version
> > +file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN git_version REGEX "DEF_VER=v(.*)")
> > +string(REPLACE "DEF_VER=v" "" git_version ${git_version})
> > +string(REPLACE ".GIT" ".0" git_version ${git_version})#for building from a snapshot
>
> Hmph, I'd really prefer to see the logic in GIT-VERSION-GEN not
> bypassed like this.  People know they can create a text file 'version'
> and record the version name they desire in it and expect GIT-VERSION-GEN
> to pick it up, for example.
>
> Later in this file, you seem to depend on the shell to do things
> like generating config-list.h file, so I'd rather see the same
> technique used here a well.
>
> > +set(libgit_SOURCES
> > +     abspath.c add-interactive.c add-patch.c advice.c alias.c
> > +...
> > +     zlib.c)
>
> Hmph.
>
> > +set(git_SOURCES
> > +     builtin/add.c builtin/am.c builtin/annotate.c builtin/apply.c
> > +     builtin/archive.c builtin/bisect--helper.c builtin/blame.c
> > +     builtin/branch.c builtin/bundle.c builtin/cat-file.c builtin/check-attr.c
> > +     builtin/check-ignore.c builtin/check-mailmap.c builtin/check-ref-format.c
> > +     builtin/checkout-index.c builtin/checkout.c builtin/clean.c
> > +     builtin/clone.c builtin/column.c builtin/commit-tree.c
> > +     builtin/commit.c builtin/commit-graph.c builtin/config.c
> > +     builtin/count-objects.c builtin/credential.c builtin/describe.c
> > +     builtin/diff-files.c builtin/diff-index.c builtin/diff-tree.c
> > +     builtin/diff.c builtin/difftool.c builtin/env--helper.c
> > +     builtin/fast-export.c builtin/fetch-pack.c builtin/fetch.c builtin/fmt-merge-msg.c
> > +     builtin/for-each-ref.c builtin/fsck.c builtin/gc.c
> > +     builtin/get-tar-commit-id.c builtin/grep.c builtin/hash-object.c
> > +     builtin/help.c builtin/index-pack.c builtin/init-db.c
> > +     builtin/interpret-trailers.c builtin/log.c builtin/ls-files.c
> > +     builtin/ls-remote.c builtin/ls-tree.c builtin/mailinfo.c builtin/mailsplit.c
> > +     builtin/merge.c builtin/merge-base.c builtin/merge-file.c builtin/merge-index.c
> > +     builtin/merge-ours.c builtin/merge-recursive.c builtin/merge-tree.c
> > +     builtin/mktag.c builtin/mktree.c builtin/multi-pack-index.c builtin/mv.c
> > +     builtin/name-rev.c builtin/notes.c builtin/pack-objects.c builtin/pack-redundant.c
> > +     builtin/pack-refs.c builtin/patch-id.c builtin/prune-packed.c builtin/prune.c
> > +     builtin/pull.c builtin/push.c builtin/range-diff.c builtin/read-tree.c
> > +     builtin/rebase.c builtin/receive-pack.c builtin/reflog.c builtin/remote.c
> > +     builtin/remote-ext.c builtin/remote-fd.c builtin/repack.c builtin/replace.c
> > +     builtin/rerere.c builtin/reset.c builtin/rev-list.c builtin/rev-parse.c
> > +     builtin/revert.c builtin/rm.c builtin/send-pack.c builtin/shortlog.c
> > +     builtin/show-branch.c builtin/show-index.c builtin/show-ref.c
> > +     builtin/sparse-checkout.c builtin/stash.c builtin/stripspace.c
> > +     builtin/submodule--helper.c builtin/symbolic-ref.c builtin/tag.c
> > +     builtin/unpack-file.c builtin/unpack-objects.c builtin/update-index.c
> > +     builtin/update-ref.c builtin/update-server-info.c builtin/upload-archive.c
> > +     builtin/upload-pack.c builtin/var.c builtin/verify-commit.c builtin/verify-pack.c
> > +     builtin/verify-tag.c builtin/worktree.c builtin/write-tree.c)
>
> Can't we do a bit better here?
>
> Perhaps grab this out of our Makefile?  The same command applies to
> huge lists of sources we have seen.
>
> Or do the equivalent of $(wildcard builtin/*.c) if CMake has such a
> feature?
>

We do have that.

> > ...
> > \ No newline at end of file
>
> Double check and make sure you have a text file without an incomplete
> line at the end.
>
> Thanks.

Thank You,
Sibi Siddharthan
