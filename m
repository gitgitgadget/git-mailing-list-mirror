Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9887C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 08:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1420619B1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 08:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCWIyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 04:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhCWIyK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 04:54:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D126C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 01:54:10 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x2so16219094oiv.2
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ad/6AdNNE1AA9gvI8LM9Z92aKIAeke3FrQFYXGzjVMI=;
        b=SApi0kZBLX1e8g+XHHuD6PEom1CGkPai4Tyf6YDkoAlcrJmItt5FnThopw+6X+i8bN
         XgF5eWnF6SlvD5SM2kDBimrlgayZ8nNRLlUPxxb0tFS7BS+6cpw+najHEObwy/NT9yQx
         2iioq8bYapQty48yF6/o0oaKOShn0rGbC0proHcBjIyIlxeo1jHzF1zM2bziaAVIf/kf
         gTAuXKZvRxhVRNzg+24nx7LmRRuJtdqlpL3wNqsiIv+kb6zwXD1f9shIsCtnRnsEnzzQ
         x/lJPW5h+LJ2SKlN81CjqI8G6qVXU7NlO/8qITOF3vyaegQ042b94EADVf303dDKuueo
         26TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ad/6AdNNE1AA9gvI8LM9Z92aKIAeke3FrQFYXGzjVMI=;
        b=bC8UEwqz3PhSDTXzFb0A0Bc1LL8XYCIygizYFK4O+0umQH/JdlIeiSNLRQnvnbiYjx
         aClc7zOGf3GNZ8CZocpgHbV03K+pKR66k+EGQYqHhFD+KBFv97g/PHvIemK6wUfBchan
         iDi3VyP+Wvv2fhjzQmwSfuYmKpV4NR/l1zUI4E4HgYGY6sz/CiN2TvfxQsJ9KIg74Esh
         gsJHn5NAH/nSb3AtPmlgNiW6obWM2hDbHv8b6jcuRYxD6ASAJuk4cOH+iPViutdRK2rU
         PzdYDiL5fkx9rGd9UVHEAypfLfE7bGF6xrD+7GvtrWMe8B5BqlFz6XHVlSoSelTWLr3w
         g74g==
X-Gm-Message-State: AOAM530kFR0MkihEBL1AmcBTrMVoXW0SDe1vIdeypyUQApxMp8FCh1gn
        s5cEY+FHlt75HhXtUZMqUioxYdf6WBVI227ymlw=
X-Google-Smtp-Source: ABdhPJz1etHVVIG+ZKDcb0p3ntbfrnuAwCvTFTd2rjXTO6s17PjajkPtelEhCtK3GCf1Yi0/cRtGO0ruX42Gs5Z0ls4=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr2674978oia.44.1616489649574;
 Tue, 23 Mar 2021 01:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
 <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com> <CAPig+cQ5jBc-fz69ygpWUP7uCVNAT8GT_01y6GnxDEa6XDNZ=g@mail.gmail.com>
In-Reply-To: <CAPig+cQ5jBc-fz69ygpWUP7uCVNAT8GT_01y6GnxDEa6XDNZ=g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 23 Mar 2021 16:53:53 +0800
Message-ID: <CAOLTT8QrqDFj+ZGFRqDWDixj6hvdsF8OqYsac5J9WP2Yc+zXRQ@mail.gmail.com>
Subject: Re: [PATCH v9] format-patch: allow a non-integral version numbers
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:31=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Sun, Mar 21, 2021 at 5:00 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > [...]
> > Allow `format-patch` to take such a non-integral iteration
> > number.
> > [...]
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>
> Just a few nits below; nothing very important (except perhaps the
> final comment about the potential for people to get confused while
> reading the tests). Junio already has this marked as ready to merge to
> "next", so these nits may not be worth a re-roll.
>

Thanks, Eric, these suggestions are worth considering.

> > diff --git a/log-tree.c b/log-tree.c
> > @@ -368,9 +368,14 @@ void fmt_output_subject(struct strbuf *filename,
> >         int max_len =3D start_len + info->patch_name_max - (strlen(suff=
ix) + 1);
> > +       struct strbuf temp =3D STRBUF_INIT;
> >
> > +       if (info->reroll_count) {
> > +               strbuf_addf(&temp, "v%s", info->reroll_count);
> > +               format_sanitized_subject(filename, temp.buf, temp.len);
> > +               strbuf_addstr(filename, "-");
> > +               strbuf_release(&temp);
> > +       }
>
> The new `temp` strbuf is use only inside the conditional, so it
> could/should have been declared in that block rather than in the outer
> block:
>

Sometimes I always forget this: which variables need to be placed locally,
It seems that I have to be more careful.

>     if (info->reroll_count) {
>         struct strbuf temp =3D STRBUF_INIT;
>
>         strbuf_addf(&temp, "v%s", info->reroll_count);
>         ...
>     }
>
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > @@ -378,6 +378,22 @@ test_expect_success 'reroll count' '
> > +test_expect_success 'reroll count with a fractional number' '
> > +       rm -fr patches &&
> > +       git format-patch -o patches --cover-letter --reroll-count 4.4 m=
ain..side >list &&
> > +       ! grep -v "^patches/v4.4-000[0-3]-" list &&
> > +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> > +       ! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
> > +'
> > +
> > +test_expect_success 'reroll count with a non number' '
> > +       rm -fr patches &&
> > +       git format-patch -o patches --cover-letter --reroll-count 4rev2=
 main..side >list &&
> > +       ! grep -v "^patches/v4rev2-000[0-3]-" list &&
> > +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> > +       ! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
> > +'
>
> The above two tests...
>
> > @@ -386,6 +402,38 @@ test_expect_success 'reroll count (-v)' '
> > +test_expect_success 'reroll count (-v) with a fractional number' '
> > +       rm -fr patches &&
> > +       git format-patch -o patches --cover-letter -v4.4 main..side >li=
st &&
> > +       ! grep -v "^patches/v4.4-000[0-3]-" list &&
> > +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> > +       ! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
> > +'
> > +
> > +test_expect_success 'reroll (-v) count with a non number' '
> > +       rm -fr patches &&
> > +       git format-patch -o patches --cover-letter -v4rev2 main..side >=
list &&
> > +       ! grep -v "^patches/v4rev2-000[0-3]-" list &&
> > +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> > +       ! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
> > +'
>
> ... are repeated here with the only difference being `--reroll-count`
> versus `-v`. Since other tests have already established that
> `--reroll-count` and `-v` are identical, it's not really necessary to
> do that work again with these duplicate tests.
>

Makes sense.

> > +test_expect_success 'reroll (-v) count with a "injection (1)"' '
> > +       rm -fr patches &&
> > +       git format-patch -o patches --cover-letter -v4..././../1/.2//  =
main..side >list &&
> > +       ! grep -v "^patches/v4.-.-.-1-.2-000[0-3]-" list &&
> > +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> > +       ! grep -v "^Subject: \[PATCH v4..././../1/.2// [0-3]/3\] " subj=
ects
> > +'
>
> A couple comments:
>
> The test title might be easier for other people to understand if it
> says "non-pathname character" or "non filename character" rather than
> "injection".
>
> Note that the `grep -v` is casting a wider net than it seems at first
> glance. The `.` matches any character, not just a period ".". To
> tighten the matching and make `.` match just a ".", you can use `grep
> -vF`.
>

Yes, `grep -vF` is very important for the correctness of the test.

> > +test_expect_success 'reroll (-v) count with a "injection (2)"' '
> > +       rm -fr patches &&
> > +       git format-patch -o patches --cover-letter -v4-----//1//--.--  =
main..side >list &&
> > +       ! grep -v "^patches/v4-1-000[0-3]-" list &&
> > +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> > +       ! grep -v "^Subject: \[PATCH v4-----//1//--.-- [0-3]/3\] " subj=
ects
> > +'
>
> Presumably the coverage of format_sanitized_subject() is already being
> tested elsewhere, so it's not clear that this second "injection" test
> adds any value over the first test. Moreover, this second test can
> confuse readers into thinking that it is testing something that the
> first test didn't cover, but that isn't the case (as far as I can
> tell).

The second test I just want to test character `-`, but now I think it can
merge to first test.

Thanks.
