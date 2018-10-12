Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE021F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 15:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeJLWpg (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 18:45:36 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:46063 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeJLWpg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 18:45:36 -0400
Received: by mail-qt1-f180.google.com with SMTP id e10-v6so14155107qtq.12
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Zbe2GV3I5FyXVqKC7b2AKdQuJ4qpURLsbPxUj/4uFRw=;
        b=a5q5vZOLNUqdGqnuNTtbGrb7Lt8/MFdpuu0QQoALPnGy1xnZ6c2Ldn6s213p+Y69sT
         PNZYy5EnySHAvYeSH0rN2/4qJKcWB+o8nqLzryu1EI8Izd6IGTxtNiw0umAdfntjyHs/
         2ZEpFgr5+UIB+yeMZj2HoKiCvHVXlZMnzMozZancTKVfIPJ6caDP4Bj22kKtNj54nicv
         mxIVr1wyZCrVZYUb4ZZuZFV7yLohhpOT9oKb9moK5cLojCbfnEhymKFoZInirLpCht56
         cJaIiafRcMZbifZglEVcGi9upyApCfyREQe30Fm9f9t6fditSYFEbedp8kQkYlowY2A8
         LFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zbe2GV3I5FyXVqKC7b2AKdQuJ4qpURLsbPxUj/4uFRw=;
        b=k+KismhoYa9AfcTTliQ2/1IF/MKVjGGnpHkx50Ow2cyLVm47NlFkh7aiCVFAj/4M1E
         cCzhlb8gZ+Ii1iJTKecwNv8dcwiJ7rQyRoqZ/R9yC7e1AjhXpb7hs61WZUDCnJyyFLhk
         jt06KYjBlKVu8yvM9pTXsXXQvNVq+N50HNsaMlVpYt6m7FpQWfKZ25zDbrKGtxpQJv0O
         A+CXqozCsuuKnkkTcMbWdAHSz4JTQoDDNzMvLQ2FDb1TYOkfckP4osXovixMBhgsLbp4
         4KoL8TwCIK51pCReAAqhD+d/gyehIw0jIsfxQ3+6dh1HULTsDdc4qKmKXHYaFG/SukxY
         xBng==
X-Gm-Message-State: ABuFfoiBfYqVjW42/niJXUzayIAXwnyt+rMW6GkNqha+x7ZMYIZNR5Oh
        D783CswEGPP6S3gIX8JhIgk=
X-Google-Smtp-Source: ACcGV62wnRwBW5KCsrDjpFrW2lKtzrrEspyklrbNzrzft1V9rzIdENrGS22xsWAxg7qEe/2K9nvVzA==
X-Received: by 2002:a05:6214:88:: with SMTP id n8mr6234567qvr.176.1539357160956;
        Fri, 12 Oct 2018 08:12:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e9ec:1ddb:856c:2858? ([2001:4898:8010:0:d322:1ddb:856c:2858])
        by smtp.gmail.com with ESMTPSA id v5-v6sm662083qkf.26.2018.10.12.08.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:12:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
 <20180917153336.2280-2-avarab@gmail.com> <20181010203738.GE23446@szeder.dev>
 <xmqqa7njd7bi.fsf@gitster-ct.c.googlers.com>
 <877eindx03.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f7a0cbee-863c-61d3-4959-5cec8b43c705@gmail.com>
Date:   Fri, 12 Oct 2018 11:12:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <877eindx03.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2018 11:07 AM, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Oct 12 2018, Junio C Hamano wrote:
>
>> Makes sense. If this second iteration were also time consuming,
>> then it probably is a good idea to split these into two separate
>> phases?  "Counting 1...N" followed by "Inspecting 1...N" or
>> something like that.  Of course, if the latter does not take much
>> time, then doing without any progress indicator is also fine.
> That's a good point. Derrick: If the three loops in close_reachable()
> had to be split up into different progress stages and given different
> names what do you think they should be? Now it's "Annotating commits in
> commit graph" for all of them.

The following is the best I can think of right now:

1. Loading known commits.
2. Expanding reachable commits.
3. Clearing commit marks.

-Stolee
