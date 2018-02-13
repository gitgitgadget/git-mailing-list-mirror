Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB731F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965365AbeBMSLw (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:11:52 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:40282 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965286AbeBMSLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:11:51 -0500
Received: by mail-yw0-f177.google.com with SMTP id y186so5009695ywf.7
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zNR1KWHXPKVnYoAsqlbiMbYkDVrWloQLa79H0RaV/TI=;
        b=B4UxOo3zY2sLDQBubW1JSH7qRZhs2zxbK04wNcUqGEXSLFmEQYb5ol8ApwTSf28/sy
         S0vQ3uM5UI/MCtlT3ag6IexoSw95fW3Ebh5Z+RryrSAeaGBjBZaJ5ufk8hb67v2zBBN+
         Ti15GY9xijuuZr2ONRlHzGY+O/GQSU8AWWYlQArrA/rxcm2pO1LurJGndiuKhvVIPlZ5
         sOWJxxfniChAhCzOWN+sEdYaniokh40AkUj6Qjss6Ul8ATEwgQMlUp2gOnXwBhnCM87r
         LEwMNH0VvPlXkJXdeg6SsimRGeAt28bV+crTHuxS38xPt3Yi+hYGgq3CsVdPEsJ8iSTT
         OkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zNR1KWHXPKVnYoAsqlbiMbYkDVrWloQLa79H0RaV/TI=;
        b=KBk01/G84c9QhCH7hh1mNehaCjsFYARlrpRfSUj4z6jaCQ4d1Ug0zb64use9S8MmX8
         k+q9AFa0PMNgL2D9acd/5uFblaGWeoyYZ7ISjtiSUMWSnzpv5XbZjtmHC0gy+fpLa/Jk
         jFt3uzqngVvgjNdLs8bO8YLe6DIvwGEhkYrIDus7t9SqmXjaDO1O4qdv2ti6O6+WZnmA
         oaF+cCXLgt91lI8V/MB5j1C+iuXEn/ZPFkGAzMvtQ75lHYTEM2+zVg64M0Lk1o7baWYT
         +vBBecxiLZHRY8DyaJpEi/A4JoyLHik/mm9A1f7//ZumxQRbQY6tgeWkIzfascOWV9YK
         1E8w==
X-Gm-Message-State: APf1xPCGkFyrM5bkbwxTcbSWoIzwDrL+hDP2ZDCdgMX6QybkZioXT9ri
        vsWdnwQeXJdf5OrEQ3W5b85u32ThyovwkdQbksA53A==
X-Google-Smtp-Source: AH8x224wvgCVBv8q9U2uc0ybhHYIPLxkoA5tNAkimQsRI84PkAinAXjAUIJFZn/kUNnT5OA0p/RPEeFzIsYSx1Klu6Q=
X-Received: by 10.37.34.138 with SMTP id i132mr1423256ybi.114.1518545510550;
 Tue, 13 Feb 2018 10:11:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Tue, 13 Feb 2018 10:11:49 -0800 (PST)
In-Reply-To: <20180213160824.GA5203@sigill.intra.peff.net>
References: <CAOmC-AncOZfAwowXLjwDbL9Bdx1+=RbXsrd72LzEBd2W-=LAQg@mail.gmail.com>
 <20180213160824.GA5203@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Feb 2018 10:11:49 -0800
Message-ID: <CAGZ79kYXStMQCxnVjpV7n7miZEDAw4moR+0JksgTaRqHJwgSqw@mail.gmail.com>
Subject: Re: make git diff output easier to read - use better diff heuristics
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?zqPPgM+Nz4HOv8+CIM6SzrHOts6xzq/Ov8+C?= 
        <sbazaios@gmail.com>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 8:08 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 13, 2018 at 05:06:15PM +0200, =CE=A3=CF=80=CF=8D=CF=81=CE=BF=
=CF=82 =CE=92=CE=B1=CE=B6=CE=B1=CE=AF=CE=BF=CF=82 wrote:
>
>> Hi, I've came across an issue when using the git diff command. In
>> particular the diff is different to what the svn diff produces. While
>> both being correct the output of the svn diff is easier to understand
>> than the git diff one. See the following issue on github where I
>> initially reported the issue:
>>
>> https://github.com/git-for-windows/git/issues/1494
>>
>> I have Included a picture to better illustrate the problem. What do
>> you think? Is it possible to make git diff output similar to svn diff
>> regarding this issue?
>
> Try "git diff --no-indent-heuristic", which makes your example look
> better. Here's a quick reproduction:
>
> -- >8 --
> cat >foo.c <<\EOF
> static struct foo bar[] =3D {
> #ifdef SOMETHING
>         { "stats.info", MNU_GBX_FSTAINF, etc },
>         { "expired.info", MNU_GBX_FSTAINF, etc },
>         { "info.log", MNU_GBX_INFOLOG, etc },
> #endif
>         { NULL, 0, 0 },
> };
> EOF
>
> sed '6a\
> #ifdef WITH_EMU\
>         { "SoftCam.Key", MNU_CFG_FSOFTCAMKEY, etc },\
> #endif
> ' <foo.c >bar.c
> -- 8< --
>
> Now this looks ugly:
>
>   git diff --no-index foo.c bar.c
>
> but this does not:
>
>   git diff --no-index --no-indent-heuristic foo.c bar.c
>
> That heuristic is described in 433860f3d0 (diff: improve positioning of
> add/delete blocks in diffs, 2016-09-05). I'm not sure exactly why it
> does the wrong thing here, or if it would be possible to tweak the
> weighting factors to make it work.

https://github.com/git/git/commit/433860f3d0

I would think that the long lines at the shift boundaries[1] have
bad impact on the algorithm as they are of different length
and influence the backstepping value. (vague theory)

I wonder if we want to add language specifics to the heuristic,
such that '}' or 'end' in a given line have a strong signal that the
cut should be right after that line? i.e. that would decrease the
badness score.

While this is not a general solution (but quite language specific),
I would think this is still a good idea to look at.
(When coming up with the heuristic, most people thought the bad
examples would come from exotic languages, but not C, which we
are all so familiar with such that we thought we had a good grasp
how to make a heuristic that works with C. Note that the example
looks like C, though).

[1]
{ "info.log", MNU_GBX_INFOLOG, etc },
vs
{ "SoftCam.Key", MNU_CFG_FSOFTCAMKEY, etc },\


(slightly unrelated tangent on better diffs in general:)
A couple days ago I had another discussion on how
diffs are best presented to users. That discussion was
focused on a slightly higher layer, the diff algorithm itself,
instead of a post-algorithm boost-fixup.

It is usually easier to both write as well as review code that
adds completely new features or projects instead of squashing
bugs or integrating subtle new features in an existing code base.

This observation lead to the conclusion that reviewing large
locks of adjacent new lines is easier than reviewing blocks
where deletions as well as additions are found. So we theorized
that deletions should have more impact than additions when
computing the diff itself. The case presented here has no deletions
so this is not applicable, but most examples that came up once
2477ab2ea8 (diff: support anchoring line(s), 2017-11-27)
was discussed would be likely to have better diffs.

Stefan
