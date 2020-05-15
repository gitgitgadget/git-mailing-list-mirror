Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AFCC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C364206D4
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="CeEb9LpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEOVP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 17:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOVP5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 17:15:57 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CA2C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 14:15:57 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 79so4277714iou.2
        for <git@vger.kernel.org>; Fri, 15 May 2020 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mc8am8AQd5k7bERjY3jCxX7oW/YqbwdoUWt5rBMuDq0=;
        b=CeEb9LpQjMPFCNgh9FgjzsKGcnVfjJ5vFOdNhQYHLTt5AQXt0f92bJM6oEPL+vMXGG
         QxqRaFv4M7q8OQAbi/gZFAxcft1X0sbV+RrH0FJqljnmU8M+jWqpwxkCrSQivKV9Z/rk
         haYBhk0Uv8ZJopC5dIeTkuksCKFgAifVBzKN65JYzmG6TJPumuacTIzC4wtp4lWGKd6Q
         YtmxVc2/OxPoaNP6AoymoXe98aRSU8FAUEOZhzuZZ3sAmdVsV+/nwpPUOH08o76oseEL
         AfAItLdaSuggwKk1GuJslv6YQzFmVQxbGV2ms6De6hjMhBiVFZfG0W9FCeJSpVu3/sI8
         XjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mc8am8AQd5k7bERjY3jCxX7oW/YqbwdoUWt5rBMuDq0=;
        b=uUX4hO6SgIjXDfFh2Djkp85VORdepKFH95ZTRn9ZIPRu83YxOYqQY0RZKCqfPO5heo
         kYR8pQiF2C1h1cdsWguDv/AItJcbmI+GkmtN00gHwuIX62MjbMANNr7Kj9xMk0Tndny1
         4yNYiG/DltbJkpD/d5uEEx/5AmrckkY6Ol6lFJCinJ1ekp+ajDRHEor7lJ5pefOVhKQq
         L+PbFjJBtWdlXR+RwEbZ/xnmtDymlzvzJKu0w9fji7gWmhhWqdggMV5zyhf1apS3RWGM
         XRC733LepACH0ZEPbOjo2OIw9vbf+cg39pjwtuXeL29AxLSsssrABhPL4IlZ56v7mbff
         AfLQ==
X-Gm-Message-State: AOAM5303OPsJlr1iJRwQxd74u7HXMU8q6N7EQ2ALJ1zoZCFGpDupRxGr
        xAcnnWjMZf3IXfJUD/wW1bn2CnHhyxhOePQfcZnFNt16
X-Google-Smtp-Source: ABdhPJzzNTrAUBFLWy+Wn4zV5YJK4dWRfTxvSscV/G5RasenCpeIBFPyj/Qqr0kjTlg5OJgS5cFAbhYcmzCEFTBa8to=
X-Received: by 2002:a05:6638:243:: with SMTP id w3mr5157404jaq.20.1589577356860;
 Fri, 15 May 2020 14:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173242.6154-1-johannes.schindelin@gmx.de>
In-Reply-To: <20200515173242.6154-1-johannes.schindelin@gmx.de>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 15 May 2020 14:15:46 -0700
Message-ID: <CAGyf7-HbnCip8WZ9vtc_KW1kXMBUoPZQ8GD7H=1DOAk45Wbjxw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git for Windows 2.27.0-rc0
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 10:32 AM Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>
> Dear Git users,
>
> I hereby announce that Git for Windows 2.27.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc0.windows.1

I've added the 2.27.0-rc0 release candidates for Git and Git for
Windows to Bitbucket Server's test matrix. No failures to report.

Thanks as always for these early release candidates!

Best regards,
Bryan Turner
