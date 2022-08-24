Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C7AC3F6B0
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 20:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiHXT77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiHXT74 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 15:59:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A6640577
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 12:59:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c13-20020a17090a4d0d00b001fb6921b42aso2590798pjg.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=MBA7VqDRgsk0zUYgxCUl5dkGrOWgaNjlrcnu24QeLQI=;
        b=ops9Ca5UV+C8frTW0QHykoh0KatGuv27V1tCI9ScZM398G8xfyUbHpMWkwz5GJk8id
         CQ9Ez3ksjRxMrE8gdKygvlwFmhzoum3lnVX3pNnDp1i9fArdCNVXyjhhvyVsin1rZzBy
         ocajbij36upr5d67X77jF5iGoNm3RPTiPtriRGlTXl9mvrtJyDcPeFJn/yNqQOZfhtE4
         Mem7peLNZPxhVvL9t16y5F/x/+GQKXtZVMJyl/6o/agIgpwW9VHVqbKs6uWajZdxL50X
         UATWnFRzvUBOSe0WKyhtb14yBdT7qTvyCD0uvwaSxvyMbPH7cwqkjGHfwZuUPYHR1D8+
         pFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=MBA7VqDRgsk0zUYgxCUl5dkGrOWgaNjlrcnu24QeLQI=;
        b=h3GeYcCajRDQnBiS241R1LQVeD9EnVk3YNMKCSbIharvD64RlEEG0Yiq3OsJ5ZdiNX
         eMpNxt3dZ8hLkab9oLQG2EyJ4BH476YZBiCNsrhKu9HD6/YaF6TR0CWrXm6j83CjemQv
         keC+Ba3En+iPlDvGlLlY8BCi2cJDpcqvZXzx+8+tN9kq/AT9VLrO3odBuwnjeKCRhH+X
         YWg46s/BYOomuhsSpqiws89gYL3mnWXk1PuyKX6pdgiutQla5o3dxGax6l5ZKmlNBHLV
         P5DjCtyqn9ph08X1u3/P+xh9KIeaxSWRl5R8Ks2IoYWoxC8/LW1rmVPXSdpN7rC41zQS
         rHCg==
X-Gm-Message-State: ACgBeo3o6s4BF7jV3eYuhWXvTfp67QVfWFXONeIJgDrst47lvaj+4j/Y
        j359Xqh+3+F0YuaxEi0bwPM=
X-Google-Smtp-Source: AA6agR4tUt5nToQ/6L/Fq1dR8r5Vcyif1/cmkV+QXNfqcsDTQqGr9A04z4Mbi+1RKjOLzlWDkldHWg==
X-Received: by 2002:a17:902:6b84:b0:172:f7cc:175 with SMTP id p4-20020a1709026b8400b00172f7cc0175mr404130plk.158.1661371195386;
        Wed, 24 Aug 2022 12:59:55 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h16-20020a635310000000b0041b5b929664sm11472933pgb.24.2022.08.24.12.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 12:59:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
        <r49psprs-4s48-p6q9-o3q9-37nnr3oq301o@tzk.qr>
Date:   Wed, 24 Aug 2022 12:59:54 -0700
In-Reply-To: <r49psprs-4s48-p6q9-o3q9-37nnr3oq301o@tzk.qr> (Johannes
        Schindelin's message of "Wed, 24 Aug 2022 16:40:18 +0200 (CEST)")
Message-ID: <xmqq1qt576px.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Stolee,
>
> On Tue, 23 Aug 2022, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> GitHub Actions scheduled a brownout of Ubuntu 18.04, which canceled all
>> runs of the 'static-analysis' job in our CI runs. Update to 22.04 to
>> avoid this as the brownout later turns into a complete deprecation.
>>
>> The use of 18.04 was set in d051ed77ee6 (.github/workflows/main.yml: run
>> static-analysis on bionic, 2021-02-08) due to the lack of Coccinelle
>> being available on 20.04 (which continues today).
>
> ACK!

Yup, this is probably a good move.  We tend to stay away from
bleeding edge and instead pick a representative one that is likely
to be with our real users, but 22.04 by no means is one.

I guess we would want to do this even down to 'maint'?

Thanks, both.
