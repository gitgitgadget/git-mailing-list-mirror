Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE3A1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 16:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfHSQMf (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 12:12:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39881 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHSQMe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 12:12:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so2490034qtu.6
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NbnRFap+eDhOySK6QdIN4qfZjjoCpEfpbIuCYJeutVI=;
        b=F7CQY4gDXFiJMP4t+MgLAom0p8xXN4AI27xmjA24jXztxayNDGGfOi8CNx3RkRexQv
         g1Q6YUgm8f0rkheRIDxZ6YWxG/gbX5IkgqqMSPP0lmP+rnO8Odlviip2WXT1IcVWz6Lv
         pzAGIrw8UwyeLxgkQdwFmDXbVa4UnZcV6KcM4V6atomM0Dq6+PfUvHyOOJMonp+zlkGl
         3t3Ork55aMxQYFKV2W7WRCtLp1nh7wlnOIYTEOJzvUhvr9I7XIyR80tSP10W0yLbQowT
         O4HAzCC27p3J0NsvwsB40fLivkOOn7O1EeAoPrOk7hqHfSLdF56VvvU0t89gIzxzL21/
         4Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NbnRFap+eDhOySK6QdIN4qfZjjoCpEfpbIuCYJeutVI=;
        b=ewy3SZ5dXJ9bRyf3BRE1FXSXTALuD83i2+KNZEILscQjWQ5Q7/y5GxK3gj1bu4K9Wl
         FzcU+xMY7LVaJpP4GyhA7rbAn8o6nPQpvuaNhRwexwDSjuwFb8PQ8DzWz0o9AhqVMj/t
         zYMPaDPaDjvOCLfiz6obLgNvzzygREf57f96yw/71hy7mAMOcl9RXEDB0n20H2j0h3GT
         DwBV6mzpWrS95ydZs+dt1HrZ9Pz/pB23wZR6z9btfSvX6sxrsfAgsgvq+/p7TfGG6fKk
         MS/EWDZI48C+//R5jra5ORfZsFhovfQIS+j5ds5hNCK1MytIhOJKpCkIyzC9SZOxvqf6
         rGMA==
X-Gm-Message-State: APjAAAUfsyF0xAw/hA0Yn0/jPU88FB+JNBorQb5x0iNJSXQg3eFbgmDX
        RcoEPBiKa8ZfZ772gJj2GHdCqgCdEhQ=
X-Google-Smtp-Source: APXvYqw2NdqTXP21yQtVDLv3SB1/sRdyeDxHs/rB2BHOxC+uPZfJUwGenh6rB5tcY3WEmTv7WWk0ug==
X-Received: by 2002:ac8:170f:: with SMTP id w15mr21313386qtj.370.1566231153622;
        Mon, 19 Aug 2019 09:12:33 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3cc4:beea:5454:ae58? ([2001:4898:a800:1012:edf7:beea:5454:ae58])
        by smtp.gmail.com with ESMTPSA id t13sm7200072qkm.117.2019.08.19.09.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:12:33 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] line-log: towards a more responsive, incremental
 'git log -L'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
 <a3f8b468-5ee5-4056-db67-bb8ba5390002@gmail.com>
 <20190819130323.GU20404@szeder.dev>
 <5611dad6-94fe-e4e1-c06d-7dd0642be3ae@gmail.com>
 <20190819150245.GV20404@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6a576e13-79e6-43be-c4a8-065e7a8310ea@gmail.com>
Date:   Mon, 19 Aug 2019 12:12:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190819150245.GV20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2019 11:02 AM, SZEDER Gábor wrote:
> On Mon, Aug 19, 2019 at 10:50:48AM -0400, Derrick Stolee wrote:
>> Note that I don't include the "without patch" numbers. For some
>> reason the path provided is particularly nasty and caused 20,000+
>> missing blobs to be downloaded one-by-one (remember: VFS for Git
>> has many partial-clone-like behaviors). I canceled my test after 55
>> minutes. I'll dig in more to see what is going on, since only 37
>> commits actually change that path.
> 
> Don't bother digging into it, I know why it happens (and how to avoid
> it! :), but don't have the time right now to explain.

Great!  I look forward to your explanation and fix later.

Just to be sure we've got the same issue, here is a section of the
call stack in the hot portion:

line_log_filter
+ queue_diffs
  + diffcore_std
    + diffcore_rename
      + diff_populate_filespec

Thanks,
-Stolee
