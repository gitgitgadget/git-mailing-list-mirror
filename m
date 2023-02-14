Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6BFC05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 17:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjBNRIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 12:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjBNRIa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 12:08:30 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B62E834
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 09:08:02 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id 5so18261729qtp.9
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 09:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eo5vUbvb9IeYHOe21ainEw2SG05R6KifK3yEedPkhC4=;
        b=cMnVCu5vcc+/nvs1wAr+RQv+r2GTQApi1njTpvMkfiMwUycio9l6EvfKz3MBW22JUm
         toU0PTAi3kxxO0ST4f9OPWVq8LGrCzKTg2SObWgz13EbSG1hFpp7t3zouVHz25nu6L0o
         WZTHJq0JlnEhNgWZLRfe2csJ4BD+wwtTbhOXu759cIKNelkPGGToQqHsHO5rtKfrFWrH
         J4xJwt7bu5233C5nCD1mzXXv975NpsDP2/0kiQoA0Uq45CsAB5z/yOlZ8j3dN5CA3pf3
         t8QUSzELUaYyPvY+HWShsIXiWy+VW4ZNJKGHbaLJpfzGZjv9FVTDOGTp1We9BmnNY3QL
         uWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo5vUbvb9IeYHOe21ainEw2SG05R6KifK3yEedPkhC4=;
        b=AR0CZyNTWUDoObb+0H3e3V1+xGm3SykOy02RVD86dsLJcaQoyhBZ+lhSywPN5/NpXg
         VKWj8jFimlGkAuKS7OAMOr8MFBm+lReX47bzvEaiWy8GV9A5z0y4axtLvLTBK30n+1ay
         nI0y6haUOm5JqreGpDc6ZURd6thNsVs9imVjfNoDBfrjYUk5/1mFMB5O/wjz0aGWSwpx
         tT9pOaqJc+jZzzf7AsXCayajwTWLzrEivm2UvwsrCxtBuWQdRZp/chdp3lQicHvx0tdO
         BNwfg+lNLdawLX272n9KIWOk4aXMZVyPNwwBYQbxr7y+cLOhi9xgeK8k3+moK2+CPlKA
         GHzQ==
X-Gm-Message-State: AO0yUKUC+u0FngSExVoWBlO2yveJM/D3Nr/29jbpo9mDlugteKRaGB1u
        GM/zAiHjkGZg7RYhlJ6D75qpmVT0caQWy7s=
X-Google-Smtp-Source: AK7set+G+mnms8UrnEzYjVFs0+tJqaFryktDpiphwecxG81gLiUy0ulexyclBjSRHOizvIPjnQypRw==
X-Received: by 2002:a05:622a:5c9:b0:3b9:a49e:2835 with SMTP id d9-20020a05622a05c900b003b9a49e2835mr4922550qtb.63.1676394480616;
        Tue, 14 Feb 2023 09:08:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:68aa:e1d1:5ebe:6827? ([2600:1700:e72:80a0:68aa:e1d1:5ebe:6827])
        by smtp.gmail.com with ESMTPSA id k126-20020a37ba84000000b0073b5fd5ff9fsm1328451qkf.128.2023.02.14.09.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 09:07:59 -0800 (PST)
Message-ID: <2eb324c9-4908-5ace-4724-72c2815674fb@github.com>
Date:   Tue, 14 Feb 2023 12:07:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: "git maintenance" - detect status?
To:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
References: <CAPMMpohJ1gajTYOA9ZJjq=hASA9ry9fKP02TYH2dDF+VBeek8w@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPMMpohJ1gajTYOA9ZJjq=hASA9ry9fKP02TYH2dDF+VBeek8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2023 5:50 AM, Tao Klerks wrote:

> However, I can't figure out how to test the current state of
> scheduling, from within git:
>  * There's no config value representing "scheduling is enabled" (as
> far as I can tell)
>  * There's no "git maintenance" subcommand for "check on the
> scheduling tasks" (as far as I can tell)
> 
> In principle I guess it's possible to check for the Task Scheduler
> entries and their status in Windows, for example, but that sounds...
> like relying on implementation details.
> 
> Is there any correct cross-platform way to detect the scheduling state?

Not currently, but you do make a good point about the scheduler
being an implementation detail.

You're making a good case for a new subcommand like 'git maintenance
status' that would report these details. It could even be a three-
tiered result:

  $ git maintenance status
  global scheduler: on
  repository schedule: enabled
  foreground maintenance: disabled

...or something like that. Not sure how to properly describe the
maintenance.auto config option as anything other than "foreground
maintenance", even if it launches maintenance processes in the
background on most platforms.

Of course, it could be worth exploring more about the specific
schedule the repository is scheduled for. It could describe the
maintenance.strategy value that is assumed (if there is one) or
even break down the tasks that will be run on different cadences:

  $ git maintenance status
  global scheduler: on
  repository schedule: enabled
    strategy: incremental
    hourly: prefetch, commit-graph
    daily: incremental-repack
    weekly: pack-refs
  foreground maintenance: disabled

Finally, making this something machine-readable (say, key=value
lines or JSON output) could be valuable behind an argument.

These are all just "top of mind" thoughts when I read your
questions, so feel free to disregard any or all of it. Just
ideas to think about.

Thanks,
-Stolee
