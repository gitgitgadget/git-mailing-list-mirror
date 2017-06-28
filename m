Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322A32023D
	for <e@80x24.org>; Wed, 28 Jun 2017 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdF1VS1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:18:27 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33328 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdF1VSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:18:25 -0400
Received: by mail-pg0-f41.google.com with SMTP id f127so37509930pgc.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EN8K809/tdll+J2KM95IJG6MU4hwzbA1MLY0Tx3psDA=;
        b=blGqxpnXLgtLgnr+b7KTI9PdZWLrswtS1HqZ666D8/1Zs7YzsPXDd+CCZiPYl8RxV1
         27T1TZbdd4MHKo9LJcDFcT2MmYjcrn6OsEJiYLPEyQLaFSYN71nALo/n7eelwHybTSTR
         9OU241BEOD2u0Bnxe/MO6KFz/9IeW/K3x8L4r9kLNM++Y2kRBuCeOLb96evT2SlsJxmj
         ym+yM8sXFPfPMQc0mJsoHDMqGJC8RmBEXzHJq/7sUvu+U6eTMuYBkA5tcqegXY/jWSGx
         teSjvBiHR7F1+ReYwfV70yIglseQh8hGEH+ckFmxpONhwVlI/ZIou/gRosYRmkkO1YYk
         kPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EN8K809/tdll+J2KM95IJG6MU4hwzbA1MLY0Tx3psDA=;
        b=gSzHMCz6Q8RSmS3pZ3KHzuvRKzCUtRN/uKEyHPqAXko+gWoRUU6/uWiMxaquaS+tdt
         d5dTwLoubPYs/UQhtgzqokqvWmKXgNiuWzqbomOR9EoQ+dOkG1zYYEYDXRQknuZz7rOh
         iwNS1wbeLndwC1FF8YBQaXfJiAUdnF/kFPuAIxH9IWq8E4oGn+X3FbMw13AAg0om2WnN
         LNOyKejgKOLD++I0iAelHzoCbz89TBBkAqyPuY2eLG0dcUGymC/tb1ASjBeZ8zjtpgqE
         jsidEUrSiS4WLEyQ/U47J7lu6TxDDnRLiozK93oJy//34PuZuPxsVcHaOoQS2WIGc4oX
         32bQ==
X-Gm-Message-State: AKS2vOxvwdBWDZl1bgcI9PQ6OAjIigNmgJnAKdOBf/DR9NlPCRA4Pf6D
        jmK8OIPPM6RIrJjLfnIJlZ0+yu5T6EFYWPpNng==
X-Received: by 10.99.55.83 with SMTP id g19mr12061411pgn.243.1498684704900;
 Wed, 28 Jun 2017 14:18:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 28 Jun 2017 14:18:24 -0700 (PDT)
In-Reply-To: <xmqqwp7vvngg.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sq3x2xz.fsf@gitster.mtv.corp.google.com> <CAGZ79kbvncDoSuj8AF_rdDoEzavdzEaLxqr7NXi1_eCLNt01Kg@mail.gmail.com>
 <xmqqwp7vvngg.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Jun 2017 14:18:24 -0700
Message-ID: <CAGZ79kY++zFEGDZhPMQebbGBw7UXjUf6f+bOzZ58_5NLQpCcjg@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: do not call utf8_fprintf() unnecessarily
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 28, 2017 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, Jun 28, 2017 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> The helper function utf8_fprintf(fp, ...) has exactly the same
>>> effect to the output stream fp as fprintf(fp, ...) does, and the
>>> only difference is that its return value counts in display columns
>>> consumed (assuming that the payload is encoded in UTF-8), as opposed
>>> to number of bytes.
>>>
>>> There is no reason to call it unless the caller cares about its
>>> return value.
>>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>>
>>>  * The helper was introduced at c0821965 ("Add utf8_fprintf helper
>>>    that returns correct number of columns", 2013-02-09), which also
>>>    taught the help text output from the parse_options API to use it
>>>    to align columns.  These original callers naturally do use the
>>>    returned value and left alone by this fix, which corrects all the
>>>    later callers that misuses it.
>>>
>>
>> The patch looks correct.

I said this because I had a similar implementation a couple weeks back
when Peff tried to poke (security) holes into submodule usage.

I tried finding the reason why it was originally introduced, but to no avail.
It seems to be randomly introduced.

> Thanks.  I had a small voice back in my head telling me that I may
> have misread the code and this patch breaks things, which you
> cleared up for me ;-)

That said, #include "utf8.h" could also go from the file with this
or after this patch, I believe.
