Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039C1C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 01:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE41B61159
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 01:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhIVBci (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 21:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhIVBch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 21:32:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B686C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 18:31:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p29so5023620lfa.11
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z0pP0a81Gq1dZnA6cwIgzvr78sYeNwiMhNRC4nPdYJY=;
        b=EyqaZ6yyC5Qm9YsctbSHbEXgEI2aQWosSFb2xTIv54kfEnx6Zmh/gN2tPvSIdTXeU4
         e0R6vLUJdA0SDGDhhgk4rjut3nPH/gyAlCa3Y7cH3OXI0LquHVgMSQeO2xAUuqwpjCV4
         v1l1JQu/WrI2jXMdmr1kL4rl4tFM5BFfvuXAcJo1WxH/XP6krFUaNkh3yqyP2Mx6okfb
         7F3ZBiQi6E5kKVHtlmX/JoV0S6sPSRHonm+BKBJPsNZcx0LsFP9buIA1ETF2M1vaFTOc
         lSnLDudl8gH6ZxPPCt8NOz0l7UiSyoHveWLvtnARnb1EYLqn/hKHYz5o/7EDn2GIj5oe
         93Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z0pP0a81Gq1dZnA6cwIgzvr78sYeNwiMhNRC4nPdYJY=;
        b=lySLnsRlGja+AUuALOsUsyj4OasFkarp/1WVpdS++m1/Y18V/s5J6MZ+VuEagvF8z8
         Q3ShotzZVqES6dQOxwZdmOfsBzq1CPBnio5JNugFKA+xTvC9+hRS4mHhIWkZU3cwc0ES
         2s9JL7oWzG2DV4M5cHaCmsC+eoKIZ61NwoiRUOl+zpzLwM559y3Oqxmy6oCqYGyp1+3O
         6hacDVEoyHP9ApTVssD8VnIObTD2U0FqguBKam51jUPWFnCGyLBTpkxTbq3WfIMVZXom
         NV5YuTsAE9J2jjIfTcEDl+h/baLjoq8XsokNtPlVAZCPohFgZuUrxclH80n+T6GeMxNC
         w5jg==
X-Gm-Message-State: AOAM533dKF1dYVeKb1Bfv/XGMpXTrZWlkHCLhMfC92J8ztvDpLG7ht0h
        0d8BBlj5ul586oYcW7emQoZWGarcEcfjFJZRrPE=
X-Google-Smtp-Source: ABdhPJxyzI5mrUyD+criBAIIWyldnG2hc6y/Q3h8bY4jQ4PhVfx2s1g6K5Sx6Vsoujn3jzgvYQDYcZHduG3HhYmGCKA=
X-Received: by 2002:a2e:7d07:: with SMTP id y7mr580477ljc.406.1632274266545;
 Tue, 21 Sep 2021 18:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com> <afb0028e79648c1f7be8d77df5c6d675bd27d983.1632176111.git.gitgitgadget@gmail.com>
 <87a6k58or9.fsf@evledraar.gmail.com>
In-Reply-To: <87a6k58or9.fsf@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 21 Sep 2021 18:30:55 -0700
Message-ID: <CANQDOdc3R0H_DS9eqh9vK7JA6=2LsB6q9mANgMgrtbOwp7Fvwg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] core.fsyncobjectfiles: tests for batch mode
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 4:58 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Add test cases to exercise batch mode for 'git add'
> > and 'git stash'. These tests ensure that the added
> > data winds up in the object database.
> >
> > I verified the tests by introducing an incorrect rename
> > in do_sync_and_rename.
> >
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > ---
> >  t/lib-unique-files.sh | 34 ++++++++++++++++++++++++++++++++++
> >  t/t3700-add.sh        | 11 +++++++++++
> >  t/t3903-stash.sh      | 14 ++++++++++++++
> >  3 files changed, 59 insertions(+)
> >  create mode 100644 t/lib-unique-files.sh
> >
> > diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
> > new file mode 100644
> > index 00000000000..a8a25eba61d
> > --- /dev/null
> > +++ b/t/lib-unique-files.sh
> > @@ -0,0 +1,34 @@
> > +# Helper to create files with unique contents
> > +
> > +test_create_unique_files_base__=3D$(date -u)
> > +test_create_unique_files_counter__=3D0
> > +
> > +# Create multiple files with unique contents. Takes the number of
> > +# directories, the number of files in each directory, and the base
> > +# directory.
> > +#
> > +# test_create_unique_files 2 3 . -- Creates 2 directories with 3 files
> > +#                                each in the specified directory, all
> > +#                                with unique contents.
> > +
> > +test_create_unique_files() {
> > +     test "$#" -ne 3 && BUG "3 param"
> > +
> > +     local dirs=3D$1
> > +     local files=3D$2
> > +     local basedir=3D$3
> > +
> > +     rm -rf $basedir >/dev/null
>
> Why the >/dev/null? It's not a "-rfv", and any errors would go to
> stderr.

Will fix. Clearly I don't know UNIX very well.

>
> > +             mkdir -p "$dir" > /dev/null
>
> Ditto.

Will fix.

>
> > +             for j in $(test_seq $files)
> > +             do
> > +                     test_create_unique_files_counter__=3D$((test_crea=
te_unique_files_counter__ + 1))
> > +                     echo "$test_create_unique_files_base__.$test_crea=
te_unique_files_counter__"  >"$dir/file$j.txt"
>
> Would be much more readable if we these variables were shorter.
>
> But actually, why are we trying to create files as a function of "date
> -u" at all? This is all in the trash directory, which is rm -rf'd beween
> runs, why aren't names created with test_seq or whatever OK? I.e. just
> 1.txt, 2.txt....
>

The uniqueness is in the contents of the file.  I wanted to make sure that
we are really creating new objects and not reusing old ones.  Is the scope
of the "trash repo" small enough that I can be guaranteed that a new one
is created before my test since the last time I tried adding something to
the ODB?

> > +test_expect_success 'stash with core.fsyncobjectfiles=3Dbatch' "
> > +     test_create_unique_files 2 4 fsync-files &&
> > +     git -c core.fsyncobjectfiles=3Dbatch stash push -u -- ./fsync-fil=
es/ &&
> > +     rm -f fsynced_files &&
> > +
> > +     # The files were untracked, so use the third parent,
> > +     # which contains the untracked files
> > +     git ls-tree -r stash^3 -- ./fsync-files/ > fsynced_files &&
> > +     test_line_count =3D 8 fsynced_files &&
> > +     cat fsynced_files | awk '{print \$3}' | xargs -n1 git cat-file -e
> > +"
> > +
> > +
> >  test_expect_success 'stash -c stash.useBuiltin=3Dfalse warning ' '
> >       expected=3D"stash.useBuiltin support has been removed" &&
>
> We really prefer our tests to create the same data each time if
> possible, but as noted with the "date -u" comment above you're
> explicitly bypassing that, but I still can't see why...

I'm trying to make sure we get new object contents. Is there a better
way to achieve what I want without the risk of finding that the contents
are already in the database from a previous test run?

Thanks again for the thorough review,
-Neeraj
