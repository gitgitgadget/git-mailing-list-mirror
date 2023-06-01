Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF608C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 13:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjFANXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjFANX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 09:23:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11643125
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 06:23:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso8798485e9.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685625800; x=1688217800;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FKhtJ66tFyn/8XqonqaMoQR/baEFCeV/SNz36RguJ+E=;
        b=ZjaZhV+Wh1hAjqEyANTbm+mkStkr0Jh+ZmhO+TRB3lNl19JC9hIZbcFHIcKtZxRT/c
         E4jvs5ajtyICKohCKmSzf2olai52rpexKYYvTZgjpG6u8T4vuylAvULRn8I5zPDi5w8g
         /fteFx+J0GMmfXGDL4eoYcYeyuKbjxOmu4DClrDFynuEpvN4tTRN95o11cSZoFuP8oal
         x047+zWQj8jZ8qBgzZI+8/SvVGnIEMEXy+sZXzr3SE2qworxCq70mnf1Ep/PWC+8uGYL
         UgsZmMLX4qwzK5qeWHPZGDAYhFmVopo2wvx3pdp9YC5GZJ2lcKWiuTnnFS74hgKhVKGp
         c0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685625800; x=1688217800;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKhtJ66tFyn/8XqonqaMoQR/baEFCeV/SNz36RguJ+E=;
        b=g4AEP4vVvN/40jq0vTB91uw0Ik+mLO55jYbmi9PcliDeTqwG2hAaTLqmUpR/79iqzS
         YF5SqOaxmkpavBVGvpWffIc17IR7b1js24+PpYI1YikfoKiu1eNFXVsX6kx5UbphG8Dl
         2kpT3pXNIio7uSeegfnNp/w9wb9RdE5Tmu403N33kk/8EKp162pO/G2/N+xj9pon+L8q
         qqDsyqDsWocVQeOOiq7Y3sBuXzUgN+15C4lHvFmen6PzMG7VfGCjlibDOLJEWce8ZMhP
         L3FIZv4ZGOI6c89b43BKDxCGKC3ht2kwy776MIW+ZOjPuKsQmtebMZS5fDr6Y8oIeOt6
         y+zA==
X-Gm-Message-State: AC+VfDzj4LGxOXttPHUipH7s8cfqZeiBX2xter5Ddz3hO1D6unq4CyQe
        eDXuzmcToD3fg9stf/UZ2oM=
X-Google-Smtp-Source: ACHHUZ6f5aYSzPXDSqRlLXW5aV9VNjAtNH/AK3l0/xIkJuQTqZ4nfx46IWMyjYkeMXMOGSYjUVVwsQ==
X-Received: by 2002:a7b:cc95:0:b0:3f4:20bd:ba46 with SMTP id p21-20020a7bcc95000000b003f420bdba46mr1886229wma.5.1685625800245;
        Thu, 01 Jun 2023 06:23:20 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id o11-20020adfeacb000000b0030ae7bd1737sm10449029wrn.45.2023.06.01.06.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:23:19 -0700 (PDT)
Message-ID: <30c735ea-cd8d-d82f-a5dc-da2bd591f76e@gmail.com>
Date:   Thu, 1 Jun 2023 14:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/1] Unit tests for khash.h
Content-Language: en-US
To:     Siddharth Singh <siddhartth@google.com>, git@vger.kernel.org
References: <20230531155142.3359886-1-siddhartth@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20230531155142.3359886-1-siddhartth@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Siddharth

On 31/05/2023 16:51, Siddharth Singh wrote:
> This RFC patch adds unit tests for khash.h. It uses the C TAP harness to illustrate the test cases [1]. This is not intended to be a complete implementation. The purpose of this patch to get your thoughts on the unit test content, not the test framework itself.

It is a bit hard to comment on the test content when you say they are 
incomplete so we don't know what you're planning on adding in the 
future. I agree with Taylor and Junio that khash is probably not the 
best place to start adding tests (I've not checked how far away from 
upstream our code has drifted over time) but from a quick glance I found 
these tests rather tame. I'd like to see tests that are trying to break 
things, for example adding keys with hash collisions and checking that 
they can still be retrieved, updated  after some have been deleted. You 
could use a hash function that returns the first character of a string 
and add words starting with the same letter to generate collisions.

It is also hard to separate the tests from the framework as a good test 
framework will make it easy to write tests that have good diagnostic 
messages when they fail that pin-point the line where the failure 
occurred and the values used in the comparison that failed. A good 
framework will also minimize the amount of " if (...) return 0" boiler 
plate required when a comparison fails. The tests here do not benefit 
from such a framework.

I think this patch also raises the question of what should be tested by 
our test-tool helper and what should be tested in unit tests. Ævar 
raised the idea of improving our test-helper tests rather than adding 
unit tests [1]. It would be good to get a response to that point of view.

Finally I would recommend that you chat to your colleagues about the 
expectations around including an explanation of the reasons for a change 
in the commit message and code style for patches posted on this list.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/230502.861qjyj0cb.gmgdl@evledraar.gmail.com

> The tests cover a wide range of functionality, including the creation and destruction of hash tables, the insertion and deletion of elements and the querying of hash tables. I would appreciate feedback from reviewers on what other tests would be useful for khash.h and if these tests provide enough value.
> 
> [1] https://lore.kernel.org/git/20230427175007.902278-1-calvinwan@google.com/T/#me379c06257ebe2847d71b604c031328c7edc3843
> 
> 
> Siddharth Singh (1):
>    khash_test.c: add unit tests
> 
>   Makefile       |   1 +
>   t/khash_test.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 174 insertions(+)
>   create mode 100644 t/khash_test.c
> 

