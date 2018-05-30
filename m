Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124741FD4F
	for <e@80x24.org>; Wed, 30 May 2018 01:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968497AbeE3BcW (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 21:32:22 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38800 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968253AbeE3BcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 21:32:21 -0400
Received: by mail-wm0-f43.google.com with SMTP id m129-v6so44528317wmb.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 18:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DWo4B4TA/XCxWJxFDLTpEiuQRcOPna2jDYg/ZbAGPZE=;
        b=YXUhYoc10GT1GGukSmEVclbnjTTTFov7hANVRjPAOnON8dluPlWLFgy/NLRgeeJb+X
         4qjLtC5krppAiWw5+LV5xJaB94qWh+djlARv6cSdwopY7FqXL9UPi6GUUPYSabsPbJq8
         frgw4n9D4pcJ2MwGJ8YxgjN3M+AzrLJTJGAAk3g5sjRS57YTFgCgD49jc4551KnirZn1
         G0GDfexlYoYMJgQLBFO0CIUN1uuZu0N56/fgoiOnUEXgskc0L1W8Wfeb4mT7J7fJRi1/
         KQVfUhEW8O31ndJgXxKrxo4ioMHAjOOwVuzmrJ0sBY0RnA9wmAAkAWp94iT55aTbCFCr
         0T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DWo4B4TA/XCxWJxFDLTpEiuQRcOPna2jDYg/ZbAGPZE=;
        b=fQQeVqU7vrCjn8VjILhWxtTDwWTBGdgI2eNQ6+ycM9QOrld7JZDC/Ua22g5xzIdJ7m
         V5sdYPoYNQyuBsLAuaZfCN1UBL7wM/xQlX1iUjPxb+RB4dSlXomdQBkjLlAkfYG1s2Xa
         lw5uAjijrFDTKeVi14YRw8uoGnSkr6I1OvrBUe07ybjXPwba6yaxuXbqmWCSQvjdVBzZ
         Gc1sIuqbTwkMfhxTBmWe0bE69Da2UR0Dgxm6+2LoLZDDriTPfDp7t2203gZTbeHZurWX
         Mix2Lmdg8n927yRRwM8X5VG3Z5pp0EdmNt8Ct8Tc622qmFU4vMwN0i9o87oZUBhx5Pek
         bRXQ==
X-Gm-Message-State: ALKqPwcgIKokC8WWPN1yXKg+athqQ1n1PtRnhifPjd2jjJgP61VW4zXh
        F2Y3Gx3qmht83RKwr6ub2ZA=
X-Google-Smtp-Source: ADUXVKLqGyqwe3uJSqmmuhlcn5ziIGgr+e+rmmJiarL6GfKHk7rtAX6p5TV7vYMFcaWovySSDOXe3A==
X-Received: by 2002:a1c:6952:: with SMTP id e79-v6mr732735wmc.76.1527643940638;
        Tue, 29 May 2018 18:32:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v31-v6sm42626841wrc.80.2018.05.29.18.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 18:32:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] fsckObjects tests: show how v2.17.1 can exploit downstream
References: <20180529211950.26896-1-avarab@gmail.com>
        <20180529212458.GC7964@sigill.intra.peff.net>
Date:   Wed, 30 May 2018 10:32:19 +0900
In-Reply-To: <20180529212458.GC7964@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 29 May 2018 17:24:58 -0400")
Message-ID: <xmqqk1rmexng.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> It's worth testing for this explicitly. So let's amend the tests added
>> in 73c3f0f704 ("index-pack: check .gitmodules files with --strict",
>> 2018-05-04) to show how this can result in a v2.17.1 client passing
>> along the evil objects.
>
> I'm not sure what testing this buys us. If it stopped passing them
> along, would we consider that a regression? This seems more like a
> documentation issue than something that needs to be tested.

I tend to agree.  The recommendation of the release notes is about
protecting the place downstream would pull from, by telling Git to
vet the pushes into that place and that is why receive.fsckObjects
is mentioned there.  Nobody sane would expect receive.fsckObjects to
do anything when that central place fetches from elsewhere, and I am
not sure what additional value it buys us(over the tests we already
have) to test that diabled transfer.fsckObjects are truly disabled.

If we want to also encourage people to vet their own "fetches", I am
not against extending documentation.  It just is different from "we
extended the mechanism to help server side protect their clients"
that was the focus of (updated, relative to what is in the tarball)
the description in the release notes.

Thanks.
