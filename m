Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41031FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 20:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbdJXUs5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 16:48:57 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:48060 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdJXUs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 16:48:56 -0400
Received: by mail-qk0-f177.google.com with SMTP id m189so27980088qke.4
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6vB3DSSyaOUu/yunM6XhoKbHHMivnMJZzbk6fZ3g1pQ=;
        b=HBFFumCulHBmPsbmtQGVU3TNJBkjOCIl3lZtKTMrdExMLjKg9pzcVut1SoualZ9fdz
         sZ0Zj4mk6rKbdXtbxYrnveWXHgQG0+3GwPoXxmRy68kYd8NgZRScrHoImsvGfVozuHgk
         xUqNIUi+OeMBSWQHe7wnvopDae2FBcIVHK4vkQhYBDzNTmSbv4l8/YenZQTE2jVTRsOb
         Fo16IDVp/jOGFQVxj4k9x7GCYC+jie5tMkSfepaeb0efcOaNjtR9j+dTTLMweOQr3NiK
         mpw1AFTOS6Vnd9xsKUyXsICqilQWkkAATqbq2iyrotw2vlJ0JDuJa0+pfvREzXHWvXJH
         6n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6vB3DSSyaOUu/yunM6XhoKbHHMivnMJZzbk6fZ3g1pQ=;
        b=V6D8BmKLPzGuzd72s6KgW5rg0QTbvX8AibbolCdqnAC0s+QneyLhMy3EfqnEgDDE4C
         MFNyloF0d252kSVUcZlm6c7I3AGwEwzsCsySZXkRie8cu8pf8QaZKZmi6GvctlF2ywBp
         wQyrYQebpgb6wmoHAjdWjaQ3NdaU4rcSFrdIR7vlbUe3CZ9qbf0Q7058hQafRTcjaJl0
         RYB6WtoYUhEUXxOoso1hyhcCbsJbIvYIQ2ew52RWHNxxyw9C6Ffp9P82uzIKzbNSX+8+
         tiPu2mEHnkofWLRt0OAz/gYGm+QxZo7exLs7wT84NEuoHEV5bOB5iWrf7kBk+zd/SSSa
         0EUg==
X-Gm-Message-State: AMCzsaW9Qk7lFsj2oHtxgEqlXA4rlS24TchBtI6DVh7eg2dMgIhB1oo5
        9I0Vapi4/4RbRIcCmkVdkG12Gm1TPz68ZMmYgX4e3g==
X-Google-Smtp-Source: ABhQp+QN9Iib6C7iAL/i/lxPiJCWBQjh5R2dXmMuSdyuI2C/4QFZXCgcgHRamIcY+sMldvPDMPas+lFKBx9YtOaUiO8=
X-Received: by 10.55.111.3 with SMTP id k3mr24824512qkc.332.1508878135253;
 Tue, 24 Oct 2017 13:48:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 24 Oct 2017 13:48:54 -0700 (PDT)
In-Reply-To: <06c950e8-92c6-4926-ccac-2827d480f373@web.de>
References: <20171024185917.20515-1-sbeller@google.com> <20171024185917.20515-2-sbeller@google.com>
 <06c950e8-92c6-4926-ccac-2827d480f373@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Oct 2017 13:48:54 -0700
Message-ID: <CAGZ79kaQA90t6o2bn=H4Xrf2RiBOHc=gBE8XuKb+iHB6oEQVqA@mail.gmail.com>
Subject: Re: [PATCH 1/4] hashmap: introduce memhash_feed to access the
 internals of FNV-1 hash
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +unsigned int memhash_feed(unsigned int hash_seed, const unsigned char next)
>
> Why is the second parameter const and the first one isn't?  (We tend
> not to bother with const for value types.)

will do.

>> +             hash = memhash_feed(hash, c);
>
> I guess compilers inline a copy of the function here with -O2.  My
> knee-jerk reaction, however, is horror in the face of adding a function
> call to the inner loop of a hash function.  Do you have performance
> test results, ideally also with -O0?  And why not make memhash_feed()
> an inline function or macro to sidestep that issue?

My gut feeling was similar, but then I assumed compilers of today would
be smart.

As per the discussion on a later patch, we could migrate all memhash* functions
to fnv32.c except for the _feed, which will be static in its header fnv32.h

Thanks,
Stefan
