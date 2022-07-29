Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F8C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 13:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiG2NZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiG2NZV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 09:25:21 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4212776
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 06:25:20 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i4so3557689qvv.7
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BoB5RnqNoxZ1+yb45g98ekh9YC4SLPazz1XFuYppLD4=;
        b=MkNzN2UNa9BwptMb2gAHuPubjGvrQ7Tw9sO1AsBZEnO3UEd4iNcr0bRZ5+Z0K4W7Qy
         WsQff/rlfWlBVS/0r+K0RHWROXWWXbJaVP0phY6StrEk84sjXHQETfJr5YH9aHaWodX/
         r2l4OM6GlwfD3vGO9T3vvxC6tpZ3QJw2sXXLz7nBuOkPUUBHDeGCkuLkgSiWbPw3MZSl
         AUIqy3BqS9SvLhuSa4nIarMy/HTjPnvmTAd+pKdSJBt7cvgnRNrBHpD3q24LL+MRRdVU
         Eznan302oJ9755Hxj0tEUO0pmvqQhKEn9GPnDWOXIz8fL7zA70A/WWj1moRneLRoWZUm
         OdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BoB5RnqNoxZ1+yb45g98ekh9YC4SLPazz1XFuYppLD4=;
        b=bIddTuZUXyPdE6oKROAAjv18Ax0fPGshsZvDoMZ9kCDvHljrU3x5EqhrNWxRj1WWPg
         aHAszIuNdtXumbTcHUf52+T3ogt18mWfzMT/m2Cx5673+Unca3PXFqYpOFJ8Rhg550YH
         YwImum7161finkXthuZPD46hUDBJDJQsY2pVhou4H45FVjZ4L01AvYgEPTkiGKh/zDHt
         bzm0kNdRIwlIrmnPMcvbokDYRpVOuCFEkY73L6exdoqG15QFzwD55IJXU2HXIPvOsKha
         9GVgX4K607EcRROaJBamadzaYJaxPsQmhsniqu4JcOUwe/umZqW4My7u0yYKI89u/D84
         otPg==
X-Gm-Message-State: ACgBeo1y0IStmG2zehf0ilVut7f4Ma6uz8KAao8tuZFJC5lbRs828A1k
        encDkgd9RsfbkG1O0s9vGJAT
X-Google-Smtp-Source: AA6agR6KYL13m2XBX4HRkxl/GzwMPw4Xrn1OrKRUbIex+j9g8rd1/MzI8zRo/91irtBR1VHeJHZ3fQ==
X-Received: by 2002:a05:6214:d47:b0:474:7f18:4764 with SMTP id 7-20020a0562140d4700b004747f184764mr3081643qvr.15.1659101119530;
        Fri, 29 Jul 2022 06:25:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:994a:ecce:40c:c0b7? ([2600:1700:e72:80a0:994a:ecce:40c:c0b7])
        by smtp.gmail.com with ESMTPSA id c1-20020a05620a268100b006b64d36342fsm2357627qkp.68.2022.07.29.06.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 06:25:18 -0700 (PDT)
Message-ID: <5fb71f12-28c4-3e37-c6c7-e7074872658b@github.com>
Date:   Fri, 29 Jul 2022 09:25:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] log: add default decoration filter
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
 <220726.86y1wglyuq.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220726.86y1wglyuq.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/2022 10:39 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 26 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
>>  test_expect_success 'log.decorate config parsing' '
>>  	git log --oneline --decorate=full >expect.full &&
>>  	git log --oneline --decorate=short >expect.short &&
>> @@ -2198,6 +2204,23 @@ test_expect_success 'log --decorate includes all levels of tag annotated tags' '
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success 'log --decorate does not include things outside filter' '
>> +	reflist="refs/prefetch/ refs/rebase-merge/ refs/bundle/" &&
>> +
>> +	for ref in $reflist
>> +	do
>> +		mkdir -p .git/$ref &&
> 
> Let's not use -p, and fail if .git doesn't exist?

The reflist contains multi-leveled refs. However, they don't go more than
one level beyond .git/refs/, so -p shouldn't be necessary since .git/refs/
should exist.
 
>> +		echo $(git rev-parse HEAD) >.git/$ref/fake || return 1
> 
> Hiding the exit code of the "git rev-parse here, but aside fram that why
> is the echo needed at all, can't we just:
> 
> 	git rev-parse HEAD >.git/ref/fake
> 
> But even more generally can't we:
> 
> 	git update-ref $ref/fake HEAD
> 
> ?

This was just a brain fart on my part.

> If we need to manually munge the ref store let's add REFFILES prereq.

We don't. Thanks.

-Stolee
