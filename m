Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F749C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 18:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDMShu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMShs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 14:37:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEF76B4
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 11:37:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h206-20020a2521d7000000b00b8f3681db1eso6917812ybh.11
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681411067; x=1684003067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTzpNUuK1RLDYvWsFGAyO9zj4C0HbwNvl7Avih4U3/0=;
        b=dAleE7RGg9yivPKZkh0ItEMW22kSeSoEFnO+ftm/6F1JO5cZ6bKmJozS1wFkDdv/aD
         QPnOa8NZe6whBMX0wjz7M/Yzz6nlPSPZntPS3YclQrDDSV7nTIQMKWuvkEMAEGS8wSXD
         o82hbJQ25mxOR9Sokri8qRh2hH6dg7rkOK96qGcHQabFAgkpWMBJZguN8FY6Kyle4EHf
         wL/H2oYDuoYw6niFFzzIX3UlX0Kic5raieF9BG/BzQuP0SsVG9AJyqtqEWKZW+hQcn3P
         da1WHTdq3edrgnh2AQ7tV5B158v+ePTHpYlAjcgHTrSTKMBT0QW44lb1Wov9vJjBjooG
         MKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681411067; x=1684003067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTzpNUuK1RLDYvWsFGAyO9zj4C0HbwNvl7Avih4U3/0=;
        b=gnOkF5JMRwTopXFP+QmgN4Bd3J/n4f9ouKYCUFfYOeDIdspQgpnbZO2mAZlNgpbGfS
         56M+DgApbvziNglLXQVgbv9WQS2zn2waRGNUn9+gcbH7DobI997QGkmggBtY5Rc3C8m5
         AGrYmrSWaDXv3xoOKaSD6Om/P0IfCjgntrvtcKUlMjYRPJTioOaLh9L3b0E/HZDt/avy
         frLJTrcoa067gWOcd0iik4JhCn3E3uHq5jfmnP0+lIG3BEAvCQT7iBVer1COOdHMqh2u
         L/yXhXj/xIkvUGZIAzyNF7Mt4fI6thTQevHDQUlrnYxRjttGlfkf+o5XToBIyPpGDPT2
         Amqw==
X-Gm-Message-State: AAQBX9cr1UOcCtdRg55MJU1f38ESnccbAq9We1rwL9R8Eba/TW/5jbnt
        VMSbpKh495fusPXDnGAWvu3AprEglyx5jA==
X-Google-Smtp-Source: AKy350a3fa0V+XKASz6BEjfGwi7crEUDnG9cGwgIjt3SXSmxAzxwh0LRCsRFONV0NN3r5xTxyVFqmtmEclEtcA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:d744:0:b0:b8f:53e1:64b with SMTP id
 o65-20020a25d744000000b00b8f53e1064bmr1668973ybg.13.1681411067224; Thu, 13
 Apr 2023 11:37:47 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:37:38 -0700
In-Reply-To: <xmqq8rew7q9s.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
 <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1681329955.git.gitgitgadget@gmail.com>
 <xmqq8rew7q9s.fsf@gitster.g>
Message-ID: <kl6lleivk4r1.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 1/2] cocci: add headings to and reword README
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason" 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> From: Glen Choo <chooglen@google.com>
>>
>> - Drop "examples" since we actually use the patches.
>> - Drop sentences that could be headings instead
>>
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>>  contrib/coccinelle/README | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> Makes sense.  Will queue.  Thanks.

I believe this was directed at just the cleanups in this patch and not
the recommendations in the later patch?

I was confused for a moment when I first saw this, and someone else
mentioned off-list that they also thought you meant you'd queue both
patches.
