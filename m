Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8FA1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeHAXI2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 19:08:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43707 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeHAXI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 19:08:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so16322wrv.10
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Zg+Ibv1MlFDJxoRgOFHJZ8Io9+l5S4sw2GLtbzj6SZw=;
        b=Zx4ZNtAw+KLNTrOt4gDq+tUCBwQWnoVwVNVMFVgWiZ+wVTtezYpMfHkWu0XCU9Juwd
         /q/3cDhCCiVqsZQ09hI3a12X8MpdHW8kGHGLnqpbk2HZXZ4gzgWLy7fX3AKzS3vhFxhN
         iX2CSiXyzqr9TN9xTDzbuIreKQm8SlPHJTsVy+GpBKA232pdXu8cx2RMNxyUS9FUgFol
         5YCjwSNoWEuzJW5CEPXHkxv/s6CH/buk41gVvUB20wQMfKvRHyA09l7GPsOYWcFG0eSv
         ILmcFgJ6C4icEMb4Ilky8UTRsiZsw3PncBAPlPyK88JiJpJnSMVdt5kO5RjkLsFsAb9p
         2TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Zg+Ibv1MlFDJxoRgOFHJZ8Io9+l5S4sw2GLtbzj6SZw=;
        b=oFbLcQzmdodcWjnm3XGawjJKdMO3ovJb5evhJrIXuo9r8u/bKbDkXmTbDTmmRCqKNj
         j56uSq/GPFz1GTkeTx9tVEYbyQrcH4EDVE4EKdLQclolVQAiEQ4rUX1etDz0h8mbRZoi
         X6K382BAtNCM9TIIp7jdknhZPgSdi1forpYBozuBMZMDd7pWfXd34k1oLNRq7LdpHC+A
         o7xPtKdxLpeE+cZlGpI2pIDgIEMakWK44q3yxQERWT3+6RVlJUm6K4oWvVvHoKfwfp8a
         7Vn54q4ErqN1J/MrsA6cBr8j7deM608fl2bSMjU0vZlAatrg3duONJv1gJ6F3X7TA4br
         gafA==
X-Gm-Message-State: AOUpUlHQIxwZnkgvJ+y6qK+SSl6rekzFYUUifaFMogOJbNC0C+b2TvV+
        EHflcElBtlRDPGnbKFI//SU=
X-Google-Smtp-Source: AAOMgpdUDN4LCZ+6JqZh1Ej/MBb8wVA4p2c2YAlTSrsrcKYO8uaG0kibHJ7DWEwdXgU3QsqCroRjUQ==
X-Received: by 2002:adf:f850:: with SMTP id d16-v6mr22415wrq.172.1533158443659;
        Wed, 01 Aug 2018 14:20:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g10-v6sm19018wru.43.2018.08.01.14.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 14:20:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
References: <20180729092759.GA14484@sigill.intra.peff.net>
        <20180730152756.15012-1-pclouds@gmail.com>
        <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
        <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
        <20180731192931.GD3372@sigill.intra.peff.net>
        <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
        <20180731203746.GA9442@sigill.intra.peff.net>
        <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 01 Aug 2018 14:20:42 -0700
In-Reply-To: <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 31 Jul 2018 13:57:57 -0700")
Message-ID: <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> Presumably we are already in an error codepath, so if it is
>>> absolutely necessary, then we can issue a lstat() to grab the inum
>>> for the path we are about to create, iterate over the previously
>>> checked out paths issuing lstat() and see which one yields the same
>>> inum, to find the one who is the culprit.
>>
>> Yes, this is the cleverness I was missing in my earlier response.
>>
>> So it seems do-able, and I like that this incurs no cost in the
>> non-error case.
>
> Not so fast, unfortunately.  
>
> I suspect that some filesystems do not give us inum that we can use
> for that "identity" purpose, and they tend to be the ones with the
> case smashing characteristics where we need this code in the error
> path the most X-<.

But even if inum is unreliable, we should be able to use other
clues, perhaps the same set of fields we use for cached stat
matching optimization we use for "diff" plumbing commands, to
implement the error report.  The more important part of the idea is
that we already need to notice that we need to remove a path that is
in the working tree while doing the checkout, so the alternative
approach won't incur any extra cost for normal cases where the
project being checked out does not have two files whose pathnames
are only different in case (or checking out such an offending
project to a case sensitive filesytem, of course).

So I guess it still _is_ workable.  Any takers?
