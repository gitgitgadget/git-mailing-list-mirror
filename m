Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F48C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 23:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EC223A1D
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 23:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLGXa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 18:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgLGXa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 18:30:56 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E14C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 15:30:16 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id p7so8576513vsf.8
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 15:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FtZoAUaB6kcGBKFu4Yofc2Jz9iUzkBrP/B2l9qmy9k=;
        b=u2HwQ8KkFxXIjW+lVbcKQLrNmWqK8XrslOAgHJPgBHY6Na6mSwzHgaUDxovAIWDyn8
         x+B2fPum3nbJf6QPbBpHy5h9Rarsy/nNtNP1fupY1t5UGB6w3uh05wYtiyzmPBsCbFQP
         dADsUzmRJWBShQGCbflJ67wXkFwJH3C7jgme+6YQZ5iyF2bZRyKUcTph5mYDau6jbWPn
         hcvBLEshXMkvHPHNNI8N31MUrTk+mvcx1Bb+ciZCPyVZjkZ76QcvdsatDLy/C9J5X6+5
         NzlKfy6RmGv6AFg3yieu9CD1mKwfxZqxjlPx2soKv9u7nNz7Stev8r6xjMju8gC3uxdk
         43Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FtZoAUaB6kcGBKFu4Yofc2Jz9iUzkBrP/B2l9qmy9k=;
        b=D2FR+5a7vGwh1cIrjI3OTPzN0DylfSfF9VKiN9R29H4zLTLE1GPqAIEb9nzy/z/xBq
         wkO1uOJ37/ca4hcqA7456MgWK7f7k2xygwfh4UNZDUmAx3oPmTHgrVEqvelXcpopmHBj
         e62ONz4M/h27TGGJBi2qUjyUYgLpZIdh4MLOXh5JQrEWKJHIRulGdWfnklnf6WVenpEQ
         M/RZPHsJq3I5sFHFlRQpouSEcXSPbQ1vV6q6VrNZT8k+MJcJlDcdMC8bX02etGm++6x/
         5tfrmAe5Bn2xxUEB92DpkQxAgQnHpBMPKb/zQF4PODlAW/2A7Sof/yB+0KK5F4CpeFsX
         aF8g==
X-Gm-Message-State: AOAM5319evZGPeClWtyIfCJjMrvb4tCGHY39yTi+gmc1FWZtfci3S5+B
        FyHbEXNuULdfgtQlO+C1xy3DFZdiDRQ4kPCOyWc=
X-Google-Smtp-Source: ABdhPJySDzBDuPNPaJRHmcnzZDOzoY9S/EtKainhdXdjXflej+QEG6lZlCvZF1rpayazQqBJuzwJfBDkC8zLYrrtiXo=
X-Received: by 2002:a67:f80b:: with SMTP id l11mr13384132vso.27.1607383815629;
 Mon, 07 Dec 2020 15:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com> <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com> <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 7 Dec 2020 15:30:04 -0800
Message-ID: <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 11:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > They start by saying the same thing. But one errors out and says the
> > user must choose, and the other warns that in the future the user must
> > choose.
>
> Then I do not see the point in giving the warning---even in the
> future they do not have to choose as long as they are merely
> following along.
>

I think the key point is that this "in the future" is referring to "a
future version of git will make this an error"

This might be better if it said something like "The pull was not
fast-forward. In a future version of git you will need to specify
whether to merge or rebase, using pull.mode"

or something similar. In theory, this warning will go away once that
future version of git changes so that pull.mode defaults to ff-only.

The difference being that a warning will allow the command to continue
doing the default of today (merging), where as an error will stop the
command essentially just after the fetch portion finishes, without
changing the branch.

Thanks,
Jake

> >> > Just to put this series in context: it's only part 1; it does not
> >> > introduce pull.mode, and it doesn't make --ff-only the default.
> >>
> >> I'd view the "in a non-fast-forward situation, the warning kicks in
> >> to those who haven't chosen between merge and rebase (i.e. no
> >> pull.rebase set to either true or false, and pull.ff not set to
> >> only), which is a bit more gentle than the current situtation" a
> >> good stopping point.  That state is already making ff-only the
> >> default for unconfigured users, or you can view it as shipping "git
> >> pull" in a shape that has the more dangerous half of its feature
> >> disabled to avoid hurting users.  So I am not sure why you keep
> >> saying you do not have --ff-only as the default.
> >
> > The warning doesn't make the pull fail, ff-only does.
>
> Then probably you are giving an error and a warning at a wrong
> place.
>
>  - When history fast-forwards, and the user hasn't chosen between
>    rebase or merge, there is no need to give any warning.  Just
>    succeed by fast-forwarding.
>

Correct.

>  - When history does not fast-forward and the user hasn't chosen
>    between rebase or merge, whether pull.ff is set to "only" or not,
>    we should fail and the error message can instruct the user to
>    choose between rebase and merge; there is no "ff-only" option
>    that is useful in the situation.
>

Yes, I understand that this is the destination Felipe wants us to end up at.

> And that essentially makes the "ff-only" mode the safe default that
> castrates one half of the feature (the more dangerous half) of "git
> pull".  Why do we make it more complicated than that by warning that
> the user must choose in the future?  They will see an error tell
> them that when they start pulling while on their own work, and I do
> not see a need to bother them before that point.

The warning would be in an earlier version of git before that is the
default. The warning is for a transition period between today when we
merge by default (with a warning) and when we fail with an error
without completing the pull. Once the default is the ff-only mode,
then the warning is no longer necessary, as we will get an error
indicating that you must choose.

Thanks,
Jake
