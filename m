Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9250C0015E
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 13:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjGRNgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 09:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGRNgR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 09:36:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E3DE5
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 06:36:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3144098df56so6076456f8f.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689687373; x=1692279373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mxA4caDVuW8MfoeRi7iTsQ678oyb5iCSH+1jRLHbo4c=;
        b=lxOelddtJKmbvXgVJnoyAmTjLM3WmT7gsoaBb6reNp+t6nrpcQgZbdPME4k8b+DiXr
         xXebHW1MA6CixhfoHCggAZrxlXfs/DP2Fw9jpUMpEbpl+YnqIZtfTcrvvQT5GpgNbd9Y
         4WHh9mINCVUlTifWUsYKIFgipx248GCM7C1yCi6wn46qX9bAsfpLHMABG/ddhtH4CinX
         n3/hUNpOTFSNNZf0Bsp7BEc8O9cEnaZav6d+W0MHPa2zQyMUeUPzsEFZtfJTG1CoBuNh
         xj6xpBqfXHOWgd6+6VPQqnlnfx5Z1ZAvh9qUjmN9P6mKa5TSmqyEcl2eLOJq7ex9UpPV
         SQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687373; x=1692279373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxA4caDVuW8MfoeRi7iTsQ678oyb5iCSH+1jRLHbo4c=;
        b=h6+hLWAh47ib//xnXUB+MMtKvIrhOpOXIjICJWD7yRzmrbrnS/N0K3KWORqXynmkMt
         MVyI2waOGU+W65tG6nVMXsB2TCO1I7TtcOA1ZOrm2tqahayCP2eYuxo7AaG4MWoqHzY7
         /Cu6EV2AX0cihDMW8brQ4ExSBQ1JDSkZ8LxByV3H1vNiGoM0eim9OWuYdGg59OCE5/+O
         KoT+Nha98WBcBl1KMccAbGLpPkzTTmQQKPc5EXKie94YiIlpeOfeYi0XL7APztMLGRs1
         4RmHenjbX9Ytqa0xJT1ItAHjzLh/v0Yec72zeVCnyTT23toZOutOZNjNdvPKdoV1rKNz
         9XVg==
X-Gm-Message-State: ABy/qLao9dZlHAPwzH+oIDtvx1V10jRLuHeKgx0glZ3UVnl2451usfCk
        S0oJah3TWpXM8Ekyu22w8Y3o/+5d7MlfPw==
X-Google-Smtp-Source: APBJJlEODMRHa9m5XncU0uY78epn7orkbS+WPJF69nKHYBCUxJ97827qLgRlTfQ4qqCT+NwWweIwkg==
X-Received: by 2002:adf:f508:0:b0:313:f2bf:295a with SMTP id q8-20020adff508000000b00313f2bf295amr14021583wro.39.1689687372838;
        Tue, 18 Jul 2023 06:36:12 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id y20-20020a05600c20d400b003f91e32b1ebsm10446422wmm.17.2023.07.18.06.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:36:12 -0700 (PDT)
Message-ID: <44671697-e9e6-d75a-30b9-7dccffcc792a@gmail.com>
Date:   Tue, 18 Jul 2023 14:36:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
Content-Language: en-US
To:     Jacob Abel <jacobabel@nullpo.dev>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
 <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com>
 <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk>
 <3f3a3f5b-70fd-ec3f-acbb-d585b5eb6cbc@gmail.com>
 <dyzkftugvd5b4f4wxsg6773fkrdrnbync6idvvi6h7cuuto36w@dbzjnkj3mh2l>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <dyzkftugvd5b4f4wxsg6773fkrdrnbync6idvvi6h7cuuto36w@dbzjnkj3mh2l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/07/2023 01:44, Jacob Abel wrote:
> On 23/07/16 04:34PM, Phillip Wood wrote:
>> Oh so we need to search for a space followed by a tab after "hint:"
>> then.
> 
> Okay. I think `\t` is PCRE so I'll just update the string in
> `builtin/worktree.c` so we can just do `[ ]+` instead.
> 
>> As an aside we often just use four spaces to indent commands in
>> advice messages (see the output of git -C .. grep '"    git' \*.c)
> 
> Apologies. When writing up that original patchset I based the
> formatting of the advice based on the ones in `builtin/add.c` which
> seems to also use `\t`.

The existing code is not consistent on this point but I think there are 
more instances of "    " than "\t". Using "    " makes the indentation 
consistent as the "hint: " prefix is translated so we don't know how far 
the next tab stop will be from the end of the prefix.

>>
>>> So I just went with `[[:space:]]+` as I
>>> didn't want to have to worry about whether some platforms expand the
>>> tab to spaces or how many spaces.
>>
>> Is that a thing?
> 
> It might be? I know copying text through tmux tends to expand tabs to
> spaces for me so I figured some other tools or those same tools on
> different platforms might do things like that as well. To be honest I
> have no idea and figured that I'd just CYA by making it work in the
> case that it did than trying to guarantee that it wouldn't happen.

In the test we are redirecting the output to a file so things like tmux 
do not come into play. I think it would be a bit odd for the system libc 
to convert tabs to spaces.

>>> [...]
>>
>> I think it might be better to just diagnose if HEAD is a dangling
>> symbolic-ref or contains an invalid oid and leave it at that. See the
>> documentation in refs.h for refs_resolve_ref_unsafe() for how to check
>> if HEAD is a dangling symbolic ref - if rego_get_oid(repo, "HEAD") fails
>> and it is not a dangling symbolic ref then it contains an invalid oid.
> 
> Understood. I'll start working on a separate patch to update that
> warning once this patch settles then.

That's great. I think just telling the user something like

    branch 'main' does not exist

when HEAD contains the dangling symbolic ref "refs/heads/main" and

     HEAD is corrupt

when it is not a symbolic ref and repo_get_oid() fails would be fine.

Best Wishes

Phillip
