Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A32C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 23:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0173206DC
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 23:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWQHnbEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgKCXqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 18:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgKCXqS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 18:46:18 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F983C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 15:46:18 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so20245529wrm.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 15:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtsKC7qbE4uoIW3GsnsVkNvQB8M7SHY2OvoscRVgc4M=;
        b=kWQHnbELJ9KrvuLF8zfSO6JdgFAWxc93E3/CzmrVvTgI4SqJvAxu7mAsL13t2zuhG2
         qLU9CJTBgErs6qkPGdsu/2Ay8v0ZCqDMlwmDs99DUg3yrg9VUNXiyx+9PbdjrWBLuNmg
         1aFSdcUAIAGLNQgUv8nwq671PCIS9+HDwtqMgquYu0FwmIVrwariLwgeG6N0jX3WKnmp
         QbcmT0WaMaM1RglDQH4Jfme8hq/DOFd0J1iGgJD7qX3H8iK8oDOEAyRhlAVohltC4o/a
         29W5xjgozQRzuU1JbMA/p8/kSs8pfGebWZN4OVBzkZ7w+q59Pchrwzmohb43We6xRIBM
         Y6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtsKC7qbE4uoIW3GsnsVkNvQB8M7SHY2OvoscRVgc4M=;
        b=Q/oBELlr5TSypUfW9BWBNUejC9utnv+r/PNTBXomPfCSNomO8hZGbAYJGn4czFrQA/
         0TaRBtCbC5bBd3/5ZbyL4fRM7cNvazc8CYLaVXONxVQ2fZqRC3rIkDmBk/j/JUXqi8Ud
         zhnQmXR0w8pYe3XVMdONgl0mXpTOdiAsh6VJSo4DO/YBNWRLNq9W4TgvHQOs6n55Q9/s
         Gttsxej95V1PYALHKsD4/4mTRCWBU9IChA1tVLTRuslXdcj/m9MIDPHq83PjkT6Tp/1Q
         4/fzvh8PnmBZ20cNLpvZDrltWIW5xf+/dKGtyyWPtZyV/w0yOTDwjvLKrcmKYfKl/cHS
         gvTw==
X-Gm-Message-State: AOAM5313qES/IwnDQ0iEZlbljt23EBezu5M2eXG0z1DA1UWF/1QHCwK7
        U0Quvu6n/cACjPnbJEBQVpX905s4LkxREptlz18=
X-Google-Smtp-Source: ABdhPJwbu/hEmPE3hT62K6wx/NU4uDBhwev8t4Ap9Ntp7/AB8FkwTp5tOf+27+9vHzAhmlLmaUMxFR0VLQer/vZ87dA=
X-Received: by 2002:adf:84a3:: with SMTP id 32mr28529661wrg.255.1604447176686;
 Tue, 03 Nov 2020 15:46:16 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0vbbep5.fsf@gitster.c.googlers.com> <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com> <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de> <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com> <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de>
 <xmqqh7qb3a3r.fsf@gitster.c.googlers.com> <CAMP44s3Tx1DdzD3fAOA+_3fLMK6Ew9GQAJWiRoA2KR156jiZBg@mail.gmail.com>
 <X6CQpfuhRkAwmMou@pug.qqx.org> <xmqqwnz3nrwx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnz3nrwx.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 3 Nov 2020 17:46:05 -0600
Message-ID: <CAMP44s3yfdKA3y8NihDwRGh-RzAohWncnztJo9aU-F-GO=UY8g@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Aaron Schrab <aaron@schrab.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 2, 2020 at 7:35 PM Junio C Hamano <gitster@pobox.com> wrote:

> My understanding is that Felipe's 1 & 2 are essentially the same
> thing in the larger picture but they come in different packaging.

Yes, and no. That's like saying you get the same thing with Gentoo
than with Ubuntu.

Yes; you get the same thing, but no; Oh-My-Zsh comes with a lot more
you might not necessarily want.

> And your preference is the former.  It is not like I picked a wrong
> SO thread and was swayed by an oddball opinion of somebody who
> prefers the Zsh default.  Even though the preference is up to
> individual users, the important point here is that Zsh default is
> not universally unusable for everybody and it is one of the valid
> choices.

I think that's debatable. If I had to be it would be on a 50/50 split.
But that's considering that most people never change their default.

If my script were the default, my bet would be on a 90/10 split (at
least). Yes, there are some people who do prefer the Zsh default but
not many.

Seriously, submit yourself to one hour of the default Zsh completion,
I bet you will consider it torture.

-- 
Felipe Contreras
