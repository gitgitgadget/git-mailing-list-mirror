Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404DDEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 12:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjGGM0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGGM0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 08:26:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA11FEA
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 05:26:45 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2632336f75fso1317524a91.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688732805; x=1691324805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr1fA1ST3mVFDCuZEiI26aFGPz+svqLRigQmldDx/hg=;
        b=s2cDysZORuI6TKM0nXnv6iBNmubE5gA48p+09ytzy/8nLPu3GPanj8yB/MoQZk99Qi
         pdBG1rHwK1QQZ+fAcYYCyw3JfjTUkK+6u+3Yjxl/EbwPEd87E3FVvUQQHSwTYY3nhx/m
         4RVle6laHMwZqICGgi6Tl3S1EOkUVCIV+Anzww/JNBPiXbvPxazFbvyIR0XRoq5Lo0aD
         MJQgNcL38Eap2O6M5IO4RKr5aJdM896l1owH9kf56fDBAOIbeNoRDsgRr4N24IfCHNfz
         aARqC8eCbfSNMKN5xLzoweca5ymZNR31OacmJMVYCy+TkPrd+AYBWQJgxv9IYUosdMLU
         t7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688732805; x=1691324805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr1fA1ST3mVFDCuZEiI26aFGPz+svqLRigQmldDx/hg=;
        b=cuZcu/W53zsRqZEGvBzsXIeO4BqulbOcrCCkmCFxPwHjE0Y1dOD/6//vvHPMjHjoIM
         kgynqIZGcPB3PMA0WRxNMluWE+mUgZohZCr8K7lut8PgIInt87Qd08CEl3C3IRVIAik3
         +ULfmGbBcFMKypS2PTvmNkbH7ea9JCSvNnCQ8aUTWMmXputF6ZOUsEoFin15a7sDVd+I
         9j8Xi9vSi7zAWNu1q4QInY7lxTD5M4/U0Q2iDbExijXvXc3KP5fWwMf/M7vBQcr2lzMj
         03V+NwsWBsAibu6zvNJ3XryDTpPagqU2HVWXzCi/2FMBW0mQI0yAxGt0z3fkHUsbVLz3
         J6KA==
X-Gm-Message-State: ABy/qLYs+VIotrJa/1PIpxM4VZG7gy4xQfXi61CZ0JgF6csMus/ODbaL
        UwEYNDa8rabIMjKEDyiaoH/ldGlmfKdstRinGOQ=
X-Google-Smtp-Source: APBJJlFt5+stDOK7N32hpohnhyRWcf/Mxej2OlFdWX/Rl6WDP4xUZ2CQfufIR2WV8Wzwew/SHdNcq2FCAE0PJhTJ86c=
X-Received: by 2002:a17:90a:9b0b:b0:263:479:3dc with SMTP id
 f11-20020a17090a9b0b00b00263047903dcmr4519162pjp.19.1688732805059; Fri, 07
 Jul 2023 05:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <AN0heSrMCnygWUC5Sh1UA9v2JGtjcxYDKPFE0xUPddGEW29c3w@mail.gmail.com>
 <20230705183532.3057433-1-martin.agren@gmail.com> <xmqqv8eyyw2g.fsf@gitster.g>
In-Reply-To: <xmqqv8eyyw2g.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 7 Jul 2023 14:26:33 +0200
Message-ID: <CAN0heSpY-vYVFznq9YLtjj0Enmf957ASCLdN_Eyz0ZLKd82FWg@mail.gmail.com>
Subject: Re: [PATCH v3] t0091-bugreport.sh: actually verify some content of report
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Jul 2023 at 21:53, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > +test_expect_success 'sanity check "System Info" section' '
> > +     test_when_finished rm -f git-bugreport-format.txt &&
> > +
> > +     sed -ne "/^\[System Info\]$/,/^$/p" <git-bugreport-format.txt >sy=
stem &&
> > +
> > +     # The beginning should match "git version --build-info" verbatim,
> > +     # but rather than checking bit-for-bit equality, just test some b=
asics.
> > +     grep "git version [0-9]." system &&
> > +     grep "shell-path: ." system &&
> > +
> > +     # After the version, there should be some more info.
>
> Do you want to assert the "after" part?  "grep" alone does not do
> anything of that sort.

Right, I remember thinking this 'after' could be useful to a human being
reading along, but that the test isn't enforcing it, as you point out.
If it's just misleading though, maybe we're better off either dropping
the "After" or enforcing it.

> > +     # This is bound to differ from environment to environment,
> > +     # so we just do some rather high-level checks.
> > +     grep "uname: ." system &&
> > +     grep "compiler info: ." system
> >  '
>
> Don't we at least want to anchor all these patterns with "^" or
> something?
>
> Alternatively, since we do not expect the values of the fields are useful
> at all, perhaps doing something like this
>
>     sed -n -e '/^\[System Info\]/,/\[Enabled Hooks]/s/^\([^:]*):.*/\1/p' =
>names
>
> to ensure that we have the fields we expect in the output makes more sens=
e?

The latter would make sense, yes. I could amend the patch to do
something like that, but I see you've already merged it to next. I'll
look into doing it as a patch on top during the weekend.

> I notice that "git version:" does not have its value on its line.
> Isn't it a bug we would rather fix before writing this "sanity check"
> test, I have to wonder.

Yeah, I noticed this. In my case, there's this:

 git version:
 git version 2.41.0.428.gbd0ef4c9fd
 cpu: x86_64
 built from commit: bd0ef4c9fd591e9c2ea1310dae92fe07a51438c7
 sizeof-long: 8
 sizeof-size_t: 8
 shell-path: /bin/sh
 uname: [...]
 [...]

IMHO, "git version: git version 2.41.0.428.gbd0ef4c9fd" would look sort
of weird. I tend to think "git version:" is more of a header for the
first several lines. It could perhaps be something like this, after
adding "--build-options" and indenting its output:

 git version --build-options:
   git version 2.41.0.428.gbd0ef4c9fd
   cpu: x86_64
   built from commit: bd0ef4c9fd591e9c2ea1310dae92fe07a51438c7
   sizeof-long: 8
   sizeof-size_t: 8
   shell-path: /bin/sh
 uname: [...]
 [...]

That's how I think of the contents. Actually changing the format would
be out-of-scope for the test updates, of course. I also wonder if there
are scripts out there trying to parse these reports and how they would
cope with such a tweak to the format.

Martin
