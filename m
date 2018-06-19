Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E93C1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 20:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757228AbeFSUhV (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 16:37:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36793 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757106AbeFSUhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 16:37:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id v131-v6so2828377wma.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 13:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oz5/Uvc+unppJ5tvmLwVAFbOEwiV1eeOuukAHQsg0/A=;
        b=mX4XxWelJrZrxXIAxm/RzhDj1wTalmEXBUSFCdTXpm+ST/jqj0eG5IBDymSXknCV2w
         NPm0FNTdwLq364RNFdRB0n5MWFAnu+yvQFmvYj4SXkj0RxmIuNXIb9H4QBEhsS2m6Eot
         +0FrBBvf/dkHzsAbotb6ckwM2RhyM4QLYRlKCpOuGvLTnLsMKANdRkplMctU65T2gmWm
         ifw1etJoJEKc6cz3bPwhbJQwZyg47Ry0KoYiVl4aUEZtuKkD8hWbwG0+zbbb60ripzO/
         uv5QAPQohjagWk/rMO9QhmP5gkBrxEajSQCtTRKWdhYdMEsrB4qIng8NvsZV1WdmPXb4
         6Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oz5/Uvc+unppJ5tvmLwVAFbOEwiV1eeOuukAHQsg0/A=;
        b=MgMnC7VbPbtu2CtFshBc/VW8+pluzuypIWQXZ9PYglVhnQDDUbJRaPAD0j2TdmK57A
         qbKp5n85j1DTymbQuHQXqHLEUSjP3fJ1Vp9hOlbgxnrqejYY2IGQwVVqQhhAhWsMcEvc
         68ceiklzgMWvaRq9wdVF5H/yueRIWQ4YuXxVxFo3Iix2ii6CO9oAUxUAqAlhhJ601rlg
         h6LDm976iK6pwvzgTTj4HDZ5ZRaeBpikJf4jlDC5Symdbk4DkKd8uT/lBJllLktQRBEb
         r3tV3XXBedKzm9YFCpvtnnTmDXWTDvzMP/x1burZFDiwtdGbBvAc+RLdbNJcB6KKNILy
         ZS0w==
X-Gm-Message-State: APt69E3T7myfxByDDEgAQGvymHfHdtBpxmJAsxegRx+PNlAsP/VTcN1n
        ohcGmIoVis1+8UNmEGbbrjA=
X-Google-Smtp-Source: ADUXVKLmhPcDTKHJ3ARKKLDos8tObdtOZvmGhrMkyKH1kShiCkINb0YFWkAWkuX2SGCKP5rROUk+/Q==
X-Received: by 2002:a1c:3ac6:: with SMTP id h189-v6mr14163366wma.64.1529440635165;
        Tue, 19 Jun 2018 13:37:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h12-v6sm10125787wmb.3.2018.06.19.13.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 13:37:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 2/8] upload-pack: implement ref-in-want
References: <20180605175144.4225-1-bmwill@google.com>
        <20180613213925.10560-1-bmwill@google.com>
        <20180613213925.10560-3-bmwill@google.com>
        <xmqq602jzriy.fsf@gitster-ct.c.googlers.com>
        <20180619185033.GC199585@google.com>
Date:   Tue, 19 Jun 2018 13:37:14 -0700
In-Reply-To: <20180619185033.GC199585@google.com> (Brandon Williams's message
        of "Tue, 19 Jun 2018 11:50:33 -0700")
Message-ID: <xmqqbmc6v7gl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I also think that we should keep this first implementation of
> ref-in-want simple and *not* include patterns, even if that's what we
> may want someday down the road.  Adding a new capability in the future
> for support of such patterns would be relatively simple and easy.

I am all for many-small-steps over a single-giant-step approach.

>  The
> reason why I don't think we should add pattern support just yet is due
> to a request for "want-ref refs/tags/*" or a like request resulting in a
> larger than expected packfile every time "fetch --tags" is run.  The
> issue being that in a fetch request "refs/tags/*" is too broad of a
> request and could be requesting 100s of tags when all we really wanted
> was to get the one or two new tags which are present on the remote
> (because we already have all the other tags present locally).

I do not quite get this.  Why does it have to result in a large
packfile?  Doesn't the requester of refs/tags/* still show what it
has via "have" exchange?



