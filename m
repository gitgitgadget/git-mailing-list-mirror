Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE3C636D6
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 21:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjBTVbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 16:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBTVbr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 16:31:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3711EFD7
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:31:45 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s5so2818849plg.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4m+FjDY03ML5D+CdnsiDf3t/n4Hc9k64Fl4FMk2cGM=;
        b=nv6hXgzCZnHjuJ8zjyUCCxMILMzqTgA9PbvEMXzge01ncIGTUMT5HpKzePTJ1kw84M
         K8PxobPcG8cf9tpKiCPc5a81RRQQqC7QdTegHLdHbzDpRfTbPgRD4pmHeT00Cyzwx/D+
         yC2V7+IwGgko2ix7tqCEMuSN2+BFpGGk0jrEN2LIDFFlXV1PImwJeUb1mFTKcrZsT/yj
         sQbAr2t8t6TVqeEfOYuhgSYkKDB0XGgfVVjkf5NhHyyT6KnPORiX6l2UVmRAIqw02LVw
         0fvrKybhp8i0f4BpKSwxztPxkAh62VmL+g+XV4ARStkjaR+9MoeTRSxZ9jApFwGY7HGT
         XdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o4m+FjDY03ML5D+CdnsiDf3t/n4Hc9k64Fl4FMk2cGM=;
        b=VP0VT/hgBHjJQPHaxHBSaU/ZsaK3QTV9sf3O/yPAaTW+U0ApQ4TiaFgx+CitXoe5KF
         v2tBsxFE/dNX2IcX8iq4g3NQK2zDJU3r+Z1jx3TToA/0D3ivoVNaC2vGQKfgsRfIkGWY
         jFd4ZDefQ0zNOcGLs9zessA4VRzoJtP1BEe9Tfv8cNTbU/EyZOg67x57oqg9dToMxbhR
         AX8FDonyzhM1kP1O8EAeKEjIRq6Ypbb6widGKV/wFRee1hCGtocqn8jbwuH/+hH8lzoC
         rQbYXQkqsTqOgsNKYBrGQNYVAFJQVWMG2MPw5eqdj5X75/Llfz5+qvub0mQ5GpJ3C2TF
         Ed7g==
X-Gm-Message-State: AO0yUKWT5qsUCi4ny7xHUsMiD/X6t7jaSm7LN47hFhFgp2xSF7sRpDU/
        Iy/MM/WB8r4l2ifvUGHmWdw=
X-Google-Smtp-Source: AK7set+L0MmwpeYFAF39dHIAwykRDoAOqOys5vB7sTWW4M48tUPGCl3fj7Atwo/UjkKt/M/PRp454w==
X-Received: by 2002:a17:903:280e:b0:19b:c6a:6bbf with SMTP id kp14-20020a170903280e00b0019b0c6a6bbfmr2470603plb.8.1676928705137;
        Mon, 20 Feb 2023 13:31:45 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902b70800b0019a983f0119sm1517703pls.307.2023.02.20.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 13:31:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Divyanshu Agrawal <agrawal-d@outlook.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: How to find places where I can contribute?
References: <BM1PR01MB3139C97DD4B99D3024847874FEA79@BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM>
        <CAP8UFD2gtdeaJ=9_DSC4knHiyZk2TeVEq8H_XWA4sdNVEqdhUw@mail.gmail.com>
Date:   Mon, 20 Feb 2023 13:31:44 -0800
In-Reply-To: <CAP8UFD2gtdeaJ=9_DSC4knHiyZk2TeVEq8H_XWA4sdNVEqdhUw@mail.gmail.com>
        (Christian Couder's message of "Mon, 20 Feb 2023 10:59:13 +0100")
Message-ID: <xmqqzg98gh1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> 1. What is the equivalent for the Git project? How can I find issues/features
>> that I can work on?
>>
>> 2. Is there a way I can find bugs/issues that are likely easy for a new
>> contributor to pick up? Similar to a "good-first-issue" label on GitHub?
>
> We have the following documentation:
>
> https://git.github.io/General-Microproject-Information/
>
> There is also the microproject idea page from last year's GSoC:
>
> https://git.github.io/SoC-2022-Microprojects/

While these are good for GSoC applicants before they do a real
project, I didn't read the "where I can contribute?" as such---it
asks for something more real, not a toy "dip my toes" practice.

Perhaps looking for #leftoverbits in the list archive may be another
approach that would give readers a problem with real upsides?

Thanks.


