Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FAFC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147776140D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFODqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFODqK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:46:10 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B864C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 20:44:06 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so12968134oth.9
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 20:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDwVBAP37licOZ/+CHzLnJ1+GfxVYpZLmMgzKxaEcF8=;
        b=jD7YBzOQR0zLlz4pFGlEaIcUrrMRpo/QJ1zFQXzpUjS9LyDjDBIpB+BGxKVtyzg6ne
         iAjinbZgR2/qcXQsb7CR2S6/eADkmPZ8Tu/5nEKxW3RCxqJbUR2mmnHJh9fSYBEUElNc
         iW5pxXEBVWiyCDFIl2Gk3etxpIUCfMyYIA7x9vG+k+cRH9ywRCCJu27Ve+VrTxL5EhvO
         FO4XsiHcQ4iKHi/ruQjx+8GTKjsOo35qM5LzDASrDZw443VFZAv8Bw/gv6Qa/nT7J3I1
         f49NsYttW0kXlPxkJCrRWQHMhsbZtXQ1iEyAldhH9Bpp0oUm/KWAROGEdn+2cua5GJs7
         b7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDwVBAP37licOZ/+CHzLnJ1+GfxVYpZLmMgzKxaEcF8=;
        b=cM08yCDg5+WyjR7bj/eVUYAqAzwhtLNiLBTRKu/Fb9PQ/23Bx6v/+jKuYvTe9DhV79
         bpw1EIQtYWiBElCMYsGr8Q+sOukxuSHQ+ahkPeKxQkxBEOHNsZ2zRPkBiZczQYVkI3IR
         Oq/69PeMT+2Je4nOj23IqN1mXhqU+6N4ocTrVROZ8dWXzXsHq9ATXxsF1uqMHvZqJxOb
         Z/dHRYEvapthhuBwds73s7WGy+ZrMvvd5eCHAHuoEsoy4vgKcdnLfviwu8WkzKPnGGNL
         QvwB9uoJFAbQntP2VOONF4XdNyVCzXf9zVl14ghsHi5BD6FiUvFBZ0GBnHPjqjUeDXtX
         MUvw==
X-Gm-Message-State: AOAM530spDCMmNebyRMFAUgfuv1fhXGG6pF2La9Kw68y9VoCwZlPpAM8
        lDFZOoEGmWNCNzZO9DREUSgfK987ZoD6gOFh2W0=
X-Google-Smtp-Source: ABdhPJx3gUtVSIZChKc/TuMsthAqmB7rPeSaWT/pdxL6OWVBuQdAdzB0PpsMeM4c6NWM6v5OEkIaKzTRGsazrhsRLb8=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr15564740ote.316.1623728645387;
 Mon, 14 Jun 2021 20:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net> <60c647c1d9b5c_41f452089@natae.notmuch>
 <60c677a2c2d24_f5651208cf@natae.notmuch> <xmqq7divzxrr.fsf@gitster.g>
In-Reply-To: <xmqq7divzxrr.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Jun 2021 20:43:54 -0700
Message-ID: <CABPp-BFY7uU5Ugypv4xCHq+XHTc3UROWPdV1v-JbN7xBycDZTA@mail.gmail.com>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 7:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > I found the problem, m->chg0 was not initialized in xdl_refine_conflicts.
> >
> > I'm not familiar with the area so I don't know if the following makes
> > sense, but it fixes the crash:
>
> Unlike the remainder of the xdiff/ directory, xdiff/xmerge.c was
> Dscho's brainchild if I am not mistaken, so I'm CCing him for
> input.

This is going to sound harsh, but people shouldn't waste (any more)
time reviewing the patches in this thread or the "merge: cleanups and
fix" series submitted elsewhere.  They should all just be rejected.

I do not think it is reasonable to expect reviewers to spend time
responding to re-posted patches when:
  * no attempt was made to make sure they were up-to-date with current
code beyond compiling (see below)
  * no attempt was made to address missing items pointed out in
response to the original submission[1]
  * no attempt was made to handle or even test particular cases
pointed out in response to the original submission (see [1] and below)
  * the patches were posted despite knowing they caused segfaults, and
without even stating as much![2]
  * the segfault "fixes" are submitted as a separate series from the
patch introducing the segfault[3], raising the risk that one gets
picked up without the other.

In my opinion, these submissions were egregiously cavalier.  I'll
submit a patch (or perhaps a few) soon that has a functioning zdiff3.

However, since I've already put in the time to understand it, let me
explain what is wrong with this patch.  This particular change is in
the area of the code that splits conflict regions when there are
portions of the sides (not the base) that match.  Doing such splitting
makes sense with "merge" conflictStyle since the base is never shown;
this splitting can allow pulling the common lines out of the conflict
region.  However, with diff3 or zdiff3, the original text does not
match the sides and by splitting the conflict region, we are forced to
decide how or where to split the original text among the various
conflict (and non-conflict?) regions.  This is pretty haphazard, and
the effect of this patch is to assign all of the original text to the
first conflict region in the split, and make all other regions have
empty base text.

This exact scenario was discussed by you and Peff back when zdiff3 was
originally introduced in the thread where Felipe got the patch that he
started this thread with.  In that thread, Peff explained how zdiff3
should only try to move common lines at the beginning or end of the
conflict hunk outside the conflict region, without doing any splitting
of the conflict region (this particular issue took about 1/3 to 1/2 of
the original thread, but I think [4] has a good hilight).
Additionally, a quick grep through the code showed that there are
additional places in bash/zsh completion that need to be fixed to use
the new option besides the locations modified in the original zdiff3
patch.  See [1] and [2] for various other things overlooked.


[1] https://lore.kernel.org/git/CABPp-BGZ2H1MVgw9RvSdogLMdqsX3n89NkkDYDa2VM3TRHn7tg@mail.gmail.com/
[2] https://lore.kernel.org/git/YMbexfeUG78yBix4@coredump.intra.peff.net/
[3] https://lore.kernel.org/git/20210613225836.1009569-5-felipe.contreras@gmail.com/
[4] https://lore.kernel.org/git/20130307180157.GA6604@sigill.intra.peff.net/
