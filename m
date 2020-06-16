Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C49C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 20:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DA3207DD
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 20:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjJ/jBQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFPUwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgFPUwP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 16:52:15 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07235C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 13:52:15 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id t132so107786vst.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=N7cqssHNa3q0ZX0Rdfwcs5xUsVQ7morXJV8i1yaAJJc=;
        b=LjJ/jBQ/T6auhN46Qqb1dAPDtIWIt5BfeXOzGTFBBdqfFUJH8dv8xm/QxUn9wFZoBX
         PNtZwe+wmWeH2KxOw3kBsieLPscX/EUVEiWsi2k7E4tKZQmfcqKGAL+Rboqz4w7/8dUd
         oqh+pxLpVMMt7yBwRtPOAOZV2cldAPGV3A4L1rLP/paEBDlp57EB0yShcsdhMXinlSZZ
         SOGauI+eRY4Yo4sLzqT/dfxKW4HOcZ7iY/an6tIDfsFs7C2aSBV3C/I0M5/FeFUWGm0G
         EDUJNM0IOmn/8lWeSa/GE1r0EFxLNqxgETei/5JGnzTLewWLjTzU0ZeyDyvGDUpUDfrJ
         M3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=N7cqssHNa3q0ZX0Rdfwcs5xUsVQ7morXJV8i1yaAJJc=;
        b=Y/gOa36a5HmspdjgreS6bPk14W3ROKoFEw1TpqNy6ypE7Q9ix7OHOPMUi5wpmFeBSl
         xfzAJCHEjOwD12R8IDkv9Vtzx57g/WiKRsmtiySIn3b97QxwbvZ3BO04TNyCtsLZ/o3u
         zbnhvVJl4Zeihoq3ZEt0EjpWWpW/2TqPaTfM94AGGp2UI2YlLE9evpKLM7ohjIhchOsc
         vQvoSRRgRX/D01L5kMCZ8JbK4JGB+pDs0PwA9F00Ygo5JDV5SZnWnKEKhCC9dGUuwfE5
         7qxgXllrDx9QahuhGfc/TSN8P9CpMJLeNGA1K9lDTOZlPPtFlw80q386ohNGLIL2s/ku
         cGzg==
X-Gm-Message-State: AOAM530xCLLI2ZIQQRNCQMtB2TU9U6M1H0FJTphvFulQdmo19iNme4Nz
        dShOBupRO3SviY34f5GP0yYdsJf2VT+m503BrTriQQwDjm8=
X-Google-Smtp-Source: ABdhPJx/+aVUo/iuHiwT7kwW4uiVuejU9LOTMEgjhkbm7s3XoTm/lbE0FpuOW3SUnxHNXa4eGEc63N+8zQmfWLzah+k=
X-Received: by 2002:a67:b647:: with SMTP id e7mr3211101vsm.63.1592340733246;
 Tue, 16 Jun 2020 13:52:13 -0700 (PDT)
MIME-Version: 1.0
From:   Kaue Doretto Grecchi <kauedg@gmail.com>
Date:   Tue, 16 Jun 2020 17:52:02 -0300
Message-ID: <CAMWmj-xR7f_F5HMuEDyn2L0N7pdBWmyzin6Yk=D048H7TDXEPg@mail.gmail.com>
Subject: Re: git-for-windows supporting public shaming and repressing
 community's opinion
To:     kauedg@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It does avoid being directly disrespectful and thus might not technically violate the code of conduct

The repo's code of conduct (Contributor Covenant Code of Conduct) states that:

> Examples of unacceptable behavior by participants include:
> [...]
> Trolling, insulting/derogatory comments, and personal or political attacks
> Public or private harassment

So it does violate the CoC and should have been removed like other
comments. But it was not only kept there, it was not disputed by the
admins even after they deleted 4 other messages following his. I
personally think it says something about their bias and this should be
addressed, even if we don't consider the issue's motivations.

> Just my own guess here, but I think calling others' arguments "dull
> and kind of childish" is not civil or respectful, and thus that you
> missed the reasons for your being blocked.

Stating that *an argument* is "dull and kind of childish" does not
mean I think the same about who wrote it. I was making arguments, the
user stated that *I* would be wary of using the word "cock" in one of
my projects' name as if I was not mature enough. It's a personal,
disrespectful statement that tried to insult and shame me as immature.
From my point of view I was blocking for defending myself while trying
to address the issue's reasoning.

But for the sake of arguing, let's say I did deserve the block. Why
was it made *after* a whole lot of other commentaries and negative
votes on the proposal rather than at the moment it was made? Because
the block has nothing to do with the comment itself nor a will to
enforce the CoC.
