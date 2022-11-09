Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D87C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 07:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKIHCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 02:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIHC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 02:02:28 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0644363B1
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 23:02:28 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 8so10475506qka.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 23:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAS3icPBks4cI368KYt1LWT6MjYl6K9JfpSH7rCLzeE=;
        b=ObSbrHRwDuXGq7f8uJuBXLGfTRgCR4z+RboYVYF7VsoxFcSd9zSHRDjspF2m/GX/i+
         8jgceDt4Q9ruciuNq97nMI1DjYdcRRTaldJjZ6gUQQD2mO2A7Y9ijBSz9iSUkGF3wWun
         wXGgZ/Fr5KUjgvmRm9KgijB+nvtIcg6S7FCfrUzIMKJbnXdVV7fow6tsAJaqpUls1f7N
         G3u+qYPJ1pL3WAjgR6yXNXCni2agpWraUR5KJdDpAqL7/lfvDIzz7MzliV2Jx3t+gdfa
         dL9Y0uHnn+YFHvaJKTXNFwoEsWmVO3pMYu6xhtObtRfr9nHNNTqUwwHHpOdVSLx06gdU
         UzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAS3icPBks4cI368KYt1LWT6MjYl6K9JfpSH7rCLzeE=;
        b=MszapzAUcsDb4WgF7kYoX220Z0WAXosFlHfA1pGvU246Wbq2U6T1Adr0AEOClFp3Y3
         qjkNLbMEWp3qnpG68DjMTC1EO8/MiTzvPitkmh4lQRJa7LYdzJt2KkaNk112zFCotsyI
         ROav749sJLUV/8jNV32hKRyTVcATAwF7c/LXWIZpFdyiN0k25pTOF+DoXKXID475dMXd
         VzatYaC2P7+DDZfFFly0nzzkT1zM/Q3GiWr8ftB2mewcXphr9A6ZuP91BKZqf0gnofPj
         qtHTn2VcxazR7VhHfqHFzfGJ+jrem/6HgXoWtygzxasv6b+JOBlERMokUZnAezQ9axM1
         5zkQ==
X-Gm-Message-State: ACrzQf2NE83mxZvmgohhXbDBsisbTSRjyn9DmqV8zf3L8CQu1HXraQ71
        r/OnFfsjKXeOuQbqbiWL7uCTSZcCOytVkQ==
X-Google-Smtp-Source: AMsMyM7C93SWswFt4hgoe+byWniHu0tcmUap5tygZePWWvDRDypLJI6uN1YigmsjNDh1WDF18Vwi+Q==
X-Received: by 2002:a37:2cc6:0:b0:6fa:3916:4213 with SMTP id s189-20020a372cc6000000b006fa39164213mr34443610qkh.449.1667977346899;
        Tue, 08 Nov 2022 23:02:26 -0800 (PST)
Received: from ?IPV6:2605:2a00:9005:dead:a5ad:28f9:f53:90b4? ([2605:2a00:9005:dead:a5ad:28f9:f53:90b4])
        by smtp.gmail.com with ESMTPSA id z9-20020a05622a028900b0039bde72b14asm9480487qtw.92.2022.11.08.23.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 23:02:26 -0800 (PST)
Message-ID: <536bcbc6-df12-e3b8-f995-35adfd311a84@gmail.com>
Date:   Wed, 9 Nov 2022 02:02:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     "J. Paul Reed" <preed@sigkill.com>
Cc:     git@vger.kernel.org
References: <Y2A1bdiw6kGC65f/@sigkill.com>
 <bc3aa4b1-4716-cf9c-5dff-22b25793f66c@gmail.com>
 <Y2rhfTYDEGQ7EhaS@sigkill.com>
From:   Thomas Guyot <tguyot@gmail.com>
Subject: Re: Odd git-config behavior
In-Reply-To: <Y2rhfTYDEGQ7EhaS@sigkill.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-08 18:08, J. Paul Reed wrote:
> This does beg the question: does running "git fsck" on an untrusted
> repository as another user present a [security] problem?
>
> If so, should it?

Probably not, but I can't say for sure. Even some seemingly safe 
commands can be dangerous in this context; for example "git gc --auto" 
invokes a hook which could execute arbitrary code if run on an untrusted 
repo.

I haven't read the CVE but did notice the change - the primary issue if 
I'm not mistaken is when git behaves differently when there is a .git 
dir that could have been placed by a malicious user. I believe a safe 
approach has been taken where we have to explicitly whitelist repos or 
paths where the repos are trusted
>> What was the return code for the git config command? If it was zero when
>> it didn't parse/output the config option you asked for that is
>> definitively a bug. If you failed to check the return code of git-config
>> then you should fix your script/tool instead.
> underworld # ~preed/src/git/git --version
> git version 2.30.2.4.g8959555cee
> underworld # GIT_PAGER=cat ~preed/src/git/git-config -l
> underworld # echo $?
> 0

We should test with the latest version... If git ignores the config it 
should warn (like other commands do) and not return 0.

Since git normally uses the global config when not a repo, it appears it 
keeps looking for the global config after it decides the local one is no 
good. What you see with this command is your global config not your 
repo's config.

Regards,

--
Thomas
