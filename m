Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8191F597
	for <e@80x24.org>; Fri, 20 Jul 2018 09:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeGTKTz (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 06:19:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36407 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeGTKTy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 06:19:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so10685553wro.3
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NiUIjZcepQOZQ2KCs//+jkAHkFNtVZzOHG/TLwx9xlU=;
        b=bbeOjsM1jd7wFeB/0ubL0k84bZ55dffFC83/H0xkUQkZ08RGAzBZAqF2j2J4hI31vv
         KxrD+OoiXwymV9Xoj4x3t5fwQ5A37LzDOdmtlNdiewgHjJrKp8JDzDY3CMU5QRriWt2H
         MaPDplQURHonVLwNPyuKWirurgLuB8VZJ/c4VRDli41IIcAD3er1xTkG7MUyQ1tFePcZ
         w0LR5JTApMgDTFBZI0hErwzn8d0fddP6hjmlbyuUm9kOPOfKyfIpdf+o68BZZrp43LFX
         WLpZONk8ki229ZNKp+kpXDZ1XEHs+y7Bi6qX8z4FBhqSGgO1BiqyTOQ94L2nAcD1cso/
         pDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NiUIjZcepQOZQ2KCs//+jkAHkFNtVZzOHG/TLwx9xlU=;
        b=P3C1uxe8bwNmijrEUI+/99SQ7Hyuit7LTbpEdziT6z9+749wSdG5w3dlWxRIL0SG66
         aZfn4bM4+oLaBfMci7bZimZtsYatXN9jwd3u+WUVipOjl/CuAn1Gy6nNQuLaoUKsnyH6
         oI+wKMeQGESNaOHy7DVzVQk/lxyMtnld8PDxjGLIJ1Yfx2mFdCM+ZdKmDKueB3+kuc4h
         aQqb+JZaGNNlbLs7yIw3HlOenduWQNWuMPa3tgkTA7z2OLTBrdB+ISsxk0viQCQBgqoV
         C9bqFH86xH/hMNWibQgi/cRSlpdNSs4CcQcM93Fql/rVgAL2s1haOnqTXbXy6wsDYzEw
         P0dw==
X-Gm-Message-State: AOUpUlGIiW8m/MjFjnXq0gz4ghPPuXAf1SvT9f1Zh1U2nk/KtPxpjx38
        q+xTpv20iIYa0xo2gdmZd5U=
X-Google-Smtp-Source: AAOMgpcJgkGRpzW0LnZMaF3v1MmItrmBgnZqgvd6ZZLaQi2ryucJWdbLq43ZqGrK/dZ01lHLhU+jbQ==
X-Received: by 2002:adf:9a55:: with SMTP id z79-v6mr852301wrb.153.1532079150931;
        Fri, 20 Jul 2018 02:32:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w9-v6sm1317652wrr.77.2018.07.20.02.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 02:32:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
References: <20180719203259.GA7869@sigill.intra.peff.net>
        <20180719203901.GA8079@sigill.intra.peff.net>
        <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
        <20180720010808.GC2179@sigill.intra.peff.net>
Date:   Fri, 20 Jul 2018 02:32:29 -0700
In-Reply-To: <20180720010808.GC2179@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 19 Jul 2018 21:08:08 -0400")
Message-ID: <xmqqa7qmckwi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Is it a downside that it is cumbersome to override?  This is not a
>> rhetorical question.  I am not convinced there will not be a legit
>> circumstance that calling strcpy (or whatever we are going to ban)
>> is the best solution and it is safe.  By "best", what I mean is "you
>> could instead use memcpy/strncpy/whatever" can legitimately be
>> argued with "but still using memcpy/strncpy/whatever is inferior
>> than using strcpy in this case for such and such reasons".
>
> In my opinion, no, this is not a problem.
>
> My plan is to only add functions which are truly worthless.

OK.

> Contrast this with memcpy(). This is on Microsoft's SDL banned list[1],
> but I think it's silly for it to be. I would never add it to this list.

A tangent, but is that because they want you to use memmove()
instead so that you do not have to worry about overlapping copies,
perhaps?

