Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFE6C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 09:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4412208FE
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 09:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyGCVy3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgJRJM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgJRJM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 05:12:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C1AC061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 02:12:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e17so8019630wru.12
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zX1GhoGZM/+Kv0chi48++uKsLoUVh1fofOhcvqsQ+08=;
        b=FyGCVy3T6CCzzwxK7CykH2jGM/s2jctLO+HRNtZPCuXdvAgPPWtfsnj+BvNUgGEYd5
         HxFNquSbm3wJJEpfImmYr+1mKtwCwDvWAUqCl0MkK+XsdD/2CiazI58wgLclxvBi1bQ0
         5iHhTQQ3TshANCco9qhJWHQ4zcAav+o9RUyVTIJA4tr0X9E2P0Ow2ZvGVH9h3RVr13yW
         bSsWF8201D71Jj6TJE2uk5flCJm3oN55vM0WYTiBJ+xgTvI+dBZfoG7jv3vCiDj5FVq2
         te+Q4Jep/LeGmob8cr2mg0mCJT1L5SQ2RaGwrOSOwmXJHVvlqZka2jcv+rx6LE8C3jTB
         IEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zX1GhoGZM/+Kv0chi48++uKsLoUVh1fofOhcvqsQ+08=;
        b=Hog8YNywF9ypu1lt1KxcCOrboCEIiLJpZ/RzGzMM/pjOXvySVWqxKpqFL/U7v7KDwf
         PJ6ogSEaESerSAcYu2kiS5AeHGBDVOB7HY+2YPmC+VH6S8lco5XDPkFHXXHNj4PJqGWn
         tSFJeklRSaiYOhglSyoJa46F/AOFwidFdAzEFXuhCpApb5zANMdXKwMiewiIBQ+hlDEW
         NysEkkWwK6M31YAbDr0pJvFBfMajZ5Mva7Dj53to+v7YzFQPYBlw92qgLsZmp0GGkSug
         BeanrZJJF/BXSz2oDySekrepM/hyhzSXONDH08Zp4Bn5H3rmmReMTsSqENtRoBboxy9S
         UhtQ==
X-Gm-Message-State: AOAM533x07tyWxOR8P45kkFom/Dk6Lkl2R5FiJ1VjRGiYD0ywTdIxj4P
        7bTLpHhW6vO1NgvVJ4FBPGBlL+J6KJU=
X-Google-Smtp-Source: ABdhPJzhUawgJ0F0vjtj9xU8TJog37CEyf1CNFJ6RMOMjRJSYZVJY54MGl4yk40THtPqPP3zBlv6Ig==
X-Received: by 2002:adf:9507:: with SMTP id 7mr13743250wrs.365.1603012377372;
        Sun, 18 Oct 2020 02:12:57 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id t12sm13037003wrm.25.2020.10.18.02.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 02:12:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Issue with staging, unstaging, discarding hunks with no context
To:     Daniel Dinnyes <dinnyesd@gmail.com>, git@vger.kernel.org
References: <CAFfHKJ7kAJ7030GPywKHEWG0vJjC0hhEGt4MMR=85nSHnu5Q-w@mail.gmail.com>
 <CAFfHKJ54smgBZrYTEmgoqmo7gMp+H8AxjL3GxnWVdF9K_MnoFg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <26316a94-ed0f-cf52-74f5-b20508345569@gmail.com>
Date:   Sun, 18 Oct 2020 10:12:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFfHKJ54smgBZrYTEmgoqmo7gMp+H8AxjL3GxnWVdF9K_MnoFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel

On 18/10/2020 06:48, Daniel Dinnyes wrote:
> The problem I have is described in more detail in the issue here with magit:
> https://github.com/magit/magit/issues/4222
> 
> The conclusion there was that this is an upstream problem due to some
> recent changes in git.

That's not my reading of that issue. Specifically this comment by kyleam

     You're blaming the wrong git :) I introduced this change with
     6b3c90d (magit-apply-patch: Abort when there is no context,
     2019-08-02). It was prompted by gh-3924, which also brought
     about d508f02 (apply: Adjust hunk line positions for partial
     application, 2019-07-28).

Seems to point to this being a change in magit not git.

`git apply --unidiff-zero` will apply zero context patches but as a 
safety measure they will be rejected without `--unidiff-zero`

Best Wishes

Phillip

> As it has been mentioned in the issue itself, it is understood that
> git had problems with handling hunks without context, so I assume this
> upstream change was to eliminate such issues.
> 
> Yet my experience was that hunks without context worked fine before
> 80% of the time, except if they were right next to each other, they
> might get mixed/messed up. Even in that case, I found that if I
> staged/unstaged hunks in top-down order in magit it didn't cause
> problems.
> 
> Without handling no-context hunks, I see I will have to stash/redo
> entire change-sets, to be able to commit logically separate hunks
> separately. This would be a major PITA.
> 
> Is there a plan to reintroduce handling of hunks with 0 line context
> in the future, or is this something which is technically not going to
> be possible ever?
> 
> Cheers,
> Dan
> 
