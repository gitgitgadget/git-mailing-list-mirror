Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4211BC54E8A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 19:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251DC208DB
	for <git@archiver.kernel.org>; Sun, 10 May 2020 19:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igeOEqhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgEJT0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 15:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgEJT0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 15:26:12 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631FEC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 12:26:12 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r1so1491938oog.7
        for <git@vger.kernel.org>; Sun, 10 May 2020 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWZT9J/AMOgLUkalsdG2dC1M2EnulZZZTsAywblrLUQ=;
        b=igeOEqhwmcR/OyCw+x3Hbp69AxZEXCYS4yWKeUHOF9GpvlPQ6pFWxd3TUHv3E3QpBY
         NkiP+bY4TqyYYQa9Trwu6fkraT9wZPP1QOaQtP1tsRF3BWLm1nbbfuI9Th1ha7SamzPk
         Hl9A9C5yTcgIGaFbxImjmVHspwlvm/4dvKMFY8ODwsE5E95Dxi9DwUBvCe1MukEaeFoA
         ezzSJkKboZUh3gFodAXqbVvd5nTj9o+NSMalPJKX/c0TF2+xj5XbjlvtFqkuQfGs9y74
         +B6yffl6WbxukMZ0W1KamNnp2EF9KWu391SU0XC4jL7IdIhDHcWxZgvq5kFyUY7kIlX8
         bnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWZT9J/AMOgLUkalsdG2dC1M2EnulZZZTsAywblrLUQ=;
        b=Uhgw9bkQWHA/cb7GvmVnQD7IwbP0+o1NDv3QI9FS7fdEhTByU9y7HDvI5uVVACizqy
         C387xQajfyHLswtRk28Gs76ZHn9dWo3NoKRaJdKzUvgroMu5fY0fH1n2ILoQfOPAClwQ
         dEXK0uAOP4TueAdh/dMiHHRS05yOgpiiDhL9z6uyG+Udhozmg2L/QSzcCObN63Y5L5sL
         ZM3uhqBEakJPyAr9Y8eMtHXyvk7QObswYhGZw4jjBZ6ffVz0sPXzSknN+eOMHZPFrEQ/
         JpBVOt9ov0npiw1GogBBWFm2thX/WpTSWpAL2IOkLCh+xWCC3NOvnuG1hei3M8x1M9BU
         PVVA==
X-Gm-Message-State: AGi0PuYwGyWquqwig+rsYrOMlxOFemHw9RN8SUEsPe0fZXyIQFWZJ5u5
        TCFz73UKwtwK4NTOsv7rj9wuIHhrTgCr/AQuLeY=
X-Google-Smtp-Source: APiQypKmZWrPNRfC1syKxNGlpQWE5NYufcbqIUmf1vhNXjFu58YzqlNtPFgLaN/FL7JL06vEoeRcdEhe3vJgIfg4j20=
X-Received: by 2002:a4a:2fd3:: with SMTP id p202mr11022038oop.33.1589138770209;
 Sun, 10 May 2020 12:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
 <xmqqd07cvl9b.fsf@gitster.c.googlers.com> <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
 <xmqq8si0vfp3.fsf@gitster.c.googlers.com> <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
 <xmqqwo5ju47t.fsf@gitster.c.googlers.com> <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
 <xmqqo8qvu0ao.fsf@gitster.c.googlers.com> <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
 <xmqqk11jtxl3.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk11jtxl3.fsf@gitster.c.googlers.com>
From:   George Brown <321.george@gmail.com>
Date:   Sun, 10 May 2020 20:25:59 +0100
Message-ID: <CAFKec1Uya31withxzAqwFSVxqgxj_RbU1B6NrMYQ4U8WzLOs6g@mail.gmail.com>
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Imagine a user wanted to spawn a graphical editor via git-jump from within
> a GUI script (probably launched from a window manager menu and has no
> gqipterminal).  With git-jump with this patch, such a use will be broken, no?

Aha OK that's an example that I didn't grok from your earlier mails,
I had only been thinking in the context of editors. The reasoning behind
the "escape hatch" you describe makes sense.

> Unilaterally breaking, and ignoring when you are told you are
> breaking, possible existing users, without giving them any escape
> hatch, is simply irresponsible, and not something done in this
> project.  But I am sensing that you are not listening to and
> thinking about what you hear before you respond, so I will stop
> spending time on this topic for now, and wait until others chime in.

I apologise for not understanding, it was not my intention to be
willfully ignorant.
