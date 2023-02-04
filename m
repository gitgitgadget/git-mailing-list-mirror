Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C30C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 14:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjBDODb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 09:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjBDOD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 09:03:29 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7382203E
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 06:03:28 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id a1so9473277ybj.9
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 06:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2UsWNEM+P2lAMBvN8hB8UfUbi5KiarlitlUwmvn0J8=;
        b=NAp2pocLA9T9QrKKr5DMnOypjDxT9EdPeJ7XvOKBslDLzltoHouEESu3de/9lTWKLV
         /Yual7wwOSHXamlwVjiRIW+/sfh6z/eCdGHkSh+6ZSwuBeF/3KS8qaTmOA5r8MPAbWHG
         J9FkrS+z6gnRT1uu3e+9uqJOlYCGLdiC7x1HG5zfYqbQes4ViDGSk9RjkJEo8czOoumY
         s6wJ1PDdx2A9YIhGXdUkD/gDvjF8S3nfyPSvZUJOiqPDTOPAQ4US6J1Tlxdw5lwDr1BD
         DCrs+/+C1jXHT2rsWs4R15vn2/MM2xqOiBFjnoC7ZErfwcPKUbDMumdbx4+UYfVfJ5wB
         WQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2UsWNEM+P2lAMBvN8hB8UfUbi5KiarlitlUwmvn0J8=;
        b=3Rx5rp6siVZ3sOOcO4bT4fotPTokJZRkgMfcoHGDFPTSoviCnUmR5gkB9Ys8gS3skt
         7DJ7jyjNIhqwOORP/adv4tfnjASlMAa+zwamUjOlv+ezJwaQGaHIZXj/+IPTzcSUQ0eY
         Y29eAQrjnN5/dLefJDDZhmypTB+5xDNijDS2QxSBexYmk1FaCI7nVB7Gu4hZNgJrcNpu
         wpr7l6zKp/b6WKsUwZW5GkaP4eImwAljxPWgSxvCdHVh/otgbkZ0xm1v/nTTY15Fj06i
         kTtSHCOXw+lTK+PjYuoDWs/p9mOfiDMEPTt2ynxeHRIOQGZPg4OGmG0Z9gXGdECQGCAr
         SG8A==
X-Gm-Message-State: AO0yUKVhvpLQEeVVKTFJe3R/tGYqTlFUB6aITSbTcf2zVIvGVSMVPQQK
        OSJ0Y2DBD/fzZM+sicfE46acoYGuDOePztq17pODrU27voY=
X-Google-Smtp-Source: AK7set9QEH7uUxCtZ9Th9gDNergtGvp4K59innPNl+WGHiiBbk2M1elVGoGngrpY4yC4ZhwWEuQAIt53Vg7s1/Z8Bes=
X-Received: by 2002:a25:9c49:0:b0:881:642d:90e2 with SMTP id
 x9-20020a259c49000000b00881642d90e2mr117422ybo.259.1675519407553; Sat, 04 Feb
 2023 06:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20230203182255.lqla3hsme6riy4w7@meerkat.local> <Y95BEaOGJy9uBHkG@coredump.intra.peff.net>
In-Reply-To: <Y95BEaOGJy9uBHkG@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 4 Feb 2023 15:03:16 +0100
Message-ID: <CAP8UFD1q7-XbX4C_NjyL7A-6n6Nc4MgSbUKnzQOiRyKRMtLv_w@mail.gmail.com>
Subject: Re: The sad state of git.wiki.kernel.org
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2023 at 12:48 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Feb 03, 2023 at 01:22:55PM -0500, Konstantin Ryabitsev wrote:

> > # Should it be archived as a static site?
> >
> > It's possible to turn git.wiki.kernel.org into a static site with a large
> > header on every page that it contains historical archival information, with a
> > link to https://git-scm.com/doc
>
> This would be my preference, just because some of the old content may
> still have value. Some pages (like old gsoc stuff) would better redirect
> to git.github.io, but it is probably not worth the time to even try to
> classify pages.

This would be my preference too. I agree that some old content might
still have some value. We could also move or redirect some old content
to git.github.io, but I am not sure it's worth the time either.

> > # Should it be archived and put out of its misery?
> >
> > The last option is to just archive the site and put it out of its increasingly
> > irrelevant existence.
>
> I'm also OK with this, though if it is not too much work to serve the
> old content with a warning that it may be out-of-date, that seems
> better.

I agree.

Thanks,
Christian.
