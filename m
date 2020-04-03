Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9608C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 06:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95E6206F6
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 06:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlh4bkVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbgDCGBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:01:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42663 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCGBs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 02:01:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id s13so4744662lfb.9
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2GaOMBJzGar6inPYInh2L7i0FgpEEQyjQh0M7MnXYQ=;
        b=dlh4bkVkJ/tMwV2ZTl03I5+uaGvMaw/t1680yvpYvlFdYNI67Cyh1EdHVm3psRI5vy
         vA96otguq5ZT9CE3wNdO3UOxsv8axCbrSExBZMrao9qHa92vUncsUa5F5bj+9qqyUEBQ
         893dDGSskgeFDGedojaEd7jFhMn/LbYz0GrmjaRj6eBDHixzuB3Um3TOfFMMY//tDflJ
         9KXzuj4krBRMQU3YoVDEWvMoRb/LntG0fRu9I5bvjYy1Xv03Iit8RW4A+Fwqy/nYZElY
         sFtrlqdL2kjHZXi+eDAFiXoOEwFxZfZYVU8K7tvrBka4nasyN2jeI8Q1lfWtxtgTNYR3
         rVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2GaOMBJzGar6inPYInh2L7i0FgpEEQyjQh0M7MnXYQ=;
        b=YzlkZx8PVg3hg3Djr+WEBLQaRXkCaeQfYv5HUDwwgTkTblJiG4Cfgiw4gJ9nzobkRR
         wUYZczOPyC2iR/cxhhs7bE8NWdUU2r3rLVdXe5gc74kfPG54oQxJTjHUUdVyp/gD+QsQ
         Gxa3dofSWS2g2qmdDFBIuSKyQ9evrxyVJrAHKk9X6XlWHWL2Q6CQKHzw6Ax3YIs6U8MK
         kk8cOK0qqbWcTD49DD4quKd/oakC1bP8DdP6nAZUZpJVSBAP7Cbcfd7u3+ff7xG8bIUt
         4OLtT6bMhoGqqAJz8rFeKpiXMed/CPwKA98VNcHZk9h/DkdGEXdgIM2HoNbX8GEUcG8S
         J7Vw==
X-Gm-Message-State: AGi0PuZksTY7Brr75OAF39Zj/GGdMo6UGtDsASW1VrsWtnCGusM+t/CX
        C3ke4mroJb/zZR6ASPGayYWYhUKVkzhubicai01A9V0F
X-Google-Smtp-Source: APiQypIwc0QyVc+Y9PcoXi00fLuy8HZAB+SUJ5IxXndt2RIZ3/p3Z5N5Pq5J9QOlfurGjBCg0y3uQ1ecffTe8hMgCuc=
X-Received: by 2002:a19:240a:: with SMTP id k10mr4348939lfk.30.1585893705497;
 Thu, 02 Apr 2020 23:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200402225807.8603-1-shouryashukla.oo@gmail.com> <xmqqo8s91ktt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8s91ktt.fsf@gitster.c.googlers.com>
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
Date:   Fri, 3 Apr 2020 11:31:34 +0530
Message-ID: <CAP6+3T2Kj2tfeaR+xm_B=_oJO8eWLyOjeXLm+8WSRSFSjkpUSQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I apologize. I did not notice that my patch was merged.

Regards,
Shourya Shukla


On Fri, Apr 3, 2020 at 5:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>
> > Subcommands in 'submodule--helper.c' which give a callback to other functions
> > have structures and macros named in the format: 'subcommand_cb' and 'SUBCOMMAND_CB_INIT'
> > respectively.
> >
> > The subcommand 'foreach' did not follow this convention and therefore had the naming of
> > the form: 'struct foreach_cb' and 'CB_FOREACH_INIT'. Rename these to: 'struct foreach_cb'
> > and 'FOREACH_CB_INIT' respectively.
> >
> >
> > Shourya Shukla (1):
> >   submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
> >
> >  builtin/submodule--helper.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Isn't this already in 'master'?
>
