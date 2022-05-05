Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216C6C433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 12:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354206AbiEEMIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 08:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359552AbiEEMIE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 08:08:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AFC54FB2
        for <git@vger.kernel.org>; Thu,  5 May 2022 05:04:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4947982wme.5
        for <git@vger.kernel.org>; Thu, 05 May 2022 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=TwN3I7+y5YjerUJvOtFgXruTNrPEO+SKGcOtjjS695k=;
        b=gQSqEyWLx+EPPTCSOQIuxW5x3pHVq5jdUH1bEwkB/UpQPab93Ea8lzV8CFcQoOOvkw
         U8zXvoceauDt5/8lU7WZUWlD61ZpqCLrSyFNZei3Kff3wwleJGjuFCJbYAj1oKkhkvY5
         dY09U6hXMGc41utTxz/EgWz2XEyJgYsC96m2PRo3kAKhWu0Ygziuuz484rijNDrn60KU
         1QTcJPWbrrI7ipTlkmCJuDoISffANK+nNltg7hukuGljSkq0u8+KpbJ94fVrdW9okwM1
         ek0lV5hhylvchIVqZni24v0hgFY/PK4o5vNE7lYViQTmyPpX6RZ2c05XPjk/AcAHQ9dE
         Lg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=TwN3I7+y5YjerUJvOtFgXruTNrPEO+SKGcOtjjS695k=;
        b=blhMJaCFPKy96hNITCLUKgXcKp2Tif1CF1vYvj+ay8lSW9bcat7YLm/fNljlviLqSw
         awCUvwLOrORzTQrQ0Oa6B1LHCBf9SfddZzmQWP1ONArjoV8ggjzb90/QULlqChXSxeIp
         MQQR7u7NQ8JTn3cESXgx/IGm8Irv/hW+oQTz5o2lDkDQarcNyxFwG/9oGYtIhT5NxW9T
         J4H4CXWr4nEZ0gqv4a5W9EsCcFcebTK33MfAXvs1akwkDKNI6qhJvx2vj8UoPivav2sW
         7d+gNSoVQkCGTh8p/kh3SeZ4T1pSizk+XfHcJaBHWzlFQauOdA42OQ6GgeYMJ+D3Ko2c
         OT/A==
X-Gm-Message-State: AOAM532lx/jMTz1NnarF2GdPlJZrh8XdNN7NsT1fJX7uR1O2NvFyIAxO
        yDM1YOZXHmVFyB1QFFjFu0I=
X-Google-Smtp-Source: ABdhPJyv06cQYnJtqTCYOyK52FLbibPgyP5sg0wHry84OtheylcmYf5I6hkAyvFUpWC9/PQ/n67YTA==
X-Received: by 2002:a7b:cf0a:0:b0:394:7bf:66c7 with SMTP id l10-20020a7bcf0a000000b0039407bf66c7mr4345403wmg.52.1651752262742;
        Thu, 05 May 2022 05:04:22 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id 13-20020a05600c024d00b003942a244f35sm6935609wmj.14.2022.05.05.05.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 05:04:21 -0700 (PDT)
Message-ID: <5d7ace7c-17d3-591d-6cca-ba5223449609@gmail.com>
Date:   Thu, 5 May 2022 13:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] setup: tighten ownership checks post CVE-2022-24765
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, junio@pobox.com
References: <20220504184401.17438-1-carenas@gmail.com>
 <20220505005009.27789-1-carenas@gmail.com>
 <41ec8c09-f31f-46ce-d6ec-4b6fdd78228a@gmail.com>
In-Reply-To: <41ec8c09-f31f-46ce-d6ec-4b6fdd78228a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/05/2022 10:40, Phillip Wood wrote:
> [...]
>> To avoid that, extend the ensure_valid_ownership function to be able to
>> check for ownership of both the worktree and the gitdir, and use that for
>> non bare repositories.
> 
> Looking at the code below it now only ever checks the ownership of the 
> gitdir, it no longer checks the ownership of the worktree. I haven't 
> really thought through what happens if I cd into a worktree added by an 
> attacker to a repository that I own which has extentions.worktreeConfig 
> set. My initial thought is that if they can add a worktree then they can 
> probably edit the repository config anyway but I wonder if an attacker 
> can set GIT_COMMON_DIR to a directory where they have write permission 
> to add a worktree to a repository where they don't have write permission.

Thinking about this some more, I don't think setting GIT_COMMON_DIR 
while running "git worktree add" will help an attacker as the worktree's 
gitdir is created under the main gitdir. I've had a bit of a think and 
I've not been able to come up with a senario where GIT_DIR and 
GIT_COMMON_DIR have different owners that is exploitable but it might be 
worth someone else checking I've not missed something.

Best Wishes

Phillip
