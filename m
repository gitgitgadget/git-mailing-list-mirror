Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56DAC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348556AbiCYOe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiCYOe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:34:27 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB6FC4E02
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:32:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so5597639otj.10
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mj/mtxE1ja611DvqoUDeDNoqQI3wpHJwj75P5JvJxQs=;
        b=QPfQfexTdRaHUKiLy820cUuGQHzHGI7tIjk3k1oJe2Y96/K2QhVa13OsK+UchT3rMT
         FMIXoqk0y6efBxEHsMXjQ7hhEbeRLWcse04cdJ+ZQGCQkq0ZRlE6dCaDNyyAiUpCebvt
         mzNEKq5aZF+Gq/+SRJowpgwJ/RoHvvtDHYWER8a2g79IEiCRm0b8jDevAkowSkAF6/Mn
         /sP18neyrGR/malHKvEtilUoaI3ynd4aKECfe/s/xndIHZOKQe7vsGSSPzmlcvErvOea
         eugicLqf6pQn/Uh6WfdcJM40pqcthMoHQ80l0MJsZkc30xc9uCx6cGW/ZmpIrS7qmbEV
         lnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mj/mtxE1ja611DvqoUDeDNoqQI3wpHJwj75P5JvJxQs=;
        b=FNrDPNaQN0vhntz5owvvK9hBw/MkJjvtnSQA85pBC9NbsgARjAY2TVw/nXWFmw7ApB
         RZxbYNYzGCcEhcujz69BRb16jJr9EgFYkiU8D5JcrwK95mZPR/4/9ICH7yvuUMxksb+3
         63G4nDUPf747nKI2PmXxEm1M96LS7nHCZBwjOuGd2kUKEEFsIfA3L5BRUejpZZnCIjsS
         ++VFjvRNrCllP3l9m2sGEzBmzHYDCueriNi8MkQSjCyuIZLos1fTgQufImGDJztuGWoN
         MqVT440zEyzGwtv1hx7Z2DmGhgV6LGTL9LgAJB7TNVmHUViHYtmtRbmYMMcJVwXWy+hr
         xeYQ==
X-Gm-Message-State: AOAM530X7c4L50AvOw1uzQ3RMFNK8TZSnmTbK7EqHDUu0wgxpglzx1U3
        InEBPTrrfv/OTuxLWIYRh+Wu
X-Google-Smtp-Source: ABdhPJwSuanS8/Bu/RlzVV9s32ex74vBP3urh6utHOsTiXSNL0l//gRIO7U6YggKMW1EfPO/EMFr1A==
X-Received: by 2002:a05:6830:61b:b0:5cc:e44:7dc3 with SMTP id w27-20020a056830061b00b005cc0e447dc3mr4266534oti.159.1648218769683;
        Fri, 25 Mar 2022 07:32:49 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z82-20020aca3355000000b002ef73b018absm2906530oiz.9.2022.03.25.07.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 07:32:49 -0700 (PDT)
Message-ID: <88e4259e-8e1d-14bb-407f-3177b883388e@github.com>
Date:   Fri, 25 Mar 2022 10:32:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] commit-reach: do not parse and iterate minima
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com
References: <20220323210803.1130790-1-jonathantanmy@google.com>
 <xmqqbkxwp7qp.fsf@gitster.g>
 <34da1688-7d94-d54c-6b3a-3106d0f15380@github.com>
 <YjzrZNQZ7cBIr+Kx@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YjzrZNQZ7cBIr+Kx@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2022 6:06 PM, Taylor Blau wrote:
> This made me think of some of the difficulties we encountered back in
> ce16364e89 (commit.c: don't persist substituted parents when
> unshallowing, 2020-07-08), particularly:
> 
>     One way to fix this would be to reset the parsed object pool entirely
>     (flushing the cache and thus preventing subsequent reads from modifying
>     their parents) after unshallowing. That would produce a problem when
>     callers have a now-stale reference to the old pool, and so this patch
>     implements a different approach.
> 
> if I can recall back to when that patch was written, I think the issue
> was that dumping the entire set of parsed objects caused us to have
> stale references in the commit-graph machinery.
> 
> I'm not sure whether or not the same difficulties would be encountered
> here, though. The shallow stuff is so tricky to me...

The commit-graph is disabled in the presence of grafts, so this
_should_ be fine. I guess there are some issues if you are
transitioning not having grafts to having grafts (or vice-versa)
so that might be worth investigating.

Thanks,
-Stolee
