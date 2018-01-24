Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5BF1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 16:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934268AbeAXQvd (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 11:51:33 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:37304 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934194AbeAXQvc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 11:51:32 -0500
Received: by mail-vk0-f47.google.com with SMTP id g83so2963283vki.4
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 08:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y/YNaOx4D4x8p4Un6jeEbXsdGyMetsMNrC8IM46EHys=;
        b=JGNzu0na0ACWSW1iGnNQ2DL5fge9cE/odRi6OR/EToX7TLudfcS2DRtzEuc9mL5SKC
         taXNfumK7hu6CHYzovY/G4j2//MtgGcXloIPA4sKQjCsYN/O7VTzn6ddUp6vNBuIZTtq
         SOV2qgveXyT6RWNoNVnWZhvdnlPpQ60Ld0JNmMy3FdtAozGgYPTtJbqSI5OKV1BZTEkO
         OVJemrebWBs7JD4nP3ul3j+VUqxaM9Es4yw0K4j6pRkCAYNond08owx5ErG5x2kIhc2Y
         DTzBhUwiFRsJ8DdzXzJ+5VfHtQd19x3jxtKP+/FpG8np937I1LsWn6CPT9T8WiFUNeYO
         iM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y/YNaOx4D4x8p4Un6jeEbXsdGyMetsMNrC8IM46EHys=;
        b=SCWVES5hGqTahRdW02L7+d/Z91nHYM0kHa+46wLBSxt0Up4+jhNMt1nH/JIudLY1sQ
         1W7Ys4xhX4MIqpnyrPABtjPp8Az8nRxwZ1xiFahPO/AM85/c+mcThHmlXQSmSXogX2Ja
         Z4whYxxQGKqKTVaDgm7Vcz7uwNsYVzhpSIE6ujjowDcrFSUT8nh+dYg/3f6Kn5JWuMba
         Xob9Pe8ig7DTKirfRUmro0cef5pC8kCW8sthHrG1I8FNe7YTqoD1AM9NwAXRC+PAjx4X
         6NJErt+6BjdsNiLITq4GMjxsE7q4WIULRBcL133RqBwp7BFPdYwfQemkq5APD411Ha1L
         b/bQ==
X-Gm-Message-State: AKwxytf1ZzzfzHLbaFuNoTFHl+JTadu/Dhs9OMOuLNS/cuBQMy8wW8+p
        ybPmkx4I7B/U2zYWSpu4QTQebPcAilR0YjJ9bYo=
X-Google-Smtp-Source: AH8x2248ImZ9DB0KUhoMzkKFhp01ciLRmeCB4cZ8+npKXTVeJdtgMkdyRidTVu7qla4bxppMPUYguYDegYnrDbY0U5U=
X-Received: by 10.31.242.204 with SMTP id q195mr4871823vkh.188.1516812691874;
 Wed, 24 Jan 2018 08:51:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.85.6 with HTTP; Wed, 24 Jan 2018 08:51:31 -0800 (PST)
In-Reply-To: <20180124040232.GB1330@sigill.intra.peff.net>
References: <20180124025417.32497-1-jcodagnone@gmail.com> <20180124040232.GB1330@sigill.intra.peff.net>
From:   "Juan F. Codagnone" <jcodagnone@gmail.com>
Date:   Wed, 24 Jan 2018 13:51:31 -0300
Message-ID: <CALfSDjd0oZZmz1nKzasKu-Adn3LPS+AdLH4mYeR=Rx-PZpe4Jw@mail.gmail.com>
Subject: Re: [PATCH] mailinfo: avoid segfault when can't open files
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 1:02 AM, Jeff King <peff@peff.net> wrote:
>
> On Tue, Jan 23, 2018 at 11:54:17PM -0300, Juan F. Codagnone wrote:
...
>
>
> But given the lack of callers, it may not be worth the effort. So I'm OK
> with this solution. It may be worth giving an abbreviated version of the
> above explanation in the commit message. Perhaps:
>
>   If <msg> or <patch> files can't be opened, then mailinfo() returns an
>   error before it even initializes mi->p_hdr_data or mi->s_hdr_data.
>   When cmd_mailinfo() then calls clear_mailinfo(), we dereference the
>   NULL pointers trying to free their contents.
>
> As for the patch itself, it looks correct but I saw two style nits:


Thanks for the detailed review! I'm sorry about the style nits. I
focused on the tabs and braces. Next time I will take additional
attention.
I'll be resubmitting  the patch taking into account your remarks.
