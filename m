Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754D71F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbeIYEAS (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 00:00:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36700 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeIYEAS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 00:00:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1-v6so21220743wrt.3
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WiRbzBxkqQc9j8pjqVCnV1ZBu6ZM/EUsf59Mj4SYUY8=;
        b=bd3O31pfwvVwIrwPe3ngjWkFaES0Vb2F5SRozy152eNxoi5fpnDBsyI/nK0MQiULgY
         nw57EVjLorGF3v2qJKzgfbSsLowd7IU9kHIgpJ4LWJAP6ggpNtsPQx9eJseC+Jtded2k
         FMdTsxq6ELwcyeW+pBBHu7bmhwKzMP+vZazwq+LcMqWmdHlTL67MxBJmjGzujzSFbP1N
         ZEWbbLDNGhQmZl1rsoLjuC1TkyzsYBuFrWN6KHtAFmAXthkhjrz9SrDiRtMMK3Gk7Fi2
         l9lOSuBbRGS/MZCebsiKnXgCXMT8XjLmeWK2JvSyOkZ7YuhJqT8w45yUrDO8AG97zK+b
         bv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WiRbzBxkqQc9j8pjqVCnV1ZBu6ZM/EUsf59Mj4SYUY8=;
        b=ICPq0y/Xs0neNL8ihx9QQU6RQh2Hhn0Rucy7h7k3QieTlMExTCOl6j9l8BOiXkFYbN
         4LJU1F9f+UuepHUHw9EtXnjIv4qt9dUNy7OLlCscfPXb2UPKPhrD/mTSu7/iAqt/7IYh
         e4rAeIWE4D063zctKnCp+4zplRZ+1BT2ZSfgGfqiX5as3laMACfggRs0OkRwKekX7se8
         2pnsM8BVg4GkzQBRo5WmQP2+7hAR8N3G+6RiSZgquJ1D8SKH53a3kHwS/vF/S+nwI8+o
         NVAZH3x+a/Z4ghrBOjl24UQBMklYSy9HbsAzODczEeiPPAY2oCcAnLrSLUtT5x3bf1NH
         mLNA==
X-Gm-Message-State: ABuFfogLnDQKfML/JSy7muKAlS7sNVorTOhDfWgU9Zj+YLuhLM7eA4jn
        VnN8WZRESxfokL6OjA43g0lalORD
X-Google-Smtp-Source: ACcGV638wfZzpXg76Hgn7+KxRylXK1GUgoOAB0UmBa8yxAaOcbPN2St84kO5ChEjr9CPx1CF8fdxdQ==
X-Received: by 2002:adf:8024:: with SMTP id 33-v6mr537910wrk.16.1537826158871;
        Mon, 24 Sep 2018 14:55:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c8sm519430wrx.92.2018.09.24.14.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 14:55:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
References: <cover.1537466087.git.me@ttaylorr.com>
        <cover.1537555544.git.me@ttaylorr.com>
        <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
        <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
        <20180921213753.GA11177@sigill.intra.peff.net>
        <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
        <20180921221832.GC11177@sigill.intra.peff.net>
        <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
        <20180924181011.GA24781@sigill.intra.peff.net>
        <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
        <20180924205022.GA26936@sigill.intra.peff.net>
Date:   Mon, 24 Sep 2018 14:55:57 -0700
In-Reply-To: <20180924205022.GA26936@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 24 Sep 2018 16:50:22 -0400")
Message-ID: <xmqqva6ur24y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Do you have an opinion on whether for_each_alternate_refs() interface
> should stop passing back refnames? By the "they may not even exist"
> rationale in this sub-thread, I think it's probably foolish for any
> caller to actually depend on the names being meaningful.

I personally do not mind they were all ".have" or unnamed.

The primary motivatgion behind for-each-alternate-refs was that we
wanted to find more anchoring points to help the common ancestry
negotiation and for-each-*-ref was the obvious way to do so; the
user did not care anything about names.
