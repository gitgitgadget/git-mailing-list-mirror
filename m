Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F967C77B7E
	for <git@archiver.kernel.org>; Thu, 25 May 2023 20:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbjEYUCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 16:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjEYUCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 16:02:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811BD8
        for <git@vger.kernel.org>; Thu, 25 May 2023 13:02:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53033a0b473so1450737a12.0
        for <git@vger.kernel.org>; Thu, 25 May 2023 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685044967; x=1687636967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehTbMkvhMMjOzRT5ZZFaF70XdyXdX+nTfKXApQ+uuRs=;
        b=HEHLJCJonLPzoLSUDnnNvVodKvbTL5zpXxVQrQMnI0JD6q92IQtkxvn7GueMsVz8BJ
         l8aVdWqCPcSiO7kkWu7kInWxIfiYglCdwdqDY1fdtCYgoBYYTqheyJsbZ0m/amYhTAl3
         qxPiiqhI75ulS7FpUOw7A68rZAsfK2BWa8ao/UBGGTGAg2Ndjs4xIibG00FBoQ6rUc1G
         g2VCoH7JvT9mJ82P56WX0R+cJAORu2uusN+ZDdwEzTIMYQskv1WxpnnHxNHC69aFnBY/
         UQcy1zbskLCCLc6Ddny1aC8uMeAd8mvCSiBZ+30+YHIY9EtfoybfwTVEDa5F36wZSYlw
         jsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685044967; x=1687636967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehTbMkvhMMjOzRT5ZZFaF70XdyXdX+nTfKXApQ+uuRs=;
        b=VSTOV8WDMv0MwznScAwMfLZijugGEg51J6vXAB+baSUirv6G3cEUqq2HD+u6CaEz5+
         ZNBuEtUgvWQ9heaLx7qs5T7rKRUs3uqRljh2McCov0uHtn4tAQaRmBFsFbZVq0xczIAC
         AKzYYYKc//iSdI+5yBlGAYukFfM6kDYt5eR6DqPo0ve+AH+65oxaoApNzHBxC54ej9e4
         vsVs1+tmq+Xep7sNtvk39tGPOkZfA0QTtiEBDcCreSqWb0NlADcEMESppFuaC2u0eKg6
         F/CYjHi4xbxp/J+hspHOJVDfJHbXzznrbqwYb2YByyztLSRLezaaFFbkm5u9Xg1WsQfN
         xNzg==
X-Gm-Message-State: AC+VfDw8ATRodPeGRUqz7ihW1lfZvyRUO3cjI0fxiiujQ3jY9Oct/SXG
        VwWTve0ww1AW9UYnflHCJRNH
X-Google-Smtp-Source: ACHHUZ6bL8rcosQcigu22OSQSbFHFeUpLU6CN9/IBpDIud3wiCkjfZehSuTSnB9IIH/lTYh+vWGegg==
X-Received: by 2002:a17:902:da8b:b0:1af:cabb:87b6 with SMTP id j11-20020a170902da8b00b001afcabb87b6mr3755587plx.19.1685044967294;
        Thu, 25 May 2023 13:02:47 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001a9293597efsm1766752pli.246.2023.05.25.13.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 13:02:46 -0700 (PDT)
Message-ID: <9d1e5afd-e29a-0088-6151-251796277ef3@github.com>
Date:   Thu, 25 May 2023 13:02:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] repository: move 'repository_format_worktree_config'
 to repo scope
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <5ed9100a7707a529b309005419244d083cdc85ba.1684883872.git.gitgitgadget@gmail.com>
 <kl6lv8ghxkpc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lsfbkxuje.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <kl6lsfbkxuje.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo wrote:
> Glen Choo <chooglen@google.com> writes:
> 
>> I think it would be better to pass a "struct repository" arg to
>> config_with_options() instead of mocking a config_source to hold a .repo
>> member.
> 
> The flipside is that this would be redundant with an existing use of
> git_config_source.repo, so for consistency, we should probably remove
> git_config_source.repo. There's only one user of git_config_source.repo
> - reading .gitmodules from a blob. It probably made sense to add .repo
> the time, but now that we have a second, different use of "struct
> repository", accepting an arg is probably better.

Agreed, I'd much prefer having a single 'struct repository' instance used in
the context of config parsing (if they ever had different values, it
probably wouldn't be immediately obvious for debugging). This and all of
your other recommendations seem reasonable to me, I'll re-roll shortly.

Thanks for the review!
