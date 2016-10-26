Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B0082022A
	for <e@80x24.org>; Wed, 26 Oct 2016 22:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935919AbcJZWOY (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 18:14:24 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36261 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935220AbcJZWOX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 18:14:23 -0400
Received: by mail-qt0-f172.google.com with SMTP id 12so11187126qtm.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BXWtRMW0g1KojZDQ4T4D1cHwoAEoiZx//a6/Ul2cuHs=;
        b=CG/Ko4L/IFmiILKwacLHH6Ry4QtEr+o/BiwHFRsmwHs8L1IN5HTPV12/iFzerA++PO
         XPOoWL5bKDd6m5JC3bsvQEs/RFhOiLxMNnlJlPFzTM1zUOAH7y6yetKpQfJgQahPQSy1
         RfOhNngMEg33yxfVuyUCQtJ/85MFGdmdE04bT7yy/s8AwZAZVq1yCMxibL9RwW2Rayo5
         Dehmghe7LOIbkJO3N7cWEZLo0qHl990Qmke4Tx1CN5Uh1kVexI/5N1tctZFy/EQy69c2
         0Ll5ci1yqi5A9VpVou/PaKXrt3gWiZ2u/7jdfqmAg8xTkeON4NbXk5yEV5s5UjE0zL5G
         ynAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BXWtRMW0g1KojZDQ4T4D1cHwoAEoiZx//a6/Ul2cuHs=;
        b=lFXcOmlf6j3d9z8LU2eOYVTffAA4VREIeci9Y5DTuX126rsUJCTrGmyVTqtPfxY9IJ
         4PQDkh38onYus1Vyv2t7aUx9eyYtvzvPjVirxuKyOO2Y2pQk9oWVTFzswrEybZkMQUhf
         1hV52kgSdkZbczisfiT2eAAwDgeWv8d6ltnPH/jPJUBUuq/aPv7pZ3dEHwAPPus+UBkf
         tXCN0o4Wtunce8JxturxTec97RskAXAEXgdasjy85FqJWoSq1rjNC0e1kf2iGkj4irh2
         0t47HQ9pMxKajiOGOIiuVVSIYsvgkbuJ4gVwpQrByVKIMugbSpcFapRtiLh+GxvQuExB
         zybw==
X-Gm-Message-State: ABUngvdqKWuQSXfosEBI1RfKKmBt45R4oNi1tIUbUGCmnMCl3sm5erFH4spSe2VC7Sx0vjIXNhyYMY7autPFPZJD
X-Received: by 10.200.34.145 with SMTP id f17mr3808905qta.149.1477520062188;
 Wed, 26 Oct 2016 15:14:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 15:14:21 -0700 (PDT)
In-Reply-To: <20161026215732.16411-1-sbeller@google.com>
References: <20161026215732.16411-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 15:14:21 -0700
Message-ID: <CAGZ79kZryb-5jGif04BtK1V9tgFj-tnahqUk+1Lb7XeecU7cMQ@mail.gmail.com>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 2:57 PM, Stefan Beller <sbeller@google.com> wrote:
> In Windows it is not possible to have a static initialized mutex as of
> now, but that seems to be painful for the upcoming refactoring of the
> attribute subsystem, as we have no good place to put the initialization
> of the attr global lock.
>
> The trick is to get a named mutex as CreateMutex[1] will return the
> existing named mutex if it exists in a thread safe way, or return
> a newly created mutex with that name.
>
> Inside the critical section of the single named mutex, we need to double
> check if the mutex was already initialized because the outer check is
> not sufficient.
> (e.g. 2 threads enter the first condition `(!a)` at the same time, but
> only one of them will acquire the named mutex first and proceeds to
> initialize the given mutex a. The second thread shall not re-initialize
> the given mutex `a`, which is why we have the inner condition on `(!a)`.
>
> Due to the use of memory barriers inside the critical section the mutex
> `a` gets updated to other threads, such that any further invocation
> will skip the initialization check code altogether on the first condition.
>
> [1] https://msdn.microsoft.com/en-us/library/windows/desktop/ms682411(v=vs.85).aspx
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Flying blind here, i.e. not compiled, not tested. For a system I do not
>  have deep knowledge of. The only help was the online documentation.

This is of course a Double Check Locking Pattern, that Johannes warned about
a couple of days ago. However according to
https://www.cs.umd.edu/~pugh/java/memoryModel/DoubleCheckedLocking.html
we can make it work by adding enough memory barriers, (See section
"Making it work with explicit memory barriers").
