Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD2C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 13:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244960AbiHRNSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbiHRNSc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 09:18:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F0C83F19
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:18:31 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r141so1048184iod.4
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EBdOgjBhrQ9eO+qZDsaaUkd8zn0ZCLHGN0nhuTWcc2s=;
        b=hKg4jC8JFraRj46sHMsAtLHugIJ8VA+cwv1fK/tCs9uX1SQPIL+6JjEmOxMTKk1uZT
         h8zWMDlTrqFuaFtGb5NQJQQvmIpDyPwraeVIjo+zXRLAYjSjUAQ4dvw7L4VJnPq53ofZ
         5iwsXsjfHzZ5RECfqvplxda/G7KD5fz33LyaaoSn+j462hBWcb2258cWUAur6VgCh8Qf
         zQFBV6YVIo7FOm12Ifvx1Y5k9470C/osiEVjFtmyaWfKL1xxRywtgpP2N+xQ9XjclYoV
         0kSKTHipayHciBczouzFRMfNdaGcc/4WEMSWedCsZUEv+Me/oEfhb3li0Nyo0k2KfEnQ
         tr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EBdOgjBhrQ9eO+qZDsaaUkd8zn0ZCLHGN0nhuTWcc2s=;
        b=uzguscszsL9Ja9OcANWA5j4oE3z/1ljDXFbtjk3ZtCUJqE1/s1N+tVZuF2ezfVnFKN
         lCuIEJWxkeivTXsdZahDPeIez/KRWoaCj/9diRMvPdWxfJPkUh6EUHNUQupcJHYCl4N7
         S2mov8t2M30HCFqPBhBgsh8I+Tk3iXauO/OvKZhoLQkiBIS/VI8nTjlH1xe6i5zVszvc
         NNZxXBy1BQIgD5FmhD2JhaqPbV5Y1ezcO8jJBdZu6FK41KV4MudL9Gam8YhZH6yQvg+i
         6MWOCaJZYM4zPwXQGmK1Qt1ldte+0nQbJmHIUZr1MLY+GFCKQ3dHUgNfQqdy2jFWkOYW
         KGSg==
X-Gm-Message-State: ACgBeo36rLNeZ6GSiuJ1b6F2MG9CmSF3SGi6D4C/4WyYp5x2NWhBHv1Y
        yiaHxSATgUpeiiqy6I5I+Yf17siVSF/O
X-Google-Smtp-Source: AA6agR5U+T2eCDrPR3bHub7FoyLu/U7U4ugXy9WwQTb9AHvSXeUjtCLmzPkVSpnUpe/urcb+zfY0kg==
X-Received: by 2002:a5d:8618:0:b0:684:6469:596b with SMTP id f24-20020a5d8618000000b006846469596bmr1314221iol.177.1660828710514;
        Thu, 18 Aug 2022 06:18:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6? ([2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6])
        by smtp.gmail.com with ESMTPSA id s15-20020a02b14f000000b003435776213esm597896jah.61.2022.08.18.06.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 06:18:30 -0700 (PDT)
Message-ID: <864680d7-69e0-c392-db39-28f15bce3935@github.com>
Date:   Thu, 18 Aug 2022 09:18:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: What's cooking in git.git (Aug 2022, #06; Wed, 17)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7d36s31e.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7d36s31e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 7:47 PM, Victoria Dye wrote:

> (warning: long-winded tangent mostly unrelated to FSMonitor)
> 
> In the process of testing FSMonitor behavior, I think found other issues
> with Scalar registration. Specifically, the test I wrote attempted to
> 'scalar register' a bare repo, since bare directories are incompatible with
> FSMonitor. After seeing that FSMonitor was *not* incompatible with the
> repository, I found that Scalar was 1) ignoring the bare repository and, as

This is interesting, that Scalar doesn't recognize a bare repo. There are
definitely some config settings that it recommends that don't make sense
in a bare repo, but it's interesting that it completely ignores it. Good
find.

I'm not sure there is anything to 'fix' except maybe error out when the
discovered Git repository is bare. Add a warning, at minimum.

> a result, 2) identifying my Git clone (way above GIT_CEILING_DIRECTORIES) as
> the "enlistment root". I think 1) might be fine as-is - uniformly ignoring
> bare repos seems like a reasonable choice - but 2) seems like more of a
> problem. 

...

> The current usage of GIT_CEILING_DIRECTORIES relies on the fact that, when
> invoking a normal 'git' command, 'setup_git_directory()' only searches
> upwards from the current working directory to find the repo root; it's a
> clear "yes" or "no" as to whether that search passes a ceiling directory.
> Scalar isn't as clear, since it searches for the repo root both "downwards"
> into '<dir>/src' *and* upwards through the parents of '<dir>'. It's not
> totally clear to me what the "right" behavior for Scalar is, but my current
> thought is to follow the same rules as 'setup_git_directory()', but for the
> *enlistment* root rather than the repository root. It's more restrictive
> than GIT_CEILING_DIRECTORIES on a normal git repo, e.g.:
> 
> 1. 'GIT_CEILING_DIRECTORIES=somedir/enlistment git -C somedir/enlistment/src status' 
>    is valid.
> 2. 'GIT_CEILING_DIRECTORIES=somedir/enlistment scalar register somedir/enlistment/src'
>    is not valid.

This is interesting, that we can't recognize the ceiling as the root.

> but since Scalar works on the entire enlistment (not just the repo inside of
> it), I think it makes sense to prevent it from crossing a ceiling directory
> boundary.

I think the enlistment root was something that was inherited from VFS for
Git, and we can mostly abandon it. The things we need to do are all based
on the Git repository itself, not the parent. The only thing we need to
keep is to allow a user to specify the repo by pointing to the directory
immediately above the 'src' directory.

> 'scalar register somedir/enlistment/test/data' will search:
> 
>   * somedir/enlistment/test/data/src
>   * somedir/enlistment/test/data
>   * somedir/enlistment/test/src
>   * somedir/enlistment/test
>   * somedir/enlistment/src

Instead, we could do the following on a specified <dir>:

 * If <dir>/src exists, find the Git directory by finding the first Git
   repository containing <dir>/src.
 * Otherwise, find the first Git repository containing <dir>.

Is there an easy way to discover a Git repository at a specific directory?
Or, do we do something simpler, like changing directories then calling
setup_git_directory()? I think simplifying the logic that way should
respect GIT_CEILING_DIRECTORIES correctly.

Thanks,
-Stolee
