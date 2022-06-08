Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DBEC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 18:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiFHSBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 14:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiFHSBO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 14:01:14 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93041CBD2D
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 11:01:13 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id a8-20020a05683012c800b0060c027c8afdso5403949otq.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVoUzYyiu7w4nqdX6Woj6d+MnP33uvZgWbH2TfGziLc=;
        b=OdfUdYglS+azIQXY85W2SGm3T4Lx76xul8ZsYPYjQhm/OrU7HtxLuYopueKQ4JGieN
         9Ztdlt9S9zCO8LNRZPyPvbzvPGUtkLs2xsnl+gMbP+Tj+QdAiZQaNmCLl4uSRDwHr13t
         FkSp9gnGje7RNG/OnRAQ0WGR6b49G0GCKoHmCxorOSYSMrr5ZmAanngb10+uwkE6ANX3
         tJOppuWKS5BTIxiEY1mE1R+L+L/I/JznIQyK6HowrXVdQole7/pSW6gXZtgEqGyxKMi5
         BDlARiqUBU8gCi8SZLbDDp1WkvHFZFds+2dpWl0gfT3GE9EDFLB9kCfaNfBU10G7vhwb
         NI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVoUzYyiu7w4nqdX6Woj6d+MnP33uvZgWbH2TfGziLc=;
        b=SLQYzMpOcnprfzndNONeCzKAIwBN1dJ5s6wQPMPrvX+/Sg0O69B8NQtpD28KH7BJK4
         LmI+2my9YKrBTm/O98apcMlnfwHzmf67iKZqoxqPOo0UmHmf2BXdDaHb2d+XwQs0Igju
         /BRtrf4BSoaNqEabXCAEwq+Ele2v1AFoO4z2tVkOmtIcaASfyU74YAHeVJ7Onk/W4CAy
         NUAXDbnjnpbtHJYV9EIfRHb+n2zgOT+0Ba695giM69I+7CDTAm0pk6LWO8+t5iJuDjeI
         3XmPW4L421g+s6oxUUXRfNzBipdrYXNK1Q0ElxtUptvWpkABCxw7o/q1ducwYA8HUl4P
         iGZA==
X-Gm-Message-State: AOAM530cb8m6GdtpO7tfURm0Cjadt2oLcMRgTFuZ11LRWDKctJg2wC15
        0GtWGF7DyIW3JtnwVbpAxJV8di1IIabk1PkZxyuefFD50KzwKg==
X-Google-Smtp-Source: ABdhPJx5gccyuN3mRE7GCoQ5dAW/zi6+kkXY2bKALiJ28OZ2gbuCctsYllQfFuUp+zk2eRO9ihaTGuDhb83SsOg/vwU=
X-Received: by 2002:a9d:5907:0:b0:60b:b346:73d2 with SMTP id
 t7-20020a9d5907000000b0060bb34673d2mr14657269oth.130.1654711271577; Wed, 08
 Jun 2022 11:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220606235449.2890858-1-calvinwan@google.com>
 <xmqqh74x1eol.fsf@gitster.g> <CAFySSZC0ieObo=CzhoHiqrcdv3335VaRBtYMLFe9oEJ0hucOCA@mail.gmail.com>
 <kl6l8rq76oub.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l8rq76oub.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 8 Jun 2022 11:01:00 -0700
Message-ID: <CAFySSZBV8r1PuLb7br90VHbHmXgdgW2Ta4qw07BN9SXvh=aFpw@mail.gmail.com>
Subject: Re: [PATCH] submodule merge: update conflict error message
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The user probably
> wants to merge the submodules, but they can choose however they want to
> resolve the merge conflict

It sounds like I should reword "merge conflicted submodules" to
"resolve conflicted submodules". That should cover those 10% cases.

I would prefer to find a generic, but still helpful message that doesn't
require going into the advice() API or require some config change

On Wed, Jun 8, 2022 at 10:35 AM Glen Choo <chooglen@google.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> >> Hmph.  Is 1. necessary?
> >
> > I just tested it and it is not, so I do agree recommending to abort the
> > merge is unnecessary/bad advice. How does this sound?
> >
> > Failed to merge submodule <submodule>
> > CONFLICT (submodule): Merge conflict in <submodule>
> > Automatic merge failed; recursive merging with submodules is currently
> > not supported. To manually merge, merge conflicted submodules first
> > before merging the superproject.
>
> This message sounds ok to me, since this is probably what the user wants
> 90% of the time. Since we don't abort the merge, this just a 'regular'
> merge conflict resolution (albeit with submodules). The user probably
> wants to merge the submodules, but they can choose however they want to
> resolve the merge conflict, e.g. maybe they'd prefer to just pick one
> side (or even more exotically, a different commit altogether.)
>
> An improvement for that other 10% would be to print this help message
> with the advice() API so that users can turn it off if they don't find
> it helpful. Or maybe it's confusing to some new users who use a
> different merging workflow and so an admin might turn off this advice
> for them.
