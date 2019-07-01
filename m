Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 992581F461
	for <e@80x24.org>; Mon,  1 Jul 2019 12:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfGAMa7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 08:30:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45507 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfGAMa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 08:30:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so14359791qtr.12
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 05:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sD6yzXr5EgqkpisDybDkrc1mSXi6P4ENy++zccyXzHc=;
        b=FB6Jj3tpB4LBYySoqhuHCFSV48cK+FSw7N7KVa6m3dzqynomO1FwHLiXf/FOnkMmHw
         de8cZeRvdJVCcSMmKuD5U0XLYKnzcK0X+W8jltPVgS5qhoKDA2ucKxJJ4PeZpLGL9i99
         kWL3zU9ghTsw7qAb4ycSKzNRPop6fFK6xjZTOnWF3vRKTzBc8L7yeGfdE2sDOmH2FBD9
         nuC/kaCmwoiVInJArkgUA7lM/KCdj0JYX+ScvYBsoRAtLpcv4EPtDUmd3a4smWQo9LEP
         gA86YTNBBZGVRXa8isso5JGRtIkhSXfZzbXY9xk27U5NEtu+a7L678N5Y1ehET/nkDC2
         jVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sD6yzXr5EgqkpisDybDkrc1mSXi6P4ENy++zccyXzHc=;
        b=te5XD5KIaUHNBy3s5bF85dpd0kO4pNmn5MiKUz0QilNiEx3MAn8v7vY4Si9c2kTnf/
         z6E71p3gHi2K07M8B0T4AFtQ5WkS9lkq9VNC3UXI1siTLOFSM9bTWe3bmJYIk1QW7FEO
         IufTas2ZSTLEsP5iBpli5jCAI1QMo83qL32LcJX4RP8yL0uVzRBMrgl+JHcZJmIndJNt
         n87YfkLZH7Mp99/Lo2FwqPIWJnvzOmrb/a2fqdSXvjtyJF4T5LmXvvN6p8nCqcGzjbHl
         nDkgpjPLHiwoh3RFoKnMiDEyY3DMfS/lA8aCcPr4B2U9c+qdDWebTxF8g3Y3V0ClWKdk
         A5vw==
X-Gm-Message-State: APjAAAUoXpR8k+gQSGEe2i6ISFmtEKNFgAmolWWywYbsibTzleI3zYSh
        DFTeMLSxRozySRC9JrSkN/s=
X-Google-Smtp-Source: APXvYqz3rdlszIRqqzYHyUyHD3mMHg/2W/Ry7JkIuLWCBjhhxe/hDFkpbh0aPgB3Fz+G5jixLxgwcg==
X-Received: by 2002:ac8:156:: with SMTP id f22mr19858703qtg.58.1561984257969;
        Mon, 01 Jul 2019 05:30:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8d39:716e:a6fa:35c4? ([2001:4898:a800:1012:3e6d:716e:a6fa:35c4])
        by smtp.gmail.com with ESMTPSA id w19sm4497236qkj.66.2019.07.01.05.30.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 05:30:56 -0700 (PDT)
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
 <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
 <20190630222537.GA21696@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1907011409420.44@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b1f6a752-6edd-d86c-7d69-7624a2c5407f@gmail.com>
Date:   Mon, 1 Jul 2019 08:30:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1907011409420.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/1/2019 8:11 AM, Johannes Schindelin wrote:
> Hi Peff,
> 
> On Sun, 30 Jun 2019, Jeff King wrote:
> 
>> On Sun, Jun 30, 2019 at 10:59:34PM +0200, Johannes Sixt wrote:
>>
>>> Am 30.06.19 um 21:48 schrieb Eric Sunshine:
>>>> On Sun, Jun 30, 2019 at 2:57 PM Johannes Sixt <j6t@kdbg.org> wrote:
>>>>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>>>>> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
>>>>> -               MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
>>>>> +               MINSIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 1) &&
>>>>
>>>> Unfortunately, this is not portable. While "stat -c %s" works on Linux
>>>> and MSYS2, neither that option nor the format directive are recognized
>>>> on BSD-like platforms (I tested Mac OS and FreeBSD), which instead
>>>> need "stat -f %z".
>>>
>>> Ouch! I did notice that stat(1) is not in POSIX, but hoped that it was
>>> sufficiently portable. I need a new idea...
>>
>> If we are OK relying on rudimentary perl[1], then:
>>
>>   perl -le "print((stat)[7]) for @ARGV"
>>
>> works. If you want it more readable, then maybe:
>>
>>   perl -MFile::stat -le "print stat(\$_)->size for @ARGV"
> 
> Or we stop introducing new Perl calls, and use the perfectly fine
> `test-tool path-utils file-size` command:
> 
> https://github.com/git/git/blob/v2.22.0/t/helper/test-path-utils.c#L302-L312
> 
> This solves not only portability problems but also avoids yet another
> obstacle into making a `NO_PERL` test suite run really work without Perl.
Thanks! This does seem like the best option. Thanks for bringing this to our
attention. Here is a diff, and I'll prepare a full patch:

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index dd6083e61a2..5379e59168a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -447,7 +447,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
                touch -m -t 201901010002 .git/objects/pack/pack-B* &&
                touch -m -t 201901010003 .git/objects/pack/pack-A* &&
                ls .git/objects/pack >expect &&
-               MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
+               MINSIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 1) &&
                git multi-pack-index repack --batch-size=$MINSIZE &&
                ls .git/objects/pack >actual &&
                test_cmp expect actual
@@ -459,7 +459,7 @@ test_expect_success 'repack creates a new pack' '
                cd dup &&
                ls .git/objects/pack/*idx >idx-list &&
                test_line_count = 5 idx-list &&
-               THIRD_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 3 | tail -n 1) &&
+               THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
                BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
                git multi-pack-index repack --batch-size=$BATCH_SIZE &&
                ls .git/objects/pack/*idx >idx-list &&

Thanks,
-Stolee
