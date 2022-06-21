Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F6FC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 21:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354562AbiFUVXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 17:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355600AbiFUVXN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 17:23:13 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1262C60F4
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 14:13:38 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso19990876fac.4
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3pXWJQf/4CSDkiJK0kEHa7TJY113TbI6K9CYRBgDBt8=;
        b=LVIeJplhwVF2obURYpjilg5M1FxTbDMdXjZSbaZGPiWk0yjRAHVqAJ+IikMbhUtnwH
         2ExdrOvHMqHhUzhqxlnkBGjfRDsvJcxeqkiKmAlIFp2NS0BkYWD/qIz/jgAXja1VmltY
         MliJeMJzGfNI5Ce5c+1wScJcM+yQE66akliDfXCL4em/wHqOgdupkuvY4KfjR+ZF27/T
         xov3hfeoNcDuGXGSg0fFxUuge/Yat/VinC8AfKBBHKSTWnTocvqvdSQTjylzo446kpR1
         2GqFrkRe+L1ENLdcqoQseGRx8EzjSqsOo/8PSislf6O0ozaIaOxlYoBEY3jePAbPu3+n
         BkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3pXWJQf/4CSDkiJK0kEHa7TJY113TbI6K9CYRBgDBt8=;
        b=aOyqsVULRDoRgPcBrB04vQxyabRfU5mYoxfquxnuf6RqhK2b6j7Kdda8c6CzFHpwNh
         tv0BtlOwiIw2ph937l9Wvbf1NNswO1uGjh8dKGVHjGY1nQ/gGtmlRpvtfv6e62bw0kgt
         IC14I+2QI/8sPdkJinR2bSUed2apvpk/2BBfm3pgvhYAvssaT73HO9eREu8AKf9dTzus
         v5HyRzuHNgT7VrYbdTuxu0VcGir4f4pmS8Itg8/e0sm5BfivMbx3C1iARponegAm/9L6
         /adpWQ+kXJrCWiWzfgaf9+BMIOh1FKbjqA37e4U9KFgoEqoslY+80o8N2qy4aErYlnzj
         kCvA==
X-Gm-Message-State: AJIora/CvuQ38Q5tFGWHF6QVgqpdEYdpX5DwCtl7nqlC956d1Eenbyd1
        uUR6NVfw/sx/o634L5FuQvdO
X-Google-Smtp-Source: AGRyM1voy5p538onLvNH4EuTx34ntoNr1dR2rK5jx9U3QGnPxauUJuiRi2SBw1ZdC9ZqHmb8egQjOw==
X-Received: by 2002:a05:6870:a40d:b0:f2:a956:bdb0 with SMTP id m13-20020a056870a40d00b000f2a956bdb0mr21866896oal.263.1655846017436;
        Tue, 21 Jun 2022 14:13:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:44d7:1b01:4339:1df9? ([2600:1700:e72:80a0:44d7:1b01:4339:1df9])
        by smtp.gmail.com with ESMTPSA id k23-20020a056820017700b0041b57e44d93sm10331176ood.28.2022.06.21.14.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:13:37 -0700 (PDT)
Message-ID: <dbfbbbd6-70bd-3830-8c87-9f50c346e8ea@github.com>
Date:   Tue, 21 Jun 2022 17:13:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] t5510: replace 'origin' with URL more carefully (was
 Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, Jeff King <peff@peff.net>, avarab@gmail.com
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
 <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
 <YrFwcL2dRS/v7xAw@coredump.intra.peff.net> <xmqq1qviht4h.fsf@gitster.g>
 <xmqqy1xpg3th.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqy1xpg3th.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2022 4:27 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Yup, a solution along that line was what I expected to see from
>> those who write Perl when I saw the discussion yesterday.
> 
> Here is what I queued tentatively.  This is not exactly new;
> e1790f92 (fetch tests: fetch <url> <spec> as well as fetch
> [<remote>], 2018-02-09) first appeared in v2.17.0 and we can
> live with the same glitch for few more weeks ;-)

There are also other tests that need similar updates before
we consider this topic done.
 
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> From: Derrick Stolee <derrickstolee@github.com>
> Original-patch-by: Derrick Stolee <derrickstolee@github.com>

I recommend updating the authorship to yourself or Peff, since I
was mostly useless in constructing the actual solution.

Thanks,
-Stolee
