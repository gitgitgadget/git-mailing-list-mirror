Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920FD20248
	for <e@80x24.org>; Mon,  8 Apr 2019 16:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDHQma (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 12:42:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37233 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDHQma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 12:42:30 -0400
Received: by mail-io1-f65.google.com with SMTP id x7so11624876ioh.4
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=61bSLufu9uDXnf0s7JImrotOMKcyhsWGxDNE4vqh0Yw=;
        b=TmXGzLMppi6xAPh1t3WaPOR3QiAZEroh4xEfhcp8tpTysxHMFOeeZmIyMnpNmjehXN
         PopdaF0p6MQk9OxYV3h5l7a8WUCN99ouaU84YDiknbEMvHSn4g63yAMl/zXlS6B82EJN
         5a47xfWBQ0N0t4odIMWHgK0iCe3YHk9RNq8+C363ayZ2hQz8FdYqtooNkPbHPPBnZNef
         5mRfXz7cviny9+7kgvJLgk2TyahsE0C61gbMFIEF6LSJi0/pX2GqW72XGjvLMiP2ceuA
         1XRQ8qiLYqHWPZDM5FEpDSmX9hG5jC/WAPZU5CU6wn2ZIwREC9I0pr8PIJABJD4I/0qp
         pHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=61bSLufu9uDXnf0s7JImrotOMKcyhsWGxDNE4vqh0Yw=;
        b=MO8ZpbNJ892dL3wnKF6bUlnry4/R6x9VDS8gaw4Elz2dpPiIVvSrxUHmsZu8L6CLP0
         RkoFmngLN2WoWp//ywemYS7xwvDNpU0DK5lUzP08uS0WZ7bPaFY/37LvsATbClBH7BU/
         iuuIVg61a4SOnOajJkMhRtynmUr9YgzSkx702psrkqWJ3SSiNUfxEPwgavtAM/cOLRgJ
         env5k5YKAtetefXyehinViTJ3fMFBfHA5nMjZw1ZQZk539N4IrpheVZpkw67hPw/K9CW
         d4PI01vtYCuf5tnqsEK4sk27vSqST1yITX5TnrJAx8o5NuIE8V4DXtTTpRZmvHf6E3Zl
         VzMw==
X-Gm-Message-State: APjAAAWgb+CcLvOWYcI/irTSPJR1BYr2xhkKUgxBBzd9rsmOV9xH9J8J
        a25t0lSz/jrecdUwTnJg44F6M0hkCQK6clq4b5k+gQ==
X-Google-Smtp-Source: APXvYqyUSswiHbMqWa8eui4ot45E/GrTetmQXn/wBtZlIZfCB2gtOaCRA9F4e8LRNMnqkO6UdWzJEFhFLB/UHBCiHag=
X-Received: by 2002:a6b:c981:: with SMTP id z123mr17942916iof.123.1554741748529;
 Mon, 08 Apr 2019 09:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
In-Reply-To: <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 8 Apr 2019 13:42:17 -0300
Message-ID: <CAHd-oW7UQdmyeODUOPdjMnmumFaQZ7_bzB2-x=crN92arSOejQ@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 7, 2019 at 7:52 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Matheus
>
> On Sun, Apr 7, 2019 at 10:48 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > This is my proposal for GSoC with the subject "Make pack access code
> > thread-safe".
>
> Thanks!
>
> > I'm late in schedule but I would like to ask for your
> > comments on it. Any feedback will be highly appreciated.
> >
> > The "rendered" version can be seen here:
> > https://docs.google.com/document/d/1QXT3iiI5zjwusplcZNf6IbYc04-9diziVKd=
OGkTHeIU/edit?usp=3Dsharing
>
> Thanks for the link!
>
> > Besides administrative questions and contributions to FLOSS projects, a=
t
> > FLUSP, I=E2=80=99ve been mentoring people who want to start contributin=
g to the
> > Linux Kernel and now, to Git, as well.
>
> Nice! Do you have links about that?

Unfortunately not :( Maybe just the mentoring slides (e.g.
https://flusp.ime.usp.br/materials/Kernel_Primeiros_Passos.pdf). But
they are all in Portuguese, so I don't know wether it would be
valuable to add them here...

> > # The Project
> >
> > As direct as possible, the goal with this project is to make more of
> > Git=E2=80=99s codebase thread-safe, so that we can improve parallelism =
in
> > various commands. The motivation behind this are the complaints from
> > developers experiencing slow Git commands when working with large
> > repositories[1], such as chromium and Android. And since nowadays, most
> > personal computers have multi-core CPUs, it is a natural step trying to
> > improve parallel support so that we can better use the available resour=
ces.
> >
> > With this in mind, pack access code is a good target for improvement,
> > since it=E2=80=99s used by many Git commands (e.g., checkout, grep, bla=
me, diff,
> > log, etc.). This section of the codebase is still sequential and has
> > many global states, which should be protected before we can work to
> > improve parallelism.
>
> I think it's better if global state can be made local or perhaps
> removed, rather than protected (though of course that's not always
> possible).

Indeed! I just added this to the docs version. Thanks

> > ## The Pack Access Code
> >
> > To better describe what the pack access code is, we must talk about
> > Git=E2=80=99s object storing (in a simplified way):
>
> Maybe s/storing/storage/

Thanks. Already changed.

> > Besides what are called loose objects,
>
> s/loose object/loose object files/

Done, thanks!

> > Git has a very optimized mechanism to compactly store
> > objects (blobs, trees, commits, etc.) in packfiles[2]. These files are
> > created by[3]:
> >
> > 1. listing objects;
> > 2. sorting the list with some good heuristics;
> > 3. traversing the list with a sliding window to find similar objects in
> > the window, in order to do delta decomposing;
> > 4. compress the objects with zlib and write them to the packfile.
> >
> > What we are calling pack access code in this document, is the set of
> > functions responsible for retrieving the objects stored at the
> > packfiles. This process consists, roughly speaking, in three parts:
> >
> > 1. Locate and read the blob from packfile, using the index file;
> > 2. If the blob is a delta, locate and read the base object to apply the
> > delta on top of it;
> > 3. Once the full content is read, decompress it (using zlib inflate).
> >
> > Note: There is a delta cache for the second step so that if another
> > delta depends on the same base object, it is already in memory. This
> > cache is global; also, the sliding windows, are global per packfile.
>
> Yeah, but the sliding windows are used only when creating pack files,
> not when reading them, right?
>
> > If these steps were thread-safe, the ability to perform the delta
> > reconstruction (together with the delta cache lookup) and zlib inflatio=
n
> > in parallel could bring a good speedup. At git-blame, for example,
> > 24%[4] of the time is spent in the call stack originated at
> > read_object_file_extended. Not only this but once we have this big
> > section of the codebase thread-safe, we can work to parallelize even
> > more work at higher levels of the call stack. Therefore, with this
> > project, we aim to make room for many future optimizations in many Git
> > commands.
>
> Nice.
>
> > # Plan
> >
> > I will probably be working mainly with packfile.c, sha1-file.c,
> > object-store.h, object.c and pack.h, however, I may also need to tackle
> > other files. I will be focusing on the following three pack access call
> > chains, found in git-grep and/or git-blame:
> >
> > read_object_file =E2=86=92 repo_read_object_file =E2=86=92 read_object_=
file_extended =E2=86=92
> > read_object =E2=86=92 oid_object_info_extended =E2=86=92 find_pack_entr=
y =E2=86=92
> > fill_pack_entry =E2=86=92 find_pack_entry_one =E2=86=92 bsearch_pack an=
d
> > nth_packed_object_offset
> >
> > oid_object_info =E2=86=92 oid_object_info_extended =E2=86=92 <same as p=
revious>
> >
> > read_object_with_reference =E2=86=92 read_object_file =E2=86=92 <same a=
s previous>
> >
> > Ideally, at the end of the project, it will be possible to call
> > read_object_file, oid_object_info and read_object_with_reference with
> > thread-safety, so that these operations can be, latter, performed in
> > parallel.
> >
> > Here are some threads on Git=E2=80=99s mailing list where I started dis=
cussing
> > my project:
> >
> > * https://public-inbox.org/git/CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00d=
U8iaoc+b8=3DQ@mail.gmail.com/
> > * https://public-inbox.org/git/20190402005245.4983-1-matheus.bernardino=
@usp.br/#t
> >
> > And also, a previous attempt to make part of the pack access code
> > thread-safe which I may use as a base:
> >
> > * https://public-inbox.org/git/20140212015727.1D63A403D3@wince.sfo.corp=
.google.com/#Z30builtin:gc.c
>
> Nice.
>
> > # Points to work on
> >
> > * Investigate pack access call chains and look for non-thread-safe
> > operations on then.
> > * Protect packfile.c read-and-write global variables, such as
> > pack_open_windows, pack_open_fds and etc., using mutexes.
>
> Do you want to work on making both packfile reading and packfile
> writing thread safe? Or just packfile reading?

I plan to work on packfile reading, only.

> If some variables are used for both reading and writing packfiles, do
> you plan to protect them only when they are used for reading?

Hm, I haven't thought of that before. But indeed, if they are used for
both, I think I should protect them in both cases.

> The rest of your proposal looks very good to me. Please make sure you
> upload this or an updated version soon to the GSoC web site.

Thanks, Christian. I will work on the final points today and submit it.

> Thanks,
> Christian.
