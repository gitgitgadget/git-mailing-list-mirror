Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB831F453
	for <e@80x24.org>; Tue,  5 Feb 2019 18:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfBESBu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 13:01:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfBESBu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 13:01:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id v16so2796979wrn.11
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 10:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C3xKihpG7PFYliEZRzPRDOVdCHzKmyCRS8NycMN4R0o=;
        b=R8HjZz1tKdpVkROpnItbzje0BafqKHl4tFcg+hOd88sKLg8frYQd3FhV3REufUBiiR
         cb4DUxTJPBKSRsYAGuaF2jgiRZLtM09evJqXU2HikpUP64FkdGnv74MbD/b/9eS5YrOu
         JaFUThDXqfqUhE4uv+DlHkNERRgK+lkS5JekE9NB2nshFyS08jfTj7jr/QB7EUzuakzh
         BJkiwE6Yjzt5fpi3lIAnS2/e6571KeFwQprVtWv9ernSaGZS3WSNxyfKPlH5U+wa+l0S
         PejatBquwOq2VFuHkbNwSsb/wlXOQQFwJ0glldP78VQByTjYDFYyUkD4r6A5SEAbY31W
         y9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C3xKihpG7PFYliEZRzPRDOVdCHzKmyCRS8NycMN4R0o=;
        b=CryfHMPkCFrfYRanuRvO343q4Gi024nVFk7dDn1/Vk9uFEHbaNi9QVkf/9pxFNuTWM
         8myYsLAqiBVHM4mM55KR4cZYdVwMv1utLsUuzjrCXNWwjO5ChK3GttQaA5sRHBKyJtQM
         NHzh1ZIJ/7zSFFzUTbJ3aGrADn0LJkNjn3gGhoxg9BLDGLTZ+/W3OLxXgRrgdbNipyym
         VwQQlwoV/d9Hh9ib84qoJeZQRNd5KjvnALdQPXxToHb9o5O7sDSwXEOpMyKI0ebZbWNm
         g+mtw55BRb0DrYg+7qoALKReOUOd4mQYT2kQIMpBmo+mcyJlEMKqIRzcttEwYKHcpwwY
         Zntg==
X-Gm-Message-State: AHQUAuY8IDIqGswvNecphPqC81/3p3EQgTo4mxC89t75aikhLBxlWl/2
        KXpMbD9vvvHDb+imqyg1smo=
X-Google-Smtp-Source: AHgI3IZzBgqfixxWAkvkMfvO+OdpT4X9Bd54wPGKVodBOoOWC0QFyzN8nMmkLxF6Fmp0xgpfKDpD7g==
X-Received: by 2002:adf:b783:: with SMTP id s3mr4882377wre.274.1549389708067;
        Tue, 05 Feb 2019 10:01:48 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z17sm14689399wrv.2.2019.02.05.10.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:01:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer size to vsnprintf
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
        <xmqqd0o7tdxt.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902051140060.41@tvgsbejvaqbjf.bet>
Date:   Tue, 05 Feb 2019 10:01:46 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902051140060.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 5 Feb 2019 12:06:06 +0100 (STD)")
Message-ID: <xmqqzhraru5x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Or that they are read with a fine toothed comb, but that the focus lies
> more on style and maintainability than correctness. We talked about this
> in the past.

Perhaps we can do better the next time, then.  I find unreadable
code is impossible to reason about its correctness, so you'd need
to pay attention to style and maintenance issues to quickly get past
that step.

>> Thanks for finding it.  This needs to be squashed into bfc3fe33
>> ("strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`",
>> 2018-12-20)?
>
> Since you want to open that can of worms again, you will also want to
> squash ed5d77f7d382 (stash: fix segmentation fault when files were added with
> intent, 2019-01-18) into 1f5a011d90ec (stash: convert create to builtin,
> 2018-12-20). It will have trivial merge conflicts, and the addition of the
> regression test will be surprising without modifying the commit message to
> explain that there was a regression that was fixed very late in the
> development, and that that regression test intends to guarantee that it
> won't need to be fixed again.

Are you saying that I should not merge the series as is but expect
an update that does these squashing?  I was planning to make this a
merge-down day, but let me exclude this topic from the "for next"
batch just in case for today.

Thanks.
