Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F38C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiGKPPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGKPPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 11:15:02 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ACB23BE2
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:15:01 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n68so5201324iod.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3MWOvKp7Ab83DaFR9/2nDqgtcX+UU1/xo6C1hf1wOxk=;
        b=ixtXqDaEMDN1MPnYfbsOQWp+UOidRbyTEwIJf7KJUp5tdydPi5ZQPMkAVUGGbkTwwE
         aZPwoLzVYz5smjbU2lJ3HN/1+YUVlwETu5V4C5rJ3QoGG5jz6F8l/B+MZ2wGYx2GDu8L
         m7UiiHbmwSOea/Awq2i0c4NU6sJEPJ4TWlGpt7MQD+jF11WRg/LoIDoNlVx8MxebOV3x
         A6nsTjTCRC+cCh9hsalDb0Qffrrp9F3YG6W2NAAj7n89Iqazygmd1bXiavLCVsGkTU/c
         P3AXxYdAVHO5hWlOeoYVXQ8W9myQgGt1by8C59Ujh/DSS2Uo2wp1v584+ELA5icFuEDx
         U00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3MWOvKp7Ab83DaFR9/2nDqgtcX+UU1/xo6C1hf1wOxk=;
        b=mAT3P1DgtofWo9fKyGsMMmYbrTX0SF/JB8WmDc/SBEYIeGNhm1Zb6txKF2PXsd5ccP
         5VdOsBGKEQAfHOkV3dsJctyk6GtBJ2TrEl8vKyo1ZZWa0tDSDvlbfyBjkzpt1Kc3VfIK
         73/p+D4/nJ2XqHRF0HAgPGUvJkG2JgehS4RO5qzz+Qgiti49/3wlHBP4vWb10ZS7LJ+/
         NIs5k186CjBGSxZye6XO9IDlEas+IlQ6zdZHiF8ZmIffO79HN0CVrLn1z1v9pOBeYYYx
         FTLFtqlu685xyFYjPY4eXWKSlFqYZPNkDCM9YOHf7iOIJdug31SR8RtHvIi/JqNvgbE4
         diMg==
X-Gm-Message-State: AJIora/q9P9aGKIcs9jBS93us3crWK0RKUy3Vu0VQbF3epOWczN3P6lK
        SG+c/0OycWb8n/wkR4+g7ZMChzX/9OZzaGc4LSO/LsxMpqi/iA==
X-Google-Smtp-Source: AGRyM1t/f9yWWLi4I8RnzA8ITggj2uFUjUHIJmz/VNaPD5c3hh6Y115DOtqjgsaxSti3bAyoPe3JpmbATdfMqRnsPr4=
X-Received: by 2002:a05:6638:339b:b0:33f:5a4c:4d8e with SMTP id
 h27-20020a056638339b00b0033f5a4c4d8emr2355225jav.93.1657552501019; Mon, 11
 Jul 2022 08:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
 <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com> <220705.86sfng9c5a.gmgdl@evledraar.gmail.com>
In-Reply-To: <220705.86sfng9c5a.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 11 Jul 2022 23:14:49 +0800
Message-ID: <CAOLTT8Q+-Tr9-X=DBmf7wExT3L3DtAXzpmoV+dqfrY-nouP5pg@mail.gmail.com>
Subject: Re: [PATCH v5] ls-files: introduce "--format" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B47=E6=9C=885=E6=97=A5=E5=91=A8=E4=BA=8C 16:50=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Tue, Jul 05 2022, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Add a new option --format that output index enties
> > informations with custom format, taking inspiration
> > from the option with the same name in the `git ls-tree`
> > command.
> >
> > --format cannot used with -s, -o, -k, -t, --resolve-undo,
> > --deduplicate and --eol.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     ls-files: introduce "--format" options
> >
> >     v4->v5:
> >
> >      1. Let --format incompatible with -t.
> >      2. Fix %(eolinfo) and %(eolattr) docs suggested by Junio.
> >
> >     Looking forward to =C3=86var's reviewing.
>
> Thanks again, I took a look at this and it looks good to me as-is.
>
> If you do want to further twiddle with it at this point I applied these
> changes to it locally while poking around, changes:
>
>  * Some trivial whitespace between variable decl.
>
>  * Removed a "return;" at the end of a function
>
>  * I found the new write_*() helpers to be uneccesary, what I did spot
>    after seeing if they could be factored out is the existing
>    write_eolinfo() function.
>
>    I see you just copied some of the code from there, but
>    e.g. initializing to "" and doing an unconditional strbuf_addstr()
>    looks odd IMO compared to just doing it inline as below.
>

Indeed, it may be a little inelegant...

>    I think if helpers are to be introduced here I'd think it would make
>    more sense to split out the small bits of behavior from
>    write_eolinfo() so you can call it picemeal and share the code, but
>    since it's calling trivial external functions I think just calling
>    those directly probably makes more sense...
>
>  * Likewise for the test I wondered if you were adding a bug by not
>    reporting when lstat() failed, but then found that this is the same
>    thing we do on --eol.
>

Yes, write_eolinfo() ignore lstat() error too, so this would not be a probl=
em.

>    So for the tests I think it's better just to demonstrate that we can
>    emit the exact same thing that --eol does with --format.
>
>  * We've gone back & forth a bit on whether this would combine with
>    --debug, while it's an internal-only feature it would be nice to have =
a
>    test for it combined with --format, noting that the behavior might
>    change...
>

Oh, if we really want --format, --debug used with --eol, -t, some user
may curious about why --format can not used with  --eol, -t (without --debu=
g),
and I think this will make it interface more complicated. So now I pefer to=
 keep
origin design.

>  * There is one subtle behavior change here in that I deleted the "ce
>    &&" part from write_index_eolinfo_to_buf() when moving the code
>    over. I'm 99% sure this is the right thing to do, as other code in
>    expand_show_index() unconditionally dereferences it.
>
>    So perhaps we don't need that guard in write_eolinfo() either? In any
>    case copy/pasting it over when we're already assuming a non-NULL "ce"
>    in the same "if/elseif/else" chain looks a bit odd.
>
>    Ah, I see it's because in show_dir_entry() we explicitly pass it as
>    NULL, but that doesn't apply to our new codepath, so as long as we're
>    not sharing that helper with write_eolinfo() it makes sense to not do
>    that check.
>

Agree.

>    Even then the helper should probably assume "ce", and write_eolinfo()
>    itself should do the "is ce NULL?" check which is specific to its
>    use-case.
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 79ecdce2c9c..cc3cece3830 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -77,30 +77,6 @@ static void write_eolinfo(struct index_state *istate,
>         }
>  }
>
> -static void write_index_eolinfo_to_buf(struct strbuf *sb, struct index_s=
tate *istate,
> -                                      const struct cache_entry *ce)
> -{
> -       const char *i_txt =3D "";
> -       if (ce && S_ISREG(ce->ce_mode))
> -               i_txt =3D get_cached_convert_stats_ascii(istate, ce->name=
);
> -       strbuf_addstr(sb, i_txt);
> -}
> -
> -static void write_worktree_eolinfo_to_buf(struct strbuf *sb, const char =
*path)
> -{
> -       struct stat st;
> -       const char *w_txt =3D "";
> -       if (!lstat(path, &st) && S_ISREG(st.st_mode))
> -               w_txt =3D get_wt_convert_stats_ascii(path);
> -       strbuf_addstr(sb, w_txt);
> -}
> -
> -static void write_eolattr_to_buf(struct strbuf *sb, struct index_state *=
istate,
> -                                const char *path)
> -{
> -       strbuf_addstr(sb, get_convert_attr_ascii(istate, path));
> -}
> -
>  static void write_name(const char *name)
>  {
>         /*
> @@ -114,6 +90,7 @@ static void write_name(const char *name)
>  static void write_name_to_buf(struct strbuf *sb, const char *name)
>  {
>         const char *rel =3D relative_path(name, prefix_len ? prefix : NUL=
L, sb);
> +
>         if (line_terminator)
>                 quote_c_style(rel, sb, NULL, 0);
>         else
> @@ -270,6 +247,8 @@ static size_t expand_show_index(struct strbuf *sb, co=
nst char *start,
>         const char *end;
>         const char *p;
>         size_t len =3D strbuf_expand_literal_cb(sb, start, NULL);
> +       struct stat st;
> +
>         if (len)
>                 return len;
>         if (*start !=3D '(')
> @@ -288,12 +267,16 @@ static size_t expand_show_index(struct strbuf *sb, =
const char *start,
>                 strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
>         else if (skip_prefix(start, "(stage)", &p))
>                 strbuf_addf(sb, "%d", ce_stage(data->ce));
> -       else if (skip_prefix(start, "(eolinfo:index)", &p))
> -               write_index_eolinfo_to_buf(sb, data->istate, data->ce);
> -       else if (skip_prefix(start, "(eolinfo:worktree)", &p))
> -               write_worktree_eolinfo_to_buf(sb, data->pathname);
> +       else if (skip_prefix(start, "(eolinfo:index)", &p) &&
> +                S_ISREG(data->ce->ce_mode))
> +               strbuf_addstr(sb, get_cached_convert_stats_ascii(data->is=
tate,
> +                                                                data->ce=
->name));
> +       else if (skip_prefix(start, "(eolinfo:worktree)", &p) &&
> +                !lstat(data->pathname, &st) && S_ISREG(st.st_mode))
> +               strbuf_addstr(sb, get_wt_convert_stats_ascii(data->pathna=
me));
>         else if (skip_prefix(start, "(eolattr)", &p))
> -               write_eolattr_to_buf(sb, data->istate, data->pathname);
> +               strbuf_addstr(sb, get_convert_attr_ascii(data->istate,
> +                                                        data->pathname))=
;
>         else if (skip_prefix(start, "(path)", &p))
>                 write_name_to_buf(sb, data->pathname);
>         else
> @@ -310,13 +293,12 @@ static void show_ce_fmt(struct repository *repo, co=
nst struct cache_entry *ce,
>                 .istate =3D repo->index,
>                 .ce =3D ce,
>         };
> -
>         struct strbuf sb =3D STRBUF_INIT;
> +
>         strbuf_expand(&sb, format, expand_show_index, &data);
>         strbuf_addch(&sb, line_terminator);
>         fwrite(sb.buf, sb.len, 1, stdout);
>         strbuf_release(&sb);
> -       return;
>  }
>
>  static void show_ce(struct repository *repo, struct dir_struct *dir,
> diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> index 60c415aafd6..baf03f9096e 100755
> --- a/t/t3013-ls-files-format.sh
> +++ b/t/t3013-ls-files-format.sh
> @@ -40,27 +40,13 @@ test_expect_success 'git ls-files --format objectname=
' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'git ls-files --format eolinfo:index' '
> -       cat >expect <<-\EOF &&
> -       lf
> -       lf
> -       EOF
> -       git ls-files --format=3D"%(eolinfo:index)" >actual &&
> -       test_cmp expect actual
> -'
> -
> -test_expect_success 'git ls-files --format eolinfo:worktree' '
> -       cat >expect <<-\EOF &&
> -       lf
> -       lf
> -       EOF
> -       git ls-files --format=3D"%(eolinfo:worktree)" >actual &&
> -       test_cmp expect actual
> -'
> -
> -test_expect_success 'git ls-files --format eolattr' '
> -       printf "\n\n" >expect &&
> -       git ls-files --format=3D"%(eolattr)" >actual &&
> +HT=3D'   '
> +WS=3D'    '
> +test_expect_success 'git ls-files --format v.s. --eol' '
> +       git ls-files --eol >expect 2>err &&
> +       test_must_be_empty err &&
> +       git ls-files --format=3D"i/%(eolinfo:index)${WS}w/%(eolinfo:workt=
ree)${WS}attr/${WS}${WS}${WS}${WS} ${HT}%(path)" >actual 2>err &&
> +       test_must_be_empty err &&
>         test_cmp expect actual
>  '
>

Thanks for review and help :-)

ZheNing Hu
