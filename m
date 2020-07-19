Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCD4C433E0
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C05A20738
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 08:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCQrluIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgGSI1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSI1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 04:27:07 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C4C0619D2
        for <git@vger.kernel.org>; Sun, 19 Jul 2020 01:27:07 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j186so6957336vsd.10
        for <git@vger.kernel.org>; Sun, 19 Jul 2020 01:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5bO0hFELSwkdDp/G0fcri4BIut87DSWLIsb9Y6KePww=;
        b=LCQrluIjQCYmuIjjKqXz0skVUC2nZ3ceBmn5Rjni4t+OAX/CQa9Oy7G/99tzQwEf++
         aynUwfkUPePy5MHwYbHtwFw5m3IHC0sLjGcpEgdw8EfdRrm4sXXtUZHg7DAvS5NZHa+B
         qBnqSNsW5wnx4Us48UkjItmAVTkPH4URSjH+zpj7BqK74u6BHKq6moS53wrWSzLSX5/+
         h5bX0ttrtWDsOrJqq+B7cboBK8MIxRQX4HLU1ZZVwFkEhnL6FO9c9y/TVGqGBMBu15D6
         wAcrzhQjYRKht3CdFyFy+e3GkjcCX99X1h3b2PIww0aMQ0y5UnEsJsImdJ+Nk6D9tFwC
         becQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5bO0hFELSwkdDp/G0fcri4BIut87DSWLIsb9Y6KePww=;
        b=F8/nV9ixUbR4ka4yv89sp628hlNKTBqkICdukmso2f80auOP71BcbVfNrCDDYu82iN
         6wf0kuF1wzMKvu2WUpvLxcA9U6TWn0QF+ejt0iEgjaMcUl+OJASylbaB1r70AoGkF6CQ
         FQYuCgYdayEISbuXa0m2+1S3pugarFFFbc+oPRZJrYUxjxXBewrP774vtnmWQ2WR9+xR
         EFKfW4B/hJClNPcT8n2oO/UwlaZY3smH7ppBgDeS3ZFOPud8MGflLRRbkcMn3v6LcEJR
         S8xfkvvsyKd7aw9dMtsHlc896lno2dulAuW+QAkX1aPvnq013vdxd1wsFwus5O2Baxs3
         wT2g==
X-Gm-Message-State: AOAM533rbV3g29jyh0Erp1Dik1Lg77Ts8yQ7f+YUlEHWqhfGChI8A+av
        xy3yoRJBGJUGYSFnmLkUWp4byfGWs4xzAu0stZ8=
X-Google-Smtp-Source: ABdhPJx8xXrXq1kxSoTDEwMcIF69BMFkROL+BsqaWUQYF8Q4UyxQFFtVSlM1uGpQwUI9DFZp1H6BwFfE9Jm1rBl7xSI=
X-Received: by 2002:a67:e046:: with SMTP id n6mr13076053vsl.6.1595147226404;
 Sun, 19 Jul 2020 01:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
 <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
 <20200716153159.GA1061124@coredump.intra.peff.net> <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
 <20200717063324.GB1179001@coredump.intra.peff.net> <xmqqd04ufutq.fsf@gitster.c.googlers.com>
 <xmqq7dv2fnpb.fsf@gitster.c.googlers.com> <CAAvDm6bG-s2m9fGXVtuyLB7_FSDRduhb3ptrBsL3ezR9LaS-hQ@mail.gmail.com>
 <xmqqlfjgbssl.fsf@gitster.c.googlers.com> <CAAvDm6aNN2kDh=SF6_K-v+cq0a94tcQ1AQ-Fpgs2mNo18FTFfQ@mail.gmail.com>
In-Reply-To: <CAAvDm6aNN2kDh=SF6_K-v+cq0a94tcQ1AQ-Fpgs2mNo18FTFfQ@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 19 Jul 2020 01:26:55 -0700
Message-ID: <CAPUEspj3A-bCo+WqiGksuLkqm65HAPiOjrWaAyy7S8XSy_Ohiw@mail.gmail.com>
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
To:     =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 18, 2020 at 10:28 PM =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong <su=
nshilong369@gmail.com> wrote:
> Is there some method(or command provided by git) that could get the
> comments of a certain commit (e.g: first, second,... nth)

what you are looking for is described sometimes as "relative
reference" [1], so for example if you want to refer to the commit
before last (ex: second from the top, counting as 0 base) in a
repository that looks like:

$ git log --oneline
b1824b2 (HEAD -> master) second
00d85f1 first
68757c9 initial

$ git log --oneline -n 1 HEAD@{1}
00d85f1 first

Carlo

[1] https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E9%80%89%E6%8B%A=
9%E4%BF%AE%E8%AE%A2%E7%89%88%E6%9C%AC
