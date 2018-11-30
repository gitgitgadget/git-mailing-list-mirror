Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A14211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 15:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeLADDE (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 22:03:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35955 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeLADDE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 22:03:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id o125so3421296qkf.3
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 07:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V1VsLTn8KNyyB0l6DHxhISUn8tXFHp6KyObX8DsenlA=;
        b=jBILUhc6QOGeIutSpHnXJfYdy2AfOL2ljGprqQ8DIMhThEjD2VwctAL6Hr/SQA2vkj
         0lbtXjykOCQQeJkP/N0r9NTmVaXTL5Ppk+qhFmZ9s6CUvJGSkgo64YkRulwAdgTY3agL
         EQkvqBBsW+VvjVaKzjWDzXTEY8wvS7VqSKXxk8lwtCwIfNbCH2Wpcx1UYyl8Frf1KwX+
         mVZ/XbRuGAs7PSST591U33LPQmid8VCE5IAAmX5ALZ95QCyAiMEC5clKl9zcrtFxMokV
         eJsPIFNhI6WBYC0E4QVS39IdjPFV7WsdqxPvEM9GfMvMf0qmm2B+5k5EUaNfZ9SdUpWX
         JDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V1VsLTn8KNyyB0l6DHxhISUn8tXFHp6KyObX8DsenlA=;
        b=aFdWFY67/yS/xd7mf797gbIUvyH0YfBb4HG2wzmMLqz2YvaS0Pd7pFZOuPyFFpQpau
         OOIHsuQNpdjxbSgv1X5iS1KASQQl2HmfJ8qYiev/EZjFNVYU+Yz5fI5QDldhW3Co7mF/
         Q9crl39FxbOczqmdvey99U+uu8JsRgsYEnaFEG2oLeCPAodXWgQDdkM/eowP8Z4xYgXK
         UIxpr8Iclm/qfye55jeCXvanj/+BvUqxSi3Q6wPdQDCbjq1zxTvXjeYfDUXQPZJbN6CW
         YhazRd2buYKc8arCgYxS8KHC7vMzDshLX8c/K2euX1QrCUZelNVu3lUR+qqV9sh/M37r
         exfQ==
X-Gm-Message-State: AA+aEWb8dv+fv0wfRz18fEmdwYmZW8+oVwpyR1VAystfNjtaTl1ZUpFJ
        1GT4BI201Rkc4c+VgCtaPFA=
X-Google-Smtp-Source: AFSGD/X95+9VzRgLVAxGRcGm9ngB8X+8xz/ViMI8fVq1dFXyG/S29kqCB46aCvrYfXZObB9duMhtMg==
X-Received: by 2002:ae9:dd42:: with SMTP id r63mr5547309qkf.264.1543593196732;
        Fri, 30 Nov 2018 07:53:16 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:2ccb:dbc2:b5d4:990d? ([2001:4898:8010:2:15ff:dbc2:b5d4:990d])
        by smtp.gmail.com with ESMTPSA id 195sm2941352qki.76.2018.11.30.07.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 07:53:16 -0800 (PST)
Subject: Re: [PATCH 3/5] pack-objects: add --sparse option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.89.git.gitgitgadget@gmail.com>
 <9d6b8f6d0602e85652b2a748c58eeed4cbf4359e.1543441960.git.gitgitgadget@gmail.com>
 <CAGZ79kbVGyX=Ky9HvmUGWPoHdLJYqnPTNda2kT3aC8XuHnH3+A@mail.gmail.com>
 <1e9d4d2d-561e-fcbc-48cf-374dcb9ce009@gmail.com>
 <xmqq36rjmgqf.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f9421d46-9cdd-5399-d55e-d5351f149630@gmail.com>
Date:   Fri, 30 Nov 2018 10:53:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <xmqq36rjmgqf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2018 9:39 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> While _eventually_ we should make this opt-out, we shouldn't do that
>> until it has cooked a while.
> I actually do not agree.  If the knob gives enough benefit, the
> users will learn about it viva voce, and in a few more releases
> we'll hear "enough users complain that they have to turn it on,
> let's make it the default".  If that does not happen, the knob
> does not deserve to be turned on in the first place.

That's a good philosophy. I'll keep it in mind.
> Having said that, I won't be commenting on this shiny new toy before
> the final.  I want to see more people help tying the loose ends and
> give it final varnish to the upcoming release, as it seems to have
> become rockier and larger release than we originally anticipated.

Yeah, no rush on this one. I just wanted to get some initial feedback 
about the idea.

Thanks,
-Stolee
