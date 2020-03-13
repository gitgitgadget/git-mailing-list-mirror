Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE71DC10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A140F20716
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib0PkXzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgCMT1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:27:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32848 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMT1a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 15:27:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id r7so10659801oij.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z74Vn2wgsfggvgWy4G86kTfcJzhlk+VmZJTXAbUdLaM=;
        b=ib0PkXzDuASSNDYEzbdwS1Jj8ZSu53O41zdSPoTZQlbJYj/OapPWIcLhpxueXsaN51
         a2LrjulONFme77awn28rpDp2uMPNuS+cLwJV3WdYyf455OeEEAZ0T6b6fhqFrsNsqRbo
         4UCi48iUU1xNbSP/R12hDuBIziHYPgQtubOqSkdXiBFK7XMCMFhk1kXyP0E/dOGMYIBg
         kbF1AQyYp3S5/3b9eeJ66A0zg1yQiPFx8JBMDZxTGR745tkyF/Qjbs293KU3e1cp+UDJ
         FueyldNATvSMJS8AIxVNzAKKgqoNqq9GxpeyWWkB+uYKDkvNy/1+PTpMyJALAwYjcyEg
         Sl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z74Vn2wgsfggvgWy4G86kTfcJzhlk+VmZJTXAbUdLaM=;
        b=s9em6iKqpoSDE+0jGtTo7ALKkDE7uyD11k45J4HC6AfVNovNexWpo12625E3BptY8h
         w397abIXHPLfWqc/2dc2+Z+w5WrEaS3u6UUCzCOpK7rS4eNGd1WZEkvC5kLtZS8ZwaLu
         jzKdgYt92b26GPyofIM/RHaZlTaVGXLv6RlKITYaJX2dhAZsmUmjlHPmfr+t25BsF8zW
         PyY4mb+Od22t0cPNbtmNSw8n+8h3YzL2mdXJhUcxlxO3b6zR4IhlHqEieT+WMcH3HKMn
         WDwG1RdK6wCuJ4fBCaHW90M5q1dN//i/RKFv230ksp8urDUrwej6k1C5YIyuBeGL6ub2
         KUzA==
X-Gm-Message-State: ANhLgQ0V07mpVc2Fhsj01u00fertvY4k84Q7G+vwe7a8PpHPleW6/b5v
        C7/Yiwc9J4RtkUxX3095lWwKsVTv+qEnDXn2SKw=
X-Google-Smtp-Source: ADFU+vtqj4Eonvz+P0p+tw19IgnlVeo3u9xiwEbLVPFQpF59RcP6CTa5GpRhk1eKBmum1ZyQxhj9U3gpkRsuebVjGz0=
X-Received: by 2002:aca:130c:: with SMTP id e12mr7927122oii.6.1584127649503;
 Fri, 13 Mar 2020 12:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.725.git.git.1584125875550.gitgitgadget@gmail.com> <xmqqtv2sawsf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtv2sawsf.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Mar 2020 12:27:18 -0700
Message-ID: <CABPp-BHGsED9noSgAt_OH5G8iXOAvS2cjEV-MDL=hjk365=NdQ@mail.gmail.com>
Subject: Re: [PATCH] t6022, t6046: fix flaky files-are-updated checks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 12:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Several tests wanted to verify that files were actually modified by a
> > merge, which it would do by checking that the mtime was updated.  In
> > order to avoid problems with the merge completing so fast that the mtime
> > at the beginning and end of the operation was the same, these tests
> > would first set the mtime of a file to something "old".  This "old"
> > value was usually determined as current system clock minus one second,
> > truncated to the nearest integer.  Unfortunately, it appears the system
> > clock and filesystem clock are different and comparing across the two
> > runs into race problems resulting in flaky tests.
>
> Good observation (and if we were doing networked filesystems, things
> would be worse).
>
> > So, instead of trying to compare across what are effectively two
> > different clocks, just avoid using the system clock.  Any new updates to
> > files have to give an mtime at least as big as what is already in the
> > file, so define "old" as one second before the mtime found in the file
> > before the merge starts.
>
> Is there a reason why we prefer as small an offset as possible?  I
> am not objecting to the choice of 1 second, but am curious if
> anything bad happens if we used a larger offset, say, 2 hours.

I was thinking about putting in some magic larger number, but was
wondering if I needed to explain it or if people might spend cycles
thinking about the significance of the random number selected.

However, a larger value might be useful in the face of leap seconds
and ntp time updates, so I should probably move that direction.

Any preferences on whether I should I pick something like 3600 (large
but easily recognizable), something more round like 10000, or
something else?
