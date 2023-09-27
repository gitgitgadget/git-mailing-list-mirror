Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8A3E80AAE
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 14:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjI0OOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjI0OOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 10:14:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B99F3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 07:14:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4064867903cso7937505e9.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695824091; x=1696428891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sX4T7jOHk+0F+l9JicNiFhMULJM/rZGC5Xs3Q+dVVh0=;
        b=ecG0LFZQVs66CF2dWPXdhWgvmg/AJzyvDSCDq5yubM+RRVlrQTJC00iQaKuvADCtjg
         51B9NKHdIf2z70YOC0Ms8yTpYO0YEESjUNpyJOkDn810WPTu5NDu8TtUE1fLPu5PkfZ2
         ao4vOYG0DzK5NIrD5AMLoBG2KSXcLStiv0n9M70Z2K+BHcs/dB0jpHRCGaKTblb+yoo9
         zXgXpDpUTjeaPQth0q6aPix3X2tBwIAfIK7mWgyoozAwuj6ax/7ng1jkXq3DFJmnF95M
         lxImWm9tGYoV8TO3Duas0FoO7dvVl/Rd3qrwSqIG8XaARREOBF8sQ4pDJKHlV6grLa5/
         6gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824091; x=1696428891;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sX4T7jOHk+0F+l9JicNiFhMULJM/rZGC5Xs3Q+dVVh0=;
        b=Dd3wiB0nmDruHpLHiMf+JI0cnhu/LTid/NDrgQV+l4gdoQMeLCIKIUwS+INNeQr7Z7
         m7kxBQjg1aFYb+ftVgkdxA5YGQtAg+DRNHk0Bn8F8B3pJq7TVvyAQD07IO1ntxXWl31E
         RQ5ro762GYiAzegeH2drK1DhgYZM5aP3TbRl/059No4rt/I5uHSHigCiX4zT7vwPzSP7
         UjHr3GegwFnY5MSZ/J3GxN6zFklDKWHVMr+YDLwip9f32Jupmjw7uwuuYZ3DCup1zmzw
         TinWrJ6Z4Lf1adFL9h9u+mukPWPfrs4dygjtGdHVjus+aBDrWwGJmLXKXbV/XCD7IlrL
         xXNg==
X-Gm-Message-State: AOJu0Yxo6oOA2b9GqMOZ94L9zBVkko9TyJc1y6/E0exsHm5mH3ii7cW3
        dqiVDHuZZuPSSsjIa8yN1iy8Q0e3WPY=
X-Google-Smtp-Source: AGHT+IGqtImIju7jaIIV6a9yXnPRapdkIjSm2kunpWxarotAqMa/wohb3Pvcd/QqoirNwUIkNpBYSQ==
X-Received: by 2002:a5d:56d1:0:b0:323:1d8a:3d87 with SMTP id m17-20020a5d56d1000000b003231d8a3d87mr2124453wrw.4.1695824090654;
        Wed, 27 Sep 2023 07:14:50 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id v2-20020adff682000000b0030647449730sm17239907wrp.74.2023.09.27.07.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 07:14:50 -0700 (PDT)
Message-ID: <98f3edcf-7f37-45ff-abd2-c0038d4e0589@gmail.com>
Date:   Wed, 27 Sep 2023 15:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/6] git-std-lib: introduce git standard library
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com, jonathantanmy@google.com, linusa@google.com,
        vdye@github.com
References: <20230908174134.1026823-1-calvinwan@google.com>
 <20230908174443.1027716-5-calvinwan@google.com>
 <4cefe4f8-04ee-48fb-aee4-07342b7a062f@gmail.com>
In-Reply-To: <4cefe4f8-04ee-48fb-aee4-07342b7a062f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 11/09/2023 14:22, Phillip Wood wrote:
> This is looking good, it would be really nice to see a demonstration of 
> building git using git-std-lib (with gettext support) in the next 
> iteration.

I've just pushed a couple of patches on top of this series to 
https://github.com/phillipwood/git/tree/cw/git-std-lib/v3 that show a 
possible way to do that.

Rather than re-using LIB_OBJS when building git-std-lib.a it uses a 
separate variable to hold the list of sources. git is linked against 
git-std-lib.a so we don't have to worry about having the same source 
file in two different libraries. The stub objects are moved into their 
own library. This enables git to be built using git-std-lib.a with

     make git

which will link git against git-std-lib.a built with gettext and tracing 
support. To use git-std-lib.a in other programs compile it and 
git-stub-lib.a with

     make NO_GETTEXT=YesPlease git-std-lib.a git-stub-lib.a

and link your program against both libraries.

The GIT_STD_LIB define is also removed in favor of more stubbing to 
avoid the complications of conditional compilation.

Best Wishes

Phillip
