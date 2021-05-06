Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E213C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD49610C8
	for <git@archiver.kernel.org>; Thu,  6 May 2021 09:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhEFJNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhEFJNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 05:13:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD3C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 02:12:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n138so6780046lfa.3
        for <git@vger.kernel.org>; Thu, 06 May 2021 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NJWWAxy5H2OkwByjPwBBKGAL/lvHEQU2a42AcS2jiNA=;
        b=vcVVFQdSqrZqvuwCLFcHntdswwDI0ES6UgkYxrprlhMaQylyhfoMOmjws7rF66NKdZ
         ezpTDlrj+ywru/d1g41A2R4BAFk3MpUxvYW6gn0hBgWWbjAWBz9mTq9M4174sRLkgNzP
         gbWK8cr5LIrvmZLVgi5BW2+AtdpLDuiDFA48zXE/ZGGd3qDSHBH/uNiYl5KPjI9xq1Mj
         JJJyxi013L/qMAS6mwm9P56b/38GAQptKcfCR84bbaFsKFGaeBvLAt8nIaOScA3v0K88
         ZhfLJMTiof/8mwWhs+rUEFiADUJoQsg/kiYGQWZWYENrXRrWnpCzsxvXEi2OBuLwRfJY
         Ik5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NJWWAxy5H2OkwByjPwBBKGAL/lvHEQU2a42AcS2jiNA=;
        b=dps/Iwyjj+m2RDdaGl+hEuKKooQvTZ4y4yqlSgoGaIh4qGPNxUa1afJBSEKeUX/ZJF
         3H3dr/hhJMPWIlP7Gyx+iHBj9WlgHz1CL3GPMpp7HrdOmzRPtFcttrEOXcFz4ymL9cfb
         c2fj9NatB+7PoxwWbtL/V2b+zHi9RAIn1QGBs/1yIS5zNUcZxa1+JK23Ou9YlJU01jPa
         TuyMQj3FvCj2ziNMcgRWvbr3JyP0fFI8dYnMGq2vOEscG3pfBNfOO8l+yTmmNR+RGGRt
         msASOe1dbMozoqYr/18cfQSZzZ11PlkvXSavHcsFhgONUTobcseRjLyyX3068vDdVNW6
         SABw==
X-Gm-Message-State: AOAM5332RiTnfZecSsW/QdqUMOw1iU/s54cSGd5AgKyTByc3aujdUxoz
        psRLnQa/NYOvsjE5kmjeAuMClslDLZW4rak1zm4=
X-Google-Smtp-Source: ABdhPJz/RdNberW7ovodsBUESrE34SccU9nM3ENzmVyK0RO0P0D3TWRgaIvMG0ak61xkRNOj5eQfsK8/L42YqMnz4bI=
X-Received: by 2002:ac2:53aa:: with SMTP id j10mr2168800lfh.524.1620292371133;
 Thu, 06 May 2021 02:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
 <20210504151954.aczbvml4rh7t2svc@tb-raspi4> <xmqqtuni58ra.fsf@gitster.g> <20210506043429.zqgzxjrj643avrns@tb-raspi4>
In-Reply-To: <20210506043429.zqgzxjrj643avrns@tb-raspi4>
From:   Mark Amery <markrobertamery@gmail.com>
Date:   Thu, 6 May 2021 10:12:40 +0100
Message-ID: <CAD8jeghZKDcp=weHtcMZ4z8KaO1jQJqfPqaRtYgtiwrX-1+NNg@mail.gmail.com>
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, I'm just a dumb Git user who doesn't even write C, so much of this
discussion is over my head, but I have a few thoughts that may be
helpful:

=E2=80=A2 The mv utility on Mac is capable of doing `mv b=C3=A4r.txt b=C3=
=84r.txt` just
fine. Maybe `git mv` can learn something from whatever `mv` does?

=E2=80=A2 On a case-insensitive file system, `git mv somedir sOMEdir` is a
rename. But on a case-sensitive file system, it might NOT be a rename;
it might be the case that `somedir` and `sOMEdir` both exist and that
the command should put `somedir` inside `sOMEdir`. I mention this
because I can imagine some naive attempts at fixing the original bug
by doing a case-insensitive comparison of the two names ending up
breaking this behaviour on case-sensitive file systems by wrongly
treating such a command as a rename. It's probably worth having a test
that this scenario gets handled cleanly on case-sensitive file
systems? (I haven't checked whether Torsten's proposed diff falls into
this trap or not.)

=E2=80=A2 Above, Torsten mentions that there are filesystem-specific rules
about what names are equal to each other that Git can't easily handle,
because they go beyond just ASCII case changes. In that case, maybe
the right solution is to always defer the question to the filesystem
rather than Git trying to figure out the answer "in its head"?

  That is: first check the inode or file ID of the src and dst passed
to `git mv`. If they are different and the second one is a folder,
move src inside the existing folder. If either they are the same or
the second one is not a folder, then do a rename.

  It seems to me that this approach automatically handles stuff like
`git mv b=C3=A4r.txt b=C3=84r.txt` plus any other rules about names being e=
qual
(like two different sequences of code points that both express "=C3=A0"),
all without Git ever needing to explicitly check whether two names are
case-insensitively equal. Am I missing something?

Sorry if any of the above is dumb or if I'm reiterating things others
have already said without realising it.

On Thu, May 6, 2021 at 5:34 AM Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:
>
> On Wed, May 05, 2021 at 09:23:05AM +0900, Junio C Hamano wrote:
> > Torsten B=C3=B6gershausen <tboegi@web.de> writes:
> >
> > > To my undestanding we try to rename
> > > foo/ into FOO/.
> > > But because FOO/ already "exists" as directory,
> > > Git tries to move foo/ into FOO/foo, which fails.
> > >
> > > And no, the problem is probably not restricted to MacOs,
> > > Windows and all case-insenstive file systems should show
> > > the same, but I haven't tested yet, so it's more a suspicion.
> > >
> > > The following diff allows to move foo/ into FOO/
> > > If someone wants to make a patch out if, that would be good.
> >
> > Is strcasecmp() sufficient for macOS whose filesystem has not just
> > case insensitivity but UTF-8 normalization issues?
> >
>
> Strictly speaking: no.
>
> The Git code doesn't handle UTF-8 uppper/lower case at all:
> git mv bar.txt BAR.TXT works because strcasecmp() is catching it.
>
> git mv b=C3=A4r.txt B=C3=84R.TXT needs the long way:
> git mv b=C3=A4r.txt baer.txt && git mv baer.txt B=C3=84R.TXT
>
> We have been restricting the case-change-is-allowed to ASCII filenames
> all the time.
> There is no information, which code points map onto each other in Git,
> since this is all file system dependent.
> NTFS has one way, HFS+, APFS another, VFAT a third one, and if I expose
> ext4 via SAMBA we probably have another one.
> Not mentioniong that ext4 can be use case-insensitve on later Linux kerne=
ls,
> which sticks to unicode.
> Or Git repos running on machines using ISO-8859-1, those should be rare t=
hese
> days.
>
> That said, people are renaming files in ASCII only and are happy,
> and in that sense renaming directories in ASCII can be supported
> without major hassle.
>
> And the inode approach mentioned as well:
> This could go on top of strcasecmp() to cover non-ASCII filenames
> or other oddities, if someone implements it.
>
>
