Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90EC1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 19:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeJSDF7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 23:05:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34879 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSDF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 23:05:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id z7-v6so3200034qts.2
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KHwxClvR/QV+aucNk9MngTXTJ9hZ935W2GKqdLukKVU=;
        b=Te4dh48jAPzIcLeKIKtyU8OJyivGvsQ5c6rTxdxAj0039RRMa1VxaSEAsr6Uo3MJYl
         eRwFmP8UYlJjUI8+Whrv/om3qqWZ0ubTrNmSObu2MetQdW9NDg40uuMGfq6Bev3ScYaV
         nSqeDF2OaHATbM5lQtDZh3cmYwJ2dPoGAPsnIBOeqwM6Kt0i0XHL6EfjhicFQVBJbCmI
         Je6NAjVAyijuRaInriBXoW5IHyDIO+LOEUk+XgYVtrPA4Mhdk79wTOrqgh3MJP9NMVXj
         7OyG1saVBIym+AUWwp/sUaT4iywkzqqY6mJdiTrm3RTUR3+W/pHwqC+fSu+q4S9PPEoq
         ny2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KHwxClvR/QV+aucNk9MngTXTJ9hZ935W2GKqdLukKVU=;
        b=foRl5nndQX7SPJ5S0AH1cMVr9GFvaCnKQ1qsXvjcNrfElgxiK+WyB2QT9TpvWNuxYx
         FuyoLXqMCCtrJGds3WH/1+/vcKs+HbE5YIsI2Hhcf+utLKgs2yxQK6vbgaOb1fmP4Cd3
         ycGn01HZWC95bLV5rzNIePzxQYf3djctlmPYJLYWWZzMgKrEY3l82X67nB/Sd6QDjzEN
         NnrA88Zs+HnRi45pRgu4+WIFFoUvGW7NQCxQrde1YIk55wy+vecf8Z2OMG7kRwpyrI8L
         ebrS0LQRIHhZ7VLDngbpXYAmM1Xl5fyw3emyFsw/2tJ2fA5SL3P3RiMf43sQE4l0pXyn
         Q3hg==
X-Gm-Message-State: ABuFfogEfA7vt+lnTjt2/+vv3K3D0pCpdv9ZsrogW+A+BA53Q24tFkZZ
        BWCykkSZV8Qv6dMeo+7XO5Q=
X-Google-Smtp-Source: ACcGV62XhJ//kXe19uvU/192Z1QI8nhrRerEmEAQjXnKsQXOUtca+W0cqrw9e52i7um75SZ7gKrKxg==
X-Received: by 2002:a0c:bffb:: with SMTP id u56mr31397081qvj.196.1539889414651;
        Thu, 18 Oct 2018 12:03:34 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m46-v6sm14461022qtk.48.2018.10.18.12.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:03:33 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] reset: don't compute unstaged changes after reset
 when --quiet
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181017164021.15204-2-peartben@gmail.com>
 <CAPig+cSiE-M9QMch4WE7y4cib1FBUNiaR2pGGtbDuqiz6juhaw@mail.gmail.com>
 <20181017182255.GC28326@sigill.intra.peff.net>
 <xmqqpnw7vs5b.fsf@gitster-ct.c.googlers.com>
 <20181018063628.GA23537@sigill.intra.peff.net>
 <5b4d46c2-ac0b-8a44-5e99-b0926ea764d3@gmail.com>
 <CACsJy8CvvZcQdxnZbu-FZmVm7wtMDLocjiMVURhvJ=NtuYgi9w@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ce5077bd-fefc-d415-7237-a2f9a26e3294@gmail.com>
Date:   Thu, 18 Oct 2018 15:03:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CvvZcQdxnZbu-FZmVm7wtMDLocjiMVURhvJ=NtuYgi9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/18/2018 2:26 PM, Duy Nguyen wrote:
> On Thu, Oct 18, 2018 at 8:18 PM Ben Peart <peartben@gmail.com> wrote:
>> I actually started my effort to speed up reset by attempting to
>> multi-thread refresh_index().  You can see a work in progress at:
>>
>> https://github.com/benpeart/git/pull/new/refresh-index-multithread-gvfs
>>
>> The patch doesn't always work as it is still not thread safe.  When it
>> works, it's great but I ran into to many difficulties trying to debug
>> the remaining threading issues (even adding print statements would
>> change the timing and the repro would disappear).  It will take a lot of
>> code review to discover and fix the remaining non-thread safe code paths.
>>
>> In addition, the optimized code path that takes advantage of fsmonitor,
>> uses multiple threads, fscache, etc _already exists_ in preload_index().
>>    Trying to recreate all those optimizations in refresh_index() is (as I
>> discovered) a daunting task.
> 
> Why not make refresh_index() run preload_index() first (or the
> parallel lstat part to be precise), and only do the heavy
> content-based refresh in single thread mode?
> 

Head smack! Why didn't I think of that?

That is a terrific suggestion.  Calling preload_index() right before the 
big for loop in refresh_index() is a trivial and effective way to do the 
bulk of the updating with the optimized code.  After doing that, most of 
the cache entries can bail out quickly down in refresh_cache_ent() when 
it tests ce_uptodate(ce).

Here are the numbers using that optimization (hot cache, averaged across 
3 runs):

0.32 git add asdf
1.67 git reset asdf
1.68 git status
3.67 Total

vs without it:

0.32 git add asdf
2.48 git reset asdf
1.50 git status
4.30 Total

For a savings in the reset command of 32% and 15% overall.

Clearly doing the refresh_index() faster is not as much savings as not 
doing it at all.  Given how simple this patch is, I think it makes sense 
to do both so that we have optimized each path to is fullest.
