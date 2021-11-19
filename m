Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621B3C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE8361AF0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhKSFlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 00:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSFlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 00:41:16 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8A0C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:38:14 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id k83so5248974vke.7
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROsJAb7gFuceQ3AVb+4R9duxUn6PWve0hQ4lUjDG1BI=;
        b=KZXd/PN6tlUqH5ZNQRNXDnSPFHs7MCIRYK+EIz0D7BkKRMXzGCMm0GxHeh2x2E44oU
         RisYdpW2iRJMZpfRjFcD33I8pwSpRQIkXvvUg+sGTYbMfSiiKN8qvJxFhtyDxoE85Sqt
         o2+mYSOqofKrQrw/KceosgMOWqb183eS7tuZjmxHNWJb2ZLYma0nSGNqGqDVz7gDDWdE
         Hdwqi2Tm42H6fVoK6ErBTNq5v5EAmg39lpBR8TaMYcYmkZxgQBxjHkBRjDnzWzdP0zB5
         8Lm1oAgcUJRCxQbHilwbLxN7eJWzrTMGBZV+TfDyjJyUwmX3sqNx2NsNs2dUPZs+C+Il
         CPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROsJAb7gFuceQ3AVb+4R9duxUn6PWve0hQ4lUjDG1BI=;
        b=D/cwSoeZtjAXKcCdJNbZDq3dSFnj1Cqe66Nn7CfyFdJzlw1TT9kx8CCOhnDksYLBde
         MS70FIK/UodkulRiSc7FJRC8J5fbFMQPY3RmnWjcff5dZUcKKQw5a3GN2H2ItgCKTCxD
         KfruvFM/asGARyHgKVBRm8Oe1aVhP+fjtHV8T7XncK4qCCMcX6pBYQVsIghdwmlUriC3
         QFJv4bEkPpVgQ0WUzcX8Xs7e3bBLWxdvC1pRUXebNlRglX0d3QphkOJVDWd3YdbeAo3X
         GQm5JjPWUFVmeCWjcHjOAC1EE9yN4QbTL8bRewOmxYSW+O8bJdVtUKJIZCeUvFiQ01DQ
         8z3A==
X-Gm-Message-State: AOAM531Kaeux5OiVhOn3phpsQ+B2TBnoqSd/Kt17EYith0Qpj7cXlhEa
        7YDx4Tbd0c2jlVqEmR8XoAPVNzPSUCprVR1G7ro=
X-Google-Smtp-Source: ABdhPJxHz+sLZcroGdGvnAv8gO6FKSxLBbD0B+16dywBHs7Z+JnvHN2TGiGyczADmVEk/5iCTcet6IY3YMhOpIuEVAs=
X-Received: by 2002:a05:6122:2193:: with SMTP id j19mr115148894vkd.7.1637300292955;
 Thu, 18 Nov 2021 21:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20211005063936.588874-1-mh@glandium.org> <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
 <20211118030255.jscp2zda4p2ewact@glandium.org> <CAPUEspg-5+YdfTJ6zi9hdDqF=KV2LJFCtqmECSss9Kfpn6sGrQ@mail.gmail.com>
 <20211118053415.4axljmr4s6kmqmms@glandium.org> <CAPUEsphf0d90HGg64j=jZnt-Xuhs_bwmeOyoUnmzesp_k2c4JA@mail.gmail.com>
 <20211118090542.rcaggue6zpd7r3ht@glandium.org>
In-Reply-To: <20211118090542.rcaggue6zpd7r3ht@glandium.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 18 Nov 2021 21:38:00 -0800
Message-ID: <CAPUEspjZmwoOWSJHBrykOfNEv=zLi2nQLs1EkUPTPr-nSNf08Q@mail.gmail.com>
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on msys2
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 1:05 AM Mike Hommey <mh@glandium.org> wrote:
> Oh my bad, I overlooked an important part of the build log: it was a
> mingw32 build, not minwg64. Mingw64 builds fine without
> -D_POSIX_THREAD_SAFE_FUNCTIONS=200112L. Mingw32 requires it (because
> the ifdefs are for mingw64)

Can you confirm the version of the winpthread library in your SDK? and
output of your headers, or something that could back up that statement
of "ifdefs are for mingw64"?.

 I definitely can't reproduce it, but I also have a freshly installed
32-bit SDK.

The proposed change was meant to be backward compatible though, which
is why I am holding on submitting it to git.git and even advocating
throwing it away (even if it has been in use for several months) and
replacing it with your original proposal, but would be good to
understand why it fails, and why yours wouldn't.

Carlo
