Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4222BC433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3432073E
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="FDFbwCa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgFAEhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAEg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 00:36:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C704C061A0E
        for <git@vger.kernel.org>; Sun, 31 May 2020 21:36:59 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so6482794ljo.0
        for <git@vger.kernel.org>; Sun, 31 May 2020 21:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y902ftKmsWu/NQk1FaHC8Kw1NWp/6dcPKStnf+Iw2NY=;
        b=FDFbwCa1xFenIcRWHX5NFERS5RFk4PGiSKTQTAo4fFKak5HTSxMriZFjZa3u0V35Du
         MoDdVvjMh77Rx2lBVMMTWOLLT6xgruMW0Ok6hSaX73Bam4MR4mtgutB5/DFQnqG2W5ba
         PGkmYRwL1E4idnW1csVW4wI6kqPrGzXHK/2HnM3atu+nc3e6gpxm5DFTI6UXmvykgBIJ
         20ifQ5Lr1Qff7iTDs1jub0DUqBoNUIAKt0xo3ui1scblrAuKNjBFcGReOSSsjOxlH73o
         Gytnxw9dX3eYwNmtJ8x5q8SRfsoOd8ghVfU1N6hsqS0jm0d86XaZBCyoiHaIqziKlVFa
         1yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y902ftKmsWu/NQk1FaHC8Kw1NWp/6dcPKStnf+Iw2NY=;
        b=J361kYRUz1yv4zreJ5off9szJoMecTY/mU3gk7oN0vGtAtltFckuIhl26A12sRyQqB
         iQa1opVljmvRZMnSG2IN8LD4mmGaZPr6C60BGajNwPqlGx7RcpGScZcsmM50jICPbNOC
         /thIqrWTwwvHKOqRLXU1JHtsD99RTw3sZWmv3zZvf6XxWmOa9AMX9gGHI5H8irVzwp5Y
         wlTicqSh9E8kYpR1RybWU25qrkUQEIEExk/kD8D3DWEAWCPzHgT0yyK+LT0fuY2YhXEB
         wdoAUhkJjis9BYZ7jL945Hm8YwFtI0EIFAyaDphFIFr0Ic/bPT3+ao49EzXMHbOShrUf
         LrVw==
X-Gm-Message-State: AOAM532Asc+ywM4P+ZBX+Jd4ZMKlbpgzOSnqj0g5OUMQ1XM6L+/ppm4G
        i3jBmV23STCNILm35/mPYJB35jx618/Jm1L+Tpxqs+lXhso=
X-Google-Smtp-Source: ABdhPJzGabk40bGiyOvUpvJVNErzepWRlCSX7y7pUEIvlmP+afeLJISzQiq+dxp+dBA/Fii2VMzuwltrYamq8tnIxWk=
X-Received: by 2002:a2e:3808:: with SMTP id f8mr6530659lja.165.1590986217442;
 Sun, 31 May 2020 21:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br>
 <43402007adb0916846f92c3e4ff86d4131056ce0.1590627264.git.matheus.bernardino@usp.br>
 <CABPp-BHTmYy=AtXoCLG-xXQ_0EZ7=3xiMibkNMDLzsKCnHBoFw@mail.gmail.com>
In-Reply-To: <CABPp-BHTmYy=AtXoCLG-xXQ_0EZ7=3xiMibkNMDLzsKCnHBoFw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 1 Jun 2020 01:36:46 -0300
Message-ID: <CAHd-oW7x+A8ZmW-2XUkCcN2T=m_mHQMvfH7GCW58Q49OHgVZJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] t/helper/test-config: return exit codes consistently
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 11:29 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 6:13 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > The test-config helper may exit with a variety of at least four
> > different codes, to reflect the status of the requested operations.
> > These codes are sometimes checked in the tests, but not all of the codes
> > are returned consistently by the helper: 1 will usually refer to a
> > "value not found", but usage errors can also return 1 or 128. The latter
>
> I'm not sure what "The latter" refers to here.

It would be the 128 exit code. I'll try to reword that for clarity.

> > is also expected on errors within the configset functions. These
> > inconsistent uses of the exit codes can lead to false positives in the
> > tests. Although all tests that currently check the helper's exit code,
> > on errors, do also check the output, it's still better to standardize
> > the exit codes and avoid future problems in new tests. While we are
>
> That last sentence was slightly hard for me to parse.  Maybe something like:
>
> ...Although all tests which expect errors and check the helper's exit
> code currently also check the output, it's still better...

Sounds better, I will use that for the next version. Thanks.
