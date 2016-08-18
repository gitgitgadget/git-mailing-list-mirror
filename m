Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6BA41F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754212AbcHSCXo (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:23:44 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37112 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbcHSCWs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 22:22:48 -0400
Received: by mail-it0-f41.google.com with SMTP id f6so14028871ith.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 19:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bgQIfOph7Xvhv/nRR8e9obRHTo2kXFplQnH4qnYoZgk=;
        b=IrDAXo0z06jqKxIN210ThcP55qEpmsrrr8mhnkjG0OLaY+rPZwoJDNqvqhc7n4gQOz
         LOi2/x22WH/bH8MFP0gFKJ+8OQTzGYgNvzdMyVLr0w9hkr/aCLN+ghyUFhlhsogqa6+R
         7bKBf6/bKMzUO2needljo4yb7aHl4JWshkCDgwKpj//8ce9dfaug0sllO5Lpp/ZxEUaq
         cOl6Rr3pxVrHO6MG/52CeV7K9Psyla71oCguLtIqppduerg02ZR8A7ujhCtwLYy1aaBd
         L8ZSsi1CDNwa3cSb/kbLNUOkG2YyzJXg6lblkz3z8SLiXt66rm07uvqaVJih9gKbFxzu
         bY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bgQIfOph7Xvhv/nRR8e9obRHTo2kXFplQnH4qnYoZgk=;
        b=dPdkP2XfS7YRAiTdqAYs0HgcSWygJFm50+xfr1EbCMhUa+E0X84YIhbpYGiPppCD6D
         sThbEYF0wa35TOi65quRCB7Di0eYuWBvLHM1Wwzur60CDalCo1lU6BfZllUaNJ3AvNwA
         /QhYHOazlKMDlnxHnpN29JxJJWxsGbdqbymoHw6uteAKvygDy7d1fDPRiyHtUQnLN79c
         j5ancgNq4q0C9Ydmb/t44j8T7O7Fa5Y7tJO7BR2VQ5i/egVJ2dlmFMG5L9cs6ZpWTPph
         icjQQAKjqEOmrHSVxE+gSsYovQtK5ihjMwDNmTjQSz05fruVSHLKJqU8Fcszrnnf7rmy
         XeYw==
X-Gm-Message-State: AEkoouuNulr93w7TTP5xv1s/rKjZQIEvRsbL/g9Kt2DNhEw3bpSEuBmNabcFf3/BxHge5dPxgmqXLSWoK0UB0L9c
X-Received: by 10.36.127.7 with SMTP id r7mr1779866itc.49.1471552799963; Thu,
 18 Aug 2016 13:39:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 18 Aug 2016 13:39:59 -0700 (PDT)
In-Reply-To: <CA+P7+xrNzc-+KBdu20QpEcCJ_udYUUk=qQyDi26YoOyCwrPXiQ@mail.gmail.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-7-jacob.e.keller@intel.com> <CAGZ79kaFfrVwe+JXVJBBZVPn=mTv7F1db8T1ZzXEaMtZKoupQA@mail.gmail.com>
 <CA+P7+xrNzc-+KBdu20QpEcCJ_udYUUk=qQyDi26YoOyCwrPXiQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Aug 2016 13:39:59 -0700
Message-ID: <CAGZ79kZp+fhB-APx+zSAyYYiLq0pinDZOS1s33a7OjckJOi5=A@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] submodule: refactor show_submodule_summary with
 helper function
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 1:24 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Aug 18, 2016 at 12:04 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>>> +       if (is_null_sha1(one))
>>> +               message = "(new submodule)";
>>> +       else if (is_null_sha1(two))
>>> +               message = "(submodule deleted)";
>>> +
>>> +       if (add_submodule_odb(path)) {
>>> +               if (!message)
>>> +                       message = "(submodule not initialized)";
>>
>> Before it was  "(not initialized)" for this case, I think we'd rather keep that?
>> Though this code path is only used by the porcelain commands, we'd rather not
>> want to change this in a subtle way in this commit.
>>
>> If we were to change those, we could discuss if we want to go with
>> full sentences
>> all the time:
>>
>>     submodule is new
>>     submodule is deleted
>>     submodule is not initialized
>>
>>
>
> I agree, I'll make a new patch that does this as a cleanup prior to
> this re-work.

I was actually not suggesting to change that. I rather wanted to point out
that if we'd want that we'd rather do it consistently and in a different patch.
Sorry for not being clear.

Thanks,
Stefan

>
> Thanks,
> Jake
