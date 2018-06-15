Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C0C1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 18:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756464AbeFOSdS (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:33:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34597 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756355AbeFOSdR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:33:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so7637540wmc.1
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OCjCUy5Ix7T84IjJrhUTFhLwTwx7v1B1fFpPkRbVFcc=;
        b=K2MWhbB+qPSmjEwprjaFLUFo67vAh7AItCoOL1TKDiCy4e8XkYeKp2SPcuiima7fYp
         IgB2WH/bgQyFu2PyL1NFyBidB9GbRRkg2B05FHynXrvbtIb08zSJc4kh3XaiUcEdYfuy
         wjRhWFcU64sXZuazreWVaPOR/PwX2ke5cgqYKyrBcEfCH+GyuKRMDa0SG2fnYbxNVyrY
         z1rcHewyMEojJCcszuE6BCzOJ7JFtHx8D1RQzJJtL2CrObXPhWETuw7pUC1HepZibhOs
         +xb6AUU709VmW9oi7WJ09euRR4s/fDkqXAzenszn4Xhs7DHEgI9f4+EL6CIgatgE4Wah
         NYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OCjCUy5Ix7T84IjJrhUTFhLwTwx7v1B1fFpPkRbVFcc=;
        b=mmT66XQSejRif0R7C6HdL+sTWV87SHcwUjjBFKQg6+P7SArowfSDsLyphl+9JY6Q/0
         yD2rabKTTU6rH9ILEzlu1qal0jEPuNkPWMe5rtjN5aATKzDoOW9lSKY+4AU8NILUKKs6
         XH+mZymHPwLevJsAqwal7B4Tz1hK/x5FbK+Dx1rrZuFSO6tWKCQv72vdwX1V2cRxS8oH
         NXLJRRWBuR9LtAyLRGgoGfJeC8ZIFq4IeEB6dMUcCCztpu1JhWhMGoIQKhYRrAdSJ6AW
         x187glzitFZZvV/g32iZp0ooYllLC7RE9S07U2OunsfqeWB2qt6dphj1QKbi9Hy5n2/x
         QzHA==
X-Gm-Message-State: APt69E2blyw7/pOf59Tmg0LElLKvYRChPDqj9gmsCq6uLByqsD4hyO96
        tKJ2XU5fIqzTLo6UQQfDHpo=
X-Google-Smtp-Source: ADUXVKJhwkaOqN4EhD1ZW4Q/dWaFihfmckhPz7MmSpo7OMc8BuzcLx0ox5U3Tj19nse6kTgyiyo0eA==
X-Received: by 2002:a1c:d905:: with SMTP id q5-v6mr2191683wmg.78.1529087595700;
        Fri, 15 Jun 2018 11:33:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t9-v6sm1636712wmh.41.2018.06.15.11.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:33:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] ewah: drop ewah_serialize_native function
References: <20180615032850.GA23241@sigill.intra.peff.net>
        <20180615033228.GC20390@sigill.intra.peff.net>
        <afbd5335-ef0d-5ca5-84ab-bdfa8bdc50bb@ramsayjones.plus.com>
        <ab6378a8-3728-7fa8-da08-b58ec768dbfe@gmail.com>
        <20180615175111.GD3067@sigill.intra.peff.net>
Date:   Fri, 15 Jun 2018 11:33:14 -0700
In-Reply-To: <20180615175111.GD3067@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 15 Jun 2018 13:51:12 -0400")
Message-ID: <xmqq602j293p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One thing that gave me pause on ripping out more code is that I have
> some bitmap-related patches on my send-to-upstream list, and I wasn't
> sure if they used any of this code. But I checked against your patches,
> and no, this can all go (which makes sense -- my patches are about using
> .bitmap files in more places, so they build at a higher level).
>
> So your patches look good to me, modulo the declarations that Ramsay
> noticed should be removed, too.

I'll queue your 1/3 and 4/3 (without 2&3/3) for now and let Derrick
and you handle the removal of unused stuff separately on top, so
that the fix-proper can graduate earlier than the rest.

Thanks.
