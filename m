Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29994C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF26864EA0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhBALez (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBALet (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 06:34:49 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99243C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 03:34:06 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c1so11944286qtc.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 03:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rrfHDh5w+mfFpLEL8PkB4abY9H1pWXy9da+TEL5hY20=;
        b=p+zCYkg1LJ8p866Q4BSV5fAKcwjrOq97F6Y+nCd0zqg8absvWhtq6wpU+J/EuPENXd
         BVVi0082JqbHp/FGKeXVr75AQ4JyhHfeUc8BHy5Dpkyt1AH5UouMdEsLGQemauAwKOzl
         BPPz3Y4mkzCcYoJzXY/n1EWcGuRM4gpyBROT1HgKq8jY8kuBWlZs14eFv+8YQDK6NxI3
         aFZD12unjtMpplCZba/ZhK/8R2ISvgaS51e8Hr6kM0ndKQpzTkUrDpsZR5y1m+Invbcu
         LGvJM/6mKdpO2gZ+xSuv16eo0LNnOdRY6AiEwrnr6rS7kwQpHy0jmPtIS6MYth+/XfGS
         Lg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rrfHDh5w+mfFpLEL8PkB4abY9H1pWXy9da+TEL5hY20=;
        b=DudJR2B4QL9gqsqcPr727vzfPBet83ZZZQFTxhXy+7nKBO7ZbGEj5D6wArWHyNZ9G7
         BwoF8ywFWIiULZhtXRMmmexYsHMsXCgZJY6FYqDwwpwcF7faMilj8+TgxUW+W6ldhWXD
         fSnCLu2Zmb0EjYTnuEPFh5bHAyoMEi5q/sSm0NiXHKFxeZGHfQOzwDEm5SYUC5ogTe4T
         fE5qvmkl0ez7CCodJKuCsVg4S6Sd8edWFAWBuGUcZQ8pdSRd6yHdIp1Bzp+dnJH1ZGwN
         z2Nmj5Zvy7X0q5jquf72it/SZbrRYkGTd+e+giMNyoL9qpaW48iw4zxVx6n96mwfYT+b
         YpxA==
X-Gm-Message-State: AOAM533d4TTNRItBL8sK7jMBtCS8OuoEvkqnmDRnoEzX6e6h9rXDsjOF
        /rqZYm6XadRVExbpvoWyw9CMKPvf27pCWU16UUQ=
X-Google-Smtp-Source: ABdhPJx0qYPEkrM7cA944nvlvQ2ptPKAElfWtviuUDNKv2hQfGyCjq0g8Kh9r+lXZr/pBtY30N2aQxJSvUouscRQKBk=
X-Received: by 2002:ac8:6a01:: with SMTP id t1mr15140554qtr.105.1612179245719;
 Mon, 01 Feb 2021 03:34:05 -0800 (PST)
MIME-Version: 1.0
References: <YAG/vzctP4JwSp5x@zira.vinc17.org> <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org> <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
In-Reply-To: <20210201103429.GT623063@zira.vinc17.org>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 1 Feb 2021 03:33:54 -0800
Message-ID: <CAPx1Gvf92eCnSCZJLeqwyL-SprCxmnfi4w=d0-MHddY38DzADg@mail.gmail.com>
Subject: Re: git fails with a broken pipe when one quits the pager
To:     Vincent Lefevre <vincent@vinc17.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 2021-01-31 21:49:49 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrot=
e:
> > ... That we're returning an exit code per getting a SIGHUP here
> > is a feature. Consider:
> >
> >     git -c core.pager=3D/bin/false log && echo showed you the output

This example has a minor flaw: it should use `git -c core.pager=3D/bin/true=
`,
probably.

On Mon, Feb 1, 2021 at 2:36 AM Vincent Lefevre <vincent@vinc17.net> wrote:
> If the pager exists with a non-zero exit status, it is normal to
> return a non-zero exit status. This was not the bug I reported.

That's the flaw in the example.  The key though is that the program
we ran as the pager=E2=80=94false, true, whatever=E2=80=94*did not read any=
 of its input*.

> > Not being able to write "git log" output is a real SIGPIPE.

Worth noting: Linux has a pretty large pipe buffer.  POSIX requires
at least 4k here, as I recall, but Linux will buffer 64k or more, so that
if `git log` is able to write the entire log text (will be the case for sma=
ll
repositories) *before* the program on the right side of the pager pipe
exits (this depends on many things), the pager's exit *won't* cause
a SIGPIPE.  You'll get the SIGPIPE if either the pager exits very
quickly, so that `git log` is unable to write much before the exit, or
if the repository is sufficiently large so that the pipe blocks first.

> Which is not the case here, because the full output has never been
> requested by the user.

The `git log` command *did* request the full output.

The problem that has come up is, if I understand correctly, that
some Linux distributions have come with misconfigured pagers
that don't bother reading their input, and silently exit zero.  This
causes all kinds of Git commands to *seem* to fail.  The Git commands
are just fine; the bug is that the pager doesn't read or write anything.

Unfortunately, the way that pipes work -- asynchronously -- means
that Git really *can't* catch all problems here.  But catching a SIGPIPE,
whether Git itself spawned the pager or not, does indicate that
something has gone wrong ... *unless* Git was piping to, e.g., less,
and the user read enough, and the user typed `q` at less, and less
exited without bothering to read the rest of the input.

There's no good way for Git to be able to tell which of these was
the case.

I'm not sure what this actually argues for. ;-)

Chris
