Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82A441F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbeGTTwp (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 15:52:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33070 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387994AbeGTTwp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 15:52:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so4915008wma.0
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UMcSXuhpC5E4TYXmFswndkCZL+mnPm47Xxyixyek8ps=;
        b=Iyv81DZN7Z/dPEZlPx0kzLu3d6w/5RXFTNzHUGIK8iWyWPv8j5CEpeapnAbhUGiz1R
         SpI+b0nZmf2wJkKK9m3fwLermRwi3QpbDWwyGP96oIxE8+dXClEDOF2pkK4j6iZHOvbt
         eIld/lXAZgQZR4eq2OHbxpKDXF/3Xorzmu9wfw3oJF9W5zLXrF190rLtcsnLLLr1VgFu
         ppkdY4NBz6DENleazo38/2gh7VEA5pNikloqUm+EXHEQChhy98p979FTMkNBBfVBCXYI
         PhlEJ1/w15mK7yuuNgWMS/uIdp3JH6wIOjytZ1XtXLsn5GEuJNGKmssjs7WDvIcKzNDQ
         bsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UMcSXuhpC5E4TYXmFswndkCZL+mnPm47Xxyixyek8ps=;
        b=GXE1xHiI4aQm/Sxpl8lcIihONlLXm5uLkp1abDaW1UQ3cE2TX+iIED4g32qkgv037g
         a8iNi0Bk2Xy7pPnNfTd7cGBvyNJN0YxLy7nUep6eCGSqNeJsNn8OOxTnR9ZayMfIQnJf
         rRppFyHTBVDFGmThsQSTJ+svxA4Ca+iI060+Z4/4JWLZJb86JnQZ+r6967Qqjou6KIAx
         RmOkpIH871YRSJOiN8sHHG62l9Ge6cur46ODXL8VLIa9iTPVlyYSipzf0MU498RU5QC+
         NFFDjQsy+Lbd+eyJpw647muUC6SPh8qrQONkBqxJiOuzPuLD7POwqOCvwrYzgXAeLj4G
         ll1w==
X-Gm-Message-State: AOUpUlG2VSICJ8fT+P9CCxRzzsWGc5JXousUEFU24MUcvA+3wZYgWvSI
        v1b1pUdSgmIpcAyuEuVIrFc=
X-Google-Smtp-Source: AAOMgpdpMsXOJyoZzbGUbZK0XB0nmI0thFcnPwFzGmTTtmKej+OV5cYgCXbQOm33sLERYOzcPUbj3g==
X-Received: by 2002:a1c:f407:: with SMTP id z7-v6mr2128011wma.143.1532113388783;
        Fri, 20 Jul 2018 12:03:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w9-v6sm2883137wrr.77.2018.07.20.12.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 12:03:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
References: <20180719203259.GA7869@sigill.intra.peff.net>
        <20180719203901.GA8079@sigill.intra.peff.net>
        <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
        <20180720010808.GC2179@sigill.intra.peff.net>
        <20180720132241.GN30706@thunk.org>
        <20180720175602.GC22486@sigill.intra.peff.net>
Date:   Fri, 20 Jul 2018 12:03:07 -0700
In-Reply-To: <20180720175602.GC22486@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 20 Jul 2018 13:56:03 -0400")
Message-ID: <xmqqk1ppbuhg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks for an interesting (and exotic) counter-point. For strcpy(), you
> always have to run strlen() anyway to know you're not going to overflow,
> so you might as well memcpy() at that point. But if you really are OK
> with truncation, then using strncpy() lets you copy while walking over
> the string only once, which is more efficient.  On the other hand,
> strncpy() fills out NULs to the end of the destination array, so you are
> paying an extra cost for small strings.
>
>> So I used strncpy() advisedly, and I ignore people running Coccinelle
>> scripts and blindly sending patches to "fix" ext4.

Given that strncpy() was invented in V7 days for specifically the
purpose of filling the filename field, it is not surprising at all
that it is the perfect tool for the same purpose in ext4 ;-)

> We don't have any remaining calls to strncpy() in Git, so this lets us
> punt on deciding if the ban is worth changing what's there. We can wait
> for somebody to decide they _really_ need strncpy, and we can discuss it
> then with a concrete case.

Yes, and the plan (or at least your plan) is to limit the banned
list to things that really has no reason to be used, the above
sounds like a good approach.

