Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB290201A7
	for <e@80x24.org>; Tue, 16 May 2017 05:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdEPFAZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 01:00:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33666 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdEPFAX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 01:00:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id s62so19917362pgc.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d/8zlJ5XiQ/skbSXe2AiN2W5noOtX4D6/8qMtWsyqa0=;
        b=O+fj7AOulcXFceFuaYbHiF7IUzOSZonEfFKlVjn745HlcLOpRx3lX2aAtIdQbjcjtu
         3HC0sr6P+fGUHRWWQFvQbfq4mQLCfApXxzi0jkpxQCkmRjgtKsREDo1VBvs1FSXlu7SC
         LKvNG2dNzzRXMd1LQ/cLoeAp9y1ZX7IqLlEJNyEIFNeAevCOcJFGGjf27q2FmcwQh4Vq
         RIOzGShZ6aAy7dINXNC9ZMHoRASvEeERE/xDVdm+3FckiyWWBGHfZv9gyiWnJplWbcny
         NLpoKs2AEcm123GMrYo4mRK81bk2IN1/cLP2QM+eenKTD7n9Ruk+kU3LZ41PFvfpMLYt
         hFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d/8zlJ5XiQ/skbSXe2AiN2W5noOtX4D6/8qMtWsyqa0=;
        b=Nm1+rlwzDQuzJXDdiOLQoErubwI1c8wXkTJ32lAmIcSl1pVKPhDtQpmvXNsoy9wRBD
         6epODzxhGvSRpQi9WWbCon9fquWSSfPCkzYZ5fpjBwoxeQfKt+YmU1wFachVrJ0ZJfso
         26VZvEoQvc5MgHmTGr1tnF8UsbLePpSZJY3GJoaAyEQcb48CNbK5Y4cCGBGGQ2RIahxI
         sWvHAaS+7Txqd5HML+er6OYG6LI0bjL8EzeyWa+JNSNZ1ZpYhln9nwz1ns8f19yS3hEB
         iL8Ro8vlyb0XYufBzA7OZSRn9B+Ylp0VE+pZFY2j+IzZfad7IgWjigAAJ4WgbpeLQhsK
         FeoQ==
X-Gm-Message-State: AODbwcBHftUeTygASPlapnjXYBSdQvixHIEVk21lMZE3W0amzNiwszZI
        ZjH1z2y9YLpa7A==
X-Received: by 10.84.224.70 with SMTP id a6mr13376789plt.38.1494910822882;
        Mon, 15 May 2017 22:00:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id t19sm23212087pfg.31.2017.05.15.22.00.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 22:00:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: Re: [PATCH v1 0/5] Fast git status via a file system watcher
References: <20170515191347.1892-1-benpeart@microsoft.com>
Date:   Tue, 16 May 2017 14:00:21 +0900
In-Reply-To: <20170515191347.1892-1-benpeart@microsoft.com> (Ben Peart's
        message of "Mon, 15 May 2017 15:13:42 -0400")
Message-ID: <xmqq1srp2y6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>   Add documentation for the fsmonitor extension.  This includes the
>     core.fsmonitor setting, the query-fsmonitor hook, and the fsmonitor
>     index extension.
>   Add a sample query-fsmonitor hook script that integrates with the
>     cross platform Watchman file watching service.

These two have looong titles ;-)  Accident?
