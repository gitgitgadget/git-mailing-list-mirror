Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411EDC41513
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 17:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjG1RhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjG1RhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 13:37:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FD34227
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 10:36:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bb982d2603so21467815ad.3
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690565808; x=1691170608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEuUD0Q9B4R5tia3AIbL5H2gkUTjGlspKCs6O/Cvvgo=;
        b=7gdZaGzg7A9wvFQs3zbzkQ19H7tY/bjypKiFCQFUG9sm3tZ/3fK4l9rfNVvsWa3iNY
         Vta/zDtTNfqoC8rYLy2A+Pu2V+XmKau7tgxvAyc0AtHXmhFbxOVJf9tAUGMyHrblxob3
         /orok8n5jZmXL3PGM/PZGx34iz6sbYACwuj+gFPVhvNjs9PEYURSTRsnynoVt7zexPkD
         M2ONhRkkvrqvx2XNgMiQIdGKgym96mq2oAyTbbCzHnOv+KFf+7n9+StO5kdpt0YNrB4Y
         Woo4yTrpbt5ysBHCPZ/SPsQPQtwTrUwEmrqEBeMtuSXsRnflffx0qKHuy8fFCEKJm6RF
         dAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565808; x=1691170608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEuUD0Q9B4R5tia3AIbL5H2gkUTjGlspKCs6O/Cvvgo=;
        b=ClgEmcDXhhvG2rFrYjOQUxZYlIQ1uHS/A1fg202JCc7fDnyJmuZ9Vs7fh31YyKGzMo
         Koht0jxDUiLTQSFcwD106DzDwhCPijvnUYWg74+3AvEJVZvxKmrV0BvYVf6XM4lb6K8z
         mEjDSBOnTmmCPwFI4g86x8ZbgqgNCWz1rRRkePyWoyCU0L7jZboeE7oP2uMDGyxzQu9W
         rfqX8W2m2PbbGdEkW9ScNykiKSpvR0g8YZuI0P2+Yu9ltiwVBLzvL7/yeZALI313KOii
         7W3UHIojoy3anEOZ9iCsfLKuTey364ej7YP3zX/aVZhRQMxCjFjbkzHEr2k9XjKwEg5i
         HCbg==
X-Gm-Message-State: ABy/qLZ7jW39pp5EhxI+GrKOOC7w1p/pkC9h7XsSro4LvgVWOe238JqB
        YZM/bA7H0sBxgqjP070VK2mFfi65BII=
X-Google-Smtp-Source: APBJJlHMyfBIciFdu683mmMxsKLYYdlZ/e/tcOQw/62ffHTziN6IkbtWpl198n/izteIiox23/pqayb4s/k=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:182:b0:1b8:c6ba:bf75 with SMTP id
 z2-20020a170903018200b001b8c6babf75mr8909plg.0.1690565808212; Fri, 28 Jul
 2023 10:36:48 -0700 (PDT)
Date:   Fri, 28 Jul 2023 10:36:46 -0700
In-Reply-To: <xmqqpm4c5ax9.fsf@gitster.g>
Mime-Version: 1.0
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com> <ZGSlqAPwaLhgWm6v@ugly>
 <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com> <ZGUIqBU0+Vr5LSBF@ugly>
 <10523968-0f02-f483-69c4-24e62e839f70@gmail.com> <xmqqmt21txid.fsf@gitster.g>
 <owly7cqkfvyu.fsf@fine.c.googlers.com> <ZMOOQTMk2wFwtSfa@ugly> <xmqqpm4c5ax9.fsf@gitster.g>
Message-ID: <owly3518ey4x.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The usefulness of the message comes from its information content.
> What do we want to read out of these messages?  I think we want
> a title that immediately lets us know three things:
>
>  (1) What the original patch was about.  
>  (2) What the final state is.
>  (3) How involved was the road to get to the final state has been.
>
> As to (1), we are not proposing to lose what comes "Revert", so this
> information is not lost under any proposal we have seen so far in
> the discussion.

Agreed.

> As to (2), with the current "Revert" -> "Revert Revert" -> "Revert
> Revert Revert" -> ..., you have to count, which is cumbersome and
> does not give you an immediate access to that information.  With
> "Revert^n", you'd see if n is even or odd to determine, which is
> much better than the status quo

I actually think "Revert^n" is much worse than what we have, mainly
because the "^n" syntax is already used in other subcommands (e.g.,
rebase). It may well be that we already have overloaded syntax
elsewhere, but we should avoid overloading where possible.

> , but it takes practice to interpret.
> With "Revert" -> "Reapply" -> "Revert Reapply" -> "Reapply Reapply"
> -> ..., the first word would give you the final state immediately.

I agree. But to take the idea further, maybe "Reapply Reapply" should be
shortened to just

    Reapply* "original title"

and likewise any ultimate _removal_ of the commit (no matter the exact
pairwise count of the word "Revert") should be shortened to

    Revert* "original title"

? The trailing asterisk in each case would indicate that this
reapplication was not the first reapplication. We could then put
in the commit message body text something like

--8<---------------cut here--------------------------------->8---
   *NOTE: This is not the first time we've reverted XXX.
--8<---------------cut here----------------^---------^------>8---
                                           |         |
                                           |         Commit SHA.
                                           |
                                           Could be "reapplied" if
                                           "Reapply*" is the title
                                           prefix.

to help stress point (3) that you described in your list above.

> We want to know (3), because between a change whose revert was
> reverted and a change that hasn't been involved in any revert, there
> may be no difference in the end result, the former is likely to be
> trickier and merits more careful inspection than the latter.

Agreed.

> With
> "Revert^n", we read how large the number n is to find the
> information.  With the current "the Revert repeated number of times"
> or your "a pair of frontmost Reverts become one Reapply", the length
> of the Revert/Reapply prefix conveys this information, but this is
> associated with the cost of pushing the original title further to
> the right and hard to read/find.

I agree that trying to keep the title short is very important. I didn't
think too deeply about this point previously, but I think it is equally
important as the other points you've enumerated above.

> Note that, while the number of
> times revert-reapply sequence took place is a useful piece of
> information, the exact number may not be all that important.

Agreed. For this reason I would prefer just using a single asterisk (as
in my example) after the first occurrence of the revert/reapplication.

> And from the above discussion, I wonder if the following would be a
> good place to stop:
>
>  - The first revert is as before:         Revert "original title"
>  - A revert of a revert becomes:          Reapply "original title"
>  - A revert of a reapply becomes:         Revert Reapply "original title"
>  - A revert of "Revert Reapply" becomes:  Reapply Reapply "original title"
>  - A revert of "Reapply Reapply" becomes: Revert Reapply "original title"
>
> In other words, we accept the fact that wedo not need exact number
> of times reversions were done, and use that to simplify the output
> to make sure we will not spend more than two words in the front of
> the title.  That would help to keep the original title visible,
> while still allowing us to distinguish the ones that was reverted up
> to four times (and "Revert Reapply" and "Reapply Reapply" only tell
> us "final state is to (discard|accept) the original but it took us
> _many_ times", without saying exactly how many).

I very much like your idea of just "stopping the recursion" early on.
The only difference is that I would prefer to drop the second "Reapply"
word in your examples and replace them with an asterisk (this makes them
the same as in my example).

I think having this second word "Reapply" would make the title
potentially hurt readability, especially because the first word is
really the only one users should be looking at anyway to figure out the
final state. Another reason for dropping it is because a well-written
commit message title should have a single verb near the beginning, but
your style would break this convention.

If you don't like the "asterisk" idea, another form might be

  - A revert of a reapply becomes:         Revert reapplication of "original title"
  - A revert of the above becomes:         Reapply revert of "original title"
  - A revert of the above becomes:         Revert reapplication of "original title"
  - A revert of the above becomes:         Reapply revert of "original title"

and so forth.
