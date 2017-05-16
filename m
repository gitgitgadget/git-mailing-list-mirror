Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0EAE1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbdEPRR7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:17:59 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36418 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdEPRR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:17:58 -0400
Received: by mail-qk0-f195.google.com with SMTP id y128so23765358qka.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=8t5gFnW9Z/amDbTUMTkKyC/I/gElB+Tpl3GODebvuB8=;
        b=lG7SvovOZT1AetS/HVoXxiyrYIOiVJHUaRSnrTGU6W4+KWaGSR1a3X8Uwu9swhprhu
         +f+iwcHl/mwPgg0mHOUI+WXcV9rZzLOZTkjMwmXSM2NccH/Lcpb19lVUMXMsR6jbtENo
         VRre2HMT+PRjbiocpJZDW11UPmCsABU2fesCziCcBtVHu+XGJXr7zlMG7V64GHQ1c3Ac
         sA1SipcaWBKxRZvajQShC/GwF+muxYpGb0xR34PHo4d5ul/Mc2p9YTS1Xlgr4dMTpSp3
         wFOWffNoSZroCjSv3oTxKEMzV3n9rt9fkNraXE4kqfQg44gcvWMP204XxxEI3zaeuTnA
         DnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8t5gFnW9Z/amDbTUMTkKyC/I/gElB+Tpl3GODebvuB8=;
        b=badPeZoiNVjemR1fv3DZAYjMg/iFm/N6ds1n3SNGobKIC8FHd4fNdYlRCZiTyDCbtj
         Mux+gTpvmdIerf05TkhdAVTY3SbAi+TD9QIOlf2ve9Nlx7lNS0E+lUyIyxg2A0SoWLfb
         1wiLAIwjOGBbWakCsm7/GRcrFIRDZXi8eJrAgmDNKTm3Ll+2kcLp8tC/iWFq8bO0W5Xw
         d/sJeqm3iX/bIp4+EwgCDd8Q6uO3n9gL3Ii1E6ZhtjpSgWGjgi8EyalBiJJaiDAdMifg
         QG9TCksmlxyK6CUJ9P04U8ONtqKEjA/e+KjPWDLzhRJ36UU/e8www81Jn7wT51XayXsR
         dqCg==
X-Gm-Message-State: AODbwcCc8fiQDEJLL0/1eT1MUgClcR4+CPwhIXy4ZrlQYrqbjRmX0kzi
        SA6qmCIl8aehOw==
X-Received: by 10.55.168.86 with SMTP id r83mr10423344qke.97.1494955077229;
        Tue, 16 May 2017 10:17:57 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d14sm1291980qka.7.2017.05.16.10.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 10:17:56 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, johannes.schindelin@gmx.de,
        David.Turner@twosigma.com
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
 <20170516003414.yliltu5fsaudfhyu@sigill.intra.peff.net>
 <2d965a87-36da-23b4-4bc5-97de47f3d7f7@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <29122818-71fb-5af9-59b1-03387f014151@gmail.com>
Date:   Tue, 16 May 2017 13:17:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <2d965a87-36da-23b4-4bc5-97de47f3d7f7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/15/2017 9:55 PM, Ben Peart wrote:
>
>
> On 5/15/2017 8:34 PM, Jeff King wrote:
>> On Tue, May 16, 2017 at 12:22:14AM +0000, brian m. carlson wrote:
>>
>>> On Mon, May 15, 2017 at 03:13:44PM -0400, Ben Peart wrote:
>>>> +    istate->last_update = (time_t)ntohll(*(uint64_t *)index);
>>>> +    index += sizeof(uint64_t);
>>>> +
>>>> +    ewah_size = ntohl(*(uint32_t *)index);
>>>> +    index += sizeof(uint32_t);
>>>
>>> To answer the question you asked in your cover letter, you cannot write
>>> this unless you can guarantee (((uintptr_t)index & 7) == 0) is true.
>>> Otherwise, this will produce a SIGBUS on SPARC, Alpha, MIPS, and some
>>> ARM systems, and it will perform poorly on PowerPC and other ARM
>>> systems[0].
>>>
>>> If you got that pointer from malloc and have only indexed multiples of 8
>>> on it, you're good.  But if you're not sure, you probably want to use
>>> memcpy.  If the compiler can determine that it's not necessary, it will
>>> omit the copy and perform a direct load.
>>
>> I think get_be32() does exactly what we want for the ewah_size read. For
>> the last_update one, we don't have a get_be64() yet, but it should be
>> easy to make based on the 16/32 versions.
>
> Thanks for the pointers.  I'll update this to use the existing get_be32
> and have created a get_be64 and will use that for the last_update.
>

OK, now I'm confused as to the best path for adding a get_be64.  This 
one is trivial:

#define get_be64(p)	ntohll(*(uint64_t *)(p))

but should the unaligned version be:

#define get_be64(p)	( \
	(*((unsigned char *)(p) + 0) << 56) | \
	(*((unsigned char *)(p) + 1) << 48) | \
	(*((unsigned char *)(p) + 2) << 40) | \
	(*((unsigned char *)(p) + 3) << 32) | \
	(*((unsigned char *)(p) + 4) << 24) | \
	(*((unsigned char *)(p) + 5) << 16) | \
	(*((unsigned char *)(p) + 6) <<  8) | \
	(*((unsigned char *)(p) + 7) <<  0) )

or would it be better to do it like this:

#define get_be64(p)	( \
	((uint64_t)get_be32((unsigned char *)(p) + 0) << 32) | \
	((uint64_t)get_be32((unsigned char *)(p) + 4) <<  0)

or with a static inline function like git_bswap64:

or something else entirely?

I'm not sure why the different styles in this one file and which I 
should be emulating.


>>
>> (I note also that time_t is not necessarily 64-bits in the first place,
>> but David said something about this not really being a time_t).
>>
>
> The in memory representation is a time_t as that is the return value of
> time(NULL) but it is converted to/from a 64 bit value when written/read
> to the index extension so that the index format is the same no matter
> the native size of time_t.
>
>> -Peff
>>
