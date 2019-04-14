Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533A820248
	for <e@80x24.org>; Sun, 14 Apr 2019 09:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbfDNJlj (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 05:41:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40835 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfDNJlj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 05:41:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so16011891qts.7
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 02:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCh+YjfcsJt5C3DW8nHJgSrhMqsuSfAask352ul39GE=;
        b=PmLaNnJMXmkoC6htuyuaiv8lq9v2RRYv40pDT/K9+qEZKr1G8UGWfPtS2KDhY2jFbH
         /ML+umXjwg/FAEpos5sHprXsFCglQXUzrXdJqV6XZ6UJ7EDBNzAQpHZ6YcXhsYLvEqV5
         BkY0MhdnC7CF+QxP2M1qw7Xr4M2584YfA3aTDrseDwld4fDKWTLnzkhwRKNBmaX76kwu
         WaNRVZoRlf0Y8B5LHNRZcDPWHpAsArSvAvQ2Y7Cjn/7NZyhOUZ1CfAgiAGS6CU+/nPbP
         zZAUZIOUutQfRE0Gy+WnXoqvkcVeKleVvGWDYGhnK/yjjLjuSiLd9UpEFiS1D66fXeQ9
         y7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCh+YjfcsJt5C3DW8nHJgSrhMqsuSfAask352ul39GE=;
        b=WMDwDR/MvQo4TR0eC6MysdKLjoTpW/VOpuGOLXTOraENoY8YuaEEEo7wmiWgP/2b03
         B09MvcKrslQjs57lYWBnxDol8tVoj8rnY+U5xOV1nMJvjFKeTLxwWowrIutVda39344X
         WEXOc6drHFUcAOHo7+Y2JD0g82+TmxRBCLhHMD/j2uAKrtYEqnaS2M2OHbkO0nF6VpUk
         ZM/of27R77CabkSB/k6Y91CEEpXHCsDGy5Tqw1SbFkQUqBPJ0q6vIzB/kh9LIYXAxFeJ
         OXnONRhMvcINb08XnbkuL24dwoR4xzUyRN0bgrSKuKqv49yB7ORI20+C4/Mhh5dj3uR0
         Xpsg==
X-Gm-Message-State: APjAAAXB2XaM2PBuBkUqpT7Xs84CgngCsK/iIGtVFQkLk8fdCXMzXstb
        r1Bfbujxulhpt3FLN+4/OX0Y2cJNQkg5eHHNIDI=
X-Google-Smtp-Source: APXvYqxKUSPBR7yYq6tN/Tb3mreRjq+mFDll8AKXQNCb+4jseGXCIZn9bo6HlSBKIGax69AwiY4F6qFoVKS9wbJuxng=
X-Received: by 2002:a0c:9baa:: with SMTP id o42mr53958386qve.184.1555234898390;
 Sun, 14 Apr 2019 02:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190410162409.117264-1-brho@google.com> <20190410162409.117264-7-brho@google.com>
 <xmqqk1fxw8ad.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1fxw8ad.fsf@gitster-ct.c.googlers.com>
From:   Michael Platings <michael@platin.gs>
Date:   Sun, 14 Apr 2019 10:41:26 +0100
Message-ID: <CAJDYR9RHb89mjT65XVERJfo3cTySi++ZAwOFftBtyXkqfC=JOQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] blame: use a fingerprint heuristic to match
 ignored lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  - I wonder if the hash used here can replace what is used in
>    diffcore-delta.c as an improvement (or obviously vice versa), as
>    using two (or more) ad-hoc fingerprinting function without having
>    a clear reason why we need two instead of a unified one feels
>    like a bad idea.

Hi Junio,
If I understand correctly, the algorithm in diffcore-delta.c is
intended to match files that contain identical lines (or 64-byte
chunks). The fingerprinting that Barret & I are talking about is
intended to match lines that contain identical byte pairs.
With significant refactoring, you could make the diffcore-delta
algorithm apply in both cases but I think the end result would be
longer and more complicated than keeping the two separate.
Unlike hashing a line, hashing a byte pair is trivial. Unlike hashing
lines, all except the first and last bytes are included in two
"hashes" - "hello" is hashed to "he", "el", "ll", "lo".
So based on my limited understanding of diffcore-delta.c I think the
two are algorithms are sufficiently different in intent and in
implementation that it's appropriate to keep them separate.

Regarding the "old heuristic" I think there may still be a use case
for that but I'll expand on that later.

Thanks,
-Michael
