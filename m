Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30480C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E3560E08
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhGLND7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhGLND7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:03:59 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166D9C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:01:11 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h3so19279173ilc.9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zWGf6CNGdm29/sHG39GcpHa9LtGc+Dtas//OdavB3n0=;
        b=qBKARRnEnjzm18CiC7UGTreRkqcxlk6R4FzR2EK5vox8TSyOg0mrqwhNw4t1f7RuWW
         D0/mTernm2usS2AWWuJLFZ70bh6phpH0JROgs7+v3ezeQy2BwJXGemWusZ+ab0i9PJbo
         s2zJtCpqnGKrAssqBw7cbErvd9vQtNUQdenh+TPG2MlJS34F103KWoi80p+Xn7cMaP1r
         2y87tygsucRrHkXP411MKE2xA8/dhDpupBGwI7mo06rfV2PQW8HTuYB52N3L25I7sakP
         lPZ0al+LAMeL+JSwW5LNhtGPf/up7tdnmF9M/0ImoiKmH/mQNR8WWWFg8l9JZfH7JAjg
         IxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zWGf6CNGdm29/sHG39GcpHa9LtGc+Dtas//OdavB3n0=;
        b=jxHq4QqwvMGgoibXFVZuiJlxE3TwyyDaxAHPVNYc/el5v2v0iWCaOSeU4BqDuSJC3w
         LbesF3krq5T3gpuZhOPX1q2ndErzK8BTMf3TyUJBP2oHFKbYXa2YDtqFJ5fhB1Eib6mJ
         Bfo25PL8osSasrt0jkO8PjL8TNH4THI0NsTTkRNtFMAPapRtaZQTHQHisnQ2uY7f0Jid
         2pDvJtrAjZ4rY6PFDapBhnnDm/vfKLbXABgTv4ZgofRU3a+6ArdXU1Y5v+djGSmo56e8
         1dD4ySCmgXlVmMziTKqrystFj0p4Ci1iTPfvMhFWe+Z2QIy4SHBJ7XioB2McUcHHaRTR
         7/hQ==
X-Gm-Message-State: AOAM532zx93sFFuDy7EClO1Hnwj7yB9/RShektfRQg/TQG0mVI2eA9DZ
        FEySYK0trH63mNE6lsly+qCI/ScTLa7CaH+Hk6A=
X-Google-Smtp-Source: ABdhPJzKhKIdvD6+KKqF8Wo/hZGmq71P7m4vgkxRGMGb3j60nVJGEhRV6X1UNBdpHezkoXAw8vZPw8iZboT2xleRmsI=
X-Received: by 2002:a92:a806:: with SMTP id o6mr38513708ilh.53.1626094870264;
 Mon, 12 Jul 2021 06:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com> <CAP8UFD2gfwB-bEgj6pd__2zkSU20rxr3qN8HOYuLaQYmcuCynw@mail.gmail.com>
In-Reply-To: <CAP8UFD2gfwB-bEgj6pd__2zkSU20rxr3qN8HOYuLaQYmcuCynw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 12 Jul 2021 21:01:19 +0800
Message-ID: <CAOLTT8TwwBQ+OXAgVvGSOQiM19GWy+Y=m1QxQ8nc6SaE=1x=9w@mail.gmail.com>
Subject: Re: [PATCH 00/19] [GSOC] cat-file: reuse ref-filter logic
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:36=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Jul 12, 2021 at 1:47 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > This patch series make cat-file reuse ref-filter logic.
>
> s/make/makes/
>
> By the way if you have already sent some of the patches in this series
> (and if they haven't changed much since when you sent them), it's a
> good idea to use V2 or V3, V4, etc, so we can easily refer to each of
> the versions you sent. (See the `-v` option of `git format-patch`.)
>

Yes, but my patch was generated by gitgitgadget, when I want to send
a new patch which is totally different with before, I will send a new PR.
GGG will not know the connection between these two PRs. So the
version number of the patch will be reset.

> > Change from last version:
> >
> >  1. Declare buf_size in if (atom_type =3D=3D ATOM_RAW) block.
> >  2. Modify the code style of the test.
> >  3. Delete "use_textconv" and "use_filter" flag. Instead, add member
>
> s/flag/flags/
>
> >     cat_file_cmdmode to struct ref_array_item.
> >  4. Add function reject_atom() to enhance the readability of the code.
> >  5. Create p1006-cat-file.sh for performance regression testing.
> >  6. Use a "fast path" to output object data to reduce the performance
> >     degradation of cat-file --batch with the suggest of =C3=86var Arnfj=
=C3=B6r=C3=B0
> >     Bjarmason.
>
> Maybe:
>
> s/with the suggest of =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason/as suggested=
 by =C3=86var
> Arnfj=C3=B6r=C3=B0 Bjarmason/
>
> or:
>
> s/with the suggest of =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason/according to=
 =C3=86var
> Arnfj=C3=B6r=C3=B0 Bjarmason's suggestion/
>
>
> > ZheNing Hu (19):
> >   cat-file: handle trivial --batch format with --batch-all-objects
> >   cat-file: merge two block into one
>
> It's a bit strange that the above 2 don't have [GSOC] while the others
> below have it.
>

That's because it's belong to the branch zh/cat-file-batch-fix. I
should mention it
in the cover-letter.

> >   [GSOC] ref-filter: add obj-type check in grab contents
> >   [GSOC] ref-filter: add %(raw) atom
> >   [GSOC] ref-filter: --format=3D%(raw) re-support --perl
> >   [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
> >   [GSOC] ref-filter: add %(rest) atom
> >   [GSOC] ref-filter: pass get_object() return value to their callers
> >   [GSOC] ref-filter: introduce free_ref_array_item_value() function
> >   [GSOC] ref-filter: introduce reject_atom()
> >   [GSOC] ref-filter: modify the error message and value in get_object
> >   [GSOC] cat-file: add has_object_file() check
> >   [GSOC] cat-file: change batch_objects parameter name
> >   [GSOC] cat-file: reuse ref-filter logic
> >   [GSOC] cat-file: reuse err buf in batch_object_write()
> >   [GSOC] cat-file: re-implement --textconv, --filters options
> >   [GSOC] ref-filter: remove grab_oid() function
> >   [GSOC] cat-file: create p1006-cat-file.sh
>
> Maybe you could add the new perf test earlier in the series so that we
> could see how performance changes when ref-filter logic is reused in
> cat-file earlier in the series.

Make sence.

>
> >   [GSOC] cat-file: use fast path when using default_format

Thanks.
--
ZheNing Hu
