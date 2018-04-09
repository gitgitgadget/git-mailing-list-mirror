Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095A51F404
	for <e@80x24.org>; Mon,  9 Apr 2018 02:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756445AbeDICHZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 22:07:25 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54853 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755941AbeDICHW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 22:07:22 -0400
Received: by mail-wm0-f44.google.com with SMTP id r191so15032550wmg.4
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 19:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A2Uu+aD9ksLLM3DTExYMQTIgPJpcw98Jd7cJ/+3Ifck=;
        b=NFTQNnt/dbDi0cN37YS2PB9qLROa3P5o5FS0fK1BuPEDsqR1GjZXaxo16s47uWu++r
         pHee52a5TVYDz8lo82oANJ5vAKPmFDEY1ny2qpurGi62M3ysXS0+NVZ8jV6KyN8K/Bpx
         Xy36Eweq6BTp512X+OI+UJxt5Q1LC9Ga26jFvPY3LmeakwALj2W65MxnpQTNHDa1dz2r
         oii2kHwmB31voaybz/8hR0tEogCz8FF5zzSD0lftsSPOHZ3IyV+9SfRs5EDpnnuSxbkz
         n2i+97YxZXnIK4XHm+av8gZzpcvoZDpzVuFKEa6yGM9SMqzO4PTocn3PU754XQsgSBb/
         +27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A2Uu+aD9ksLLM3DTExYMQTIgPJpcw98Jd7cJ/+3Ifck=;
        b=hIZmx+PLeE9ODb//9BeKZlJKXCxpLFnmtEPtz/T2ea405g4x3pOnKiUBV71ewdJDFz
         ZXsYa/s4Vvkx3grLbvJgzEqU+lez/eAd8k4KIsq1+XlAZ+EG5ADnnDGwi8xv3x4o2XLU
         Rwzgxqsnce/GQ+jQPG0Ersgk8eYXsfcGpWyoXEITJ/u9JRwm1t66XZSo02u8zmfLmzk/
         RTFnn33d1iOvbVilkxEqX+K09R2d+AEQIqg6Ev4w8XOX49LGp9SOofv+P9aV4qeBA+6C
         OMAtqvoBBBnUgyVJXFEGn8RUqi262cY+pup3SJtX2a2XPJDvr2R0VKBKNVyHrdKizYgl
         v5gA==
X-Gm-Message-State: ALQs6tB25hnq9nf04F8Lyn+mocvFeeLuW/K4R0p6j+kpxu+4WbeCGjJM
        lL6AiGnTKBm/vpETySBfhAQ=
X-Google-Smtp-Source: AIpwx4/cBHH44KJS3FCJOTTRfFOuZ2QAnuwWYMkCpFLmszUyAoCMD1rOoRYnXTa0FkOwx8xBAcHXdw==
X-Received: by 10.28.24.204 with SMTP id 195mr20608147wmy.2.1523239640837;
        Sun, 08 Apr 2018 19:07:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k11sm20291588wmi.35.2018.04.08.19.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 19:07:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [RFC PATCH 4/7] dir: Directories should be checked for matching pathspecs too
References: <20180405173446.32372-1-newren@gmail.com>
        <20180405173446.32372-5-newren@gmail.com>
        <20180405185805.GA21164@sigill.intra.peff.net>
        <CABPp-BEnFiEnao0NqU3GerYkpxO9fJadQLHo6_PZ-hXLZfbbdg@mail.gmail.com>
        <20180405193124.GA24643@sigill.intra.peff.net>
Date:   Mon, 09 Apr 2018 11:07:19 +0900
In-Reply-To: <20180405193124.GA24643@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 5 Apr 2018 15:31:24 -0400")
Message-ID: <xmqqefjp6sko.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> To be honest, I don't know. Most of dir.c predates me, and I've tried to
> avoid looking at it too hard. But I had a vague recollection of it being
> "best effort", and this bit from cf424f5fd89b reinforces that:
>
>   However, read_directory does not actually check against our pathspec.
>   It uses a simplified version that may turn up false positives. As a
>   result, we need to check that any hits match our pathspec.

At least the original design of the traversal was "try making use of
pathspec during the traversal when we can cheaply filter out obvious
non-hits and avoid recursing into an entire hierarchy---false negative
is an absolute no-no, but forcing the consumer to post filter is OK".

> ... But I think that anybody who looks at the output of
> fill_directory() does need to be aware that they may get more entries
> than they expected, and has to apply the pathspecs themselves.

That matches with my understanding of how "fill" thing worked from
early days.
