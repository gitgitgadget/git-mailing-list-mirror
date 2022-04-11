Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E0BC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346699AbiDKNtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346784AbiDKNtF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 09:49:05 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DF326ADF
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:46:26 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k25so18680835iok.8
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ptkYXecMVtdYahMdlMmEkysJLMAymGDJnn751cwGa74=;
        b=YZmXqsYYGutXRjmcGp+e9gFRLEUN16uh3fFkoXKWgKJXfSaagvMbmIOBE8YS55Ihw9
         R5N0LYqQ1TIaHWllc97/2ukp2TmrOzG9WKryche2IK2+ZJzA5ZeWMrDCHGNz6LhhgDtx
         mbvCs0ysXpdIN7zu4SEg+McT59jSIn6kufdwVOW0HsTdrvuKhGavcLeNURn3qKdvrL4O
         26AlVnOoEyO6P+nU0/8KX9oC/hyKuImDqmMGrVVVMN94p2XiRazlQwGc2L5D1jpOXnN7
         N5UGgUP0PZaIBDuG6vJBLlrpIAKFz3w06/Yxls/mCp5YQ+KJgtv2QG8Tg7w3XHel5Wl7
         2pHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ptkYXecMVtdYahMdlMmEkysJLMAymGDJnn751cwGa74=;
        b=ci+/aCWsl45m7PycQ7lrhQbRyz2yikmXoitmDnvJGJOIXY6BuTzr4Xsgr4QZJYyG9k
         2XVQUcIEUxHnJqwKdYHDvuguITDnCz1m+0pPygzmlpzBGp5CkaQbIR63JyCX1GsNaaSI
         EoonYZP44zGFQcUQfCVOEzhPxO9Ws5mT8r0rJjZ8croz0P377LgnsB9uw6wSfDKruInr
         WAM4+Lzsymj+D5jP3gjj4lOVUXcL5nLButXuptAwk7CZsdIRNWHg7hxf0omq1VNA7wO2
         BJrrDkc/MwPcJ8mIUXfuk26eDw2amsG2jjPPeoctB1vp5moO8uT70NEBusMY/rD53yVf
         knWA==
X-Gm-Message-State: AOAM532LCzXh19yzpwNoVtKwpQkvmjTSqnP+YLFqeKm7Trf6Li4e0LzB
        TlD+OBhIokGGakbQRk4P+1BU25AZmB7c
X-Google-Smtp-Source: ABdhPJwaMAriI4pGirqCTgssrJS0ouekTmU7h4iY4mZsx/SHEvBDJLin+nW2MI1b3iISc92a0h2fNQ==
X-Received: by 2002:a02:cd15:0:b0:326:176:4fe9 with SMTP id g21-20020a02cd15000000b0032601764fe9mr6610942jaq.134.1649684785870;
        Mon, 11 Apr 2022 06:46:25 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b12-20020a6be70c000000b00648f61d9652sm19958525ioh.52.2022.04.11.06.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:46:25 -0700 (PDT)
Message-ID: <edea2223-a9e1-c026-089f-80ea36cf97c2@github.com>
Date:   Mon, 11 Apr 2022 09:46:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Issue when using the fsmonitor-watchman hook?
Content-Language: en-US
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Community <git@vger.kernel.org>
References: <3ce82619-6305-69b6-b4e5-bbbc91c17530@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <3ce82619-6305-69b6-b4e5-bbbc91c17530@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2022 2:21 PM, Kaartic Sivaraam wrote:
> Hi all,

Hi Kaartic,
 
> I recently installed v2.36.0-rc1 and started getting the warning about
> the deprecation of core.useBuiltinFSMonitor configuration. It appeared
> for each 'git' invocation which was a bit annoying. Fortunately, I had
> some spare time so I went the route of actually applying the suggested
> alternative rather than suppressing the warning.

So, the new alternative is to set core.fsmonitor=true, which continues
to use the builtin FS Monitor. What advice did you see that was
different?

(Also, this thread will only apply to Git for Windows, since core Git
did not include core.useBuiltinFSMonitor. Feel free to move this
discussion to [1] if you'd rather talk there.)

[1] https://github.com/git-for-windows/git/discussions/3251

Hopefully using core.fsmonitor=true solves your issue.

---

If you really want to use the Watchman-based hook solution, then
here's the rest of my response:

> According to the git-hooks documentation, I configured core.fsmonitor
> to '.git/hooks/fsmonitor-watchman' and after that for some reason all
> the styles in the terminal seems to have gone awry (I use Windows
> Terminal with PowerShell 7). A sample demonstration.

The hooks documentation will only discuss the external hook-based
FS Monitor, not the builtin one, so you are changing your behavior
here.
> Also, I got the following error messages when running 'git status'
> 
>> git status
> open2: exec of watchman -j --no-pretty failed: No such file or directory at .git/hooks/fsmonitor-watchman line 78.

> It's clear that I'm doing something wrong. I'm not sure what, though.
> The fact that I have no clear idea about what the fsmonitor-watchman
> hook does, does not help at all. It would be great if someone could
> help me understand what I got wrong :)

The .git/hooks/ directory is populated when your repository is
created. That hook might not have existed in your installed templates
when your repo was initialized.

Further, the default name is "fsmonitor-watchman.sample" and you need
to change the name (after inspecting the script to ensure it is not
malicious). You can also find the latest copy in a more protected
place: C:\Program Files\Git\mingw64\share\git-core\templates\hooks

The .NET version of Scalar used to update the hook from this
protected directory on upgrade. With the builtin mechanism, such
efforts are not necessary.

Thanks,
-Stolee
