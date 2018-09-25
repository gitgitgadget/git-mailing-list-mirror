Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0EA1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 17:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeIYXt4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 19:49:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52085 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIYXt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 19:49:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id y25-v6so6897429wmi.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OsaXi3D9jCB3yQS7aC9Z20M2iVtqmWQahx+fIJlUDr0=;
        b=p9buPca4np0ttqIKmaryiXuoyPW8FhMFga9j/y1QesWEyPls4DG4SXsUMYBum4UBa6
         LojT7vuHCcL1itSeimAbqjla2Fw7wPGnO2JlU7uv/4sHtuAMPUD5sefBz/BIjONtxtc7
         Lg5Zo1nWAxgSkPGXH9zZoOcckcCDkU2meFVZEzi/fQVRzDNBWBaDdXBc6w3BRSwI4XlW
         JRuhagrXr3jvWYwxyIMdKOhNDGVhkIOu8cnjAqGyebyH+wdBf1DASsSvAgVIPUDzldIW
         rcWs3tsB1RBRoYnLWz/cmaSl/JVXLKGfiL2HkQ5mIWhH68uceUeiMPp3xC/M45EC8ISQ
         eSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OsaXi3D9jCB3yQS7aC9Z20M2iVtqmWQahx+fIJlUDr0=;
        b=kq2hApNv04GoU9EioFqizlHJ46Jil4zEBPEOiWIN6EzkY5sPftZfHbH3itT4AOWiR2
         36qYzUm5Az9WTDVMfXlF3VhNU0TADzMrL79wWaaFt0THvvEQ4PYrEy/p13X1sH6cISB9
         qBBkR9Xjns2n7JxUgShZq/Ob33W0LO4DDN/ycQm4G81ymyc3GyDCzC4F4i6dLhxklBP8
         o6M6rmj5vdJ37K0hXLBez1XWZCoMP9sVQaquZl0OQyAwY0t5h7E58t+Uv2r1X04X4qcm
         sVICg2luOnMXFTpFvMHH4MGAQcMSJfR+ZTqiD1oEIz1KOL82CQiCINBbJCGNqxhvXzFn
         EhdA==
X-Gm-Message-State: ABuFfoglkFGRDggOrv4O+lflwkkykGNz5ci+vC+6ESWU5bgGZsbZE2Zx
        oNxqgoJ7dEiRDlPjpH7O6/k=
X-Google-Smtp-Source: ACcGV60+RNAHy1PYplJrm9/Hl5tmu4acOQro9fdYvwBCAfCVqSemZDnHoFiKzj3G7Gesc6yL5DvHlg==
X-Received: by 2002:a7b:c0d3:: with SMTP id s19-v6mr1658595wmh.119.1537897280309;
        Tue, 25 Sep 2018 10:41:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z16-v6sm2747699wrq.78.2018.09.25.10.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 10:41:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
References: <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
        <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
        <20180921213753.GA11177@sigill.intra.peff.net>
        <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
        <20180921221832.GC11177@sigill.intra.peff.net>
        <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
        <20180924181011.GA24781@sigill.intra.peff.net>
        <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
        <20180924205022.GA26936@sigill.intra.peff.net>
        <xmqqva6ur24y.fsf@gitster-ct.c.googlers.com>
        <20180924231455.GA7702@sigill.intra.peff.net>
Date:   Tue, 25 Sep 2018 10:41:18 -0700
In-Reply-To: <20180924231455.GA7702@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 24 Sep 2018 19:14:56 -0400")
Message-ID: <xmqq1s9hqxtt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Right, I think that is totally fine for the current uses. I guess my
> question was: do you envision cutting the interface down to only the
> oids to bite us in the future?
>
> I was on the fence during past discussions, but I think I've come over
> to the idea that the refnames actively confuse things.

Alternates are sort-of repositories that you interact with via more
normal transports like fetch or push, and at the object store level
(i.e. the one that helps you build your local history) you do not
really care what refnames other people use in their repository.
E.g. it does not matter if a pull request to you asks you to pull
their 'frotz' branch or 'nitfol' branch, as long as the work they
did on that branch is what you expected them to do.  And I think
"I am aware that I can get to the objects that are reachable from
these objects I can borrow from that alternate when I need them" is
quite similar in spirit; the borrower has even less need to be aware
of the refnames as there isn't even a need to "git pull" from it (at
that only one single point, you would care what name they used in
their pull request).

So, I think we probably are better off without names.
