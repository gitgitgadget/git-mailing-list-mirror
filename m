Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F705EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjF2SVz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 29 Jun 2023 14:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjF2SVp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 14:21:45 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CBD30C5
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 11:21:43 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-635e372679bso7647376d6.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 11:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688062903; x=1690654903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la5MA1rhs2Eg5n0eMFuwmJXbotfo7fU09sDjPlKOMtg=;
        b=Pm/++CwMdvR/NFWAU2oagQVBGVEAXw+wxfDvVa3zaKEwTbUq3wx83UQlLgCfvsgRRh
         S10ol028Tr2/tcfzsN3TwtEqLhhwrSnVvC/le9GBZ9rI1gDyP6IO5El75gHuXxjy5WJW
         51cHVn0wWzsAFzjWpcH2zrFeLXLtBnqDmubXXjiCpFfGI6zAFvFEvLQ85LizysZf2AJu
         Z4VbKhWYzTifnjH8dT49llyUcDYMtMGCTstqQfQtkZAAM0NV84H+bfI60cV6Fso9hmyr
         vdhyw5axZqhOib8idHGt/ykL+g+rbFAi6Gi6EItxtFVWuP6d2EPAzFB/DBjwit3Ww3Rg
         jwFw==
X-Gm-Message-State: ABy/qLYJ43ahP/4Q+Q81+g9l5XDGbxcoaaNTxrOFpwxG9YjXmOtGFT5a
        yk9UFh8qZ8/+4Yrw7PiKGNfbjQyA5imE4LkExRvQfFqmVZU=
X-Google-Smtp-Source: APBJJlGva2M21Iw5tc5NZLIaGC8zpgNuGrb2S1aevLYLZBKIXhiYzbdy/JW3/AJRCblRpLdxpjvlsyk7Un6ryJXO/9U=
X-Received: by 2002:a0c:efc8:0:b0:632:15e6:a75e with SMTP id
 a8-20020a0cefc8000000b0063215e6a75emr346327qvt.46.1688062902724; Thu, 29 Jun
 2023 11:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net> <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
 <305ccc55-25e3-6b01-cd86-9a9035839d06@sunshineco.com> <20230511161757.GA1973344@coredump.intra.peff.net>
 <CAPig+cQP736+944k40wgE8Vybk=ajD-kLTDHM6Y92dKEeWMB8g@mail.gmail.com> <20230511170133.GA1977634@coredump.intra.peff.net>
In-Reply-To: <20230511170133.GA1977634@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Jun 2023 14:21:31 -0400
Message-ID: <CAPig+cSeQKr-MNN7_44wuGBCYDMm8H+1mi+X6dd-0p2DkFY2sg@mail.gmail.com>
Subject: Re: [PATCH 3/3] fsck: mention file path for index errors
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 1:01 PM Jeff King <peff@peff.net> wrote:
> On Thu, May 11, 2023 at 12:28:45PM -0400, Eric Sunshine wrote:
> > Yes, s/main/current/ probably would be helpful for future readers of
> > the code. It's unfortunate that the term "current" can ambiguously
> > also be read as meaning "the up-to-date index" or "the present-time
> > index" as opposed to "the index in this directory/worktree", which is
> > the intention here. But "current" is consistent with the existing
> > `struct worktree.is_current`, so hopefully should not be too
> > confusing.
>
> I think in this context it should be pretty clear. Do you want to
> prepare a patch?

Done. As usual, I forgot to use --in-reply-to=<this-thread> when
sending the patch despite having gone through the effort of looking up
the relevant message-ID of this thread. Oh well. The patch is here[1].

[1]: https://lore.kernel.org/git/20230629181333.87465-1-ericsunshine@charter.net/
