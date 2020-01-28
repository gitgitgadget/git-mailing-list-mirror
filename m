Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8DFC33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 05:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24512467B
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 05:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVQhvnYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgA1FGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:06:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40577 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgA1FGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 00:06:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id a142so7550158oii.7
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 21:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6nc5K6tUEal/V7ZSlligqzNa0+OcJ64tzxpWP7rTfn0=;
        b=QVQhvnYG+zsUGfx+bQzovtFkG5zOi7NVNo/NIr+R74PkZEv0996eH254Bi7znCgoW6
         Xsxjc5C29FrndN+ASp3A/Lyl4jv/rpCw08wKuUMrGbvjcFY04fAU+lgzEdCDGPEcj4VO
         XjBxJDaL9yyYgqzlG96FpmOxAAGiD4fROdDbnJqUHhzj3za8tcgunedCSUcc+hb0c/s0
         lw326p01UGqJvA77kYnskKWBiYkdy9BZ1BrE0MgX+9yK/hMBGQ8illlYyD1hNcfwqQJb
         ygr0EgGzp/CR1ixSqUzo0baiuMhhlwqOogPob1vKg/KSa27tYL21nyXGTxYJivmFdHdN
         yd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6nc5K6tUEal/V7ZSlligqzNa0+OcJ64tzxpWP7rTfn0=;
        b=CU7hAe7nViXUUEtKjY123hXFxEXTfXC2mZFO9VW3Ypyw5Ix5IWKP+uQTlVGG9tsHDr
         xPEPAOd9I2EyyLRa8MShgN5jFLKw/3OFSPHxCjP3Dv16cvSFgpNO7WXshfZEJXew1eeI
         WHG2XEoOjsL3iiBD7n6I+k+FEUBYWb8AMfzOQ2T7zxMsnvoGf8N0wCizAzyIVhknBZ7N
         Xps3vIL51IuP0Hk1uTYkQ4HowiQ6TaVpAjQWU+QOi8SgzPOAj8UqhFd8VGBDjKopHq0t
         gmaraW/jWKBrvBOPt70/d7I+3E/vrnx5EW85cWyCgbsi5u3oJyySUyDlYdvJGWqnqE8y
         zOPw==
X-Gm-Message-State: APjAAAU3HDEzmE0L3//5fD3svDonGjaWJzia07tFuUkApcrQ7oxhFMTY
        OYZ8OPkX8/lqJbrEBpgOqatm+xD5OcOUYAD9X+I=
X-Google-Smtp-Source: APXvYqyf/ZXU1Pf6qagDuWyEwPC7w+ttnsxg/JzmOZoBiE2cIq3ObyswsDjW5m5ssnhJ0O9TWBazvCBet3dGS5o0+VY=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr1667148oib.6.1580187972848;
 Mon, 27 Jan 2020 21:06:12 -0800 (PST)
MIME-Version: 1.0
References: <CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com>
 <20200127120837.GA10482@szeder.dev>
In-Reply-To: <20200127120837.GA10482@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Jan 2020 21:06:01 -0800
Message-ID: <CABPp-BGvU_DHQu66bqPZ+WXg5mL8bCP5Uxp4g5393WnWyO1Dhg@mail.gmail.com>
Subject: Re: git status --ignored hangs when a deep directory structure
 present in working tree
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Martin Melka <martin.melka@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 4:08 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Mon, Jan 27, 2020 at 11:55:01AM +0100, Martin Melka wrote:
> > Hi all, I have ran across what might be a bug in git. When there is a
> > deep directory structure (tried on 100+ nested dirs), then git status
> > --ignored hangs indefinitely.
> > Discovered this on OSX (Mojave, git 2.20.1 (Apple Git-117)), but it
> > reproduces in Ubuntu (19.04, git 2.25.0) Docker container on OSX and
> > also on baremetal Ubuntu server (16.04, git 2.17.1).
> >
> > Steps to reproduce:
> >
> > 1. Generate the deep dir structure:
> >
> >     mkdir gittest; pushd gittest; git init; for i in $(seq 1 120); do
> > mkdir dir; cd dir; done; touch leaf; popd
> >
> > 2. Try to get git status --ignored
> >
> >     cd gittest && git status --ignored
> >
> >
> > If there is a dir depth limit, git should probably exit with an error
> > rather than getting stuck endlessly.
>
> This is interesting, thanks for the report.

Agreed.

> There is no such directory depth limit, but the runtime of 'git status
> --ignored' grows quickly with the depth of the untracked directory.
> Running this shell loop produces the numbers below:
>
> for depth in $(seq 10 30)
> do
>         dirs=3D$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
>         rm -rf dir
>         mkdir -p $dirs
>         >$dirs/untracked-file
>         /usr/bin/time --format=3D"$depth: %e" git status --ignored >/dev/=
null
> done
>
> 10: 0.01
> 11: 0.03
> 12: 0.05
> 13: 0.11
> 14: 0.23
> 15: 0.47
> 16: 0.97
> 17: 1.97
> 18: 3.88
> 19: 7.85
> 20: 16.29
> 21: 32.92
> 22: 76.24

Wow.

Really nice testcase, though, thanks.

> Beautifully quadratic, isn't it? :)

I think you mean exponential (in particular 2^n rather than n^2).

> Unless I messed up my numbers, with a depth of 120 directories it
> would take over 6*10^23 years to complete... so yeah, it does qualify
> as indefinitely.

No comment about how people today are spoiled and addicted to instant
gratification?  I mean, can't folks just be a little patient?  ;-)

> This slowdown was caused by commit df5bcdf83a (dir: recurse into
> untracked dirs for ignored files, 2017-05-18), which was part of a
> patch series to fix 'git clean -d' deleting untracked directories even
> if they contained ignored files.
>
> Cc'ing Samuel, author of that commit, and Elijah, who had quite some
> fun with 'dir.c' recently.

Heh, yes, what "fun" it was.

Anyway, after digging around for quite a bit today... that commit
added calling read_directory_recursive() directly from itself for
certain untracked paths.  This means that read_directory_recursive()
(which I'll abbreviate to r_d_r()), when we're dealing with certain
untracked paths:

  * Calls treat_path() -> treat_one_path() -> treat_directory() -> r_d_r()
  * Calls r_d_r() directly as well

So, from the toplevel directory, r_d_r() will call itself twice on the
next directory down.  For each of those, it'll call r_d_r() twice on
the second directory down.  From each of those, it'll call r_d_r()
twice on the third directory in the hierarchy and so on until we have
2^n calls to r_d_r() for the nth level deep directory.

Trying to back out the underlying problem, I _think_ the cause behind
all this is that r_d_r() and friends all use the path_treatment enum,
which says that the treatment of any path has to be one of those four
types. The dichotomy between path_untracked and path_recurse in
particular means the system has no way to mark that something should
be both marked as untracked and recursed into, yet we definitely need
to have some directories marked as untracked and we also need to
recurse into them.  This, I think led to Samuel's attempt to
workaround that dichotomy by having the code in r_d_r() check for
certain path_untracked cases which should also be recursed into.  I
think adding another type to the enum and shifting the logic elsewhere
might enable us to both simplify the logic and avoid this expensive
exponential behavior, but I haven't gotten it working yet.  We'll see
if my patch goes anywhere, or if it's just another dead-end among
many.


Elijah
