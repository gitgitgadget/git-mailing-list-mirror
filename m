Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1271FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbcFPUii (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 16:38:38 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37397 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbcFPUih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 16:38:37 -0400
Received: by mail-wm0-f45.google.com with SMTP id a66so74100591wme.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 13:38:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=89XU/rNs70mIH6hE07GcOL6Y38dWIh82ANYfwVDmviY=;
        b=POIXfmm4sn7NOYX3eZHEGF+CBewIeTBBAcWEqETyWPiYu8uL1NOByGvrnklj5ByB8Y
         qAckVRi6K4OJyoP2Qc2tztqDvLYiHKOlX6eS/OPI7NIoMcBrttChuy1xKjGJXZe9mduu
         rRQNibVjV1QPgNNPbYLX9AqU8U0VNhUZckCYNdU1wtaqQPAGJqOaE49h3GJmPSJmcJOp
         Vc8HZPFqZjBG/t61Bhj5brK3PD+CJbsIhHEeQYa05cQOU8QVZ8TyiySU/LeT4qNlHIn/
         YdwnUChiI3aPm5Q7D7psH8KS7I9gIecCKzZKpaHZsOrEFiEIz2e/r7CN17mWZgq4aDr5
         HYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=89XU/rNs70mIH6hE07GcOL6Y38dWIh82ANYfwVDmviY=;
        b=ZLolR5H1pTu+kIsLkGwlezrrfZZv0jx5VbRKvjZIbQp4CwIwdhRTy49Rhr93YnR0/D
         PurR5QI2Kh0Iqci80/u+9PcLG3G7u3IHU/bNedP74VdqNG3gFHixHBkn7/4hutcEo++y
         KYGfZFIcWZD1M7GA0HC9YO88Klm7Et6QE4NvpeIqGyr0GOqdJNgqupSfd5DUpGcPhUQh
         3p4VMQKDEetGJaIWQQZ0yad0+dU2Wd5z2Z5WcwCxTNy1D8MfeIn3TCsmpK0gekUD6qjf
         pdbNZEHptgW74CmLdXxFH9ngdt8aGGXOQGFL0WDcVHA95+L7YH4SQfVDQuUfCpnaXk7o
         Yudw==
X-Gm-Message-State: ALyK8tKfCZ3APX8hiyQV2H7RM0vpYzoWMKIohzTTc59R9b9k1DValirqYiOTpiFhlC6cxfUw+NO/GwAy+BnusA==
X-Received: by 10.28.16.193 with SMTP id 184mr7011725wmq.62.1466109516044;
 Thu, 16 Jun 2016 13:38:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Thu, 16 Jun 2016 13:38:35 -0700 (PDT)
In-Reply-To: <CAFZEwPNpeD3+6kzY7HDH_ZXcL-Nu0B7jGeM5GMjH7PT0eSTLBw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-7-pranit.bauva@gmail.com>
 <CAPig+cQV3FTGJBvS0Kuc3CNPiwZMZtApT6r8+Ojhw3y7O2VTiw@mail.gmail.com> <CAFZEwPNpeD3+6kzY7HDH_ZXcL-Nu0B7jGeM5GMjH7PT0eSTLBw@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Thu, 16 Jun 2016 22:38:35 +0200
Message-ID: <CAP8UFD1Fi53am5O+RBS4XfHOEF1rdYiNSbWBvhaAUv_9fgJ3Zg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] bisect--helper: `bisect_write` shell function in C
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 9:01 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Hey Eric,
>
> On Fri, Jun 17, 2016 at 12:25 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>
>>> Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
>>> from the global shell script thus we need to pass it to the subcommand
>>> using the arguments. After the whole conversion, we can remove the extra
>>> arguments and make the method use the two variables from the global scope
>>> within the C code.
>>
>> You could do this now rather than waiting for later. Instead of
>> passing these arguments to bisect_write(), create global variables in
>> this patch and assign them in the BISECT_WRITE case of
>> cmd_bisect__helper() before calling bisect_write().
>>
>> Not necessarily worth a re-roll, but would save you the effort of
>> having to explain it here and then change it in some later patch.
>
> I have actually done it in my next conversion which is converting
> check_and_set_terms()[1] which also sets those variables to some value
> so its more appropriate there.

My opinion about this is that using global variables would go against
a possible future libification of the bisect functionality and might
be less safe than just adding 2 parameters to a small number of
functions.

If we think that 2 parameters are too much or that there could be more
parameters to pass like this, we could just pass a pointer to a
'struct bisect_state' or something like that ;-)
