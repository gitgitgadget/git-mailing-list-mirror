Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D651F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 18:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934336AbeGCSO3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 14:14:29 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33386 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934141AbeGCSO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 14:14:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id k7-v6so2902185wrq.0
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 11:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FJxS7kW1z9BKanD/pUPA+paBrho4pyN+dUSqh7Apa+w=;
        b=HDEqp+pMkS45Vxx+GxAmDmsQgPTGRvWfix+voSXoeFsXXw2gkIX6JW0KrkAU5tN5NT
         wfLDtbe6lfC91nG4xgpIqOMZ1U0tZun/10kjAMxvpmXPoQphclRuR1UtLULTBDRwtYlv
         AYf4uAVYXMIoUQxHX8vwD+zcu4PbE0X5bvAbny8UTTWdJXhz/vsDvzu6DVKtRQRJi/kE
         f6zCymN5YTFmY+n4xHKADC/mUne1Ai1dyqAo+YQ+fhApV6eIqpWaxNwHNga6rx3EB/o8
         9eGouobmB8N25CidWB+Vy6FauA8eDsF/qeScTGAftO1w1ac/kDoMBPo6+vuI8LX43NCO
         fchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FJxS7kW1z9BKanD/pUPA+paBrho4pyN+dUSqh7Apa+w=;
        b=jjq3G8rGJ1JH/4Oi0qxbKfysH95EU61aU/DCN01nRFEe3E6yUT2aPxBsMdRvdk1hF7
         beZ1oShhLOKEcGHHrNbXsSGzp+ox5PxCwTcw53VAAo3P3dMkqEiw1Oa8LSVE8Ct7Jrbk
         NG9FFpzIseIuX6CfLwZOC/CTJmNNvxePntm7fymqGjU24fmA/oBGB88zSuGcRnzAOLsk
         hUGDHv9gpzWMejkJTVE5+HWUNMFzs1cje44HJJFBZkoLrQp2xVs94/PurGPaRqM3lZTW
         DP1V7YgE0tOnuvxl7PSZfEmqVqon73qxjgV/tcmqcz6Af5ZSaXmPa7un7Lcte4dlsSC7
         tpnQ==
X-Gm-Message-State: APt69E0AOhZ86669s2paoOtMVnTomcWT9NT6blluD1WATKNCOeT/tJbL
        75OJlWaDQ9c5PNqAjuR5yEw=
X-Google-Smtp-Source: AAOMgpdM2rvhjP4t/EPavrxkkX2YWUnICcbf/Ip90LC9t/ixn7Mu4wDbjvuPjnFXaX0+BZbBTl8n7A==
X-Received: by 2002:adf:b502:: with SMTP id a2-v6mr24428972wrd.273.1530641667604;
        Tue, 03 Jul 2018 11:14:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 65-v6sm3341660wml.32.2018.07.03.11.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 11:14:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jamill@microsoft.com, mh@glandium.org
Subject: Re: [PATCH] xdiff: reduce indent heuristic overhead
References: <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
        <20180629202811.131265-1-sbeller@google.com>
        <72ac1ac2-f567-f241-41d6-d0f83072e0b3@alum.mit.edu>
Date:   Tue, 03 Jul 2018 11:14:26 -0700
In-Reply-To: <72ac1ac2-f567-f241-41d6-d0f83072e0b3@alum.mit.edu> (Michael
        Haggerty's message of "Sun, 1 Jul 2018 17:57:35 +0200")
Message-ID: <xmqq1sckrxtp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> So if `N ≫ M`, there is necessarily a lot of repetition among the `N +
> M` lines that the hunk could possibly overlay. Specifically, it must
> consist of `floor((N + M)/M)` identical copies of the hunk, plus
> possibly a few leftover lines constituting the start of another repetition.
>
> Given this large amount of repetition, it seems to me that there is
> never a need to scan more than the bottom `M + 1` possible positions [1]
> plus the highest possible position [2] to be sure of finding the very
> best one. In the pathological case that you described above, where `M`
> is 1, only three positions have to be evaluated, not 100.

Nicely analysed.
