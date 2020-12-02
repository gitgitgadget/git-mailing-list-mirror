Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A418C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 05:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C302222A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 05:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgLBFFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 00:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgLBFFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 00:05:34 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74539C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 21:04:54 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so1151012wrx.5
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 21:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1R6m2RBXWligHxBU8le1aPAFSfksXWT5XR07HFq+BM=;
        b=QYgZCGKluAB20OzEW57gsKE6br+ZIBhkgeiET386ZqYuje+ZRZb15NwrAAdJIM97ug
         MHNqdWdHsgOuHBMhRfrsVWrC1ZFl3CZ22xgOSaRMaC8DYggWjdI3eptPElpOxiu1JO0L
         p12GCli4ypcQenmEmIftLI6/pLWhfbH1q1UJRVmJjCy6wKtNqMHsIzBH9biQwa/r5aSx
         9K7YhSDuK2SmVrjhKODuPC4i/U+8bYhnP8EJ8/Z/3lofD/k4SMSKltg2NYC49XcniKBR
         +kOUbEp8RTaLC9rKKziJjc1QYeHUNGCFtU60LVyoE9wtb9bzsPeFvRD8hO+n4HkzCW7p
         vsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1R6m2RBXWligHxBU8le1aPAFSfksXWT5XR07HFq+BM=;
        b=FQsqXdjJXPrLkONBdWkuz2fEzfJvjrI325JrG+3nQ0y5JZ4vSLCe0PtcLOYo8KgZbt
         ITkmH2be7J+UyyiFAFfYp5RGW7rn8RJBX0vv7i4bgTHM5HOU8E+WPNueCxoaKQ80ndCx
         9KlttyOfZfTOspOZk3MDiXHFHTQxlAMSzEYD58XbWellqisiiqbzy/oN1cih5QBk6vRv
         HHaHaTiSVLdYCHc22SpCqWKXHC+G3uUuQLttlGbnStfZ/bJYSETn0K4+ek18E0xFdy90
         6mWTb/RXpkrYZfE6DkMyFKijhljLZ2aBcwhTRAPujU9xxnUbWq6KIBzn9nlMwoqACDId
         tkNQ==
X-Gm-Message-State: AOAM533r8KRADvOWl2P+SvC0RHeNvLEpIJqfvD6JwphUK+n8toHoHyo4
        hbg5ERF0JajF5AgzzL/V9HvUeNwXE2ojlUTf96k=
X-Google-Smtp-Source: ABdhPJxPxdhqJfTKA7XD0m6kSAwkwwSHbLR1YDmMuonWYds0ASuvS+PoFTVSFaZGxW8qgLXMRaZNFwvFduNmBrzi0cg=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr952492wrs.100.1606885493186;
 Tue, 01 Dec 2020 21:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
 <20201125032938.786393-9-felipe.contreras@gmail.com> <a3be85cd-a01a-4ed9-bf98-09785e79fb85@iee.email>
In-Reply-To: <a3be85cd-a01a-4ed9-bf98-09785e79fb85@iee.email>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 23:04:42 -0600
Message-ID: <CAMP44s0VuP+GkrcyNtQnTerZOiMm4f1qSzuizHgsMddHqOvjXg@mail.gmail.com>
Subject: Re: [PATCH v8 08/10] pull: add pull.mode
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git <git@vger.kernel.org>, Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 6:31 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> Accidental repetition of phrasing from branch.<name>.pullmode ?
>
> On 25/11/2020 03:29, Felipe Contreras wrote:
> > +pull.mode::
> > +     When "git pull" is run, this determines if it would either merge or
> > +     rebase the fetched branch. The possible values are 'merge',
> > +     and 'rebase'. See "branch.<name>.pullmode" for doing
> > +     this in a non branch-specific manner.
> > +
> s/non//
>
> Same problem in 09/10 I think.
> I didn't check the code... Spotted while browsing.

Weird. I could swear I copied the text from pull.rebase. Anyway, now I
did: "see branch.<name>.pullmode" for setting this on a per-branch
basis."

-- 
Felipe Contreras
