Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9910F1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 13:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeJ2WDk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 18:03:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36949 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJ2WDk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 18:03:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id 131so4836045qkd.4
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WDtJcQ3pS1OzU1Jr7NYd9A7OT4WcRtZiANN+UCT2gvk=;
        b=oocIrZ7ZaizfLyRUEzTa1uGsL9iA3wdJs/MomheOq+xizZJJ7/5dH7xD0QLCTcYHf6
         XPlLkavSnzAFNY5DdICKn9QCWzxyPYU2218H4OnukjWq4y54QMeTfGxipl8dzx8b6H9w
         kWjo6gbH7OHihrVa3iKQaep+ZCKCAMkXzyvyzqXSp44YcTx3VJv1/1QUbahEYPsDqa46
         jMvpWom7ViPoJb3O56DMnLmeDbChPRUwOpMJZW+kreswJMWG43PN5WbdzYtLSIdiiSvP
         zYBP+k+fQ9hJSvLoUOMOjTBiQULFYZ8XG+eshwNV/L0Z6NN0IdbIvhg6X8IEi0O6eE6i
         Jg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WDtJcQ3pS1OzU1Jr7NYd9A7OT4WcRtZiANN+UCT2gvk=;
        b=uQLKKvMrUUhz+o/XnX2n+VBs/dCftof3sDMqt/X3aH+aLsHy041lxrV7SV9grth1sm
         dJGs1sL2rTs8/GGrkAQ25Z50+KUpQCxaAZVhoWLypmGiXJ/B6XMi+/FTCNgpCDzIHaWt
         +ORrwleI1DTO4RACB0f0CuffgAqdjF3VK5JQuWGKr9cFjNJ01MfZ4juzbsMmj7DfNb/8
         5QJ8Ff1WipuBzsb43qbuta2RAN7rNbmDXFymYzrhKW32cala6lhkWiTRAJXwM/IOqUMe
         mnHXkA6tLL4opPapxm4R4YwYZjCF3uY6FRJq5Yr3D991zEiBXwqBuIhFXKwqo9YJlgXz
         neMA==
X-Gm-Message-State: AGRZ1gJmkIoTarWWXWWhxLTbUvKjiuUDiXACxBdj+BFh2MDuktIubUm3
        8MHoRX3xWCTHMTAFjvEhaiM=
X-Google-Smtp-Source: AJdET5e8d/6Il+fu7FSao9tiA3b54SM4vP9IPEND3cwKm5raVpZOBhcU8UVgkwRAOpupZUSFez9jeQ==
X-Received: by 2002:a37:8d4:: with SMTP id 203mr4541411qki.338.1540818901597;
        Mon, 29 Oct 2018 06:15:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f97c:d233:17ff:d619? ([2001:4898:8010:0:e2b2:d233:17ff:d619])
        by smtp.gmail.com with ESMTPSA id s21-v6sm16405323qth.11.2018.10.29.06.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 06:15:00 -0700 (PDT)
Subject: Re: [PATCH] packfile: close multi-pack-index in close_all_packs
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com
References: <20181025111557.GL30222@szeder.dev>
 <20181025125405.30351-1-dstolee@microsoft.com>
 <20181029111041.GQ30222@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cf5a9e5e-ac75-1ba2-fda4-9776a90f6968@gmail.com>
Date:   Mon, 29 Oct 2018 09:15:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181029111041.GQ30222@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/29/2018 7:10 AM, SZEDER Gábor wrote:
> On Thu, Oct 25, 2018 at 12:54:05PM +0000, Derrick Stolee wrote:
>> Whenever we delete pack-files from the object directory, we need
>> to also delete the multi-pack-index that may refer to those
>> objects. Sometimes, this connection is obvious, like during a
>> repack. Other times, this is less obvious, like when gc calls
>> a repack command and then does other actions on the objects, like
>> write a commit-graph file.
>>
>> The pattern we use to avoid out-of-date in-memory packed_git
>> structs is to call close_all_packs(). This should also call
>> close_midx(). Since we already pass an object store to
>> close_all_packs(), this is a nicely scoped operation.
>>
>> This fixes a test failure when running t6500-gc.sh with
>> GIT_TEST_MULTI_PACK_INDEX=1.
>>
>> Reported-by: Szeder Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>
>> Thanks for the report, Szeder! I think this is the correct fix,
>> and more likely to be permanent across all builtins that run
>> auto-GC. I based it on ds/test-multi-pack-index so it could easily
>> be added on top.
> OK, avoiding those errors in the first place is good, of course...
> However, I still find it disconcerting that those errors didn't cause
> 'git gc' to error out, and, consequently, what other MIDX-related
> errors/bugs might do the same.
When I added GIT_TEST_MULTI_PACK_INDEX, one of the important pieces was 
to delete the multi-pack-index file whenever deleting the pack-files it 
contains. This only happens during a 'git repack'.

The thing I had missed (and is covered by this patch) is when we run a 
subcommand that can remove pack-files while we have a multi-pack-index open.

The reason this wasn't caught is that the test suite did not include any 
cases where the following things happened in order:

1. Open pack-files and multi-pack-index.
2. Delete pack-files, but keep multi-pack-index open.
3. Read objects (from the multi-pack-index).

This step 3 was added to 'git gc' by the commit-graph write, hence the 
break. The pack-file deletion happens in the repack subcommand.

Since close_all_packs() is the way we guarded against this problem in 
the traditional pack-file environment, this is the right place to insert 
a close_midx() call, and will avoid cases like this in the future (at 
least, the multi-pack-index will not be the reason on its own).

Thanks,
-Stolee
