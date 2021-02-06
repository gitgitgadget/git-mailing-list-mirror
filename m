Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5F1C433E6
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 05:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6D264FCA
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 05:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBFFhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 00:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhBFFho (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 00:37:44 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97547C06174A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 21:37:04 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n7so9847891oic.11
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 21:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNrMFBR2Zq8sfb3i9RCzkd0oh7QiGLSkQHRl2+UsLFU=;
        b=CPS0hoHdcNSBX6HJD3WveF75Xq2M2C04vFaMCDu5gpS5Rf8XZtl2E9gNQGb4KVXTpW
         04HZZ0hlK2q1CoK7+h9eNYShsbHE/zdGrzP4zpFhcdQs7lyRnOqT1TA7i3ZhJ3pC/yoR
         SJPq56whaEbAK7vlUGlND22QNvQjGSt8PoWq8FH7KJymwpv1DzPgX35rrEJKQT5SHuG2
         iPkY9TwweqBBwSvA/jPzJcPjkHz4CtNi3co+LFYwr1VPZGnCWtxA/WIilHzmF0W1vv+9
         +u0nZ+CB8UISFNtZTKYsl6E0q1K7GzoTK+0NFvu5lnn9uXC6EltRY3FwlRgT6xryNMc2
         991Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNrMFBR2Zq8sfb3i9RCzkd0oh7QiGLSkQHRl2+UsLFU=;
        b=a8/xliqs3fxYUOWAfIAM2J3QBi6+lOVPR0b8b80BO8bs3g02u6BNmmG55BE3Q9CsuS
         Qh5s8+KaJfKeugjcgZONgmpntOkoIDEOBQCQCz/6bIpROS+qf5boyt3R/2JzCuUeKjra
         ycs6hhVfopMYOoToUj+usFCrw+OEw99scnzy5MU/IIyeisR8q8WY0lEtg1gCjcwb74yH
         aYWeP7B7tvytOiMfHZAESfgYDQU3O+sJ7SHH6MY9bavBbu1EPKVvlVxUlo/4FrkJTD5W
         x8zlPaENm3NabQm0I8HJwyXr4ukj4xVDPY8F/yfjwV215kj32A5ShKfBNDl3YDbXPZZI
         T/PA==
X-Gm-Message-State: AOAM530KjhvHsRGs8+ICPhOGSZ0O+zPG0R0kln8xkpKTB/A5zkckiPYO
        tZvi9kSGDWM561ImdQlepvR7nLyiQr7x2fPgQL0=
X-Google-Smtp-Source: ABdhPJwOndweSPobEOSYpIveZDoVjwh/6dFE2effZlM2mGvbZJqgJ99MaWz38ew9wGsw6TvBTvcMvD+78+8YlQ1tFM8=
X-Received: by 2002:a05:6808:c:: with SMTP id u12mr5005906oic.163.1612589823983;
 Fri, 05 Feb 2021 21:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20210129182050.26143-1-charvi077@gmail.com> <20210204190507.26487-1-charvi077@gmail.com>
 <CAPig+cTj5erQ6GoikwU7aeJTH0+QCC2SqkSuZ_T=n0LVxf1pBQ@mail.gmail.com>
 <CAPSFM5f0Jk03tWCTerZP1JhcMHG4MXjVSZjPKm2uzQYc+cOwsw@mail.gmail.com>
 <CAP8UFD0VpgT=mTydWQRmqo9TFQvdfDiXuA1TcwAqG1BtXXdKxA@mail.gmail.com> <CAPig+cR44eisWjbcsSiTyHqVKeqPKXMnc=-9BEjK5MFxPUBFkQ@mail.gmail.com>
In-Reply-To: <CAPig+cR44eisWjbcsSiTyHqVKeqPKXMnc=-9BEjK5MFxPUBFkQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 6 Feb 2021 11:06:52 +0530
Message-ID: <CAPSFM5fbryEsikVNzuYOtnrhXEyNMfx5HH8rGGYjXDS8jAVipw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8][Outreachy] rebase -i: add options to fixup command
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 6 Feb 2021 at 00:27, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Feb 5, 2021 at 1:25 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Fri, Feb 5, 2021 at 10:42 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > > On Fri, 5 Feb 2021 at 13:00, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > > These changes are still worthwhile and can easily be done
> > > > incrementally atop what is already in next, I would think.
> > >
> > > I agree, these fixes are required. So, I am not sure but now to do these
> > > fixup shall I send another patch cleaning this patch series(v4) and rebase the
> > > patch on the 'next' branch ? Is it the right way ?
> >
> > Yeah, I think you can send each of the above 3 changes in a different
> > patch on top of the 'next' branch. That would create a new 3 patch
> > long series, which you should give a new name and not consider v5 of
> > the previous patch series.
>
> Yes, whatever issues from my reviews seem worth fixing atop the
> existing v4 can be included in this new patch series. (I think there
> may have been a few things beyond the three listed in the v5 cover
> letter, but I didn't bother doing a full audit of my review emails, so
> I could be wrong.) As Christian said, just make it a new series,
> though be sure to build it atop your v4 rather than building it atop
> "next". (The problem with building atop "next" is that your series
> then gets held hostage by _every_ series already in "next", which
> makes it nearly impossible for your series to graduate to "master"
> since it can't graduate until every other existing series in "next"
> graduates to "master".) The one other important thing is to mention in
> the cover letter that your new series is built atop "cm/rebase-i",
> which lets Junio know where to place the new series when he picks it
> up (and also lets reviewers know where to apply it if they want to
> test it themselves).

Got it, Thanks !
