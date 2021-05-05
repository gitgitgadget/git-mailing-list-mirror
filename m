Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCAFC433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF03A613C4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhEESbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhEESbe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:31:34 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372DEC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 11:30:37 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id u48-20020a4a97330000b02901fa060b8066so690172ooi.8
        for <git@vger.kernel.org>; Wed, 05 May 2021 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmgGJRklsv8+PDqIQKswSeVwdiIotp2Tz2u0ay+seMQ=;
        b=QvwLsAPtCuxn9vQ+w+ba7Jm4Ma6aGQ3ZBNamo0Cxef+zoLoKZ3RYn1gr4+HPmZu0nE
         j+PwfGfNhFO4ndzs5E4Z5B1LTw1tbVxkxaAzojV+yfFPvl7kaGaVYjaPL80KZtGijQaJ
         KeBwbGPQ+BLOejzFS3TOA7Hq0DIK2Dw0mfB/0Qgh2F4RtgzlYFUI7bD2ZmBTGAQzQgDo
         RpyeO0+8Liz+l5p511ZNkGg9SC+aWBNsxdbFHaCzG31kvYBJkHu03ZC5iA1Q1EZuNxxT
         4D/hnyZH5BFP7tmfEqt//uoO7rq4SF6XxdywFzy3Z6Hc2/3BsqvNaoj++Dv3npmWsFGn
         EFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmgGJRklsv8+PDqIQKswSeVwdiIotp2Tz2u0ay+seMQ=;
        b=YoDMG0BEvS/xbRWkXwU2QFoXAfBa7i9+Ir7pO8AnJfEBiHgQaZhOyY10rSWIBVkF7R
         YonE7hBfeiFJTyFiCoSa8a+KsZS1cMLpDNYLPDQpVCHmR18ss4dad/vorjbIPvTAHa39
         DkcNFPxXzzuJ7ABDu/k/z5HEkdzYnnFcJEiwpK4gBGLrm9hk9BgHbxaIKcglf2mJUCHZ
         2+FOea0sl/jzbtg5m9fKg+wU+3RO4kNJ4XnIdQY0zgOiIgdk4WUbfy4Z75uU6xoAHRij
         lsKXA25m9w3syc3yqsxbesC7k12ZjQLCBpmx7o2z/4XJ+mNDjwkMlwy6NUVCJIc6EcEr
         qhpQ==
X-Gm-Message-State: AOAM533Ma2oR2CWu0hQHEgri3XBsJ0zxfspobR8Op+4AE26VJbw1O4eQ
        CctKQRIZOY9EW1Q2x9h6GLgSzSSjEyAOGnKmiTSZEV/0OaVB3VvW
X-Google-Smtp-Source: ABdhPJxQlFM7CM4ts0JbQOXCwHMjzCooA0+dYsHVvoauGDC3t8S6y7wpgpciSQLCRQbFWDPfONNOegaY6QWFIYOIuj4=
X-Received: by 2002:a4a:dc5:: with SMTP id 188mr5738oob.80.1620239436702; Wed,
 05 May 2021 11:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
 <YJLgmXS/fJm1BQb4@coredump.intra.peff.net> <CAPig+cTX179z5MrTvSmgYGzZdc4xz=2G_ffHsyVOXsKVHrL93w@mail.gmail.com>
In-Reply-To: <CAPig+cTX179z5MrTvSmgYGzZdc4xz=2G_ffHsyVOXsKVHrL93w@mail.gmail.com>
From:   Theodor Negrescu <theodor.negrescu@gmail.com>
Date:   Wed, 5 May 2021 21:30:21 +0300
Message-ID: <CAEumJaCmcReO4ry7DP14zDg0R5L5QgULZpZmaqBY5g=EQD4U+Q@mail.gmail.com>
Subject: Re: BUG: Git path --config doesn't work with ~ symbol
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using powershell, but usually ~ works there. Typing "cd ~" would
work for example.
Also I tried using the command as an alias and it still didn't work.

On Wed, May 5, 2021 at 9:21 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, May 5, 2021 at 2:14 PM Jeff King <peff@peff.net> wrote:
> > On Wed, May 05, 2021 at 09:06:12PM +0300, Theodor Negrescu wrote:
> > > I ran the command "git config --file ~/git-settings/.gitconfig -l"
> > > (git-settings is a repo where I keep my config, the global one is just
> > > an include)
> >
> > I don't think this is a bug in git-config. It is generally the shell
> > that is responsible for expanding "~" and passing along the result to
> > commands. E.g.:
> >
> >   $ strace -e execve git config --file ~/foo --list
> >   execve("/home/peff/local/git/current/bin/git", ["git", "config", "--file", "/home/peff/foo", "--list"], 0x7ffc10a88130 /* 55 vars */) = 0
> >
> > I'd guess this might be related to Windows somehow. Are you entering the
> > command in a bash shell, or via some other mechanism?
>
> Is OPT_FILENAME supposed to handle tilde-expansion? I ask because
> git-config is using OPT_STRING for this option, whereas other commands
> use OPT_FILENAME for their `--file` options.
