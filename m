Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8431C1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 20:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967194AbeFSUv7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 16:51:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56023 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964897AbeFSUv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 16:51:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so2482624wmh.5
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9HE/5D0QWXGo2I+v5ejsLjjcLcp6WUjtSWCPr1c001k=;
        b=Wq13CPGrwP+t6+frwUsUk7mniWI5x5v0hD39gzDCUBy1ErPlI8lIUMQky5j+DgxEDr
         tHcLCu1MnLcbFgo+8bFnG7Urh/vA3yLCSauJkVt3Re5e+R5c+ppfHXySBEZTN/Ab3MKo
         XCW9PKjW90WHgZ4lsfM2V7d0i/I6hbW2xLn5XTLMv3rk7kizyWlD04l63qvsSr6lSQ2i
         F7HBeOblDUXLNpw+3w0p4drQ7dXxNjRHb3wEn9RiPpdm73eoJ2GxrUglKsQiE6UpTYpy
         FOEGdlN2KQaCrF6Hm1INbCIcM1AG+eXEFhK17O5+8OpZ4KkECvJcDVEeaQZe6MtlHg10
         xgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9HE/5D0QWXGo2I+v5ejsLjjcLcp6WUjtSWCPr1c001k=;
        b=rn39mqBRoL2/tmA9gWQ5GRNOBRCxf7MTPskcWwtkzJM04porJE5NwYs7x/Kzs0DO0P
         rs4Y2HC5+9FeMy3miMW/BljAXowNZDCXrUbE2MIFi99ilpod83Q6fOLECPgoGQIPj+Um
         NLAMWCp6RmxLKE4WHKBOfYWjDbXZhPcXBFXiJblT/+MlRAPlGHzljLsG64IcfO5G/eJt
         wiLmjXBXfMQeYrrDv2R72OupkTPmlrguabDP1RHAVfcXT1iDwTbXn+gsCbN5tzV9S0eK
         GWOvw7YtulQUf5FMM+hselIsn3PmJtLlc7kbQg/7e826NRjfHqhEd/edTbU/ZyaZXI41
         DxkA==
X-Gm-Message-State: APt69E2iPcR/697F54PDtv0137yqCYTUsiLz4u3uh5zeJv4DdWVhdfYf
        3QGpy44pYC9zzTj4cdpE7Dk=
X-Google-Smtp-Source: ADUXVKKONLLCLyHBsFaVIyVY+jaZw9y8aguIvkG7b2psTh3ZQOzb3vJlEweAZEBCHQoo/8Sw1Yg5eg==
X-Received: by 2002:a1c:f114:: with SMTP id p20-v6mr13231371wmh.10.1529441516724;
        Tue, 19 Jun 2018 13:51:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g4-v6sm479879wrq.32.2018.06.19.13.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 13:51:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
References: <cover.1529365072.git.me@ttaylorr.com>
        <20180619163506.GB22034@sigill.intra.peff.net>
        <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
        <20180619174846.GA27820@sigill.intra.peff.net>
        <6ab94453-84ef-e269-c320-e102b02d6f3b@web.de>
        <20180619191156.GA21641@sigill.intra.peff.net>
        <385b429e-5d57-91c0-054c-0f04c59538e3@web.de>
Date:   Tue, 19 Jun 2018 13:51:55 -0700
In-Reply-To: <385b429e-5d57-91c0-054c-0f04c59538e3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 19 Jun 2018 22:34:44 +0200")
Message-ID: <xmqq7emuv6s4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> So let's see what your example does:
>
>    $ git grep --column --not \( --not -e foo --or --not -e bar \) trace.h
>    trace.h:13: *  #define foo(format, ...) bar(format, __VA_ARGS__)
>    $ git grep --column --not \( --not -e bar --or --not -e foo \) trace.h
>    trace.h:13: *  #define foo(format, ...) bar(format, __VA_ARGS__)
>
> Impressive.  That expression is confusing at first sight, but showing
> the first matching column anyway requires no further explanation.  I
> like it.

OK, obviously many people are a lot more math/logic minded than I
am.  I still think that any code that attempts to show the same
result as '-e bar --and -e foo' from the above is over-engineered,
but as long as it is done corretly and efficiently I won't have any
objection.

Thanks.



