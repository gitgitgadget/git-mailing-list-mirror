Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDCF20248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDIPnr (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:43:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46441 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIPnr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:43:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so21500360wrw.13
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qVYl6qTO+v5D+kBblRKujKMZn/9Ij/PtLOAm+DZYi5Q=;
        b=TjtP6Thc6tOHiVEn+mHKMDZav+ih/qvo4LoPqVJ9WmYkqdALiA57+S/Hded1WKn+F3
         waGUYUym9MpG5dp0PfgwJJJudoRfeX0Xmx3wj6fBUv44CMTmw4htPrzROHYZdApCi90L
         LlcvbK+AEF5Fga/oPWmxu8bORVtGIbWknpmIA68zbPI5Xk78Qpza2HUL8SJN+l0VLHDb
         mcNDrfo7xF5tNmU2Dvq9HxZWhA9kZr6dWxe/FJ6WYOrAMWkraC5OQczmLKW7mwrExROK
         t/J1ZlUdJkXcE0ERHEFBmVL19eCldJBEPPi3MS7FF6OVDf2YUfqgMSSGu1GJYMwviSz2
         +BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qVYl6qTO+v5D+kBblRKujKMZn/9Ij/PtLOAm+DZYi5Q=;
        b=ooL25KxmfO9t3L+tegU8HOCpv/p3+C+BAn0LFJkzzZfuuY9PVAThAD/MTs/ynS3LFu
         oEWOFNfaQfdgqMaXtDLI1VqgjYZZsLYZfuz+y56vckFTIN9tphs4TADiT5XpoipuAjWn
         HrVguEs+pakvl64uu6IxNuJKh7QvJcsmUwljWIWJ88FFXZbPoZMWoPkTa4tqQjZQj2ZC
         UNQ+JqqDHBODSI76sSUczQMAJlcTeB8j/RpfcwxG2zHWBdzy9/xi1w8fZEH1XYyhRdsO
         981dc1ehtxu2UxG9Y5BNZc0RbUvHqdE5FTdVpQK1UQj1kESf6hnbha+Z4t5xi4TRRN07
         TVig==
X-Gm-Message-State: APjAAAX5gh0LAWrJmenM4MmBpqPQhkARDpNs+VfZN1khZoIq5BzygZur
        DXQg7xKdaefh9597ipe55mw=
X-Google-Smtp-Source: APXvYqype71412Lar1cXY4zOYHp19ulacsNsfComKaaeA8wDiWZKS281uV3iY9iZ+JSTpQ34tHuWjw==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr22827736wro.78.1554824625036;
        Tue, 09 Apr 2019 08:43:45 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z14sm51148642wrv.78.2019.04.09.08.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:43:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
        <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
        <xmqqo95f43dq.fsf@gitster-ct.c.googlers.com>
        <20190409151559.GB12627@sigill.intra.peff.net>
Date:   Wed, 10 Apr 2019 00:43:43 +0900
In-Reply-To: <20190409151559.GB12627@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 9 Apr 2019 11:15:59 -0400")
Message-ID: <xmqqbm1f421c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 10, 2019 at 12:14:41AM +0900, Junio C Hamano wrote:
>
>> I've dealt with the stray double-sign-off locally, but is there
>> anything else planned for v4 or later?  Is this performance-only
>> change, or does it have an externally observable behaviour change
>> that we can easily add to our test suite?
>
> I am OK if we do not include it, but even if this is "just" a
> performance-only change, we can always add to our perf regression suite.

Hmph, that does not say much about a possible change in behaviour in
corner cases you guys were discuussing near the beginning of the
thread when an object can be reached from both a non-promisor and a
promisor object, does it?

Shouldn't we at least tweak the log message to record that we were
aware of the possibility even though we couldn't readily come up
with a case where this optimization breaks things?  I suspect that
it would help the next person who needs to deal with a possible
regression coming from this change to understand the problem better
and hopefully faster.

