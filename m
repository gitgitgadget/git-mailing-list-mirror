Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872D9C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BE260F44
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbhJHWT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243539AbhJHWTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 18:19:25 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0EBC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 15:17:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i189so4584587ioa.1
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=msqJZ/s71d4Qfd5pyaVgpWS9Htha3nREJH7F3rmOX/k=;
        b=qNVXc0gqhXsRG7WJ/b+XOpyUV/v2DPsOCdP+gV/QrBmlGRTjHwpdqnIUtPcuz+YdX9
         L4NmvS80b7C0scI0juSrc/OwDvm2nj/bTiAb0xPnx8RurWCinslGMAzjeC6bIwKSaHzY
         GUiYwYS97wNWkL8ELCYZCBvuY+MRGvttz3bhQ1aigvb29TSpuS9hyu3/TXSPGIU1gpuC
         2mJiBlQ5ukvPbQwfT8O/LKzqOXkDrMb7wDouOoNbI2on2Rr/4J370sOBfKmSNeFwPyxy
         gk40pnIcEsRXQ2CeGl1QIGdPtbJ2SFlysN+Rnbb3lcpMfTX/hHClndhJCJ/6OwfRCnR4
         17XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=msqJZ/s71d4Qfd5pyaVgpWS9Htha3nREJH7F3rmOX/k=;
        b=qtxeJSJyL7fxjwyqbnwefF+6yHP2QFU5zcS2xzP6K+Lg+qsWCig575wgqJVPfjjB6x
         wv5mjJrMS7Gka/tDXkwpbrLaFCj/i1hmTXYJlP4n9yMLpR5dYhL4v4FXWGYBbu1f4W+6
         A+65M9sb7Q0CHdGBNzceZVezxuwG1Iz7k/ZiSV9IlereLCzqAwMe1V63BUqZVnmyumb3
         /nIjAN/MgSAriw0G1MLBGWjqE6Rort2PzICcugIsjaHC1IXaQ6J5eny4310ygfhkfaYV
         5itMTkvMFfCmQEFukWN56fJHiGqmoHJkHL8VKt1kVIWBcFuRCdUxxM+LNBCiCGJtC+xN
         QtMg==
X-Gm-Message-State: AOAM531Ij3g9dQGPkeaLr4YKDBRyQ9x+XFBHvvLfOx4+Gnj88rcEIZyh
        S4dVxQdldBgrR/uzetKQA+HX9sEf3fjK7OlzOTWEJQwi
X-Google-Smtp-Source: ABdhPJwW4uJ8tche8eVfg6ywJLNKATKAxZ+Nilw42lPCKrkNQ/3doBQb+/0vJsv1mZAQn2jvFrwgvGJcNxNvaX1VFVA=
X-Received: by 2002:a05:6602:2d86:: with SMTP id k6mr5548311iow.130.1633731447961;
 Fri, 08 Oct 2021 15:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
 <xmqqbl3zjl5y.fsf@gitster.g> <YWCwvOdW/L5aMpr7@camp.crustytoothpaste.net>
In-Reply-To: <YWCwvOdW/L5aMpr7@camp.crustytoothpaste.net>
From:   Robert Estelle <robertestelle@gmail.com>
Date:   Fri, 8 Oct 2021 15:17:01 -0700
Message-ID: <CAMmwyQqw3ebSxnUnYDgignpF5jyca7TgzzduCeKdbzEn97Tddg@mail.gmail.com>
Subject: Re: [PATCH] completion: fix incorrect bash/zsh string equality check
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 8, 2021 at 1:58 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> It's actually preferable in most cases to use [ and = rather than [[ and
> ==, because the former looks for strict equality and the latter looks
> for pattern matching.

Yep, I agree with these style notes, but went with the prevalent style
to avoid confusion. And note that the args here are both quoted, and
so are treated as a literal comparison rather than globbed.

That said, whoever maintains that script, since this is a one-line
change, I'm not insistent about one way of addressing this or another
:)
