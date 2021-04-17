Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181E2C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 07:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D4F61186
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 07:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhDQHmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 03:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhDQHmB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 03:42:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345FCC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 00:41:34 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id g125so1257347iof.3
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LG3PJu75ik+9uaC8wSdIEBW8S7BBls4zhY8Ei1JKZFE=;
        b=LQWuZZw1Ok086Hdbr5/0+vz+p32zEgdoMR3tGek5dhtuOys29ES5AfkQBoDMlIHlLv
         3XJ8n6Z5H7GrWiASEamaJK2ahMdLWVHvE9uKnE7mQGzPZM2J8/SomRhEHCu+DLjNsxWU
         2UwIJlnXODB212ZRi5IPlaqHneeaf5ubdm7dfacUSKjN574uHx6c0w0+lX1jvTN4IS3u
         zRQPe7NyVrnlME0R9N/LmgrtHbp043rwQJNuCXm0N9EpAd4nnbWcdOwcdJlV6IfF4jQQ
         PmJMOFO86eNVAtW7u2zj+isKF2tQc9oQMqTtKgBdPZ1TuB2/G/F1iyLDKwj7MZhxcRYa
         KyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LG3PJu75ik+9uaC8wSdIEBW8S7BBls4zhY8Ei1JKZFE=;
        b=QOBpPTzqa33aDJscqBh+s86M8y95oGcdsah67AQiaZLcbjrZX8LLLDPupD6gBTKFCK
         IKzZ4pEfv8mbW24pq9lHzwyWQyl7d4hK4ungHWVkj4yO/J+cPai1p8lxEcviMoxszGOJ
         FQHTVxvcHSlKx2INPJlv0LIrVPiMEeNOrl3pIFvt7M/j1tUmWZmWaErDt2tEiOU9benE
         k6cyfocjLKbK0AI67t1N5+ecYP5SZnVcKP61+7PW1FF8SUAmvOQsnV46jBSBkobpObth
         GreJK4jKg6Sqdp8LvHhc7AJKfGbAw3NsTyXRvFj1oIjvGBQkOpxBjbGAl5kYZD+uyBOh
         dEcA==
X-Gm-Message-State: AOAM5320+BTlw3l+DvX6mrKM1qZ2x8hjjI4AmRbwXyLRI+/0WJLqZ5Vk
        JTWcBVP6SmVa+n+lEGXWLuazytWB0KkQExD+enI=
X-Google-Smtp-Source: ABdhPJxlCWY6VTpP9/f/D0xwKYmvl8PjLdiC99B0nCt2Nrj5HO2g3AcgC3BkghGjFNxUt/Ty16hkC9691id3KNqkqkA=
X-Received: by 2002:a5d:848a:: with SMTP id t10mr6793545iom.68.1618645293480;
 Sat, 17 Apr 2021 00:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
 <pull.913.v10.git.1618562875.gitgitgadget@gmail.com> <daa889bd0ade1111eb8b1471fe7e953fcb41d12b.1618562875.git.gitgitgadget@gmail.com>
 <xmqqy2dikpc1.fsf@gitster.g> <xmqqr1jakp57.fsf@gitster.g> <xmqqpmytiplw.fsf@gitster.g>
 <xmqqlf9hinuw.fsf@gitster.g>
In-Reply-To: <xmqqlf9hinuw.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 17 Apr 2021 15:41:17 +0800
Message-ID: <CAOLTT8S-CLSk6Obu-8L+QKb9YjBufVTMcTnSrfaUOQmyej59TQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] [GSOC] trailer: add new .cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8817=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8811:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > And continuing this line of thought, I think it would be a perfectly
> > fine extension to allow the script/program that is launched by the
> > .command or .cmd mechanism to signal interpret-trailers that it does
> > not want it to add a trailer as the result of this invocation by
> > exiting with non-zero.  And that would be a reasonable way forward
> > without having to add yet another ugly workaround .runMode.
> >
> > For example, trailer.signoff.cmd could be this script:
> >
> >       #!/bin/sh
> >       if test $# !=3D 1
> >       then
> >               exit 1
> >       else
> >               git log -1 --author=3D"$1" --format=3D'"%aN" <$aE>'
> >       fi
> >
> > where the "implicit" invocation is signalled by not passing any
> > argument, to which the script reacts by exiting with 1, and the
> > interpret-trailers would discard the result of the unasked-for
> > invocation.
>
> The beauty of this approach, compared to say .runMode, is that the
> program specified by .cmd (and .command, except that it cannot tell
> if the invocation is in response to explicit --trailer=3D<key>:<value>
> request, or the extra one that is done even without being asked)
> have even better control in squelching the trailer output.  Not just
> to silence the extra unasked-for invocation, it can inspect the
> value given to each of --trailer=3D<key>:<value> option and decide not
> to add a trailer in response to it.
>

If I understand correctly, Your approach may be like this:

First, Those `<token> <value>` pairs we passed on the command line
will use one positional parameter in the shell-script.

Second, if it is the trailer implicitly added, originally it was
`<token> ""`, now we turn it to `<token> NULL`, This will make
the shell-script not pass positional parameters.

Then our shell script can distinguish them by the value of $#.

If we want shell-script to execute implicitly anyway, We can do nothing.
the shell-script can be like  as Christian mention:

#!/bin/sh
echo "$(git config user.name) <$(git config user.email)>"

But If we want shell-script to reject implicit execution, We can judge the
value of $# : 0 exit , 1 normal as you mention:

#!/bin/sh
if test $# !=3D 1
then
    exit 0
else
    git log -1 --author=3D"$1" --format=3D'%aN <%aE>'
fi

I agree with your approach.
But when I am reproducing your solution, I may be in trouble:
If we let shell-script `exit(1)`, `capture_command()` will output
"running trailer command '%s' failed" which is its origin strategy
in order to catch the user's command error.

But If we use `exit(0)` , The headache is coming again:

Signed-off-by:

the empty value trailer still output. What we want is that those
"<token> NULL" are rejected here, we don=E2=80=99t want any other output,
do we?


Thanks.
--
ZheNing Hu
