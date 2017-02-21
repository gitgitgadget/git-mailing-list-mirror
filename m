Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCCA201B3
	for <e@80x24.org>; Tue, 21 Feb 2017 06:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbdBUGDX (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 01:03:23 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35808 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdBUGCq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 01:02:46 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so9244197pgz.2
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 22:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oKm/KQv2qZA7qXToNSruHeqK4t0rOpAZmlHF6dyEziQ=;
        b=Jae2E5Hc4lfN8shMvDBwh0ZU9Bm8HBalHlCySucSPyKTwbyRWFqDJol+rt+jXdjdp7
         xYoPPFGKcdNKuGb7m19M3ZvumUdFOqAdnMMx+4OoqEvyuxlqdj733ybvSH9288eVtn8m
         NZUP5qIiHJ0iRs044056M04PXlT7gLvHUUrPElh4Ljvk9WrjsdTi5MbO5L0gwTTNHsFF
         fCTLiRPw+6zY1ZXj/HJo6ENqLY6TxE7qBgn0exvKqdPNkWSW9rhulVyfJaFjPSqaRjXA
         VaAfCgpmVSmGEsMTl39vgcDMvK8E+zlz3CaA+OWyLX5WZnh7AA4klK0e4lm98vMWFruv
         Rpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oKm/KQv2qZA7qXToNSruHeqK4t0rOpAZmlHF6dyEziQ=;
        b=MhZ1YB6m8yAnVWA7UHMVrV8JghQaRXVWHJJfaLtEsKckHLkxP/+nsyZjcg/gqzNheg
         nfg1dvqHguyZCcF4iFhIJ5gFCsFVPHLaz2aeK/Z8d+WwfMnk4D32rTx+zA0iowU5NigY
         swsA+e/w5FcxVSkeWg+ljX7aat9z7a9Tw9bZOBlNZ5o8MiQetxvPruPrUCzYaRyu/HLX
         ikNL2fsu2eSLFWMvmb9t8Jo7e3Xz7QWrptUlHgwxSxsUgYJMGbdplooCXD0nUlMu1tFA
         DAWPTxJiasJXlcmRa2/0yQ0bqRFf1Gp0N86b3ttHDQcj7ouVtfuFG+TSLnl3apC7mp+v
         YBww==
X-Gm-Message-State: AMke39mnO5YbcpG17Ji+KvcijInREpeamaQ6aNzQl35T4+y7/bhHxfCJJckw9nihPncExA==
X-Received: by 10.84.136.135 with SMTP id 7mr37477813pll.149.1487656965850;
        Mon, 20 Feb 2017 22:02:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id l3sm38478070pgn.10.2017.02.20.22.02.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 22:02:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Michael Fladischer <michael@fladi.at>
Subject: Re: [PATCH] git-svn: escape backslashes in refnames
References: <cb8cd9b1-9882-64d2-435d-40d0b2b82d59@fladi.at>
        <20161223014202.GA8327@starla> <20170221045420.GA24048@whir>
Date:   Mon, 20 Feb 2017 22:02:44 -0800
In-Reply-To: <20170221045420.GA24048@whir> (Eric Wong's message of "Tue, 21
        Feb 2017 04:54:20 +0000")
Message-ID: <xmqq4lzohyij.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio: ping?
>
> https://public-inbox.org/git/20161223014202.GA8327@starla/raw
>
> Thanks.

Thanks for reminding.  This indeed fell thru cracks.
