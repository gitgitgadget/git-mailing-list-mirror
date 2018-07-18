Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC0F1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeGRVhp (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:37:45 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33882 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRVhp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:37:45 -0400
Received: by mail-yb0-f194.google.com with SMTP id e9-v6so2418843ybq.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcZzbiOJ7qLwpPYl6iYhj4F8IYAkFyk+izKlkTzkBfE=;
        b=l+ih7uKn2ISfcD8wUiM+qjTRjuCIEgnH+u3Pbdpcm5LmuOyx+M4iMK1UqXS5H6xXFL
         sYxAG+9nlB41yBBeOzGVYszs/NeyNhPF5HFakSVK1SKn+5lvNl1tVk7qRcHr7WQK+fur
         L+7TqKxZcgKQ/baHHLdehV2TN8txL2coWg0lOOXtQ/bOzIpz7NUdCvQCNGAaGpo/Jn/3
         BwYMSCo7x4slD75jUTQnftCbPad7zhoID3YZUDDPBJLbN4CtfaHcfjwqgLRE9VYBs1OV
         Qk+wHW3Gww6knT4MGSHKNAXfh/7+jD9zdpsWzPdlPNZI4Q9OwDO05KI8ojNWNMBd5NXv
         AZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcZzbiOJ7qLwpPYl6iYhj4F8IYAkFyk+izKlkTzkBfE=;
        b=RSFkNt01IC9fy5ZtO0L1za270VOsA8WLtt+z75I1NgFzppmuucP47H6VJe49L55E2F
         53dCapqtae9j5mS0ypVA3s7qc06jHHTRU7pFSy6MMoyhhcA3d8IIQZhI9LB9p2IIgdT5
         Rpg08CoEwjELr7ZgRxOYex70xRb8weKC7QmQSii3pNRKIFuEt5N24Iw5sI2i+emVZYR9
         RaPTvsLIQq7EVNiRLeg7QNAfayN3i1WqAdqKeQMEurT8G8Vxuyod/xJ1yw2lhjpGCUCt
         Jo6K6yE3Ur45SMiWkSgpa9DZ6VzhUnu3nvcPAVWvAuPPTquYQgzKUjxiswPlGEh0eaba
         +bEg==
X-Gm-Message-State: AOUpUlE3goWxS2m60b8DlpLSCEXqHnFtcmoYBDKYz0NakWNb1PBocFlt
        kxahw9rzJNMr+cxlO6Og50SJXSMsIV7Uv6h3JdIyZlOtmns=
X-Google-Smtp-Source: AAOMgpeltCksmVlf+F5pvYQvFbC91XbT86tx3H0PPMyzqy7DLdAyBv6xYJf0X9h4dVWJIFC+ctiOInXz4MPZEvAxMvc=
X-Received: by 2002:a25:b091:: with SMTP id f17-v6mr3991725ybj.167.1531947484758;
 Wed, 18 Jul 2018 13:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180718204458.20936-1-benpeart@microsoft.com> <20180718204458.20936-2-benpeart@microsoft.com>
In-Reply-To: <20180718204458.20936-2-benpeart@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 13:57:53 -0700
Message-ID: <CAGZ79ka=GkwBLeC1SK33dCH6X91kEeMAFUuDci5GMxyPgO3gXg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] add unbounded Multi-Producer-Multi-Consumer queue
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 1:45 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
>

Did you have any further considerations that are worth recording here?
(memory, performance, CPU execution, threading, would all come to mind)

> Signed-off-by: Ben Peart <benpeart@microsoft.com>

> +/*
> + * Initializes a mpmcq structure.
> + */

I'd find the name mpmcq a bit troubling if I were just stumbling upon it
in the code without the knowledge of this review (and its abbreviation),
maybe just 'threadsafe_queue' ?

> +extern void mpmcq_init(struct mpmcq *queue);

We prefer no extern keyword these days
c.f. Documentation/CodingGuidelines:
 - Variables and functions local to a given source file should be marked
   with "static". Variables that are visible to other source files
   must be declared with "extern" in header files. However, function
   declarations should not use "extern", as that is already the default.
