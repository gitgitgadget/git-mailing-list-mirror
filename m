Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1C7C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 23:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5285722EBE
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 23:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbhAEXVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 18:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbhAEXVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 18:21:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E1C061798
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 15:20:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 3so1057611wmg.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 15:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pzhqg7Mc6VOYvKwzI59As/hwt89QWQbgAXkXdEBlct4=;
        b=mTrUQcO4GTVg1SOyHoJLjWEidZluMratveqCNXcfzEbXtzkPiHFOyOVJCdDn/iW44n
         K93gP7y1w7keMzFl+NtVR7kDqQluz6fKvzOf6OLQaXUIyDZOb44bNP+KBeZnFEU+CoNP
         FM4DHMZ93zwe1Ojq+KO9jL0Ty2dClj0Q0cZquRGuEI3fiGvnwX/nuIvb2YXPxAxcrIqE
         IZrW2bNZ9uunt2HgVqa8lRJJDY91KCiX4BDMDs4EyMkZmyIP96WFQoA8gl29b0jh4sGE
         4V9ccgWiQcK16qS7lks+plExGV/5Sn3NkC/wqjOV0B6yQvluDKt4vwKL4ZouKdKaTXU5
         14Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pzhqg7Mc6VOYvKwzI59As/hwt89QWQbgAXkXdEBlct4=;
        b=JH91lSUYjeSvZ2MTr53p0oSIzm7rPVqnN+vBJGBsN8gkG4ZKpLHfr2roGUDDWXSuHa
         Lne9vjQGWAw+F53yEXmLx8Iqc3GdpzGMpXir8nodlHRQnqUBjVBKN2vVnLW9J8ZbhRjV
         tnt8eOjbUmcQWZFes2Wm409nuv3mw4qeQMdfjLZLI040yU1OJMWJeFh3sZ8mzNzc7Yqh
         JNwYKtldRyTWqgqZaBHZMolJQ9o+7JIkqpP0C+Ixzm3bx4D8fC2kFnk0A7Ne4ey8n71N
         UvuXfYnvIQVkIHVNSomv0HkwZYNExON6VnmYL2ibL4F/sBDZ6nriUpEk2dY5H3GMaAZp
         rQpQ==
X-Gm-Message-State: AOAM531omVS6eQPEZdZZ3JOeFINVM+Xb+pMhxkXsULJdXDJKiwf6nS5Z
        2eWfrxDwlD+IwpPEhLcvYeY=
X-Google-Smtp-Source: ABdhPJx69hh/gvfvXMfegSYMmZXk9lAbN57mep2GldScyx6V2k1+oxqZnMZJf0uqaFDQKo1s8TCFWQ==
X-Received: by 2002:a1c:ddd5:: with SMTP id u204mr1154525wmg.174.1609888838367;
        Tue, 05 Jan 2021 15:20:38 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-420-166.w2-6.abo.wanadoo.fr. [2.6.83.166])
        by smtp.gmail.com with ESMTPSA id x18sm805879wrg.55.2021.01.05.15.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 15:20:37 -0800 (PST)
Subject: Re: [PATCH v6 06/13] merge-index: don't fork if the requested program
 is `git-merge-one-file'
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-7-alban.gruin@gmail.com>
 <44c9189d-9d2f-c437-d0d6-9529708d2c99@gmail.com>
 <CAN0heSrOKr--GenbowHP+iwkijbg5pCeJLq+wz6NXCXTsfcvGg@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <a0c44e65-bad5-5fb1-9aea-806260a6294e@gmail.com>
Date:   Wed, 6 Jan 2021 00:20:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSrOKr--GenbowHP+iwkijbg5pCeJLq+wz6NXCXTsfcvGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin & Derrick,

Le 05/01/2021 à 18:35, Martin Ågren a écrit :
> On Tue, 5 Jan 2021 at 17:13, Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 11/24/2020 6:53 AM, Alban Gruin wrote:
>>> +     if (merge_action == merge_one_file_func) {
>>
>> nit: This made me think it would be better to check the 'lock'
>> itself to see if it was initialized or not. Perhaps
>>
>>         if (lock.tempfile) {
>>
>> would be the appropriate way to check this?
> 
>> nit: this could be simplified. In total, I recommend:
>>
>>         if (lock.tempfile) {
>>                 if (err)
>>                         rollback_lock_file(&lock);
>>                 else
>>                         return write_locked_index(&the_index, &lock, COMMIT_LOCK);
>>         }
>>         return err;
> 
> FWIW, I also find that way of writing it easier to grok. Although,
> rather than peeking at `lock.tempfile`, I suggest using
> `is_lock_file_locked(&lock)`.
> 

OK, this looks good to me.

> Martin
> 

Alban

