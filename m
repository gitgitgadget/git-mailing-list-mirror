Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422D31F453
	for <e@80x24.org>; Fri, 19 Oct 2018 00:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeJSIic (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 04:38:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51685 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeJSIic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 04:38:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so1966859wmf.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 17:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vHnWYTxae+/gpC3i9JPfYZ820vhrQQq4i2tPtaWBw4A=;
        b=nqtZ0F87D6HeTKTbxXnJ+ByAdcZJlhoZJ/CuotPvWuczsyAiYpq2PRLsQcBtDRlvan
         9r7ETGqz3pI3M70iBA2lv1EqK/jyYoC3GbKY4yiBa2C0y2JLRrUsx3Y+xmYznEsisv1j
         xj1sjoEHZBIVJIKVmOOg6KDd5Qkjx1ojg08K3qyc7uhWUFG1H5xnMTeak8eX/+f7qwiP
         LQsohLcBiGfHCLjL+BvZni3kYJ4BA6kwOmelMuzU71dNH9mKzJh+KMw9vAS0q1C7Uiwj
         NhQhrOjH6TOrhiFGGZfyv5F1SzUWTo2nzFzvRzJaN/zX/TKlRv7sKC60PcbPaqKbbGDq
         gB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vHnWYTxae+/gpC3i9JPfYZ820vhrQQq4i2tPtaWBw4A=;
        b=Qmxt+kzl5vPlWM2onYjv6mmVMjd0vmojYDIZcYOxgUZQgwhqVAD94qPECrLZy2ZOVZ
         /cMxwqhKHXBf0ubUfA4QBshTNwRSvhzPZ5+z7gOhvCjzIlDp/IiyTQ3t8XBtWAWaV0Qb
         Vb4q1g82Zhg/Qhxi1/EIgmVhEeOjvLdH7r+LiOZru0e3krkUX2qiYn+qnYbWJxR2MxZj
         36t8Me2h0qLJo69a5fJg8cKlKJ1yljrKfKCzHIG2zsz9tEY/Bi1wKgNfHc4TzJV1Gdmn
         k2b5wpOhVHgN0VSh05WhDwB6VVEehHiMEPAH5Wm64iyrxiSkBRs0DWuHbUTVCRB2kwuH
         iXQQ==
X-Gm-Message-State: ABuFfoh2fTYIkIrqxDSTm2RvGIuSgR8CZezZzYS8/Xi7JphaOq9WYFJI
        +Nhw/7qmdvbfPmttiORh9+o=
X-Google-Smtp-Source: ACcGV60VwXM1oqxM+iDVED8UYKlJP0bU6ldSgGfEtFDxnfZbCNuxwBdNmGzOVc0QW+BtrD0WyAYTlA==
X-Received: by 2002:a1c:8154:: with SMTP id c81-v6mr2383061wmd.140.1539909294681;
        Thu, 18 Oct 2018 17:34:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m143-v6sm1913478wmd.29.2018.10.18.17.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 17:34:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1 1/2] reset: don't compute unstaged changes after reset when --quiet
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181017164021.15204-2-peartben@gmail.com>
        <CAPig+cSiE-M9QMch4WE7y4cib1FBUNiaR2pGGtbDuqiz6juhaw@mail.gmail.com>
        <20181017182255.GC28326@sigill.intra.peff.net>
        <xmqqpnw7vs5b.fsf@gitster-ct.c.googlers.com>
        <20181018063628.GA23537@sigill.intra.peff.net>
        <5b4d46c2-ac0b-8a44-5e99-b0926ea764d3@gmail.com>
Date:   Fri, 19 Oct 2018 09:34:52 +0900
In-Reply-To: <5b4d46c2-ac0b-8a44-5e99-b0926ea764d3@gmail.com> (Ben Peart's
        message of "Thu, 18 Oct 2018 14:15:24 -0400")
Message-ID: <xmqqo9bq4vv7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Note the status command after the reset doesn't really change as it
> still must lstat() every file (the 0.02 difference is well within the
> variability of run to run differences).

Of course, it would not make an iota of difference, whether reset
refreshes the cached stat index fully, to the cost of later lstat().
What the refreshing saves is having to scan the contents to find that
the file is unchanged at runtime.

If your lstat() is not significantly faster than opening and
scanning the file, the optimization based on the cached-stat
information becomes moot.  In a working tree full of unmodified
files, stale cached-stat info in the index will cause us to compare
the contents and waste a lot of time, and that is what refreshing
avoids.  If the "status" in your test sequence do not have to do
that (e.g. the cached-stat information is already up-to-date and
there is no point running refresh in reset), then I'd expect no
difference between these two tests.

> To move this forward, here is what I propose:
>
> 1) If the '--quiet' flag is passed, we silently take advantage of the
> fact we can avoid having to do an "extra" lstat() of every file and
> scope the refresh_index() call to those paths that we know have
> changed.

That's pretty much what the patch under discussion does.

> 2) I can remove the note in the documentation of --quiet which I only
> added to facilitate discoverability.

Quite honestly, I am not sure if this (meaning #1 above) alone need
to be even discoverable.  Those who want --quiet output would use
it, those who want to be told which paths are modified would not,
and those who want to quickly be told which paths are modified would
not be helped by the limited refresh anyway, so "with --quiet you
can make it go faster" would not help anybody.

> 3) I can also edit the documentation for reset.quietDefault (maybe I
> should rename that to "reset.quiet"?) so that it does not discuss the
> potential performance impact.

I think reset.quiet (or reset.verbosity) is a good thing to have
regardless.

