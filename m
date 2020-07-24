Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50350C433EC
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1D520674
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 16:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daejLxZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgGXQJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgGXQJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 12:09:25 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE7C0619E4
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 09:09:25 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so7281755qti.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQ2ZFha2q/iUKAGc5M8JnJg094jZG9H9rPhStL+VG6Q=;
        b=daejLxZJe1zytOB8Jsll5ARFQG5S4l3C+bRLR5lwaW9ejJbhxO6sDCDPs3oZd6PPIX
         dzevpuG4ZewMymo10nSQ1SXmlvvQ52cd8y0p6OCWHASQx6MfuMtucU7h2bfTOjGSmyp5
         IOGgRKi3XVayj2ZI/P0kQWWQFjNgYwr6pwz2VwdfIxP6v/JBsdBOG3p+qcIAr6ygyWVU
         O3ANE+82yygZyzV2kXTeTIDMN1LUkTgr3LRwCVz2X9JDn0MMcC87mZrvsdr6Q3pumiI0
         VCOfaCwFtZz5TwvukNf7dGDnJASnRdto9gFErjzvB4wInHuHK3qZYxWOuWm/0WsMC3YG
         Cq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQ2ZFha2q/iUKAGc5M8JnJg094jZG9H9rPhStL+VG6Q=;
        b=f1XsieMzCMs8AjiGwBPJ+OvFxf6faxvyzfIis/F2iJaFVTKOVIufzYDyW6satcMUYo
         qbGhaeqb08KtqN3/nfy4Va51hUqOoa1lMD/Y1jFUNyy7fES/pyTcWVmP3NFmT4UTxu97
         1X3cSe5IZvYiU99IYlRAzuHsqwBKsUFIfYY2yEUaqanFkElKuyxtvfz5shv1e3gt5TYe
         ZtEaZBc1EB13ElcQxBvjQyu4YnTkqH1GoAvSTWI2EDpRrZUYhylZsn+6ySJdJXnLTcG9
         wuDtEUG2qn86+OarZSSgvQ8n1C1ItAGGtYArErSe+qS8LPxjnNUUz9Eic9Q08BLfnfaD
         b1ZQ==
X-Gm-Message-State: AOAM5301gVYq/tGsjooxqRJZ7ZrMYb28u6sDdf/VX4XnflEiagdFkwpy
        MWSqXvjuBvVDEvANKPLxNpU=
X-Google-Smtp-Source: ABdhPJywCWRf0/GlBqNMU5g9nk3BsgLUkuOwlrVten0Hrq8uYHdcTnHQYwaW7Ka19FQHL2oBxSnd2g==
X-Received: by 2002:ac8:47c8:: with SMTP id d8mr9663196qtr.32.1595606964690;
        Fri, 24 Jul 2020 09:09:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dd66:75cb:8c22:1387? ([2600:1700:e72:80a0:dd66:75cb:8c22:1387])
        by smtp.gmail.com with ESMTPSA id d196sm4913585qkg.96.2020.07.24.09.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 09:09:23 -0700 (PDT)
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        steadmon@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
 <xmqqa6zpq3nt.fsf@gitster.c.googlers.com>
 <CAPig+cRXdrg6ceZV27yjV_jB58iDuMi=54SvtArV1BfxExRgMQ@mail.gmail.com>
 <xmqqsgdholvy.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ef102be6-132e-17eb-14dd-79239fdfd04b@gmail.com>
Date:   Fri, 24 Jul 2020 12:09:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgdholvy.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2020 7:24 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Thu, Jul 23, 2020 at 6:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>> +     struct strbuf batch_arg = STRBUF_INIT;
>>>> +
>>>> -     argv_array_push(&cmd, "--batch-size=0");
>>>> +     strbuf_addf(&batch_arg, "--batch-size=%"PRIuMAX,
>>>> +                 (uintmax_t)get_auto_pack_size());
>>>> +     argv_array_push(&cmd, batch_arg.buf);
>>>>
>>>> +     strbuf_release(&batch_arg);
>>>
>>> I think I saw a suggestion to use xstrfmt() with free()  instead of
>>> the sequence of strbuf_init(), strbuf_addf(), and strbuf_release()
>>> in a similar but different context.  Perhaps we should follow suit
>>> here, too?
>>
>> Perhaps I'm missing something obvious, but wouldn't argv_array_pushf()
>> be even simpler?
>>
>>     argv_array_pushf(&cmd, "--batch-size=%"PRIuMAX,
>>         (uintmax_t)get_auto_pack_size());
> 
> No, it was me who was missing an obvious and better alternative.

Today I learned about arv_array_push. Thanks!

-Stolee

