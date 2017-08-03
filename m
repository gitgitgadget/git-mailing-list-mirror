Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466E220899
	for <e@80x24.org>; Thu,  3 Aug 2017 02:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbdHCCVe (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 22:21:34 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:37145 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdHCCVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 22:21:33 -0400
Received: by mail-vk0-f50.google.com with SMTP id r199so244378vke.4
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 19:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MmYG3zOSjhuJ38sPBU1kWQwKodB7xMJYOz+DqzYub1c=;
        b=U+XN+Bfyt8VGmrh1or7ZslDfdlTNjg+Y5HVfqFqbxQn2dxaijnqfEmiwo0gAXGftRL
         NbgrPdojHYkuyvLRw4iruoQjhMwuIgWbYWSV0yxJR8tYCX7vW9jxOCLslXABXw287cuA
         oki3zKh1Q7Xzw9n/2Hxi/PShmhWE/is0ddFNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MmYG3zOSjhuJ38sPBU1kWQwKodB7xMJYOz+DqzYub1c=;
        b=CY14GBku/G0Cyf5ZoZ/9e0zTVuVguqd6zwiOollQFIDxw/EBoP9WtUv5sWtOnsx3xx
         0T9/3MAvAIWaK2cvs3dqf5L8jLc2GvSopyVkjaavGfcgT0ksMvtP1JlTD/DSILqBC7MJ
         LCscW/tWjUbG7pLBPaLBXmU0CHhvF8qelihYTA/KjeDHN5Wuow1IqUoj0tdvEpXsIzlB
         +5x1MAXF+5ePILRaowZpbuZPp9tel+VVEKCP5aVlgnyEMo1dXywhV/HYa3bUOALjYG3X
         WjNWVv5hq0kVYvNAeelPMJm/xeIxeYSiibu2mjCa9QoDGDhJZ6qgC0XoK/XP2EB46UWW
         C1nw==
X-Gm-Message-State: AIVw110uWBzvCuAQZ021DLXOWzi+KTi9QNIXvvBo30pjJ6rNy9iNh3rY
        QaVfOOjAUlDrGKFSVfbpKONFHpcqOPlc
X-Received: by 10.31.128.141 with SMTP id b135mr73619vkd.22.1501726892016;
 Wed, 02 Aug 2017 19:21:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Wed, 2 Aug 2017 19:21:11 -0700 (PDT)
In-Reply-To: <xmqqd18dqv0y.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <xmqqh8xpsq9c.fsf@gitster.mtv.corp.google.com> <xmqqd18dqv0y.fsf@gitster.mtv.corp.google.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Wed, 2 Aug 2017 19:21:11 -0700
Message-ID: <CAJo=hJuWc-hLyTgtdO_AYjUhvRWFSY70bBPEgNtygs5ojJcKyQ@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 2, 2017 at 6:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I like the general idea, what the file format can represent and how
>> it does so, but I am a bit uneasy about how well this "stacked" part
>> would work for desktop clients.
>
> Two more random things before I forget.
>
>  * I understand that you would want to allow both a ref "ref/D" and
>    "ref/D/F" to appear in the same reftable file.  A refname is an
>    uninterpreted sequence of bytes and refnames are sorted in the
>    table.
>
>    Would it benefit us if we define the sort order of bytes slightly
>    different from the ASCII order, so that a slash '/' sorts between
>    NUL '\000' and SOH '\001', which is the order we should have used
>    when storing the entries in the index?

I'm not really with that. It complicates the compare routine, and
makes the data in reftable sorted differently than we announce in the
wire protocol. That cuts off any sort of optimizations we were
considering at $DAY_JOB to plumb the wire protocol code in JGit closer
to reftable code so that a large advertisement is more or less just
dumped straight from reftable to the wire protocol with only minimal
formatting changes.

>  * Even though readers can continue accessing, starting from the
>    $GIT_DIR/refs, without locking and get consistent views, any
>    transaction that groups one or more ref updates would need to
>    take a global lock on $GIT_DIR/refs file.
>
>    Would it become a problem in a busy repository?

Potentially yes. Writers may need to use a randomized exponential
backoff while trying to acquire the lock. For big application servers,
I recommended wrapping the file IO locking code with an application
server managed lock + fair wait queue. This is fairly straightforward
for JGit to implement within Gerrit Code Review.

I'm not really sure how one could safely do the same thing with
git-core. Its certainly not going to be portable or safe on NFS if we
tried to do anything fancy with flock(2), fcntl(F_SETLKW), or
semop(2).
