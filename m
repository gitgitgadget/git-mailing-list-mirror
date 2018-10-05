Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E051F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 16:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeJEXrR (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:47:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34187 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbeJEXrR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:47:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4-v6so14232866wrb.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=0FrkNEGYNaQRaMIY1Qm8zFDdfmDnzuhvGc1dvSEZc58=;
        b=Pfq1slps/MyVNlqF6T6TYMqBnFPISJCsjNTrytLO/PYrwXT5is7shw4QUutmf3m5cF
         Aosr9PAvozJU+FrYVMY2o3PNF28CU4j6l9ehl/896n+mFT3qdF7rCjQ0BFdwxo+aFXOl
         /3VWEjXWefBluUYeMzopeCEKTmP1Od4/DvII4cMYPYvcMJSDMP0KcCBqKq03h+r5oCEG
         vq9y387uUT/s5dmtHvcYGdRRy16kxf3gHrHrVsRPlt3YiSaRBZq5wvqzlCuDwClGPHm/
         mAOfHzv8wMXtDt1YrRHOv1OePPdqVJXdQlEEARvECT7fW/yp/DGc/v8VpDx2OB/j+nsu
         4wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=0FrkNEGYNaQRaMIY1Qm8zFDdfmDnzuhvGc1dvSEZc58=;
        b=LCO+B38L6t0LyNU9ue0bOtg0V+uBsEQt5Vorb1+iKgQlF3JgcU0VLba7FxBOFlEDtR
         dmFENOw3UGosDwZRRhlE610Ci6P5E2uzUk+VV1qXxijPCykqNppy7ppN4yVa9t1gVVz/
         dzgBAk7AE1uR5GvFZviiuH48MpT5NihPTkPPTQDuvywYMpMbuaPplByV19Bn9V26eo2L
         qNjkH6wQ9aksPw30BlpMAcBbH4pHiEy7DckBDNqHJ2ZndZSefBbQF18sjMMLMSFkVYFn
         pBDzs0oAHQIXL8eTGZoN3MRQ+76cWNLHqmDvzkKbCjo6tF0AiyB6BUTjfUJYf2GcL3/G
         hfJg==
X-Gm-Message-State: ABuFfohbDBFbGpvfq1gS49+fc/SuQ8gZ8U4Xt4KsHcvAAPce4C8PiWkL
        POs21yR5cevKQkMaxXTAKWo=
X-Google-Smtp-Source: ACcGV62oSViEfMfliZkIpT3H7v6i9225OSRRcZ+8XbrmQE1nTuOvRFGBk8DgnSeE8f/297WWCxLWKQ==
X-Received: by 2002:adf:db45:: with SMTP id f5-v6mr9040038wrj.237.1538758063837;
        Fri, 05 Oct 2018 09:47:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t77-v6sm1968623wme.18.2018.10.05.09.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 09:47:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/3] help: redirect to aliased commands for "git cmd --help"
References: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
        <20181003114242.9858-1-rv@rasmusvillemoes.dk>
        <20181003114242.9858-2-rv@rasmusvillemoes.dk>
        <xmqq8t3czty3.fsf@gitster-ct.c.googlers.com>
        <5e79944d-e82f-f4c1-00ec-445121769f42@rasmusvillemoes.dk>
Date:   Fri, 05 Oct 2018 09:47:41 -0700
Message-ID: <xmqqr2h4wdaq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

>> It also is strange to count from (0); if the patchset is rerolled
>> again, I'd prefer to see these start counting from (1), in which
>> case this item will become (3).
>
> If you prefer, I can send a v4.

Sure, if you prefer, you can send a v4 for me to look at and queue.

Thanks.
