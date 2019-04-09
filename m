Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC73B20248
	for <e@80x24.org>; Tue,  9 Apr 2019 08:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDIICh (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 04:02:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37126 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIICh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 04:02:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so19578642wrm.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 01:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28ZpBWVrKg29h2QWAofFnTU6kdKTh326oa5glNRDDps=;
        b=M3/sPzig1QUe8GoI3Q6VPrBD8Mw9qXJAOo1q/O3hWK70aU+zbavF2ZV1FgHYZlz8Zm
         lDuGWGEZUPxrL2HCUi3tum30qCrCVS0Wa4aUtORxUSR0FhFE2Otp9eB12npKqYUKMuUf
         gd4P3ryWVju5v/DS2OOIw0I7Dvpgdu+Zceet/LU8p8yDFioKcOM2ZM+6Kt9yGoS89DyP
         tBLuHUsPLgvHTrNoj0wpz0MJpFQwb3EVgzokHxqiwK3YYDKadVAxzUeK4pgKYi+ifflA
         VuUhnD3sheairo87yXW0yv8wBVPIWh3GYISE9ZvLPjmZ46TvjSwZBbG9hfpAN4lQ8ekX
         3LPw==
X-Gm-Message-State: APjAAAXuLyXiPA8ay1IfnDa2rFDYv2fncw49ls6tvmanslB+GA9y0F0v
        L4ULNEGm1r2jEIXojvYCW+trwaMx5sygl223ZWNgnIUh
X-Google-Smtp-Source: APXvYqy23x1lcPKr0yMglzfqi6016qcPS7lBWJYWwtn+DoeGjkWy11KfgXRk1IvptRVACrA1kKwYMPFcMQNefXpCxiU=
X-Received: by 2002:adf:ea45:: with SMTP id j5mr13867376wrn.89.1554796955401;
 Tue, 09 Apr 2019 01:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554435033.git.me@ttaylorr.com> <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev> <20190405182412.GC2284@sigill.intra.peff.net>
 <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
 <xmqqbm1h9et2.fsf@gitster-ct.c.googlers.com> <20190409023055.GF81620@Taylors-MBP.hsd1.wa.comcast.net>
 <CAPig+cS+4tTAAWsp+KX2-__kcvgDABQQCmz63d6pQUa6Qu3LKw@mail.gmail.com> <20190409050857.GI81620@Taylors-MBP.hsd1.wa.comcast.net>
In-Reply-To: <20190409050857.GI81620@Taylors-MBP.hsd1.wa.comcast.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Apr 2019 04:02:23 -0400
Message-ID: <CAPig+cR6v_+nmGLsnoSz6K262hQfC1R9Xdk8CfuHcx6MduZfcg@mail.gmail.com>
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 9, 2019 at 1:09 AM Taylor Blau <me@ttaylorr.com> wrote:
> On Mon, Apr 08, 2019 at 11:28:19PM -0400, Eric Sunshine wrote:
> > I suspect that Junio's "Looks good" was referring to the 'sed expression.
>
> I think that you are right -- and I'll happily _not_ introduce more Git
> on the left-hand-side of a pipe instances.
>
> I noticed a few more instances in t6102 [...]

Indeed, SZEDER mentioned those in [1]:

    Don't run git commands upstream of a pipe, because the pipe
    hides their exit code.  This applies to several other tests
    below as well.

[1]: http://public-inbox.org/git/20190405105033.GT32732@szeder.dev/

> I wrote the following patch, which I've folded into my local copy (and
> will send with v2):
>
> > With all the recent work of moving away from having Git upstream of a
> > pipe, let's not intentionally introduce a new instance. I wrote the
> > example 'sed' expression that way merely to mirror how the original
> > 'perl' version was written to make it easier to see the equivalence
> > (not because it was intended as an endorsement of having Git upstream
> > of a pipe).
>
> I see, and thank you for the clarification. Let me know if you like the
> patch above.

Looks fine. Thanks.
