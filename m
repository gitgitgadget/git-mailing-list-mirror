Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12485C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 10:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE1F61492
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 10:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFZKam (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 06:30:42 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]:42594 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFZKal (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 06:30:41 -0400
Received: by mail-qv1-f49.google.com with SMTP id m15so6571817qvc.9
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 03:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8WlYGcXwfFPj+Vq4UtrpBh6j/gEdxJcEuQePKSXx3Q=;
        b=aSaD263ZmW2xJtH19rmrw39n81BF7zSM0LFYNZeyaZQY4m9nBqOcxc+7Vm+hzJbcT+
         +1sOEeHCcjAUgagpQ+zjDr0WkuSPKZScUYG9+zqaofmfk4QACClBk5P24Er+zoUTI11J
         nai8++45Z8OMWmd5ygxkCgpmqxNPOTAc2rvD2PVh7HSGExUR9rN4PagNlxh7L3MgEy/p
         gH75/M11ZvwtfFZt+jMsca9jl8LLqPdtjt7fQfKqZjmOhssdO02x68r4PPX+CeHRHVEf
         oiit2M9Flxx2Ws0TAqQxKiyQjb1xtPU25F1FpTb7CkBRLNr+k1cnwqk5TAsiuaMRW1jn
         9k2g==
X-Gm-Message-State: AOAM531Fh0O6l8jpI1f8GvmhrX2OpcPuvwUXQf05E0GShGtOomX/Yr8w
        5eKAhf6kGo4RsdYbwfebSjC6zoZ9i7Dy68Ds
X-Google-Smtp-Source: ABdhPJx8k8TZUvRNQxTG8bt/fDJIOcs5Q0bMoqp4DBgYRRSHVwHwy4mIR11rUBheCvYuYTICS6QOfA==
X-Received: by 2002:a0c:a999:: with SMTP id a25mr15436476qvb.26.1624703297491;
        Sat, 26 Jun 2021 03:28:17 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id u184sm2618206qkd.53.2021.06.26.03.28.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jun 2021 03:28:17 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id bj15so21885701qkb.11
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 03:28:16 -0700 (PDT)
X-Received: by 2002:a37:8581:: with SMTP id h123mr15781733qkd.316.1624703296822;
 Sat, 26 Jun 2021 03:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
 <60d294eb984ba_3122081@natae.notmuch> <CAJ-0Oswry0Rry_0ZqZzzVGuzfU-apZnv95LcxQEhm7GVA=uOxA@mail.gmail.com>
 <60d6158fcef74_cc8d20834@natae.notmuch>
In-Reply-To: <60d6158fcef74_cc8d20834@natae.notmuch>
From:   Avishay Matayev <me@avishay.dev>
Date:   Sat, 26 Jun 2021 13:28:05 +0300
X-Gmail-Original-Message-ID: <CAJ-0OszRbZYe6RbgKmEG=38FzrcfOezpYKtYRSLT0bokaLRZPA@mail.gmail.com>
Message-ID: <CAJ-0OszRbZYe6RbgKmEG=38FzrcfOezpYKtYRSLT0bokaLRZPA@mail.gmail.com>
Subject: Re: Forcing git to use a pager without a tty
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 25 Jun 2021 at 20:42, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Either way feel free to provide a patch with whatever approach you think
> is best.
>
> However, for a proper patch you need to add documentation too (see
> Documentation/git-var.txt), and preferably some tests.
>
> Cheers.
>
> --
> Felipe Contreras
I will do so, thank you.

Avishay
