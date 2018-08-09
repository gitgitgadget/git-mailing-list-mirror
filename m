Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFECA1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 22:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeHJAe3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:34:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33458 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHJAe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:34:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id r24-v6so3448206wmh.0
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=db0CWG9EpG/2NPbkHGWmHLlVsOivB3VekppxqL3Lge8=;
        b=YHig66dgnvFtzVkLL0wFfDS8vlPTtNl+qlcm9nMlRZeP5sKOY3NVml4ShVI3HVe4KC
         UWkcJJhP1u/r2QQOIMYYi5QRzxz9QmLRWOAGx3jcKo3WC0OaYVvJubFjWGhSJX6Fdywg
         Fz9gA5LuBKzVl5PZTacdhPMXCKt33QryWJ+bKnQ6ZlCzgO3RXk61a7o9brK0jt++zHmi
         YKzqhsIFHqu+O/94Itpj+jWiU55a6+b/Pg7M3IJJ8v4OsyhqicngrIu4klg2wnGDYIEn
         uzkbd0237iXQnE8GkEhl/QCuOAIaDEzjYCz0KLh66IoxKpPEJSoP+jPQyq2rnxYfTpvB
         H6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=db0CWG9EpG/2NPbkHGWmHLlVsOivB3VekppxqL3Lge8=;
        b=Z96IsVnLxDzGjTjba/z1/rU0VjbUjU03HW3F6PrY+G3OK4aUglxA8LaU5Y6ZZskqoM
         OG42wGOMj3GIkFXNrmeKtG2CAVb13sYGXfnq9BOy53SiFmacDF7cpQ08MJNbDkZCIUcx
         bj/nC4A6bhG5zZ33K93uWb9VXgboPcaXESk/z381W8qU+R6sPP7X8RgyPIarECcZtsje
         cPazD6rHTe5jF20uB8gOvr5uwThPoXrotyjy77sV3rts8jtrRR3i0HdAqMWql5hams3B
         iXFgDD8K0W2bTGEb4FudUp4aXqDqvH7MwqWLuz8JRPHdFELCR4Ov/Jz8ufKh6HlqowzR
         CTNw==
X-Gm-Message-State: AOUpUlGd54vCgklAVrw06iF3oEfqe+RfxRe263Dhcaf14eaaAHh8E8y2
        efO8Co97exVmQnL/k7TqLV0=
X-Google-Smtp-Source: AA+uWPzI5piFpf3BNo0gZzRgG1mbg8uaHtoqUamAp68tV8MNrqr2FVPZYfmqTPFoW0fYjiYo2chYPQ==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr60283wmd.51.1533852457132;
        Thu, 09 Aug 2018 15:07:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i125-v6sm15097254wmd.23.2018.08.09.15.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 15:07:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive filesystems
References: <20180730152756.15012-1-pclouds@gmail.com>
        <20180807190110.16216-1-pclouds@gmail.com>
        <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
        <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
        <20180808223139.GA3902@sigill.intra.peff.net>
        <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
        <20180809142333.GB1439@sigill.intra.peff.net>
        <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com>
        <CABPp-BHiB_gR-dQbpJtSBYPJ5Om4Mv0ymnZFNocyTfbUotyBgw@mail.gmail.com>
Date:   Thu, 09 Aug 2018 15:07:35 -0700
In-Reply-To: <CABPp-BHiB_gR-dQbpJtSBYPJ5Om4Mv0ymnZFNocyTfbUotyBgw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 9 Aug 2018 14:40:58 -0700")
Message-ID: <xmqqftzn9ot4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> A possibly crazy idea: Don't bother reporting the other filename; just
> report the OID instead.
>
> "Error: Foo.txt cannot be checked out because another file with hash
> <whatever> is in the way."  Maybe even add a hint for the user: "Run
> `git ls-files -s` to see see all files and their hash".

Once we start using OID to talk to humans, we are already lost.  At
that point, it would be 1000% better to

 - not check out Foo.txt to unlink and overwrite; instead leave the
   content that is already in the working tree as-is; and

 - report that Foo.txt was not checked out as something else that
   also claims to deserve that path was checked out already.

Then the user can inspect Foo.txt and realize it is actually the
contents that should be in foo.txt or whatever.


