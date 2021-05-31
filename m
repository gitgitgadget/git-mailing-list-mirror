Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0084FC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 18:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C336A610A0
	for <git@archiver.kernel.org>; Mon, 31 May 2021 18:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEaSkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhEaSkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 14:40:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C3EC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 11:39:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lz27so17876699ejb.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WbYOTdxdpG1Ze6j8hmtzW/+3pXoZDGZ7JuWfIuVlPLg=;
        b=T4AO6SnCtW2WNo5iDXs9c5LVA9BSLl+KVPqJmCto9145Yy8bS2x+gEhUQCgDeYZ0mn
         4a0YHqtelsd4lMdh/Jc+ap9LyVVtpI1fgW2iYJ421mxQoNfC6OnFh/8nskKHze8JcKJ8
         NyNu664R4KPDgMrZCaerkWHrHtFfoH99DTyNPgJEP5mxhmuWWMH0T08iCKp/hMMQqMOi
         Cqkw9vGi4hpEM4Kwwk9c2Bq0PetBKx6MJfzeQihAqDkXh7btfFgjnuADfBU0vugRjm37
         +hgVH5l6jlWevT6oQqKbuUH1TYOsAX+TGWl/rP49ZUi4dXBM8CSe61pKJe2n4pEK8kNz
         D6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbYOTdxdpG1Ze6j8hmtzW/+3pXoZDGZ7JuWfIuVlPLg=;
        b=iBYGh61gdHJOXmGfLY+wEM4kj01Vw8eoJdATT7WsLr2vxwsA3ISnkg3tbnRuaBeMy5
         2Oh6iLL7pUst2Ww6eHn/A5tPgaT6nMU08cta/jwyuR2PvFwNZSYcARs4mmmpVQ1nPv6n
         ii/M3zo2Wv+4SbG/2IEqkbz44f3mv7pf8Mrxrz0KiR91TkC6YYu0KJRDaO5b21jGjBEh
         4KEq4JFRWBT4f00FjXiImN0kdsmcan9CiccEZ/beBPcqoLr312l8gUa3Gzb6KQXwOeM1
         kg+iNd0UvBhrt4tuKG9TS3/sUj1jurcVqUOsvrFX9WYgGbxO4rb14NJ0BIe9id1+DAP1
         aMjw==
X-Gm-Message-State: AOAM530EOTzFsW9/zQOMnsUGEmICgxALV4i/QtJ1QDpMg7kOiynK5lBy
        lsk/kfQNRdkvEjDdJHjuENE=
X-Google-Smtp-Source: ABdhPJw22+s+ssBIL5lJtCNTrs4ajv3mW+HBao8NyNYfkaXBnNkZWiTsOjvM1pkeaY7X/jG2I7wuYw==
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr24297293ejc.196.1622486338672;
        Mon, 31 May 2021 11:38:58 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:c4c7:70b3:fe71:c06d? (2a02-8388-e002-8cf0-c4c7-70b3-fe71-c06d.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:c4c7:70b3:fe71:c06d])
        by smtp.googlemail.com with ESMTPSA id cz14sm624612edb.84.2021.05.31.11.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 11:38:58 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
 <60b3e2ceee840_ee4c20823@natae.notmuch>
 <3e5c2303-030e-928e-af57-8e2be8f3ce86@gmail.com>
 <60b4fd4db5dee_24d282088c@natae.notmuch>
 <5fa7e3f4-60a0-c3b1-83f2-054ed38e5683@gmail.com>
 <60b51d6c93c7d_279c820856@natae.notmuch>
From:   Mathias Kunter <mathiaskunter@gmail.com>
Message-ID: <c4bb335c-4909-8525-cbdb-bb214d18d8fd@gmail.com>
Date:   Mon, 31 May 2021 20:38:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <60b51d6c93c7d_279c820856@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.05.21 um 19:31 schrieb Felipe Contreras:
> Once those patches are merged, then I will probably send the one to
> change the behavior.
> 
> I will include you in the Cc list when I do so.

Thank you very much.

> In my experience you need to convince either Junio Hamano, or Jeff King
> for any change in behavior to happen, and until they do comment on this
> one it's fair to say it won't happen.

I assume they are on this mailing list?

I'd say it should be quite an argument if the related StackOverflow 
question dealing with this exact issue is one of the top-voted git 
questions of all time. [1]

It seems that millions of developers (judging by the number of views of 
that question) wonder what they need to do so that "git pull and git 
push will work immediately" on a newly created local branch.

If that would "just work" out of the box and with the default settings 
of git, without having to read up the solution in StackOverflow first, 
then it would certainly be an improvement for a huge number of people. 
So, to all whom it may concern, I think a behavioral change is advisable 
here.

Thank you.

[1] https://stackoverflow.com/q/2765421
