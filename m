Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8756EC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 05:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiGUFZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiGUFZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 01:25:33 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA49CDF95
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 22:25:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y9so560646qtv.5
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 22:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OE8Ub9xnNHpwIXDQDWMcEIu1N6OwanWyYouKZxFJnQM=;
        b=p2gHvbeiFRu1iF1rErWObVhTyxoZWQhKbw1ecJwkOySffiyPyvDQbtTA7XZbUZ/s5D
         hCS+s89yhcLGPsDRZ4pL2bljwI8e+GFurZ0E/k2DtUzIMViHuWArpENUvo13hU98pEyM
         T7l8AMKA4Hp9KLb3Nxp4skpej7TxqjD3ZVVKzNWrG42mJwPGM5Z+QCuhSNwTyCLDgmmL
         rfA46NaU2G9Kdyd/KZWqwxLobDE8BjuPDvcNlyAnuT9TwB1lBEprhK+WOtzxhl0cNn6N
         Fuincx15f3tBULGN086O2k1JyBwlx6SbVquXggJKWRMblm+Mknmtrdtff2mmTP2/Rn2o
         Lm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OE8Ub9xnNHpwIXDQDWMcEIu1N6OwanWyYouKZxFJnQM=;
        b=gXdM6pKwF4Zj5PAOosn7flY34tUTKPgeLdyl+2MVORa/LPEwECgykN6OkrD0hj39Ot
         SZD+EmbQZIrNkFInq2Bum91cegf3udnbpgFqlIo84UI/iNCaA4mBDqOE/GopbZTpwhCR
         QdPOdeuZxDkqFX2l5JiTWIyRBwGbWx6CU8tuPXKLWBx+Tghr2LLm9/uKaoFhxAl5xKWY
         16Kk7z4eAftVrzPpwMKuzy8F4/+dsgIhRvmerrgF2qAAD4LO5hCi7JhrinYEPZ+WRfzL
         t76I7Vdj+U7ZmVcljeYoQJyKqvs8KHTdm2nHevsPv6A5sR2BLzl/uQ1s5vkRJessspD0
         GddQ==
X-Gm-Message-State: AJIora9ltzGZj7FTBjOaRJYlgh5tFCf2UV6b10hFc/ajqoBfoNiS/KVp
        MECLiLTY/tPAi8n6Jcygtmz/OrWxgcE1zEf6HATiML0fCKY=
X-Google-Smtp-Source: AGRyM1sY7KJji3LR1mtzn6HHZz/AP+1yFJ3EM3vR+BmjI2kiDFqPOZ0L1IQk50gqNsCB5UDYxM10GMMejmVkGTDae0k=
X-Received: by 2002:a05:622a:412:b0:31e:daba:4fc9 with SMTP id
 n18-20020a05622a041200b0031edaba4fc9mr22646838qtx.541.1658381130754; Wed, 20
 Jul 2022 22:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqilnr1hff.fsf@gitster.g>
In-Reply-To: <xmqqilnr1hff.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jul 2022 22:25:19 -0700
Message-ID: <CABPp-BFm2c2Mpdj6pTR2-WPEsnQWTJpH70xrZoqUrwOed9o9=w@mail.gmail.com>
Subject: Re: On-branch topic description support?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 5:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I've been playing with this idea from time to time, but recently I
> started seeing a related discussion on the b4 front, so I thought I
> would throw it out and how people would think.
>
> We made "git merge" not to silently commit the result, but open the
> editor to encourage the integrator to describe what the topic is
> about.  We also made "git format-patch" prepare [PATCH 0/n] aka
> "cover letter" so that the author of the patch series can express
> what the overall topic is about.  What the author should say in the
> cover letter very much overlaps what the integrator wants to have in
> the log message of the commit that merges the topic to the
> integration branch.
>
> But there are two (and half) links from format-patch to that merge
> commit that are missing.
>
>  - You cannot prepare the cover letter material while working on the
>    topic---instead, you have to write one by editing the output from
>    "format-patch --cover-letter";
>
>  - "git am" at the receiving end discards the cover letter when
>    queuing the e-mailed patches to a topic.
>
>  - "git merge" cannot take advantage of the cover letter that was
>    discarded when the topic was queued.
>
> So, here is how I would imagine a slightly better world may work.
>
>  * When you are almost finished with the initial draft of your
>    topic, you'd write a cover letter, and record it as the log
>    message of an empty commit at the tip of the topic.  As you go on
>    polishing the topic with "rebase -i", the empty commit would be
>    kept (if we currently lose an empty commit by default, we may
>    need to teach "rebase -i" to special case an empty commit at the
>    tip of the range to make this convenient to use), and you would
>    keep it up to date as you update the topic.

No need for rebase changes here.  By default, it preserves commits
which start empty, and only drops commits which *become* empty.

(If one wants to drop commits that start empty, you can pass
`--no-keep-empty`.  If you want to keep commits that become empty, you
can use either `--empty=keep` or `--empty=ask`.)

>  * "git format-patch" would notice that the topic has such an empty
>    commit at the tip, and use the log message from it to
>    pre-populate the cover letter.
>
>  * "git am" would learn an option to save the cover letter [0/n] and
>    create such an empty commit at the tip of the branch.
>
>  * "git merge" would learn an option to recognize that the branch
>    being merged has such an empty commit at the tip, and instead
>    merge the parent of the tip of the branch into the integration
>    branch, while using the log message of the discarded tip commit
>    in the log message of the merge itself.
>
> Yes, there is "git config branch.mytopic.description" that helps
> when pre-populating the cover letter, but that only helps at the
> origin, and it is not shared between your personal repositories.
> If you have the draft of the cover letter as part of the branch,
> you can push/fetch them around just like all the "real" commits
> you are working on.
>
> Regardless of where the cover letter comes from, the changes to "am"
> and "merge" dreamed above in this message would be useful, and that
> is the primary reason why I am envisioning that right at the origin
> having the topic description as an empty commit at the tip would be
> the most convenient.  It would match the shape of the history at the
> author side and at the side who runs "git am".

Seems mostly reasonable, but I'm curious about one thing:

The cover letter material often includes stuff that would not make
sense for the merge message (e.g. "Rebased this version on master
because of conflicts with ...", "Changes since v3", "I'm a little
unsure of the logic in Patch 5", "Patch 3 might be controversial; take
a look", etc.)  Would there be some kind of syntax for specifying the
part of the cover letter meant to be used in the merge commit message,
or would we just start out with it pre-populating the commit message
and expect the integrator to cull out the irrelevant parts?
