Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6CBC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 11:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiCVLXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 07:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiCVLX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 07:23:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1912814B6
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 04:22:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v4so15378342pjh.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=uawnM7XtYqYk24z5XECOIah1RMeFbVPzOJ599s26VEM=;
        b=DgneJ70wXc0rz3R9QpOHaxEpNOy5zuMEL7pE9sw6vuSlQjXB8N/khfQiuBW4N0CX07
         nf5Xc7Qr861NjyvBT77qzTx0rzfEl6kFs/ej1D6gntXrqWJ2mq4p2f5L7JiZtzfz2TLf
         kLR1BRDm10ihZAAs/Pd8RSdMolBANyHqXy7d2ZtyvVo2A+hfZwFFptOfeEwcdpwXINd8
         quxuCZsp3HFkUJkb34g6YUOo/raMYa3QJwm7g96wEfqoYd1+NKTKAUiwW8IOtFHX5r0S
         TN10nDd3TInxXBXahVBiyo9QWrLvT1YRmM/RO1p3pRDFCNoYGrR61O8QZpjDRgNgay62
         d2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=uawnM7XtYqYk24z5XECOIah1RMeFbVPzOJ599s26VEM=;
        b=JVGgKvgJdAhZmWF+EvU0pSP4rw3hLbA5vT0r/3zAUOH6NqNnpeMNxgZOTCM6VGrVVY
         OTX+XOVDVLd422vIGlQjqyVvGJjyE8qiPIus5arHWD5iEHEXGyCVGouQO5qUFJ8bjP2r
         UgCbv/40iuvRdlbd5HmFysHe2DFCNEJhYNnZTZkH83+j0pNNf4qSn342L1dsHhaUnkXS
         Ol/wFPsoPmFV9up8UEjakhQQzV1d0oBmwDGXyWLankNHC6hA0imQFA0WB+ggBLmw1T+Z
         Es/hCgVMrsx45Ig/W+1EmC9V049Sapwmb8lORXvaVeRJXcR5RfOj7BNNuLDyPlIPa7q5
         +ZCw==
X-Gm-Message-State: AOAM531u6DaYjy0xF01KPKlflI3noq/Mc7071rlKompm9anKFZzxJznP
        qvlKmAl946EY7NViECG2QPw=
X-Google-Smtp-Source: ABdhPJx4IfT+XNPS2s1IdoUEr61pYLwYP1GC0TFaOrzCeNuQJfa+vH79t2IfGTswQWlpvUSsmO6aSQ==
X-Received: by 2002:a17:902:a714:b0:154:6dfe:bba9 with SMTP id w20-20020a170902a71400b001546dfebba9mr6689757plq.124.1647948122499;
        Tue, 22 Mar 2022 04:22:02 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f7ab5a44ebsm25008117pfv.18.2022.03.22.04.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 04:22:01 -0700 (PDT)
Message-ID: <34a387f9-eab2-daa0-0726-cffa3cc266e0@gmail.com>
Date:   Tue, 22 Mar 2022 18:21:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 00/41] use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
 status
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
 <5dea325c-c80c-c203-c42e-b55e58b717de@gmail.com>
In-Reply-To: <5dea325c-c80c-c203-c42e-b55e58b717de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/03/22 13.49, Bagas Sanjaya wrote:
> I think we should only have 2 patches in this series: the first is to replace
> with EXIT_SUCCESS, and second is to replace with EXIT_FAILURE.
> 

Oops, I missed [PATCH 00/41] that adds cocci semantics. So actually we should
have 3 patches...

-- 
An old man doll... just what I always wanted! - Clara
