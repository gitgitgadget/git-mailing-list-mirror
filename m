Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FBC64E75
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA10720720
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="NqX2e6nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKXCs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgKXCs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 21:48:56 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9263CC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 18:48:56 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v14so4580044lfo.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31tx5xsu5bLaq36Qcpc3Rl6xU6q0yiHG208triEaseQ=;
        b=NqX2e6nb+DHBAIIdlAVdIUFfm/aBlMNhU8lFDiJNQOxuFCI2hOOhPYVch6XBG9+A1N
         y9lcVG56mIxqF2rfxUPn1iwnlJnK79q5jKXRYtjC5kyy4gnGuWlV8Lh01C88ZBg1wzzz
         ykzqBkRxs1VpPaNHcNH/4+c86Y709NKsoQmIz/CE/ngqCyTL7wlcn2bEfwzZtluX3xrp
         T3QvaW94yykwbH8pmD5fvb5IjmMpVBv37RGcd+npunoxw1L1Ihlz41hv7U4DzOGTS184
         eCcJaraN9Bo07sBMBy2/HZT+5ixqeoYqwwblntvW23Dum6ZTw3lTQe1skgwlAAJ9mH+5
         uplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31tx5xsu5bLaq36Qcpc3Rl6xU6q0yiHG208triEaseQ=;
        b=lNqD2EZGI0dz5aOZA8zG1DcbJwYh7nlFWNx+sNHt3PJ0CmSbEuk5hWTH5bIJ6Z54iD
         tjP1GbiOmYoiTgXbDmIeAq3rM8vcgSRl+ScdvGYg3I6xXgCuMIyWVOSGN4Bhy210h0tC
         w1SLDbjUvc5Ey9WGTKupQqJ9cGZGre9KIs6ElYx1YZheIR4EodfomNgchb/EJxpQTW9e
         QgFpI3+ro1DPWmidiYh81L5VcgqmJe7HK42galscbYXFDt+XtBlP1hIiObMLNpKgpncR
         qZp25BACAecBlGpJxwBR8YX+TEm1/s8jGop/dC2tz7VVpoiLpfiRy4Y1fT2XjD7GCrst
         hViQ==
X-Gm-Message-State: AOAM531KQU+vSxX6g5fmfRc745a8D6Cyzs+5gotSe6fCtT+Gw4Inca0a
        3N+xODEXIyYjZ+WMLyTfqTggX0NX3C9vLsYJDk0f3g==
X-Google-Smtp-Source: ABdhPJyoQEaCfl1n31sZAF4gniO7b8NOMJP8f5BRCQCUxEIKmcYy/yDnKCNpM2gwLjMBSxS9G3tXLUYL7JH6O3QLRSY=
X-Received: by 2002:ac2:53bc:: with SMTP id j28mr832254lfh.39.1606186134984;
 Mon, 23 Nov 2020 18:48:54 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com>
 <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com> <CAHd-oW7X3fEM8PDFWQVc4kG_vfkY4LbvADzJfQrocjyaAr28TQ@mail.gmail.com>
 <79313c8c-c927-78d4-bb1d-024f9feb553c@kdbg.org> <CAHd-oW4OVDvfkaMjsO4vLvwrnHbyhngwW2y6AkoScJmS6XGVeQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2011231421520.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2011231421520.56@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 23 Nov 2020 23:48:43 -0300
Message-ID: <CAHd-oW5Pi=kTBhO-d=DEOqPCKfKhbA51KazoTw+6YhSM2woHPg@mail.gmail.com>
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 10:23 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Matheus,
>
> On Mon, 16 Nov 2020, Matheus Tavares Bernardino wrote:
>
> > On Sun, Nov 15, 2020 at 6:42 PM Johannes Sixt <j6t@kdbg.org> wrote:
> > >
> > > Am 15.11.20 um 21:12 schrieb Matheus Tavares Bernardino:
> > > > Thank you both for the comments. I'll try to send v2 soon.
> > > >
> > > > On Fri, Nov 13, 2020 at 10:47 AM Derrick Stolee <stolee@gmail.com> wrote:
> > > >>
> > > >> On 11/12/2020 6:54 PM, Elijah Newren wrote:
> > > >>>
> > > >>> Do we also want to include a testcase where the user specifies a
> > > >>> directory and part of that directory is within the sparsity paths and
> > > >>> part is out?  E.g.  'git sparse-checkout set /sub/dir && git rm -r
> > > >>> sub' ?
> > > >>
> > > >> That is definitely an interesting case.
> > > >
> > > > I've added the test [1], but it's failing on Windows and I'm not quite
> > > > sure why. The trash dir artifact shows that `git sparse-checkout set
> > > > /sub/dir` produced the following path on the sparse-checkout file:
> > > > "D:/a/git/git/git-sdk-64-minimal/sub/dir".
> > >
> > > If 'git sparse-checkout' is run from a bash command line, I would not be
> > > surprised if the absolute path is munched in the way that you observe,
> > > provided that D:/a/git/git/git-sdk-64-minimal is where your MinGW
> > > subsystem is located. I that the case?
> >
> > Yeah, that must be it, thanks. I didn't run the command myself as I'm
> > not on Windows, but D:/a/git/git/git-sdk-64-minimal must be the path
> > where MinGW was installed by our GitHub Actions script, then. I'll use
> > "sub/dir" without the root slash in t3600 to avoid the conversion.
> > Thanks again!
>
> In the `windows-test` job, the construct `$(pwd)` will give you the
> Windows form (`D:/a/git/git/git-sdk-64-minimal`) whereas the `$PWD` form
> will give you the Unix-y form (`/`). What form to use depends on the
> context (if the absolute path comes from a shell script, the Unix-y form,
> if the absolute path comes from `git.exe` itself, the Windows form).

Got it, thanks for the explanation!
