Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B4C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 05:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhLDFy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 00:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhLDFyz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 00:54:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2041C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 21:51:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so19877524edd.9
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 21:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0IEenH+sKcvjkf3tRvPqfsFBXNaDKkj0V49axolE84=;
        b=aMV80/oz3hd7/oKnjdhMIesI4oA9L2u8ME9btkvjeZYCW5FUxlwXZCriJ14Mx4CBS3
         AtpC1RjmpS9FJxP7ZbP0buEhtmp9dw/1kzkzDgO0MFI6t/7xxoPj9U0WyY3JG5nYr0bc
         yugpfS3nqhS8LALEnZKuq488krvvYv0KHpj/G0cYJDvaeNG71+nQh55Fif/QS3x+tcrB
         6H2ALGP8QqD3Zu1donPpM+P2j5CyUPzlt9VOvkfyY/bxrR2v3rdicoQjeAcg6Ue5+sFA
         w1dDIRmJIHoeWGVqoyr6aLu6iZjAjyAE8YlxHHZR76qqVwLQDnpm6jRHgKQIxNIrh3xa
         Kqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0IEenH+sKcvjkf3tRvPqfsFBXNaDKkj0V49axolE84=;
        b=fua9kED9aNvgrw8Z4z2OlgbKsKwsDcuXfJIKjOV+1b2YqC2cEWAjb4wNn2pMNngnaX
         jEubUtbR1gD1F8Ec7+Gw6dq0Bsq0ujb5BFw9tDs1kqg6FKMdir7pL3CxI3jXj6HgdmEd
         wIQu3LMjb8U56lILOKG1oCwCpBLZPS8DzsjI2pUxY9ygwkAi2+kQpWOaDfG48aQbRJKJ
         LGSqJ33HTImw91tvUMm4kItdrWa8+X4bGYD2qGorQdbBH6jG/ZiZV7ZeB3XR/6qQ9M1m
         riGl69wSl2qejFxuVTG+nQEFfG4zqUkKiyB6tti1rgpwS2QVY7I3BTyz54fkwG/I2Guj
         j+Wg==
X-Gm-Message-State: AOAM532ciP4RjXhWv0x+q/E5dvVx+yCZ1hwOwNWelA1U/O6D/NW94IhA
        tk7FUPMmNSH5zU4m3xNPl1MNXb1O7Z3hoia7BYc=
X-Google-Smtp-Source: ABdhPJws4JxyRirp5M/80iKazx6CE8oR47Hg2gS6Eo2+8iQGZAQvhkxve7nzSUax7+WLlSSWi+6dU+0FUtOrWCI0NJ4=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr29226025eji.434.1638597089068;
 Fri, 03 Dec 2021 21:51:29 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzgpm2xrd.fsf@gitster.g> <CABPp-BHq4DnkCZZ+HcnGiZYKHpWJgzMBjMDuWbbTFYPesm2sXA@mail.gmail.com>
 <xmqqa6hhsdee.fsf@gitster.g> <20211204025820.GA17138@neerajsi-x1.localdomain>
In-Reply-To: <20211204025820.GA17138@neerajsi-x1.localdomain>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 3 Dec 2021 21:51:18 -0800
Message-ID: <CABPp-BH8grgsKwPpE+7xMVsW5NAeh40y1fHUKvqRD4ZNa2kX1Q@mail.gmail.com>
Subject: Re: ns/tmp-objdir and ns/remerge-diff
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 6:58 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On Fri, Dec 03, 2021 at 11:21:13AM -0800, Junio C Hamano wrote:
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > ns/tmp-objdir had a re-roll that has not been picked up, at [1] --
> > > perhaps because it's an combination of ns/tmp-objdir and
> > > ns/batched-fsync (it'd be nicer to have those two split).  I gave the
> > > ns/tmp-objdir part another read over and was only able to spot two
> > > small things.  I think you should mark it as expecting a reroll based
> > > on [2] ("Good catch. I'll fix this.") and [3] ("I'll take this
> > > suggestion."), but I think it could be merged to next quickly after
> > > that.
> > >
> > > [1] https://lore.kernel.org/git/pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com/
> > > [2] https://lore.kernel.org/git/CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com/
> > > [3] https://lore.kernel.org/git/CANQDOdd7EHUqD_JBdO9ArpvOQYUnU9GSL6EVR7W7XXgNASZyhQ@mail.gmail.com/
> > >
> > >>  Also ns/remerge-diff that is Neeraj's rebase of the
> > >> remerge-diff topic needs Elijah's Ack at least.
> > >
> > > Mark it as expecting a re-roll; I've been waiting for ns/tmp-objdir to
> > > settle so I can rebase on it.
> >
> > I took a quick look at the rerolled one on list, and I agree that
> > keeping tmp-objdir and batched-fsync as two separate topics makes
> > sense, since the former can graduate much more smoothly and quickly,
> > and it can have other dependant topics.
> >
> > So I'll mark all three (ns/tmp-objdir, ns/batched-fsync and
> > remerge-diff) as "Expecting a reroll".
> >
> > As I announced, I won't be taking any new topics or new rerolls
> > today (or possibly tomorrow) until I can sift the topics I've
> > already seen to come up with a tested set of candidate topics to
> > merge to 'next', so there is no need to rush.
> >
> > Thanks.
>
> I submitted a new PR (with a new mail thread) for ns/tmp-objdir.  Hopefully
> that one can sail in smoothly now.

Thanks for sending that out.  I wasn't cc'ed on them, and I'm dealing
with multi-day delay of git emails that I'm not cc'ed on, but I read
them over on lore.kernel.org/git and those two patches look good and
appear to me to be ready for next.  :-)

> ns/batched-fsync will take a bit more time to settle.  I'm going to post a
> new series called ns/core-fsync, which is focused on the extensible interface
> for syncing parts of the tree.
