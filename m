Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2853C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 04:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8935761A40
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 04:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJAEBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 00:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhJAEBn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 00:01:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D14C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 21:00:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l7so6080191edq.3
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 21:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QO0hHoGkh2vTIgrOB61xubNqgjjmptA4cSzgOXZK/II=;
        b=F/ekw9lJ0p/6oTVehPfUHcs3kWOY2qgniz9zeHGvTUuMv9khFO7uqkkZOW+tmj/Dqt
         f4H91S/AAib1Jkvahpz4W0bIpnn+3npVxVklneEukFsvlTEoae72NHQnDceaf5nlUhiO
         GDnG+V8gyV1cKtmmhANU/RuhWvyUNBGMBAjPzGq217CF3N5L8rcwzrArP7O96NRvIWas
         4eNKigdYwX3pha/+VLb6nKJMXi9nkq9X8/howsbHqvkXCKyAp3a+wp3fBH8b1+e2e7j8
         tidsjxaCD2QvTqyIQNinN6s3fc+5fGp3y7WEqNitRjMFh/l7Tx75p+7dG7/I1BmOuDrZ
         FZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QO0hHoGkh2vTIgrOB61xubNqgjjmptA4cSzgOXZK/II=;
        b=BVmtLQIILF/yqSRoDX0vjEszaWQ6NzdiLYuLsItG3dHzNnE8vTHl9FPYOL0zcY5X1h
         NbauIGuO7u1SOm16uKa1qIBGP4EukP8eNgfLnlr4BFGn2gfMAscGqxGIKNWZ2/rmIxhM
         3LOOHAn1OWM8amrQJIhaTvOcWoIdMKHs5sUFIMKaDB+WPU/zQ65/aGTb/06IA+ItOmZW
         VXhUViFVF90/EvW3Ev5PGEc6qMU9x/0WPHqhxK7bdatE2W8FPHARn6uQd3xsXry0YeNQ
         UdYvl3WV0GiwD/IOyf/Dcb2mVthCsXfN3BOFYZqcc+Mjrbp9kbcFDH6RXlOJjbnwvKi4
         keVA==
X-Gm-Message-State: AOAM5325xGtQLfUffZhuSvXEWQ14jBZ1Y6DUcFH5OosGmPi2CrtaEv1w
        NnN9HtdFKYPqkKCYKJL/HGwqRoeXneU/CgoDkP0=
X-Google-Smtp-Source: ABdhPJyq5pA4N1aqPdvkQc2ibkN+foMcXBRD4P3km+t/GkndlHUvHCctKlgZtlGQuppoZzWyblQACyoUO//LONMcMX4=
X-Received: by 2002:aa7:d6c9:: with SMTP id x9mr8592230edr.0.1633060798562;
 Thu, 30 Sep 2021 20:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net> <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
 <YVVmssXlaFM6yD5W@coredump.intra.peff.net> <YVVrY0/kXfWHCWJ1@coredump.intra.peff.net>
 <xmqqbl49bzfy.fsf@gitster.g>
In-Reply-To: <xmqqbl49bzfy.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 20:59:46 -0700
Message-ID: <CABPp-BGgytcH5kBF_xuukz=FfEi0-076AsvCsW=1otycAOMbdQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing primary
 object dirs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 1:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >   - is it possible for the merge code to ever write an object? I kind of
> >     wonder if we'd ever do any cache-able transformations as part of a
> >     content-level merge. I don't think we do now, though.
>
> How is virtual merge base, result of an inner merge that recursively
> merging two merge bases, fed to an outer merge as the ancestor?
> Isn't it written as a tree object by the inner merge as a tree with
> full of blob objects, so the outer merge does not have to treat a
> merge base tree that is virtual any specially from a sole merge
> base?

Yes.  And that's not unique to the inner merges; it also writes new
blob and tree objects for the outer merge, and then passes the
resulting toplevel tree id out as the result.
