Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECC61F597
	for <e@80x24.org>; Wed, 25 Jul 2018 21:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbeGYWad (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 18:30:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42529 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731248AbeGYWac (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 18:30:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so8676191wrs.9
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T+/q5jW1AdXi1UO/MYK46CzDlTdgL8JAqM5tVjW11mY=;
        b=Nt876n4ImuKBBMnXyDZwM+lRdWFFULPbJmoXT39bBT/4w7Bm4duwhaxkfzWxkPAZ3M
         kj6wHoCRqKzVx98Grix/1B2+KxU0+WR80DnWJelOV6OsWCL3M6KsPUF0iaijaWnMzikC
         I2iSJrAy5yrmi4LJx0njfUlJnIZhOUjM0irZvQ5/Jbxgl27PFt67mq4da5uWFFxj6wZq
         tpvADEaxEmKOwlK4Lc6Cjkm0u9RBpvR8MJfyU13OsJBF5hITezv8CVBTeYKTj+VIcmvt
         Vlq9uJptO/nQbl+3EvgYkDnukG1moxSaYIylps1LSAHl+2bXT1DsD9AwfF0vdPO9SHKC
         JTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T+/q5jW1AdXi1UO/MYK46CzDlTdgL8JAqM5tVjW11mY=;
        b=s1BZVUXbMJaLDvwUdWRdhjiHe2DWFKHoQy84fsIca63BMHo8l1CNB7LUxYwwv/l1qO
         k1s0tfoTFXdlRfKuaxvf858KvJ5MpyE+OHvhUriK8mctb25FpLBiUtpMLyUU81cuatXE
         7zFIBpLOz7L1tSdYiIHGVibYIzkV2ha50tcLe7vx2PXaqK8Wnih1s4xcG6ULSEeQGlwi
         /CDJN8Wrzs/xJ7OANQOd8O+13JL4+c0lWQynP3nxVdTg8GQtaXlYOC5uZn6oprGclcCg
         59W3yxJnaqkqHEJ4A9CkVjodsTbP4jVA0XQsDeUgiIWe4iaTC7G5FYRdA/ifVDZPQW7m
         mavw==
X-Gm-Message-State: AOUpUlGlo3OFtLtngzwGJ6G9uatajn1SykkAUZDBxQ5DDIlcbSurQ5Gr
        +qE5ohpNUw82ABErxXZAbCM=
X-Google-Smtp-Source: AAOMgpdQghy9pCLRrQITpb9P5EnWWio/piRPKIM5+kWeDqnfrykunepjFQB8/dXXezIXPq7lACxieg==
X-Received: by 2002:adf:e190:: with SMTP id k16-v6mr15773961wri.36.1532553420978;
        Wed, 25 Jul 2018 14:17:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q140-v6sm9492830wmb.35.2018.07.25.14.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 14:17:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Beat Bolli <dev+git@drbeat.li>,
        Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] remote-odb: un-inline function remote_odb_reinit
References: <20180724215223.27516-1-dev+git@drbeat.li>
        <20180724215223.27516-3-dev+git@drbeat.li>
        <20180724215953.GD136514@aiede.svl.corp.google.com>
        <cf9889ba-89c5-dc97-d888-aa42aa9dee68@drbeat.li>
        <CAP8UFD2PxA4s=Gb-6paUAdWpmqMWpis3mn0Zz9nzqQhHt1EEBg@mail.gmail.com>
Date:   Wed, 25 Jul 2018 14:16:59 -0700
In-Reply-To: <CAP8UFD2PxA4s=Gb-6paUAdWpmqMWpis3mn0Zz9nzqQhHt1EEBg@mail.gmail.com>
        (Christian Couder's message of "Wed, 25 Jul 2018 09:29:06 +0200")
Message-ID: <xmqqmuuft3qs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Hi,
>
> On Wed, Jul 25, 2018 at 12:03 AM, Beat Bolli <dev+git@drbeat.li> wrote:
>>
>> On 24.07.18 23:59, Jonathan Nieder wrote:
>>>
>>> Beat Bolli wrote:
>
>>>> -inline void remote_odb_reinit(void)
>>>> +void remote_odb_reinit(void)
>>>
>>> This looks like an oversight in
>>> https://public-inbox.org/git/20180713174959.16748-6-chriscool@tuxfamily.org/:
>>> there isn't any reason for this function to be inline.
>>>
>>> Christian, can you squash it in on your next reroll?
>>
>> That would probably make sense. I didn't check how mature the topics
>> were that caused errors.
>
> Ok, it is in the next version I will send.

OK, then I'll ignore this one for now.
