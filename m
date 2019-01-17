Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9E91F453
	for <e@80x24.org>; Thu, 17 Jan 2019 15:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfAQPJV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 10:09:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36935 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfAQPJU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 10:09:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id g125so6169868qke.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 07:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nkyu4qZXYeFuLeyZhbH17NtCGxdVaO2+y1l7f36oeio=;
        b=SvjDW6pmZiwF5q00+tLg0riEExc7DFNTz/bllRp7bRLaPzLtIjqZdYsVfEXuD1sYly
         A8W3jeVeVsT8J08CMgU2A83PfcvsnfK4zhUnf2BtQtN8V9KjVm4zczpFJYAa+0jb0hCy
         idW4rciw1Jzc5JfFG2L4Bn9ISIlGHKC2gThEwNP//X8Pc+P0WaZthj8OdOxS2hht4k8S
         kn58By0Jr8jgUXLrhlI02Jlh4CPDB4iUqjKkVRPTEwkxyDu1p7qTAGJ+fvIs4GwDi0Qz
         zphsAwZ8m0bh+LYdD6YHp0Pnw0ChmuQuu+tJ8AKUPSGHEz0TvFGhxEsbjjicmwBvdSmR
         ezZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nkyu4qZXYeFuLeyZhbH17NtCGxdVaO2+y1l7f36oeio=;
        b=I2RQ/2c77sPOtj+4aL+y2QL6nS5LhNtWAmrPDptGZ4tOokI65lOBjRA1MFSvoEtGrt
         htMRfxU4X6XQ0uNznyWYieigv7DK6hrURpjQ3X7aT88KInBLqkvE48pQlQaE2sE+89m6
         hkojAR9lu39HQ2GEe0TEIcjkxq1cBqDs7KYmldCY2aXz0d2O54y/HpZm2oZ47pUVlQi6
         UvQjpJco4c9FEsQghs/Bc6QUU3i1S0Ri01JWJ4/MrK8NsuuDs67fQ0wWIcWUBycXBSUk
         QLDE6Ron8BDfY59QhIEVbQs/1qhy0+KPsSlGFoiBrIsm6HkKR32Kpxk8BK6zhGIyA0P1
         x+sg==
X-Gm-Message-State: AJcUukdIpzaFajoEiWmH/+QCQgZ+QoTLu28AJbWYwJi+kfzwGZ2iKXW1
        zB1P31RhXGhiltSXgHCK0bM=
X-Google-Smtp-Source: ALg8bN7EYnkl5RCsFV3SExNut6N8ir+SzGfQfkNxHoQy3LM/l5rJ++SsmSl+t2KtneoNgl3wV2vtOA==
X-Received: by 2002:a37:688c:: with SMTP id d134mr11360167qkc.57.1547737759322;
        Thu, 17 Jan 2019 07:09:19 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c447:1d70:84f9:bac9? ([2001:4898:8010:0:ad7d:1d70:84f9:bac9])
        by smtp.gmail.com with ESMTPSA id o48sm57051766qtb.87.2019.01.17.07.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 07:09:18 -0800 (PST)
Subject: Re: [PATCH] commit-graph write: use pack order when finding commits
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20190116132947.26025-10-avarab@gmail.com>
 <20190117132345.29791-1-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5b1146a1-9ec6-f30e-80e9-cb7cd4dc1a58@gmail.com>
Date:   Thu, 17 Jan 2019 10:09:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190117132345.29791-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2019 8:23 AM, Ævar Arnfjörð Bjarmason wrote:
> Slightly optimize the "commit-graph write" step by using
> FOR_EACH_OBJECT_PACK_ORDER with for_each_object_in_pack(). See commit
> [1] and [2] for the facility and a similar optimization for "cat-file".
>
> On Linux it is around 5% slower to run:
>
>      echo 1 >/proc/sys/vm/drop_caches &&
>      cat .git/objects/pack/* >/dev/null &&
>      git cat-file --batch-all-objects --batch-check --unordered
>
> Than the same thing with the "cat" omitted. This is as expected, since
> we're iterating in pack order and the "cat" is extra work.
>
> Before this change the opposite was true of "commit-graph write". We
> were 6% faster if we first ran "cat" to efficiently populate the FS
> cache for our sole big pack on linux.git than if we had it populated
> via for_each_object_in_pack(). Now we're 3% faster without the "cat"
> instead.
>
> The tests were done on an unloaded Linux 3.10 system with 10 runs for
> each.
>
> 1. 736eb88fdc ("for_each_packed_object: support iterating in
>     pack-order", 2018-08-10)
>
> 2. 0750bb5b51 ("cat-file: support "unordered" output for
>     --batch-all-objects", 2018-08-10)
Thanks, Aevar! I plan to give this a test on the Windows repository, as 
this is the way we generate the commit-graph in VFS for Git.

I created a PR on microsoft/git [1] and am generating the installers now [2]

[1] https://github.com/Microsoft/git/pull/110

[2] https://dev.azure.com/gvfs/ci/_build/results?buildId=6114

The code itself looks good, I just need to double-check the performance 
numbers.

Thanks,
-Stolee
