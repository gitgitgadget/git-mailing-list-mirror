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
	by dcvr.yhbt.net (Postfix) with ESMTP id F062D201A7
	for <e@80x24.org>; Wed, 17 May 2017 14:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbdEQO0L (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 10:26:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33700 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbdEQO0J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 10:26:09 -0400
Received: by mail-qt0-f194.google.com with SMTP id a46so1751383qte.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=yRXLfAT38hxzLf4A20/5fHrq7AIUFENImmOljzGCmo8=;
        b=N12HZAFGdIAf5uEnfz3ZMufuH7RuwFoMJ4P24HzKKOJebsPBVSRmkc4bDuB4XxjI5E
         +c1NILn26HJuh3gNyKJnKS31Qk0KXx/EKvCiqJAEeo+PWzRXughndRnxA5gMdLqrjAi0
         hjL23hXakF1rPdMtwjwiFhIPDR+Alyph46tmVMWsgPVpKm3+TSSRY0ZHMyz5KIYNa6n3
         wq8Xk/eBivPetcQ/X/KN22G0UIMR4XhSWjsFhKeBCmk8l8RmekVJ57uqZP8tNlcMo34u
         OSr8NGgzCEdrl2Tka5U4c0bSVY6bCv4tFF4pxMC11+nvsX49C5zF3GynuvQhZkobwL6f
         /Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=yRXLfAT38hxzLf4A20/5fHrq7AIUFENImmOljzGCmo8=;
        b=R3MVlt8GasrbV+n59UImIrPPPqQpnTNVGDTE9VxUFYAqdIbh6sUMz1Md3qGBaQ5E3P
         LJt9VJXpo4bdgLkdb+rF8cAAZBPJ7dAyFB2M5hUYqtaeWH4IAfv4wIe7TYA2nnnCgSbC
         rOK3VyRdGpYMsPeKTYBo199ihWL+X5fJUSx/lzPmolUQm592bX/QP1G0wWiW1kJB6FXA
         L0WyL2Mm36sY/O1MEsXvORD2/D8vLUaaaGiQKxRQONj28uH+SE9cCOjelbc4mSgwD9Ap
         mJZD0eGGQf8ET/UjDPx8Ledydr9foB6Ci86QYbg/AoQF199ZQ6n4Lx4kDXdjcShNI+LV
         Obgw==
X-Gm-Message-State: AODbwcBcC3OVxzykkLY6kr73pVffaxp7GswJfgkIGREkm44iqpcw4Ymi
        KRdnZgda++Ft6A==
X-Received: by 10.200.9.76 with SMTP id z12mr3647290qth.102.1495031169063;
        Wed, 17 May 2017 07:26:09 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s32sm1485983qtg.2.2017.05.17.07.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 May 2017 07:26:08 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
To:     Johannes Sixt <j6t@kdbg.org>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
 <20170516003414.yliltu5fsaudfhyu@sigill.intra.peff.net>
 <2d965a87-36da-23b4-4bc5-97de47f3d7f7@gmail.com>
 <29122818-71fb-5af9-59b1-03387f014151@gmail.com>
 <134ea57f-3a64-f7b5-67dd-8b14ff3cc04a@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, johannes.schindelin@gmx.de,
        David.Turner@twosigma.com
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0a3f38b7-788b-b364-3fef-83191e4b9bea@gmail.com>
Date:   Wed, 17 May 2017 10:26:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <134ea57f-3a64-f7b5-67dd-8b14ff3cc04a@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/16/2017 3:13 PM, Johannes Sixt wrote:
> Am 16.05.2017 um 19:17 schrieb Ben Peart:
>> OK, now I'm confused as to the best path for adding a get_be64.  This
>> one is trivial:
>>
>> #define get_be64(p)    ntohll(*(uint64_t *)(p))
>
> I cringe when I see a cast like this. Unless you can guarantee that p is
> char* (bare or signed or unsigned), you fall pray to strict aliasing
> violations, aka undefined behavior. And I'm not even mentioning correct
> alignment, yet.
>
> -- Hannes

Note, this macro is only used where the CPU architecture is OK with 
unaligned memory access.  You can see it in context with many similar 
macros and casts in bswap.h.  It's outside the scope of this patch 
series to fix them all.  Perhaps a separate patch series?
