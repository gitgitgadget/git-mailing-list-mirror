Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A5DC2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A34E2071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 20:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsxyqHeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgAYUuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 15:50:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44678 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAYUuu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 15:50:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so4919744otj.11
        for <git@vger.kernel.org>; Sat, 25 Jan 2020 12:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwnlP5cqY7b3KFDm8rftkLmXsygy0SPOpYnD5Q9S9wM=;
        b=ZsxyqHeHOXoGBOkPuGtW0l/R8S+zCqJNipSVR+YDZzwWLq3md3IutO8tpOd1zfiDK2
         9DqK3bXxKLKLLyxaEJur4L0wc4515mBQLEBl6Qk3eDb2XCXIjCzQzO5CfX8DUkOaDfH2
         ih8PeoIa4xbNwx8uE28/55rqthzt4h3dAjfrnH4axEGVOpv9ZjefMCtFSa+7QgKysyeH
         KiweZHGP6BB/AJrTGS1YZ5wpZ8y5elu81AUZqQPOPBPho4VrNyK114ak6HO78tDGN3ez
         /p/dmS5dyh/fHNbSOHBSChjsN/WTKS8E+7TXI8nAufBPGn8VUJTU4Xd5R/Cp1K/IRnGR
         2MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwnlP5cqY7b3KFDm8rftkLmXsygy0SPOpYnD5Q9S9wM=;
        b=b+H1RX62mbZf/7zmapXkEl1ltrOot7OVs6hFyfiedLDELI4kx+lvLkO157WlRmwDST
         B1FrfbVV2eR02Vf7Xrs8Nfrr0jni+VkxmQ0hpv6hU+jhD01m1mzBtWnlzNqwAyZtTdC6
         iFbWlijzRVPtZ8me4LoOP4caQJTH8OwMcfKwv7N4X9WHdM4oXOIN7BafHozUgCmpZOh8
         MxblFqL+2pdgJ4ROs1u1jLT1yxz/1g7cHLudsy14Z/cyvNrv9+pHtK3u00xDb17M16W8
         GczqGNPn2Tb70Rs3AQLWi0k0JxrwcKPYU6x6Wo0zUFmTciiuU9UMenrTjdEnRrQNPomH
         pLwg==
X-Gm-Message-State: APjAAAVxPxWoSBJb3/2tYiwpSG3pcGW/JM/tIU3gD08m+D3EjpNv46lf
        aY/zYALoSmk5mxDNqmx8Z1Ls3owLiWgrzLW2KII=
X-Google-Smtp-Source: APXvYqwZAAbP+yPlRCddA49hIry+iuXjfsZhsBYNlp55e8UIevDRHXXaNTDdXkhE2QhcankLtJ5GjlobYEuLfzY/UuM=
X-Received: by 2002:a9d:634e:: with SMTP id y14mr7595457otk.162.1579985449658;
 Sat, 25 Jan 2020 12:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20200125053542.GA744596@coredump.intra.peff.net>
 <20200125053723.GA744673@coredump.intra.peff.net> <xmqq4kwjcupj.fsf@gitster-ct.c.googlers.com>
 <20200125195515.GB5519@coredump.intra.peff.net>
In-Reply-To: <20200125195515.GB5519@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 25 Jan 2020 12:50:38 -0800
Message-ID: <CABPp-BFp3VrYjD8KTqnOff0-CDY7qO3Au7GeUDCuA46ofv1GSg@mail.gmail.com>
Subject: Re: [PATCH 1/4] merge-recursive: silence -Wxor-used-as-pow warning
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 11:55 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Jan 25, 2020 at 09:27:36AM -0800, Junio C Hamano wrote:
>
> > > So let's keep the bit-flipping, but let's also put it behind a named
> > > function, which will make its purpose a bit clearer. This also has the
> > > side effect of suppressing the warning (and an optimizing compiler
> > > should be able to easily turn it into a constant as before).
> >
> > OK.  Now I see you named it flip_stage(), which is even better than
> > "the-other-side" above.  Makes sense.
> >
> > I still think ((2 + 3) - two_or_three_to_be_flipped) easier to
> > reason about than the bit flipping, as the implementation detail,
> > though.
>
> Yeah, the existing one relies on the coincidence that the two stages
> differ by a single bit (in another universe, they could well be stages
> "3" and "4").
>
> I don't overly care on the implementation either way, since it's now
> hidden in the helper. I mostly chose the bit-flip to match the existing
> code, but I'd be happy to change it. Other people who actually work on
> merge-recursive may have other opinions, though.

Interesting.  In merge-ort (my in-development attempt at a replacement
for merge-recursive), I'm currently storing the stages in an array
with indices 0-2 rather than the 1-3 used by merge-recursive.  This
removes the empty/unused array entry at the beginning, and also works
a bit better with the masks that traverse_trees() returns (as 1<<index
corresponds to the bit in the mask from the traverse_trees()
callback).  In that scheme, bitflip won't work, but the subtraction
idea still does.  So, I'd tend to agree with Junio, but I think the
helper you added here is probably the more important improvement.

However, all that said, I don't care all that much about what to do
with merge-recursive in this case, because it currently looks like not
much of the code is going to survive anyway.  merge-ort isn't even
alpha quality yet[1], but I seem to be moving towards totally
different data structures and copying/sharing less and less code from
merge-recursive with each change.

Elijah

[1] merge-ort still isn't functional yet other than in extremely
narrow circumstances, I'm still experimenting with the data
structures, and I've written several hundred lines of code and then
thrown it all away at least once -- and may do so again.  Whenever I
find a useful patch I can separate and submit upstream, I have been
doing so, but until the risk of another complete rewrite goes down,
there's no point in me sending my half-baked ideas in for review.
They need to be at least three-quarters baked first.  :-)
