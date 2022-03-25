Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A8C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 20:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiCYUE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiCYUD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 16:03:26 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74A2A267F
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:55:22 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id hu11so7071635qvb.7
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xx/2LqhjkavTa8aqsP5OHp2x2oZeaJjzGEXTbgRprzY=;
        b=G6H63S7GN8C2DDKzweEGOa8/vTbQLySqla4ZSkacjmjh6mVVfSJdOzVJ7M/N/TsKS+
         +j+Kl6ApSX7iu8NBYkFuQe1pSoMryjL3O6V36M4vzgwmbHEwoZtORDBB9z+LhYR3jfHi
         XcxZdQMiHqbuuVCOzGDq+6vgDkZtcDKcYVPTfj7gv51iqeJq20P/yRn7pJAjqiPgftNm
         ri/JTQJr0jvohTkAciF22/ftQ/lmJg13B1hlTxjrWhogVVo06vxVmcHAZ5zi28AeP5tU
         WTEaQPHChPl0/cjDers3Kg7xyCT7ii4i2A+xaEXbITCpcRqtN/G47em5LpIYG8hCfv59
         QBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xx/2LqhjkavTa8aqsP5OHp2x2oZeaJjzGEXTbgRprzY=;
        b=lsv2SsNSRiyK8+/yYI3j2/UCSk+ZHhBNLIpnucFbVbbGr6t6xfcd1DOBpuY/C+54D/
         h6SNQ15kNrZoWmGfj4IPpo2x2iOUyNoZwcmqjDOs1RMo09lIwRxTRL1vqaHEnqxqcwIp
         07KRpz/kooDJ+kSyVgzvG5jaqRV+TNua8fKZSkhshqXgCinQpEdkCnpSlNzXuNn+KXaj
         PWNNgJEsCVQw1nDyOY49ry9AiqCmu+LO7kz+WGHeFzUzyD/c03byL7WYXQ4B8UIp/mSY
         hYAXnu+Q9Fvnbwnr1rchOYLAReWz+92DSA5nTVXLLVYc+nMLfCYhxVIMgP/k3EJdT/J3
         2Dcw==
X-Gm-Message-State: AOAM530rnhUDLrjtN0AOlPYDALh0smR0FgkUgb+PYHi4CeD7Vl2d4tSb
        +1ae3bzdiHWEtG0KKFG5z7nQ1CwBYbuYCA==
X-Google-Smtp-Source: ABdhPJx8II0CGgXpNK4rcgHz6VGcbN16qLqpNndmvgtCIqlsnkUk9kTAT5LlLoJyAnMM9+fxvovBPQ==
X-Received: by 2002:a05:6214:1cc4:b0:431:4cbc:1d91 with SMTP id g4-20020a0562141cc400b004314cbc1d91mr10851444qvd.64.1648238121388;
        Fri, 25 Mar 2022 12:55:21 -0700 (PDT)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id d6-20020ac85d86000000b002e1e20444b6sm5633997qtx.57.2022.03.25.12.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:55:21 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <3f823608-adf4-f717-13d8-8da6f89a9506@sunshineco.com>
Date:   Fri, 25 Mar 2022 15:55:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] worktree: include repair cmd in usage
Content-Language: en-US
To:     Des Preston via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Des Preston <despreston@gmail.com>
References: <pull.1188.git.1648231504463.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <pull.1188.git.1648231504463.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/22 2:05 PM, Des Preston via GitGitGadget wrote:
> The worktree repair command was not added to the usage menu for the
> worktree command. This commit adds the usage of 'worktree repair'
> according to the existing docs.
> 
> Signed-off-by: Des Preston <despreston@gmail.com>

Thanks for fixing my oversight. This certainly should have been done by 
e8e1ff24c5 (worktree: add skeleton "repair" command, 2020-08-27).

One minor comment below...

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -22,6 +22,7 @@ static const char * const worktree_usage[] = {
>   	N_("git worktree move <worktree> <new-path>"),
>   	N_("git worktree prune [<options>]"),
>   	N_("git worktree remove [<options>] <worktree>"),
> +	N_("git worktree repair [<path>]"),
>   	N_("git worktree unlock <path>"),

The usage message should reflect the fact that `git worktree repair` can 
accept multiple paths, thus:

     N_("git worktree repair [<path>...]"),

which would also make it consistent with the synopsis in 
Documentation/worktree.txt.

With that change applied, consider this:

     Acked-by: Eric Sunshine <sunshine@sunshineco.com>
