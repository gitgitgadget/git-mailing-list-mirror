Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DF21F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbdB0WbJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:31:09 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35104 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdB0W3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:29:38 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so2329703pgz.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eS8AlBMt+WuFFczyOGDCYeMWlJbcsXFLdzBGqYKQIeg=;
        b=S/EVJHFOgo9RKQu6qCsQeRWz4w825ZZGz3dqI+jcbINQDCTvglzEviSLBK/jgHnIL4
         lBJCb2ftKQ6ZS2PuxsmTCBP2KnxOa+pEmmrMuLMEY/PMfDjGcfS0YtqeXd1Y1wwO6JNX
         uSI4KP0j1rKFNyQmfprYrXj8MMS3YSDAyyINpXqFvCIulyVh1FrcUFEqe3SekJY7X6YW
         so4e2fP0dOQGpdvaevTitBoEyrXwQo5dRihWSTsEljUYisO6iSxe1ddNNUTD7sxkd0k8
         c6QD3q2CuydW3C3aOE51Az8CMH9U0cWoxLG4Uf4QQV0FRkwYenFoW+1Gm9UHi8LlRS/4
         vnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eS8AlBMt+WuFFczyOGDCYeMWlJbcsXFLdzBGqYKQIeg=;
        b=MqwAj+bB6alAK6Czj6lpvsKKoGVFXURKoM1WWLHH2ou88mspQS7CynfaRvHKc0DP97
         /gYEPUbw31g9weNIlAkS27wyewUKLB03/M9V+UI/tiAMcCUgnoTJlG2svUplhjQV+P20
         sy4n3XlZg5kURQr40MR066UWvMKa75TmKZOrS+VTQ9Pn/rK3Vw5eYXAgCi7ND6TnF9xh
         CMsw+kZDQusccW5rjMikzZ4orO6F4tocgmvYmns83LCYGMe1RSzuDRdiLxgTggdW3C73
         xacBWTrguSr94L8hTi264MXRYkGhXma4QGEbd7SV4EtxExP1WShckM52hgj9SRkBH+ng
         T8yg==
X-Gm-Message-State: AMke39n8U4v4KKZ969XjE3ETwt+Hs7Wp4ijxVYloIAaMlw0vT8aKg/+ORuYn7vdx1K7fZg==
X-Received: by 10.98.14.217 with SMTP id 86mr23643728pfo.79.1488234490455;
        Mon, 27 Feb 2017 14:28:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id e7sm32609038pgp.2.2017.02.27.14.28.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 14:28:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
        <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
        <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
        <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
        <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
Date:   Mon, 27 Feb 2017 14:28:09 -0800
In-Reply-To: <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 27 Feb 2017 04:02:33 -0500")
Message-ID: <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I guess something like the patch below works, but I wonder if there is a
> less-horrible way to accomplish the same thing.

I suspect that a less-horrible would be a lot more intrusive.  It
would go like "interpret-branch-name only gives local branch name,
and when it does not show it, the callers that know they do not
necessarily need local branch name would call other at-mark things".
As you pointed out with the @{upstream} that potentially point at a
local branch, it will quickly get more involved, I would think, and
I tend to think that this patch of yours is probably the least evil
one among possible solutions.  

Perhaps with s/not_in_refs_heads/not_a_branch_name/ (or swapping
polarity, "is_a_branch_name"), the resulting code may not be too
hard to read?

Thanks.
