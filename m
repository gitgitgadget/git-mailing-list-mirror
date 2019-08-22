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
	by dcvr.yhbt.net (Postfix) with ESMTP id AD00E1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 14:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbfHVOZ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 10:25:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34279 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbfHVOZX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 10:25:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id m10so5294910qkk.1
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4cYFgY9xsxrQBaWnv46e+q4s/Ci2xrfiEA7BIkvxRNE=;
        b=WdoGZKKX/eYLOgwl+S9uZ+aZXz3gQE6oldYQk86HrxOdzPKyzL/ObnxqAM04biNjvI
         foLbfcn9Iid4FxEg/r+3L1emuhHOnjOHGV6kLJp1DNIHDO6+pRYzUrB9zJphQaOEX696
         zn622PNX/m7YMswEs7IB40TSry4lW72oIHg1GPOWDUvsmnsaHn9ufT0GdP1P2TdI9+I7
         eBjr2WM5HY0Wd4fM5KTEmYgw/F3au6mO+L8ehHk4zCY+ij4QHPWwOpqwk3Xc5mZAS5V7
         r90XVWpu15ErFVqNbLjkk/dsR9vZrQOcqnX16xQYppGzhdGCHhwA1YcRClUzHu72+Puy
         GohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4cYFgY9xsxrQBaWnv46e+q4s/Ci2xrfiEA7BIkvxRNE=;
        b=lZzPDSdk+nI6E/AgUq1Wc5iOxZ7RFk3ZJz9uJUlqTEBGJqP+mREoHXdnj8dN4kDHue
         NDiSHFq8dvNO94tL878CLHv17wJbJ4qGUzTLbP7E4AGXR1YWzdJJF6fFfNkn6s+hiK6W
         r799xcFJ884gJs8248n8flzvoX3BOMUwvaXZAf0TfDtAHpL3N9CUhzUjGiRvsezzg/S7
         mLiW6NgCr6K7mDMY9droaQVavau5SHgHWAY8kLEbjlzxusDH/3pjHuuiKmxtfRp1WyFw
         8fHlViMI12uvbvBpf7yIXBvJTn44XGC6QG6WLEzwrU0Og5Ad6PkxWy+p35uZ7FVDJpAh
         d0DQ==
X-Gm-Message-State: APjAAAUGfpKEsUBR9z1YE3WvGPySRnHemNcKhMTcYIvu3pQOHsyJ0mq2
        vGXzXdsF7Np02OM6needtC0=
X-Google-Smtp-Source: APXvYqwwTnl0ACtdaRQ1Q8fyvAQKg6UFtRY9i3N1KfJ3RAJgzFjXiYqeZ5nNz1rVWWKnxlbHe6LFhw==
X-Received: by 2002:ae9:ee07:: with SMTP id i7mr38090985qkg.410.1566483922575;
        Thu, 22 Aug 2019 07:25:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7dcd:416c:c779:cf77? ([2001:4898:a800:1012:2f01:416c:c779:cf77])
        by smtp.gmail.com with ESMTPSA id m27sm12650635qtu.31.2019.08.22.07.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 07:25:21 -0700 (PDT)
Subject: Re: [PATCH 0/9] [RFC] New sparse-checkout builtin and "cone" mode
From:   Derrick Stolee <stolee@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com>
 <08bd295b-ec5a-3128-42cf-acb24971d679@gmail.com>
Message-ID: <67dc33a6-3995-bd3e-f1be-db337c04c7b2@gmail.com>
Date:   Thu, 22 Aug 2019 10:25:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <08bd295b-ec5a-3128-42cf-acb24971d679@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2019 9:10 AM, Derrick Stolee wrote:
> On 8/21/2019 5:52 PM, Elijah Newren wrote:
>> On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
>>> For example, if we add A/B/C as a recursive folder, then we add the
>>> following patterns to the sparse-checkout file:
>>>
>>> /*
>>> !/*/*
>>> /A/*
>>> !/A/*/*
>>> /A/B/*
>>> !/A/B/*/*
>>> /A/B/C/*
>>>
>>> The alternating positive/negative patterns say "include everything in this
>>> folder, but exclude everything another level deeper". The final pattern has
>>> no matching negation, so is a recursively closed pattern.
>>
>> Oh, um, would there be any option for fast but without grabbing
>> sibling and parent files of requested directories?  And could users
>> still request individual files (not with regex or pathspec, but fully
>> specifying the path) and still get the fast mode?
> 
> Exact files could probably be included and still be fast. It requires an
> extra hash check per entry, but that's a small price to pay I think.

Quick side note on this point about exact file names and the REAL reason
for the parent paths that I had forgotten until just now.

The following comment exists in unpack-trees.c, clear_ce_flags_dir():

	/*
	 * TODO: check el, if there are no patterns that may conflict
	 * with ret (iow, we know in advance the incl/excl
	 * decision for the entire directory), clear flag here without
	 * calling clear_ce_flags_1(). That function will call
	 * the expensive is_excluded_from_list() on every entry.
	 */

While I haven't implemented it yet in this RFC, this TODO can actually
happen with the current set of cone patterns:

1. If we hit a directory that is not in a parent or recursive path,
   then all paths it contains must have their skipworktree bits set.
   We can avoid computing hashes for them.

2. If we hit a directory that is in a recursive path, then all paths
   it contains must have skipworktree bits off. We can avoid computing
   hashes for them.

When we have a million index entries, these hash computations are not
insignificant!

With that in mind, I think there is a _performance_ reason to include
the parent folders in addition to _user experience_ reason. If we
were to add the complexity of exact file matches, then we would also
want to add the parent folders leading to that file so we can still
do the logic above.

Thanks,
-Stolee
