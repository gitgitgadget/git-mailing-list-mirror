Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015C81F454
	for <e@80x24.org>; Mon, 29 Oct 2018 17:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeJ3CsJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:48:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45938 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbeJ3CsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:48:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id d135so4461378qkc.12
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WEUfwIEiNyUkjB/uKey+WMwhP8cPAqzLQXC4/Ljr79Q=;
        b=Jd71i31tAGfGJ3whWdFoCLpvgtBhG8strZ4un/ZgOPI5BOVbndKl8mHO+YyzmLa66h
         1qUdyGSR8iAh7JuGTbd97FCzXKYE+G4kl7itVacULX2qLBYZxAB1tblB7RFhwX38FeD0
         LThLmvFjPlyRfQa/pVhTh8ofBIVPD4Tp0q2PadW5CH6LDwS4tUZF2Qukj7yvg3en2VQ7
         IYG/fN7tFLf7PnIQOW3hpAZNxVkdgXpTGiX+AMfW1ObXBvBA2PhTMaHX+4/TDUIgT8eI
         ApXBtJqJrmbpvWuW7PHUZW05GJOaUSNZv0ZBGNQOYguWdB18LNvaNZMX2vW5hAej6ZqI
         hSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WEUfwIEiNyUkjB/uKey+WMwhP8cPAqzLQXC4/Ljr79Q=;
        b=AXWd8SiCeWYhy0KQV+o9MuBmpmsoB9+3YsMVS18+RZ6D52ffRuTTMkIxVSOaDfjT7W
         AUEleIMcULaTQsTf59rbmXn1Wtm112lCV9q53Tl2WMj99D/qD6kjH0NRvbmqj/Ivf1hO
         KPZCDAH3TvegFTZLyM4BrLnc3BkDBpwPBtlHuG38IZmT098poTZftVLlKnedc+lICpyj
         2FhyQ24NvmTVgKlVJ0RMFKu4IQ6KJBsllFfKyBrmwfz2xoADrK0/hzWVylMEjTbDzYa/
         eotfrxQhlLg9wpAdX7BmQw2NKrMyVfEPuwer4iP8mDjpUWxNeDahh7iqTeL/Ez5q0BQA
         BUTw==
X-Gm-Message-State: AGRZ1gJowHvu5+b2mRlpyaBmjKwJi90HefF1JalbHRcAvkMPz9Y9UUAh
        qJcr3/wE7A7GPTt+Ew3vF7E=
X-Google-Smtp-Source: AJdET5fjpewOvi7fd4QIQ/mLiDkw7vAkYj3k5QnTyQoT09kk3qOwO1UIt+v8tpIAEDjQ+p81H8ds0w==
X-Received: by 2002:a37:6a46:: with SMTP id f67-v6mr12867873qkc.284.1540835907351;
        Mon, 29 Oct 2018 10:58:27 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o41-v6sm17290806qto.38.2018.10.29.10.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:58:26 -0700 (PDT)
Subject: Re: [PATCH 09/10] read-cache.c: remove #ifdef NO_PTHREADS
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-10-pclouds@gmail.com>
 <9e489011-36b9-a8b3-838d-de1a097f4854@gmail.com>
 <CACsJy8BD8nUfJoNjWCnaYgUn5+LaunOx74AgwPf5okG0OhwEXw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c28a563d-853e-c976-8268-45e84ef6afc8@gmail.com>
Date:   Mon, 29 Oct 2018 13:58:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8BD8nUfJoNjWCnaYgUn5+LaunOx74AgwPf5okG0OhwEXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/29/2018 1:21 PM, Duy Nguyen wrote:
> On Mon, Oct 29, 2018 at 6:05 PM Ben Peart <peartben@gmail.com> wrote:
>>> @@ -2756,8 +2745,11 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>>        if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
>>>                return -1;
>>>
>>> -#ifndef NO_PTHREADS
>>> -     nr_threads = git_config_get_index_threads();
>>> +     if (HAVE_THREADS)
>>
>> This shouldn't be needed either.  My assumption was that if someone
>> explicitly asked for multiple threads we're better off failing than
>> silently ignoring their request.  The default/automatic setting will
>> detect the number of cpus and behave correctly.
> 
> No. I can have ~/.gitconfig shared between different machines. One
> with multithread support and one without. I should not have to fall
> back to conditional includes in order to use the same config file on
> the machine without multithread.
> 

If you want to share the ~/.gitconfig across machines that have 
different numbers of CPUs, it makes more sense to me to leave the 
setting at the "auto" setting rather than specifically overriding it to 
a number that won't work on at least one of your machines.  Then it all 
"just works" without the need to conditional includes.
