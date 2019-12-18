Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBB8C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58D62176D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 14:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh6ugu7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLROET (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:04:19 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:40729 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLROES (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 09:04:18 -0500
Received: by mail-il1-f182.google.com with SMTP id c4so1779118ilo.7
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 06:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O/cTOWjYJpuhocc4+QUgL5WNKNKYx6m09TJW0Ikd5UE=;
        b=Eh6ugu7mA6TP1poPApWXk2l6TC69ibbH6oUVGrGsC3N+C4MY1edaQeoZkuSL/0GSlb
         yChidU8Nm4jn1D/kFz3v5DiFhQfvFR2qcVk2uLcb/cBpVu7mUk6iI8CHfv+h6129ZWWb
         ib2bEUtX8ybC6i1J+nm3+ukK1S3dLHYdBzHisHla2FyOTCKw/x3cU5bEE6rhKtnk8l9G
         AMFjKU62k9YzbWOZiCVGgUs91B6p/6nD4+1u1pS/OeO5bsgl4aZIeADyEzLeW7c6HFEu
         0Pt81VkD1UdoxsiEnc/6dX3Uw+Ku1p+eby4ChC2JDw2SNUCf37L8OGDPQwrmoDEzzDVM
         0aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O/cTOWjYJpuhocc4+QUgL5WNKNKYx6m09TJW0Ikd5UE=;
        b=aKvytc92YPS2iRcYgBQHTpCDtNWBFEcSHskfu6/fhZYHEavtu8iiwz7Dusnj5K1mDz
         LybD11NPWBuMl64mYhwQnhsV05W6foUYp4t0yiatGyvVhv8x5EoMunFPwnpxDup8KqZu
         13ShFUq6gLh5J5yOdxhmNJxRy3d0ElrX6zCpAgjZyogSN1gXlr/XZaNAPckMgIJgkm2N
         8LP49wC6OskQt+YYrDwTxAlQRmUES9ybW3o53LJq6AV80I5waSzI1KYt7dheeVJoLjey
         S5wjUdUGaDnRzu0xJn9NNcJ6RZIjKxHOh9+wz6Vq/IDsme3veGNh7IUPzpAt/9+5W+9r
         d1Jw==
X-Gm-Message-State: APjAAAVpynsZRWp4PmrkKD5rKCcciuiAgIoyDW7IoSXRnxJjkyqQxdz3
        CNwdzi2AyYP4EIUFBQlSI74AVvoFGw3XqWvXRa7KLJZ5
X-Google-Smtp-Source: APXvYqyKv9HccAFxnjTmDLPA86V5zNJCsOiAc7E0nx33XoPvMQn8sWKHEr8Dq45wmyjnx/hUaE3kzOI7zriPHBOLdpw=
X-Received: by 2002:a92:874e:: with SMTP id d14mr1916330ilm.125.1576677857692;
 Wed, 18 Dec 2019 06:04:17 -0800 (PST)
MIME-Version: 1.0
References: <CAK60LiX0g8mNVH5YY0JNOuUNRNYp+URt=2MyH758OAWpX_Phxg@mail.gmail.com>
 <20191216063425.GA2127604@coredump.intra.peff.net>
In-Reply-To: <20191216063425.GA2127604@coredump.intra.peff.net>
From:   pp yy <yoann.mac.donald@gmail.com>
Date:   Wed, 18 Dec 2019 15:04:06 +0100
Message-ID: <CAK60LiV_e=q33R20WJU=Hxrn6kKuXwehM+9j_8cmWX4krnmv2w@mail.gmail.com>
Subject: Re: [bug] Adding -z to git status seems to disable relative path
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

Even without adding -s the option "status.relativePaths" isn't respected.
$ git -c status.relativePaths=3Dtrue status -z test
?? plugins/git/test

It is explained in the man in fact.
Porcelain v1 is applied when using"-z" and porcelain v1 explicitly state:
"
1. The user=E2=80=99s color.status configuration is not respected; color wi=
ll
always be off.
2. The user=E2=80=99s status.relativePaths configuration is not respected;
paths shown will always be relative to the repository root.
"

With this in mind, it seems impossible to have the same output as `git
-c status.relativePaths=3Dtrue -c color.status=3Dalways status -s test`
but with records separated by '\0' (for scripting purpose), and that's
what I was looking for :
- list files status
- separated by '\0'
- with colors

Regards,

Le lun. 16 d=C3=A9c. 2019 =C3=A0 07:34, Jeff King <peff@peff.net> a =C3=A9c=
rit :
>
> On Sun, Dec 15, 2019 at 09:31:23PM +0100, pp yy wrote:
>
> > Maybe i missed something but i can't get relativepath when adding '-z'
> >
> > $ git --version
> > git version 2.17.1
> > $ git status -s test
> > ?? test
> > $ git status -s -z test
> > ?? plugins/git/test
> > $ git -c status.relativePaths=3Dtrue status -s test
> > ?? test
> > $ git -c status.relativePaths=3Dtrue status -s -z test
> > ?? plugins/git/test
> >
> > Bug or did i missed something ?
>
> I think it's a bug. At first I thought you were running up against the
> implied porcelain output:
>
>   -z
>       Terminate entries with NUL, instead of LF. This implies the
>       --porcelain=3Dv1 output format if no other format is given.
>
> but you are explicitly saying "-s" (and running this in a terminal shows
> that the result is colorized, which means we're triggering the short
> format and not porcelain).
>
> And indeed, the "-z" code path seems to ignore the prefix entirely.
> Something like this would fix it:
>
> diff --git a/wt-status.c b/wt-status.c
> index cc6f94504d..3a0e479407 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1837,9 +1837,13 @@ static void wt_shortstatus_status(struct string_li=
st_item *it,
>                 putchar(' ');
>         putchar(' ');
>         if (s->null_termination) {
> -               fprintf(stdout, "%s%c", it->string, 0);
> +               struct strbuf scratch =3D STRBUF_INIT;
> +               fprintf(stdout, "%s%c",
> +                       relative_path(it->string, s->prefix, &scratch), 0=
);
>                 if (d->rename_source)
> -                       fprintf(stdout, "%s%c", d->rename_source, 0);
> +                       fprintf(stdout, "%s%c",
> +                               relative_path(d->rename_source, s->prefix=
, &scratch), 0);
> +               strbuf_release(&scratch);
>         } else {
>                 struct strbuf onebuf =3D STRBUF_INIT;
>                 const char *one;
>
> Now I do think it's a little weird to use "-z" with "--short" in the
> first place, since the whole point of "-z" is make something that can be
> parsed. And the whole point of "--short" versus "--porcelain" is that
> the latter is stable and predictable (so it doesn't respect config at
> all).
>
> But I guess I could imagine a use case where a script is taking in paths
> from the "-z" and then showing them to the user without further
> processing (and so it's convenient to get the relative path directly
> rather than computing them itself). I do wonder if there are any other
> surprises in "--short" that might be lurking, though (IIRC, we do not
> even promise that the output will stay syntactically the same between
> versions; it could change to something completely different, or add new
> lines in future versions).
>
> -Peff
