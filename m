Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05109C05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 02:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBKCqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 21:46:09 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6208329424
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:46:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k13so8635241plg.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGbrSpMgPT9lcoI6ILwc8AgVIOHW90QS51rMMM34yL0=;
        b=fihue6247y+ooonb9ZGa73IG2EckA29RMtaFTFHgUohNu3tlIukRl+tGGoDK8WOWlA
         idbg+SkEaeOJw4hH6cJSjDZFgQSA7lDIQiWOQRKENS75zW759I/6UE02B+e+vRbc1tf2
         U1p2cZhBt9sVM13Sa3Bm7XYMx2qoH/aiUCM3rJTaXXWIBzONKtWu/9/edNyawJ/gd8ru
         vGP1l/HU56F7AgeeztO4apGWoDxMhz/Ma2/rXOylno9QPg+OV0SrygTFIjJQBFfPQ7XA
         6LaoFUG6aqFchU+9bDJi1oZjAlHAaeUoAJ4TsnzqnkhVtaQgSEB/s47+C/GApzwoYJDL
         xlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pGbrSpMgPT9lcoI6ILwc8AgVIOHW90QS51rMMM34yL0=;
        b=RnBI/vm+z6cUtxQzUTPAcnhVMRFM8TFBSerabwSEInRn9EKRuh7EftvkeAW+0ePmbr
         7h30I386OXGEkHl72dzkivGn23Kl8SxA7DvOUGeH1uYLFpYxYoERbu6CbULQxzB0DksZ
         mG1NnBNz+TvtYwvfCshtokDV8Gvp+93UioDwNpdWiSiinbcRykFi+MuBbP6DAD1DswCU
         fys0Y7z/A2bLhgmhdH7jnUXeBofo4NMu7GThQ1i+0r49lG+4WuiaB1/5MM87q90SyjGA
         zaHoyOnzDAaSOsdAbBOzKpfpP4qvS46Vu8DTXz2uRYY3IGQkYe25iTSlP1grWCB+CL8Z
         Gt2A==
X-Gm-Message-State: AO0yUKUREFFtb8469POIzPqR4fGAiw1i53n1IwlsKX0ClSJshou09d8D
        Ijv4i4O4xvaUJF7qrb7BJ3U=
X-Google-Smtp-Source: AK7set/xMdkSmVoLvNNXsQSlBWAsd3WGf7+a0zSJJdcaU+i7+/zLm0Q+8jdPj4GNO+OPYyTVX80IvA==
X-Received: by 2002:a17:90b:4a81:b0:230:acb2:e3e8 with SMTP id lp1-20020a17090b4a8100b00230acb2e3e8mr599247pjb.23.1676083567783;
        Fri, 10 Feb 2023 18:46:07 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090a4c8600b002339195a47bsm2186626pjh.53.2023.02.10.18.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 18:46:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
        <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
        <850c94d5-973a-335e-903f-e0ab7e52f37e@web.de>
        <xmqqwn4pgt1f.fsf@gitster.g>
        <Y+b6TAmxel48QHJa@coredump.intra.peff.net>
Date:   Fri, 10 Feb 2023 18:46:06 -0800
In-Reply-To: <Y+b6TAmxel48QHJa@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 10 Feb 2023 21:15:40 -0500")
Message-ID: <xmqqa61kgbrl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> ...  I do not feel it too strongly but we
>> might want to rename _grow() to _grow_by() and make _grow() call it
>> while giving deprecation warning X-<.
>
> Having been confused by that myself, I would be happy to see such a
> name change.

If we did not know how useless explicit growth control is, we would
likely have a pair of helpers, _grow_by() and _grow_to(), but given
that ...

>> There are ~45 calls to strbuf_grow() in C files other than strbuf.c;
>> I suspect probably a half or more of them can and should be removed
>> to reduce the resulting code size without hurting anything.
>
> My gut feeling is that your suspicion is giving strbuf_grow() users too
> much credit. ;) And having looked at the first 7 grep hits, every single
> one of them seemed pointless to me.

... we'd only have a very limited number of callers for which the
helper makes sense, I am not sure if it is even worth the renaming.

Or just rename it to _grow_to() while fixing what it does, as
grow_to() is what programmers would expect naturally?

> I wonder if these would make a good #leftoverbits / micro-project
> candidate.

The task is to pick one or two from these 45 hits, analyze what
would happen if we remove the _grow() calls.  For many of them, the
result of such analysis would say the calls are pointless, but for
some, there hopefully are solid reasons why explicit sizing makes
sense.  The former will be just removed, while the latter will be
kept with a new in-code comment to record why it is worth having the
call.  The parameter may need to be updated for them at the same
time.

It can be done extremely poorly without breaking anything in the
test suite, or it can be done expertly.  Unless the result are
reviewed competently, it may make a rather poor micro-project
experience.

So, I dunno.
