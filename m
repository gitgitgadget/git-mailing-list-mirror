Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F29C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 14:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJGOYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJGOYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 10:24:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137914D20
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 07:24:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j21so745830qkk.9
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bq6U8IFQgEn9wEPvf8WPG42tdmMMcXRp1DDFXEF+NUA=;
        b=MBXYaAs3Y9MUXNAkIIsWI4oarkPpSSTGwnqmD+5BOP1EgEnOOKW80pqGX4XgLgX5CY
         L6JeMQqH5OL6ugc9f6svbwl+DQ1cemjBkcX3KzNzb7P+rkU+POhNBtNcom+p/Ash3oLX
         uORuWr4Lm9GHWUUQ+T3zGYAHJ+dwNKyQzF1fpJX/mSqGJYc6Pjrpr7NboO9PfBAyE/3d
         lpDK3dviRzyYs1RfuOSlE2Ny8PLZElT8pQMVNQqDxM4SegnJIxNjgE2txZlueEmb5kBU
         6HbDn7rs9nh+dqRczqcNC2VfEEi4rEeb/QMmoSJKwE0Kx6uyIxKCVj3eHEHvTIWwsQjD
         bjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq6U8IFQgEn9wEPvf8WPG42tdmMMcXRp1DDFXEF+NUA=;
        b=BpFTdHlemHA1t7lcqUSkIjKXusZZrPEhtETa+slUBBfMtKxkjQIksePezoCi7UgbmS
         XsbBN31Nh0jXaC2Vr7105akjYKuhfnvlx9c1DT2xUh9HXGPXuBMMUT8sbQlA8V/xXYnr
         A9pMKD3hPFqP9MLEtndS+ShORlpqC6u5UhBJdMDhMbmhNMC8QaFlN4z6IeejqycfpfkY
         sjp5JuchoWid5zJbY8Ee/519M/d4+t7hjgiCvLXqArMOugIPnN74Z+uFq26p1LaNiptL
         2ubyvqhGtQ7nJokJw801twbm2nr1QhwLtXu3OLHA2Ua79lUNxf1TS6Db/YJfO5LiOXQQ
         1pEg==
X-Gm-Message-State: ACrzQf0NtfY5OdTigzuux17YlHXeH1wHrerRlq1AXc0Xnps4tlCmyQ+2
        THLEIkPUraKCSNVB+mPWYb15FIjsIMsm
X-Google-Smtp-Source: AMsMyM66QX9s42yr2F3ktFVye33729zy3qe/hUv8me/C+09aP1XQD85mtItGawT05BMCC9EyxgKUfA==
X-Received: by 2002:a05:620a:800d:b0:6ce:6f69:d629 with SMTP id ee13-20020a05620a800d00b006ce6f69d629mr3724890qkb.594.1665152686824;
        Fri, 07 Oct 2022 07:24:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2185:e582:857d:e0db? ([2600:1700:e72:80a0:2185:e582:857d:e0db])
        by smtp.gmail.com with ESMTPSA id ay11-20020a05620a178b00b006bb78d095c5sm2009130qkb.79.2022.10.07.07.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 07:24:45 -0700 (PDT)
Message-ID: <ae9de8dd-d1e6-2898-90cb-2a6593aa8f3a@github.com>
Date:   Fri, 7 Oct 2022 10:24:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [feature request] resume capability for users in enemies of
 Internet countries
Content-Language: en-US
To:     Philip Oakley <philipoakley@iee.email>, Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, m <mahg361@gmail.com>,
        git@vger.kernel.org
References: <6e4a08d2-5d72-29fd-6917-11f0a74e9314@gmail.com>
 <83814bcb-1d72-07bf-32d1-d05db6cc6481@gmail.com>
 <20221007071459.GM28810@kitsune.suse.cz> <20221007072606.M704368@dcvr>
 <8e11ecf0-735a-a104-a3d1-8324fbd76862@iee.email>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <8e11ecf0-735a-a104-a3d1-8324fbd76862@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/7/22 6:03 AM, Philip Oakley wrote:
> On 07/10/2022 08:26, Eric Wong wrote:

>> Perhaps GIT_SMART_HTTP=0 and having dumb clones not throwaway
>> incomplete xfers would be more transparent to hosters, but dumb
>> HTTP tends to be slow even on good connections.
> 
> There is work going on by Stollee (cc'd) on Bundle-URIs that look to
> split up repository serving into bite sized chunk, so may be worth
> looking at.
> https://lore.kernel.org/git/pull.1248.v4.git.1660050761.gitgitgadget@gmail.com/
> : [PATCH v4 0/2] bundle URIs: design doc
> 
> Also discussed at the recent Contributor's Summit
> https://lore.kernel.org/git/YzXvwv%2FzK5AjhVvV@nand.local/ : [TOPIC 1/8]
> Bundle URIs

Thanks, Philip.

The bundle URIs feature should make it possible to help here.

One is that we could break the clone into smaller pieces, but
I think that most bundle providers will still have at least
one bundle with "most" of the repo. The real payoff is that
we should be able to have resumable downloads for those
bundles (pending some implementation details, but I'm waiting
for the rest of the series to land first).

Of course, this all depends on the host providing bundles and
advertising them, but we will get to that when we can.

Thanks,
-Stolee
