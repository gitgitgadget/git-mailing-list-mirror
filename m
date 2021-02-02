Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC43C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0DC64F64
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhBBQk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:40:58 -0500
Received: from mout.web.de ([217.72.192.78]:57001 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236338AbhBBQiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 11:38:00 -0500
X-Greylist: delayed 87792 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 11:37:59 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1612283761;
        bh=46yi3nmN4JQyrKGKQXmbVIbp2G6R/NS6Vzz4rZEYw6c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HebvGe6AKVItb0Yn+6nnPAMkr0kpe1RuN9BPGDnALo+66jkGNYMgRV/Xi0TFWgW92
         +NuZ2gJLdcjkCRm8V08G2+JgZooyFS6KV5MZRbNlSz6QP7jFZ3pknBjgHoQOzQ4+os
         yQC3ltyuHKGr09lXO1SjIvo0dfov8CwCwMqonmJI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LfRzh-1liB0j4AVl-00p1Ce; Tue, 02 Feb 2021 17:36:01 +0100
Subject: Re: [PATCH v2] alloc.h|c: migrate alloc_states to mem-pool
To:     =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <pull.857.git.1612011569489.gitgitgadget@gmail.com>
 <pull.857.v2.git.1612175966786.gitgitgadget@gmail.com>
 <7a9e78d0-732d-a990-0cb5-6bd8cf940a88@web.de>
 <CAOLTT8Rf0vjB1+RuChbVPgf=YDif4B1mnro2MEF6E8+uGXM24Q@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <f10273ef-3d71-5220-9985-1a4fa2c84cd3@web.de>
Date:   Tue, 2 Feb 2021 17:36:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAOLTT8Rf0vjB1+RuChbVPgf=YDif4B1mnro2MEF6E8+uGXM24Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Drgu1hfr59GuLr+ZqctyNgZ3UcoJAhRoZWYUoqN6Xi1JlFr83gf
 L0nC+sRnCl7XkIR1RL1GuZKyn98yCpk18X8Pm5PvyZHhEF4FH772dWVCUAfU0Noh/LaGTH6
 HsmA/lGNm1nvfdfhI98JDo/KBTjhe9Ia57x5aoF1pozjpTjnXF3oEoVtO12/tncTvcJ/mcI
 lf1qyDzDrBe/Y5JRuAL7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4PtBOwgAaks=:MTONXkNhaRMxrgjetR2u7X
 Nn9H/6w6ZrfXKJuEHs3YtpjaNJlSKlqLtdf8UTjY6j5LjcXvSYToRE2iZBJ+aEAuxPDSzTQWW
 4xbUpdfCF4wsO0R6uu3XDidAhPdyCJMWXt5OUcwQbWl3fj9f0XvJtjMTmlPnLc3654vdoGUIs
 YEbBgxvEsM2GGejn2IrA1Hm39azX8IsblUX2Wwc8vu1ui946tbIg/srrMwNu0kycMMLPM+QPe
 iDUveTDeEoK5jbLtBWdnx+qczBYbINps7PRD4NuzEL+U+z1Eimj1RmhJC0M3AU18Q1/h8F/u4
 q287nBULklCvlG/G2Vd1F23sjKDn5v3hUSr/86DFUvj5rDTlxleOLsFLLD9xL+SFPQR5gx2G9
 sB2rDhA/dlkTyDRm5qMbsCii1PxbBAlONosLhYb9uKxY8irPj/NFfFgZ6MjInRf/XEqBbxsGA
 sIaCeqJgv84mGgcqYEjXcW3qhGmOU09OCeO5hj9736UVYR6P//Xsp7L7rHjxYa6nSYXtnlody
 y0ycJsHCX5iMXO23mGg2gMlYxftINGpetK8QY+gNDqvyWjXxy8+cB83Bcq10lnRgdetjR/3up
 r78huH2GKPA73GRbIfAp/XVVQ3ndSk6i+0DMGmda5RcKVoG06jirW/kAY92m9m8MZ3cUOiJcj
 EsjzBPiFiNTk81UMALPChI1wqYVlhQpvlOzBaNtSA35JDUNifyznHaLJS8xawOOwHpQI5lTIT
 3uQrE04doDq5s5Za1TjxTg3PKTJ53KEPu996g9G34fd5AdRPzFz7XpT6KI1xEyaDD6l0H2HjV
 hF+ZzjfLv0psWdvwmN8u4g6EfsKTHENXycPAWMWBWpHGuOjV8Q4AhHe778QAdZnOzKOiXeYdn
 L4E7d0AZgahPHWl2jF6Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.21 um 14:12 schrieb =E8=83=A1=E5=93=B2=E5=AE=81:
> To Ren=C3=A9 Scharfe:
>>> -     struct alloc_state *blob_state;
>>> -     struct alloc_state *tree_state;
>>> -     struct alloc_state *commit_state;
>>> -     struct alloc_state *tag_state;
>>> -     struct alloc_state *object_state;
>>> +     struct mem_pool *blob_pool;
>>> +     struct mem_pool *tree_pool;
>>> +     struct mem_pool *commit_pool;
>>> +     struct mem_pool *tag_pool;
>>> +     struct mem_pool *object_pool;
>>
>> Why have pointers here instead of the structs themselves?  It's not lik=
e
>> a struct parsed_object_pool is of much use without them, right?
>>
>> The same question applies to the original code as well, of course.
> Here I may have some questions: why use `struct mem_pool` instead of
> using `struct mem_pool *`?
> I hope you can answer my doubts, thank you!

If struct parsed_object_pool contains pointers to five instances of
struct alloc_state or struct mem_pool then you have to allocate and
eventually release those instances explicitly.  Your patch introduced
mem_pool_new() for the allocation part.

If the five instances are embedded in struct parsed_object_pool then
you don't need to do that.

The indirection added by allocating explicitly and using pointers
would be beneficial if some of five instances were optional, as you
could skip their allocation and save some memory -- but you need
them all to get a usable struct parsed_object_pool.

Ren=C3=A9
