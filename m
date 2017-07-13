Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136A72027C
	for <e@80x24.org>; Thu, 13 Jul 2017 22:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdGMWBV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 18:01:21 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36137 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGMWBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 18:01:20 -0400
Received: by mail-pg0-f41.google.com with SMTP id u62so35744823pgb.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=12DKZCkhepTPwODUsbVmx1i45GJJkdLyoCuyad8iXaY=;
        b=mcbh0n+KHG249ClQjyZLL2cP+UDe1NLRouoNgIa7NR+3POnECDhfFZ4kPQb/rXJ44b
         /ScTYU8COQbjYbnxxtPsRZaVLkVKRG06XwQYNzXh5DFclJRFzMjvmML5HCGzYIkjTxpG
         F8aGhnOvTNhuRU6WkbCRtLalzZj1evTRkJ1XDAkGl8+u1X3Kl4DnGZ2lO81YC5gwDa4u
         JOl2sE6oK8xZIc5arezL5M1oq5PzeP5H/dBfoNTH1mTp5sVJc3abs61z+oSYWQDT+9ma
         sMjmou67zvxNxgQBdxKP+Oq3zCFMvuHPcTZJkKak+AwR7J49bugrOi6Pz7VEIhVQvG7I
         K+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=12DKZCkhepTPwODUsbVmx1i45GJJkdLyoCuyad8iXaY=;
        b=aSU2JSehE2xuMOmGp3ReXt5amvHGW9iB5bcyq72CVXf2nCy6Jhy30IiUFJeDGppxGP
         bBdx/5Fq7g2AxEHoSLlgL8mbh5DnS+9yPBrf0PlUW+n1yCtDnDh3iZWbAu2E2+qSFJYx
         m61wuTU/1J9phy4HqSELv7g0N8rM63LV4DqhO16AYK/2Ty7dIoMysP28lZkjidniWPEq
         n1B7VO4or0T/ayM99pbYH2kmF3+lW/K96N+rlS81ruBHqHecFRVVb3CU5IAvZ8fGDjjz
         RNewRJzyXTNm2E/8HBe74zgFZb4S97y5WrumfCh9G8E55vdNXpjlF0qcySIymafV9Wsx
         IPxg==
X-Gm-Message-State: AIVw113U3iPJPZb7SJhLoydznLzrXTYGP+WVa92PaFfisyycmUuseduu
        Zq/923z6srBjgjfYSIDKmJSjqg9tQX+G
X-Received: by 10.84.215.197 with SMTP id g5mr12352944plj.297.1499983279949;
 Thu, 13 Jul 2017 15:01:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 15:01:19 -0700 (PDT)
In-Reply-To: <xmqqmv88t444.fsf@gitster.mtv.corp.google.com>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
 <20170713150118.eof3xgu4zujmo6u6@sigill.intra.peff.net> <CAGZ79kag1B37FBrmDzbRFNVODHp=n1h=xSq_pi1b7Fs4wLoRBg@mail.gmail.com>
 <xmqqlgnsulco.fsf@gitster.mtv.corp.google.com> <xmqqmv88t444.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 15:01:19 -0700
Message-ID: <CAGZ79kaOfcvVGUewVZMyZ7zVUcVESyzsdOBnAvG6FebuZ5HFQw@mail.gmail.com>
Subject: Re: [PATCH 05/15] ref-filter: abstract ref format into its own struct
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Thu, Jul 13, 2017 at 8:01 AM, Jeff King <peff@peff.net> wrote:
>>>
>>>>  builtin/branch.c       | 14 +++++++-------
>>>>  builtin/for-each-ref.c | 22 ++++++++++++----------
>>>>  builtin/tag.c          | 30 ++++++++++++++++--------------
>>>>  builtin/verify-tag.c   | 12 ++++++------
>>>>  ref-filter.c           | 22 ++++++++++++----------
>>>>  ref-filter.h           | 22 +++++++++++++++++-----
>>>>  6 files changed, 70 insertions(+), 52 deletions(-)
>>>
>>> The patch looks good to me. So some off-topic comments:
>>> I reviewed this patch from bottom up, i.e. I started looking at
>>> ref-filter.h, then  ref-filter.c and then the rest. If only you had formatted
>>> the patches with an orderfile. ;)
>>
>> As a reviewer, for this particular patchq, I actually appreciated
>> that ref-filter.[ch] came at the end.  That forced me to think.
>> ...
>> I do want to present from Doc to header to code when I am showing my
>> patch to others, so this is probably a good example that illustrates
>> that the preferred presentation order is not just personal
>> preference, but is different on occasion even for the same person.
>
> So when somebody wants to do a "from design and explanation to
> provider to consumer", we would probably want "doc, *.h, *.c at the
> top-level and then things inside builtin/ subdirectory" order.  Of
> course, on the other hand, "I do not trust me not getting swayed by
> the fact that a developer more competent than me wrote the patch"
> reviewer would want to use the reverse order.

I do not understand what you say here? Are you saying:
"I can be tricked easier when the order is top-down,
specifically when the more competent developer tries to?"

> Can we actually express "top-level first and then builtin/*" order
> with the diff.orderfile mechanism?

By reading the code, I think we snap to the first match. And matching
is done via the wildmatch.{c,h}, that claims it has special-case '/' matching,
and '**' **  work differently than '*',

> without which it would be cumbersome to make ref-filter.c listed
> before builtin/branch.c in a generic way.

Indeed.
