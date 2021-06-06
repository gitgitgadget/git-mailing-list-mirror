Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB19C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 03:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A87D6136E
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 03:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFFDlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 23:41:08 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46763 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFFDlH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 23:41:07 -0400
Received: by mail-pg1-f182.google.com with SMTP id n12so11115820pgs.13
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 20:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nFR35FTD8pIgGtoALSpUn0eLizNiGWkps/Uqrx0zsWI=;
        b=Fsl2XmhpoakvZWDqareWnRkeAeIdLjA1KRtBh3oc7VVDOT47nN2WDiqH+kJlsuhQN+
         3GozYMHVAomsX/5kfMxSOKJYZ/DIL3/iqDWKso9rZ4IOIBeBko6saKyCq6geZfM1R7gh
         nySLfiKZFh7SbYVvUes6TPaOkMQJWK7Jjt3IvFaR2Y2flBZdfp1p6gN114PJzrF5+kmL
         by+xr55qacSyKe6+3PDadh4YyiRJIyxdjGZXT6ijLh6B4bMahe4Ag0e4ebruB2M5IzVi
         XrsUax/GljI0IpW5O9hHvdpOnjV7fIfnjxKj34XB1XEsMKZ1GbKAtHVTd3QT41FarmCq
         46Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nFR35FTD8pIgGtoALSpUn0eLizNiGWkps/Uqrx0zsWI=;
        b=fXj80Q+2pGNM9aG0J3ZgNWvOswJ55SY9xUGuIY2+Q+9UnShufya1i3hK3hzhYNqnjU
         hr51ztwd31ZXKi7QFVCAGyoDlNCZTxM6agpxwGBVtmMJHMjk4E718rPoceyaNCI696lX
         +zaOlWylHmUKTDEt1unwUhNP3cyG6QNrqh7UWV1TvTsZaINdBlpD7TCM+6Lunw9svYuT
         4ZGOXEX840yx8apilqAiiKgMNyfHkvMQGPnwm9Cief0JHKGGFRk1EfZt+A47wa+h9jac
         MkA2ORy8e/faySI7+O+kYSjq2kFbNUWNdgTWjIDdVv8xMBEJHwKbbYEZ5jU59dJB0gtx
         Nq8A==
X-Gm-Message-State: AOAM531Yejoz5ckTivhUMB6gBfxUBDKLwel/xokD7r2IvBvYaDctlK5B
        /ClAM+OJAZKdCebaGRVXF84=
X-Google-Smtp-Source: ABdhPJwqNA8GhBxK6OhxSoP0t2v4Zxw2+UBeSmsp+hFSsx9NieNFJq0mzFR/NFB8usuZLML2CPfmzw==
X-Received: by 2002:aa7:9188:0:b029:2d8:96df:8dec with SMTP id x8-20020aa791880000b02902d896df8decmr11633054pfa.8.1622950683793;
        Sat, 05 Jun 2021 20:38:03 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-2.three.co.id. [180.214.233.2])
        by smtp.gmail.com with ESMTPSA id v22sm4908714pff.105.2021.06.05.20.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 20:38:03 -0700 (PDT)
Subject: Re: [GSoC] [PATCH 1/2] submodule--helper: introduce add-clone
 subcommand
To:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
References: <20210605113913.29005-1-raykar.ath@gmail.com>
 <20210605113913.29005-2-raykar.ath@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <2422ea94-473e-2fa9-a3cf-f22f941e9b44@gmail.com>
Date:   Sun, 6 Jun 2021 10:38:00 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210605113913.29005-2-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 05/06/21 18.39, Atharva Raykar wrote:
> +	git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit

What is the exit code you mean in case of error?

>   	git config submodule."$sm_name".url "$realrepo"
>   
>   	git add --no-warn-embedded-repo $force "$sm_path" ||
> 

Is `git` executable that found in $PATH used? I have both 
distro-packaged Git and custom-compiled Git installed, and I would like 
the latter to be able to use git-submodule from its own install prefix 
(/path/to/git-prefix or whatsever).

-- 
An old man doll... just what I always wanted! - Clara
