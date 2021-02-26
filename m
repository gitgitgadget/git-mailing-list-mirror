Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A44C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 21:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F394D60241
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 21:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBZV3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 16:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZV3S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 16:29:18 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1009C061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 13:28:37 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 21so1592961oiq.7
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 13:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e255+HnPKFs1AjDVLc3zUr4iBNiIXAAkNDGPgn3RHTU=;
        b=dyGTZIbwauYzhmlmJm18heb2ptVYhGoV3DAiaxRoqDE8D6PIXwg+hrgatMAwmOsMwG
         woJYC0qXznjO2EgXNMN3r2m61e0kZCEAPiukxiFG2R2EXPVpYpX27QGpEcYZTjtP6g7U
         ASbO2/w0NRoNLprz/xf9xF3n5ARS1UPgVYP/tfnyIKIjdzYUkCBSk/QvkC9FfiQf+mZB
         KUxtnWNmb8BzOVRFAGlbmF7niAIU3hKhzzMLC8MmeLmcmsfyuMb56fpNFF7FOAKkO2rW
         XhxE7nPe1kB1CDeNINpQUheWuEKdl2do31xwB24dPywT3WEXG7/20NXQMMtOSeiJU4JZ
         Y/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e255+HnPKFs1AjDVLc3zUr4iBNiIXAAkNDGPgn3RHTU=;
        b=JTg/mMp0UQom+sV+R06k28Oa1R8hv5vLZG4M6AtvqObEJciAT8Kcs+qwKwoLo2dMds
         k4WP1Tb7lM0lOjYTL58GtH8V0ht9VFl+C6OMHYHOlHD2ccMzQWSa8YgCsP3uFIN08lWc
         +Sm6dxV0prVnSETP56ECS6dP0jDUhM/lwIBW0wKuCqHQy0P+Q3P/CKo5LNEO2U1dxLVK
         W/DL9cG3R7/o2X6WtyM2Hng0mGEMyzDDH/PJFJDIc4u5T0NBjLZfGmdzn5oH8bMkYVwk
         2V5GKTCGccEKY31BZsAxm3Q0TvAcTzQuJu+7w6NEXF5o1iFnQgADguGXY/EBX0akgxJ6
         SvZw==
X-Gm-Message-State: AOAM533C+bRjmq/HjRg+um4C9srFrw2JJRPN/j8dHbe8Vz6RmsgIKh17
        2qwajJWbKC7nQQ9zK0S3uBiSAGKjmwYPSoI+fvA=
X-Google-Smtp-Source: ABdhPJzIkWXqNEMWr1/++KDBrEPW3PRExd1vyyuAliuNZrio2qEDoT/0tkATsbrqlbpSwQ7387Y75ldLsZiiaJ7fGLs=
X-Received: by 2002:aca:3181:: with SMTP id x123mr2406803oix.167.1614374917464;
 Fri, 26 Feb 2021 13:28:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <CABPp-BEf5F_BT69_V0vOq9CdcNEce6qR5nk+2XZsdS5EeLV0_g@mail.gmail.com>
In-Reply-To: <CABPp-BEf5F_BT69_V0vOq9CdcNEce6qR5nk+2XZsdS5EeLV0_g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Feb 2021 13:28:26 -0800
Message-ID: <CABPp-BG+gK=Opmjhg-X2GEkvWt9C62hjiESjX=YwDXp=_x1yzg@mail.gmail.com>
Subject: Re: [PATCH 00/20] Sparse Index: Design, Format, Tests
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 3:49 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > Here is the first full patch series submission coming out of the
> > sparse-index RFC [1].
>
> Wahoo!  I'll be reading these over the next few days.

I finally finished the last five patches today, and didn't spot
anything on those to comment on.

Overall, I find the series well constructed, motivated, and explained.
I've left various comments on individual patches, but they're mostly
all minor things that should be easy to cleanup and/or just comment
on.
