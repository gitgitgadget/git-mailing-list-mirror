Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AA9C46466
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 13:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D16B2083B
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 13:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvH4Lcje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgJHNcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgJHNcE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 09:32:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E54BC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 06:32:04 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n61so5449692ota.10
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J3tRA4v23S1HlkHnui4sDXNJlkMedochoCDQh53ujqQ=;
        b=QvH4LcjeCRVRqL+3Ty8hZQHW4fGH3IN9xiZIT+rjr4ffmYkfmY1kfXuoLZedFRcbnB
         vb15wCw4FcCdykFMsqWIlsTxL28Co3HDGS4RpDVAr7jPu+paJoBBwOVFlPk1ClhEquj4
         fYy4UiWqhhBxV4t+6l8kEs8UuzDxVRirtIMLYiMHkkiydM7gO3+dOpJoNdd8Ar7jWn5X
         KFZzrby0CSseLhOvrOK/R/0WE2VAj2MTnReO1VI8VOpJUzXDar96Uh0DDrd6X3IBjqCU
         5UDJDjJNAHVG2qEhpwfYwCWZWFAkLa7GJfuxo484MXAIDLhOKcDu6ynKTmHvUixpBe6t
         uWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J3tRA4v23S1HlkHnui4sDXNJlkMedochoCDQh53ujqQ=;
        b=aF5B2Di5zdFYbjCoRm96CPeUYFJ+N5VpzwbwL9qu7/AW6U3ryFjEp7z+ONolcqc/wW
         wej/wrmO2JA0zgd+uUVkSYfofeTZtdwCdglG4CdiOVmj+tSRXbMUBnVX51KSCLOQswAf
         qZR7IHntwUQSYqCF9DSeJv0CS5WrQJPbU4CLxwQ6489v9EQgPfVmTUTni951jkQ/wDV1
         09wOpz5LMPJsOd3lRUyUPwDOXRJLyogcciiJspSMUV84i6ITEjaQROsu8kh6uhrA4vEy
         wTkWi5cq5gsRPnfP2MKDgi9nv35V+lhCs8L08gC4XKkPfuYybxZ7AEs50MRGLZn6OpNx
         oTUA==
X-Gm-Message-State: AOAM530MFjMS3IdMga2aVnGGz3jrvbQ7D8VfJKiwXt0Z7nv/GLEwH0LT
        U41Uc+t5ZCRM/JjLrvAJ0E4=
X-Google-Smtp-Source: ABdhPJxsfaNfgFlzo80eI15dwJ+VWBTdSsYIKjO9nxBP/xSJwJH+SRlWnfrRVnCQM1wTKrgUAreCOA==
X-Received: by 2002:a9d:6491:: with SMTP id g17mr4820910otl.326.1602163922559;
        Thu, 08 Oct 2020 06:32:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:56e:1bd4:bf96:36ec? ([2600:1700:e72:80a0:56e:1bd4:bf96:36ec])
        by smtp.gmail.com with UTF8SMTPSA id z8sm4634744oic.11.2020.10.08.06.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 06:32:01 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] maintenance: use default schedule if not
 configured
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <d833fffe89c94ecf3551c075960ba6d7607e9b17.1601902635.git.gitgitgadget@gmail.com>
 <20201005195701.14268-1-martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b9791e64-57c5-465d-7175-efe6fcee8aac@gmail.com>
Date:   Thu, 8 Oct 2020 09:32:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201005195701.14268-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2020 3:57 PM, Martin Ågren wrote:
> On Mon, 5 Oct 2020 at 15:07, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> To make this process extremely simple for users, assume a default
>> schedule when no 'maintenance.<task>.schedule' or '...enabled' config
>> settings are concretely set. This is only an in-process assumption, so
>> future versions of Git could adjust this expected schedule.
> 
> This obviously makes sense to me. ;-) One thing it does mean though is
> that something like this:
> 
>   $ git maintenance register
>   # Time goes by...
>   # Someone said to try this:
>   $ git config --add maintenance.commit-graph.schedule hourly
>   $ git config --add maintenance.commit-graph.enable true
>   # That could have been a no-op, since we were already on
>   # such an hourly schedule, but it will effectively turn off
>   # all other scheduled tasks. So some time later:
>   # -- Why are my fetches so slow all of a sudden? :-(
> 
> That could be different if `git maintenance register` would turn on,
> say, `maintenance.baseSchedule = standard` where setting those
> `maintenance.commit-graph.*` would tweak that "standard" "base
> schedule" (in a no-op way as it happens).

Thank you so much for your detailed feedback! This is an excellent
point and I will be sure to account for it when I have time to
carefully examine the options and these kind of workflows.

Right now, I'm a bit underwater getting ready for the v2.29.0
release (in microsoft/git, Scalar, and VFS for Git) but I will
revisit this as my main focus after this release cycle. I have
not forgotten about this topic!!!

> As mentioned above, I end with some minor suggestions.

I really appreciate the effort you put in to this fixup.
Thanks,
-Stolee

