Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA132C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 06:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiCVGvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 02:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbiCVGu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 02:50:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256FE252B9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 23:49:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k6so7509035plg.12
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Y0SOctRsjig36AZ2hy8j/p+mXAgekrczUkjeI67I84E=;
        b=NnYDr2FVHGVwYqWP6uA+PC84ySunjBvnkDGMxxz4jqTiiMNYQIgUYjpAXK4Qli2qoS
         hGUWPcYfmGaiGIMoqlTiXl/DqazuSMfTYtIKFxezGfCDa+kLJIfCsUpBSO9HR+Bimo9W
         /4QrhGoAb14rO2cv+Ds6TX2p4go0G0KsTtS4JNe/g/oK+XtGy2JYLbkgJP5CDBorqX5u
         xHRRdZA+pWQnKjQa+l1Q4fg6ZR1T2YqTQhWEYfctvxVCNG1hiNMH1YLwGmFRVqv1zygr
         tpFQYIp/j1oBsPyRuJFy+DszC+/Osf8AFcIWBqk1tXPMCSi1i8ro3MHSom2cg7gQbfs6
         5u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y0SOctRsjig36AZ2hy8j/p+mXAgekrczUkjeI67I84E=;
        b=MhldtPnapbiHOk5MKwjwMMHdZNf2drbqO5ByhkQaIU9HcLzn5v+/Sj5OC/oLecNSP1
         VPwpJJij+3Tmax22oe8jxCJfFKDo/7EGKqlcjJJR+LlhT2AbiQac65xtJWXnKEWmck+s
         k0q0FfCswpICJGmsv8cjv/iZbXRqXBQsCb+0NHd3untQTNs95dt2Zc95Cj7CPcfsovr4
         izlLFX/xjhT3tFaNja6X1pWsnkrGD64EOd4qHh8lLWkAdNdO6hdrwHbtYUY8IGu4dZnf
         6htH053vIkU4NqQg6MbMABG6OS87TNUuGPO5MCKZAVzQhw9cOV9EskFlEb8AlMAoxwzg
         qAFw==
X-Gm-Message-State: AOAM532slWnRj97pRzfrca2Ca8FpDb9bPqnvpWnMmVczYdobcTjvLqUo
        AgQrljXYULR3R/mrWPWZEPutrLQqKUw7Eg==
X-Google-Smtp-Source: ABdhPJwGWhLT+B9gprThNyYXdtH6yWc9rqDDnQ5g2R5PrBmGToludo/CpvOQZXP3lUfIpcwsjXqsZw==
X-Received: by 2002:a17:902:7049:b0:151:e52e:ae42 with SMTP id h9-20020a170902704900b00151e52eae42mr17309185plt.118.1647931770597;
        Mon, 21 Mar 2022 23:49:30 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-49.three.co.id. [116.206.28.49])
        by smtp.gmail.com with ESMTPSA id f8-20020a056a00238800b004f7a066c904sm22839342pfc.96.2022.03.21.23.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:49:29 -0700 (PDT)
Message-ID: <5dea325c-c80c-c203-c42e-b55e58b717de@gmail.com>
Date:   Tue, 22 Mar 2022 13:49:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 00/41] use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
 status
Content-Language: en-US
To:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/03/22 05.54, Elia Pinto wrote:
> Elia Pinto (41):
>    archive.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    branch.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    am.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    blame.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    commit.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    credential-cache--daemon.c: use the stdlib EXIT_SUCCESS or
>      EXIT_FAILURE exit status
>    help.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    init-db.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    mailsplit.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    merge-index.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    merge.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    pull.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    rebase.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    remote-ext.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    rev-parse.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    rm.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    shortlog.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    show-branch.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    stash.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    tag.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    unpack-objects.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
>      status
>    update-index.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
>      status
>    obstack.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    git-credential-osxkeychain.c: use the stdlib EXIT_SUCCESS or
>      EXIT_FAILURE exit status
>    git-credential-wincred.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE
>      exit status
>    daemon.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    git.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    help.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    http-backend.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
>      status
>    parse-options.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
>      status
>    path.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    remote-curl.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    run-command.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    setup.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    shell.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    test-json-writer.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
>      status
>    test-reach.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    test-submodule-config.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE
>      exit status
>    test-submodule-nested-repo-config.c: use the stdlib EXIT_SUCCESS or
>      EXIT_FAILURE exit status
>    upload-pack.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
>    exit.cocci: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> 

I think we should only have 2 patches in this series: the first is to replace
with EXIT_SUCCESS, and second is to replace with EXIT_FAILURE.

-- 
An old man doll... just what I always wanted! - Clara
