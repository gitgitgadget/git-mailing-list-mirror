Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C591F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbeGKR0P (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:26:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54663 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbeGKR0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:26:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so3112378wmf.4
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OR5b+IxsgxQgwqGN5qDYUha2bEFDSQ+93115lTunSAs=;
        b=m0g15BPyo+k/ygjJK4WHSi+OlH5hRBcTa2eurZX7njzSJIhvHbgr+PX5XtoE3p5n4T
         2cA7251Jd0Xi73goYCU1pJf7foLvkxMaLKUCURQcQ4xo5u0ZcDOA94UiZp9JMxhE3lhu
         GKW4WA7Q7dmDNeCFFHQ2i6Pnjj/5bv3eoaR3UI8wJ6GXah03w2N4TYomBFz7a9VM0mtl
         fCto/VImzNieXrduogqOcaV7kTSRR1nNjgNyGC8ggEbajfLjDGgXspv6gfb5+V2C2WNS
         QU1MOGJIWk3FuPQoTBvi+Lmp7iel6SPghc8YHM4eElvABXl03zXLHLcH67oigla73tUb
         IMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OR5b+IxsgxQgwqGN5qDYUha2bEFDSQ+93115lTunSAs=;
        b=j8DuKwxbXk2e4hUAvhRYVGRMmcwjrEDi1fF7OalwQOLZBVis6bt5eLUE0n5lxrayqI
         41jlt8knFa9ZEQTJ7j05DLyS0OnyxmXr3mXyyAOYuDCD6y7pgm4JzLTfn1ifN03kq0r9
         S4lKRLC8eMtTRKkU129B1hPm375GPezWiG0OCwDJU2g4NCbor/cCt77GfsHgBoj3XMBF
         3/Svn21WKE4iK0dZVlzDLwUtyA+R7TNRXIh/a5IlVoZSZo1ToJ+ZI4SQJ0rn9E0X2iRC
         yItdk1EWnCCQh3TJnVOOrdY7tpqBKnFbca8M1XepFwFcw7ZbfmMk+mccofYQZWAAeIYO
         FTvA==
X-Gm-Message-State: APt69E31u1yhB50TeaUsE1F4PCcYhD/tiyNsR3cCjJM6AJhrtPYc/a0X
        I+JBMEllIlGQydOdKNnnSHI=
X-Google-Smtp-Source: AAOMgpdfGFHgacRgUs0GggdkmS3jqXjg1eEdxs7gpu073rPBtLDAcYYNGPkppCf5Se0r7JIpqwzj0Q==
X-Received: by 2002:a1c:55c8:: with SMTP id j191-v6mr17338637wmb.67.1531329655814;
        Wed, 11 Jul 2018 10:20:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a2-v6sm1787021wmb.6.2018.07.11.10.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 10:20:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     wchargin@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
References: <20180710154106.5356-1-wchargin@gmail.com>
        <CACsJy8CBJvpKAAtVjrdcuO06WossxcMmqwmSRL9Shr7g+qVySA@mail.gmail.com>
Date:   Wed, 11 Jul 2018 10:20:54 -0700
In-Reply-To: <CACsJy8CBJvpKAAtVjrdcuO06WossxcMmqwmSRL9Shr7g+qVySA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 11 Jul 2018 17:45:09 +0200")
Message-ID: <xmqqfu0p3czt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> diff --git a/sha1-name.c b/sha1-name.c
>> index 60d9ef3c7..641ca12f9 100644
>> --- a/sha1-name.c
>> +++ b/sha1-name.c
>> @@ -1650,6 +1650,7 @@ static int get_oid_with_context_1(const char *name,
>>                         struct commit_list *list = NULL;
>>
>>                         for_each_ref(handle_one_ref, &list);
>> +                       head_ref(handle_one_ref, &list);
>
> When multiple worktrees are used, should we consider all HEADs or just
> current worktree's HEAD?

Does for_each_ref() iterate over per-worktree refs (like "bisect",
perhaps)?  If so, then looking in different worktree's HEADs would
make sense, and otherwise not.

I would think that the whole point of detaching HEAD in a separate
worktree is that you can avoid exposing the work you do while
detached to other worktrees by doing so, so from that point of view,
I would probably prefer :/ not to look into other worktrees, but
that is not a very strong preference.  If peeking all over the place
is easier to implement, then a minor information leaking is not
something I'd lose sleep over.

Thanks for bringing up an interesting issue.


