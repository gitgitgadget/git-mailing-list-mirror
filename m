Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95FAC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FBB64F60
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhBBU2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhBBU0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 15:26:39 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2617C06178B
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 12:25:18 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e133so11928057iof.8
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 12:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BTmNK/NNQZr7YSBN+QtOxkwumfJiqtpUZRlXrZCK+U=;
        b=RUCGIFmBhbV0i3NRQ0YTg5WrbBSOnHY6z7q3tRzmZws9/4Z2SIcm91Zff3x1qtR1Uo
         HyNSzUSTeN5VppmkXmaRxFIxINKVrSfBYgDkchWK48p5x76yA6Ht9c1XJBsO1ATWQ1MZ
         +sk2ZLTyir1CgaAEaQ4ABdTgyiOvwMgR7RjgsI7EO5c57jtVHZGdDvNfmx8BR12NuvfS
         5xASTWhO3ZWdRn7fCbGY6uJOhDg9hhZop0TqlxiMAgmsUSqLDelRWO05JkCglfwtbS1a
         UqessBFsmV+ZLOrvypc60BdLSwQxFnI645FM9jQRLMqZsRvLyUaEe9VBgzfYRTZaLlrl
         uocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BTmNK/NNQZr7YSBN+QtOxkwumfJiqtpUZRlXrZCK+U=;
        b=NWa2ME3MpjOU1xzrBcPy9WB0iIbfmPcXJhk/YtJkIeWpyQjxwNF4e8Ww5Nv9uTymef
         08Z6tlFR+vx1QkBFURugbXE9FsjVVcgHnBnHcWjhEwfxxyNnI2q6tanr37WG5zlo2/YM
         Wu5eZ3ol9L30Pwan/rjDUYs60FPItLPasPzel+MxjeQxZTj/tkI2vnqSO4I96Vk5tTJP
         2hVnOUUtvPK+guEfqTwi9xNt/4bPYhGR0cxMhhppfIjcTvzhSC3/cSGG5upNyUj+aZgq
         abmKnwSwXjp3zzgeB2PZY86nMMAUQu8qoAeJ/gKkz0qcE/LEko5QBgbd/tO4LuIAeI8u
         WlvQ==
X-Gm-Message-State: AOAM533YSKUHB3L+9sDT/UbZZmeA20IpMM6p67P2A6iPcsmZdkbkcA+K
        bD0teKeKAOWLEW2XHDTuCTxrny2xanNCJ7BENZqz9A==
X-Google-Smtp-Source: ABdhPJxaPEupNW86yjWl6GLYk5h7M8yAA2fIYpGCXbsRG+892lXI5xBxm8IK3thB0FAHBVlHWR+DQt/eonzkojC+iCA=
X-Received: by 2002:a6b:dc17:: with SMTP id s23mr18710091ioc.170.1612297518052;
 Tue, 02 Feb 2021 12:25:18 -0800 (PST)
MIME-Version: 1.0
References: <CACoUkn6+9C3+HVVQF905t1siAD9Sqo1JvRa0Whw-J6x7V7icyg@mail.gmail.com>
 <YBkVFTOP6K1//i6m@coredump.intra.peff.net> <YBkZnY8X5VyNkXkR@coredump.intra.peff.net>
 <xmqqpn1igznk.fsf@gitster.c.googlers.com> <YBmqT/hvT9wM6yHz@coredump.intra.peff.net>
In-Reply-To: <YBmqT/hvT9wM6yHz@coredump.intra.peff.net>
From:   Paul Jolly <paul@myitcv.io>
Date:   Tue, 2 Feb 2021 20:25:07 +0000
Message-ID: <CACoUkn4AK1uvOwfkU-adrsoCFwAbEow=owN7kTeyc5hoASAUTA@mail.gmail.com>
Subject: Re: Bash completion suggests tags for git branch -D
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I had also considered whether a test made sense, but I wasn't at all
> familiar with the completion tests. It looks like we're not even testing
> "-d", so I'm happy to proceed without one.

Thanks for the many replies and quick fix.

Just to flag another issue that I raised that's in the same space of
bash completions:

https://lore.kernel.org/git/CACoUkn7D52ox2MgUfS2uQtLa28twccfxnQnUteVV_yFfVLFQdQ@mail.gmail.com/

That, however, might be more tricky?

Thanks,


Paul
