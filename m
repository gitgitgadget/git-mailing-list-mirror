Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2690207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 05:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979740AbdDYFdP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 01:33:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34442 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979270AbdDYFdN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 01:33:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id g23so7851292pfj.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1QfuyxuB2LEAWtVk1FOAd2Iqm88GFMPwNpYB0e07hgE=;
        b=G7mJ2ayRwR0Zi3eRLqxgxw/v9x8dBZ7R0vXQc6WVWbyBWFq3UW3xF6e/Cm0J7mNGkO
         8+wHyyCL1evRQfU2/bLGGPPKbVgnXVFmr+5B03k+C9pVbuW5imOXS0auQG99Z1z5dCHq
         BB+yaIAjGZ/3+6+oEL14F9YCVHVhkIm/AjAOc4zHRELXkW+8FetzA8+HBd7fpp0Ndb9g
         cz/Dbq/GZCydQUbsftPVgAAUYW/8Dk6FBKsdcadfxDVEzGqWZrgWHBOaWcyOVLF1xsa1
         YUAZvdQi3od4sQ0Pv9R64EKjGkcKB8Bqef9UMuce1Ff+WRBPaO5JEhJLhfJfgg8rNsvR
         4ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1QfuyxuB2LEAWtVk1FOAd2Iqm88GFMPwNpYB0e07hgE=;
        b=Y0De/6Amrml6lvcBB4ckG+MofNH1Dv+AiNnLn4dykmhqTPYWbgHGMzhAASMKkpUnzE
         CFw1l0UROEvP9g2rcQlSdg808xhjOEp1yvbw2EBzJWynW1NJRLh8+J34lEs+5qgq33gK
         fupvaz7dSIbS8os34JFY1mFFpRNEwsHNfqH2HtPQZjvKSjxijTGdwH0o1+oztsMeyYea
         U9ujfFdhRWZziv3JD11pJVAlkPoZ+RznWtMiHjq1UOJ1W44jwb1ORtnSvuJ559rk+0vp
         eaSE+lcZ+RfMHe8W68/vnTmq51ZsG+fYy5eBFutstgDatM97N8md9pFCnkACanib56Dz
         KAWg==
X-Gm-Message-State: AN3rC/74TgC4mmfxTFm+FCRzF2zHiuNZB6H8vcrFR4Ykvtd7XyuuZeVx
        tuf903tSG5Anvw==
X-Received: by 10.84.128.47 with SMTP id 44mr36329614pla.35.1493098393086;
        Mon, 24 Apr 2017 22:33:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id p187sm1392914pfp.129.2017.04.24.22.33.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 22:33:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Miguel Torroja <miguel.torroja@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] fast-export: deletion action first
References: <1493079137-1838-1-git-send-email-miguel.torroja@gmail.com>
        <20170425032927.74btvfcexbdq4rmz@sigill.intra.peff.net>
        <xmqqfugxw1us.fsf@gitster.mtv.corp.google.com>
        <20170425044641.sx5uoql4oiug6iq7@sigill.intra.peff.net>
Date:   Mon, 24 Apr 2017 22:33:11 -0700
In-Reply-To: <20170425044641.sx5uoql4oiug6iq7@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 25 Apr 2017 00:46:41 -0400")
Message-ID: <xmqqy3upuk4o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Anyway. I don't think Miguel's patch needs to solve all of the lingering
> rename cases. But I am curious whether it makes some rename cases worse,
> because the depth-sorting was kicking in before and making them work.

I agree with you on both counts, and I care more about the second
sentence, not just "am curious", but "am worried".  I am not sure
that this patch is safe---it looked more like robbing peter to pay
paul or the other way around.  Fixing for one class of breakage
without regressing is one thing and it is perfectly fine to leave
some already broken case broken with such a fix.  Claiming to fix
one class and breaking other class that was happily working is quite
different, and that is where my "Wait, we also allow renames?" comes
from.

