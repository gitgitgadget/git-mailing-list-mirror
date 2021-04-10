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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F9C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE84B6044F
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 13:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhDJNkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhDJNkm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 09:40:42 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E63C061762
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 06:40:27 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y4so8821289ioy.3
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CMgyHLBCcr0Cdiyn8PIBF7aZTN2H6VYeG3xYYTu6LYc=;
        b=V2yci1vxPzzrgfaPednlQldOPpyk+8srsoUtZL2z5Um4Om/FezIlZWkHZ1P6dBh4MW
         tRezq6EBZAq/esruPY0ua1KJpy06GOlPE4owIyWpOUNvew9xL55wIEwxbm0g/Ps4Tley
         KkTPlQ5MQmEkxL3XDBs8LYlZ7xoHhkzJXzMcKHFzAlOkXKxsy09WEGlsikFuZYh8ILEv
         r/xBRP1bChukbI7JUsaLTEGOc+q5Hy+s+NE0NCBtII/lbR0GHwlQhrDWc88w6g8Z/WNJ
         QgIf6FDjSnBrMIB7E3pYqVZoEXDaX3vZa2cgYrDRwcOcwJJBEoXtYbPCiXyy/+U9mMsG
         k+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CMgyHLBCcr0Cdiyn8PIBF7aZTN2H6VYeG3xYYTu6LYc=;
        b=ZyyEtW/QmtG0oRim6B6XRGriVBxc5i26vG6Q1VA8XCM60cM0+B0jLI7U1O9EccxBIH
         Yn9fAaEBLAisCDW2obwwpMg0pr1WEhAFYChpJpxqs7SDcchHV/Q6F93EeRS9O5Q0T7k7
         u2blZUKZczxo+iLbUg4F5cK0BxelGRjNUSH9bVzV1kRWs9/v/DRdoQxizZdFoMHxmqge
         D+/XQNFZLxPPtK7DhF62S6ijaQQGWmMm3un9CpR5Reqz/gPGVBiWOIvH0Fpb1f5ArwN8
         9/Vx1fyyfFSzNXyv30/l40sRdjJ8I4PsyGacKdrV2NbekfMZ/OxYO+ITRyRFhHsM2jfa
         WswA==
X-Gm-Message-State: AOAM530bo5cvJDFuCUfL+OL4O8c/O7QU0nvEAREHNNS5mVB4LpiT9htE
        Qi1cgdW/PQv7whvsHYXKQHDnkxty4oNl3uzqxjQgh0LaGaDbRjPr
X-Google-Smtp-Source: ABdhPJxShgpLajS6GC+wQLEACATxfiU9baZVPHwGqFid05tFBUnXeX0vkOhqWBCvej6kTpMHTYHohPiiH/A/FjsTaGM=
X-Received: by 2002:a5d:848a:: with SMTP id t10mr15972252iom.68.1618062027148;
 Sat, 10 Apr 2021 06:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
 <pull.913.v8.git.1617975462.gitgitgadget@gmail.com> <505903811df83cf26f4dd70c5b811dde169896a2.1617975462.git.gitgitgadget@gmail.com>
 <CAP8UFD0q=7JT1Wsbr6wj9_LEh41ZKbvKsgnE+_3hSM3aMnjwzw@mail.gmail.com>
In-Reply-To: <CAP8UFD0q=7JT1Wsbr6wj9_LEh41ZKbvKsgnE+_3hSM3aMnjwzw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 10 Apr 2021 21:40:10 +0800
Message-ID: <CAOLTT8RD_pWRQzP7zYYJrV-S1pdU30AbAVB0guHD-HPcWVkuhg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] [GSOC] docs: correct descript of trailer.<token>.command
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=8810=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=883:02=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Fri, Apr 9, 2021 at 3:37 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > In the original documentation of `trailer.<token>.command`,
> > some descriptions are easily misunderstood. So let's modify
> > it to increase its readability.
> >
> > In addition, clarify that `$ARG` in command can only be
> > replaced once since `$ARG` is text replacement.
>
> I think you can remove the "since `$ARG` is text replacement" part.
> Otherwise this looks fine.
>

Ok.

> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  Documentation/git-interpret-trailers.txt | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/g=
it-interpret-trailers.txt
> > index 96ec6499f001..3e5aa3a65ae9 100644
> > --- a/Documentation/git-interpret-trailers.txt
> > +++ b/Documentation/git-interpret-trailers.txt
> > @@ -237,20 +237,20 @@ trailer.<token>.command::
> >         specified <token>.
>
> The beginning of the doc for trailer.<token>.command could already be
> improved. It is:
>
>        This option can be used to specify a shell command that will
>        be called to automatically add or modify a trailer with the
>        specified <token>.
>
> Instead we could say for example:
>
>        This option can be used to specify a shell command that will
>        be called:
>          - once to automatically add a trailer with the specified
> <token>, and then
>          - each time a '--trailer <token>=3D<value>' argument to modify
> the <value> of the trailer that this option would produce
>
> >  When this option is specified, the behavior is as if a special
>
> I would rather say:
>
> When the specified command is first called to add a trailer with the
> specified <token>, the behavior is as if a special
>
> > -'<token>=3D<value>' argument were added at the beginning of the comman=
d
> > -line, where <value> is taken to be the standard output of the
> > -specified command with any leading and trailing whitespace trimmed
> > -off.
> > +'--trailer <token>=3D<value>' argument was added at the beginning of
> > +the "git interpret-trailers" command, where <value> is taken to be the
> > +standard output of the specified command with any leading and trailing
>
> Here we can remove "specified" as we now use it at the beginning of
> the sentence.
>
> > +whitespace trimmed off.
> >  +
> > -If the command contains the `$ARG` string, this string will be
> > -replaced with the <value> part of an existing trailer with the same
> > -<token>, if any, before the command is launched.
> > +The first occurrence of substring `$ARG` will be replaced with the
> > +<value> part of an existing trailer with the same <token>, if any,
> > +before the command is launched.
>
> I think we should not talk about `$ARG` at this point, let's remove
> this and see what we can do below in the next paragraph or after it.
>

Here I may want to keep the content similar to the original paragraph.
But if you say so, it will be fine.

> >  If some '<token>=3D<value>' arguments are also passed on the command
>
> s/'<token>=3D<value>'/'--trailer <token>=3D<value>'/
>
> > -line, when a 'trailer.<token>.command' is configured, the command will
> > -also be executed for each of these arguments. And the <value> part of
> > -these arguments, if any, will be used to replace the `$ARG` string in
> > -the command.
> > +line, when a 'trailer.<token>.command' is configured, the command is r=
un
>
> s/when a 'trailer.<token>.command' is configured, //
> s/the command is run/the command is called again/
>
> > +once for each these arguments with the same <token>.
>
> s/each these/each of these/
>
> > And the <value>
> > +part of these arguments, if any, will be used to replace the first `$A=
RG`
> > +string in the command.
>
> s/first `$ARG` string/first occurrence of substring `$ARG`/
>
> Let's also add something to explain the purpose of this, for example
> we could add:
>
> "This way the command can produce a <value> computed from the <value>
> passed in the '--trailer <token>=3D<value>' argument."
>
> And then let's also explain what happens when the command is called
> the first time, with for example:
>
> "For consistency, the first occurrence of substring `$ARG` is also
> replaced, this time with the empty string, in the command when the
> command is first called to add a trailer with the specified <token>."
>
> To sum up this would give the following (not properly formatted) descript=
ion:
>
> -------------------
> trailer.<token>.command::
>        This option can be used to specify a shell command that will be ca=
lled:
>          - once to automatically add a trailer with the specified
> <token>, and then
>          - each time a '--trailer <token>=3D<value>' argument to modify
> the <value> of the trailer that this option would produce
>

Maybe I am a little confused: this two "-" meaning? Shouldn't it be the
same paragraph?

-       This option can be used to specify a shell command that will
-       be called to automatically add or modify a trailer with the
-       specified <token>.
+       This option can be used to specify a shell command that will be cal=
led:
+       - once to automatically add a trailer with the specified
<token>, and then
+       - each time a '--trailer <token>=3D<value>' argument to modify
the <value> of
+       the trailer that this option would produce.

Wouldn't it be weird?

>        When the specified command is first called to add a trailer
> with the specified <token>, the behavior is as if a special
>        '--trailer <token>=3D<value>' argument was added at the beginning
> of the "git interpret-trailers" command, where <value>
>        is taken to be the standard output of the command with any
> leading and trailing whitespace trimmed off.
>
>        If some '--trailer <token>=3D<value>' arguments are also passed
> on the command
>        line, the command is called again once for each of these
> arguments with the same <token>.
>        And the <value> part of these arguments, if any, will be used
> to replace the first occurrence
>        of substring `$ARG` in the command. This way the command can
> produce a <value>
>        computed from the <value> passed in the '--trailer
> <token>=3D<value>' argument.
>
>        For consistency, the first occurrence of substring `$ARG` is
> also replaced, this time with the
>        empty string, in the command when the command is first called
> to add a trailer with the
>        specified <token>.
> -------------------
>
> Thanks!

Thanks a lot!
It looks more professional than what I wrote.

--
ZheNing Hu
