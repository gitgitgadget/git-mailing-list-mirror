Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5BEC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 01:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0168E2073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 01:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="C1ubck2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbgEYByI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 21:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbgEYByH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 21:54:07 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C603C061A0E
        for <git@vger.kernel.org>; Sun, 24 May 2020 18:54:06 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o14so19116002ljp.4
        for <git@vger.kernel.org>; Sun, 24 May 2020 18:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ms7w2ztNfyAOk3EAaZMOjtBzuQT7UxbtfQcj2bvB3w8=;
        b=C1ubck2FolG+EhBex6RIJ3Vv2BulAvDyKO66aAnMHRfLG3Yj9Ke4fs9dZ7sBgsA8av
         lUC4EX2q592wbjKqyZujT4juTkgq6vpWN5KBMPCTvpWDGf3YNjp7jQhk/FwtEo1vi0/6
         pluFJ0m0DGMR23CkgsFKM34ZGKzXwz+ZTZCeLbc9nzAjLsgmIsySq5M7dIgnhm5DE+WU
         mp44wtBnGrwJc/rkwxNqpZX9dzyYwwoEchN9y+GInpnAabtPINnrwUEdt0b4/925qRI2
         3gXLfoeZxLyyDay5Z+viMWBoKe1XHXPw+dcT/JvhJCbLZppmsB3DYAhNsK/zTf/8yU36
         HACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms7w2ztNfyAOk3EAaZMOjtBzuQT7UxbtfQcj2bvB3w8=;
        b=GmkLe9x6Vbdtc4ts62WJCwn63/wvs9M4SinPpyir4fNZ6atWcm5Vt2GNYYVKlT2ZrK
         xHvcnlt1gM1YpYBwLWrIkLCm0btEaqcb4vsEpfYDE/LHa+ExNfwwTRwJ2cgxOLvSSWdV
         fLTuaKn3xOwumeQLXW+DifVK9Ku/3xIxZxWkadeoC/a6LOsaeVg+oNEN3aC0G5DgAAih
         O+6CAovYtVWKaBOYz7cp/Yc8UcagdGEGYs3WUwnGLpjPBFIll7R+0zAy9yLdOy4y0FEj
         K4fOf8ntAoLstxzbjQj5Z9jivEUUetAfKP8scVJTCexBgH+5CEdxYxkpu10oLwyWPRtD
         cbrA==
X-Gm-Message-State: AOAM5328ISipXW5LgeT1ZDlVqJIluBeDBBtcxXCtdv7s6N8Kt/H6v4rE
        ysf8to9abvhO5B4rbeSa/OeVZzUrSKcw1BJr5gOUlg==
X-Google-Smtp-Source: ABdhPJx1dUY9rbXi/yhrXYuEokpgeCCXgmgH2oz/a89TfKEIRGKQavk8rWewGo3yypgwX/DndnY18AN4X3Ah4YIRgEU=
X-Received: by 2002:a2e:7007:: with SMTP id l7mr6192151ljc.74.1590371644635;
 Sun, 24 May 2020 18:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEBnpheB-ZT5+bajKphux-+7gYFx1Msws7mXM=LOJO7pukw@mail.gmail.com>
 <20200524213808.24849-1-matheus.bernardino@usp.br> <xmqqlflgq2nr.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlflgq2nr.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 24 May 2020 22:53:53 -0300
Message-ID: <CAHd-oW7b2191haSeoaBu4jvS+PBG04RKGxOhp7+rRQF+b9eErg@mail.gmail.com>
Subject: Re: git git<tab> completes non-existent command `git gitk`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anthony Sottile <asottile@umich.edu>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 24, 2020 at 9:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > In the meantime, you could use:
> >
> >       git config completion.commands -gitk
> >
> > To locally remove the completion for "gitk".
>
> I think an equivalent of this in-core would be the way to go.

I'm not sure I understand the idea, but would that be something along
these lines? Adding a "nocomplete" category in commands-list.txt, to
do the opposite of the "complete" we already have[1]. Then adding a
new group name to "--list-cmds" (such as "--list-cmds=completeonly"),
which would include the commands that are in "complete" and exclude
those in "nocomplete"? We then might be able to complete subcommands
with the output of:

git --list-cmds=list-mainporcelain,others,nohelpers,alias,completeonly,config

[1]: "nocomplete" would only be relevant in conjunction with
"list-mainporcelain", as the commands in the latter (as gitk) are
currently completed by default (even without "complete").

> I wonder if there are any commands other than gitk that cannot be
> invoked as a subcommand of "git" potty.

In the list suggested by git-completion, I think gitk is the only one
(if I haven't missed any).
