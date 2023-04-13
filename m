Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52857C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 21:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDMVi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 17:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDMVi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 17:38:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BB88A7A
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:38:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p8so16489483plk.9
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681421937; x=1684013937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4YMRROUgkdXbqRX990JVjN2iK7BWkOMVIKRDzi5UR4=;
        b=Et0AMwko5eZfZf3TejwLcw+S1AJyOHy61EUWQAsv9QrK1+hOoamAxEqquNT4hMgteB
         dr/4V8VYq/d8b+ZcXs3qv7IU48+XnU94SCPN9ijJrA53mXU3WjAa3la2FDz4+DSvk/IB
         9E6CqyxwDnrGGeuri/Idtq8k3jv/Cs2+RaT0FkO8HA7I+VyQ3ntlHG1L0i3cRRx8UIId
         nU+GZLsPS1APe5sRyg5fZOWO9JPx9hnjDKk66w4ZK0NNp/5UxOdtR+QxWp3OgEReZL+P
         Y2R+I1k041zTnrYHgMBNCdL07ba5uBn0bapOa4UQ59GEeIBPEuYI7mFmIplig0uSd5r/
         DlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681421937; x=1684013937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4YMRROUgkdXbqRX990JVjN2iK7BWkOMVIKRDzi5UR4=;
        b=gSPWKO1zIvcmJVhb+7cwdgqWCrYNSUCk0umZ6mBbYOvz2eFueR6nracXRPUzr4aEbn
         ahsJ50wif3bAdTc7Ypneq+wCUev7MKLb6YOKc2akqXLzTROXha4jsnNTFrD5FZ88QgvY
         nu8HoIYXndE1qnlO3/cedP3VRscmh/XUB1EoKyBFE99nZRgYoskUCtbbQJEftqyYwNQ1
         o2vMEJ96gEChoAcWpzddnpN6nfJ9BVrFwcAbZw3rr0KyQaki7utDY+sb7lMg0nuPZ586
         ZhF/8ZikmZK6zGoI0f6+A43jWLTtQASFoYSueT+WzxUSTUyHpNn5l8bltVZDzUnXsN4m
         fxaw==
X-Gm-Message-State: AAQBX9cYmgQPZh7trmnPLaRmnF0y8Ygpb3RQCiztbQJtSF7uGOQohQaC
        8rN+hX1PIoRbzKoKk8tAMJ4h
X-Google-Smtp-Source: AKy350YXj0HCTUo6MbDv8UuIYl/pnsMAWH5Sf8yvwhH0EuWWmU6ggl6EpcoUf3I1vzrS37hjUfS9QQ==
X-Received: by 2002:a17:902:a40d:b0:1a4:ee94:a79c with SMTP id p13-20020a170902a40d00b001a4ee94a79cmr344098plq.14.1681421936947;
        Thu, 13 Apr 2023 14:38:56 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b001a68991e1b3sm1646719plr.263.2023.04.13.14.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 14:38:56 -0700 (PDT)
Message-ID: <c8091eaf-7c45-119c-fb67-9d7590364902@github.com>
Date:   Thu, 13 Apr 2023 14:38:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v7 0/2] diff-files: integrate with sparse index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, derrickstolee@github.com
Cc:     git@vger.kernel.org, Shuqi Liang <cheskaqiqi@gmail.com>
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-1-cheskaqiqi@gmail.com> <xmqq7cufxy5j.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq7cufxy5j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Shuqi Liang <cheskaqiqi@gmail.com> writes:
> 
>> Changes since v6:
>>
>> 1. Fix word wrap in commit message.
>>
>> 2. Use  'mkdir -p folder1' since full-checkout already have folder1.
>>
>> 3. Use `--stat` to ignore file creation time differences in unrefreshed
>> index.
>>
>> 4. In 'diff-files with pathspec outside sparse definition' add 
>> 'git diff-files "folder*/a" to show that the result is the same with a 
>> wildcard pathspec.
>>
>> 5. Create an 'ensure_expanded' to handle silent failures.
> 
> It seems that review comments have petered out.
> 
> Shall we mark this ready for 'next'?

Sorry for the delay - I noticed a couple more things that might warrant
changes before moving to 'next' and am in the process of writing up that
response. I'll send it within the hour.

> 
> Thanks.

