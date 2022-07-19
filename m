Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B187CC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 19:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiGSTa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiGSTa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 15:30:26 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186328718
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 12:30:25 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s188so1740054oie.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plDS12j95FKMAwG95otkHwOTGnYuycrShRW317VBpNw=;
        b=n0ofAAz6FGeBX9Vt4pFoZqw/rd75pY/Gh2m8L7IUS7rSia69LUTdhQ/D9VCdybx43d
         OJqPzbuSKbTsE0cyNO7GK0pGq7jkDgAWMPNTzgPlBvLxAa0i3ORp58RXogDtJ3VJXOM9
         uQWDWvuVXsXjAdzbeHOlqXWTeMvW5Z/bTVfc6ApAD6upQNmSxpZ836wo/TZCdr0uTW0D
         IcqF0YevoSLk0NECMjOPFHvF2vGbxk3DzmCsCmbzozHVclCgdFT1F5uZWqyUxlQ65iZz
         h2PAn0rj9vA/CPjGW2b7kWzcUGTsHwosI/rICoGnLyc8cgHSSTdP/i6Tx7U+3oydWs+4
         wNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plDS12j95FKMAwG95otkHwOTGnYuycrShRW317VBpNw=;
        b=b3vjO7waHMxD4f78C7O3nAtX1wsQ9OONBxZ74pH2r6tRB6NuPPLYpmh0UhKsfJfuF4
         mg3ISMYJc7TUVFv5g9TOydKpUWxZA29kkOfTiiaghA9cykspe16/debCdmmy4Hi7+tyg
         f8LxxIn5nEURa1QK4fFQAx7aUpRqzw9QUPe1mQXERHr/ld2X5CWZlwQVhsoXSBa1BHhh
         MBw4f9SnmuAgXixPoeGd1wDQZ1glBXVpNwQwFLt6PUUhgwOi9ZTI1Ia/N9Kw6M3nHwv9
         D/0xnvaE+DEvG6kTOcuTw2UtKooLlA0tMpGkhD5K/IUvZaUZ3xEv5S5+C52BrrF2K73k
         ZBZw==
X-Gm-Message-State: AJIora/Gl3EzEXxxG5ORIuxtWUOwLNoxdlGDfyhk7+JlRnLU+OHfLEC4
        36hfyOVeUuWhjjc84k9c4IYWZdVgD3oXYLOMZqWIwA==
X-Google-Smtp-Source: AGRyM1tuFJuJpGnLyWN8lLTue9gTw2ZnFgnJQ/Sr0Kr6bBLfhtYxLqBVrIeloR+5H0VXjFJQQVEPxHp2lTbWf8rbazU=
X-Received: by 2002:a54:4e94:0:b0:33a:3462:1d71 with SMTP id
 c20-20020a544e94000000b0033a34621d71mr522039oiy.236.1658259025004; Tue, 19
 Jul 2022 12:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231935.2979727-1-calvinwan@google.com>
 <20220718214349.3379328-1-calvinwan@google.com> <xmqqzgh5d2s5.fsf@gitster.g>
In-Reply-To: <xmqqzgh5d2s5.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 19 Jul 2022 12:30:13 -0700
Message-ID: <CAFySSZDqMVV=Zv9hVa+S9=fhuvCTZvZUL50qMfSJHh4KTpm5RA@mail.gmail.com>
Subject: Re: [PATCH v5] submodule merge: update conflict error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        levraiphilippeblain@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The stuff to help reviewers who may have seen earlier round are
> usually written in the cover letter, or after the three-dash line.
Ah I see since this patch doesn't have a cover letter, I should put
all the reviewer-centric stuff after the three-dash line.

> > +     if (csub && csub->nr > 0) {
> > +             int i;
> > +             printf(_("Recursive merging with submodules currently only supports trivial cases.\n"
> > +                     "Please manually handle the merging of each conflicted submodule.\n"
> > +                     "This can be accomplished with the following steps:\n"));
>
> This makes me wonder if these "helpful but verbose" messages should
> use the advise mechanism.

I agree. The only loss of information if someone turned off this message
would be the commit id that possibly needs to be merged.

> Also, those reviewers who care about l10n
> may suggest use of printf_ln() to lose the LF at the end of these
> messages (i.e. not just the above one, but others we see below as
> well).

ack
