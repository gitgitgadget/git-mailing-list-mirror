Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811E7C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJJSWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJJSWW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:22:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494D1DA63
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:22:21 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q196so2812596iod.8
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXCoBEoDVFlF9UG2fU9i/CnAZ4mNvYQ28xfPDlZh9UU=;
        b=grpUGITFVaN/0cG+EHtmmxQRI5skA+2+ffZGWd5OF7ovoUb5bXRzAzj/yMlGrUe11+
         NZBkr5ZX5gO1JSZZ2xkQG1KkD6jiRHShR/C6Qk0eCMKkKQDco1d3GeB+HL6MuPY7m7vo
         RaOifNNOi27HJfn/JKvi+MKgi1yrws0T8OvnXNW62eeCDym8BGeoD8cqMb7QcWzKnjoj
         00bvWncVYVn1oeQ/SslbfStJaGI4yaCHb8NCAaaG1sa2QZygfdE2J6IikDTB3ypppBkp
         UXPGe/vAzsj3XbRYzK4VE+WocD0x4keB6MtG1ieGRvd/XAKWQe9o+nnD8JErAtL5Nfb9
         Hp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXCoBEoDVFlF9UG2fU9i/CnAZ4mNvYQ28xfPDlZh9UU=;
        b=Bb3VAlFD+6/TEAbbjZBAlRmZfFC4sXTzYiJfa+PvIvktkNHSTVRT6d4nYazR6Wi7r9
         lmL/n5cKL9Y1D1PIPGzZgQS7GVLN5OooqsAVG/Cz0QEIoAeeoCzHgBVovxYGtiGQ8jo8
         V8apvV4VrYiq321ZGwJ2VAQEX4rKxDoRg+oFJooECLv5xxcCFpUErrgm46hd8uK9QT8b
         wkYBcWAAExoc1PaS6ZmRrUMtlBmRGRliuHl1jmRFHG8yEmH48K32JgB1G9UsQ2I5UxW4
         KOAwCgZXUoFfzdIbLX8Xe+eJ6AuvcPq2Fz/gXnGEuna/lkE9NfJdMtHlWoA1d0hH6wgC
         pwdQ==
X-Gm-Message-State: ACrzQf1rifWYh7Iucohh4+3DsGc+fmmh9ETS2p23ufrS9oFi0anv4bro
        OywLWPC3bSqrxzuoDR8Jixd0
X-Google-Smtp-Source: AMsMyM6F5M6lxaY09j5hYoXlivZ7EqNTCv1naJKCnPQ2nVepAK/UZA0cUMJBakK9AY8lmqduAReRrA==
X-Received: by 2002:a05:6638:2501:b0:35a:3675:fe2c with SMTP id v1-20020a056638250100b0035a3675fe2cmr10867678jat.35.1665426141219;
        Mon, 10 Oct 2022 11:22:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2102:4070:cf6:fed2? ([2600:1700:e72:80a0:2102:4070:cf6:fed2])
        by smtp.gmail.com with ESMTPSA id s3-20020a92c5c3000000b002f9a7dc2e1fsm4099908ilt.53.2022.10.10.11.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 11:22:20 -0700 (PDT)
Message-ID: <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com>
Date:   Mon, 10 Oct 2022 14:22:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [Outreachy] internship contribution
Content-Language: en-US
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        Luna Jernberg <droidbittin@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Hariom verma <hariom18599@gmail.com>
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
 <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
 <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
 <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com>
 <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
 <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2022 2:17 PM, NSENGIYUMVA WILBERFORCE wrote:
> thank you all for your suggestions, let me see what is easy for me
> 
> On Mon, Oct 10, 2022 at 7:58 PM Luna Jernberg <droidbittin@gmail.com> wrote:
>>
>> Maybe WSL can be used?: https://learn.microsoft.com/en-us/windows/wsl/install

If you do go the WSL route, then please share your learnings by updating the
contributing doc either in git-for-windows/git [1] or here on the mailing list.

[1] https://github.com/git-for-windows/git/blob/main/CONTRIBUTING.md

Thanks,
-Stolee
