Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CED8720248
	for <e@80x24.org>; Wed, 17 Apr 2019 15:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfDQPEX (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 11:04:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40563 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQPEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 11:04:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so4009920wmi.5
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vKA0TVMAXxX4x6Oz3v8yXsxyXxCcCm8CGSxh4wljl/w=;
        b=IkQSEDqGH5e1UwaszyRAfRVhcZ3A2leQEn0aDybEO08YP7fHYzzwGuneegvLXYBzsd
         r6WYXzKgk+lHuweg3jvsMGuVIVhYlK35/kCwaF5XA1Cwfo5B7rWT3eFpxT5n+3CjTEkg
         gQtXIxhkRNQIvIMV0tpVRwZA+fuyTFA6aPEvXPVs1Eq8x8ct9fTTHiEcYfO1YwW4Snvt
         wW7kFqrhDIUGSTV8GnBkq1UCRmcrIpy+UbYz/SEc2uQ8DoE25EaOc80OptUsI/Qcqodc
         BYsZpWZwrpDTyICHrGciceSgPHPMsRHrm3HdJ3t70frxT/pRXCri1BjErhgsMQkATH7N
         72vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vKA0TVMAXxX4x6Oz3v8yXsxyXxCcCm8CGSxh4wljl/w=;
        b=qDdrrjP5ebiX/AAZX/Svl2uo1pk4yhxCKL7BOa3aZj0j5pCX0wzcfIcD7ZWWq4AUPP
         PwNcFLfSlfFKIZvHwXZGRY4Bo6KTWFXYZkhoFgjksb/THwJa5vHDCsrp9uK0dmCftSBD
         xy1Ip4tvNE1SCCSW20+SLHA+K1ztt6EmeBulGmWMbP80oRwXl4xXobLEJxj6WGNVJV6M
         nKwEstVtZDFlZnABP9uKkD63Mt2a5SPQkJQqzqo/KRGZs2Da+K7YEq4CeeqZJtgKezz0
         pPbb2vUWVxIwf7jD2azlUgLzHy1j+cd8XoX+tS6WpA1VZ3wexqtxHRHeIJ0zIyLQjVwR
         iFfA==
X-Gm-Message-State: APjAAAX5v9GSgx8nk8pSj8V6LrYDjP9M+D8L3b+JfLBxRt3NNzupPUhH
        4EeeGWyCUThn9VKs9qMrrzrAdiRS4TE=
X-Google-Smtp-Source: APXvYqwijJWyQYw2aw245KVS08OjvVHJCQBAaTiQXFcMn11UlVjGR0BRn3qh/O+ZMWDZiyXR8gg5ng==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr30695825wmi.20.1555513461637;
        Wed, 17 Apr 2019 08:04:21 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id x18sm3453425wmi.6.2019.04.17.08.04.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:04:20 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] commit/reset: try to clean up sequencer state
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190329163009.493-1-phillip.wood123@gmail.com>
 <20190416101842.16556-1-phillip.wood123@gmail.com>
 <20190416101842.16556-2-phillip.wood123@gmail.com>
 <xmqqr2a1jenm.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1904171423370.46@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f1371b89-8f8b-d0b9-7bda-23f8cb5d0541@gmail.com>
Date:   Wed, 17 Apr 2019 16:04:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904171423370.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 17/04/2019 13:26, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 17 Apr 2019, Junio C Hamano wrote:
> 
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> Avoid this potential problem by removing the sequencer state if we're
>>> committing or resetting the final pick in a sequence.
>>
>> The use-case story before this conclusion only mentioned "commit"
>> that concluded the multi-step cherry-pick/revert, and never talked
>> about "reset", which made my eyebrows to rise.
>>
>> As a part of "reset", we have already been removing CHERRY_PICK_HEAD
>> and REVERT_HEAD, so "git reset" during a conflicted "cherry-pick"
>> for example is already destructive and the user can no longer get
>> back to continuing the cherry-pick anyway after running it, even
>> without this patch.  So from that point of view, it does make sense
>> to remove the other sequencer states at the same time.
> 
> Do you mean to say that a `git reset` during `git cherry-pick <range>`
> aborts it?

No I mean it removes CHERRY_PICK_HEAD/REVERT_HEAD and so cancels the 
conflicting pick/revert, it does not abort the operation as a whole. If 
the conflicting pick/revert was the last in a range then we want it to 
remove .git/sequencer as well as the ..._HEAD file as it is easy to 
forget to run --continue in that case.

Best Wishes

Phillip

> In my experience, this is not the case. The advice printed out after a
> conflict even recommends to run `git reset` (followed by `git cherry-pick
> --continue`, in lieu of the `git cherry-pick --skip` we have yet to
> implement).
> 
> So I don't think it is correct to say that `git reset` does not let the
> user get back to continuing a cherry-pick...
> 
> Ciao,
> Dscho
> 
