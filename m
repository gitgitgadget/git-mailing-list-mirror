Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7F71FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 19:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbcKRTZa (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 14:25:30 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35983 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbcKRTZa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 14:25:30 -0500
Received: by mail-qt0-f172.google.com with SMTP id w33so163291510qtc.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 11:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qAIjtlj5/IZpPWfvejFCdfap4bg9elHNbvyFoXegSkk=;
        b=bOSBexNC93T0UenRzmijy2rWUSdVtdZd/LFWNzXvmG81nOE329E33mQ6kmM6Y2nnRd
         cn+UCZiHxn7y6P+pKem7NR+Gt+9iLQt9YjcvPUqGrR0v4YrEkKpim0p+jl9+uUq2xVYx
         Iv/pHHvhAijuaZwwX6XCS2CgDJJrZUlLGwZGOQ5FUBJgYvaxjusL6eYnR6XeWSgtCtzG
         7BLOdDwK6IlYq6X++GxInYqH3DBvSOBpXZkxVdPS/SZHpCcyDYY704YRKF4Sj/UMpu6w
         YXkiNLv5bL6YoytCZWmk6BJuAnhwZDpQmbCB5YviI325k7vTHEO03XTxnKgWvdeArJ4L
         VHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qAIjtlj5/IZpPWfvejFCdfap4bg9elHNbvyFoXegSkk=;
        b=XIsDt/xbr5nTt3gl3rhcItaKGZ4m+N2i/wASPz94kVbF49JJ1VUXRy7BhprsHA9BpQ
         jXA8VXG6eSoS5iOIe63Fd3b8OI23VgvPJFCAlEa2NjJg7tPfFmzb8BcuBEjbAdNzPAib
         BgJjofF8gl4Y0C9hg6gCbfgzHPTsRB4QPzsAnGAhP8VQI2LX7+G+KFAm73+drpZTH47e
         uih6ToM1nXV3ZOTcHZxyg7oZz6xonDxqULZyRAZZKDQxYi0/B1fF8Z8sq7QOGXfY+e5W
         PkJZbddKob0DZPGeXPNeE/sat2ohtkhHaWjgyIeG0tPtItQH8IflEcLFULKGamXrJTrs
         LKhw==
X-Gm-Message-State: AKaTC011SqcaNN4iYLh0lAcrc9zTs3EcahE4jz65Use2BDmbcS/omHqPr6NeSy1NXfMKTgtr3VvcBy8+yZnim1rH
X-Received: by 10.200.49.235 with SMTP id i40mr1142870qte.170.1479497128898;
 Fri, 18 Nov 2016 11:25:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 18 Nov 2016 11:25:28 -0800 (PST)
In-Reply-To: <20161117133538.GF39230@book.hvoigt.net>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-12-sbeller@google.com>
 <20161117133538.GF39230@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Nov 2016 11:25:28 -0800
Message-ID: <CAGZ79kYBWa1yjdRK4GzFo8BtsGJVexxxh0vVW4K5-xYhG9ucEA@mail.gmail.com>
Subject: Re: [PATCH 11/16] teach unpack_trees() to remove submodule contents
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2016 at 5:35 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Tue, Nov 15, 2016 at 03:06:46PM -0800, Stefan Beller wrote:
>> Extend rmdir_or_warn() to remove the directories of those submodules which
>> are scheduled for removal. Also teach verify_clean_submodule() to check
>> that a submodule configured to be removed is not modified before scheduling
>> it for removal.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
> [...]
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -2,6 +2,7 @@
>>   * Various trivial helper wrappers around standard functions
>>   */
>>  #include "cache.h"
>> +#include "submodule.h"
>>
>>  static void do_nothing(size_t size)
>>  {
>> @@ -592,6 +593,9 @@ int unlink_or_warn(const char *file)
>>
>>  int rmdir_or_warn(const char *file)
>>  {
>> +     if (submodule_is_interesting(file, null_sha1)
>> +         && depopulate_submodule(file))
>> +             return -1;
>
> How about untracked files inside submodules? Should we not care about
> them? With this code the entire directory will be removed. In general
> git would not remove a directory with untracked files in it even though
> it is removed in the database. I wonder if we should imitate that here
> and just remove files that are tracked by git so that users do not loose
> files that might be precious to them.

Well from the superprojects perspective a submodule looks like a file,
so if the checkout involved removing a file it had to either be clean or the
checkout failed. So I though we'd go with a similar way here?

We need to stop when untracked files are present, I am not sure if we need
to care if the files are ignored, though.

In this version of the series, the test added in patch 14, testing for
treating untracked files properly is a failing test. So I agree that we should
not just delete them; I'll fix that in the next version of the series.

Thanks,
Stefan
