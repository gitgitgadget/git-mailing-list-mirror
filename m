Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27391F453
	for <e@80x24.org>; Wed,  7 Nov 2018 00:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbeKGKKN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 05:10:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37558 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388515AbeKGKKN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 05:10:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id o15-v6so11942670wrv.4
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 16:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+b7r51FQ/FKFDLh/YnscNXy/xnkyN1ozWaRspBc7oJk=;
        b=Ohvl4TKwxqGjtu0XI6GkcDVZosq7xJWpH0gpczEZx34AJSDMLzVYraIFBDyV3y402g
         sIMkYL5iOejm8c/wkMG3SJ/bS7Lfrkd+Ll8UOAJtg+RVlojXAvsPkkvCPFlMB092L9mT
         mbMoxA9N4dN6XoSBIkLj4+WpRRbjlCgld7h3J+uwabCikK2EIihryHtJQh1MNxszHqEX
         /ilh6W7eN24C3s66yQiSdC5F1GEy9diCOEE4I/r2B8ZI97FjVuqh2pMZJI39yVLCqfIG
         w/Pzk1Np181SL3kMdBT3HtyIXlFH9myZua7AnDlHZtRVaHfKtJcC3tQdGh6zsdK9Fxpn
         c7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+b7r51FQ/FKFDLh/YnscNXy/xnkyN1ozWaRspBc7oJk=;
        b=lFgzPjbaGfsAzT0ZmojOjCW0WI0UrsoIWaO6sSQQjj4+HCx4/fq5dq/N7Wk4wfJkni
         oxp1GT8qjVi1gGYXwQkQqye+Q0KoLO5hDVaKfKfVWM6t66SosLPeMc7AYsT5yOtpKCMl
         sDTEfV6hdQGyyy/lRMXuPH7nsWt4b0iyizSlBuW7sw61jnvk1YTajynxgv6ZB0E5A9Y7
         AJuKHyh/MLWHLga62mdgRAVAqNq3aip/24n1NMU6EHOa+ZqnfZhfsaW13hpSO2DWd94B
         zuv8tlSBFFs8sDdteS4G+2aCq5qzY2Tqp7XooWFXPcAd5Ic/J8lqrKAz9RAgq8iYeG9e
         1H5g==
X-Gm-Message-State: AGRZ1gKR065Iz9pwHTYGWIMA57etpX71Ar1DCJb0Sef7N31VQWwLZE78
        ZeraPCmCT7ZQxG9lbD8GxvI=
X-Google-Smtp-Source: AJdET5fd/4KRldnPbBBquueHsNmvb3O0iipWT+gC2pfKjyXCbU2oCndcwn7PPaWjH3GttsiCnafhqQ==
X-Received: by 2002:a5d:6943:: with SMTP id r3-v6mr25088188wrw.323.1541551335176;
        Tue, 06 Nov 2018 16:42:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e7-v6sm18298608wra.10.2018.11.06.16.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:42:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        andals@crustytoothpaste.net, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
References: <20181104181026.8451-1-pclouds@gmail.com>
        <20181106171637.15562-1-pclouds@gmail.com>
        <871s7y6qs9.fsf@evledraar.gmail.com>
        <20181106221118.GA9975@sigill.intra.peff.net>
Date:   Wed, 07 Nov 2018 09:42:13 +0900
In-Reply-To: <20181106221118.GA9975@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 6 Nov 2018 17:11:18 -0500")
Message-ID: <xmqqzhuld8gq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Could we help the reading scripts by normalizing old and new output via
> interpret-trailers, %(trailers), etc?
>
> I think "(cherry picked from ...)" is already considered a trailer by
> the trailer code.

;-)  

Great minds think alike, I guess.  I think it is a great idea
to ask interpret-trailers to help us here.
