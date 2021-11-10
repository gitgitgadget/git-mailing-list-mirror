Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1320C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5BD61027
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhKJJSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhKJJSw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 04:18:52 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB38FC061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 01:16:04 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id b17so3501756uas.0
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 01:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXJilEd6NeUHyktNfqm/srz3BwdVlJP5j/8LVFcm7Xk=;
        b=kWW1zf9ZKPgnLafEtscHgtV569+G1wyDrR25hwVy9RYtdfmiNMlf/LfBdgqUr5Awwa
         /a60PygkVca8QmEhlm4hoaZkAFqj00F4kd4yGx/RKqsc9SuinsN9XxyE+2x8uSQB9mop
         vPDiFyrb4bdVwqTQo3Uw8PMnefmidBKSYov7NtEojCkgqA+V5YVruHpHCCE64mHIACcV
         xSu2DQpwrDVb8SkLSbY7BJc5JGijlsDBA/GiFfsuKKFcUDI4+xsF8PigWrrg37PfG91l
         FG5zHbYWd41haT2YaTGKEq6+XhVupVo4p4BkrqXrFgoQhjl/S+g1tkgwlGxjezy7sNgC
         mcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXJilEd6NeUHyktNfqm/srz3BwdVlJP5j/8LVFcm7Xk=;
        b=k0G52VZe718GP7F4zcGdEHJDGf+BDOTIoDoTA/jSsk+p/AJfGb3NoY4F6Mu3Nvkjoc
         wCeWtavCymFrxnFWZJUqrq4o4451/YLs8ijGQGoul1dnNlEsx+G5TanF0Ye6dPwY5Zcb
         XBLwVWtv9RFHTz8VKJTkfroKK42Jsq2IT82CWkXDtQbfNwKLN/TKTUhmGvjWAOaEoUEs
         HEX5qbXD0TvcsmnuyyH0WuTCjpXHWax9GzhtAU1Qik0DXkXPdJVdhSaNYOBPrE/Z9CwQ
         yRQ0FEJz1+X/WU6FV3GV5EOQWUGUmilVPGeN+V2GwJbvmTEw8H4EUHq5VCTdux09U3Ue
         l+Jg==
X-Gm-Message-State: AOAM531Jnyf+ZfsTk7351zDqGe5jbaFNO1dHLXlq+wx0XyztBir2ApuH
        nBGJPTZ2W/tl0hWnv4c6xB+2rWleEtUf7WHBB8E=
X-Google-Smtp-Source: ABdhPJzoNztxHqaonQueQilHTaHdEzVT+zIJWebIdaiLmU9eQLNAnGZBev8vLCZPvByYt9vKeT3u8rSayCjuJl/+FcI=
X-Received: by 2002:ab0:5928:: with SMTP id n37mr20042918uad.15.1636535763895;
 Wed, 10 Nov 2021 01:16:03 -0800 (PST)
MIME-Version: 1.0
References: <xmqq4k8kzuz2.fsf@gitster.g> <YYtbdkLsCSFFE5io@coredump.intra.peff.net>
 <YYtgD8VT/0vuIHRX@coredump.intra.peff.net> <CAPUEspg+NDJFAVcFs2hhcSTORb0Q-Gjcv0M+5tzqXJuBTvbT+Q@mail.gmail.com>
 <YYuBQ2mUCeEmYoLR@coredump.intra.peff.net>
In-Reply-To: <YYuBQ2mUCeEmYoLR@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 10 Nov 2021 01:15:52 -0800
Message-ID: <CAPUEspjzs0ZvDGUwp=XYxdHb_t+1yx0C1epaNhhiAn6SsPeidQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 12:22 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Nov 10, 2021 at 12:11:12AM -0800, Carlo Arenas wrote:
>
> > On Tue, Nov 9, 2021 at 10:02 PM Jeff King <peff@peff.net> wrote:
> >
> > >   - we're not really testing the desired behavior, just looking for a
> > >     known-problem. The segfault may get fixed but we'd still have other
> > >     bugs.
> >
> > This openssh bug was fixed in 8.8 per the release notes; indeed the
> > fix[1] (which was misapplied but fixed next commit) looks familiar and
> > it is just a straight up crasher, hence unlikely to cause other
> > issues.
>
> Ah, thanks for digging. I agree that this is a small isolated bug, so
> the prereq check I showed would be a good test for it.
>
> IMHO it's worth doing. It looks like 8.7 is the only affected openssh
> version, but it is likely to cause confusion right when we release.

It was discussed[1] before, and I think the plan was to at least
mention the brokenness with 8.7 in the release notes, but guess I
dropped the ball by not raising it earlier.

Carlo

[1] https://lore.kernel.org/git/CAPUEspgnRFNRoFuEvP1hpY3iKukk3OnF4zk85wkdkmiVuPuRTw@mail.gmail.com/
