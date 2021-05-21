Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C5C47076
	for <git@archiver.kernel.org>; Fri, 21 May 2021 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50A1613E3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 16:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhEURA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbhEURAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 13:00:50 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E6C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 09:59:27 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id k4so9311611qkd.0
        for <git@vger.kernel.org>; Fri, 21 May 2021 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v/eKtN/cGTWip5xj+gRL2AJhGvwC/M+/uoIxwCWgJxY=;
        b=hUpxaUF9EscA5gp44qskiBOtAqcZHVCk//RAb60VqQUMgwT3OAqDnW3xy0uuLOsdS9
         Sn309SgvdqracyYtUvysDxAj6iZpkgM4p/iIV6sInbDNf/9YZPbAFCauC2kDvbuMhPMO
         IydQVOKhoMtVhVlyHQx9o+p3K5GjnvX8fAogyp5mMnwpzHzLKixvNaJlq91cISztjQ1X
         c3cbO3a9SxaMZR3yGUFDhgqQs5ELayMYWqY4ogCL4XTJ1bOKlJjRYAKlMy72So4LD6rI
         rSjGto24TroxKF4thvkBsi7LUl7tjKu8TSyPdv/SPrLSbcOaLTig6gFpbGf0XdTDbFyL
         g71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v/eKtN/cGTWip5xj+gRL2AJhGvwC/M+/uoIxwCWgJxY=;
        b=UPBFYzRIzP55aVeSmEKR6mTCjPJ/IXrIbgyrYzWeNiC1kzei8qWYRu7rt40QtNEN7J
         FMZa9sDyVDz/MsIlJs8W4KzRxxnou3gEbOX0p04gZN3sWRNXzrjdGkFPT8Ncax1cp+Z2
         WSuEfVXp0IMd0upV5vMlLSNiPjhswz9qXnRfGB23MjyFplZMGP7rpRc02Q5k+HrEciXx
         c5ESm1a2xilmXy8Tyv7O3oz817Cvmc4aBrjr7QTPYHMQ215LblT3vri7m+x2P1OMnBJI
         iL0pYTbe2CevM4cIw7DXF+H19HsM0hGXYnHNM87aPbEJCsgPR6Ic3rwgevKHnUyQRBgA
         Fo4w==
X-Gm-Message-State: AOAM530v3+hmjXcjRbzJyGspnU8/Jj/jHHHaRHZlhYu/dyGmH8WSF1pN
        8a904TaDtH2NgDc0UyAZyk8=
X-Google-Smtp-Source: ABdhPJzRKC0cIp9NOYDPiVDwQNQPgttZnzzZrcWv+iCzfwa1L7epxznM+gLvVSxLoIdp1wOneGxTRQ==
X-Received: by 2002:ae9:c219:: with SMTP id j25mr10581543qkg.235.1621616366557;
        Fri, 21 May 2021 09:59:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:9066:494f:3cd2:8537? ([2600:1700:e72:80a0:9066:494f:3cd2:8537])
        by smtp.gmail.com with ESMTPSA id h65sm5419090qkd.112.2021.05.21.09.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 09:59:25 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on
 Linux
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-5-lenaic@lhuard.fr>
 <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
Date:   Fri, 21 May 2021 12:59:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/21/2021 5:59 AM, Bagas Sanjaya wrote:
> On 21/05/21 05.13, Lénaïc Huard wrote:
>> The existing mechanism for scheduling background maintenance is done
>> through cron. On Linux systems managed by systemd, systemd provides an
>> alternative to schedule recurring tasks: systemd timers.
>>
>> The main motivations to implement systemd timers in addition to cron
>> are:
>> * cron is optional and Linux systems running systemd might not have it
>>    installed.
>> * The execution of `crontab -l` can tell us if cron is installed but not
>>    if the daemon is actually running.
>> * With systemd, each service is run in its own cgroup and its logs are
>>    tagged by the service inside journald. With cron, all scheduled tasks
>>    are running in the cron daemon cgroup and all the logs of the
>>    user-scheduled tasks are pretended to belong to the system cron
>>    service.
>>    Concretely, a user that doesn’t have access to the system logs won’t
>>    have access to the log of its own tasks scheduled by cron whereas he
>>    will have access to the log of its own tasks scheduled by systemd
>>    timer.
> 
> For gender neutrality, we can use he/she instead.

Singular "they" is better. Fully accurate and less awkward.

Thanks,
-Stolee
