Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988C81FF76
	for <e@80x24.org>; Wed, 21 Dec 2016 05:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754237AbcLUFyW (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 00:54:22 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36822 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbcLUFyU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 00:54:20 -0500
Received: by mail-pf0-f193.google.com with SMTP id c4so10290122pfb.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 21:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=w+UBG0g/EZM3hAalRQ/7qATUX7X6oZRCKGoT/f31+54=;
        b=STY9onyBfXKyy3LA8R4RIGyGBAiuV2AqNVOxzqeR07O1t+ZnApQXCPcG5qePjpxdHV
         MfljhvDlLUKquwq6WEFXODrCEpmjuqZ3QWNQDWuNI3FyM0HszTH3eZYK1nZvkceXtdFV
         oSuBaBQvsSv/BPYMhmzgGF0n/NyR2T8tYlwbHXcAPVIlS0QBjCBqqOdOYQOrsQ3eVvsO
         bHwCRCtJuKEi7ty3EWUKZnwZ/31ff4y3EJekmgtlPM7e27ItP6PQ3nEStdx27SgIfHp/
         hBOWOw5hIbr1jT8kyo/vw5ZnOWNBK9rizvHMNAfwSMY9q/J6kCm3gksgWmTxBdKWJG+B
         udwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=w+UBG0g/EZM3hAalRQ/7qATUX7X6oZRCKGoT/f31+54=;
        b=QYEBQ0cf8K8UI6An8uSnwd3tbiEogJCp/T5Uf6PaEhHUevlFjOWfR+CBnH6wiZgZgi
         WqZYji06SQ0+Ge4jZVPGE1JyiAJT8Por5Xdf0Nh1YP8ng3CVewUd6DYkrBFlD9bQlhco
         xC4hsTYmyiLCAh/0Cho+0RzPmvcH20umBRX/iEj9qcpW86pYVS+gcqFVI67kmTGIZQ2V
         vRAtNZBPytrwB52oJPS8GQFEEnhWgOCCJ4euRIjsOUZOKxmE94Alo26N901hrEA8hJLk
         RxL31WI1pBF+V3DOSrahA+xG/rP4luaXAQUnf0vhIDRf+YsW73nv+G3k4osbfqFEpdQU
         6GQw==
X-Gm-Message-State: AIkVDXJ74lq8ESZ+akPlIAfJRXFRvgJKptz2VkHfrGgfqHNVf5MSsNd+qqwFKcOjsaurtQ==
X-Received: by 10.98.103.201 with SMTP id t70mr2580241pfj.99.1482299659849;
        Tue, 20 Dec 2016 21:54:19 -0800 (PST)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id 29sm1817023pfo.58.2016.12.20.21.54.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Dec 2016 21:54:19 -0800 (PST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jeff King <peff@peff.net>
In-Reply-To: <20161220164526.qnwnmr7cvyycmw6a@sigill.intra.peff.net>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0> <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net> <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com> <alpine.DEB.2.20.1612201511480.54750@virtualbox> <20161220164526.qnwnmr7cvyycmw6a@sigill.intra.peff.net>
Message-Id: <222ACFD4-ED9A-4B94-8BDD-3C70648A684B@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Tue, 20 Dec 2016 21:54:15 -0800
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 20, 2016, at 08:45, Jeff King wrote:

> On Tue, Dec 20, 2016 at 03:12:35PM +0100, Johannes Schindelin wrote:
>
>>> On Dec 19, 2016, at 09:45, Johannes Schindelin wrote:
>>>
>>>> ACK. I noticed this problem (and fixed it independently as a part  
>>>> of a
>>>> huge patch series I did not get around to submit yet) while  
>>>> trying to
>>>> get Git to build correctly with Visual C.
>>>
>>> Does this mean that Dscho and I are the only ones who add -DNDEBUG  
>>> for
>>> release builds?  Or are we just the only ones who actually run the  
>>> test
>>> suite on such builds?
>>
>> It seems you and I are for the moment the only ones bothering with  
>> running
>> the test suite on release builds.
>
> I wasn't aware anybody actually built with NDEBUG at all. You'd have  
> to
> explicitly ask for it via CFLAGS, so I assume most people don't.

Not a good assumption.  You know what happens when you assume[1],  
right? ;)

I've been defining NDEBUG whenever I make a release build for quite  
some time (not just for Git) in order to squeeze every last possible  
drop of performance out of it.

> Certainly I never have when deploying to GitHub's cluster (let alone  
> my
> personal use), and I note that the Debian package also does not.

Yeah, I don't do it for my personal use because those are often not  
based on a release tag so I want to see any assertion failures that  
might happen and they're also not performance critical either.

> So from my perspective it is not so much "do not bother with release
> builds" as "are release builds even a thing for git?"

They should be if you're deploying Git in a performance critical  
environment.

> One of the
> reasons I suggested switching the assert() to a die("BUG") is that the
> latter cannot be disabled. We generally seem to prefer those to  
> assert()
> in our code-base (though there is certainly a mix). If the assertions
> are not expensive to compute, I think it is better to keep them in for
> all builds. I'd much rather get a report from a user that says "I hit
> this BUG" than "git segfaulted and I have no idea where" (of course I
> prefer a backtrace even more, but that's not always an option).

Perhaps Git should provide a "verify" macro.  Works like "assert"  
except that it doesn't go away when NDEBUG is defined.  Being Git- 
provided it could also use Git's die function.  Then Git could do a  
global replace of assert with verify and institute a no-assert policy.

> I do notice that we set NDEBUG for nedmalloc, though if I am reading  
> the
> Makefile right, it is just for compiling those files. It looks like
> there are a ton of asserts there that _are_ potentially expensive, so
> that makes sense.

So there's no way to get a non-release build of nedmalloc inside Git  
then without hacking the Makefile?  What if you need those assertions  
enabled?  Maybe NDEBUG shouldn't be defined by default for any files.

--Kyle

[1] https://www.youtube.com/watch?v=KEP1acj29-Y
