Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AE0C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 07:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKYHbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 02:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKYHbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 02:31:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2109C240A8
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:31:06 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id b62so3313462pgc.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=q/ANToTSa/j7n/2XWQBtsXQJRZiN06wcKLGRURhtcCI=;
        b=Vgk8hgPg6BbotSsQsQHsYYL4XaPDaN+RyyqhwihJEL9jY9qKS7mE2Vx8XMqWwUhFI8
         HRyft5mKAjlptkQdFR5moBxnNqm41+KSefS6tG8WHU0Be2nut7l46ewDmPIwH8Z9CDBO
         JH7VaxeLlLNP5AqT35sT/vLEYed3i9klg8FdGhumKmeIDeo307FlfhzVYJxRbk8rdwcB
         WGL/2qTTyNOXqkRRkUei0xGwNBaG/O2P44jd+T0YcwtgoH3qhu4PI6PhRFFc/HMa4GOV
         tY1cvaS/pw2oSZINy6u/kw7eQNgPfWBag6q/8quDXLv1ZP31ucP8Vlw84pqF6wFNbkWM
         LSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/ANToTSa/j7n/2XWQBtsXQJRZiN06wcKLGRURhtcCI=;
        b=uwZfx/0zv2vyg9R+azUz/CahzajSOGR47rw1bwaiuTnsw4+hfpgH3ogxiOnocdS3B2
         sCUOSGitfY8EPfbPCOsb/MiqHZ/Hw5Bc4oGDUViQ/3tspcsCIvpITaUef4JQ5IzLhM31
         fN5xJ8g1QKVb4hlq8YF+eLDy94SK/YwlWa+50fs2DMvJLj1CaaN20FbT/3w4n9dxDt5A
         ORTvuyxPLXPHavPxqvYtkmHSjvYLMG5xUy3HHXnyqnuVzWbVjK/6VKx5X7wfOThox2cy
         bV8uEKkES7nxP/cybGwJMqynAELBjLCG7TeHHWA2LR45sTrr7Ecu1TKpeAYKnPWioU81
         SxDg==
X-Gm-Message-State: ANoB5pkafC+wvNm6XNCsna1ImoNfh2tPhhECIxEx0ABb/oRXTPFIpK/W
        rVb96NS5HEYUP7PUZ5tP4LY=
X-Google-Smtp-Source: AA0mqf7InIFly7hkmFimq2M66xxTUYtQpAAkgbpmEoP9J92kgZluhq62gPT5lIsUZahjQ3TmmM9tMQ==
X-Received: by 2002:a63:4755:0:b0:477:1bf6:8b1c with SMTP id w21-20020a634755000000b004771bf68b1cmr14573203pgk.25.1669361465457;
        Thu, 24 Nov 2022 23:31:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b001892af9472esm2551557pln.261.2022.11.24.23.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:31:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
        <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
        <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email>
Date:   Fri, 25 Nov 2022 16:31:04 +0900
Message-ID: <xmqqk03jcwxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` is the
>> system name, i.e. the output of `uname -s`.
>
> This `uname -s` doesn't work well on Git-for-Windows (GfW) / Windows
> because GfW has its own internal compatibility code to spoof the result.
> ...
> Or just drop the mentions of "<uname-s>" in this commit message and
> rename it 'sysname' to match the field of the struct utsname?

FWIW I do not mind "sysname".  It is much better to say

	[includeIf "sysname:Linux"] path = ...

than "os:Linux", as "sysname" informs us the granularity used to
identify the system better than "os".


