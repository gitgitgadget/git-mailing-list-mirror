Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F4C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 18:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBQS4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 13:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQS4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 13:56:30 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5F0DBD3
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 10:56:29 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17172b43531so2254950fac.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 10:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZJIE6B/lvIYdIZYuklwP+Ddnogl2YjLxhl+IqXYJr4=;
        b=REycGHYBFgAMkABV4ZBYEOt1/9q1LgBNXcfNL8/MpMC2baEEEZcRFl1GWImfoU2DJw
         kaGSTYViu7m+LEyM227OmJ/B2i/er6/lOlbqYAwim6wtToJex3WeKF8smxOcH1VnTWdT
         +PzJxMpXqhmkdWId9b0LnbCIDoUCf/o8YYKUfehMPe9SEgTGS8eSoT7TZ3CbNg5eeiCQ
         VnvosBbloj6aMlIi4ofGA0vsxU8y15mVaHmoLikZgB/MhE9Gh0HYxSNWmhcpCIvfVVOZ
         z7cg0Bx6J+oaqSusPkRqQt98w7iQAxwp3PgximygSuSjZErQAcnKAjKh6m9Y+xiK7iaa
         KuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZJIE6B/lvIYdIZYuklwP+Ddnogl2YjLxhl+IqXYJr4=;
        b=hArTixnZ8IymRRNOHwnqM6P2A2GT908sIcqT2AxNXn0AUGg920yGRbS77qVwHYA6Dl
         i9YrWMvlTN13xcy0d8B6AgJ7pWi1zmCuxYmR7cFbfUw6fVhqi9Vz/S+oqoYLOdJEcubY
         aKco3duXzclRdhiyNGn+i55QuSmFTyxFb1xXA3QGFBlldXdIGNcgTuzPg/ZRpGtat5rB
         AqaLGYrS7pIRP72mIRVow07B2NPwZeANnP01Q43Nlyi2IPaguXJPrSfwPkqkMCSe/Zhl
         cZSdNx7FvxTgXoeydLH9IH66FwyOujFQMviL/6Ehu2CttyQTqVsXy4oHTYSn7p3xVoGG
         Yg3g==
X-Gm-Message-State: AO0yUKVTHXAGVmOKslu1IoFv26OLeFvXSvrVY0O4BR7ETltMG0twPuyb
        FsOuhPT9+2G0yLRTI4mHkuu0N2PVJnvptYn136c=
X-Google-Smtp-Source: AK7set9kfpQA4919Li+QLfuXbV+2m5/MKkbIsZ+bILgB6o5Fd+4YRHph0ysz8e2lAYSXpBJz735FTnalCKYsLrLAa78=
X-Received: by 2002:a05:6870:9f84:b0:16e:902e:39df with SMTP id
 xm4-20020a0568709f8400b0016e902e39dfmr466485oab.154.1676660188332; Fri, 17
 Feb 2023 10:56:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com> <CAPMMpoj0Ts=c=Wq1eghjJ75HVyy5ZyKjL3o9=AB8SDb5Wf99mw@mail.gmail.com>
In-Reply-To: <CAPMMpoj0Ts=c=Wq1eghjJ75HVyy5ZyKjL3o9=AB8SDb5Wf99mw@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 17 Feb 2023 11:56:16 -0700
Message-ID: <CAMMLpeSGzuVEwvwP8ySUyo0FBcanUjm2psU_+adh_dHTM8vP9Q@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 4:15 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Fri, Feb 17, 2023 at 4:15 AM Alex Henrie <alexhenrie24@gmail.com> wrote:
> >
> > I would be OK with the proposed patch if it were part
> > of a larger effort to make --rebase-merges the default behavior of
> > `git rebase`.
>
> Heh, what would it take to convince you there is such an effort? :)

Doing steps 1-3 :)

> > 4. Change the `git pull` advice to recommend --rebase=merges and
> > pull.rebase=merges.
>
> I'm not sure why this would be step 4 - I would (and did try to) make
> it step 1 :)

The unintuitive syntax --rebase=merges makes a little more sense if
there is a warning in `git rebase` about it being a temporary
necessity to support a planned behavior change, and we're explicitly
committing to not expect users to use that syntax forever. It might be
a good idea to add a similar note to the `git pull` warning too.

-Alex
