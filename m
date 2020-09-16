Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C02AC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 08:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC7C20872
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 08:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgPQewiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIPIpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPIpU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 04:45:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BDEC06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 01:45:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i22so9180747eja.5
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFwnz8My2aB1yFy0zWt3Sr/GKwI6p39MzB5DMH+JhAA=;
        b=IgPQewiu7EpZMngg90HQd1A9ozIcMVDA9FNfWUCbzYvdzPJouPDpo2oYf7FeN6ubpR
         SFUSAHMpvqH1GLcTxplkVLNYhHJjSSi6F/sBwVz+AO4G0LC0o7w98wIFexSD5bXCTBtp
         HbTyh/XDW4AVMzO1yNAc017ZHtyScKuyNiLz7oSw8Sz4w52gXMyeRz8cq2xYSSJgBHIp
         GSKRVhmds3dVwDPP3Ot2R/c3pEEkK5jRd05QMtn7t7GWnJdVl8Toosu8Gmd/OTuZKBHb
         /lW9Nfx/O5xWe2Gl13pGYpgWnjCbQV/OhyLCZIQnkUUuT6iKhFJn9I24OpocG3zb5i1G
         T9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFwnz8My2aB1yFy0zWt3Sr/GKwI6p39MzB5DMH+JhAA=;
        b=RCod0/1aKe9E6J/y47rn28cfa9sVQYoDN0yiMAl9xgUzvjY8nXclTBB4j/ozIByCFp
         ke+icwfTyWEAo7PpxZ4gy/y8mJMWjmo2sD/jRLfoDLEgvNuwNEH7gEsE1ixlpfogQs4E
         5jelJ5mnoE3VlkY5xmm06d/UOybyZ85z1YVL3Ejzecx2eB66FJ0DyNLsC03GmsMgf4ak
         FGf+8dWU3PWzshu/A5ZMIpZu0Li1fFXyzdsg0goKBUse4X/IxKmpi+oXYlP+SW6P0t9R
         +ELkRytHhCofzzyf+v9FNxci5TvykxvPiK1vEznofk24Ot/AbGXd+IARZN4PlzHw/GUO
         srDQ==
X-Gm-Message-State: AOAM530lMcEQmjzEVOAlhJE/jGa21p+eXS2fqY/2gJsEw17/FgwgJdk4
        P0vV6VDKeDADe9PP4JBf56oBAQAcPyiRvNQ8Fnk=
X-Google-Smtp-Source: ABdhPJzojDOIUvuyFwj7IQey+5Fa7opCnmgGlcNs3uz2v3moUNSQngEHhlTiMnt/e3v/GvmMH1MEhxBzhXQasl6iGhQ=
X-Received: by 2002:a17:906:819:: with SMTP id e25mr24901108ejd.211.1600245918241;
 Wed, 16 Sep 2020 01:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <20200831180537.GC331156@google.com> <20200901125119.GA3250129@coredump.intra.peff.net>
In-Reply-To: <20200901125119.GA3250129@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Sep 2020 10:45:07 +0200
Message-ID: <CAP8UFD0FGs8UNwu9i7aZt4wfr7=bOgZSVtJ9XAbSkMCY8V8fEQ@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 1, 2020 at 2:51 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Aug 31, 2020 at 11:05:37AM -0700, Emily Shaffer wrote:
>
> > I'm interested in mentoring or co-mentoring this term. (I'm not working
> > this week but I didn't want to miss a deadline to volunteer.)
>
> OK, between you and Christian, then, it sounds like it's worth pursuing.
> I'll sign us up and try to arrange funding.

Thanks for signing up and for having arranged some funding already! I
might get further funding from GitLab too.

> > One thought I had was whether it might be cool to shop for another
> > co-mentor from Wireshark and have an intern teach Wireshark how to
> > decipher Git protocol. But it seems large, and maybe last-minute for
> > this term.
>
> That sounds neat. I don't think it would be too large (in fact, I think
> it might end up being a bit small for a whole-term project). It would
> definitely require somebody from Wireshark being a co-mentor, though.

I agree that it doesn't look too large. If it appears to be too large,
it could be finished later either by the Outreachy intern who started
it or by someone else like a GSoC student. Also it looks like all the
projects will be last minute anyway.
