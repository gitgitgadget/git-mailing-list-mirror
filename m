Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBD2C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 23:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356568AbhLBXRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 18:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbhLBXRv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 18:17:51 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57966C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 15:14:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so1880613wrr.8
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 15:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZpqSfPkSbxzY7TBnJQQPSsvMimgqEtONK/TGgK4v9/U=;
        b=mWRRxz4lSv5Qd5eLs6GlYveAPJfDvmzfkjuktUhjRvcRCk3r0LnOguIz7fSWZ4RWsQ
         WJtnDvQHtzE4FDytri7vy0BIEK5Q+w9HcKBeemInbnt/X5+yuXcDASAFmq0P3kFV2Y3e
         hCIue4KqDdVq2sd6b95yEJmKTHNvBj8JncpSOAp67b9jmESZiuYW6ms40DYCu9s5+u/I
         7nY7l+eHzyYlrmq3HHmVa3oCSFn+Z0mYmVS+g4L2R5eJUGi+1qDp7PiUIzzNsv54YsLb
         fbJcCzE8YQeC0y4WvIw3QTjU+IKHaGkVw9e3nhzPvK7f02iuYbRIOQa4QbSEixd/zMUp
         XcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZpqSfPkSbxzY7TBnJQQPSsvMimgqEtONK/TGgK4v9/U=;
        b=CfsIQvxUU2eMDlgFe48MPfdd9jO0lrjKZmoY54hcTN9LcQSGAFkfIBWXUFa9tDS1ig
         eHHCSRK4HKGZqtCvs5wY9FF4FlmRQXtTcG3CjqIgwFGtk2Na2mL+fno4aesL1eVDk8aB
         T/douFMFk2SqAk3F5VbQOejz2EoPvi7Pzn/ZqKyTMrJd2Znw+J78JTM/6NYwNcwPDqzc
         J1D2cIXfuriGy2txYD7WyX6wPvnZDQirc3ZXm4M3nHjTLBEutCuP2sy/nuVW8UBN6Ipc
         ykG/YWc5X90KKwVJpi2We6DBeDFDj3LMqlF9zXIriu9DU3i5RhTzm0tvVyI1cCK58rJT
         +eeA==
X-Gm-Message-State: AOAM531p/PZ/GdlNVsBt/cn5fO0i9a3rl4okzPHhjwsTL8mMN6H0Hqom
        aO9IDThcJO1RRLQK+OicIGc=
X-Google-Smtp-Source: ABdhPJxhmO3oTMXzRAJ1ZlmFnEGWwj41kDSvm8BkGXLP39Os6joKwAT6Gv5CldRcc66KOjZy4/uMtw==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr17347501wrq.354.1638486866986;
        Thu, 02 Dec 2021 15:14:26 -0800 (PST)
Received: from szeder.dev (78-131-17-57.pool.digikabel.hu. [78.131.17.57])
        by smtp.gmail.com with ESMTPSA id g18sm1054006wrv.42.2021.12.02.15.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:14:26 -0800 (PST)
Date:   Fri, 3 Dec 2021 00:14:21 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 10/10] progress.c: add & assert a "global_progress"
 variable
Message-ID: <20211202231421.GA624717@szeder.dev>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-10.10-01d5bbfce76-20211013T222329Z-avarab@gmail.com>
 <20211025050202.GC2101@szeder.dev>
 <xmqq35op4f7n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq35op4f7n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 02:38:04AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > I still very much dislike the idea of a BUG() in the progress code
> > that can trigger outside of the test suite, because the progress line
> > is only a UI gimmick and not a crucial part of any Git operation, and
> > even though a progress line might be buggy, the underlying Git
> > operation is not affected by it and would still finish successfully,
> > as was the case with the dozen of so progress line bugs in the past.
> 
> I too recall that we have fixed numerous bugs in the past year in
> the area, but weren't they kind of obvious ones _once_ they are
> pointed out at you (e.g. progress never reaching to 100%)?  Yet the
> developers have failed to catch them because their eyes would coast
> over without paying attention to them, exactly because the progress
> bar is merely a UI gimmick.
> 
> I haven't formed a firm opinion on this yet, but I think the idea
> behind these BUG() is to help such problems be caught while they are
> still in the lab.  You may not notice when your live progress bar
> behaved a bit funny, but if you hit a BUG(), that would be squarely
> in your face and you cannot ignore it.

The "outside of the test suite" part is important.  Running the test
suite with a GIT_TEST_CHECK_PROGRESS knob is sufficient to catch these
issues as my inital two patch series have shown at the very beginning
of this thread before Ævar hijacked them.  Interested Git developers
can even enable it in their .profile if they wish; I did so with
GIT_TEST_SPLIT_INDEX for a while to expose some of my patches to more
real-world use.

However, I think it's conceptually a bad idea to abort with a BUG() an
otherwise successful Git operation by default, when that bug happens
to be in such an ancillary component as the progress display, and find
the justifications given in the commit message unconvincing.

