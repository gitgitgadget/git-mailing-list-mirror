Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18962C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68FF613C7
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhEMHdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhEMHdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:33:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC2C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:31:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f1so7697688edt.4
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZI9tmk26VRKxh8NGWkjRvRvRCMLhJrWrvMaItNdrVvk=;
        b=CXVLGGXIWl8Qe8n59H7TQrLIr1dDf9ikT7HVq+OOlyhNwsJy+aJFNFeM/h4etQsvIe
         OUQM34R3zWyi2s8JtIVYpRo0hAzVVSNneY/IDQcQBmKc1786sH/X8+gVtmpdRfbUQbhI
         2SXzUBkK5XiVC7OYC26Kv6OlmzrxFc0qO0Fk4zEnGluGhvY4ldJvmfzy0Tz/nF7vD+aO
         poYhTU0IHYjsHMMlT4psHVgEWQgr94hcGWL9L1aCWXopfL/MxmvO0U8F+znssOk4B4L3
         m4gov91H5XnA+/PvlTuQISD3q6b7lMlabtxLv+6Ta3pPRlvwYPwaoBsdiK6HVwo35WHc
         A7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZI9tmk26VRKxh8NGWkjRvRvRCMLhJrWrvMaItNdrVvk=;
        b=e4C5dsdyXdxCySzMAxR6TITnzmk8QWO/En0GZT12qrMOUB3Qo9AajP1VVqisZPepSO
         vcn+aFjpkc/D59nYc/0OiuJk2XMLt57Hm6Qb8+R0TMbidTaxQCSd1XB2Lw3ZEXnNKeta
         GrfL8rUq8jjRQehULIDh6lI1HDP+wQAKOovh4BbjgzWU1pNRAMNU+qEwGRcUZ+jeckhV
         dBwCxC+S/kTdQnc3qDbrGFnE8tgYFj5Xf9mzCoFDyMNEdNrkdMMnd4iYJrc64QsLFk20
         rzydsuagO7aXTUnm8neXl7AQsYf0b0l0K4x2z+SVWZYzQjNpvglIDnLexHjvQ8rq/dTt
         PV4g==
X-Gm-Message-State: AOAM532hWcUBerYCRFhuevNCvZ70FTo87GKHjjAD/jwJMVsedpjSuy+T
        o+J3mx77gqbkWltUJdmBw54=
X-Google-Smtp-Source: ABdhPJyXj3MIkzOpMgLhf+zwX+l4GokDuEsBw1hNMPI0KhFo5FmS6VRDlFCwLeNuKtAAQAAr4AQS1g==
X-Received: by 2002:aa7:d058:: with SMTP id n24mr11292707edo.275.1620891100786;
        Thu, 13 May 2021 00:31:40 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cf10sm1769480edb.21.2021.05.13.00.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 00:31:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 9/9] send-email: move trivial config handling to Perl
Date:   Thu, 13 May 2021 09:07:57 +0200
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
 <YJxgC/PJ/JIcIOfq@coredump.intra.peff.net>
 <609ccf688a4e7_329320879@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <609ccf688a4e7_329320879@natae.notmuch>
Message-ID: <87v97nrsx0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 13 2021, Felipe Contreras wrote:

> Jeff King wrote:
>> It is a bit unfortunate to have to go through these contortions, but
>> this is definitely the best we can do for now. I think in the long run
>> it would be nice to have a "--stdin" mode for git-config, where we could
>> do something like:
>> 
>>   git config --stdin <<\EOF
>>   key=foo.bar
>>   type=bool
>>   default=false
>> 
>>   key=another.key
>>   type=color
>>   default=red
>>   EOF
>
> Why do we even have to specify the type? Shouldn't there be a registry
> of configurations (a schema), so that all users don't have to do this?

Yes, we should be moving towards that. Currently we're not there, the
closest we've got is the generated config-list.h.

If we closed that loop properly you should be able to do:

    git config --get --type=dwim clean.requireForce # or auto, or no --type

Or whatever, instead of:

    git config --get --type=bool clean.requireForce

But we're not there yet, there's also edge cases here and there that
make a plain exhaustive registry hard, and send-email is one of them.

In its case the value of sendemail.identity=something (if any)
determines if/how e.g. sendemail.something.smtpEncryption is
interpreted.

I think we can do it with just a list of config variables where the
variable is either a string or a regex (in this case,
"^sendemail(?:[^.]+\.)?\.smtpEncryption$"), but I haven't tried. There
may be other tricky special-cases.
