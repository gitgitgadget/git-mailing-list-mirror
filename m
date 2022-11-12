Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13077C433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 19:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiKLTJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 14:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLTJT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 14:09:19 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2BEB4
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 11:09:18 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id c129so7898710oia.0
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 11:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1/GDerC7OM4RqEfy1kq3IvVgZCWB27+qTMokfJuo30=;
        b=H5E/Fq0Gm9iDFlUsSFo0oAR4D2beYrVabjFRs8ZNSzhuhWU/b18nlg7jBpG2JKUJXl
         7AYFYThef4MYPbIEpDCPWccTCzZfzEbHz4W7MHJoyyA9TIqkjsCXe2cJj8MnbGuC/JXK
         G60LrN8W4i3TxYUniSiMtdRXsLG4S6lyujv8KUY5x4gib6xOeqKpYBkcj+9c9s1x2TQ2
         WoVVWLLdTY5ZRH2pcqKDjo7NOCi7UxiiyCYDpvJ5mQOe21+ueXGpA95gnUNtu+2ytK6f
         6qicAIZHdB4jbR0zn2xthtTNwV2Wl3h53VimH6givlMnbSupJmmBIyZafe8bZLaTq362
         +oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1/GDerC7OM4RqEfy1kq3IvVgZCWB27+qTMokfJuo30=;
        b=u9gN2uXgeYDv9GxOJkUWAUHISQh/gHXaJFPsATmdDzCijwK16lzaMM9QJRUAskZg1D
         C50/K36cyMaVsf3+TzBrNlE5/gP2zohYcRU05llY7Shvq0nFLSR/KIZEaPdIRchaoWz3
         tq3AdlpS0r0AoYJ95Ud6G1Y7y/SXV4g/b5WHM3HALfJa2qXooKaT6MIdhA8+O/HGEvtD
         iZwMDHF25we3Thtc4zS4cxyfIbRVqjwr95EmuEgoH0cjOV+SsgC+KLfgjc9CEbp01Z4/
         wxMw2pgQPmZH50wbDd3bkj3Qp1/Ly+utkVj7zLv1kCVbIOy3/rc9UlCauq4BXbso2EId
         Ht3g==
X-Gm-Message-State: ANoB5pkljOjYgvodQbuL4rSwwvh07Z2PVTdYV0RxYuiAD92OhzIZgQhG
        xCTPtx2eBZleJ8OH4ZFh8x4cdcRyrMnXF4np/4o5FE+e
X-Google-Smtp-Source: AA0mqf7ABqk36ZBgMzF+JLEnbVBMSBghBaFFsQroSO7HXr5gneeltXlMGOVfOxjUxyPHqoRLAzpYTmks80ZhUVFJz5M=
X-Received: by 2002:a05:6808:8ef:b0:350:ff3d:297d with SMTP id
 d15-20020a05680808ef00b00350ff3d297dmr3108428oic.183.1668280158094; Sat, 12
 Nov 2022 11:09:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1393.git.1666598268697.gitgitgadget@gmail.com>
 <Y1cm2a3qy9aowwNh@coredump.intra.peff.net> <CAGJzqsmH0DpEZDVZYU=6XpBO_vPfbirrK7KaWm2RmKG3aAk0oA@mail.gmail.com>
 <Y2/OIrSz+xrqkd+C@coredump.intra.peff.net>
In-Reply-To: <Y2/OIrSz+xrqkd+C@coredump.intra.peff.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sat, 12 Nov 2022 19:08:42 +0000
Message-ID: <CAGJzqsnd3UbCuj6xfsAgVEFz5OaDBhnCTNeAvOVPK9NWBDnDRA@mail.gmail.com>
Subject: Re: [PATCH] docs: clarify that credential discards unrecognised attributes
To:     Jeff King <peff@peff.net>
Cc:     M Hickford <mirth.hickford@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 12 Nov 2022 at 16:47, Jeff King <peff@peff.net> wrote:
> > > We did discuss patches a long time ago that would let Git carry
> > > arbitrary keys between helpers, even if Git itself didn't understand it.
> > > One of the intended uses was to let helpers talk to each other about
> > > TTLs. So if you had say:
> > >
> > >   [credential]
> > >   helper = generate-some-token
> > >   helper = cache
> > >
> > > where the first helper generates a token, and the second caches it, the
> > > first one could shove a "ttl" or "expiration" key into the protocol,
> > > which the cache could then learn to respect.
> >
>
> What you're doing works fine with the code as-is; you just can't carry
> extra data (like a ttl) between the two.

FWIW I have a draft patch that adds password_expiry_utc and
oauth_refresh_token attributes to credential
https://github.com/gitgitgadget/git/pull/1394 introducing expiry logic
in the credential layer. I'll share a RFC sometime in future.

> I agree for GitHub's tokens that the times involved make auto-expiration
> not that important. The example back in that thread was something more
> time-limited (like minutes or hours). I don't know how often that kind
> of things is in the wild.

GitLab OAuth tokens expire after 2 hours (the refresh tokens are valid
longer). This is a security improvement over long-lived tokens.
