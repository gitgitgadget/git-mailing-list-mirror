Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D61C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B846214D8
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Khsp+HGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgJNTlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgJNTlN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 15:41:13 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA34C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:41:13 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n61so730397ota.10
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FRI8J4Sl9JnPg6tT/u+w1UfhWJCRqM1ERVkQd0LXDQ=;
        b=Khsp+HGyZwcGMo5OIuPzlP5GZhChBPMu+Iq2odZrCyvFTkuXXZVg8Y74tY74POwgrp
         XMJB+ZwedSJq53XcwQzaZbeDHOx+yVzB6q8fhYnx6sc45LMZKewObRDy8iR9KNzvp3wV
         jTtLSe82GxQJAyoueuDYwZPVoAKaaGxA0W2kFA/Hd5qn2N/9mj8ZcaKU94qSyrBfcyfM
         fdz8IxnoIChrwuKJb690SMCbOlTko6TcEXpZ1rDse5p+pdgg7LhGtNdyMKsx/NrDj/W8
         KWj76DKrLX07tco4+hlFAun8EK+1LrwKp5aa4EgOajUx8ALqyMV6uH3zZ1CNMToTt/ns
         IyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FRI8J4Sl9JnPg6tT/u+w1UfhWJCRqM1ERVkQd0LXDQ=;
        b=Cme+BMAH/BjdwSsLKuEHC1O1HPNhv9kV+sa9Ial0Ae929IcyfYYHNo+YbaCOTAnwH6
         RnE0vDbixGwCtDzjn6rsSfaA5I+84DU3vaCPpcjMkYZyN0n8AcJkQxntdII7pZWNSt+H
         ciX3kU7jBku5msduRPhXjDgmW29JT1epxb30UszmZxVtE5S+Vm2N6xIQpmS/VVEeqF1w
         cE8sR6X7qTGRkXsgUmPhEey5nzWTfxngkelGA7ZMT9f0sc+WZN94AbhQ4A06y+lzyDiv
         l2kd5AO3Iq9//nJrW0/4lvBNzw+qh+Xd9EqNuTsks/qSYsV591VbQTyRlnKHLY+6bo26
         D4Rw==
X-Gm-Message-State: AOAM531TCeCcqcs5RolInY5on/t6Hs+KqZliG1lQSJ7H7a5Yc+KRyC1k
        j3dSov1tXF1nHA72jWMt6y8OMOS1dvj4UZVEedc=
X-Google-Smtp-Source: ABdhPJx3hrIM/Ym00fl7zRQ2vcEXAOz/hj3whoL2uWW8einIBhYhts7gQqt+QtXVHvplRRh1ayaPUVZHbCn7cqb/iQI=
X-Received: by 2002:a05:6830:30ac:: with SMTP id g12mr224488ots.162.1602704472072;
 Wed, 14 Oct 2020 12:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com> <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net> <CAPc5daVa4j5mDvTzCFCX2bLr1qVFLO=P=nSakT+mDG1kqeXa+g@mail.gmail.com>
 <20201014180707.GB24279@coredump.intra.peff.net> <CAPc5daU_aw=yWPKHG1XGt4X5A1AkEXeLfCmHqqVfZ+FzBD7nxg@mail.gmail.com>
In-Reply-To: <CAPc5daU_aw=yWPKHG1XGt4X5A1AkEXeLfCmHqqVfZ+FzBD7nxg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Oct 2020 12:41:00 -0700
Message-ID: <CABPp-BE0_u=TAJKUGUTLrZbg8vk2MFYmfscT_+MgYwAS2rV8Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by substring/regex
 with --run
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 12:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> > > If you define the pattern is not regexp but is glob, you can use
> > > case/esac to do this without any forking.
> >
> > Yes, that would probably be OK for most purposes, though I admit my real
> > love for regex support is the ability to use "." instead of space to
> > avoid quoting arguments. ;)
>
> I use "?" for the same purpose for globs. For things that are casual,
> I find that
> it tends to make the end-user (read: my) experience simpler to use globs than
> to use regexp, largely for your ".*" vs "*" reasons.

Oh, I thought you were arguing for globs over regexes here just due to
performance reasons.  Most of my uses of this feature so far are just
substring matches, so either globs or regexes would be fine for what
I've done so far.  Mostly, I was leaning towards regexes because I
figured they were a bit more flexible and perhaps there might arise a
usecase where that would be handy (plus Peff seemed to like them).
But if you find the normal usecase easier with globs, maybe I should
let you and Peff argue it out and then I'll resubmit with the
preferred solution?
