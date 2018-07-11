Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB111F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbeGKPlJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:41:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36416 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbeGKPlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:41:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so3061032wmc.1
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LMVtjPl1j/4Wz4QPbi09m7BR8ifncg/pRqRhQ/O8KPY=;
        b=WUi5Hvb22mkOn/wSLElt2Ype0PyOnORUr27AYBGKX5VtdemZDsf79HyJdX6B82W0cC
         3jGEGhuCAUl9QeuBwwReIxKBXDgnspf+LJ1CLUAqnigWbuQjvkm264j0u9BrJ9IO1oyV
         LX+B2nj3xutuNp+AKhaJGNO/BKQLjFkvY7mfKPGioccs/PM1vXCeoFcaeZsFMoZoHhTI
         nkS0NNbiHG1mFsrv+dItaOa+ZF6lNn0LDjAEYryxX3nBM9uR+2efFoEhQUGKswS70Mia
         TAVyNx9t86/62N+yQ/R492lS6o6HY81CLKKTLqUm8RK0GMKMhrun9TEZvxMi1WEbiJmd
         d3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LMVtjPl1j/4Wz4QPbi09m7BR8ifncg/pRqRhQ/O8KPY=;
        b=VA9HgOljI3ENNjIqObV4xUDpZwuLrW5cSIjd5vnMQ/pv/q7YVCV0MJcyQGJFTsfaDP
         uPPk6byIlEJ+P9AGqCjKmQqAloUoytuv+X0lF8tWMqxOZpnsv1H06OdUCz+/qoq6WSRy
         B7cI38/RjA47XvjpSx12FbG5YqAcCSYlezD130ja7bxnREZ+ApYGxg1kye1+24sn1/mG
         lchHgG7srvDHhWPO7pPCME5++BKX5/NhA/2aTDW8ipi5yAUyp3jl6+Ow14tJ4LlPI4ep
         DenOkAUG6x2c5v72ms/esPm2nXlU9dHmQLRiZgiMdzd4DoJMdVXRk8TpE+4jH4F7HG3G
         8w0A==
X-Gm-Message-State: APt69E3eJfZ5mSPbIjKKFcjGIujNsPV2w06W0RU/MWYIEaW2zR7ZcGzW
        Chz0tdOPTeGdzb8WUWMgSpY=
X-Google-Smtp-Source: AAOMgpd13xO+8/xm7K8xSZ3fx9dd+vsLLo3Yik8T9K8qXXmcoLzyRJfuoBJR9spjYw+Bi9OYeTmM2A==
X-Received: by 2002:a1c:b801:: with SMTP id i1-v6mr17038074wmf.30.1531323373838;
        Wed, 11 Jul 2018 08:36:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p3-v6sm34380038wrg.47.2018.07.11.08.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:36:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Ben Peart <peartben@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
        <20180708233638.520172-8-sandals@crustytoothpaste.net>
        <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
        <xmqqva9oe20y.fsf@gitster-ct.c.googlers.com>
        <20180709233952.GB535220@genre.crustytoothpaste.net>
        <02c0682a-8cc9-be49-b646-00cbdb5783f3@gmail.com>
        <20180711014346.GA888464@genre.crustytoothpaste.net>
Date:   Wed, 11 Jul 2018 08:36:12 -0700
In-Reply-To: <20180711014346.GA888464@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 11 Jul 2018 01:43:46 +0000")
Message-ID: <xmqqva9l4wer.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Jul 10, 2018 at 02:08:28PM -0400, Ben Peart wrote:
>> 
>> 
>> On 7/9/2018 7:39 PM, brian m. carlson wrote:
>> > On Mon, Jul 09, 2018 at 10:45:33AM -0700, Junio C Hamano wrote:
>> > > As Brandon alludes to downthread, we probably should use strbuf for
>> > > things like this these days, so a preliminary clean-up to do so is
>> > > probably a welcome change to sneak in and rebase this series on top
>> > > of.
>> > 
>> > Sure, I agree that would be a better change, and I'm happy to reroll
>> > with that.
>> > 
>> 
>> I've put together a patch to update log_ref_write_fd() to use strbuf and
>> will submit it shortly.
>
> Excellent.  I'll drop this patch in that case.

OK, thanks for working well together.  In the integration run I did
yesterday evening, this part was resolved by taking what Ben did,
dropping the s/100/200/ change from this series, and the result
looked reasonable, of course.
