Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFE2201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 19:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbdKOTOg (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 14:14:36 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:53025 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932880AbdKOTOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 14:14:22 -0500
Received: by mail-qt0-f194.google.com with SMTP id 31so36856144qtz.9
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 11:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oZDtof5CffBJPlXblaQzYyj7CAHQcLBoUzkYs8laMD0=;
        b=a3WVzir14PugCsO8EN6tpH+m/QuTHsHA4nnKmhDBQHgr66BLpuFUs+5/tyohH/4hYq
         OV89Rr9F3wDMNIFDR2Mgbi9GT9e9M3Sy9GyewI6OBmHMhxvS0jg7wfvtDrE/9yj74W/1
         MABvXTkkBErhDD94LaQ1lejA9rWcz0xM0qU2HM2VG6aV6cdYGR7rZbBlqkXirJemgAqB
         Rzq21kjkjYR4OhsPheLe/V7h7hdxjpaAPExQllA8XqanGB/fQDnphNEt/GdEXQkEYo/l
         foGaIKpXBNCdQ2PY9EJ1jSDV5csDruQvn2EhkOlTiSgLbE4oUui+QTQnGveb1gnQ2pOJ
         ZX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oZDtof5CffBJPlXblaQzYyj7CAHQcLBoUzkYs8laMD0=;
        b=VOboX01V3ofZQwLjuku9S9iZaMmxDEwSS8+2lpV+S+NIZUGhg/BtxzQCdJGe6aCas0
         woQEqdwybst/Zf+dvcx/nfkTo8GCI4nWDXJuDztllsXzczMLzuoYDUl/DpoLA6pH82uR
         f9GnlH2YyUWnaLvXfR6zwel0nRPjm7/NCpBpTqZrBnNcTr7EA3yxG9MUjvBgrWQg05p5
         4vUmMe4pQOgT1JXyyeHh5TID29jn38hIszYwS04fu1vGVesFT480VXmMDrL6xVyYOzI0
         I3tRP5icMMoEyE9x5lhgikiLjXRddE30bZnt0hqeKKQATYO/sxm2dxL7wZ7fLRRRJZ43
         YFRw==
X-Gm-Message-State: AJaThX7DAFtGuw13w99y6mYgGDVp02amm0Dl8Sc5Ia2QJcjUAeN4ly3r
        MF/RLUZjJm9/DwJIHrVM3TS6JjTw9ERApfKBMpK52A==
X-Google-Smtp-Source: AGs4zMZfQBZYt8DIbNBYSKDdGh6DhPGzIuTob7XcY+Izkfo8CymWMfmTMVdqUmpuRi04nr0ufJ/k1WDej6VjkJq+z/4=
X-Received: by 10.55.119.70 with SMTP id s67mr18436007qkc.45.1510773261277;
 Wed, 15 Nov 2017 11:14:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Wed, 15 Nov 2017 11:14:20 -0800 (PST)
In-Reply-To: <20171112141737.nmnsygm4wrhtkqwb@sigill.intra.peff.net>
References: <20171111192858.27255-1-gennady.kupava@gmail.com> <20171112141737.nmnsygm4wrhtkqwb@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Nov 2017 11:14:20 -0800
Message-ID: <CAGZ79kb4Eo0AC4Z42_ks5_+Pcy4DrDCufNb=5J=g8L6pMnHd7A@mail.gmail.com>
Subject: Re: [PATCH] Reduce performance penalty for turned off traces
To:     Jeff King <peff@peff.net>
Cc:     gennady.kupava@gmail.com, git <git@vger.kernel.org>,
        Gennady Kupava <gkupava@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 6:17 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 11, 2017 at 07:28:58PM +0000, gennady.kupava@gmail.com wrote:
>
>> From: Gennady Kupava <gkupava@bloomberg.net>
>>
>> Signed-off-by: Gennady Kupava <gkupava@bloomberg.net>
>
> Thanks, and welcome to the list.

Welcome to the list!

> I did manually disable HAVE_VARIADIC_MACROS and confirmed that the
> result builds and passes the test suite (though I suspect that GIT_TRACE
> is not well exercised by the suite).

GIT_TRACE is exercised in the test suite (though I am not sure if it counts
as well-exercised) in t7406-submodule-update.sh for example, which uses
GIT_TRACE to obtain information about thread parallelism used by Git, as
that is not observable otherwise, if we assume that performance tests in the
standard test suite are not feasible.

> I tried timing a simple loop like:
> ....
> Without your patch, the times for GIT_TRACE=1 and GIT_TRACE=0 are about
> 500ms and 9ms respectively.
>
> After your patch, the GIT_TRACE=1 time remains the same but GIT_TRACE=0
> drops to 1ms.

So does that mean we can use a lot more tracing now?

Thanks,
Stefan
