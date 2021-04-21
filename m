Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC6C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 05:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17DD6141C
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 05:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhDUFsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 01:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDUFsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 01:48:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0292CC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 22:47:49 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id v123so34047949ioe.10
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 22:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ohc/pHc3LT8vOmeYoBd2vlTkk3JjNMFlPx0MuHKs4AM=;
        b=ahxCJvVZItOqVTcXAewP0V6csLo7v/khx8RZdozaQFJh0L54FOOcwt2mIBmTSNz7uT
         0Dom9EFcVn5MKZkeObsePQUVq1kd/vjiAggz0aKZXyJpcEhRlnC9fQjfcGKa/Gc9oi4q
         uN9m6qAdHj78V5cD6RHo0tErjdZvTXe22AU/z+vP2kgTKSZaTJ8cXuuKPpSmViJJ/H+u
         zKFLf0k9e12DAD5I85nMDCx+x28e87QfIVQ9xmxYSKRU6AMK5xxH4qHTwQNpEsaAbSNU
         kPSXOpwMKXMNisq6zZ7XXjVtbwEO7HrrohJGWb1ad1W0FIsWWe6dZRFhUKZmhrlHLCa8
         CVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ohc/pHc3LT8vOmeYoBd2vlTkk3JjNMFlPx0MuHKs4AM=;
        b=DZtFg4Q9dsEmIRDCJtAWOTM+WD1W/nwI7c9J0DJRmc9d1hCyZnH/qQRs47lU+wbZdX
         C5ZFXAs4Xkr8x/zZ/bIsom13voLf12vE1nrDYSKusz9EWD/OR4w3QdMnrU2V1VBT3JdI
         o4TJWp4bQ4tzaFtTVKwJusEs2AegE+N2G5FBaaGhFIs59Epv6nrLFYoFUYuW/blJUPgR
         UQ9+9keR7D/8mTBlWcETGVBzKLTjg3eOQzUCiP82ri3sv706wKEcjqhNPbrzIXwd/+Xe
         AIw9B5XGt1KpAEN9yoPN5qQbl8+bqtQcvR/8m9dtJQZBbLqpJjdJGpKCzih+xXprkW8p
         m+ow==
X-Gm-Message-State: AOAM531/C8OAwnc0CLx08xLrLxrKo+Ii9nRka6mU4AhC7zmnRbmAnlGt
        LAfsKLdHfzscdh7MhRXb900NuEtYW5amKDh1UIQ=
X-Google-Smtp-Source: ABdhPJwhX2PdIwy2O2abaseljqD08osu7nc25HNho+7G0lQdsomA9PunqbReHboH1vjboqzyP1hOtbSQnUIheAdfgnE=
X-Received: by 2002:a5d:848a:: with SMTP id t10mr22469912iom.68.1618984069299;
 Tue, 20 Apr 2021 22:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
 <pull.913.v11.git.1618672417.gitgitgadget@gmail.com> <xmqq5z0kbl8x.fsf@gitster.g>
 <CAOLTT8RKCV+Kpya-_AVjuVGWzs1WtGS8n_+sD0FVzwEpeXGwCw@mail.gmail.com> <xmqqfszk1ot6.fsf@gitster.g>
In-Reply-To: <xmqqfszk1ot6.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 21 Apr 2021 13:47:38 +0800
Message-ID: <CAOLTT8QUA+m1W6-v=ZA205SZo8G5GBKMzJHBzU8DuQSTKiPUBw@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] [GSOC] trailer: add new .cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=888:09=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > OK, I understand, then I can wait for a while until `trailer_cmd` merge
> > to master.
> >
> >> But let's see what's new in this iteration.
> >>
> >>
> >> >       +#!/bin/sh
> >> >      -+test -n "$1" && git shortlog -s --author=3D"$1" HEAD || true
> >> >      ++if test "$#" !=3D 1
> >> >      ++then
> >> >      ++       exit 1
> >> >      ++else
> >> >      ++       test -n "$1" && git shortlog -s --author=3D"$1" HEAD |=
| true
> >> >      ++fi
> >>
> >> I find this dubious.  Why not
> >>
> >>         if test "$#" !=3D 1 || test -z "$1"
> >>         then
> >>                 exit 1
> >>         else
> >>                 git shortlog -s --author=3D"$1" HEAD
> >>         fi
> >>
> >> That is, if you happened to give an empty string, your version gives
> >> "" to <value> and returns success, letting a trailer "cnt:" with
> >> empty value.  Is that what we really want?
> >
> > If it's the user use `--trailer=3D"cnt:"` instread of command implict r=
unning,
> > I think keep it is right.
>
> No, if you give an empty string, you'd end up running "shortlog"
> with --author=3D"" and give whatever random number it comes up with,
> which I do not think is what you would want.
>
> That is why --trailer=3Dcnt: without name to match --author can be
> rejected with "exit 1" to demonstrate the feature.  The .cmd can
> squelch not just the "unasked for extra invocation", but invocation
> from the command line whose <value> was bogus, unlike the .runmode
> feature we've seen proposed earlier.
>

I admit that your idea makes sense, but we actually have another requiremen=
t:
Construct a trailer with an empty value.

The Commit-Count example above may not be good, Let=E2=80=99s take a look a=
t the
Signed-off-by.

e.g. `--trailer=3D"sign:"`, we expect to output a "Signed-off-by: ",
then we can fill it
with the "name <email>" pair we want, this is when we shouldn't return non-=
zero
and suppress its output.

> >> >      +        if (capture_command(&cp, &buf, 1024)) {
> >> >      +-               error(_("running trailer command '%s' failed")=
, cmd.buf);
> >> >      +                strbuf_release(&buf);
> >> >      +-               result =3D xstrdup("");
> >> >      ++               if (!conf->cmd || arg) {
> >> >      ++                       error(_("running trailer command '%s' =
failed"), cmd.buf);
> >>
> >> I am not sure about this part.  If .cmd (the new style) exits with a
> >> non-zero status for user-supplied --trailer=3D<token>:<value> (because
> >> it did not like the <value>), is that "running failed"?  The script
> >> is expected to express yes/no with its exit status, so I would say it
> >> is not failing, but successfully expressed its displeasure and vetoed
> >> the particular trailer from getting added.  IOW, "|| arg" part in
> >> the condition feels iffy to me.
> >
> > Well, you mean we can take advantage of non-zero exits instead of
> > just removing implicitly executed content. I argee with you, this
> > place is worth change.
>
> Yup, that is what I meant.
>
> In any case, let's see how well the base topic fares.
>

Yes, I don't know if Christian agrees with temporary situation.

> Thanks.

Thanks.
--
ZheNing Hu
