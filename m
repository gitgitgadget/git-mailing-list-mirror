Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AA9C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C501020872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="CvNCfyDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgJGVqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgJGVqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 17:46:00 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C8C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 14:46:00 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d20so4094731iop.10
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Sq2mdb4DOr7IvUdGbpM0eS0YSJZW+CxdfUqP/iA3wk=;
        b=CvNCfyDw98/iHE2Gj+fdp1dvXOWMyspaj1uJNVNnCAHnOy1TfHAV8H3jglWuWj3g0F
         Z4wVz6Ha8xeMf1jvnlu27ACa+jfRq9Qohw/sl+IBdUnKo8wmIXDnpKhcvedgtu0kc/Ke
         wpSk3O/6XN6HzPVaf1PCY8ZF8EPWpjKjE98RMVI1C1cuX5VjrkD8XzsQ9HjMAIA+bCwg
         P5MHa4NIClQnTG2Oaj6yr6WutjKuVajUXOLzWDyy5Xrpd5SNUWGmBps7jGEdm0LCYWBs
         3rZKUPs4GjXWiRUBW58sutLAXyUlPjIjVvZLWmyqeMKiiJpbqzBl2w/DrlgiRZ7OshTA
         NocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Sq2mdb4DOr7IvUdGbpM0eS0YSJZW+CxdfUqP/iA3wk=;
        b=iTfoHsuZ4QAXgS8p8cP+O8PJKDp9kCi7TZ8WxSgnKXG5GC7P8s4N/64nyDZqZVgSB2
         LYzZbkCZnWkguhY47X9rdU6sHIOmbmCD1aagEQsTaDCwQkBlOGN1n8mW7N+1GcP0SBEK
         ZZvMLFR6Mimuw2/UyBhn9kkb40r/vUt9xi2sCzfDuadv3FVKaz3DUivAXkYE6P3cnkp4
         NzFFH/dCJRt39O3rM+Z7z6oU/NR4Yc6gYnHev5QI1ic6xHro+YfybCfjA+GtWXpZOGiR
         ZQ54TLgtxcTxigKU9/sD8gQ1gdPtE9h3LMEMMUi66L92HgwFNF+eVBUbRc6oZBZnLX8v
         svaA==
X-Gm-Message-State: AOAM5338NkJ29I+2h4LOGhdF2NOF3NMOPGxIOtc5xUNTAF0y/2h4YMFU
        oYkRSfj2f4IwOPByycDSXsxzWtitJmyIhhaRpHXRwQ==
X-Google-Smtp-Source: ABdhPJwkwfKUJw3zzSuWqJa7UcWyKbb4ZM/G4VW325tPVfxpyo65433/OeMysf+2dFgskX6/PBmSKXWNFgUbhLhu0AI=
X-Received: by 2002:a02:94cd:: with SMTP id x71mr4374192jah.124.1602107159192;
 Wed, 07 Oct 2020 14:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201006092535.6419-1-johannes.schindelin@gmx.de>
In-Reply-To: <20201006092535.6419-1-johannes.schindelin@gmx.de>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 7 Oct 2020 14:45:48 -0700
Message-ID: <CAGyf7-Enk2Dk2gzGssW+6FEQe6vn7PazyEEJMAQfRzULQ1cHqw@mail.gmail.com>
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.29.0-rc0
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 6, 2020 at 2:25 AM Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>
> Dear Git users,
>
> I hereby announce that Git for Windows 2.29.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.29.0-rc0.windows.1

We've added Git for Windows 2.29.0-rc0 to Bitbucket Server's test
matrix. No test failures to report.

Best regards,
Bryan Turner
