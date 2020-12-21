Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC409C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E7920799
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgLUWQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 17:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUWQe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 17:16:34 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E95C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 14:15:54 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q5so10256195ilc.10
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 14:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6I+zpzZ+0REDIPwVZS1rPOTIZmDoBekcgtBeF/dYow=;
        b=CUw5fShfzD8YaXa4IYWGrPgOo1UC/M7dzIkeaszP7rtENbxkQtvrf1BEYTiqA3UuaM
         ExeQZEIsebwPHqvOAa+ZV6P4iOYXEdirSWUbfqCIQ85idjIIkC1kdbZ7IwUck9LB3cmp
         8bCJdNN00Bef4NGmoyX/pBGGww9sHuSbRbxVvaoPPSr9mpG5NeSHPD8DS6xPXc0Oy8D7
         TtrV6/HsOjn2bqUCD7tfm4Iopfq5I30TZHK9wedRa9J4xE3CB2PO9N3ru3uLdgb+zrgq
         aO0X6ctyFpJhtWaDFmbg8r2+sVGvqGkzcAAEd89oMB3BRL0ga+EQ19IfjzXdJ4hV+C2v
         wLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6I+zpzZ+0REDIPwVZS1rPOTIZmDoBekcgtBeF/dYow=;
        b=hSyWfG2OCxGxh6okclBZRSVtaJOYtfpXCl4yKSfjEzdGsFhc8DrC8O+nzO9rj++3ep
         j+vWPOHVRHS4L3dUj727k0zr4PsGOiZ6m9+Qa8som2YGh1L70Z5fFpUcCmATZsuwS+Mo
         /FmlAa1rebaL1ebD6AjWb+OyWkytOv0TZuTOGTiV/rp0wh0dPjhlXuU9sccz5mKUaP1Z
         aU1TJs7tZWPW1lFxmS3R9fh9GpBuY98vlh7ewsfbpf4L732GEZVjT43wwWW4fGGOyU5h
         r1e2RmvVswLEQvoRxqyikh0iPWZdMkLMMGxY+QqRFA7SejyjVgc+S5dOaG7bWo6biIeT
         AFqA==
X-Gm-Message-State: AOAM530Jk1Z2rfrlCtf+ogEekCrCjjH37B91RjY3mdRhki3KaZkh8PGK
        ktqqMj/OurJA/mr1ogc5/tfQXXMxdVhAO54UEUYwU+WB
X-Google-Smtp-Source: ABdhPJx6Y8QffwlS0NM43vFS7tRi2y3r30ksKc/g9LKyIdFbDzU4NMJz6/A8dnlM+4dJcM11C/zM6KgPzGF2jOIDOg4=
X-Received: by 2002:a92:9ada:: with SMTP id c87mr18534831ill.5.1608588953269;
 Mon, 21 Dec 2020 14:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20201217175037.GA80608@ellen> <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen> <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen> <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen> <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen> <5fe033e0ec278_96932089d@natae.notmuch> <20201221073633.GA157132@ellen>
In-Reply-To: <20201221073633.GA157132@ellen>
From:   David Aguilar <davvid@gmail.com>
Date:   Mon, 21 Dec 2020 14:15:17 -0800
Message-ID: <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
To:     Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 20, 2020 at 11:36 PM Seth House <seth@eseth.com> wrote:
>
> On Sun, Dec 20, 2020 at 11:34:24PM -0600, Felipe Contreras wrote:
> > I disagree. It's fine if you don't want to participate, but the fact
> > remains that the position that some tools would want to turn this off
> > hasn't been properly defended.
>
> If you are _genuinely_ interested in the answer to this question, please
> read the section in my post titled "Conflict Resolution" followed by the
> sub-section "Custom Merge Algorithm", and finally "Merge algorithms" [1]
> on Wikipedia. Then pretend you want to write your own conflict
> resolution algorithm for a new mergetool you've been dreaming up and ask
> yourself what versions of the conflicted file your tool will need.
>
> [1] https://en.wikipedia.org/wiki/Merge_(version_control)#Merge_algorithms
>
> Right now the algorithm Git uses is pretty best-in-class so it might
> seem unlikely that someone would want to write one of those. However
> a whopping *seven* of the tools surveyed do just that. Some of them even
> do a pretty good job (I've tried to point those out in the reviews).
> You're preoccupied with identifying a specific "adverse effect" but this
> debate isn't about that -- it's about giving individual tools the option
> to choose how they are used. If people out there want to try and write
> a better algorithm than Git, I want to see them try.
>
> That's the point I've been trying to drive home and that's the point
> that David also made in his last reply to you.
>
> On that note: you replied to David and said:
>
> > [Y]ou spend your time implementing this on top of my patch. That way
> > it's clear who made the mistake.
>
> I plan to start work on exactly that tomorrow. You made the initial
> patch so if you'd prefer to take it over the finish line yourself I'll
> defer. But if you're not interested then I would be happy to credit you
> and finish it.

Thanks Seth, I think your plan of action sounds pretty solid to me.

I'll be happy to review your patch.  Just a heads-up that Felipe has a
history on this list of creating long, never-ending, pointless rant
threads so sometimes the best course of action is to ignore him.

ciao,
David
