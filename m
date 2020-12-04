Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FD4C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FB322CE3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgLDVMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgLDVMm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 16:12:42 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB78C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 13:12:02 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 3so8194145wmg.4
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLtgAqSNNPWAj++KRFilwsaFew7n+3sL0FYoS6lRKwc=;
        b=hqZZk/wnopp3fkhicitwnwKwK2zK9RYslgyVIfemXJzR2LcQO1kS64TKz0db1rsarN
         nFTlcK6KtDIulafPh+4p6POOTAPRlmO0tO6KJfL1Uh2poCyaC0NIcWzR8MqlbAn2v7Ts
         whfLAsOGwZoj6941YdXpyjrKD6NPxlZpm/ednak12u1czTkT5Dt/zIYxMuyBXljV3ORI
         8txRbNjijIyrioQvGvT2WzqMDJHl1tU7BzwVr63tjXXfP7Cy0IeYdv2vwXaY5lzOeSl7
         b0kTArypM8aG/v6CCIluCERDTFPgTD5Bpa6mq9OXLhV/tHL3a/s+bhfIjvYuevrNyOuk
         W2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLtgAqSNNPWAj++KRFilwsaFew7n+3sL0FYoS6lRKwc=;
        b=iRsoIJ0skDYmxt2I7is7cV25yMppsawvYS1rPF2HR82WeGQovXBM/p/CFbcpjsfwBi
         K7HcrqA3eJnFszxOd61B0Ec8YmXiqm94JQjXwwyZlOU+7hLL+VYJBBYxVbVgY+4nmoQO
         dTkAPcoBI2G6LjwnmK4EwFul0qTKaq/KWFZU+VEz00rkyTqyMTEPiGfcdhStG8RAx6rg
         g8gu+5wx94NeqHAQVxqoMnMlpvQcsXAdMeKDLlIod/wUGxEchm6F/Huzxqp93YFPJ7kI
         ARJIr8Bqz2mBqb+B3ZKcSt2lyHv6Nfxi5M51fC5wjIMXDWheOAOmjMlzh7VwiCcbL0Lf
         mwwA==
X-Gm-Message-State: AOAM532LAdTRCpqE6FLWzndnwcqYAohe2Q3bcUdbRf9v0oQfQetTWzUN
        9SvaYgiXWhnHA1zbwmVyzrJ2+AIvAQlF1Q9vFls=
X-Google-Smtp-Source: ABdhPJy/9MAChO2Kj6NlvM9BSIVI0UQhdZpcIFmMUAiWRK/W8KUb/CN3t6DWu2RZN86zpDE6BjD7gg1f6hatcaR2KSg=
X-Received: by 2002:a7b:c843:: with SMTP id c3mr6219612wml.100.1607116320748;
 Fri, 04 Dec 2020 13:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
 <20201125020931.248427-2-alexhenrie24@gmail.com> <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
 <CAMP44s1Hwun+P=j5BBbVUT-ACS4hJCyRCJT-=6WvwK913fXq7g@mail.gmail.com>
 <xmqq7dpyix1d.fsf@gitster.c.googlers.com> <xmqqmtyuhemi.fsf@gitster.c.googlers.com>
 <xmqqpn3qfhps.fsf@gitster.c.googlers.com> <CAMP44s02N9LJxi_eme8+nqEQameKtpNJtTXWDT2q3_EPV09gag@mail.gmail.com>
 <xmqqh7p1fjml.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7p1fjml.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 15:11:49 -0600
Message-ID: <CAMP44s1Na1cf8=VdoejKr7JesmS6H3Gf=tkHLq4Zit0nxZXs4A@mail.gmail.com>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not
 set either
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Git <git@vger.kernel.org>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 1:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> What we want to see can be done without such backward incompatible
> >> changes, e.g. declaring the combination of "--ff-only" and
> >> "--[no-]rebase" incompatible and/or the last one wins, I would say,
> >> and I suspect Alex's RFC was an attempt to make the first step in
> >> that direction.
> >
> > It's debatable whether or not that is "backwards incompatible".
> >
> > Currently "--no-rebase --ff-only" fails if the merge is
> > non-fast-forward. With the proposed change of semantics it would work.
> > That's a change.
>
> But with such a change, "--ff-only --no-rebase" would work by
> ignoring the "I want to reject non-ff situation" request from the
> user, no?

Yes. And that's a change.

That's why the "pull.mode=ff-only" solution is cleaner; it doesn't
need --ff-only to change its semantics.

> > Keep in mind the whole point of the changes: to make --ff-only the
> > default.
>
> Sorry, I know you keep repeating that "keep in mind", but I do not
> quite see why anybody needs to keep that in mind.  Has a concensus
> that the repurposed --ff-only should be the default been
> established?

That's the whole point of this patch (pull: default pull.ff to "only"
when pull.rebase is not set either).

If not --ff-only, then "pull.mode=ff-only".

Are you saying making the default be fast-forward merges only is not
the eventual end-goal?

Cheers.

-- 
Felipe Contreras
