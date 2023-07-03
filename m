Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A600EEB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 15:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGCPdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCPdH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 11:33:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6353118
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 08:33:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so6278021e87.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688398384; x=1690990384;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H0UG4pq/R38YW3eK+mmSH6sWvaTuo5Bto8abC7chr60=;
        b=AcrAsJTUBlJpgAYS69SewbvVSrjQGIe5sl4yvV1EcTqxdsLrPKa4MlMez3ZpYOUTbZ
         gj5pUcei4X1b8X3QUnYnh0NDrhic7uSlMApOdmCjaB/72UVb/841MQsdcoc6gTh5RNHg
         oFKPbow/lxSPGE80/zYa5pbHbb45PR9xQifzIB1G/H5Q0A28gytJ0Uu/x3k3tWaTzED2
         WWri7/N9w7W3uwtPTzc+BWU3ag1PKOgkMTRvVdYciDwY92mbK5x70SAKqucfOiMB5rA6
         F7r4UYtzqzHxzD7YLMRHo4r2rHoK8au79VLu8j+Z8JJ92fdgFSrIu6O0AfiGqhsf0MLz
         4Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688398384; x=1690990384;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0UG4pq/R38YW3eK+mmSH6sWvaTuo5Bto8abC7chr60=;
        b=BkOghVxk6nLXxmQf2HFXWFqkvWssjbB74qsC9QLqW3vGmV3LRh39V9TeWUMzQJ8hYq
         rc0+9S9Axo/70+SuRtedP6+LN2btZEwhFE1JRxjb59+MUIyuV3OziUZz6YrZnICNqcmR
         0ouXZ7dNM8tRXHFl1/ajQZA9JcpYuIWU3iCU6aX5dVt8BYzOtfzslDL/dHBygoUA8Tju
         YedXrYqbEnhcXtjUzwaVBD+S4ZYKdZbhhiTrcpGJcSj1gH6DK1WZbJWZqz8uiTCSCvy+
         ihyivvDW2tZxX3VVKRcTFKXIVzkAVfc28J2/4XTAmKG8D++g7Vui208ZiAlvNomGojn9
         qzrg==
X-Gm-Message-State: ABy/qLavyZOWgvvrEDPryQvHQW7QncZAZqiEzWi7lXM0OnFxnFeQMLdG
        tL4gVWuHeyZgTTAxLoYEBZ8JwY+tKFY=
X-Google-Smtp-Source: APBJJlGyszfBJ1l0+FWC5S0m3tBCtZiYrjq0t0S0V/XwEaueXbU/yww1GDIzRI8y3zigS3ueYy+7vg==
X-Received: by 2002:a05:6512:2024:b0:4fb:7666:3bc0 with SMTP id s4-20020a056512202400b004fb76663bc0mr6724583lfs.47.1688398383797;
        Mon, 03 Jul 2023 08:33:03 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402165300b0051d9df5dd2fsm8507492edx.72.2023.07.03.08.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 08:33:03 -0700 (PDT)
Message-ID: <c3c36f93-3fc5-7f7d-1c24-e6925729cc96@gmail.com>
Date:   Mon, 3 Jul 2023 16:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] advise about force-pushing as an alternative to
 reconciliation
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email, gitster@pobox.com
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230702200818.1038494-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 02/07/2023 21:08, Alex Henrie wrote:
> Many times now, I have seen novices do the following:
> 
> 1. Start work on their own personal topic branch
> 2. Push the branch to origin
> 3. Rebase the branch onto origin/master
> 4. Try to push again, but Git says they need to pull
> 5. Pull and make a mess trying to reconcile the older topic branch with
>     the rebased topic branch
> 
> Help avoid this mistake by giving advice that mentions force-pushing,
> rather than assuming that the user always wants to do reconciliation.

I don't think we want to be advising users to force push. For the case 
you mention above I think it would be much safer to advise them to use

	git push --force-if-includes

In the absence of background fetches even

	git push --force-with-lease

is still safer than

	git push --force

Best Wishes

Phillip

> Alex Henrie (2):
>    remote: advise about force-pushing as an alternative to reconciliation
>    push: advise about force-pushing as an alternative to reconciliation
> 
>   builtin/push.c | 22 +++++++++++++---------
>   remote.c       |  3 ++-
>   2 files changed, 15 insertions(+), 10 deletions(-)
> 
