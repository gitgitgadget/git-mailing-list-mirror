Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BB7C77B7C
	for <git@archiver.kernel.org>; Sun, 28 May 2023 19:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjE1TeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjE1TeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 15:34:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C991FA8
        for <git@vger.kernel.org>; Sun, 28 May 2023 12:34:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-514924b4f8cso2193591a12.3
        for <git@vger.kernel.org>; Sun, 28 May 2023 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685302446; x=1687894446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aIY+yS3DYIN8cL7VIRe9ONhtxLeSpN6CcatvVwGGXXg=;
        b=bwIpSwHv45D6A2L/Uxboe+cZN9vLy5BJg233+W3brSQr5TfGgyIofqBXDEhWnLzox+
         nu1Hyo7C1FxUm2xXWWTqTizhAzaXM73SJ2QYuhSJqqM8Vv+keXhsZYNrlT45REpMBF4B
         xI2O/5g5tiwYpgj+6MrKqm4tvur5hotK1+UYOjqjajVd9O0aH+oNIKm0EIuU29fcEACv
         7vgtBEm2zJyBjsvTwz8Ix0a/635lpAVT6Wv+Mec0sKqgyuV/alI9y2QUSLy/aE0mI3RW
         QMhFcysvOCJujJws5h7WtcVC+e9+u0y/p0u6jp4fBAdrKZsdi5B5EEl47YsB1sNZ31TZ
         emfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685302446; x=1687894446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIY+yS3DYIN8cL7VIRe9ONhtxLeSpN6CcatvVwGGXXg=;
        b=DGV6Fjhf6l2C9GvsvOBqYhVoxBEmHL2f6wFw6N2kkPJCyN51S2OF9RvNTDWYuCuQ9C
         XpsTsEsSqAZecUthe++lbnvSYInDa6/tXwvSjisPKD5/Td5JljTaH5+CCGcj4CJtFQ6W
         B4C1boCawC+N8dHf0GlClItPThcPEYl1AqMSpOlRvH52n/KlQIUfuTrAo5ezmROek9sb
         5e6hSCcpcrT7RgX+3FQQ74VT5ONhXiFkVgIk8gtHXHwi97PN8k89QCRnj3p0ML/yYvPI
         f4HuXMETJLt1Zq9x8wN62B3fFhXU/6zBikxOGWK6c92zzR2OOpbZ6gtzCcfbLpvukc2m
         lIAg==
X-Gm-Message-State: AC+VfDzkXnC8fAVrH4N4LG6/5pepke+CRjn1XEl/OF9g6A9+NnxEOEYB
        4cSNSKfYcKocMFSZXdg0qyhe/GHF3zymI6bpW+F4piUgaEBS8A==
X-Google-Smtp-Source: ACHHUZ6HXUGdA7Nw6BkFlEEaSVPyeKYO7ZTDUGL8KPCC9C+35WdL/JXxXNNf713c8Y7flHLL3LnaFd18WYgvIrUCgDY=
X-Received: by 2002:a17:907:6090:b0:96a:58a:6cd8 with SMTP id
 ht16-20020a170907609000b0096a058a6cd8mr9829664ejc.9.1685302445932; Sun, 28
 May 2023 12:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
 <Y2rdw7RD8mGTF40w@tapette.crustytoothpaste.net> <AS2PR03MB98158D49DC655F6DC6D10ECDC0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
 <Y3aCx1SYq6jrYfuO@coredump.intra.peff.net>
In-Reply-To: <Y3aCx1SYq6jrYfuO@coredump.intra.peff.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sun, 28 May 2023 20:33:29 +0100
Message-ID: <CAGJzqskaM80+8+79yUf435tP93Sk8sFu7marCvyimE=2gOKnog@mail.gmail.com>
Subject: Re: The enduring popularity of git-credential-store
To:     Jeff King <peff@peff.net>
Cc:     Matthew John Cheetham <mjcheetham@outlook.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 17 Nov 2022 at 18:51, Jeff King <peff@peff.net> wrote:
>
> On Thu, Nov 17, 2022 at 09:17:53AM -0800, Matthew John Cheetham wrote:
>
> > > In the ideal world, we'd ship an encrypted store that people could use,
> > > but then we have to deal with export regulations and sanctions and
> > > nobody wants to do that.  We'd also have to deal with multiple
> > > cryptographic libraries for portability and license reasons and nobody
> > > wants to do that, either.
> >
> > One option rather than shipping (or including in contrib/) any of these
> > credential helpers, could we not reference several other popular helpers
> > in the docs, and let users make their own choice (but at least some are
> > then possibly more discoverable)?
>
> I don't have any problem with documenting the options better. The main
> reason we have store/cache at all, even though they kind of suck, was to
> act as least-common-denominators and pave the way for people making
> better helpers. That happened, but nobody ever went back to adjust the
> docs.
>
> I do think having the docs say "you should go use X" means that X will
> have an advantage over other projects which may compete with it. So I
> think we need to be careful to be inclusive of what we'll mention, and
> to word it so that we're not endorsing any one project.

I agree, although Git for Windows installs Git Credential Manager by
default. Hard to compete with that, but it's fantastic for users.

OAuth credential helpers are so widely useful I think it's worth
introducing them in the documentation. I'll draft a patch.
