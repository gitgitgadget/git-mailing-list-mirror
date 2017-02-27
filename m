Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B86CF1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 19:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbdB0Ty3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 14:54:29 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34653 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdB0TyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:54:25 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so1984992pgb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 11:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jAI16HTHxxmcQ95lgtZLwy3mHc48awmF5vKcpw5MoM8=;
        b=cqF8s/BXjOQWnEYiNY6dSw5bOzANyc/xqOpTemdI8Eb/fLLZU9R/ohacy7pMbseq0E
         k0uCEc554KKO/KdJjrebEU8B+g8+47vwb0OfSvB4PZfyZ/KHq2lzwHWb1s3K6JmHaXH4
         tQfC7t5+yzXB86nI9v7yl9TDIEX49dIIo0ZSIHnQAL6r75xM6UcT5MGb3osJhWqUHxYM
         u8+MBhahIZN6M+/5JCa+kaw1yv2f5dl97tY9VMQQKLCgpFHEC7Cl4Q8H4aHlI2h7b/76
         1xmvNDO9M8N2JSt/+pk1QP0e6yUwI1oU14BwsutUSU3v+74KjjqeEjj/6AbLAZlvPoCx
         GipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jAI16HTHxxmcQ95lgtZLwy3mHc48awmF5vKcpw5MoM8=;
        b=lUQQ2bLAZa5E756kIzVO9fjCQBuFZNRRGmX4sAFR1K8JLuab/ZMvNJaVO27tyKxp6V
         s5LJuSP2Pn8V9SsMGNjx/IzZifOekuipYIVI7LGH8N4rIHCOhFS2bR0F5M5bVcFopjzW
         gs8mLDpmaFrbW8IMlblWkw1SITuPZ84q+J8r2TLQuN/ixpkDgU4hfXtqMgFLK3wmDB6H
         p9yhSMuV5UEu7MJQFUq5r4IPtcAJgekX74oDemxRZxBAM7XXe5mTKheE0zWRpmtfYM8M
         vgAepYViz7/ZFc04x4F1/e2IR37uZcoXfnRtEr1l7trXlrnEtWoZFRk5R/I6gVaRSxHV
         z+fg==
X-Gm-Message-State: AMke39mg1pd9GbGwIOKCO5zatycpCpIhSqjyQcm/z7ZLDA0HDx1/cvg2Rh0LVDz42csqNA==
X-Received: by 10.99.174.71 with SMTP id e7mr23128240pgp.3.1488223631001;
        Mon, 27 Feb 2017 11:27:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id x2sm32082252pfa.71.2017.02.27.11.27.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 11:27:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] interpret_branch_name(): handle auto-namelen for @{-1}
References: <20170227092540.ob2oy4qpgfukqwtc@sigill.intra.peff.net>
        <20170227093122.3jdb2b62hlbbio5r@sigill.intra.peff.net>
Date:   Mon, 27 Feb 2017 11:27:09 -0800
In-Reply-To: <20170227093122.3jdb2b62hlbbio5r@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 27 Feb 2017 04:31:22 -0500")
Message-ID: <xmqq4lzfxwmq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Feb 27, 2017 at 04:25:40AM -0500, Jeff King wrote:
>
>> However, before we do that auto-namelen magic, we call
>> interpret_nth_prior_checkout(), which gets fed the bogus
>> "0". This was broken by 8cd4249c4 (interpret_branch_name:
>> always respect "namelen" parameter, 2014-01-15).  Though to
>> be fair to that commit, it was broken in the _opposite_
>> direction before, where we would always treat "name" as a
>> string even if a length was passed.
>
> That commit is mine, by the way. More embarrassing than introducing the
> bug is that I _noticed_ the problem at the time and wrote a paragraph in
> the commit message rationalizing why it was OK, rather than just doing
> this trivial fix.

Thanks, I should also be embarrased since I didn't even notice the
issue when we queued it ;-)
