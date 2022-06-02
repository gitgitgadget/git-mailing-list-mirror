Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C171C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 17:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiFBRjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiFBRjr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 13:39:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B0515906A
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 10:39:46 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id e18-20020a170902ef5200b0016153d857a6so3008196plx.5
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FqA/LWNX6Lv8HzfSaumDlC8Antpou2btU+cUVUmrN+E=;
        b=DxmWg6WTRCJaTz3PJjz4FGIQcUWHOcki8FmxZbNMdZrCVSOS9GSlgVSivyagF4/V0h
         mwNz4wVxB7EQDZhSQlOaWEQv8iF2+2m0riPkqKffzgiOAW/sVWi3Vszp/CvjlClcWPBT
         aAfWJHKpq9mnMbYiFazCdItGxNxHEHAnePw2t9z0IYB5LAjZZ3VL5ecZAgEC+KuI6YB3
         3AxE/vsWwna/Oc0BpNabicJppKEROt3Y9LpOsG1KGMMFvuRMEJ2+BHPFhmx/B7pfHTuQ
         fEggoITuEh41YdA9waF7U8zo2/odBBAq0qkTZfVifvAvPIfy6zyphfaMksZni04a2BWE
         Om5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FqA/LWNX6Lv8HzfSaumDlC8Antpou2btU+cUVUmrN+E=;
        b=pCVAX9CmdfmwJiA+My3/dgRB+ANS55AuHgBrA6Kk7PhAocBBzl8ihXQ2lOONwIRoOj
         PqmBKLhK2C9DRlAYoLBVj4cR0o11O+ALWmGiXIDaPurDMWrtHYSvEiZ+p0qZfDAj8UvK
         IEijEQK6yDVyToMdJnLYzf1nVltsHNGmZnEbxnxCmSV0LXqP2f/CsPyBe0aZ1GsIkUgB
         pjsWdDvmCkKhGlbX39qYuDWTjlxCrOmeFYucg290WRD5CEvfvriqN7uszkNnVekUY+Ak
         +kYd/hW0Wz1V8kMQFgDy7HcVeuAycNQAfwk2P0u4dtoudpQywnZXO2ieun4O9rwKTazA
         pSCQ==
X-Gm-Message-State: AOAM530X4ooq1Wlls+sF9GbrkSWe9+47nKUf4yN/B7l5uD77YvMtN0Z2
        7IGEt9HlwOYmL1fgs08UOKOwheXPY/aueQ==
X-Google-Smtp-Source: ABdhPJwXwNtR5v/rxmSKEuyDc+V8RrnZvpW86VxnPrV2mAUeBnCEkP8/BuRSD1CH99jZ7Su9+qpyt5zexnVtPQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1305:b0:512:ebab:3b20 with SMTP
 id j5-20020a056a00130500b00512ebab3b20mr6105547pfu.82.1654191585940; Thu, 02
 Jun 2022 10:39:45 -0700 (PDT)
Date:   Thu, 02 Jun 2022 10:39:38 -0700
In-Reply-To: <xmqq35gnovkp.fsf@gitster.g>
Message-Id: <kl6la6avdkx1.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com> <575676c760d9a2ce4a59d50e93aa0f45d54620ab.1653685761.git.gitgitgadget@gmail.com>
 <xmqqh75a1rmd.fsf@gitster.g> <2ed00ece-f8bb-c84c-0684-494692a71da2@github.com>
 <xmqq35gnovkp.fsf@gitster.g>
Subject: Re: [PATCH v3 1/5] Documentation: define protected configuration
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <derrickstolee@github.com> writes:
>>>  - The per-repo config is not "protected" (i.e. "trusted"), because?
>>>    If we are not honoring a configuration in the repository, why are
>>>    we working in that repository in the first place?
>>
>> This requires an example:
>>
>> 	Some workflows use repositories stored in shared directories,
>> 	which are writable by multiple unprivileged users.
>
> Isn't the reason more like "users may go spelunking random places in
> the filesystem, with PS1 settings and the like that causes some
> "git" command invoked automatically in their current directory, and
> we want to protect these users from getting harmed by a random
> repository with hostile contents in their configuration and hooks
> without even realizing they have wandered into such a repository"?

Hm, this is my understanding as well, i.e. `safe.directory` is meant to
protect you from shared repositories that you didn't expect, but it lets
you trust the shared repositories that you need (and there is no
protection once you decide to trust the repo).
