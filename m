Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1586D1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 18:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934471AbeGCSaS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 14:30:18 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:40176 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934398AbeGCSaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 14:30:17 -0400
Received: by mail-wm0-f43.google.com with SMTP id z13-v6so3278138wma.5
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jIL+Xlv+NDCfjBCfo3cosI8BmFC4JbCYjxLPfbhDiSw=;
        b=CzCIqXEITjR9rp0J8gGVeIshqoMVL+Y8vE0bgj17VaBM4mX2XEfG2A5yrsKhUYk/aJ
         LM6eRhdAPPpCMJMKmnq5XRCF0fHtVvLvlXRRaNgMhQw0VHjnifLdNm/jDvc+bFhoxe6a
         9nl0RyC7uiQb7Fzowei2xDPRRzql9M2I9IpNRJSXXHoYbBksDoKN2k9gWNG0m2uXRyS0
         EOoCRipwM8g2ZfWZEFVFSqk5hcW3rft67FaQX/3XZ79oY5RXrSYmpUSdnXAaGAHadIyh
         /NFoaG6QBEvo0tqur0Oud1peNNwrbAIr2+S1rf2egEMkelu1p60xMT51WbR9LbBlqqOr
         8/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jIL+Xlv+NDCfjBCfo3cosI8BmFC4JbCYjxLPfbhDiSw=;
        b=BoI6Vx+Bhs0Glyj3KS8h0Q8h6KXH43ngRQRJxgbVvxMXAMu4xW/T3TKK3/ODddBrDg
         8HIYRnCr4pCR20kLWnrVCLzZwKfnvZuT+bYuti3SvEw76VVIw5IuxAMLWfbnT8sUcyU6
         2dyEzw6UJFu7H7kSt6BoyWQDt5w4EFa7kuYv4+KwUlQHEIUgRrUh7Sj2UlOCRKLS17zS
         ZQ+phYjYRnyIBPN/ky1w98MQ1/lqh06iJD6z9K2YukSBS8UlC9Q3R/gHPOWAlvC9Z3Gj
         PhDRNftkn5SWFTfOdsk/vwYrRVeAl1MGtPo5uBiqnGgF4u33Bc+2YGZ3ab1MRkMJbAaJ
         MN3g==
X-Gm-Message-State: APt69E0w8xH4hHbCILmhJdyOMrnvAKmpPblV+bZmDEVcjnXwGSdldljk
        syPKWAdBYyWpR56YMqpvrxM=
X-Google-Smtp-Source: AAOMgpdryCxNOOU5luVdHa6L3C2uxJzbf7SNKrzbJ4tawYtwSfaQI34DiUwFzN6ihMfjNDl4hvAOfw==
X-Received: by 2002:a1c:f513:: with SMTP id t19-v6mr12487328wmh.50.1530642616269;
        Tue, 03 Jul 2018 11:30:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s10-v6sm4482211wmb.12.2018.07.03.11.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 11:30:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/15] apply.c: stop using index compat macros
References: <20180616054157.32433-1-pclouds@gmail.com>
        <20180616054157.32433-3-pclouds@gmail.com>
        <xmqqbmbypyis.fsf@gitster-ct.c.googlers.com>
        <20180630083825.GA2436@duynguyen.home>
Date:   Tue, 03 Jul 2018 11:30:15 -0700
In-Reply-To: <20180630083825.GA2436@duynguyen.home> (Duy Nguyen's message of
        "Sat, 30 Jun 2018 10:38:26 +0200")
Message-ID: <xmqqsh50qiiw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> A singe patch conversion would look like below. But for that to
> happen, convert.c, rerere, ws.c and read-cache.c have to be converted
> first to not use the_index.

Yes, that was pretty much what I was driving at.  I do not have any
trouble seeing a patch that converts callees that are deep in the
callchain and are meant to serve helpers to make them capable of
working on arbitrary in-core index instance.  That's a welcome
change that allows us to reuse them in more context (namely, by
callers that want to work on istate that is not the_index
themselves).  Skipping the "intermediate" step like this patch would
force us to focus on converting these lower-layer dependencies.
