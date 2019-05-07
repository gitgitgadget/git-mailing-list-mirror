Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A541F45F
	for <e@80x24.org>; Tue,  7 May 2019 14:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEGODd (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 10:03:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39675 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGODc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 10:03:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so20183375wmk.4
        for <git@vger.kernel.org>; Tue, 07 May 2019 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cx/0qy8TPzhy4UubZs0dpvzQSR0yTPYdy/66gVmMFhw=;
        b=h19B2+++QGZ0UZ7DDaTWH/ed3IVnRKXSTJN/p2P4Y/wjwMi57DmXbBx7Ch4Obxnfps
         GE09bGDshDqh++juY9HTR8qIWuWYNw+C5G/nFxPZKFI6sBM2KuZaPb0Ojzlg30u/X+7r
         dcz5DGUgK6qFBgU3JOIXXleBvGA27iPJCSxypdPhuFxDJJA+1EKbFhGkVNC6q0NCyXma
         xQfbDhbf8laBxk/LPetDe3X8VSjMaF5zYXoU5dhq5Upm7i5rJ2YQjdtiB4cnJkSjlQYf
         ejn9SQzDTPEEkqP2xItD46jhdpRxFlOLjTzNETAsJzQH98pPSpR0kHz/OM2oKX9mEydv
         VJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cx/0qy8TPzhy4UubZs0dpvzQSR0yTPYdy/66gVmMFhw=;
        b=W5LGkxWwVORt5ka1l2Be0EMeOiOfDCt/hAclLf/lGFdo1n1XjCJdZiR8fXVgF4XU/4
         bbC44E5cAMgP8sTlU+ONgEj5Aa+m0wuFTrWwSjh80oPh/K4ffDsHAKYysIVRVqdje8th
         AbEcvF+EqZ+4b88xR5s8obz0f94dZjWYuq+wsw0jp8FRPTXMtbTpWfb63qdiWHWmPiua
         //FjnqqNqQgbMobqrJs6uc1AdekpfaooDR6FaR191fO9YiRaAFmW28d3BJuxuTw89D1J
         avjoY274OfKMA2lXODLiISDJSFjllr1KqM0faT9N/ge+wTMTF+MEj6KfTS1jKsFzVP2O
         AFYw==
X-Gm-Message-State: APjAAAXsgHPRJUJZsw9kaqeQdZnIMQ3poW8yP2wN7PTuTYASgk3oh5SP
        s292ijVQPWBM6ze9FX1QWBwQinRt
X-Google-Smtp-Source: APXvYqwL5S0oc8nwDTrMIJus5MgyKPbHAxlImYkYbc9/RM5LbrhUmfpbzbl3OWWMEv+uHlOYlSf9IA==
X-Received: by 2002:a1c:9689:: with SMTP id y131mr22484550wmd.74.1557237811380;
        Tue, 07 May 2019 07:03:31 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id r9sm13327345wrv.82.2019.05.07.07.03.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 07:03:30 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] rebase --interactive silently overwrites ignored files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     wh <microrffr@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <CAL_tzDGRQ4BzJ4c6QypXfBXQNQYocbKbJSBOHhBBB2TwQQPCGA@mail.gmail.com>
 <2643a200-5356-f3bc-1715-3f34b5f19a5b@gmail.com>
 <CAL_tzDFQQtDYMStN+RDVYN_TzJmO+kufMhG9PGHwvsUWREpgWQ@mail.gmail.com>
 <3bf0f04d-83d4-ef13-8e19-a679b4153793@gmail.com>
 <xmqq4l69tupt.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <76bb6944-d448-66b9-dd4e-ed3e262e9a96@gmail.com>
Date:   Tue, 7 May 2019 15:03:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqq4l69tupt.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 05/05/2019 05:02, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I've had a look at the rebase -i code and I think it only overwrites
>> ignored files when it is fast-forwarding. This matches what merge does
>> when fast-forwarding but I'm not convinced either of them should be
>> doing this by default (I think checkout doing it is probably asking
>> for trouble)...
> 
>> I'll put a patch together to fix rebase -i, I'd like to see the
>> defaults for merge and checkout changed but I'm not sure that would be
>> popular.
> 
> I suspect that such a change in behaviour for "rebase -i" is not a
> fix but a regression.  Shouldn't it be consistent with checkout and
> merge?

My problem is that I don't really understand why some operations should 
overwrite ignored files and others shouldn't. Having nearly all rebase 
operations preserve ignored files and only overwriting them for a 
fast-forward seems confusing and probably surprising to users. Is it a 
bug that pull does not overwrite ignored files when fast-forwarding but 
merge does? Why is it ok to overwrite ignored files when merge 
fast-forwards but not otherwise?

>> It does seem like surprising behavior though when most
>> operations try to preserve untracked files.
> 
> Are you conflating untracked and ignored?
> 
> Because we haven't adopted 'precious' (or whatever the final name
> would be), which is "ignored but not expendable", ignored files are
> by definition "ignored and expendable".  

My confusion is that they are only "ignored and expendable" in certain 
circumstances. Many git operations actually fail if they are going to 
overwrite an ignored file [1] - I don't understand if that is 
intentional or not.

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/CAL_tzDFQQtDYMStN+RDVYN_TzJmO+kufMhG9PGHwvsUWREpgWQ@mail.gmail.com/

> When checkout (and merge
> that is its more general form) needs to match the working tree to
> the index contents and an ingored file is in the way, it should
> overwrite it.
> 
> Until we introduce "ignored but not expendable" class, that is.
> 
