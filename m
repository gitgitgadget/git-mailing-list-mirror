Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCAD20282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754872AbdFWTqu (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:46:50 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34125 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754781AbdFWTqt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:46:49 -0400
Received: by mail-pf0-f178.google.com with SMTP id s66so27710667pfs.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/nrrGlZVRPpHJDynSU54SsOSoeF/5KeencXyDg4lZvY=;
        b=W3V5NGvBk6mR/tAQoMe9pJCOaC4CSW6L6LTzBWjn4BEpH9T/g6YaYvE7Mx5khBQGeT
         dx41PzgX7DXK4pwnaU/kdHUyM3YPSCG0gY05kScDLiHzCzvq8n6Ff9m4ANPOFu5HjWcH
         EXdDF2VkBH+PB9ppKHhs+HkxXcUtamg4sM51ptZhvSA61KlV3zMcZXIkG/o/wwzVexiX
         G1F2EdjWLM5GY+fIQUkWUtBNrdTtkSAK/BQxIO0OPD+CYcjuIIKANQmhTFEsezdtWUBu
         fLrLECDsmAf/N05a4/xut5NC8aPp9kSN977vkqEsaYD9s7wqAASCeOl3Zcss6mN1LbPg
         2GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/nrrGlZVRPpHJDynSU54SsOSoeF/5KeencXyDg4lZvY=;
        b=sg8+rT04v2QzhR56lHL9WtWILkyNVYPK627bZjS61oY4ClV5Bt+syBFwAK+i5a20Pa
         wcSDgYP/KDjR3J37gWKReBPammHnYM261rO4emWRCWw96rLLoMq7GCMpXeIHPyPF1fgG
         7zWLtJK5M8QlS6bdNDxZn0ngVg9wifpuWH/aUhB9jv5vQUH7Ddbk/6DfPjTVOSXdnOUn
         0pt7n0qLvhrMXjiRoANJng18RvmBrPKS+jO/wiC07jPd5SL12QhhrjSwKKu355969b8n
         Kf+VtBpRaNsj71ojtwz0sLBe3zKvzngYCqa4nL+3+YVeYNGRr4uvj3hVAr2F92/K2f6Z
         lGiQ==
X-Gm-Message-State: AKS2vOzdcMcdWFFFrd7upU6gIQ/vsz54RoAuhMiGEXkjhJeanxH/2RnD
        gMOcIvPtJSxoRLjNQnSD0sk5GL770MJf
X-Received: by 10.98.49.2 with SMTP id x2mr9800145pfx.48.1498247208345; Fri,
 23 Jun 2017 12:46:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Fri, 23 Jun 2017 12:46:47 -0700 (PDT)
In-Reply-To: <20170623193508.xjcyqvf32l7wmwzx@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu> <0a7aba93b5f3378df5aa8a3ef342d36cac9d4c6e.1498200513.git.mhagger@alum.mit.edu>
 <20170623193508.xjcyqvf32l7wmwzx@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Jun 2017 12:46:47 -0700
Message-ID: <CAGZ79kZYJN3x1kD_yQ0MyoDnkqxM64HDs2oW5ia2nuN-OFSJQw@mail.gmail.com>
Subject: Re: [PATCH v2 19/29] packed-backend: new module for handling packed references
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 12:35 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 23, 2017 at 09:01:37AM +0200, Michael Haggerty wrote:
>
>> Now that the interface between `files_ref_store` and
>> `packed_ref_store` is relatively narrow, move the latter into a new
>> module, "refs/packed-backend.h" and "refs/packed-backend.c". It still
>> doesn't quite implement the `ref_store` interface, but it will soon.
>>
>> This commit moves code around and adjusts its visibility, but doesn't
>> change anything.
>
> Looks good. Stefan will be happy to know that I used --color-moved to
> look at it. ;)

Hah!

As a follow up on that, let's perform a user survey :-P
* How was your review experience?
* Were you annoyed by the default colors or mode?
  (That is best expressed as a patch, as it seems like
   bikeshedding to me, but I am far from being a UX expert ;)

Just today I thought about that further:
While reviewing is one thing (which I do a lot), how can we make this
work with merging changes?

I think the file rename detection is acknowledged by the merge code,
such that a plain file rename and a patch to said file is easy on the
maintainer, but we would want that for smaller code movements, too.

Let's take this patch as an example, if someone were to find a bug
in one of the moved functions, they would send a fix based on the
function in refs/files-backend.c, such that it can easily be merged down
to maint, but when merging it forward with this, it may clash.
