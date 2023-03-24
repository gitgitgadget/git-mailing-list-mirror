Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEB6C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCXOSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCXOSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:18:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E27D7DA0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:18:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1099401wmq.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679667516;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dctQmbIdaxYVvqBhbkIm7cV9k664rJk3+aHbWb+kZV8=;
        b=F9+jc200Bya7Wskai0cwWSJYyeVWw5GhFy7Bj5oivQRExSrEhW7bdkdk8EHi5LsWmQ
         r0OLqOfZZL2jsiJVkVypj1c1GzCKqfWk/86r2J4D3yqFPBklphcpqfSUSKTlCfeHJqXC
         11b5HAsM69E/MBu61qkyj0suVTYnwFHkGgYWK3yVje624SWeYUZpgXE1hsv/pmUU+Awp
         RAQSqflaufwqymVRS6cQhwPmAvA1Gt3CeMw7b6SSdicEsvUDbnIWjHQgqNGmy/ViaWTN
         PunJz4RnRTB8q0my+JueYE8hQCpv4cPC3wWDzEBpg4T72AlvO1B8WapzkLa5HMSseOYV
         o1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679667516;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dctQmbIdaxYVvqBhbkIm7cV9k664rJk3+aHbWb+kZV8=;
        b=EYZ5QKNDkQS+Jrz4vV28qurPApnUV9S3Wy6BGfwlXRmby5OxKJ/fjpyVN/rqL98eTC
         10nj0c3vVmfEjR4rifUEvHdIVvimbQ7xNZFIg9B54I37uttC8O+Kgq8M6QSspSJYk/7c
         7QgK7wQFBCuJTPrxBJK8CSoCWpWP5dXq19SOxVr4RrikyyNmCEfEYvFiLCP/gW0jpf5K
         cFrY8nbZtCTHyDEztwoLht7a3Nrf43B1VqQexZfsXsTHRECvKyQRWiZ+oqjf7Uo7CkHb
         F6qW5kXUNCe373h/RAypWLrMalmRIudG2zOh1n0ws3vppYdtCDody7grVzW7IEmV+soF
         AQdg==
X-Gm-Message-State: AO0yUKW4s8iIJevuevSrxqqVUYRYm8R+w44K8GKOJVSm+50Vq25+MjsE
        O3/fAPFdhaT1hFpnwuUE3owWIMVhKzw=
X-Google-Smtp-Source: AK7set826ni4sbDQHRn54VkW/0SZZ9GGC/iGzNYaFrJ8yMdOXSxr6i05iRzGwEiMCVp7o373NjD4cQ==
X-Received: by 2002:a1c:f217:0:b0:3ee:5c4c:bdb0 with SMTP id s23-20020a1cf217000000b003ee5c4cbdb0mr2514615wmc.39.1679667516510;
        Fri, 24 Mar 2023 07:18:36 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id x4-20020a1c7c04000000b003ee0d191539sm4991257wmc.10.2023.03.24.07.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 07:18:36 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <88947332-fca5-978e-4405-5c616bd91d29@dunelm.org.uk>
Date:   Fri, 24 Mar 2023 14:18:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/8] sequencer: pass `onto` to complete_action() as
 object-id
Content-Language: en-US
To:     git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-8-oswald.buddenhagen@gmx.de>
 <a3833d93-5db0-454e-526e-04681e5e5276@dunelm.org.uk> <ZBzGSbm7GZVK17ja@ugly>
In-Reply-To: <ZBzGSbm7GZVK17ja@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 21:36, Oswald Buddenhagen wrote:
> On Thu, Mar 23, 2023 at 07:34:57PM +0000, Phillip Wood wrote:
>> On 23/03/2023 16:22, Oswald Buddenhagen wrote:
>>> ... instead of as a commit, which makes the purpose clearer and will
>>> simplify things later.
>>
>> given that we want onto to be a commit I'm not sure how this makes 
>> anything clearer.
>>
> it makes it clearer that we need only the oid, not any other part of the 
> commit object. and pulling ahead the "extraction" reduces the visual 
> noise further down.
> 
>>> As a side effect, this change revealed that skip_unnecessary_picks() was
>>> butchering the commit object due to missing const-correctness. Slightly
>>> adjust its API to rectify this.
>>
>> I don't think this is correct. If you look at the original code it 
>> makes a copy of the oid and uses the copy when calling 
>> skip_unnecessary_picks()
>>
> oops, you're quite right. (facepalm)
> imo the change still makes sense, though, as it replaces the relatively 
> expensive deep copies with simple pointer updates. so just fix the 
> commit message?

I think you should just drop this patch. Copying struct object_id is 
cheap and idiomatic in the code base. If you grep for

"struct object_id \*\*[a-zA-Z0-9_]*[,)]"

you'll see that there are very few matches and all but one of those are 
passing an array.

Best Wishes

Phillip

> 
