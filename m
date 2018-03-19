Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50351F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbeCSNNe (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:13:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35180 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754996AbeCSNNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:13:33 -0400
Received: by mail-qt0-f195.google.com with SMTP id s2so2723064qti.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z+Ojkna6hgY8m/YeZ/pBY4nx+obtjhHTvbg9zI9o+HQ=;
        b=LgqeullZRVjh5w6QNTdZDpRLkx0i8vG32yuNdsauXMGG2rMWFUKKFRSxRsziSy+mz1
         DCkzaJ8UhGjb+41NjuWyRZoPL0OA/6oYKD8yIir33gIXstuFECRZMMuYolZwqR/ENhAN
         eOmWHZO7zESJMR4+Lv1mfNiY9RieVzRCd9q7xdZdROULQtwKVbCJXHKDHCNhj5ljFbTk
         8sk9uatfQy42IxTQLGH4M8ZIz61/3WmEFFeXPSxPKMYwIsnn4T9VpAn3l0v6/sbsKvVr
         9yi2BtXbfFaxWrb3mCRpdrXKffNHdqgdemyxGhRHJH60+8NhSz7NuAgo0liCi2NZyTB9
         sVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z+Ojkna6hgY8m/YeZ/pBY4nx+obtjhHTvbg9zI9o+HQ=;
        b=cKYpfUR5d7us0NYF8napkdB2DkZwAGiB9FkuSqhErRkGMsiCG0jb8zI2byWqJo/MDS
         WNkl458s9xHNpomV0CtvGXhf6EtLNkUOaiWbNvaShmxBBlXfSwYklzNNaxEx6TpzVBg1
         eW2DMuWqb3Cbuo7T4TdJMGheH3bgUGCjel4yFY6K4R3cFE/tVdFNeKxN2E8ZMWp1oj4m
         wK0vUOJypKMNmw1euaixMNb2XYCglGWxCdB5K4DsBc1EndEKv3f5szlr8l1RlRjZIo0p
         rfNs5c2Knei8zxDuQJ1v8DQmPF/eSCHAqRnM/6mqduTZrzAzRHGJaEDmuqCddFoEff65
         X3Mg==
X-Gm-Message-State: AElRT7Fl01X0ZB6bKRDFY6UxuUqf4FUv+ivfNiLJOd7L9oXi1Fkmmq8l
        m4fHjC0mQvmokY9wTk1BKXM=
X-Google-Smtp-Source: AG47ELs653ZgjuNpnPieHvvZmjWe5qkJ0qT231aVHeeUjYqDpgX1hjhulba+eOMitSUoXHOAGErhWQ==
X-Received: by 10.200.36.189 with SMTP id s58mr17859928qts.0.1521465212368;
        Mon, 19 Mar 2018 06:13:32 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id e127sm5398164qkc.60.2018.03.19.06.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:13:31 -0700 (PDT)
Subject: Re: [PATCH v6 12/14] commit-graph: read only from specific
 pack-indexes
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <20180314192736.70602-13-dstolee@microsoft.com>
 <CAM0VKjmwJYe01XBFeZaea=bzi+a_11MBvmqQN8GRWqZe8OTW7g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d76442f9-5f06-998b-8b2a-84b5ca118aaa@gmail.com>
Date:   Mon, 19 Mar 2018 09:13:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKjmwJYe01XBFeZaea=bzi+a_11MBvmqQN8GRWqZe8OTW7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2018 6:50 PM, SZEDER Gábor wrote:
> On Wed, Mar 14, 2018 at 8:27 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Teach git-commit-graph to inspect the objects only in a certain list
>> of pack-indexes within the given pack directory. This allows updating
>> the commit graph iteratively.
> This commit message, and indeed the code itself talk about pack
> indexes ...
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/git-commit-graph.txt | 11 ++++++++++-
>>   builtin/commit-graph.c             | 33 ++++++++++++++++++++++++++++++---
>>   commit-graph.c                     | 26 ++++++++++++++++++++++++--
>>   commit-graph.h                     |  4 +++-
>>   packfile.c                         |  4 ++--
>>   packfile.h                         |  2 ++
>>   t/t5318-commit-graph.sh            | 10 ++++++++++
>>   7 files changed, 81 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>> index 51cb038f3d..b945510f0f 100644
>> --- a/Documentation/git-commit-graph.txt
>> +++ b/Documentation/git-commit-graph.txt
>> @@ -32,7 +32,9 @@ COMMANDS
>>   'write'::
>>
>>   Write a commit graph file based on the commits found in packfiles.
>> -Includes all commits from the existing commit graph file.
>> ++
>> +With the `--stdin-packs` option, generate the new commit graph by
>> +walking objects only in the specified packfiles.
> ... but this piece of documentation ...
>
>> +               OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
>> +                       N_("scan packfiles listed by stdin for commits")),
> ... and this help text, and even the name of the option talk about
> packfiles.

Thanks! I'll fix that.

-Stolee
