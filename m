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
	by dcvr.yhbt.net (Postfix) with ESMTP id E28671F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfHZPJ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:09:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39564 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbfHZPJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:09:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so15690843wra.6
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=20Sc6sXtaQsUKLJTjG3aW6/pF8zQHUyxSdILqRKWv1Y=;
        b=AMjjKprhtz4QUhuXBH87t0BVH0BRY+y+g7ISdaJdD39qAXfQ2XtTk5QheP7P7vbh6a
         gfbAwFaz2CpxOfFPAXjrvJwMVXfeRjFSPdeQszZTUUX5Awt5afwCSOrsso0D5PmM2XJ7
         EctxsUjepappsIOXmBdNXv2LY1QgucJZtrm8UANKKtyb8uKwZY115kpa1EOIIh0FUZpL
         McPccoIthc357CxUuN2x4HsTuzvaaFM66x57Ll/gpHBZzw8oEXae7SSgiZQW9H6y85ix
         /26n9YqYM5wJdrR8TmxgBxG2UHCjYVg+qAHxdAp6GRSu6aiwVjuVZcphgUPs/HqCDEx/
         g6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=20Sc6sXtaQsUKLJTjG3aW6/pF8zQHUyxSdILqRKWv1Y=;
        b=RmxfblxXO5eXiUFnz8TPg4mJzWU5w5dFUtqRikqhiZeUkjeKDRTzC/gc3bPC4YvmrK
         lnT1D8zgWNpd1XLJBEDyA8+5pQsFknPKy1D4cFCTQ5UVNO/cBdufPNkaeUNPPPShWBvs
         V+2tkUUsQgw/JRISvLByAhTR1IHYVMqGLb0WUmQTcoFtKfJxYmng/5hvAZVn7EFdAteb
         pjC5LhBNNzE7PrsbFZ+IiRqX8Q3yH4eWbW/50KAmxpm7bvR9W+ban4efudHCfIQOjxts
         SXJzHXOvH5aMgJrGEZREAt2bDEMsxkCEDeM+HgklZH/20D4Vyzx7GqgzLHLPdZqc5l4I
         j8lA==
X-Gm-Message-State: APjAAAVseqfVKbTYBCJJL5FCptf4QExQVwhgIHHGQZQwwfJ21u/FWe8d
        rv0WN+LU1+mSxmeDJKiTr0k=
X-Google-Smtp-Source: APXvYqw2KoRLlWwQ3QQQULuQES0oqQd0VQ0N/RzeQA53RlY49OasNAsgfeLwxbBSRFzHDX5q901LwA==
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr23441970wrq.332.1566832164559;
        Mon, 26 Aug 2019 08:09:24 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-2-29.as13285.net. [92.22.2.29])
        by smtp.gmail.com with ESMTPSA id 91sm40687968wrp.3.2019.08.26.08.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:09:22 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
From:   Phillip Wood <phillip.wood123@gmail.com>
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
 <d59de3db-13e6-35d5-2cb1-b38dc8854c60@gmail.com>
Message-ID: <e8196c6e-7f3c-1b29-73ba-40094f1e0280@gmail.com>
Date:   Mon, 26 Aug 2019 16:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d59de3db-13e6-35d5-2cb1-b38dc8854c60@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/2019 19:32, Phillip Wood wrote:
> On 20/08/2019 19:24, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>>>> Do you know why -m and -i aren't affected?
>>>>
>>>> I had to look, but I believe the answer is because they use the
>>>> sequencer, and the sequencer calls git merge-recursive as a separate
>>>> process, and so the writing of the tree is only done in a subprocess,
>>>> which can't persist state.
>>>
>>> The sequencer has been running in a single process for a while now. We
>>> do fork for 'git merge' sometimes when processing 'merge' commands but
>>> 'pick' commands are all done in a single process by calling
>>> do_recursive_merge().
>>>
>>> Best Wishes
>>>
>>> Phillip
>>>
>>>> Should we move the merge-recursive code into the main process, we'll
>>>> likely have the same problem there.
>>
>> So we actually have the same issue already?
> 
> I don't think so, I modified Brian's test to call 'rebase -i' and it 
> passes but no one seems to know why.

I spent some time digging into this and the attributes are reloaded 
before each pick. This is because check_updates() called by 
unpack_trees() calls git_attr_set_direction(GIT_ATTR_CHECKOUT) at the 
start of the function and git_attr_set_direction(GIT_ATTR_CHECKIN) at 
the end of the function. This has the effect of dropping all loaded 
attributes as git_attr_set_direction() calls drop_all_attr_stacks() when 
the direction is changed.

Best Wishes

Phillip

> Best Wishes
> 
> Phillip
