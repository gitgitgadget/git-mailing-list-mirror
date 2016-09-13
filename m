Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C030520984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755916AbcIMXJo (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:09:44 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38742 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754521AbcIMXJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:09:43 -0400
Received: by mail-it0-f49.google.com with SMTP id n143so465779ita.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a5j+bpCMwUR9gRKzITxgEoCicFbIXF4RyzIb37Y4Rxs=;
        b=SpVNGWNe8xSUkXAs93sTwU5rgilR5eAkpG09aH/EnQO6rmubY9w35ZCnmexTRTo947
         BUxwgX8omTUw7p+pamKr9kfLvYIcPzlLM1Ng5zu4K+s5ukjGr0qdZiw6wF/G2XsnXh5/
         OuVpQ0FTbu4biVnfqVIHDU/vl6JcnciGsQ0y37vaDC7EAb55MjlGJCsgwvZKLYigkWKl
         kem/2ACHgHBjKEdd0vMIejpfdVCe0lqjp3TBeZ1VogSviQxnC06ouIyaC8wbfpJblGYe
         XFBLUSs/aPfRzzUB9qUZUxH0Y8eM9bd6A/agQkNG/YK/5Fpk9Ji1/W/yBk4IzZB3o8kr
         v8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a5j+bpCMwUR9gRKzITxgEoCicFbIXF4RyzIb37Y4Rxs=;
        b=ZmvWFjKJ9ELJzeRa+bdyIvdKr7fBvam+9oapQzeHmOUN5wJMQSopFhUUYN3rQX5qkX
         WB4i/tB+M+8ys5D9VaeQKcG8r6knOLsxb7cnj+kk+nMSvz2mQrpEKTpJBt05a4CsFA9K
         8P2OnD2dOCexHSAyJGg3koeLFzZANQJeNYLmk0jseSNMlyKjvhrFWovsDPj0XmK3y2TR
         IJIiMBY9jEAgph6RMjiI2AcZBl4Q0iNNVL27TkB5p0WxfbkpkLAEdrbutnDvp1Cz/1CE
         PzmFf3ov5iRfFiV3d4Y2bD0AA0t2D0wZad/fup8i1WrMDIUHZ689dGyQVh1S+uIUrcyc
         VYfA==
X-Gm-Message-State: AE9vXwO5f1BJuss477u/7rRGRputCF0qAmpEfYnmMbQr5GPm1Rc9H/+AUCjMfRjB3HQdIuGtSJdUQetJyO9viYUX
X-Received: by 10.107.30.68 with SMTP id e65mr5923207ioe.13.1473808182243;
 Tue, 13 Sep 2016 16:09:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 13 Sep 2016 16:09:41 -0700 (PDT)
In-Reply-To: <xmqqpoo7tnco.fsf@gitster.mtv.corp.google.com>
References: <20160913044613.1037-1-sbeller@google.com> <20160913044613.1037-11-sbeller@google.com>
 <xmqqpoo7tnco.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Sep 2016 16:09:41 -0700
Message-ID: <CAGZ79kbYNkvLC2A5oQ5FahrPQGe5syaF5_LXi-ddCRzC4HJH=Q@mail.gmail.com>
Subject: Re: [RFC/PATCH 10/17] submodule.c: convert show_submodule_summary to
 use emit_line_fmt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 4:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In a later patch, I want to propose an option to detect&color
>> moved lines in a diff, which cannot be done in a one-pass over
>> the diff. Instead we need to go over the whole diff twice,
>> because we cannot detect the first line of the two corresponding
>> lines (+ and -) that got moved.
>>
>> So to prepare the diff machinery for two pass algorithms
>> (i.e. buffer it all up and then operate on the result),
>> move all emissions to places, such that the only emitting
>> function is emit_line_0.
>>
>> This prepares the code for submodules to go through the
>> emit_line_0 function.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> I wonder how this interacts with the jk/diff-submodule-diff-inline
> topic by Jacob that has graduated recently to 'master'.  IIRC, it
> just lets a separate "git diff" instance that is spawned in the
> submodule directory emit its findings to the output of the driving
> "git diff" in the superproject.
>

The easiest way to find out is to merge HEAD^ of this patch series
(i.e. "diff: buffer output in emit_line_0") with whatever we suspect can
cause breakage for the goal of channeling everything though emit_line_*
functions. Looking at that series, I think I'll have to redo
this (maybe even including sb/diff-cleanup, to have it all in one series)
to capture all output there.

I suspected a breakage, but as the patch series grew larger and larger,
I first wanted to get into a working state before paying attention to solving
conflicts as resolving conflicts is easier when I know where this series is
headed.

Thanks!
Stefan
