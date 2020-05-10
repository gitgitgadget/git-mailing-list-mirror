Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B22C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 17:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D283620731
	for <git@archiver.kernel.org>; Sun, 10 May 2020 17:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVtFpd40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgEJRdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 13:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729113AbgEJRdY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 13:33:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69FC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 10:33:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k110so5708733otc.2
        for <git@vger.kernel.org>; Sun, 10 May 2020 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4DxOKrJ6b53b9K0VvxlBHsoJZnkp7tUh0fjZYo4zHn8=;
        b=oVtFpd40s07MF2ikAPGLiC7ThkwiTmD76emeo9hiS+TGwbpoN1fBwjvj2XGLD6PVFI
         nX/lrS2jgeClOQmsgK6g7IB7yPSW/FhkDhzWakXfaOHju9obQDTp4XfPY9BrImB/XX+q
         DyjieUnzQsMAZt3I9RpldKRkiewJDGLQENif9Qd3zWl5cKoi2HKUqwoOzcR6bEFrlP4B
         z27hAu0A8ehLKD5hQ5P8YQc3Zwj0L9HEX5P353vxkio0A6T/b7XFdQShX1Ji4jKcSdCr
         GkuGTTErh2tyVqSe3sQR0VxQThlREgqjLz/xQFM5bzrGAiyio4QoCJgOSzb7CDVbyoUx
         EMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DxOKrJ6b53b9K0VvxlBHsoJZnkp7tUh0fjZYo4zHn8=;
        b=S0DJig1Bsfj02m1alQAdYFl3JKZzQGYvvulpVCMhjvLIEnnBh5bbKavw8mdgeUzF0s
         7jzuwOprBD3zIsFUPjP5IvNpTkTc6H9XZcNuy8qAB9Z4flKFNbP67pcVhnQag622hjMq
         abquxgHAyhrIF3pUGtDDENSCA/RJ5VvsPOz2yZb4iEoToLfj7wo6c56hN5d1C6B174WI
         E3fx3+NNoykztRT6s9Si+Xl3a37VX0gIEcBGeJ0tT8j+8/xpvXZRLtFv6p5+b9+PFVKh
         TIUlZ26V/Sp0BoAiUCpy/Q91Sb0eEXUEjfIxOYtlMCwigMVBISxf0ttqvgv6fQrPqIXm
         jVfQ==
X-Gm-Message-State: AGi0PuZHkEj20EFb94ycYr3htYMgUGemV9ucv3mdFGIfQRaGXibxGP5P
        yvYOQUV7kXQ1bMYET/qg1NC6ea2mpldq1B8M2thZR0/c
X-Google-Smtp-Source: APiQypI75ScGGtBrEvJPFbnEPe6mp4xr0TdFKB8QMSS6defVDJ48GlfbJBJSgvE7J0Z+YMF6wRYtAVGZAL4CDMc63Hs=
X-Received: by 2002:a9d:1eaa:: with SMTP id n39mr10249536otn.238.1589132003493;
 Sun, 10 May 2020 10:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
 <xmqqd07cvl9b.fsf@gitster.c.googlers.com> <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
 <xmqq8si0vfp3.fsf@gitster.c.googlers.com> <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
 <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
From:   George Brown <321.george@gmail.com>
Date:   Sun, 10 May 2020 18:33:12 +0100
Message-ID: <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As long as such a regression for existing users use is impossible, I
> think the patch is probably OK, but doing a hardcoded "cat" smells
> like a very bad hack, compared to a solution on the program's side
> that *wants* to read the prepared file to arrange that to happen
> (e.g. via setting the GIT_EDITOR environment to "cat" within that
> program).

I think this change only enhances "git jump".

> In any case, I am not a "git jump" user, so...

I looked into this as other Vim users were talking about it and wanted
this behavior.

https://www.reddit.com/r/vim/comments/gf2he2/what_is_the_simplest_way_to_get_all_git_changes/fprlxtk/?context=3
