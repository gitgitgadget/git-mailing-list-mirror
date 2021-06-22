Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9C8C49EA4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64A8611CE
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhFVPJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFVPI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 11:08:59 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2203CC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:06:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q10so24070896oij.5
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M62v/sAcvfIo1x7K3nMY53B3SIao1WumYO7Gy3/Ff54=;
        b=XY4alJZ1ShyVAdGf5m+GsA87JSJWB+ftXw0ALu9CO3O3t9CSv6PpI72TRVMtyXsz4e
         wMUZbkEtxlxY493MnMJVPG6ds5M5AiApZYLs1PQa6fN0/Hc+V0kpqVGh+IrUJN3fWT8q
         wPgloVdse8yVP26XSIk/Jmjgw9Jcvrx3AZE+HBMxDmROsu4nDh9n3RKE1BoA1vvNTC/Q
         6wJeVl4O7k/mmhtv1Y+HzDsHBmgmcwAvHPoxVXsWDbiwzdpZttFWUkQwCaJflW8kbFme
         et9p8++7AhGgRFDL0EbVyRmwRGXJ2CxekL9BYjPztcqSsXREU+Pi3V2DYPIJsNtngCf7
         FzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M62v/sAcvfIo1x7K3nMY53B3SIao1WumYO7Gy3/Ff54=;
        b=B9ixp7yJ8qGC/1nkJ4zATOvMwLudnIfe5IPFxAArmUGeePor5lPwLFF/26MhCDgLwA
         Y48+FAoNSh73EUGtEfO51VkVPnQCrGvbgGHtNj6VcLBquvb6hkj8G/NVAEbGcrvSO9z0
         GLw9MbHk9pMGM4JPp1x0RNESckVxDis2fcznRt9a6gAdIuOKa+q98mV7iL6YKRcdWBUH
         zvjx9Rf4E0IL+lVFXhoPXJ1zViWeexo6OWRhhiqpX4YOefG9rpXEHJdxQeqCqA4OQU1T
         fgBUromN+IrGZgORhv0PPQtaRoiCur4749txgNx5sp6Y2dm1PSHSramwIcPgM3Xby4LP
         hH5w==
X-Gm-Message-State: AOAM5321x1OzL/jMt6DMImbR4ampfTdsmFKSzhp95H524gZUtlpH/xlE
        QbSO/5BnJ9Okb2qRtaICke6KwHxmk3Nfq3gDJd8=
X-Google-Smtp-Source: ABdhPJxCrICY3JVvUz8/dfEk00urD7oW4+7sj18TFRDvrj1Y8jjHo8YKhMqcZQjEGdI05lp3eWLwhl0ShmfplGECZqA=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr3342523oib.39.1624374401349;
 Tue, 22 Jun 2021 08:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com> <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch> <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch> <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
In-Reply-To: <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jun 2021 08:06:30 -0700
Message-ID: <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 8:15 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> My only serious objection to this patch is the instruction to merge if
> you don't know what to do instead of asking the repository maintainer
> what to do or reading the Git documentation. I don't have a strong
> opinion on the rest of the patch.

You're not alone, Alex; I objected to that part as well.  (See e.g.
https://lore.kernel.org/git/CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com/
and various other emails in that thread, ending with "agree to
disagree" later).  I still object to it as I did then.

I'm curious whether it'll just be resubmitted again multiple times,
eventually with a cover letter that repeats something along the lines
of "these are the non-controversial changes from last-year series
which...don't have any reason not to be merged."
