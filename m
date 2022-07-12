Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AB5C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiGLNyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGLNyK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:54:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3792963931
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:54:09 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r76so7858686iod.10
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ivpdtI9VhxWAC6hOKc5Hs4IdqEgMa+hj4L8yF2BoXwE=;
        b=N+khiZDPgUilm1LEU+axMJ0bKdsMas8vfZWSKuLMCbRuXLYyvkWjicGt3e6fL12JSh
         upOHYOe+cpkpyWSuzADzuyq0eaXsBX7fhsNvP8peIhiqNOssq7Z7adUWOdqPGO0AQ8jN
         gqFXlpi2U3NnHrDACPaYXrxVvNLjX98XNvenpA71EXx6X4U2LXA2VpZGkhVaUK/6gho5
         sOYhTuedPiewADGE2y3iYbCmkZ89VplDt7eWIhz2WnZS9RNM7h0DVRtjYtZVkR9PpiyZ
         NrA05drUNGkGIgP5dAtjd9KtW0bEF6HuI67yV7u0i7hMKpwj6cd5FBdWjALs7r6wxhYH
         sdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ivpdtI9VhxWAC6hOKc5Hs4IdqEgMa+hj4L8yF2BoXwE=;
        b=4zlbSKdmnYhKKDAfjiQlIQtwqIuzR5gCg3Peg98oBZ/g9MeCpnh4aPmEP6exR1Aoo/
         5DtrEGZezT96pD5gls82V2vxiqBtSFncG7Pw22nkZQcCWXOwFVBkJpHV24dq5889CVRO
         odf2SFGjUfc2oU1LLbMeRAgpBmPoHVljj6xEq6kVr/xtgtZ2WGGZ816iZXK12AmYzPJb
         d63bX74PlrQ4laX2zpDzN5PPSGKiZFry5r8RhalkFpv8WCaLqBGQv5Y7yesSnQ7EnAWX
         cc7ArRihWRjuSmVzj4BDviv3o4zCSd+UNp98PlODHnC+zbbRSgNFZsqMbWKndojMBMHz
         VDLw==
X-Gm-Message-State: AJIora91aM7WdAxnlinNBasuTs2Jpo5Bm5sxCoCCM+EeUj+7xYcH9rgo
        S52XiJUDMkzTDL47hYDBca3eoWP1IV+65lCD7gYKoRCza/g0bg==
X-Google-Smtp-Source: AGRyM1s87BUs4FS6XNMVQuI5+duDeHli3hlewGtqqYtVowsCQskVmb8SpVUJ3m31l5NJnf6RA8VwTaIjiXmqUSvQ8WA=
X-Received: by 2002:a05:6638:12ca:b0:33c:c664:64fe with SMTP id
 v10-20020a05663812ca00b0033cc66464femr13489790jas.67.1657634048630; Tue, 12
 Jul 2022 06:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com>
 <pull.1262.v6.git.1657558435532.gitgitgadget@gmail.com> <xmqqleszl2p0.fsf@gitster.g>
In-Reply-To: <xmqqleszl2p0.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 12 Jul 2022 21:53:57 +0800
Message-ID: <CAOLTT8RSo83ZBXbT_MLigD946_xHjnX-aS76D_K7=ScbMR=nYw@mail.gmail.com>
Subject: Re: [PATCH v6] ls-files: introduce "--format" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C 06:11=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Add a new option --format that output index enties ...
>
> Let's quote the options and use the Oxford comma.
>
>     ls-files: introduce "--format" option
>
>     Add a new option "--format" that outputs index entries in a
>     custom format, taking inspiration from the option with the same
>     name in the `git ls-tree` command.
>
>     "--format" cannot used with "-s", "-o", "-k", "-t", "--resolve-undo",
>     "--deduplicate", and "--eol".
>
> > +It is possible to print in a custom format by using the `--format`
> > +option, which is able to interpolate different fields using
>
> So we use the term "field" to mean different piece of information we
> can present.  The definition of what fields are available come later
> and the presentation order is a bit awkward, but hopefully the text
> is understandable as-is.
>

OK.

> > +a `%(fieldname)` notation. For example, if you only care about the
> > +"objectname" and "path" fields, you can execute with a specific
> > +"--format" like
> > +
> > +     git ls-files --format=3D'%(objectname) %(path)'
>
> And the example makes it pretty clear.  OK.
>
> > +FIELD NAMES
> > +-----------
> > +Various values from structured fields can be used to interpolate
>
> Are we dealing with unstructured fields, too?  If not, let's drop
> "structured".
>

OK (copy from git-ls-tree.txt too)

> > +into the resulting output. For each outputting line, the following
> > +names can be used:
>
> "outputting line" sounds like a non language.
>
>
>     The way each path is shown can be customized by using the
>     `--format=3D<format>` option, where the %(fieldname) in the
>     <format> string for various aspects of the index entry are
>     interpolated.  The following "fieldname" are understood:
>
> perhaps?
>

This will indeed be better.

> > +{
> > +     struct show_index_data *data =3D context;
> > +     const char *end;
> > +     const char *p;
> > +     size_t len =3D strbuf_expand_literal_cb(sb, start, NULL);
> > +     struct stat st;
> > +
> > +     if (len)
> > +             return len;
> > +     if (*start !=3D '(')
> > +             die(_("bad ls-files format: element '%s' "
> > +                   "does not start with '('"), start);
> > +
> > +     end =3D strchr(start + 1, ')');
> > +     if (!end)
> > +             die(_("bad ls-files format: element '%s'"
> > +                   "does not end in ')'"), start);
> > +
> > +     len =3D end - start + 1;
> > +     if (skip_prefix(start, "(objectmode)", &p))
>
>
> Using skip_prefix() not for the purpose of skipping (notice that
> nobody uses p at all) is ugly.  We already computed start and end
> (hence the length), so we should be able to do much better than
> this.
>

Agree. I check the parsing format part of ref-filter.c, we just need to fin=
d the
atom's begin pos and end pos, then we can use memcmp() to know what's the
type of atom.

> But let's let it pass, as it was copy-pasted from existing code in
> ls-tree.c::expand_show_tree().
>

Yeah, maybe we can optimize it later.

> > +     else if (skip_prefix(start, "(eolinfo:index)", &p) &&
> > +              S_ISREG(data->ce->ce_mode))
> > +             strbuf_addstr(sb, get_cached_convert_stats_ascii(data->is=
tate,
> > +                                                              data->ce=
->name));
>
> This is outright wrong, isn't it?
>
> It is unlikely to see such a trivial error in the 6th round of a
> series after other reviewers looked at it many times, so perhaps I
> am missing something?  Or perhaps this is a new code added in this
> round.
>
> If you ask for %(eolinfo:index) for an index entry that is not a
> regular file, this "else if" will not trigger, and the control will
> eventually fall through to hit "bad ls-files format" but what you
> detected is not a bad format at all.  Once the skip_prefix() hits,
> you should be committed to handle that "field" and never let the
> other choices in this if/elif/ cascade to see it.
>
> It is OK to interpolate %(eolinfo:index) to an empty string for a
> gitlink and a symbolic link, but the right way to do so would
> probably be:
>
>         else if (skip_prefix(start, "(eolinfo:index)", &p) {
>                 if (S_ISREG(data->ce->ce_mode))
>                         strbuf_addstr(...);
>         } else ...
>

Yeah, but we would use "{", "}" again, so just revert this code to v5,
which uses a
 wrap function.

> > +     else if (skip_prefix(start, "(eolinfo:worktree)", &p) &&
> > +              !lstat(data->pathname, &st) && S_ISREG(st.st_mode))
> > +             strbuf_addstr(sb, get_wt_convert_stats_ascii(data->pathna=
me));
>
> Likewise.
>
> > +test_expect_success 'setup' '
> > +     echo o1 >o1 &&
> > +     echo o2 >o2 &&
> > +     git add o1 o2 &&
> > +     git add --chmod +x o1 &&
> > +     git commit -m base
> > +'
>
> Apparently, this set-up is too trivial to uncover the above bug that
> can be spotted in 10 seconds of staring at the code.  Perhaps add a
> symbolic link (use "git update-index --cacheinfo" and you do not
> have to worry about Windows), a subdirectory and a submodule?
>

Ah, Just looking at the c code, I took a long time (more than 10 minutes) t=
o
find out where the mistake was. But yeah, use a subdirectory can quickly
meet the error,  so I need to add more cases here.

Thanks for your review.

ZheNing Hu
