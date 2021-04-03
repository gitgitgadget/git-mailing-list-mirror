Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D3C433B4
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB2D6128C
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 13:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhDCNXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDCNXt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 09:23:49 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624DBC0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 06:23:45 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t14so6668065ilu.3
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XFe/1tSyGMmtPubpZj8pFu6y/i9KhyipS8r0jxnTKd0=;
        b=WtY7fPCTuJOYZr7pB1M6O0ZP0wfsOvbZ/kRWLlpNsk6ysmiU7jU9qq0Y5CYKW9DJpo
         PoSfWtW5BGYcWzciuREUOswWvMbgVVYJi2t2IM7Q0vNtq8s8O5RSe/rzzJGZ6Tk9tbsT
         YbO3FQzH/7gzem3PFy96V2UyBv2pjcaIdCdIj8TiSl5um6w9ueDk2LIYAEKBTYoB9U2p
         wW/xY5+sS55JXxXZJouEXsSPId90D2xdzuaYB2jtxG0XJLxuR7Oxe+3zN5KZLadwILUu
         r2+4e54J8HKjzmQzNDtUxJ9R11rNRWebIf0fanulvv60JptNWEuoepIigIgv5KC4Xr6j
         Q49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XFe/1tSyGMmtPubpZj8pFu6y/i9KhyipS8r0jxnTKd0=;
        b=otJ2V0tctysDVKm3fmA2VcwlsqQRepB4lcsZ7K0g34qQGe+K26KQsZ4eIgYNc7cyvl
         TNLv77rcsL0gUXa936wNPsSQLKj0pg67uahzyRecSXDsOAFKvuyKWo7DJ4TxWaVgcXvy
         6VgBwa3hE3UVRoNcL7LTiUFJ4jxLmVsvAQtJB4+L5kmBsmViz3wYVXLYsXS/gKTZ2/Uk
         Kj/4j08Ei5ONQSqfF87xKoEM83Ns0f0+sRzdkM2MgfhaiV94rqUCLFeOUCxZU/T3sCWz
         qgX++jNEhvZIOsArv8ZTndAXdANNQxg59Is+tHb6jsXQhDVwHPe5yTJ/zIkuEGW/4zVF
         LOKg==
X-Gm-Message-State: AOAM531aS7OZq/IkX2diOQJzZqbZgV8XtY4QZqNHh3L0ytmOsp/uenb4
        xHXVGJfQHuJqEbNjTRqgNFLeb5M3B+9Lsk3R2nI=
X-Google-Smtp-Source: ABdhPJwUkLsPH8Z3ZqFi2WD6eCBdAfhmE9uvRfJJ3R8th2Hdcag7MZPv8cylHYOy7P49k1Uo+FaoJO+coeclQANNcV0=
X-Received: by 2002:a05:6e02:f41:: with SMTP id y1mr13257263ilj.259.1617456224502;
 Sat, 03 Apr 2021 06:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
 <CAP8UFD17jQyUSui3Czs1b7BP_sj2jB3_LvWSdP4Sd=1N_5PBRA@mail.gmail.com>
In-Reply-To: <CAP8UFD17jQyUSui3Czs1b7BP_sj2jB3_LvWSdP4Sd=1N_5PBRA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Apr 2021 21:23:31 +0800
Message-ID: <CAOLTT8SBERx8ruHqqG+bL4iQxm0koP00=o_knqdo94cGfqazSQ@mail.gmail.com>
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Hariom verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Shourya Shukla <periperidip@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Christian,

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=882=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:57=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> On Fri, Apr 2, 2021 at 11:03 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Hello, Git,
> > I'm ZheNing Hu,
> > Here is my GSoC 2021 Proposal draft.
> > And website version is there :
> > https://docs.google.com/document/d/119k-Xa4CKOt5rC1gg1cqPr6H3MvdgTUiznd=
JGAo1Erk/edit
> >
> > Welcome any Comments and Correct :)
>
> Thanks!
>
> > ----8<----
> > ## Use ref-filter formats in git cat-file
> >
> > ### About Me
> > | Name | ZheNing Hu |
> > | ---------- | ------------------------------------------ |
> > | Major | Computer Science And Technology |
> > | Mobile no. | +86 15058356458 |
> > | Email | adlternative@gmail.com |
> > | IRC | adlternative (on #git-devel/#git@freenode) |
> > | Github | https://github.com/adlternative/ |
> > | Blogs | https://adlternative.github.io/ |
> > | Time Zone | CST (UTC +08:00) |
> >
> > ### Education & Background
> > * I am currently a 2nd Year Student majoring in computer science and
> > technology in Xi'an University of Posts & Telecommunications (China).
> > * In my freshman year, I joined the XiYou Linux Group of the
> > university and learned how to use Git to submit my own code to GitHub.
> > I have learned C, C++, Python and shell in two years, I know how to
> > use gdb debugging, and I am familiar with relevant knowledge of Linux
> > System Programming and Linux Network Programming.
> > * I started learning Git source code and made contributions to Git
> > from December of 2020.
> >
> > ### Me & Git
> > Around last November, I found a couple of projects
> > [build-your-own-git](https://github.com/danistefanovic/build-your-own-x=
#build-your-own-git)
> > on GitHub teaching me how to write a simple git, the mechanics of Git
> > are very interesting:
> >
> > 1. There are four types of objects in Git: BLOB, TREE, COMMIT, TAG
> > 2. The (loose)objects are stored in `.git/object/sha1[0-1]/sha1[2-39]`
> > with the sha1 value of the data as the storage address.
> > 3. All branches are just references to commits.
> >
> > Then I read`=E3=80=8APro Git=E3=80=8B`and Jiang Xin's `=E3=80=8AGit Aut=
horitative Guide=E3=80=8B`,
> > learned the use of most Git subcommands.
> >
> > Later, I started learning some of the Git source code, I found Git has
> > at least 200,000 lines of C code and 200,000 lines of shell script
> > code, which leaves me a little confused about where to start.
> >
> > But then, after I submitted my first patch, a lot of people in the Git
> > community came over and gave me very enthusiastic guidance, which gave
> > me the courage to learn the Git source code, and then I started making
> > my own contributions, You can find them here:
> > [gitgitgadget](https://github.com/gitgitgadget/git/pulls?q=3Dis%3Apr+au=
thor%3Aadlternative+)
> > or
> > [git.kernel.org](https://git.kernel.org/pub/scm/git/git.git/log/?qt=3Dg=
rep&q=3DZheNing+Hu)
> >
> >
> > These patches have been merged into the "master" branch:
> >
> > #### [master]
> > * difftool.c: learn a new way start at specified file [(mail
> > list)](https://lore.kernel.org/git/pull.870.v6.git.1613739235241.gitgit=
gadget@gmail.com/)
> > * ls-files.c: add --deduplicate option
> > [(mail list)](https://lore.kernel.org/git/384f77a4c188456854bd86335e9bd=
c8018097a5f.1611485667.git.gitgitgadget@gmail.com/)
> > * ls_files.c: consolidate two for loops into one
> > [(mail list)](https://lore.kernel.org/git/f9d5e44d2c08b9e3d05a73b0a6e52=
0ef7bb889c9.1611485667.git.gitgitgadget@gmail.com/)
> > * ls_files.c: bugfix for --deleted and --modified
> > [(mail list)](https://lore.kernel.org/git/8b02367a359e62d7721b9078ac839=
3a467d83724.1611485667.git.gitgitgadget@gmail.com/)
> > * builtin/*: update usage format
> > [(mail list)](https://lore.kernel.org/git/d3eb6dcff1468645560c16e1d8753=
002cbd7f143.1609944243.git.gitgitgadget@gmail.com/)
> >
> > And These patches are in the queue:
> >
> > #### [next]
> >
> > * format-patch: allow a non-integral version numbers
> > [(mail list)](https://lore.kernel.org/git/pull.885.v10.git.161649794642=
7.gitgitgadget@gmail.com/)
> > * [GSOC] commit: add --trailer option
> > [(mail list)](https://lore.kernel.org/git/pull.901.v14.git.161650775799=
9.gitgitgadget@gmail.com/)
> >
> > #### [WIP]
> >
> > * gitk: add right-click context menu for tags
> > [(mail list)](https://lore.kernel.org/git/pull.866.v5.git.1614227923637=
.gitgitgadget@gmail.com/)
> > * [GSOC] trailer: pass arg as positional parameter
> > [(mail list)](https://lore.kernel.org/git/5894d8c4b36466326b0427bfda0d6=
981e52a0907.1617185147.git.gitgitgadget@gmail.com/)
>
> Great!
>
> > ### Proposed Project
> >
> > * Git used to have an old problem of duplicated implementations of
> > some logic. For example, Git had at least 4 different implementations
> > to format command output for different commands.
>
> What's the current status? Which implementations have been merged
> together since that time?
>

Under the current situation,
there are `git cat-file` using `expand_format()` for format parsing,
and `git for-each-ref` using `format_ref_array_item()` for format parsing,
and `git log --pretty` using `format_commit_one()` item for format parsing,
maybe have more?

In my general understanding now, these `cat-file` atoms, `ref-filter` have
related implementations.

%(objectsize) %(objecttype) %(objectname) %(deltabase) %(objectsize:disk)

`cat-file --batch` have a implicit %(contents) ,it already implement
in `ref-filter`.

now all them can used by `git for-each-ref`.

At the same time,
Some of the feature in 'pretty.c' can also be found in 'ref-filter.c'.

`--pretty=3D%s`   to %(subject)
`--pretty=3D%f `   to %(subject:sanitized)
`--pretty=3D%aN` to %(authorname)
`--pretty=3D%b`   to %(body)
...

On the other hand, after Olga's solution was rejected, `git cat-file`
did not directly
use the logic in 'ref-filter'. So now we can see two similar 'struct
expand_data' in
'cat-file.c' and 'ref-filter.c'. But Olga still made many useful
changes in ref-filter:
such as `grab_common_values()` support for a variety of different atoms.

> > * `git cat-file` is a git subcommand used to see information about a gi=
t object.
> >
> > * `git cat-file --batch` can print object information and contents on
> > stdin.
>
> It reads from stdin and prints on stdout.
>
> > The only difference between `--batch-check` and `--batch` is
> > that `--batch-check` does not print the contents of the object.
> > * `--batch-all-objects` will show all objects with `--batch` or `--batc=
h-check`.
> > * `--batch-check` and `--batch` both accept formatted strings:
>
> It might be better to say that they accept a custom format that can
> have placeholders like the following:
>
> > * `%(objectname)`: 40-bit SHA1 string of Git object
>
> Git is being worked on to be able to use SHA-256 as well as SHA1.
>

Yes, one of my classmate was worried about the security of Git using
SHA1 and I told him Git is already making changes.

> > * `%(objecttype)`: Object Type blob,tree,commit,tag
> > * `%(objectsize)`: Size of the object's content
> > * `%(objectsize:disk)`: The size of the object itself on disk
> > * `%(delatbase)`: If the object is stored incrementally in Git,
>
> s/delatbase/deltabase/
>
> > Returns the SHA1 string for its delabase
>
> s/delabase/deltabase/
>

Thanks for above correcting.

> Also see above about SHA1 and SHA256.
>
> > * `%(rest)`: Anything before the space and TAB in the input
> > line is treated as an object, and anything after
> > that will be printed as usual
>
> In general it's ok to copy some parts of the doc if they are important
> for your proposal as long as you say that it comes from the doc. It's
> also ok with rephrasing parts of it, to adapt them or make sure you
> understand them though.
>

Maybe I can use the instructions in the documentation will be better.

> > * In the original design, the first time use `expand_format()` in
> > `batch_objects()` is to parsing formatted messages, the second time
>
> s/parsing/to parse/
>
> I am not sure what you call "formatted messages".
>

I'm not good at expression, As you say, it's a custom format that can have
placeholders,'%(atom)'.

> > use `expand_format()` in `batch_object_write()` is to format the
> > object information and store it in a string buffer, eventually the
> > contents of this buffer will be printed to standard output.
> >
> >
> > * [Olga](olyatelezhnaya@gmail.com) have been involved in integrating
> > `ref-filter` logic into `cat-file`
> > [(link)](https://github.com/git/git/pull/568), the problem with her
> > patches at that time:
> > 1. Too long patch series, difficult to adjust and merge.
> > 2. I don't think it's a good idea for her to use `struct
> > ref_array_item` instead of `struct expand_data` for `cat-file` to fit
> > `ref-filter` logic, because `struct ref_array_item` and `struct
> > expand_data` are not very related.
> > [(link)](https://github.com/git/git/pull/568/commits/e0aafaa76476ba5528=
f84b794043531ebd4633c7#diff-d03110606a7ed8cb9832bbcc572f1093435cc6115c4e58d=
7a7750af3c33319a7R238)
>
> Olga also sent patch series to the mailing list. Could you find them
> and tell what happened to them?
>

Peff tested the performance of Olga's `cat-file`, the performance of
`cat-file` appears to
be degraded by using the logic of ref-filter due "very eager to
allocate lots of separate strings".
[(link)](https://lore.kernel.org/git/20190228214112.GK12723@sigill.intra.pe=
ff.net/)

Olga add %(rest) to `for-each-ref`,
Peff say he is not sure that for-each-ref should be supporting %(rest).
[(link)](https://lore.kernel.org/git/20190228211122.GD12723@sigill.intra.pe=
ff.net/)

%(rest) seem not useful for `for-each-ref`,
Peff think we should add some option to ref-filter to enable/disable
placeholder like
"%(rest)" In some places where it is not needed at all.
[(link)](https://lore.kernel.org/git/20190228210753.GC12723@sigill.intra.pe=
ff.net/)

Olga make `struct expand_data` global,and put it in ref_filter.h
Peff say `struct expand_data` may need a more desciriptive name in
global namespace.
[(link)](https://lore.kernel.org/git/20190228213015.GI12723@sigill.intra.pe=
ff.net/)

Olga make `mark_query` and
Peff think `splict_on_whitespace` or `mark_query` can be deleted in
`struct expand_data` immediatly.
[(link)](https://lore.kernel.org/git/20190228212540.GF12723@sigill.intra.pe=
ff.net/)

> Also Hariom Verma worked on a related project recently. Could you talk
> a bit about it?
>

Hariom's work is re-use `ref-filter` logic in pretty.c|h,
I admin I might have neglected to look at his patches, but it seems
that he once also proposed
a "pretty-lib.c|h" for use ref-filter features.
[(link)](https://public-inbox.org/git/a83270485be2bebb1ce77be55ff73d136b735=
922.1592218662.git.gitgitgadget@gmail.com/)
I may need more time to check what's going on here.

> > * Because part of the feature of `git for-each-ref` is very similar to
> > that of `git cat-file`, I think `git cat-file` can learn some feasible
> > solutions from it.
> >
> > #### My possible solutions:
> >
> > 1. Same [solution](https://github.com/git/git/pull/568/commits/cc40c464=
e813fc7a6bd93a01661646114d694d76)
> > as Olga, add member `struct ref_format format` in `struct
> > batch_options`.
> > 2. Use the function
> > [`verify_ref_format()`](https://github.com/gitgitgadget/git/blob/84d06c=
dc06389ae7c462434cb7b1db0980f63860/ref-filter.c#L904)
> > to replace the first `expand_format()` for parsing format strings.
> > 3. Write a function like
> > [`format_ref_array_item()`](https://github.com/gitgitgadget/git/blob/84=
d06cdc06389ae7c462434cb7b1db0980f63860/ref-filter.c#L2392),
> > get information about objects, and use `get_object()` to grub the
> > information which we prefer (or just use `grab_common_value()`).
> > 4. The migration of `%(rest)` may require learning the handling of
> > `%(if)` ,`%(else)`.
>
> I will look at this later.
>
> > ### Are you applying for other Projects?
> >
> > No, Git is the only one.
> >
> > ### Blogging about Git
> >
> > In fact, while I am studying Git source code, I often write some
> > [blogs](https://adlternative.github.io/tags/git/) to record my
> > learning content, this helps me to recall some content after
> > forgetting it. Most of the blogs were written in Chinese previously,
> > but during the GSoC, I promise all my blogs will be written in
> > English.
> >
> > ### TimeLine
> > * May 18 ~ June 8
> > * Look for a scheme to make `git cat-file` and `ref-filter` more
> > compatible, and start the integration attempt.
> > * *Stretch Goal*: move `%(objectsize)`,`%(objecttype)`,`%(objectname)` =
.
> >
> > * June 8 ~ July 8
> > * Move the body of the `git cat-file` attempt to the `ref-filter`
> > logic, complete the basic function realization.
> > * *Stretch Goal*: move `%(deltabase)`,`%(objectsize:disk)`,`%(rest)` .
> >
> > * July 8 ~ August 17
> > * Analyze the performance of ref-filter and try to reduce the
> > performance cost of a lot of string matching. I thought if I had some
> > spare time, I could work on some other interesting patches.
> > * *Stretch Goal*: Optimize ref-filter performance.
>
> I will also look at the timeline later.
>
> > ### Availability
> > My exam is expected to end in June, but the time I don't have classes
> > before the final exam, as well as the summer vacation after that, is
> > basically my self-learning time. Although I am studying many other
> > courses, I have enough time and energy to complete daily tasks. I'm
> > staying active on the Git mailing list, you can find me at any time as
> > long as I am not sleeping. :)
> >
> >
> > ### Post GSoC
> > * I love open source philosophy, willing to spread the spirit of
> > openness, freedom and willing to research technology with like-minded
> > people.
> > * In my previous contact with the Git community in the past few
> > months, many people in the Git community gave me great encouragement.
> > I hope I can keep my passion for Git alive, contribute my own code,
> > and pass this cool thing on.
> > * I am willing to contribute code to the Git community for a long time
> > after the end of GSoC.
> > * I hope the Git community can give me a chance to participate in
> > GSoC. I sincerely thank GSoC and the Git community!
>
> Thanks!

Thanks :)
