Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7323C2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 13:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA48C206F0
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 13:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="NE6spOu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAYNVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 08:21:37 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:32921 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYNVh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 08:21:37 -0500
Received: by mail-il1-f170.google.com with SMTP id s18so3520258iln.0
        for <git@vger.kernel.org>; Sat, 25 Jan 2020 05:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ezoOo9DryZivKSkDuTZisHWECEYsAiyDj3/CCPCBb8=;
        b=NE6spOu8SueHF5Y4pEg1Vlp3IkytKdmqUp4iZhG01l1fJebp8MF+xi0HmYuFIHIpMN
         Fl3BRQES6MdeqqC+lV1Va0l/LOEmNcmG5fGjbO5gglyf9NFON71Z++TpW6Qxzp1iqf45
         4+vCeLRUU/XzB0hB94Sg7Iu38VjdgLhTj4zqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ezoOo9DryZivKSkDuTZisHWECEYsAiyDj3/CCPCBb8=;
        b=bHdwG8zBjR9lQtHX1Q1ULAAXcFnPnTXBp9kXXfJJIqOuNoPQTAXrXaN2xZWt3TXLUe
         DPJbveYauSz3aCG8HadoYBYW9H9qQtg2HUDaAZXX0M4rR/dIA3eKqqmIsSPVlxj21dfs
         YnveRgEifjFR0sukfkLyf+F2V3dAEC4vhc+mDziM90eD8SH+ulWHmMcDnjcemEgiBhSd
         vvDpnFkZM2xU9WcWCu04iMtCUN5AQAz2GFHvTsIBqgjYSpoZqe3fXsJuCQuX2MFNAr3b
         1aMXzJ/L0cMZ7f2j3x+EX4lA+mOaglIPU9l7PeP226MvMNOu9ju3OQusmsXNRb6bzPnw
         6Ydg==
X-Gm-Message-State: APjAAAWVvCH7AtBT2jih63ACxHPnUPEKR3pouxMBx+T6Hm4aTLS3sP+s
        m+EAgyNFo2unsb63HS7LuJocVevHZkOvEn0mQft41Q==
X-Google-Smtp-Source: APXvYqwgOp2A54MkLQDGywjXMxh4UggvqtMTrtohIXMhckcc4eP7tZgnLyffuLtpjm5lIy1mF3VPtYSCMyJMPP2yR1s=
X-Received: by 2002:a92:8141:: with SMTP id e62mr7414391ild.119.1579958496422;
 Sat, 25 Jan 2020 05:21:36 -0800 (PST)
MIME-Version: 1.0
References: <CAA-mk2_jB2X1J-NCXQ92spa-fmEct9G9f1iQo7t8=rvD5coFDA@mail.gmail.com>
 <20200124190119.GB1672342@coredump.intra.peff.net> <xmqqk15gzmc8.fsf@gitster-ct.c.googlers.com>
 <20200125000051.GA566074@coredump.intra.peff.net>
In-Reply-To: <20200125000051.GA566074@coredump.intra.peff.net>
From:   =?UTF-8?Q?David_Burstr=C3=B6m?= <davidburstrom@spotify.com>
Date:   Sat, 25 Jan 2020 14:21:25 +0100
Message-ID: <CAA-mk2-X9kdS1h+6P0Y5wASHjFPJBKK-Dw9C1+OJL5U-nouVRg@mail.gmail.com>
Subject: Re: Bug or unexpected behaviour in git show <rev>:a\b
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 25 Jan 2020 at 01:00, Jeff King <peff@peff.net> wrote:
> > > We _could_ also say "even though this could technically be a pathspec
> > > because of its metacharacter, it looks vaguely enough like a
> > > path-in-tree revision that we shouldn't guess". That I'm less
> > > comfortable with, just because it makes the heuristics even more
> > > magical.
> >
> > Not just it becomes more magical, I am afraid that the code to
> > implement such a heuristics would be fragile and become a source of
> > unnecessary bugs.  Let's not go there.
>
> OK. It does mean that:
>
>   git show HEAD:a*
>
> will still quietly produce no output instead of saying "hey, there is no
> a* in HEAD". But I think given the lack of bug reports over the years
> that this case (and the backslash one I'm fixing) are probably
> relatively rare.  The backslash one seems a lot more likely, just
> because Windows folks may treat it like a path separator (I'm not sure
> if that even works, considering its meaning in a glob, but certainly I
> can imagine somebody doing so as an experiment and getting confused by
> the result).

I'm normally in a Unix environment but needed to address a potential
issue in Windows, which indeed
got me confused about the results.

Upon experimenting in said Unix environment with what you outlined
above on making revision and pathspec explicit,
I figured that it becomes a little odd in the case where one would use
a glob meta character in a filename (why anybody would want
that except for academic reasons is beyond me), but it could still be
a source of bugs in tooling interacting with git:

Given a repository initialized with

$ git init && echo a > a && echo '*' > '*' && git add a '*' && git
commit -m "first" && git rm a '*' && git commit -m "second"

there's a bit of a discrepancy when using git show to dump the
contents per revision. In the beginning, everything is normal for
HEAD^ but for HEAD, it's a requirement to use disambiguation to avoid
believing that '*' was an empty file. At the same time, the
disambiguation causes the error message change its nature, for obvious
reasons:

$ git show 'HEAD^:a'
a
$ git show 'HEAD^:a' --
a
$ git show 'HEAD^:*' # presumably get_oid finds the object
*
$ git show 'HEAD^:*' --
*
$ git show 'HEAD:a'
fatal: Path 'a' does not exist in 'HEAD'
$ git show 'HEAD:a' --
fatal: bad revision 'HEAD:a'
$ git show 'HEAD:*'
$ git show 'HEAD:*' --
fatal: bad revision 'HEAD:*'

Indeed, it seems to be working as designed or at least explainably.
I'll make sure to add '--' in my tool integration to deal with this
corner case.
