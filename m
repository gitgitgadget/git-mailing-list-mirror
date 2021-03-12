Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C64EC433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C802664FD6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhCLLsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhCLLry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 06:47:54 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B927EC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:47:53 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso10632630pjd.3
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xAdOS9FEq9283yP48XxfyR5wuh2MrSCkpfrFv+s/4Ec=;
        b=WtqGPc/MmnxEQcJ22/o9LQdRWzW7wHa/wJ54UuiJuhX5wmar+0oJhn/QzU0Q9RINRf
         660rULErLmI1rz/HpWSH4S6yezDLIqDSe1V6SlYENadXFcndVKfrW95KKE/8vVWFuQ25
         YzRIkmfu0DZnJYJLK+a7FsxfXbau8/6G0jl5c1IryW3M3RPex63urN7ACsiVdEqrkY+4
         PHLnQ4exz9fWeGxhlzc3EsDow6wH3LHGqWi5njHBSwyHQdzAXewQeeh5tqfLjkEldB5r
         mM5t2rLMXoZSxnINXuMcWWgCYBD8UCZfgsMstrdECnME7L/dmOwFhLna7S22RHDTbAvi
         iLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xAdOS9FEq9283yP48XxfyR5wuh2MrSCkpfrFv+s/4Ec=;
        b=Fvq8DPVLEvhBrQ+PQdrhq+7l16DCLbWmvH4HvkYblLJ22L5H1fo+jQlfgbBHjXIwI8
         FEFO3WE/LpMZ9JYpnLq/A0zvcsMExZcj1y+uv6YgfOH7qhRnHFxqa5OBclKESuRruBLw
         CuF1lsC5c1wPWs2X+vi/d4qzNd+zPZmlsJQOOktNfz62cHdhXpoXW+7KY5sgf8EPxQbM
         a9YuOiJ2WRIykN7bPMPe/EE2oobccq8OufhntcvaMXiJ0rhZonZ2rNAMbzfxSVvO9tnk
         xWRk1kP6jiOG/Xm8/T2w8mJTx75SwDxQKw6bUK4TlUKIG7GubYU6JLcC0dSu2UC31ROT
         wK7w==
X-Gm-Message-State: AOAM5314HZq7XvWnAYoMQr8DKbT+t5G/5Jy6Y1MiES3pq6hfuWGVBJzM
        kFonb6RHUfaBQI5mDfb8UH9VxMhPJxghLA==
X-Google-Smtp-Source: ABdhPJzS9Y/QzwvXXg6yqytFsCeLsRAHfMDVDvxEDWbcqiYvizfT9TZrNBjSawU2JB6unh8fJA98vQ==
X-Received: by 2002:a17:90b:1a89:: with SMTP id ng9mr14020084pjb.36.1615549673078;
        Fri, 12 Mar 2021 03:47:53 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id f13sm5499055pgu.36.2021.03.12.03.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:47:52 -0800 (PST)
Subject: Re: [PATCH 3/3] po/README: document l10n conventions
To:     Jiang Xin <worldhello.net@gmail.com>
References: <20210311125511.51152-1-bagasdotme@gmail.com>
 <20210311125511.51152-4-bagasdotme@gmail.com>
 <CANYiYbFDJ-CDsJs04=uPsUvcVqPA8wpY2g8ZP_6R5UsYQbQvAg@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <8b3f1c87-0cae-0c5c-78ec-1167bd89230f@gmail.com>
Date:   Fri, 12 Mar 2021 18:47:50 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANYiYbFDJ-CDsJs04=uPsUvcVqPA8wpY2g8ZP_6R5UsYQbQvAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/21 08.33, Jiang Xin wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> 于2021年3月11日周四 下午8:56写道：
>>
>> Document things that l10n contributors must folow.
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>   po/README | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/po/README b/po/README
>> index eda7edf4e6..e1a0494b17 100644
>> --- a/po/README
>> +++ b/po/README
>> @@ -344,3 +344,24 @@ Below are the usage examples:
>>           po-helper.sh check XX.po
>>
>>   Run po-helper.sh without arguments for usage help.
>> +
>> +
>> +Conventions
>> +-----------
>> +
>> +There are some conventions that l10n contributors must follow:
>> +
>> +   1. The subject of each commit should be prefixed with `l10n: `.
>> +   2. The length of commit log title (subject) should be less than 50
>> +      characters, and the length of other lines (commit log body)
>> +      should be no more than 72 characters.
>> +   3. Add "Signed-off-by" trailer to your commit log, like other
>> +      commits in Git. You can automatically add the trailer by
>> +      committing with `git commit -s`.
>> +   4. Check syntax with `msgfmt` or `po-helper.sh check` before
>> +      committing.
>> +   5. Squash trivial commits to make history clear.
>> +   6. Do NOT edit files outside po/ directory.
>> +   7. Other subsystems ("git-gui", "gitk", and Git itself) have their
>> +      own workflow. See Documentation/SubmittingPatches if you want
>> +      to make contributions to these subsystems.
> 
> This patch 3/3 can be merged before we reimplement the utility `git-po-helper`.
> 
> --
> Jiang Xin
> 
Did you mean this patch can be sent separated from this series?

-- 
An old man doll... just what I always wanted! - Clara
