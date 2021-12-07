Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54374C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 16:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhLGQve (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbhLGQvd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 11:51:33 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1487BC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 08:48:03 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o4so28725498oia.10
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ewqhJX+gYbOs4r7SrDfhxIM+2E+VVx9JN0g7YTCLeik=;
        b=hWRRQOBgmpbcgXMjWjKmajPJ29dA5aeDujXtIMgnLYuCvx8VTPXVef/JED8MYm0TTL
         hUrN4FTxeFGBocu+OLnyHJrsnji4r1k3kK3vRJgwrnaBLsPeCFT1M9Fnd63KSimHB+8o
         YaLU7DtppwKOUI6L0/vQUEEAovIyxDriU2PezSAZWK+ufazgjNnPQMZkdyCUYt4bLocq
         4eUXyq8Tfz0SZGiJxVQwEtZrwFO7pjO3muANXaw8O0xcIo6d/aSa5Uxel4O/9LWoZX0G
         pazuxhccnTZSn6mBB7odgKrLrTOuEFH+VPYkipXZQl7kFsgut10FZdSrztTLn+azFnYp
         1kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ewqhJX+gYbOs4r7SrDfhxIM+2E+VVx9JN0g7YTCLeik=;
        b=vNnB55n3lMPlMtURUpxFwTij3hGqkUM8krmZ2iJXuc3IXd7UhdRJo3aBm+ZwTDoV/o
         4s3ZA/zzSPmFKiRoaw+l5xcB+UZ06ESUnIqHpf4qJ3FE0xViFf4applNE5zsdnPngNJC
         Kfgfd1//O2LsYzPGwWsAtFeZ6ld3Emb1PuWZcvcUJ/oDITjsKSOsKMvgidXDWIxNmY+Y
         LURWIXIsUsIal7Yw5Sv9k5QdZYMiP2AGtj67+WUalXIlRw4oUY2eStneAFbVxKQ7s4IU
         +YhmKwl2K8nqNFPEk1PUJnWIbIjKdKApLdoGb+8UvNViAlJIbHVp4sja8CxmNlgsja8e
         /2Tw==
X-Gm-Message-State: AOAM5332JxnLIEezApRd5pXpERjWT4mNVrP1bBXIhsJ67eJ0K0joN55m
        Q3dFCH3eooVVT//o9OcpvhKwEBdXkpM=
X-Google-Smtp-Source: ABdhPJxHVVKAvik2ITGIAf4vG1QUoN1eBtmBPpWeLgi+qzp2EyKaDxnjlWq3peHMoH5OGfZS7ecWzQ==
X-Received: by 2002:a05:6808:994:: with SMTP id a20mr6369421oic.18.1638895682332;
        Tue, 07 Dec 2021 08:48:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id g7sm38362oon.27.2021.12.07.08.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:48:01 -0800 (PST)
Message-ID: <1e8bfab2-d556-bb96-95a9-2813857c45af@gmail.com>
Date:   Tue, 7 Dec 2021 11:48:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/6] sparse-checkout: make set subsume init
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2021 3:00 PM, Elijah Newren via GitGitGadget wrote:
> As described at [1], the split of init and set subcommands in
> sparse-checkout causes multiple issues:
> 
>  * Poor performance (deleting all tracked files, then later restoring many
>    and maybe even most of them)
>  * Poor UI (multiple progress bars in wrappers that hide both commands under
>    1 user-facing command)
>  * Loss of ignored files under directories the user wanted to keep
> 
> This series fixes this bug by providing a single command to switch to a
> sparse-checkout: set. It does so by making set able to do the combined work
> of init and set. It keeps init as-is to give folks time to adapt, but marks
> it as deprecated.
> 
> A quick overview:
> 
>  * Patches 1-2: small preparatory refactorings

These were easy to read and obviously improvements. They make the later
work easier, too.

>  * Patch 3: the crux of the series

Victoria and I had some thoughts that might improve this patch, but it
is high quality without them.

>  * Patches 4-5: documentation modifications (Patch 4 is worth reviewing; it
>    marks init as deprecated -- are others okay with that?)
>  * Patch 6: trivial modification of git clone --sparse to use git
>    sparse-checkout set rather than git sparse-checkout init.

These are good immediate follow-ups. I notice you left out the "--sparse
implies --cone" change, and I think that is wise to leave for an independent
series.

Thanks,
-Stolee
