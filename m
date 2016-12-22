Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028391FF40
	for <e@80x24.org>; Thu, 22 Dec 2016 03:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756793AbcLVDy6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 22:54:58 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35898 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbcLVDy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 22:54:56 -0500
Received: by mail-pg0-f66.google.com with SMTP id w68so12531705pgw.3
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 19:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=jFasGFNwJuw19fPbbYYOUM1E3V1UpFw7L9/bEAsio4I=;
        b=GpDBV+qfLU+MOut4Qss99rTg6tVSXcHtLQ6ThDhWP7tTjC29ucM4ygsFnXqtq19Tha
         TmB6sym2tOXAZ8UmcPLZnPYQ0L2/FYCn/dmPS3n36khZUkigrFIeI2XnvMf7QBCgABFw
         lExLVhIL9UKgZYV27o7xAAjj4GWupq1a9n2hUrzC5w5gG+l8+5l3bbOiEeucm1EOJm88
         F2Ob6cjGV6rFFQPnZuJghj/hI/tLTTuGZmFX9JHVnicvTUqR3LViuvEtZsoOVA1QTLa5
         H5EXyzStDbLIB5vpCnXdj/Cug5Ki+GAk8peGJiq545EOmSIWumznytz9BGIJ2LYj7meO
         yrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=jFasGFNwJuw19fPbbYYOUM1E3V1UpFw7L9/bEAsio4I=;
        b=hjrywaZDEWte0+cPdkfq7QCdX5ZojFyrvxWN71RdEXXXXfQcYPZWdV9BC94qc94EVj
         Xks3X02ZRJN9OOm1vQNRLMtHKcgZAXFuUnyktcJmdEDd1SF9SrjqEpKET+18dwoeLvpY
         6LKmeQu5n/BrYAI4qtjHuhoCK/0OFMQm4K8Im5EnSqe8NETneFkZBz49PSInTblPk7r9
         l/ZvzGhkaxlnnabAL5M0LhqfscX97lMspy55FiMCBnTBPmrU9VoGX269DZNYeINagcAA
         1xMXGYomAWJ33ZLXURbSjM0Uoj53Nnehf9UqmzNcPK6YwEcBkfkD1nmE6f98p4hhkWjc
         bjnA==
X-Gm-Message-State: AIkVDXLCw84wlVK7y6uTcS2GZFTk4c0Jlpam+Zp8R056BO0ZsLOaMNKfCYFEvPEFoHZXcg==
X-Received: by 10.99.117.71 with SMTP id f7mr13480276pgn.126.1482378800936;
        Wed, 21 Dec 2016 19:53:20 -0800 (PST)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id r2sm50029444pfi.67.2016.12.21.19.53.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 21 Dec 2016 19:53:20 -0800 (PST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jeff King <peff@peff.net>
In-Reply-To: <F5001DF2-20C2-4757-997F-9D40BD48E1D9@gmail.com>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0> <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net> <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com> <alpine.DEB.2.20.1612201511480.54750@virtualbox> <20161220164526.qnwnmr7cvyycmw6a@sigill.intra.peff.net> <222ACFD4-ED9A-4B94-8BDD-3C70648A684B@gmail.com> <20161221155539.aykcmkuzqvq733ri@sigill.intra.peff.net> <F5001DF2-20C2-4757-997F-9D40BD48E1D9@gmail.com>
Message-Id: <99C4A905-D66B-4609-9E55-06F9BC301C74@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Wed, 21 Dec 2016 19:53:15 -0800
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 21, 2016, at 18:21, Kyle J. McKay wrote:

> On Dec 21, 2016, at 07:55, Jeff King wrote:
>
>> On Tue, Dec 20, 2016 at 09:54:15PM -0800, Kyle J. McKay wrote:
>>
>>>> I wasn't aware anybody actually built with NDEBUG at all. You'd  
>>>> have to
>>>> explicitly ask for it via CFLAGS, so I assume most people don't.
>>>
>>> Not a good assumption.  You know what happens when you assume[1],  
>>> right? ;)
>>
>> Kind of. If it's a configuration that nobody[1] in the Git  
>> development
>> community intended to support or test, then isn't the person  
>> triggering
>> it the one making assumptions?
>
> No, I don't think so.  NDEBUG is very clearly specified in POSIX [1].
>
> If NDEBUG is defined then "assert(...)" disappears (and in a nice  
> way so as not to precipitate "unused variable" warnings).  "N" being  
> "No" or "Not" or "Negated" or "bar over the top" + "DEBUG" meaning  
> Not DEBUG.  So the code that goes away when NDEBUG is defined is  
> clearly debug code.

I think there is a useful distinction here that I make that's worth  
sharing.  Perhaps it's splitting hairs, but I categorize this "extra"  
code that we've been discussing ("assert(...)" or "if (!...) die(...)"  
or "verify(...)" into two groups:


1) DEBUG code

This is code that developers use when creating new features.  Or  
helpful code that's needed when stepping through a program with the  
debugger to debug a problem.  Or even code that's only used by some  
kind of external "test".  It may be expensive, it may do things that  
should never be done in a build for wider consumption (such as write  
information to special log files, write special syslog messages  
etc.).  Often this code is used in combination with a "-g" debug  
symbols build and possibly even a "-O0" or "-O1" option.

Code like this has no place in a release executable meant for general  
use by an end user.

2) DIAGNOSTIC code

This is near zero overhead code that is intended to be left in a  
release build meant for general use and normally sits there not doing  
anything and NOT leaching any performance out of the build either.   
Its sole purpose in life is to provide a trail of "bread crumbs" if  
the executable goes ***BOOM***.  These "bread crumbs" should be just  
enough when combined with feedback from the unfortunate user who  
experienced the meltdown to re-create the issue in a real DEBUG build  
and find and fix the problem.


It seems to me what you are saying is that Git's "assert" calls are  
DIAGNOSTIC and therefore belong in a release build -- well, except for  
the nedmalloc "assert" calls which do not.

What I'm saying is if they are diagnostic and not debug (and I'm not  
arguing one way or the other, but you've already indicated they are  
near zero overhead which suggests they are indeed diagnostic in  
nature), then they do not belong inside an "assert" which can be  
disabled with "NDEBUG".  I'm arguing that "assert" is not intended for  
diagnostic code, but only debug code as used by nedmalloc.  Having Git  
treat "NDEBUG" one way -- "no, no, do NOT define NDEBUG because that  
disables Git diagnostics and I promise you there's no performance  
penalty" -- versus nedmalloc -- "yes, yes please DO define NDEBUG  
unless you really need our slow debugging code to be present for  
debugging purposes" -- just creates needless unnecessary confusion.

--Kyle
