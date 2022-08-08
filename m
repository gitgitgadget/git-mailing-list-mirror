Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A96C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 10:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiHHKHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241931AbiHHKHW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 06:07:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752AE009
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 03:07:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso6645wmb.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=rps8L7rgE0lQC5Wahw8X1npmLpLI3m+oEfcNIq2NpCM=;
        b=NuKLBXyR+XoZV5GMZN/Aw5HVpYdeI8c6EwR6EOqgaIrDhOYgfS75AjrE/5oWvp742x
         mM2BleOBZofgGthGN4NICJs/NIaPJg8lHLRHiPKgTvYPxm2xhBq+mYiuHWYJc56+Y8BS
         gF0Wpv4DyuD3OdsMp9I/1Wcb+Gy/FAj0/YXzCLQaZ3pZsPG7FE++SWE3l6/tkjaTU9+H
         c4RfgfojlTuc/CbgGoEASwy/CRK6EKB7gHCP7rNAJetYGNEDjUE/67aE8BUJ2OVBrnqg
         9y+5mPGd68AB0UVOqETqnYSE76ig9uk6HkKxlN8v7dBHKmGdm2i0oeJqSabXGShQ7QyV
         GS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=rps8L7rgE0lQC5Wahw8X1npmLpLI3m+oEfcNIq2NpCM=;
        b=xYFwTaCbUkpqZFf9E8HhZPOAGzGsS/wnjKiLoWkuAL7P60gC99+S5uez99fFy0VRJY
         v6BJO61HlXmf7jal0jI8keALUowpswis0mQOV9+F9oL8VegYNIyxcVk8VvOLyaASz5Y8
         1r8W/ax+AoUvWIQM6xF7aFMCkGy6IZkKyyswfuAap6o4icPg/Cuwfo0nxroAanKrty0I
         mV4yhCXtx2NrgWUDR9si3EBr+gyN+3pbYDuH752dngtgWgdghygu6f5GUqF3mcrlqbtq
         np58+5mIxf30byihRoeWgMSEkFVAUZanTjo/9khoNF6T47Ma8/jyTu1IIhSuhtUdYqHc
         On0A==
X-Gm-Message-State: ACgBeo3G7+C2GcaYB8Qbp+qCAoYyqBwKxgDjOpEExuiZRbyZQi2MyyzY
        3AW4sGPVjPhco1Pku18ECJA=
X-Google-Smtp-Source: AA6agR49QsuXDvo5Hv/3Ass/z4PjAxSP3Y6i7zNsU+pexuip9Wl5kPipUyONEC1OGXPBYNa7nai8dQ==
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id p20-20020a05600c1d9400b003a4ffd9bb4amr11844519wms.8.1659953239578;
        Mon, 08 Aug 2022 03:07:19 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c4e8a00b003a30fbde91dsm20116553wmq.20.2022.08.08.03.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 03:07:19 -0700 (PDT)
Message-ID: <edc7763d-420f-a1f9-de13-fb2cb4ddfb2a@gmail.com>
Date:   Mon, 8 Aug 2022 11:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 5/6] transport: add client support for object-info
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-6-calvinwan@google.com>
 <b33ec478-8858-faa7-2678-f02559426539@gmail.com>
 <CAFySSZDvgwbbHCHfyuaqX3tKsr-GjJ9iihygg6rNNe46Ys7_EA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAFySSZDvgwbbHCHfyuaqX3tKsr-GjJ9iihygg6rNNe46Ys7_EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 04/08/2022 23:20, Calvin Wan wrote:
>>> The client currently supports requesting a list of object ids with
>>> features 'size' and 'type' from a v2 server. If a server does not
>>> advertise either of the requested features, then the client falls back
>>> to making the request through 'fetch'.
>>
>> I'm confused by the 'type' support, I might have missed something as I'm
>> not familiar with this code but I couldn't see where we parse the type
>> returned by the server.
> 
> I should clarify that the server does not support 'type', only the client.
> Since the client falls back to 'fetch' to grab the object info if the server
> doesn't support a requested option (e.g. type), I have 'type' included
> as part of the supported client options.

Does that mean all the type client code is effectively unused and so 
untested?

>>> +                     if (!strcmp(object_info_values.items[1 + size_index].string, ""))
>>> +                             die("object-info: not our ref %s",
>>
>> I'm a bit confused by this message is it trying to say "object %s is
>> missing on the server"?
> 
> Correct. You'll find the same error message in upload-pack.c

I find the message confusing as we're talking about oids not refs. I 
have also realized that dying here is incompatible with the normal 
cat-file behavior of printing "<objectname> missing" rather than dying 
when a missing object is queried.

>> Should be we checking the object id matches what we asked for? (I'm not
>> sure if protocol-v2.txt mentions the order in which the objects are
>> returned)
> 
> Hmmmm I think I either check for an object id match or update
> protocol-v2.txt to mention order is consistent.

If we can then updating the protocol makes sense. Even if we do that a 
buggy or malicious server could return the objects in a different order. 
A malicious server can also lie about the size so I'm not sure how much 
benefit there is in checking the oids in terms of validating the 
response but I think we should definitely check that the server returns 
the expected number of sizes.

Best Wishes

Phillip
