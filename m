Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A08720281
	for <e@80x24.org>; Wed, 20 Sep 2017 07:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdITHfK (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 03:35:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32890 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbdITHfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 03:35:09 -0400
Received: by mail-io0-f194.google.com with SMTP id j26so691170iod.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ez7vP9temmL0vls/br1h5itC6etTmksPEsIWilYA8Kw=;
        b=dAsxb3iv2eoGt/Lusp+C3E4w2LBCo1ebIt4lFJA7hUsJwsO98wCYOt/l38U/jwk8u2
         25Hu8ZzYBLFMa8prqOJOuzvphYBKAeVVMeQDniPI9WOl4f751eWnR9xhVnsOcuJ8nHcY
         W8fliM5ZsQU1dvw8a+Xff5OLk0u/lRUTyll+w+uqSIORAc+Don7aS18DvvkjtN5AFhIP
         PP8kdY+2xFjuUHCIzabtqhn4LozyhjOi/ANiFTcv0qzwz7JejVIE/jPWfOqMU1KJYMvD
         Lqd5WcFApsGgc4SmBj3Yp2FQG/ysaA/Jy0u9W/gf7/OKxJOKaltEEvWdaLU9U2eELVcu
         u+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ez7vP9temmL0vls/br1h5itC6etTmksPEsIWilYA8Kw=;
        b=aLXwz8uZc09KlB/1W50dnwvXZPDy1+QJQGlTUtX9vft1utydHvrmv4J3Dvm7c8fuk2
         F4B11UoaAxedoeP9ruWtoB3thGT6slsp9wxYI15N297pq7vGOztfGVwFgcBe+H3tsjuR
         7iklCrmaiPmYOJ07NwRYgZ2HrLFD4tneNcI/H3FbSge+jjXSdF1Cn6o/BZyk4mq0GsGA
         gCnwnHSlFMd87dIg5IPr12Tr95GG6mnlBxzrpxGqsta4rheFWkWP4sOv+ufovUN1FyVe
         2D0k5t3XXJGq3mASm5CI2TLbzZViBWnDK2QhRzmE4J271tjljMIcZC7i2Mt1ofU28/GB
         xdjA==
X-Gm-Message-State: AHPjjUhq935ISenNH8dgcc2nHRRtRVglof88TN1KV5VGJlkFC/MHGXkS
        PcB/10myx5nu10X2GnZ+bc71ri/4
X-Google-Smtp-Source: AOwi7QDh4nRza2JkXZ2PYgR2jO/m5tb4cqCUh0lwX4XUXsBXFV8zC4EJEszn8hxleA+XL1rCI36svw==
X-Received: by 10.107.69.7 with SMTP id s7mr1592654ioa.268.1505892908762;
        Wed, 20 Sep 2017 00:35:08 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id r9sm1939157itc.13.2017.09.20.00.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 00:35:08 -0700 (PDT)
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty
 list
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <20170915184323.GU27425@aiede.mtv.corp.google.com>
 <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
 <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
 <20170920023008.GB126984@aiede.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <3467b198-8c8c-2bfa-b139-d3ed5ab6b8bc@gmail.com>
Date:   Wed, 20 Sep 2017 13:05:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170920023008.GB126984@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Though this thread seems to have reached a conclusion, I just wanted to
know what I was missing about the optimisation.

On Wednesday 20 September 2017 08:00 AM, Jonathan Nieder wrote:
> From that link:
>      for ( ;valid_int && *valid_int < 10; (*valid_int)++) {
>          printf("Valid instance");
>      }
>
> Both gcc and clang are able to optimize out the 'valid_int &&' because
> it is dereferenced on the RHS of the &&.
>
> For comparison, 'item < (list)->items + (list)->nr' does not
> dereference (list)->items.  So that optimization doesn't apply here.
>
> A smart compiler could be able to take advantage of there being no
> object pointed to by a null pointer, which means
>
> 	item < (list)->items + (list)->nr
>
> is always false when (list)->items is NULL, which in turn makes a
> '(list)->items &&' test redundant.  But a quick test with gcc 4.8.4
> -O2 finds that at least this compiler does not contain such an
> optimization.  The overhead Michael Haggerty mentioned is real.
>

I thought the compiler optimized that check out of the loop because the
check was "invariant" across loop runs. IOW, the values used in the check
didn't change across loop runs so the compiler thought it's better to do
the check once outside the loop rather than doing it each time inside
the loop. I guess this is some kind of "loop unswitching"[1]. I don't 
see how
dereferencing influences the optimization here.

Just to be sure, I tried once more to see whether the compiler optimizes 
this
or not. This time with a more similar example and even using the macro 
of concern.
Surprisingly, the compiler did optimize the check out of the loop. This 
time both
'gcc' and 'clang' with an -O1 !

https://godbolt.org/g/Y6rHc1
https://godbolt.org/g/EMrftw

So, is the overhead still real or am I missing something?

[1] : https://en.wikipedia.org/wiki/Loop_unswitching

---
Kaartic
