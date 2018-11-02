Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AC6C1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 16:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeKCBey (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 21:34:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38555 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeKCBey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 21:34:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so2578072wrs.5
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ZDjEyvchlcC5PcQocJ1/TkeQn/LYvyk6//GAwu/COY=;
        b=aCrRbwgskRj6vLkFhpMkZbUxX8zKgM6/hciF54qwhunImuhhAq6/2zRuGnohGCtrUf
         eUGuDk26j4Jg0kuj8zL5fA9rX+aYKQz14nY4R7erRq8uVO+SEPGjsr8rW0iMKcwpOkRE
         8+KAxps2PXqEP6mFntmiEUdp3MtRMJAOI3NBmEE4qYyoe7GFDgVk4VambJ2nA9Tk+88B
         PExSxlUssQ19nghKyg5VImiunaHjD51TzLCfB+bYCfjsXN1pbSiXTR+hRFz/5YwprZgX
         mjFSx54JvCJHi9FSUgrUDzGyEFzuxcO8HNO+zYkTuBu50wTsHJYiqyib0dmxYnARFa58
         Fd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1ZDjEyvchlcC5PcQocJ1/TkeQn/LYvyk6//GAwu/COY=;
        b=RBMtv6MlTvwtdAZc0R2ZG91QC8pdShKTQRLXEHt52F4RvhSiJWorYmZUYrn80XgsH0
         CGPAa17P/S4xSDz7jD3LpdvbKW3tptNNSoRZzW10VJOWy0nTFBFdyFb41AsCiBPYb6dO
         Flbmzl230q+i/X9fSND9XSzKJ18qXOD0DceSLw2wQNERamkIsfmsYi9Q7KRiDHtcjP9Q
         Uz8wm9NfcRUJ6emeIni8syUfYsejepeLWDQpTNDRCvSJ9fYGHWok8X3nShm4l6I40ECG
         9m6EEpcPB5tT/nOiHLtTIqt/OyVSLIiEx4bAbSaEjjl1Y3E5ar2stq6hfrA6UiTGMnou
         KxQA==
X-Gm-Message-State: AGRZ1gKn2+MyE7Q8MJqvh1/i7FsjO3W+epIHLmNH4KClKpTJv3X4/OuR
        vGr1Pa9fA7Xzpg6tKDhYtSao+ub6
X-Google-Smtp-Source: AJdET5fhacf1v+B9b6vRYvNtZPPPIAffXBy7J0QIwFc/zWhbrzhVNI+5rMCbv3rvHoOQsLxSfEqR9w==
X-Received: by 2002:adf:e68d:: with SMTP id r13-v6mr10237495wrm.239.1541176032298;
        Fri, 02 Nov 2018 09:27:12 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-25-2.w86-222.abo.wanadoo.fr. [86.222.24.2])
        by smtp.gmail.com with ESMTPSA id o81-v6sm18279602wmo.38.2018.11.02.09.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:27:11 -0700 (PDT)
Subject: Re: [PATCH v2 06/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181027212930.9303-7-alban.gruin@gmail.com>
 <12e849d3-351b-7673-1f14-742d0fbb1ac1@talktalk.net>
 <c57384de-0996-2294-db8f-0204f9c16226@gmail.com>
 <351e3398-8239-5348-2880-d253d8a125d7@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <878848f4-f8f6-25cb-061e-5f7aef9ca1a9@gmail.com>
Date:   Fri, 2 Nov 2018 17:26:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <351e3398-8239-5348-2880-d253d8a125d7@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 02/11/2018 à 11:09, Phillip Wood a écrit :
>>>> +    struct todo_item *items = NULL,
>>>> +        base_item = {TODO_EXEC, NULL, 0, 0, commands_len, 0};
>>>> +
>>>> +    strbuf_addstr(buf, commands);
>>>> +    base_item.offset_in_buf = buf->len - commands_len - 1;
>>>> +    base_item.arg = buf->buf + base_item.offset_in_buf;
>>>
>>> I think if the user gives --exec more than once on the command line then
>>> commands will contain more than one exec command so this needs to parse
>>> commands and create one todo_item for each command.
>>>
>>
>> Ouch, you’re right.  Thanks for the heads up.
> 
> I haven't looked how difficult it would be but it might be best to
> change the option parsing to pass an array of strings containing the
> exec commands rather than one long string so we can just loop over the
> array here.
> 

It would be the best way to do so.  This string comes from git-rebase.sh
(or builtin/rebase.c) -- they format it this way before invoking
git-rebase--interactive.  So either I modify both of them (for this, I
would need to rebase my branch on master), or I can split this string in
builtin/rebase--interactive.c.  I prefer the first option, but maybe
changing the base of this series will not please Junio.

Cheers,
Alban

