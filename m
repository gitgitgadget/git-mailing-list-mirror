Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673B51F404
	for <e@80x24.org>; Mon, 17 Sep 2018 14:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeIQTnO (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:43:14 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43207 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeIQTnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:43:14 -0400
Received: by mail-qt0-f195.google.com with SMTP id g53-v6so15344939qtg.10
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oJuK3/Bhrp7YN5LBikvWVsDXcFfgXAV6/nRSGjF7FQs=;
        b=l7ivpUaQMa1Cw8y40WyXqDtBtboGKLo/mwpdJsIPZlNbgINn0KzyDhxIUp8XuD0WL8
         I0Cae0rFQ/9mx3E5bIFDN8FN7vPZtl7BDdCsdJki59+5MZMZqxl4GPe1q1HN6sjQcEBq
         sYuhGpolPaoP2pjJjQhQdYs0dXcGUht0VOiEZ4bO9qEdEkYqWLXAHNsKEg0J7WOFzH4S
         LNhC3P2kGUTPepgbFaAZe8kO8wJSPGiIqCbXDmELtEtTUJKhMqwWdJwr95bFYpPvPWR8
         9xRBi0Xh/lDs/+sOq9Yx7Y7EwqtMFH0Qjade5WChhdjBV+W+7NYnQXzLu7TTlLZDhdt9
         jesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oJuK3/Bhrp7YN5LBikvWVsDXcFfgXAV6/nRSGjF7FQs=;
        b=kMVdB8sg+8WJ1+4ZqKkvXu0te1/CxVLv7bKxQ0VAhUAca4OO5lZhuuu2XGXoJIlWIM
         QX7omHag1jDtMm9hAXwh+LhxrBJ6zlIUiq7UDWcJ0Lbcv0y0LOEyfcj51be519pq6xpu
         t2N1hA7N6NrKB6Foz3alL0Wv508WN8LYNaciYHd0jJpFxl8Bh8izfF/N199FIB1UR80h
         1sH7KSanNXJbngQSP9EMlSpTPJuQwxDZlCKBqA79nkQGuM7ZERELGeWs1H0oIXZRUaLR
         MumT+fJjRSCBV7eJPodF9n0xtxid2Qn8loyNv/lH+zh+5F903LX8K1CaPH3bbDvxhk6L
         OVww==
X-Gm-Message-State: APzg51CjVg9OT0ez2CecnyYgiuG9oiCtc8Y1FUcbLIlOSteZ4qtlBshV
        1A/MbGFTYc49gjFd2lmx+ad1hhVk
X-Google-Smtp-Source: ANB0VdaZu1xXc2lLsU4J5XUm4rXQRT11IqWT6jn+273Bj6Lq6U+PcwQkdwKN84/vAL7Oy/U0Y2u9gg==
X-Received: by 2002:a0c:eb48:: with SMTP id c8-v6mr11873570qvq.16.1537193740971;
        Mon, 17 Sep 2018 07:15:40 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p4-v6sm10762081qkl.41.2018.09.17.07.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 07:15:40 -0700 (PDT)
Subject: Re: [PATCH] read-cache.c: fix a sparse warning
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
References: <c92b2f25-315d-141b-8974-dd05d7fd2b9e@ramsayjones.plus.com>
 <CAPig+cSm52i=ypGoPGGumhP+_waq=OU2QZ=p3oVzTTzLsNpfNA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2efc8b66-3d26-f794-b5fe-6a4b013feeaf@gmail.com>
Date:   Mon, 17 Sep 2018 10:15:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cSm52i=ypGoPGGumhP+_waq=OU2QZ=p3oVzTTzLsNpfNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/16/2018 3:17 AM, Eric Sunshine wrote:
> On Fri, Sep 14, 2018 at 7:29 PM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>> At one time, the POSIX standard required the type used to represent
>> a thread handle (pthread_t) be an arithmetic type. This is no longer
>> the case, probably because different platforms used to regularly
>> ignore that requirement.  For example, on cygwin a pthread_t is a
>> pointer to a structure (a quite common choice), whereas on Linux it
>> is defined as an 'unsigned long int'.
>>
>> On cygwin, but not on Linux, 'sparse' currently complains about an
>> initialiser used on a 'struct load_index_extensions' variable, whose
>> first field may be a pthread handle (if not compiled with NO_PTHREADS
>> set).
>>
>> In order to fix the warning, move the (conditional) pthread field to
>> the end of the struct and change the initialiser to use a NULL, since
>> the new (unconditional) first field is a pointer type.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>> If you need to re-roll your 'bp/read-cache-parallel' branch, could you
>> please squash this into the relevant patch (commit a090af334,
>> "read-cache: load cache extensions on a worker thread", 2018-09-12).
> 
> The information contained in this commit message is so useful that it
> might make sense to plop this patch at the end of the series rather
> than merely squashing it in. (Or, if it is squashed, include the above
> explanation in the commit message of the appropriate patch.)
> 

I'm happy to squash it in if I end up re-rolling the patch series.  I'll 
include the information in the commit message above as a comment so that 
it is in close proximity to the code impacted.
