Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A35C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 07:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB35B23D37
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 07:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgLJH1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 02:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgLJH1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 02:27:36 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3EC061794
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 23:26:55 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id h10so1053246ooi.10
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 23:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rBssI+FxCJxJx5ol5PSRDY2H1Vb3IkZc9OPe8AexzU=;
        b=dAjbfbtHx8Dj/pyck5lFhEONPVKY0ScyhzPGYrFZvVgYp46EIpmfoo6kPtrwnCLrqU
         4ZZqM70KJHYXsPLLBZC3xkFOMvL+zu/Vhn1d19dr9uskvAlzcHA2P1B8v9m/5G30TKsg
         FBGDeCmmIFeCfML6R7C38PGCaQwb3aY2VHWpzxNIK6lVch2jzwcwYqeYQoYMo/aAJkku
         K6dnOJSRM42KLDsgRX8GsYlQeNUghGLRs7L5SRLsvHTToejDTjM2sGMPCKuJ95fPdekq
         4VbgQMhVMWrHcFWAKp0ihGC+Wxc6AjMKNd2kwDnRQ8IIwYkBRsvIpNZVx0ecTabCr0GX
         YkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rBssI+FxCJxJx5ol5PSRDY2H1Vb3IkZc9OPe8AexzU=;
        b=gDrC2GzjmEDHo9kjlUkTta/uIzJA+KGaW4yYSi0OexCGVt8stXg0y7io1NRBFBtWjN
         3Xm+4O98ZEhFU5aJRLBm8dUQcYgb7RTCaL7scG4bEhru3a2kFKoe0l+P1KVfjE7VDty8
         aio7NTtbouHh1rWZWmSr/kjvWD1vsiZ1zllrSpznkOANZ2ZvRR23E9TFpnKHAnkFTARq
         Jetti9StZkm64ZcYYDMFKSSg5myThFyWvg+V5yVXLZQ/C2o/yVJP7Ia/950ktAWckecR
         EQKKpEfpTAxNqmyAhwgvyJ+vI8XkGepVhzQTmUWb524JyoUM4utZl2168fZ4djF82heV
         x4Yw==
X-Gm-Message-State: AOAM530awWafMusYJe++mX9UdDwcFikvS9+bozDg7Keg6Bv6twodilI3
        7bpkuXKNSpz10sQueYvPstuCPwygFuy5jX3tME0=
X-Google-Smtp-Source: ABdhPJx4Jea5R8GACAJPyG2vrUkg3TJjaD1JVctKEmk+pGJe6KVIK0AVJ1SNb/Qqkb0dGetv3+E9Dpzj0nspGIL/Mpw=
X-Received: by 2002:a4a:b4c4:: with SMTP id g4mr4935823ooo.7.1607585215293;
 Wed, 09 Dec 2020 23:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <87y2i8dptj.fsf@osv.gnss.ru>
 <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
 <87y2i8c4mr.fsf@osv.gnss.ru> <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
 <xmqqtusv4w2g.fsf@gitster.c.googlers.com> <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
 <xmqq7dpr4qa0.fsf@gitster.c.googlers.com> <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
 <xmqq360f4npg.fsf@gitster.c.googlers.com> <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
 <xmqqtusv362t.fsf@gitster.c.googlers.com> <xmqqpn3j32ka.fsf@gitster.c.googlers.com>
 <87k0tqdasa.fsf@osv.gnss.ru>
In-Reply-To: <87k0tqdasa.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Dec 2020 23:26:44 -0800
Message-ID: <CABPp-BE7r4iUc6VD60Bdi+fF2bBn6_ZwVPrz_niFpY=LTZMXzw@mail.gmail.com>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 11:44 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> [...]
>
> > By the time the change to make "--cc" imply "-p" was introduced, it
> > was pretty much given that "-m -p" was useful to anybody, unless you
> > are consuming these individual patches in a script or something like
> > that.  So simply I didn't even think of making "-m" imply "-p".  It
> > would be logical to make it so, but it would not add much practical
> > value, I would have to say.
>
> I need some help here.
>
> Looking at the code and trying to follow the flow, I can't figure what
> rev->diff flag is for? Why rev->diffopt.output_format, that actually
> affects the output, is not enough?

I'm not a revision walking expert, but to the best of my understanding...

Showing a diff is not the only reason you might need to compute one.
You may also need to compute them if you are filtering commits by
pathspec (-- $filename), using the pickaxe (-S foo), checking if
commits are cherry-picks (--cherry-mark), checking for commits with
certain type of file changes (--diff-filter=A), selecting commits that
modified a certain function (-L :funcname:filename --no-patch), or
others I've overlooked.  None of these cause a diff to be shown.  I
don't know if all these set rev->diff to 1 or if they special case
some other way, but I suspect that rev->diff exists as a shorthand for
"need a diff", so that the code can check for it without having to
check a half dozen special conditions.

>> My confusion originates from the fact that the code in revision.c sets
> rev->diff to 1 for -c/--cc , while it doesn't set it for -m, and this
> was the case *before* -c/--cc started to imply -p and -m.
>
> It seems that the only place where rev->diff is tested is at the start
> of log_tree_diff(), and even there its absence could be ignored when
> rev->diffopt.flags.exit_with_status is set.

rev->diffopt.flags.exit_with_status seems quite unlikely to be set,
though.  That setting was added with the --exit-code flag to git log
in 2008 (in the pm/log-exit-code topic), but was never documented
(other than to say it's incompatible with --check), the commit message
adding it doesn't say what behavior was intended, and the commit
message which added it added no regression tests either.  I know what
diff --exit-code does, but I'm really not sure what git-log's
--exit-code does (random guess: sets the exit code to an OR of what
git diff would have shown for any one of the commits shown?).  Since I
don't know and can't even figure it out looking at the commits in
question, I suspect there aren't too many users out there using it.
As such, I suspect rev->diffopt.flags.exit_with_status will be 0 most
of the time and that the relevant check at the top of log_tree_diff()
really is the "if (!opt->diff)" part of it.

> Is rev->diff an optimization, does it play another significant role, or
> is it a remnant?
