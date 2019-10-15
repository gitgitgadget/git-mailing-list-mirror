Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4E31F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 19:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389269AbfJOTHn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 15:07:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37415 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfJOTHm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 15:07:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so13081703pfo.4
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tI0ZU6SnPrwynbQk78Vg4KePXmxPPI3dvLORb2Zcqzo=;
        b=mAqqT1Gw1sTcosl54bAdY6KAPXJlnbc9d1qBJik/Ibqr8PrZ7yD+PxJA27lYc5x8Ay
         0/SKAgHSHrqwDdONU9uciChz1gRHZ1aSNpJV+xQ5rhwg2/CWfeitTnkj1vu1+dP2bzQK
         fWeBkAXxClq6Q2vQQYJ3yiN4mZ0Xm0j3162cZdIgWXWE+sxbaBXheGJHBRC0Mek+raAy
         5j7ln3wNPp3JKaEizyT5uES0yaDN0Y5r222SwyCc0MU39pp/OGP9zmkU76/XColgxcPe
         tLXLiXj0MJuGBidlDN2BJPcHB0Lf7aC2SIo1LslqWIYefQtKgIWauqirUNo/5flKbwbb
         5ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tI0ZU6SnPrwynbQk78Vg4KePXmxPPI3dvLORb2Zcqzo=;
        b=hRv/V0m2hBY5xih5AnKa4eo0bFdnGEbVYd37MG3JMlPiuGTGY5VU7S0XS8AQH1FN7r
         jdam/hV82fDNNk29ujNEA+OXTzKDdpBp/rhPm17YSlP88YitBAD0b5jBip9jOT1uLADS
         zCSYBwXPOp/c6t8HKiRWeFi8obchXt5TXDaCzCiW6MhtqySMsGMd8SfNST1h9C4T9sAp
         7EsTZH0T4TJ8cFbHExV2/N0Qn12Z6Uow6As/6Qd6AKlF8zTCKzCbeWmkHZAvU1SSIetS
         YExpk6rrkyqYGeh/eNG7WiQG596+rz2Qpsb4686VDx1HawHU5nD0Y2EetKvnBJPYUAr9
         xr1Q==
X-Gm-Message-State: APjAAAVMeXgMEAnkgLq62qjAj6w/qLZw4Cw7hbXWnqKGqZBJf1ydz1hZ
        EdLV9T11BkkZr30RsCCwlSS+/gj6
X-Google-Smtp-Source: APXvYqwbMxBPPSTM9T97Nal+ObkU1LprmarvSjK1H+K9Xd4mi/9q2wRhl7U7VT2NUrasPrQvssTp6Q==
X-Received: by 2002:aa7:90da:: with SMTP id k26mr39794718pfk.145.1571166462251;
        Tue, 15 Oct 2019 12:07:42 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:8:edf0:7ee7:ed2b:8e04])
        by smtp.gmail.com with ESMTPSA id 62sm24986564pfg.164.2019.10.15.12.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 12:07:41 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] fsmonitor: don't fill bitmap with entries to be
 removed
To:     Junio C Hamano <gitster@pobox.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, Johannes.Schindelin@gmx.de,
        jeffhost@microsoft.com, William Baker <William.Baker@microsoft.com>
References: <pull.372.v2.git.gitgitgadget@gmail.com>
 <pull.372.v3.git.gitgitgadget@gmail.com>
 <840972e08b2178e89b2c3ed77eb20c91ead894ad.1570824681.git.gitgitgadget@gmail.com>
 <xmqq1rvig3fb.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <3d3b290c-bc15-4bd5-e0c0-1377c9ec3ff9@gmail.com>
Date:   Tue, 15 Oct 2019 12:07:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rvig3fb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/19 6:26 PM, Junio C Hamano wrote:
> "William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +# Test staging/unstaging files that appear at the end of the index.  Test
>> +# file names begin with 'z' so that they are sorted to the end of the index. 
> 
> Well, the test is now done in a freshly created repository, so the
> z* files are the only thing you have in here---technically they are
> at the end of the index, but so they are at the beginning, too.
> 

There is one other file in the index created by 'test_commit', however,
the point still stands that there are almost no other entries in the
index now that the test is using its own repository.

> Would it affect the effectiveness of the test that you do not have
> any other paths in the working tree or in the index, unlike the test
> in the previous rounds that did not use a newly created test
> repository?  

The test still validates the scenario that we're concerned about,
namely that the new index that's written has less entries than
the index of the last entry in the old index that's is not flagged
with CE_FSMONITOR_VALID but is flagged for removal (CE_REMOVE).

> This is not a rhetorical question, but purely asking. "no, this
> still tests what we want to test and shows breakage when the fix to
> the code in the patch gets reverted" is perfectly a good answer, but
> in that case, is "the end of" the most important trait of the
> condition this test is checking?  Wouldn't the bug be exposed as
> long as we remove sufficiently large number of entries (like
> "removing more paths than the paths still in the index at the end"
> or something like that)?

This is exactly right.  The most important trait is that the last
entry flagged with CE_REMOVE does not have CE_FSMONITOR_VALID set
and has an index >= the number of entries in the new index being
written.

I will send out a patch on top of 'wb/fsmonitor-bitmap-fix' with
an update to the comment for this test.

Thanks,
William
