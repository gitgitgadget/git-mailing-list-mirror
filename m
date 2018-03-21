Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E981F404
	for <e@80x24.org>; Wed, 21 Mar 2018 17:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeCURXl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 13:23:41 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45043 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeCURXk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 13:23:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id u46so5990837wrc.11
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P4HCwcajh98vFJGzpn6BojjFxH+NznILTfli+5i0C5s=;
        b=VduNjRqsELii+btLqJAe2/OIXui2snCeeBevL6pNCzYiQo7INS9qOM8Slhdgb6m7RE
         mSSvGiMQMiIN0r++G1JMdHWy6CmLdjAs9KOojwBE/1j8XllDqJbh/0brKEQ8Gh3hucoj
         2diIYaJxjvrpa36gmFvhMEP800jUx12wIjDuyExB+ZM+SvfaL5g++IApvVHTsKzzUnhD
         NESq/1kO1C+RCgo6D8e+znLigW2wg7g/lIg3vd4FJnAkRFYsxDMvK5wDFnwsh3onZMdS
         lSRA/ay/lzTBzdXwG7XVgEBSqV+uSj3zjxW5VpFtiEx33oIeI0dGfx6yKBlXVbRTiM+x
         CYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P4HCwcajh98vFJGzpn6BojjFxH+NznILTfli+5i0C5s=;
        b=G/VACldSuy/KNHoaHr4aYdrTiWUZUocv0IVx/ZXAWafmSDJmY5RmmHm6r29pgJBThi
         PrwBBCSLIg8QVJA4htTA0ty+fC3VhpPZnE0YQRVvWkWmv3sFBxtu9SB56Um+HtiXwc9p
         STeKqXMXNQ1mJykibV3QebAq2dKHb/r76H3e4ZcItwey6Rwr58VhuCFocxuMIdULCGKd
         axAoHG6bFAmtg5fpR2+NWUxPrzbClWmpHo4d1tw3slOUbsbjMS4IAdEC7M9TMtJKWVbn
         HZwBJy5QLueZkm1mqx4CDbbtcFUagvt/gfmwZgLR6OE2r19N/rZuiOxRXNZeEIMA6tKk
         EOPQ==
X-Gm-Message-State: AElRT7HooVMdFbJlC0dVNN6rSgdvKCS8O4xKxXNNg8FHeDRcXkE2jYc8
        bzJ8VlpTFoBSaxFrjD8/HsU=
X-Google-Smtp-Source: AG47ELsV0BOPymqDAdLp4O1U87TXxpzXFxVeRxTAaxKr2hQN57cheCkD5rQLmzUpWSLXDdi8bL1/Gw==
X-Received: by 10.223.130.194 with SMTP id 60mr11995345wrc.46.1521653019050;
        Wed, 21 Mar 2018 10:23:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a63sm5335535wrc.22.2018.03.21.10.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 10:23:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk,
        Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] log --graph corrupts patch
References: <897b7471-037a-78d9-fc11-0624ef657b4d@talktalk.net>
        <20180320060931.GE15813@sigill.intra.peff.net>
        <1e686ea0-90ac-f3f4-7bcf-6951c9253598@talktalk.net>
        <20180320155814.GA32366@sigill.intra.peff.net>
        <20180321054718.GA13936@sigill.intra.peff.net>
Date:   Wed, 21 Mar 2018 10:23:38 -0700
In-Reply-To: <20180321054718.GA13936@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 21 Mar 2018 01:47:19 -0400")
Message-ID: <xmqqsh8tpckl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> To make it bullet-proof, I think we'd have to actually parse the graph
>> structure, finding a "*" line and then accepting only an indent that
>> matched it.
>
> Wow. Nerd snipe successful. This turned out to be quite tricky, but also
> kind of interesting.

The last patch looks quite "interesting" ;-).  The idea is sound and
probably the execution, too, but it indeed is tricky.

>
> Here's a series which fixes it. The meaty bits are in the final commit;
> the rest is just preparatory cleanup, and adding some tests (all are
> cases which I managed to break while fixing this).
>
>   [1/7]: diff-highlight: correct test graph diagram
>   [2/7]: diff-highlight: use test_tick in graph test
>   [3/7]: diff-highlight: prefer "echo" to "cat" in tests
>   [4/7]: diff-highlight: test interleaved parallel lines of history
>   [5/7]: diff-highlight: test graphs with --color
>   [6/7]: diff-highlight: factor out flush_hunk() helper
>   [7/7]: diff-highlight: detect --graph by indent
>
>  contrib/diff-highlight/DiffHighlight.pm       | 89 +++++++++++++++----
>  .../diff-highlight/t/t9400-diff-highlight.sh  | 81 +++++++++++++----
>  2 files changed, 133 insertions(+), 37 deletions(-)
>
> -Peff
