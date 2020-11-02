Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64791C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 09:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA912225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 09:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbndsuLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgKBJ2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgKBJ2K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 04:28:10 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A30C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 01:28:10 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id t8so4280991vsr.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 01:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LTZ3vvcbyt2mODPSc74bnkumaHimc4R1IbdsjklQqxg=;
        b=qbndsuLedTS7iMvFTGtPsH/avmPbcXvbvifmBPYnB6oxFRuXr6RfsG5aC6g66Xk06c
         99dvPemcR75IvM4dc04chCNPqg0tuPQkrl6DTeeJAuX3rDNJXuuysurR8ruvnF2bWbrB
         C+A8IGXfLrgcko1KtjbG24tHyd2fFuKRVYE1CKcWWtZ4Cy+FUtP3v3rc0utNWJjs8KPn
         o8smTQbwAjJXopNcyEuDc1u7uLWSTarsNWStyRj4aJmU6ULpO3xDoQ1id4VxWg57LVK7
         DnDHLEB5eaRdOl9AvBWPrXMhAolDCGgZDSRzlJ6/tW6hfndWuWeRjYAlh1z2l/DLkTGX
         Ro2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LTZ3vvcbyt2mODPSc74bnkumaHimc4R1IbdsjklQqxg=;
        b=n6bV149VK/Fv8OYGq/u9IYaqJvVMTs28PfM74LWj0bIYUlNkSVzY3g4lL9euEkV0B3
         sIJSD+XuwZiAIIb6wUNhDd12gAGooAZinnU/PDvUNF09ne48rRjv/WJrLL2Vrt84f/y9
         yTpD8yWla5p/q/9iQrrCMzUIghmdL1Wtb/UVUdqkiddVTZWVPqKTFhIdjA0zjwHt649V
         wKWuyE68rgRoK3i3X0E3WHCFj1kDDF+fUJXDvCE1qDzla9+zo+VVCJVg5UOury15ljPu
         Wp4ScqejdmAxkeybhXfL1otOdEilIJ1lqAC25mDKSWdYFqdY6MNkB5CigWLqOGVt7sqW
         ZyEQ==
X-Gm-Message-State: AOAM530qY6x+GBRZFZmCqgIxvnQYYS7Hsy5uy2sHN31HSTdkZ+MlMPsJ
        bZ7lcf0b+vV2jFJISMGF39q5NzMRGtFSgg4xnuA=
X-Google-Smtp-Source: ABdhPJyC47YAEp2IIcT/+AAaIztnBKASwIBWgNtDUCWX0iCvx3xZn19QrWjRKnqLtJgewcZVFYjjl6HY7HFk5yxLVBc=
X-Received: by 2002:a05:6102:4b6:: with SMTP id r22mr4025105vsa.10.1604309289332;
 Mon, 02 Nov 2020 01:28:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com> <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 2 Nov 2020 01:27:59 -0800
Message-ID: <CA+P7+xqFrzT53vx70tRDFgZXM3i2FJJK9CpuJJfkfsN4Qj6ChQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Beginning of new merge strategy: New API, empty implementation
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 1:34 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> In this series, I show the new merge API I have developed in merge-ort, a=
nd
> show how it differs from that provided by merge-recursive. I do this in f=
our
> steps, each corresponding to a patch.
>

I'm definitely excited by this project. I'm curious if you have any
further implementation as a WIP that could be played with to see the
end result of the new merging?

I definitely like this approach where you work in smaller increments
to make the implementation easier to review!

Thanks,
Jake

> Changes since v3:
>
>  * Make 'fast-rebase' be a test-tool subcommand instead of a special hidd=
en
>    builtin, as suggested by Jonathan Tan and SZEDER G=C3=A1bor
>
> Elijah Newren (4):
>   merge-ort: barebones API of new merge strategy with empty
>     implementation
>   merge-ort-wrappers: new convience wrappers to mimic the old merge API
>   fast-rebase: demonstrate merge-ort's API via new test-tool command
>   merge,rebase,revert: select ort or recursive by config or environment
>
>  Makefile                    |   3 +
>  builtin/merge.c             |  26 ++++-
>  builtin/rebase.c            |   9 +-
>  builtin/revert.c            |   2 +
>  merge-ort-wrappers.c        |  62 +++++++++++
>  merge-ort-wrappers.h        |  25 +++++
>  merge-ort.c                 |  52 +++++++++
>  merge-ort.h                 |  58 ++++++++++
>  sequencer.c                 |  71 ++++++++++--
>  t/helper/test-fast-rebase.c | 211 ++++++++++++++++++++++++++++++++++++
>  t/helper/test-tool.c        |   1 +
>  t/helper/test-tool.h        |   1 +
>  12 files changed, 506 insertions(+), 15 deletions(-)
>  create mode 100644 merge-ort-wrappers.c
>  create mode 100644 merge-ort-wrappers.h
>  create mode 100644 merge-ort.c
>  create mode 100644 merge-ort.h
>  create mode 100644 t/helper/test-fast-rebase.c
>
>
> base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-895=
%2Fnewren%2Fort-api-with-empty-implementation-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-895/ne=
wren/ort-api-with-empty-implementation-v4
> Pull-Request: https://github.com/git/git/pull/895
>
> Range-diff vs v3:
>
>  1:  3357ea415e =3D 1:  3357ea415e merge-ort: barebones API of new merge =
strategy with empty implementation
>  2:  d7f6a834ab =3D 2:  d7f6a834ab merge-ort-wrappers: new convience wrap=
pers to mimic the old merge API
>  3:  27ad756600 ! 3:  fce0db8778 fast-rebase: demonstrate merge-ort's API=
 via temporary/hidden command
>      @@ Metadata
>       Author: Elijah Newren <newren@gmail.com>
>
>        ## Commit message ##
>      -    fast-rebase: demonstrate merge-ort's API via temporary/hidden c=
ommand
>      +    fast-rebase: demonstrate merge-ort's API via new test-tool comm=
and
>
>      -    Add a special built-in that is only of use to git-developers an=
d only
>      -    during the development of merge-ort, and which is designed to
>      -    immediately fail and print:
>      -       git: 'fast-rebase' is not a git command
>      -    unless a special GIT_TEST_MERGE_ALGORITHM environment variable =
is set.
>      -
>      -    This special builtin serves two purposes:
>      +    Add a new test-tool command named 'fast-rebase', which is a
>      +    super-slimmed down and nowhere near as capable version of 'git =
rebase'.
>      +    'test-tool fast-rebase' is not currently planned for usage in t=
he
>      +    testsuite, but is here for two purposes:
>
>             1) Demonstrate the desired API of merge-ort.  In particular,
>                fast-rebase takes advantage of the separation of the mergi=
ng
>                operation from the updating of the index and working tree,=
 to
>                allow it to pick N commits, but only update the index and =
working
>                tree once at the end.  Look for the calls to
>      -         merge_inmemory_nonrecursive() and merge_switch_to_result()=
.
>      +         merge_incore_nonrecursive() and merge_switch_to_result().
>
>             2) Provide a convenient benchmark that isn't polluted by the =
heavy
>                disk writing and forking of unnecessary processes that com=
es from
>      @@ Commit message
>           Signed-off-by: Elijah Newren <newren@gmail.com>
>
>        ## Makefile ##
>      -@@ Makefile: BUILTIN_OBJS +=3D builtin/difftool.o
>      - BUILTIN_OBJS +=3D builtin/env--helper.o
>      - BUILTIN_OBJS +=3D builtin/fast-export.o
>      - BUILTIN_OBJS +=3D builtin/fast-import.o
>      -+BUILTIN_OBJS +=3D builtin/fast-rebase.o
>      - BUILTIN_OBJS +=3D builtin/fetch-pack.o
>      - BUILTIN_OBJS +=3D builtin/fetch.o
>      - BUILTIN_OBJS +=3D builtin/fmt-merge-msg.o
>      -
>      - ## builtin.h ##
>      -@@ builtin.h: int cmd_difftool(int argc, const char **argv, const c=
har *prefix);
>      - int cmd_env__helper(int argc, const char **argv, const char *prefi=
x);
>      - int cmd_fast_export(int argc, const char **argv, const char *prefi=
x);
>      - int cmd_fast_import(int argc, const char **argv, const char *prefi=
x);
>      -+int cmd_fast_rebase(int argc, const char **argv, const char *prefi=
x);
>      - int cmd_fetch(int argc, const char **argv, const char *prefix);
>      - int cmd_fetch_pack(int argc, const char **argv, const char *prefix=
);
>      - int cmd_fmt_merge_msg(int argc, const char **argv, const char *pre=
fix);
>      +@@ Makefile: TEST_BUILTINS_OBJS +=3D test-dump-fsmonitor.o
>      + TEST_BUILTINS_OBJS +=3D test-dump-split-index.o
>      + TEST_BUILTINS_OBJS +=3D test-dump-untracked-cache.o
>      + TEST_BUILTINS_OBJS +=3D test-example-decorate.o
>      ++TEST_BUILTINS_OBJS +=3D test-fast-rebase.o
>      + TEST_BUILTINS_OBJS +=3D test-genrandom.o
>      + TEST_BUILTINS_OBJS +=3D test-genzeros.o
>      + TEST_BUILTINS_OBJS +=3D test-hash-speed.o
>
>      - ## builtin/fast-rebase.c (new) ##
>      + ## t/helper/test-fast-rebase.c (new) ##
>       @@
>       +/*
>       + * "git fast-rebase" builtin command
>      @@ builtin/fast-rebase.c (new)
>       + */
>       +
>       +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>      -+#include "builtin.h"
>      ++#include "test-tool.h"
>       +
>       +#include "cache-tree.h"
>       +#include "commit.h"
>      @@ builtin/fast-rebase.c (new)
>       + return (struct commit *)obj;
>       +}
>       +
>      -+int cmd_fast_rebase(int argc, const char **argv, const char *prefi=
x)
>      ++int cmd__fast_rebase(int argc, const char **argv)
>       +{
>       + struct commit *onto;
>       + struct commit *last_commit =3D NULL, *last_picked_commit =3D NULL=
;
>      @@ builtin/fast-rebase.c (new)
>       + struct strbuf reflog_msg =3D STRBUF_INIT;
>       + struct strbuf branch_name =3D STRBUF_INIT;
>       +
>      ++ /*
>      ++  * test-tool stuff doesn't set up the git directory by default; n=
eed to
>      ++  * do that manually.
>      ++  */
>      ++ setup_git_directory();
>      ++
>       + if (argc =3D=3D 2 && !strcmp(argv[1], "-h")) {
>       +         printf("Sorry, I am not a psychiatrist; I can not give yo=
u the help you need.  Oh, you meant usage...\n");
>       +         exit(129);
>       + }
>       +
>      -+ if (!getenv("GIT_TEST_MERGE_ALGORITHM")) {
>      -+         fprintf_ln(stderr, _("git: 'fast-rebase' is not a git com=
mand. See 'git --help'."));
>      -+         exit(1);
>      -+ }
>      -+
>       + if (argc !=3D 5 || strcmp(argv[1], "--onto"))
>       +         die("usage: read the code, figure out how to use it, then=
 do so");
>       +
>      @@ builtin/fast-rebase.c (new)
>       + return (clean =3D=3D 0);
>       +}
>
>      - ## git.c ##
>      -@@ git.c: static struct cmd_struct commands[] =3D {
>      -  { "env--helper", cmd_env__helper },
>      -  { "fast-export", cmd_fast_export, RUN_SETUP },
>      -  { "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
>      -+ { "fast-rebase", cmd_fast_rebase, RUN_SETUP /* | NEED_WORK_TREE *=
/ },
>      -  { "fetch", cmd_fetch, RUN_SETUP },
>      -  { "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
>      -  { "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
>      + ## t/helper/test-tool.c ##
>      +@@ t/helper/test-tool.c: static struct test_cmd cmds[] =3D {
>      +  { "dump-split-index", cmd__dump_split_index },
>      +  { "dump-untracked-cache", cmd__dump_untracked_cache },
>      +  { "example-decorate", cmd__example_decorate },
>      ++ { "fast-rebase", cmd__fast_rebase },
>      +  { "genrandom", cmd__genrandom },
>      +  { "genzeros", cmd__genzeros },
>      +  { "hashmap", cmd__hashmap },
>      +
>      + ## t/helper/test-tool.h ##
>      +@@ t/helper/test-tool.h: int cmd__dump_fsmonitor(int argc, const ch=
ar **argv);
>      + int cmd__dump_split_index(int argc, const char **argv);
>      + int cmd__dump_untracked_cache(int argc, const char **argv);
>      + int cmd__example_decorate(int argc, const char **argv);
>      ++int cmd__fast_rebase(int argc, const char **argv);
>      + int cmd__genrandom(int argc, const char **argv);
>      + int cmd__genzeros(int argc, const char **argv);
>      + int cmd__hashmap(int argc, const char **argv);
>  4:  0479d59c33 =3D 4:  75d19804bd merge,rebase,revert: select ort or rec=
ursive by config or environment
>
> --
> gitgitgadget
