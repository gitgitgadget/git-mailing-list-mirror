Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5349EC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A04461181
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhHFQhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 12:37:35 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:44805 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhHFQhe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 12:37:34 -0400
Received: by mail-ed1-f41.google.com with SMTP id z11so13825017edb.11
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 09:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkAGFNkwCBWWk8ya495kIK9RUUhrfXoikatOLVRbjJ4=;
        b=jdRU7dMQt3MSIucZn5+44ndKS7iOI2c9+jaFJGOQwwzCWNe4d7BgfrF0F6XtsRHtcY
         GAn1HmoxHvZbb9Xnkw4s3UgPYbhw6+MunNq3QQUnEC1xbZbIfs+hvxPlmOHNTQY/jNRL
         a2VbjJ/PqxjNMGHXn1hZ92wfh34tEM3cS7J5OjPaaNScwaIYDJIjhDe+n/WnGCoLSXrP
         7FamjXRQGQDlibfTxx+H+OIo+XjXG1ryBoU/Yqz5WbOQz6YzQ9zcBJhWDNXIr3nliVM6
         vie7XH2nU+0EbQQGcBdvZhZv8Ao9T0i7KRmvGRC77IxfO6JMqWFP80YvvrETxEOb1yHy
         LFqQ==
X-Gm-Message-State: AOAM531U82KvQeEDpaMrAKBDZ8p+UcrxeJEcPh9J+MfBtZeXC9OVi0hY
        eoJuCo2JW8lo8TWTZP0Gqh+Vk089EGnit/jYtu0=
X-Google-Smtp-Source: ABdhPJyfdkOGw8+d8R0ooPn+RjiI2CIWH+V1aT/mtpCjG2KTbtxgRPHGVQVKOS5yHrLu3UnkGgB4vZZdJ9kSaoK7BIw=
X-Received: by 2002:a05:6402:d7:: with SMTP id i23mr14170767edu.291.1628267837418;
 Fri, 06 Aug 2021 09:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210806080634.11869-1-carenas@gmail.com> <8d3d5d2e-cad9-2b02-13d0-b6be1b96f730@gmail.com>
 <CAPUEspgV3KoUOo=EDss+PTdHO6+Cp=ODDjYm7WRm8F0HHgJ08w@mail.gmail.com>
In-Reply-To: <CAPUEspgV3KoUOo=EDss+PTdHO6+Cp=ODDjYm7WRm8F0HHgJ08w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Aug 2021 12:37:06 -0400
Message-ID: <CAPig+cQBD5HbjoU=rMi=capLS_KFojYAY_OroeBCW3KRsUqamg@mail.gmail.com>
Subject: Re: [PATCH] makefile: update detect-compiler for newer Xcode version
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 6, 2021 at 9:33 AM Carlo Arenas <carenas@gmail.com> wrote:
> On Fri, Aug 6, 2021 at 5:00 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > Why not just s/Apple LLVM/Apple clang/?
>
> because that would break it for older versions of Xcode that reported
> themselves as "Apple LLVM" and I am not even sure when the change was
> made to even consider those versions as obsolete.
>
> Either way, I am sure once we figure out which versions are affected
> and which versions macOS developers care enough for, that would be the
> obvious next step.

My daily development machine still reports "Apple LLVM", so it would
indeed be premature to `s/Apple LLVM/Apple clang/`. Moreover, there's
simply no good reason to `s/Apple LLVM/Apple clang/` since it's not a
maintenance burden to leave "Apple LLVM" in the match pattern.
