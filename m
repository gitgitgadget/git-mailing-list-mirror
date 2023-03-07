Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D15C678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 15:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCGPN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCGPNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 10:13:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7B25BC9D
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 07:08:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l25so12465312wrb.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678201679;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=foQSm9SnlKYtY/wnbrpLTT/BYGQotxvAn81MkDasj6E=;
        b=qfpeKWNHTtmXRvhONf/ArFH5h1dqTduh1N3XbIJsMJtsR5V+832R0wkPXZDyNakzWc
         ObM+hkSXeTbFKWIFW1uNR+OAWrPDG/A8rAwjq0Oz5HU+9tZhPwl/gOvCDVN8Ba3FwdEn
         g520sRFK5uEw88sZGqVHlgrWJkohsfnX/hoYaExBHymzGcgnQ4amUnRQECeC/nLfVUYw
         s5iFNpjJMEjA0q2WDfvZMVOH/SAf++6eF+gBYFz2yYau8YMoPFMq15F9HiJdhC/vT0Ct
         zB6rDPOpx5318/pRYl8U3txx+azHkfh6s7A1wyxQ5sdiSdiYCZChYSb3YSZEqO2UJrSG
         1XxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678201679;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foQSm9SnlKYtY/wnbrpLTT/BYGQotxvAn81MkDasj6E=;
        b=XZftI8dBqK4gUpUJY22oZY7Cmyak8TTIwKZ9U8a7jlScyeLPzMAZ0zr8LzJyzCbfd6
         c59OwYP+QeTGzb64mj7IVPS48YC7YsaB32lZQLGG298/pgkfcdaU1S6YNj6HGynJcdXF
         QbmY+MtlNKxa1Ej1Dy9bPuYyRoRWommuLfrImIk/dvjaQnB5SJIrck7m3QejYiObt6/q
         GwsmPDNljOP3lJSJWzCul7KhVBdoZi0xS5oiULKvfRL8faQBN4vxcMkMFK1UfQmBdQFo
         UkgnZ7fCRoEt/LvFMzd1LcXvEEagrh0yVLg9LYyNQKwbo9ZtnPintT+twmUg+dZV5s5I
         Pw2g==
X-Gm-Message-State: AO0yUKUmcHtSyYRDZ+2UrC1sI+49gkp8/SA+axmu8+jFUTQW50EhZgE+
        iQ2te+NOkv0yrRdJvZntSwk=
X-Google-Smtp-Source: AK7set/Zq9vEld4wVcpdp5BfFtrC01cmhg3AlgXxK4xIIfg53UxXInEet2jZPvgl1plEyX9QFP6/Eg==
X-Received: by 2002:adf:efc3:0:b0:2c7:ffd:f483 with SMTP id i3-20020adfefc3000000b002c70ffdf483mr9473037wrp.41.1678201679326;
        Tue, 07 Mar 2023 07:07:59 -0800 (PST)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c2e4700b003e70a7c1b73sm12820583wmf.16.2023.03.07.07.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:07:58 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8366d23f-c53e-5edf-490b-e8990c9ebf28@dunelm.org.uk>
Date:   Tue, 7 Mar 2023 15:07:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a config
 option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com, jonathantanmy@google.com
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com>
 <4f313373-25c5-06d4-6d1b-89a0e595dfa1@dunelm.org.uk>
 <CAMMLpeTPNoDK9r-e9KMwfYzdG+iyuVwxQGaWHUL-ngD+-r48FQ@mail.gmail.com>
In-Reply-To: <CAMMLpeTPNoDK9r-e9KMwfYzdG+iyuVwxQGaWHUL-ngD+-r48FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 06/03/2023 17:36, Alex Henrie wrote:
> On Mon, Mar 6, 2023 at 9:24 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> Please have a look at the email I sent before sending v6:
> https://lore.kernel.org/git/CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=QHMwhoc+LtiXpavw@mail.gmail.com/

Thanks for the link, I'd missed that email.

> In that email I tried to explain why I didn't incorporate your three
> suggestions on v5. Please let me know if it still isn't clear.

I'll take a look in the next couple of days and let you know

Thanks

Phillip

> -Alex
