Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCAFF1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeGFVow (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:44:52 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39343 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeGFVov (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:44:51 -0400
Received: by mail-wm0-f41.google.com with SMTP id p11-v6so15533460wmc.4
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QQ1P7+6F0pzzPqlsuVC9bRvKuD4ZvkE7G83OaZIiC7k=;
        b=oQHrf/KLPotZY8D8ydZSmUAdPJIpszbJ6vL5mj7pDiMlZViKiMtmtpzDdj51cER+OR
         NvCJIahFgnzK0ZrNY01pZ8FiIaSAEd/67kFwbH1MRuz3yaE0Avv5ezxKO+yIrOMXUNov
         7Dqz567C2lMfolGGf99rjmrZyCtwKf3nJxOMgbJqrwlVrdcdYqFUF5VswcwRPcRFdwsE
         9sXJ0vQKioZr2WySwxQqQi77IhIGL8uZBEhQUwWiOKgAXwvUV2aRgadOzJelb5K3Q+xW
         3woo3nvy1dcrqhjeKGv0UYdnWmf72vNBNHFBCoLfAx9DDQjKYU+kMY6ctGDBxvBTp7Z0
         /Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QQ1P7+6F0pzzPqlsuVC9bRvKuD4ZvkE7G83OaZIiC7k=;
        b=fJ5E16Jn7Vthf7DMp+PML2FnQIyRMBkpbNskuLVWpMNPWv6Qgmg80TeVE6ASamDuYI
         L34uESHNS8gbicEY1vLeX4yBcwkr9Q7oR+kz9lR3m4f4VXN8wwRtyYTkiM0QQXXZ2rfr
         LXiN5kLtO/2jJOCBBWniGKFIDNFw4KxrHBSwxdTCGX94tGm/WOfKlorapVJnmc9pSqmZ
         R0s/cRxYSbCzJJNZNQIMw2vBrX82HDOlfLKsiACTRfqAzv/4PFvDKmk3gsHYtbKL6uRS
         exNWeMEoxHF0LksL97BkiYMvpDQt5iNf6Z12lLpih8emuNT3kI5s/Z/rzZgjOU4A8fpg
         NPDA==
X-Gm-Message-State: APt69E1Zll9x/1md8Cr7x7MZeXtoe3Sts2feQvh138+pr8ziO4zgN2J2
        mW0qIamaAWEq42/IcfF9vu4=
X-Google-Smtp-Source: AAOMgpcFq2DAQd9cyI54WkdAO+7N77d5ZfneB7KTPRb1BSN2iAmdR43rZhpxxoWoJF2jhMkT2nTsoA==
X-Received: by 2002:a1c:9042:: with SMTP id s63-v6mr7030863wmd.91.1530913489789;
        Fri, 06 Jul 2018 14:44:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g11-v6sm4818652wrm.31.2018.07.06.14.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:44:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v3 0/2] grep.c: teach --only-matching to 'git-grep(1)'
References: <cover.1529961706.git.me@ttaylorr.com>
        <cover.1530654455.git.me@ttaylorr.com>
        <20180705142110.GA10192@sigill.intra.peff.net>
        <20180705143401.GA87330@syl.attlocal.net>
        <xmqqlgaokyy5.fsf@gitster-ct.c.googlers.com>
        <20180706201522.GA657@syl.attlocal.net>
        <20180706203339.GB4648@sigill.intra.peff.net>
Date:   Fri, 06 Jul 2018 14:44:48 -0700
In-Reply-To: <20180706203339.GB4648@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 6 Jul 2018 16:33:39 -0400")
Message-ID: <xmqqbmbkhwdr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> FWIW, I like the GNU phrasing. I thought the "non-empty" part was not
> all that interesting, but after hearing that BSD behaves differently, it
> is probably worth mentioning.
>
> I think the actual behavior of your patch matches GNU grep, and does not
> need changing.

Great ;-)
