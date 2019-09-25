Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF921F463
	for <e@80x24.org>; Wed, 25 Sep 2019 21:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfIYV23 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 17:28:29 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42352 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfIYV22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 17:28:28 -0400
Received: by mail-vs1-f67.google.com with SMTP id m22so130928vsl.9
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8+S06WVocqKykVd+YdfUiZ9WkjdYLl8m9xRz1hQME2o=;
        b=lBz3t7XlZ/ENNHC8GDsK/HSBzlvUiMgRfhAJThHjDn3JOhVGKRjCqGqqR5nzs1Becz
         tzolX3NSNv77sDmTEDBqbbUw5EVJ0CHSJ+UglFOGtp0pQVB5qa0duboF2880c5+ssLRu
         V7Z52is3W6cH9TVYrrsloj0vbUJZ6yFBNSgGiAxIhVg5rNTsmQoKrNZo6Et3MavOAyrV
         6I6VP5pz3HYJ/JdobokhNGAa8xHLpTY6VUByj7uojltmlnIi55xfn6thxJjDBJFBqHhu
         EWkbfDByNPDVCxANkDM/jCwMEbaJFBBWLog95kfSiZnaYjWfArxt8i6n5v3dzjn7WZKA
         YuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8+S06WVocqKykVd+YdfUiZ9WkjdYLl8m9xRz1hQME2o=;
        b=q/gWRRqq4HBFfR7gGkdvsKlv/S3MRJcYva7hsDpSQp4u++Xfh+hwsXFa4V6Xi5RtKv
         5vobV5xeWAwmku02/qsc0e1NsodxYluUvRziIMP7apsYEoZR5LE+c6//XmY82a64mdye
         N/F33vNUInEXnxO3su16dScB1oHBuNvOtY1vwtYA0ZSSr6Gd8DnBVwmkIMiNAdMm2Oy8
         hIUpHbrOya7Xd0XF/DNn8blycH4haHf4/FZEW+zvrK3DRZGWmHxFPUzdIoD31J8DZUjy
         9+fAc0jVghLy7P0IQhDVG6HOCDVJh8Xu7RckfLJE1VvUFkIIm8an1Tvn0rrAcyY9lyp8
         dGlg==
X-Gm-Message-State: APjAAAV9UfVGLSdskiXdPu32L8v4SsPv/bgUq95qXvcUt+YY2vXIyxko
        BKfhN1JqQXkR3jMaX8Vyl1Yr4K2B5CXyvTOT16s=
X-Google-Smtp-Source: APXvYqzJE64Hxq+hhxlwIXE8GYWFouDRsDN39AN2t3DiFsJjTz3t+LgAvBUwzs8EqRdinbegHVPmIc6WXBEUi4ZyWl8=
X-Received: by 2002:a67:e8ca:: with SMTP id y10mr6256852vsn.136.1569446907086;
 Wed, 25 Sep 2019 14:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190912221240.18057-1-newren@gmail.com> <20190917163504.14566-1-newren@gmail.com>
 <20190917163504.14566-5-newren@gmail.com> <20190925203919.GA89135@generichostname>
In-Reply-To: <20190925203919.GA89135@generichostname>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Sep 2019 14:28:15 -0700
Message-ID: <CABPp-BHyjVSD6_S_dYgPiXM=GVEpT97FqJJearzg4hvKHXfNVA@mail.gmail.com>
Subject: Re: [BUG] git is segfaulting, was [PATCH v4 04/12] dir: also check
 directories for matching pathspecs
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, Sep 25, 2019 at 1:39 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> Hi Elijah,
>
> I ran into a segfault on MacOS. I managed to bisect it down to
> 404ebceda0 (dir: also check directories for matching pathspecs,
> 2019-09-17), which should be the patch in the parent thread. The test
> case below works fine without this patch applied but segfaults once it
> is applied.
>
>         #!/bin/sh
>
>         git worktree add testdir
>         git -C testdir checkout master
>         git -C testdir fetch https://github.com/git/git.git todo
>         bin-wrappers/git -C testdir checkout FETCH_HEAD # segfault here
>
> Note that the worktree part isn't necessary to reproduce the problem but
> I didn't want my files to be constantly refreshed, triggering a rebuild
> each time.
>
> I also managed to get this backtrace from running lldb at the segfault
> but it is based on the latest "jch" commit, 1cc52d20df (Merge branch
> 'jt/merge-recursive-symlink-is-not-a-dir-in-way' into jch, 2019-09-20).
>
>         * thread #1, queue =3D 'com.apple.main-thread', stop reason =3D E=
XC_BAD_ACCESS (code=3D1, address=3D0x8)
>           * frame #0: 0x00000001000f63a0 git`do_match_pathspec(istate=3D0=
x0000000100299940, ps=3D0x000000010200aa80, name=3D"Gitweb/static/js/lib/",=
 namelen=3D21, prefix=3D0, seen=3D0x0000000000000000, flags=3D0) at dir.c:4=
20:2 [opt]
>                 frame #1: 0x00000001000f632c git`match_pathspec(istate=3D=
0x0000000100299940, ps=3D0x0000000000000000, name=3D"Gitweb/static/js/lib/"=
, namelen=3D21, prefix=3D0, seen=3D0x0000000000000000, is_dir=3D0) at dir.c=
:490:13 [opt]
>                 frame #2: 0x00000001000f8315 git`read_directory_recursive=
(dir=3D0x00007ffeefbfe278, istate=3D0x0000000100299940, base=3D<unavailable=
>, baselen=3D17, untracked=3D<unavailable>, check_only=3D0, stop_at_first_f=
ile=3D0, pathspec=3D0x0000000000000000) at dir.c:1990:9 [opt]
>                 frame #3: 0x00000001000f82e9 git`read_directory_recursive=
(dir=3D0x00007ffeefbfe278, istate=3D0x0000000100299940, base=3D<unavailable=
>, baselen=3D14, untracked=3D<unavailable>, check_only=3D0, stop_at_first_f=
ile=3D0, pathspec=3D0x0000000000000000) at dir.c:1984:5 [opt]
>                 frame #4: 0x00000001000f82e9 git`read_directory_recursive=
(dir=3D0x00007ffeefbfe278, istate=3D0x0000000100299940, base=3D<unavailable=
>, baselen=3D7, untracked=3D<unavailable>, check_only=3D0, stop_at_first_fi=
le=3D0, pathspec=3D0x0000000000000000) at dir.c:1984:5 [opt]
>                 frame #5: 0x00000001000f60d1 git`read_directory(dir=3D0x0=
0007ffeefbfe278, istate=3D0x0000000100299940, path=3D"Gitweb/", len=3D7, pa=
thspec=3D0x0000000000000000) at dir.c:2298:3 [opt]
>                 frame #6: 0x00000001001bded1 git`verify_clean_subdirector=
y(ce=3D<unavailable>, o=3D0x00007ffeefbfe8c0) at unpack-trees.c:1846:6 [opt=
]
>                 frame #7: 0x00000001001bdc1d git`check_ok_to_remove(name=
=3D"Gitweb", len=3D6, dtype=3D4, ce=3D0x0000000103e70de0, st=3D0x00007ffeef=
bfe438, error_type=3DERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o=3D0x00007ffe=
efbfe8c0) at unpack-trees.c:1901:7 [opt]
>                 frame #8: 0x00000001001bdb01 git`verify_absent_1(ce=3D<un=
available>, error_type=3D<unavailable>, o=3D<unavailable>) at unpack-trees.=
c:1964:10 [opt]
>                 frame #9: 0x00000001001bafc0 git`verify_absent(ce=3D<unav=
ailable>, error_type=3D<unavailable>, o=3D<unavailable>) at unpack-trees.c:=
1052:11 [opt] [artificial]
>                 frame #10: 0x00000001001bbc3c git`merged_entry(ce=3D0x000=
0000100605fb0, old=3D0x0000000000000000, o=3D0x00007ffeefbfe8c0) at unpack-=
trees.c:2013:7 [opt]
>                 frame #11: 0x00000001001bd2b7 git`call_unpack_fn(src=3D<u=
navailable>, o=3D<unavailable>) at unpack-trees.c:522:12 [opt]
>                 frame #12: 0x00000001001bca16 git`unpack_nondirectories(n=
=3D2, mask=3D2, dirmask=3D<unavailable>, src=3D0x00007ffeefbfe5d0, names=3D=
<unavailable>, info=3D0x00007ffeefbfe718) at unpack-trees.c:1029:12 [opt]
>                 frame #13: 0x00000001001bad1a git`unpack_callback(n=3D2, =
mask=3D2, dirmask=3D0, names=3D0x0000000102007390, info=3D0x00007ffeefbfe71=
8) at unpack-trees.c:1229:6 [opt]
>                 frame #14: 0x00000001001b8be2 git`traverse_trees(istate=
=3D0x0000000100299940, n=3D2, t=3D<unavailable>, info=3D<unavailable>) at t=
ree-walk.c:497:17 [opt]
>                 frame #15: 0x00000001001ba80f git`unpack_trees(len=3D2, t=
=3D0x00007ffeefbfebe0, o=3D0x00007ffeefbfe8c0) at unpack-trees.c:1546:9 [op=
t]
>                 frame #16: 0x000000010001a443 git`merge_working_tree(opts=
=3D0x00007ffeefbfee38, old_branch_info=3D0x00007ffeefbfeca0, new_branch_inf=
o=3D0x00007ffeefbfeda0, writeout_error=3D0x00007ffeefbfeccc) at checkout.c:=
704:9 [opt]
>                 frame #17: 0x000000010001a08c git`switch_branches(opts=3D=
0x00007ffeefbfee38, new_branch_info=3D0x00007ffeefbfeda0) at checkout.c:105=
7:9 [opt]
>                 frame #18: 0x0000000100018df0 git`checkout_branch(opts=3D=
<unavailable>, new_branch_info=3D<unavailable>) at checkout.c:1426:9 [opt]
>                 frame #19: 0x0000000100017b90 git`checkout_main(argc=3D0,=
 argv=3D0x00007ffeefbff570, prefix=3D0x0000000000000000, opts=3D0x00007ffee=
fbfee38, options=3D<unavailable>, usagestr=3D<unavailable>) at checkout.c:1=
682:10 [opt]
>                 frame #20: 0x0000000100016f2d git`cmd_checkout(argc=3D2, =
argv=3D0x00007ffeefbff568, prefix=3D0x0000000000000000) at checkout.c:1731:=
8 [opt]
>                 frame #21: 0x00000001000026f6 git`run_builtin(p=3D0x00000=
0010024c710, argc=3D2, argv=3D0x00007ffeefbff568) at git.c:444:11 [opt]
>                 frame #22: 0x0000000100001a36 git`handle_builtin(argc=3D2=
, argv=3D0x00007ffeefbff568) at git.c:673:3 [opt]
>                 frame #23: 0x000000010000235c git`run_argv(argcp=3D0x0000=
7ffeefbff4ec, argv=3D0x00007ffeefbff4d8) at git.c:740:4 [opt]
>                 frame #24: 0x0000000100001794 git`cmd_main(argc=3D2, argv=
=3D0x00007ffeefbff568) at git.c:871:19 [opt]
>                 frame #25: 0x00000001000a4405 git`main(argc=3D<unavailabl=
e>, argv=3D0x00007ffeefbff560) at common-main.c:52:11 [opt]
>                 frame #26: 0x00007fff783053d5 libdyld.dylib`start + 1
>
> Sorry for the information dump, I haven't had the time to properly look
> into the issue but I just wanted to make sure that you're aware.

Thanks for testing and sending the heads up.  Unfortunately, I cannot
reproduce on either Linux or Mac.  Do you have some special ignore
files or sparse-checkout paths that are important to triggering?
What's in your config.mak?  What compiler and version?

Here's what I did, just to verify:

cd ~/floss/git
git checkout 404ebceda0
NO_GETTEXT=3D1 make DEVELOPER=3D1 -j8   # I leave off the NO_GETTEXT=3D1 on=
 linux
git worktree add testdir
git -C testdir checkout master
git -C testdir fetch https://github.com/git/git.git todo
bin-wrappers/git -C testdir checkout FETCH_HEAD

Did I get any of those steps wrong?


Thanks,
Elijah
