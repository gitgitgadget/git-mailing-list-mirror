Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088E81F453
	for <e@80x24.org>; Thu, 25 Oct 2018 09:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeJYSHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 14:07:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50952 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYSHr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 14:07:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so815306wmg.0
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z3wiXty+VYThtfTZ96Fmbp+gcfwRHsWUPBKvb+BoTsY=;
        b=lNab7Z5XhvYMJI2DW/9EG5tqzTOJsBuDPVaFVwPJn+DkV+36KZjj1LL4o0F4kcPtaK
         QFRd9uNDgMQlqbl7ItlbDnyv+ja3HnY9fARzdiNVjf7zrorswRG9wZyOxrcSCbrUgEiv
         5WPukdd+uUGCduLigsi2Q9q+jBQdiOIRAN7ebbxq6+L3jekiY6YYuhFB3BNV48MdiJDx
         hKcXrviLrKGvfx9VlopFlpElds4tUIA30iG3oNcFVt8XXphVzCeJ10ItKzEk8YpWPe4W
         3zSIwMI6GpDzyDpY+7HcObktCAj3ob4Xzh15nA6D9NmQ8F2RUPpu4AgxwVJC2Zeup4jM
         U5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z3wiXty+VYThtfTZ96Fmbp+gcfwRHsWUPBKvb+BoTsY=;
        b=DofX0eGs7BiEPoACsz2v4jdhVmw2OuMGFhZBLVZlXxR4qGR848TLurTTsqwPaybCjA
         O2rf6oURT4CXAGR7+oXi66tfHxIMdzuuwIgjtmsos3sUrLdHj7oE02nlzzcRBHvJF5rv
         cEAqviBPcnZhQJFJUh9s+9+79G7rHvB4Bag/FZI5PVPICJJzyHAWcXRVdd4ERj3JbhNz
         zgMlRSY4aoJrHF68RM8HeiBPfUG128wxNJr6eNB0zd3ZhsUVo+3JYlaw29l2OvVtG7ac
         GIxSumvV9gE7kE1zEe73hpR4/NRV2ULB56iMLo7PlZufkaSvWNLLODvJ1MnoWeC1q+WW
         zMJQ==
X-Gm-Message-State: AGRZ1gK61T0EBjNFUxK1EFoWoHpD2xQD9dTfcXFrCn9IDN9Z3giIUeOt
        NvKKnUpVaCtY/uBxi6XbLEgNe/f2HvM=
X-Google-Smtp-Source: AJdET5eCEX/PNiiFG8B7XZCmSp9t/vKM4Ly2T8xyKVgwzz/sSbyzN04LOl4nEZRaA99eAP9boTfwng==
X-Received: by 2002:a1c:2746:: with SMTP id n67-v6mr1062082wmn.116.1540460149491;
        Thu, 25 Oct 2018 02:35:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x17-v6sm4490949wrs.84.2018.10.25.02.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:35:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 2/3] mingw: replace MSVCRT's fstat() with a Win32-based implementation
References: <pull.53.git.gitgitgadget@gmail.com>
        <f2ce9bdc01892b514f75c6c25c3393765593b1ca.1540290197.git.gitgitgadget@gmail.com>
        <20181024022024.GE6119@genre.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.1810240927520.4546@tvgsbejvaqbjf.bet>
        <20181024224047.GF6119@genre.crustytoothpaste.net>
Date:   Thu, 25 Oct 2018 18:35:47 +0900
In-Reply-To: <20181024224047.GF6119@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 24 Oct 2018 22:40:47 +0000")
Message-ID: <xmqq7ei6gyh8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Yeah, that behavior is quite old.  I'm surprised that Linux ever did
> that.
> ...
> I don't feel strongly either way.  I feel confident the rest of Git
> doesn't use that field, so I don't see any downsides to keeping it other
> than the slight overhead of populating it.  I just thought I'd ask in
> case there was something important I was missing.

OK, I'd consider that this part of the review settled for taking the
patch as-is.  Let's mark the topic for merging to 'next' soonish in
the what's cooking report.

Thanks.
