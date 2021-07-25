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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DAAC4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2919260F11
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhGYMhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhGYMhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:37:09 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9290C061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 06:17:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r18so8422859iot.4
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yc2F9X+Z2yqjggn9hf49y/nvbqg066vH658hjoCjpKs=;
        b=je98TtW99DTzPspRYuKVNvgoDr04QJV8NDPcrc8fTOrGE7rELv4CJh2E02n2xfzuL0
         ru6XLqE6LWicUm71QCvvTkBpwy18WuMV3lxxzBFhITsFjFhim4HAQl3VXXmcagbQWohC
         OWBQhRW6j+M2hYPPpk36mEgb4ajGorhfTOG8uZjxrgFqxeLGwVEYMfFQTuiHZqX6GldR
         njSfW28PabC+pV/UGTqGB2qczA1KGlCm8uCBF5YF9p3f7fwP5hZzd6on5/jn21tZNyaU
         FQA34KG4uwK69RiTecsNNPuw/Et320THlrCI6PnHBEf2JoQDDXdKT2gWG+KkfARAMI/S
         +F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yc2F9X+Z2yqjggn9hf49y/nvbqg066vH658hjoCjpKs=;
        b=OhCQw5cPRKBXRZx7fIFHwzgyAQXnIO986XGfTSevQLL2AtqPxOZmhkQkf5uPY23mKI
         KHx7/qQPbMyBKsOlnFEHOYZVQXRjK7VrhcRKsxBewILZoNp9aps9sIf4sjq7XDzOySHI
         ilehz10144HgJLK9BUkoK23yMnL/62wbk979ugs0jeIc+6XWxdArLqEOIzKGlPxs4ipw
         axWPF9sVq9fI6QdT2iOcw4V7z8KUN4Wg4QoMbGVjmbLmLMw8J77UVlqLB3Q3RKf0jQOP
         9RJ810FkwFWzf0DDoezE1361A2y59fkchL0gXX0ReU+1h0cNDBo5A/gXKiAp7JBKimeH
         BIkQ==
X-Gm-Message-State: AOAM53204tSE/AQK/AECN6r8GRcW9aqdxLOfRn9Hd4QJpdwYCGl2nfkQ
        e7rOrEb5r10b7aNVOgDSfDsWnEz2YAeNzZvPXqQ=
X-Google-Smtp-Source: ABdhPJwlP1XZyvbGEATPxSJArzmxvjEtO+23/1yTe68N5m8OsZ8S8/LqVj4ljSAKVFRw5eB3UJsO6W/dzV66VnNOvDM=
X-Received: by 2002:a02:9f89:: with SMTP id a9mr12265114jam.51.1627219059137;
 Sun, 25 Jul 2021 06:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
 <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com> <ac5d98647dad31ebe165daa7cbf84f2b7e5fbe80.1627136062.git.gitgitgadget@gmail.com>
 <CA+P7+xqYMt1TvDY-GO--Aw5n9L7_06e-TExszcsS5oWWtFUxsA@mail.gmail.com>
In-Reply-To: <CA+P7+xqYMt1TvDY-GO--Aw5n9L7_06e-TExszcsS5oWWtFUxsA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 25 Jul 2021 21:18:08 +0800
Message-ID: <CAOLTT8TR-nYePc65=gJ8DtbuXtOgLs+p52k80iGqLKH6rkMarQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] [GSOC] ref-filter: --format=%(raw) re-support --perl
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8825=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=884:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jul 24, 2021 at 7:14 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Because the perl language can handle binary data correctly,
> > add the function perl_quote_buf_with_len(), which can specify
> > the length of the data and prevent the data from being truncated
> > at '\0' to help `--format=3D"%(raw)"` re-support `--perl`.
> >
> > Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
>
> I presume that we used to support raw with perl before in cat-file? It
> did read a bit weird to see "Re-support" in the title, because the
> previous patch which introduced the raw atom when in ref-filter code
> never supported perl. Still, I think it's fairly clear either way and
> that change wouldn't deserve a reroll on its own.
>

No, we haven't support it. It can be said that this commit is only split fr=
om
the previous commit. Therefore, "re-support" is indeed wrong. I will modify=
 it.

> Makes sense. Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
>
> > @@ -1010,10 +1013,14 @@ int verify_ref_format(struct ref_format *format=
)
> >                 at =3D parse_ref_filter_atom(format, sp + 2, ep, &err);
> >                 if (at < 0)
> >                         die("%s", err.buf);
> > -               if (format->quote_style && used_atom[at].atom_type =3D=
=3D ATOM_RAW &&
> > -                   used_atom[at].u.raw_data.option =3D=3D RAW_BARE)
> > +
> > +               if ((format->quote_style =3D=3D QUOTE_PYTHON ||
> > +                    format->quote_style =3D=3D QUOTE_SHELL ||
> > +                    format->quote_style =3D=3D QUOTE_TCL) &&
> > +                    used_atom[at].atom_type =3D=3D ATOM_RAW &&
> > +                    used_atom[at].u.raw_data.option =3D=3D RAW_BARE)
> >                         die(_("--format=3D%.*s cannot be used with"
> > -                             "--python, --shell, --tcl, --perl"), (int=
)(ep - sp - 2), sp + 2);
> > +                             "--python, --shell, --tcl"), (int)(ep - s=
p - 2), sp + 2);
> >                 cp =3D ep + 1;
> >
>
> Right, so now we have to check all of the format quote styles instead
> of just checking that its set to any of them, since we want to
> continue in the case of perl.
>
> Ok.
>

Thanks.
--
ZheNing Hu
