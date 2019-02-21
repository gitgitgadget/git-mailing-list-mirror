Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735041F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfBULjO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:39:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44038 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBULjO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:39:14 -0500
Received: by mail-io1-f66.google.com with SMTP id y13so1189683iop.11
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pMaGAO6cpZiOjxACTj9qJCAs5BrQ0TxUJ52ovTAHC38=;
        b=iOTa5Jx5rPQEGFS3K8vYC3vji/D2/veeP1HWtnPfdLgHd8j9eZs5gflQ6Pid+YI9Mc
         FJ2g/Dmu6ZzmnBXBSTpE5w/BecKGd9jlyPq70uaUYd0Lz4OXeZjdtMZIikJvytuNxm6u
         a3s2GAHxdgjcOAhz0LZRBfaDebdK5UNQlvEz9dsi3nY+TGT4/fDnflgb5ZURdhMiJ3Tl
         657deRfYNX4vtqcljc5Opk9LnBzYvVVu4nuekvcXyqLNIBXgMHqJ4I5EDyLnxZNrdRyK
         WkJa7JVZvS3qI2Un+6LK5f/2Rq/qXEyLIZjw2iI8S3hL6Oq6qDuO3L+8LMa5yHnl+v1k
         b/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMaGAO6cpZiOjxACTj9qJCAs5BrQ0TxUJ52ovTAHC38=;
        b=WN8MnLcWtlMmT/1iwHbbwq2lv6Uwp2zubQSXIfsaYjUyAuV/dxpG2J0S52zHe0ba/L
         G2qtugl0oGW/uypELBMxXNm3ZuspbEv0Le2C0LVcje5Mp6Rpz68AvPVpQE8F+qW5lnqJ
         zcoNRLEQ1v64KJaRuvsqLodS9awlezRAG8TIdeH08VYKCYrF8rvBz1G3xDxrqaB5jkym
         WIJc8VQdMHAsmk7RBhJ4sJS9kQnMIvkMACLTawu7CHYbvrfvG1GDvNx6MQw0u2XP2oys
         aI3s+jpSd1rgbwlvAs859SGAborm/hx9uFCg1WQhFwRvmwmev9AazYQfzre6nDtXZMnD
         5AiQ==
X-Gm-Message-State: AHQUAuadENXCOHEYd02BIb5xSI8Gr7NLWZrV5X7swckhCVJ1Sg1RYYbV
        L03pL0sdpxcTGF5ff+7HOGZvryDMn556ItIS5hI=
X-Google-Smtp-Source: AHgI3IaNJDqmkoX+aeYazkfmTTp31haP/cPa8dNleQ8GyJZSkBQ6THeH68Sg25SikRBUMyZ61BaE2tdd/Y1YaDQAaS0=
X-Received: by 2002:a5e:8416:: with SMTP id h22mr9665479ioj.118.1550749152559;
 Thu, 21 Feb 2019 03:39:12 -0800 (PST)
MIME-Version: 1.0
References: <1550500586.2865.0@yandex.ru> <20190221110026.23135-1-pclouds@gmail.com>
 <1550748525.30307.1@yandex.ru>
In-Reply-To: <1550748525.30307.1@yandex.ru>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Feb 2019 18:38:46 +0700
Message-ID: <CACsJy8AERM==LunYTszUf1Fb-uHPZLjkSE5x1T=0Ueqsvq3F_A@mail.gmail.com>
Subject: Re: [PATCH] worktree add: sanitize worktree names
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 6:28 PM Konstantin Kharlamov <hi-angel@yandex.ru> w=
rote:
>
>
>
> On =D0=A7=D1=82, Feb 21, 2019 at 2:00 PM,
> =3D?UTF-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?=3D Duy <pclouds@gmail.com> wrot=
e:
> > Worktree names are based on $(basename $GIT_WORK_TREE). They aren't
> > significant until 3a3b9d8cde (refs: new ref types to make per-worktree
> > refs visible to all worktrees - 2018-10-21), where worktree name could
> > be part of a refname and must follow refname rules.
> >
> > Update 'worktree add' code to remove special characters to follow
> > these rules. The code could replace chars with '-' more than
> > necessary, but it keeps the code simple. In the future the user will
> > be able to specify the worktree name by themselves if they're not
> > happy with this dumb character substitution.
> >
> > Reported-by: hi-angel@yandex.ru
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> >  builtin/worktree.c      | 47
> > ++++++++++++++++++++++++++++++++++++++++-
> >  t/t2025-worktree-add.sh |  5 +++++
> >  2 files changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 3f9907fcc9..ff36838a33 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -262,6 +262,46 @@ static void validate_worktree_add(const char
> > *path, const struct add_opts *opts)
> >       free_worktrees(worktrees);
> >  }
> >
> > +/*
> > + * worktree name is part of refname and has to pass
> > + * check_refname_component(). Remove unallowed characters to make it
> > + * valid.
> > + */
> > +static void sanitize_worktree_name(struct strbuf *name)
> > +{
> > +     int i;
> > +
> > +     /* no ending with .lock */
> > +     if (ends_with(name->buf, ".lock"))
> > +             strbuf_remove(name, name->len - strlen(".lock"),
> > +                           strlen(".lock"));
> > +
> > +     /*
> > +      * All special chars replaced with dashes. See
> > +      * check_refname_component() for reference.
> > +      */
> > +     for (i =3D 0; i < name->len; i++) {
> > +             if (strchr(":?[]\\~ \t@{}*/.", name->buf[i]))
> > +                     name->buf[i] =3D '-';
> > +     }
> > +
> > +     /* remove consecutive dashes, leading or trailing dashes */
> > +     for (i =3D 0; i < name->len; i++) {
> > +             while (name->buf[i] =3D=3D '-' &&
> > +                    (i =3D=3D 0 ||
> > +                     i =3D=3D name->len - 1 ||
> > +                     (i < name->len - 1 && name->buf[i + 1] =3D=3D '-'=
)))
> > +                     strbuf_remove(name, i, 1);
> > +     }
> > +
> > +     /* last resort, should never ever happen in practice */
> > +     if (name->len =3D=3D 0)
> > +             strbuf_addstr(name, "worktree");
>
> I assume this means a user have passed a zero-sized worktree name? But
> zero-sized file/directory names are not possible anyway, would it make
> sense to just return an error in this case?

It could happen if you do "git worktree add .lock". The ".lock" part
will be stripped out, leaving us with an empty string.
--=20
Duy
