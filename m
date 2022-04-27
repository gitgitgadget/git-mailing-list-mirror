Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A50C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 14:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiD0OIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiD0OID (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 10:08:03 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A92F030
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 07:04:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t16so1160011qtr.9
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BXok3Gf6Dk06L+YrzDG7ZJ4PSZJdaIF7Ogjvju39kf8=;
        b=Zs9dYOjZatUnEHzHJdgb0FZCwF34gPC5xNfVCqS4jh1o9/SiJ1XpBrbJC4XdoDqwx8
         U1cEAJnjh29ealD5/k3OYRjpYsG1Qgv38lzpnDJIq6FgoZ3OXO438UygcD59zFZGmCvd
         VDcNyRTEHjxPUjzEG2fZXhSe/DGcmwvXDAmb+6WYx+P9/rihAjlVzErYZQjZsOCj6L60
         k/zlroV6T5pp/s3ob930w0HHj6THooz1o45g2I8eLxV6lXCQzoFwSIvXCgeUxv/Z25w2
         kAGzmSDcEGzKjIyudetPXHfsDfjXNCyaufxtxwwLV/JYtKjfdnheHGhdg7RWH8jsMUAm
         mwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BXok3Gf6Dk06L+YrzDG7ZJ4PSZJdaIF7Ogjvju39kf8=;
        b=0BbqwaZFMZEpyYLt0i8RcAIrYTpDBDaylARV5FIKIBY2YekDVcDDDoGB5fX0Azc61n
         nT+I6R1cWSE+oanHbAvPLMA9ddtInb/kzZzqIfYFtjRn+Myb9YPOJUeLRMECcbeLBEA1
         GRh8pnNFnRmJbckHmbuZt9i/RrRkgGgBpgo8m/33Rv0OYpp7z/zXFIegunCFSlpIdfN1
         t9YCtVCx70T3MiDmp2j58vAudUfVUb4+97voK+AhnHWsgIN7K9BjtJiHRFnndaEu0kKZ
         T/J7zgDGOv/hIwrebjRxg4PNsOos4z1ZwkTPeCwb3RE/Cn9wg6+OWksqery+QoDD4mrg
         /3tw==
X-Gm-Message-State: AOAM531vvN4RQ9RJNH3fdOo9FZhdXhavdjZle0fpTgiUN2SkFYZrU/PV
        YuzEijknZSeFAzGhzJMqFZcYbFCc4IR0
X-Google-Smtp-Source: ABdhPJzFn5OZJSgmsjv0Qxm1jwreM67kGjPWxH3JOLVIjh6Hxa/E4h9ypV6zPn3vr5LhK+mNn08HOw==
X-Received: by 2002:a05:622a:1211:b0:2f2:167:55dc with SMTP id y17-20020a05622a121100b002f2016755dcmr18836088qtx.105.1651068290961;
        Wed, 27 Apr 2022 07:04:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:397f:4d1:8fe5:ea5e? ([2600:1700:e72:80a0:397f:4d1:8fe5:ea5e])
        by smtp.gmail.com with ESMTPSA id q139-20020a37a791000000b0069e88513517sm8201176qke.91.2022.04.27.07.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 07:04:50 -0700 (PDT)
Message-ID: <2ac40f33-8144-e1a1-c3a2-bb9f818287f8@github.com>
Date:   Wed, 27 Apr 2022 10:04:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] setup: avoid uninitialized use of is_safe in
 ensure_valid_ownership
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>, Matheus Valadares <me@m28.io>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
References: <20220427080412.37766-1-carenas@gmail.com>
 <CA+zfrf-6c7BG-PDehHKh6_8zWdu=NeM9gL6zN8Ug+oT9fAOfqw@mail.gmail.com>
 <CAPUEsphL6TARGuhjvCiXXt+CQZd1+c22KBw5n-XCvnP176yz8Q@mail.gmail.com>
 <CA+zfrf_mHfDXk-1VhU564YeCTW7rgDeeuORdTT61LkTESmC5Og@mail.gmail.com>
 <CAPUEspgf_PpjjrGaAqeE50fWYeCqevQRGutocNOA4gyYzQzFsA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPUEspgf_PpjjrGaAqeE50fWYeCqevQRGutocNOA4gyYzQzFsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/27/2022 5:16 AM, Carlo Arenas wrote:
> On Wed, Apr 27, 2022 at 1:33 AM Matheus Valadares <me@m28.io> wrote:
>>
>> C99 standard §6.7.8 (Initialization)/21,
>>
>> If there are fewer initializers in a brace-enclosed list than there are elements or members of an aggregate, or fewer characters in a string literal used to initialize an array of known size than there are elements in the array, the remainder of the aggregate shall be initialized implicitly the same as objects that have static storage duration.
> 
> Thanks, I will include the change to remove the path initializer and
> add instead the is_safe one as part of my bigger change, but FWIW the
> following doesn't even trigger a warning with the highest level we
> have with neither a recent clang or gcc or even the cppcheck static
> analyzer, but leave and uses is_safe uninitialized.
> 
> diff --git a/setup.c b/setup.c
> index 17c7f5fc1dc..28d008145fa 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1122,7 +1122,9 @@ static int safe_directory_cb(const char *key,
> const char *value, void *d)
> 
>  static int ensure_valid_ownership(const char *path)
>  {
> -       struct safe_directory_data data = { .path = path, .is_safe = 0 };

Here, we are using an initializer, which guarantees that the unmentioned
members are set to zeroes.

> +       struct safe_directory_data data;

Here, you are not using an initializer. The data could be anything, so
is not safe.

> +
> +       data.path = path;

Initializing individual members like this afterwards is not safe unless
you set all members individually.

That is why we use the "= { ... }" pattern throughout the codebase.
Sometimes it is simplified to just "= { 0 }" to make sure that the first
member is mentioned as zero and the remaining members are also set to
zero as specified in the standard.

Thanks,
-Stolee
