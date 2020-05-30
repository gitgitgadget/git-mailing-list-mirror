Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C759CC433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 16:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC0F207D0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 16:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFsYee+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgE3QYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3QYR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 12:24:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B24C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 09:24:17 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f95so1016676otf.7
        for <git@vger.kernel.org>; Sat, 30 May 2020 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWHQyTi7TvbJ8kVDwlkHDwFKoMiTiHuurYA5UNOFyIg=;
        b=DFsYee+QLYfmKhhobDHGDoQTRqol7IzKwkg8Bo0rCA/SuGMttRz4HfrtjQK1Vn8v9o
         E1jWrTwj5WniBDncWlh1HUSRh+5x8tcuOwNRv7OUCm5E3GzoIJlodnj4Q45ThXLEXPXj
         CzAzPDtrLmE0fULbUUKbLSKWHJ26cNzYxS5FDWwlXwQYe/c6LnA2a8XmA8MPURDiQoFP
         ysPesHYp4oW4spzwW9jNqiQqQ8dF4yU6y5aPecOyJcJ1+Vc1cZ5hvwfGsdHmcT496/9Y
         6iX/6BJKtl6KrWXs54AIKBFy8SLYTnCRwJpdJvUC3BGX5m9Qi9m/b4c1YCxv68A6aceG
         QYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWHQyTi7TvbJ8kVDwlkHDwFKoMiTiHuurYA5UNOFyIg=;
        b=eSwmQ38959lRrAkIkXy9F0Lc46cJNibYiK5I3aZ8OxjF5NV1rlgmRugrMarfuVwMOz
         mH/q4ExXlhzYe938mBC9INVeLCFOG0kufiV6ykLgxIjPq+s3/csBwbRkcyZ9712LeL9b
         lXvCx0k24dsv1bEYW1JVdj0TZ5cRjkBjj4o3OOKybA17n2HFn5SI2hSK+SdqGZJqOjYZ
         jSZzt5Bc+sdxilgESOggUs13u0RgLi17m3wKdgppe8JEohUWtw7Ozt3Bpv3bg63Y68mB
         JpppSx6LfuPv5fI2AieECtuUZV7DrlAx3yrUFqcOcDE87UexODmctzUWf+SdcaVHNda4
         hR0g==
X-Gm-Message-State: AOAM533/n5ZSSFXKYcXNfqSMsnBqMaj0iDjj1Vtd9O1f5btlAHGbbJrM
        atTTJqk+6yT9ZgSG581q/uMvFh0wQdNh2v0p8qocvCAb
X-Google-Smtp-Source: ABdhPJwKKgXb7R1Gedtu9rIN7nHKA+MrmATS595it15+azdop6xQKFrzTyuVn3OWFtv5ahqx2Dq/ktoo8ULZcS9UOR4=
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr10795790otd.162.1590855855874;
 Sat, 30 May 2020 09:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <CADhmr77EbC+3f=Oa+bm18Z_SSEMK8vCjNHQniuvkdfaZdRT_5A@mail.gmail.com>
In-Reply-To: <CADhmr77EbC+3f=Oa+bm18Z_SSEMK8vCjNHQniuvkdfaZdRT_5A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 May 2020 09:24:04 -0700
Message-ID: <CABPp-BGh0T1xio-pRb=JVNbJDK1PWpo+v877nDfjcm6khn6NDg@mail.gmail.com>
Subject: Re: [BUG?] 'git rebase --abort' couldn't abort aborted rebase
To:     Md Naeim <naeim249@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, May 30, 2020 at 3:52 AM Md Naeim <naeim249@gmail.com> wrote:
>
>
>
> 01718479491

Could you provide any details beyond the subject, such as the output
from 'git rebase --abort', your git version, the output of `git
status`, whether there are any untracked files with special status
(e.g. ignored but a submodule in the way of something?), any special
file permissions (does root own some files and prevent git from
updating things?), operating system you are on, link to a repository
people can use to reproduce?  Without more details, this report is
unactionable.
