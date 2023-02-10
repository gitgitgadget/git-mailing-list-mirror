Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC522C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 15:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjBJPaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 10:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjBJPaB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 10:30:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE6ABC
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:30:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ba1so5427767wrb.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOFZpDFSmYiCknnwLbNzdqIKv/sLCXLqbrwC06HPmGk=;
        b=hg02cVFsvcbRDrEHH5embsPbuOQv88460u7xWLRIIit7YzNW9playy8D6ybOab40hd
         5p4F3zeyhRpqU2tVlOUSuTl1/EUcJwXkY8WzAzGO0g6irtxarO+5NmrBUIABvfh+aFg1
         U3enQ7pznDTIx/dLEhQL1egkhqgALHH+sGfc5LQi4lCtxZ9YZnx6fWiQaOW6EHEw1NeO
         OJG4A+E3tZNnoyLPVgSdCxtVmT2WiGKO/dAMOXtFxQy/0cq6r5BcHwW4rEki73gs1xED
         FG8U8rMWqm2fYW7LyhqnZrwrOw6xkYbxitVCfFthFKt06lDFwXWJzHRVrnVXR8JSYCdP
         DGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOFZpDFSmYiCknnwLbNzdqIKv/sLCXLqbrwC06HPmGk=;
        b=oNAPcsB2hkp4gewmopVXvON9DEKTic3wfyPy9Xvr58APP18mijJ83BUvSkUlEuXXbp
         NHwdIqAx0HgR5kQ6InsENmha8FuqrjP45B3ZQC22XAsdCmuodBNgp6w/xp10PeXIrfOW
         J4KHRVnBIoeIZ55/dsDbP9NKI4Zt8YAus7aLSGrWltS9QwobZoGsCsSBVqBHZKWCzny1
         MjtIc7OTiEWKKxC1/s/IC/KfeJWuBwjBsf08eaKj9wzVtfKRi4RZ8oe8a5uJxTwHLZzK
         SZ1HY21n/IfCnm68Wy8Ah6ilssiTK/+bmZCMyIDHGGQenpGs4EJIHOzDGYO5Y++Ja+tS
         FuHQ==
X-Gm-Message-State: AO0yUKWUPxxBoyqgeSsTvxfZO8p73WZt99pqCAuNVFfupUwuIKkU9JiZ
        jc+cf2PJizDYkSCv+C64V0k66Me+5R5gccO+JZQRuSAfGq35Rw==
X-Google-Smtp-Source: AK7set9Fbw+hwXT8GxIeyIyrFN2V02g28Es0NwYy1GlF7ChWf6ZalcJPQMOImIZkaANhLLCphoosD1sn9HP/EEfKTLg=
X-Received: by 2002:adf:f490:0:b0:2c3:ed5b:cb67 with SMTP id
 l16-20020adff490000000b002c3ed5bcb67mr918485wro.275.1676042998486; Fri, 10
 Feb 2023 07:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20230205145245.11078-1-cheskaqiqi@gmail.com> <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com> <xmqqlela2z3p.fsf@gitster.g>
 <CAMO4yUGmQ371hLCSTODQct+CzY2mqywfLzZO6fsgqN2=1cWGrw@mail.gmail.com>
 <230207.86h6vx51x3.gmgdl@evledraar.gmail.com> <CAMO4yUEcweeGZDCBm-y51TQ0fgze_geKr95RXBpEEpH4AyYJuQ@mail.gmail.com>
 <230208.865ycc1tqc.gmgdl@evledraar.gmail.com>
In-Reply-To: <230208.865ycc1tqc.gmgdl@evledraar.gmail.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Fri, 10 Feb 2023 10:29:45 -0500
Message-ID: <CAMO4yUHZ=aUa5pOCKH4F91YhUSgCRuHNXBBOyTF5tzNY=oHsXw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var ,

Sorry if  I sent this email twice. I forget to CC  git@vger.kernel.org.

On Wed, Feb 8, 2023 at 2:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:

> I'm not sure because you're just posting snippets, if you have problems
> in the future it would be best to post the full diff to "master" that
> you're having issues with, e.g. an RFC per Documentation/SubmittingPatche=
s.

Yeah, posting snippets doesn't describe the problem very well. Thanks
for the advice.



> But I think this is because the test itself is using '-quotes, so you
> need to use '\'' if you want to single quote, and " for double quotes,
> and \" if the test were in double quotes.


> But the issues you're having here aren't with Git, but the very basics
> of POSIX shell syntax.

> I think it would be good for you to read some basic documentation on
> POSIX shells, their syntax, common POSIX commands etc. Your local "man
> sh" is probably a good place to start, but there's also books, online
> tutorials etc.

Thanks, will do .  I'll  try to avoid making mistakes on POSIX shells
questions and really learn the basic  POSIX shells syntax.

> In this case the syntax you're trying to get working is something we
> usually try to avoid in either case, i.e. even if it involves an
> external process we usually do:

>         cat >out <<-\EOF
>         a
>         b
>         c
>         EOF
>
> Rather than:
>
>         echo "a
>         b
>         c" >out
>
> If you are using "echo" I saw another change of yours had e.g.:
>
>         echo x >f &&
>         echo y >>f &&
>         echo z >>f
>
> It's better to e.g. (assuming use of "echo", or other built-ins or
> commands):
>
>         {
>                 echo x &&
>                 echo y &&
>                 echo z
>         } >f

Seen I pass the test s, I'v a submit  V5 patch instead of RFC, Would
you mind taking a look at this for me? Looking forward to reply.

-----------------------------
Thanks

Shuqi

On Wed, Feb 8, 2023 at 2:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Wed, Feb 08 2023, Shuqi Liang wrote:
>
> > On Tue, Feb 7, 2023 at 3:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >
> >> But this is almost certainly that you're trying to insert leading
> >> whitespace into a line that's in a <<-EOF here-doc, the "-" part of th=
at
> >> means that your leading whitespace is being stripped.
> >>
> >> A typical idiom for that is have a marker for the start of line, and
> >> strip the whitespace with "sed". See this for existing examples:
> >>
> >>         git grep 'sed.*\^.*>.*EOF'
> >
> >
> > I try to use Z as the marker in front of 'a' and 'b' and use sed -e
> > "s/Z/ /g" in order to replace Z with white space but it still can not
> > pass the test.
> >
> > Then I realize even if I don't add tab in front of the line but with
> > space in front of 'a' and 'b' like the original test script. It still
> > says it can't read "b" and "c=E2=80=9D =EF=BC=9A
> >
> > test_expect_success 'apply at the beginning' '
> > cat >test-patch<<\EOF &&
> > diff a/file b/file
> > --- a/file
> > +++ b/file
> > @@ -1,2 +1,3 @@
> > +a
> >  b
> >  c
> > EOF
> >
> > echo >file 'a
> > b
> > c'&&
> > git update-index file&&
> > test_must_fail git apply --index test-patch
> > '
> > Maybe the error is not caused by whitespace?
> >
> > Then I try to change:
> >
> > echo >file 'a
> > b
> > c'
> >
> > To:
> > echo >file "a
> > b
> > c"
> >
> > Then everything passes the test. I think double quotes allow for
> > variable substitution and command substitution, while single quotes
> > preserve the literal value of all characters within the quotes. In
> > this case, the string contains no variables or commands, so either
> > type of quote would work. Is there something wrong with my idea? Is it
> > good to modify code like that?
> >
> > Looking forward to your reply!
>
> I'm not sure because you're just posting snippets, if you have problems
> in the future it would be best to post the full diff to "master" that
> you're having issues with, e.g. an RFC per Documentation/SubmittingPatche=
s.
>
> But I think this is because the test itself is using '-quotes, so you
> need to use '\'' if you want to single quote, and " for double quotes,
> and \" if the test were in double quotes.
>
> But the issues you're having here aren't with Git, but the very basics
> of POSIX shell syntax.
>
> I think it would be good for you to read some basic documentation on
> POSIX shells, their syntax, common POSIX commands etc. Your local "man
> sh" is probably a good place to start, but there's also books, online
> tutorials etc.
>
> In this case the syntax you're trying to get working is something we
> usually try to avoid in either case, i.e. even if it involves an
> external process we usually do:
>
>         cat >out <<-\EOF
>         a
>         b
>         c
>         EOF
>
> Rather than:
>
>         echo "a
>         b
>         c" >out
>
> If you are using "echo" I saw another change of yours had e.g.:
>
>         echo x >f &&
>         echo y >>f &&
>         echo z >>f
>
> It's better to e.g. (assuming use of "echo", or other built-ins or
> commands):
>
>         {
>                 echo x &&
>                 echo y &&
>                 echo z
>         } >f
