Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9751F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfHTScG (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:32:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45628 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTScG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:32:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so13394295wrj.12
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iGlEBggCTP1Jw/Z8YvoJFU0tqdu9Kl5PMCqJHoj4oBQ=;
        b=Z3EOWYIsKF1WQ9zQrgHAKc6m+zYQBkwbBjmtOpcUlgvka50PIN1tmAjtxxdACl8TgJ
         GUlsGRLuLYC05tYHS5jHLlwMSw+lC3Bc2zGC5MaG0ymhiBD43JXkMfB6IEFThKL412cg
         B/7AZjjjZQbtf4PRDODo3yTPR8xgeFEnXmVN5ahl7E1G9LTPTdD9wEIBKPcVfvsE1Shl
         cfvBGC087YRbraoQr7vNEO6Fjo1RxMhQjAFiooqjMAPnWHELeSo6CUs28JUtfTDmfSK0
         J4chIH6HgzdFhyEIsPsnwXYsLPRQroqvN+LR5E8EmKjA1yHUYIIDAYoj01utrTZ7R8Qt
         GN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iGlEBggCTP1Jw/Z8YvoJFU0tqdu9Kl5PMCqJHoj4oBQ=;
        b=LBbLnQHq3rktlzmoiGVl6ec3IvQsiVpwxJ+SGgdXFVxq1f/htQCh96kvXxSZQgVVMI
         E6SeGr/G66TJKMD7c2vRvGMEslf4Yn60X4lfF0oJIxIyydz2jo1FqGV7AWe+Hers3b8H
         CAxSQxZ7AIp+Tb35WuSToElQN5t/9pyCD3cKZDuKpigoBGTsizIM/n5YoK+kJ722c+SB
         e2vwt9EtuUxcHuwPdRnFh0gjgwul3Ycc5/xwLXdiUmnNqR8YIz4e3THNI8Ah6USITrDT
         Q97FY/Dl9AZfgS5ERvwSPIruK9QYVQtLh/Xb5upTDwPHt0iIX8XMF6+Ai0liCrNEOmUv
         ZSPA==
X-Gm-Message-State: APjAAAWgG84pb1JLFxYaE24LIVDUjQ+/8PGhWsCsoLFZaiB6hQu3QjYU
        c8AjAMp2JirplHAFFgBV/9w=
X-Google-Smtp-Source: APXvYqyeRrZTZp7g88Vdsq4IsWKeohyoVgcs9W28CIUEdT14rycCs6NebLC9QldzRmNGbs1GHHyseA==
X-Received: by 2002:a5d:6742:: with SMTP id l2mr35404522wrw.70.1566325923884;
        Tue, 20 Aug 2019 11:32:03 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-13-95.as13285.net. [92.22.13.95])
        by smtp.gmail.com with ESMTPSA id d16sm16351063wrv.55.2019.08.20.11.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:32:03 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-3-sandals@crustytoothpaste.net>
 <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
 <20190820024505.GH365197@genre.crustytoothpaste.net>
 <18fcc7db-7c09-3fbf-1e3f-81be99f4bb17@gmail.com>
 <xmqqd0gzvgo3.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d59de3db-13e6-35d5-2cb1-b38dc8854c60@gmail.com>
Date:   Tue, 20 Aug 2019 19:32:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0gzvgo3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/2019 19:24, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>> Do you know why -m and -i aren't affected?
>>>
>>> I had to look, but I believe the answer is because they use the
>>> sequencer, and the sequencer calls git merge-recursive as a separate
>>> process, and so the writing of the tree is only done in a subprocess,
>>> which can't persist state.
>>
>> The sequencer has been running in a single process for a while now. We
>> do fork for 'git merge' sometimes when processing 'merge' commands but
>> 'pick' commands are all done in a single process by calling
>> do_recursive_merge().
>>
>> Best Wishes
>>
>> Phillip
>>
>>> Should we move the merge-recursive code into the main process, we'll
>>> likely have the same problem there.
> 
> So we actually have the same issue already?

I don't think so, I modified Brian's test to call 'rebase -i' and it 
passes but no one seems to know why.

Best Wishes

Phillip
