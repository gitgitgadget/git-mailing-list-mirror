Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2DAC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 13:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbiCWN3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiCWN3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 09:29:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0886352E0A
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:27:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r22so2803509ejs.11
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IYM+U4LpU/F8B+zeWGHIwje4RzfMp3hsb0qenHeoX0w=;
        b=coK1EXOQM/xO1biOL91r/ZsMnopOaY/oDCnKsVVQEWJ6ca8Lwcswaef7M67vyV4S8n
         dVuIGvE0xGeCpV+c7md3TY4m674Jq3mgK6K7aod4JI/22nsU7iCMKQEDYpticZMb4rzP
         S4fODu8OFvKxtyqbItyC7MbVLNuNfrd7Pi2z3xBokDEvwBfKujMHJ/6Gmzd+m+4frpcC
         NqC07N3nykmlbKI48jlVpOFCxYmLj9KCKc4/uPAVwQ5Svply7EMVDR78K7KrXUdcG2Wf
         uUbLUwHidZhZevFngwG0tYwirG3um09yKQk/lutcy9ALATZ+V9Ia/PhT9Blq1daMtfc9
         mHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IYM+U4LpU/F8B+zeWGHIwje4RzfMp3hsb0qenHeoX0w=;
        b=kIRZZHKsLuaCVvG7DqmOCdiSgZN1H+LUiG1ZuGIxcXCFMLvVzY5chgI2FlJkriOXaX
         ewiZyF/mjszYikQjvd6Kwb6sgL0GApl//xdo35gbzsgbbRCsVJZAiseqxW2v8gsR+izW
         wzeJQ/xXQZTkZbFA+yKOSpUYWZxcuipfHEg9jXPHfdKK2pdF92+fXTubiViud25ugd/8
         SeMZOIL7p6YyACG4TDPEg72mFZzpmR73KJKYKWpqmgwJJ9nocI8aKPyMVcQo9griT/7X
         GoweUEpIgWAXznieoLOhtPp1+wm6XzBHGVmjqlsNIH3tBwoV88FGuHdoV5R7gXBe4Po9
         H9Yw==
X-Gm-Message-State: AOAM533ttZgOvGWJCvd611bkAFsrh8wygIA/G0vWYtfM1lVpd2U5R4jy
        73ctbiI7Ir9WViW4WAAykUBPdkgGiD2P/g==
X-Google-Smtp-Source: ABdhPJzh8Je9kfiFNQLy5aWEMsyh3AIGFDfc+O4T31WoNlShK/gxPHsWJ6Ycv4wd4lTsHdtkMzFciw==
X-Received: by 2002:a17:906:6a1b:b0:6df:af36:dd43 with SMTP id qw27-20020a1709066a1b00b006dfaf36dd43mr27106948ejc.359.1648042058174;
        Wed, 23 Mar 2022 06:27:38 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b004162d0b4cbbsm11449701edu.93.2022.03.23.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:27:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nX11U-000nbv-V3;
        Wed, 23 Mar 2022 14:27:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
Date:   Wed, 23 Mar 2022 14:26:50 +0100
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
Message-ID: <220323.86k0ckol2v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 20 2022, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
> [..
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 889522956e4..a3798dfc334 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -628,6 +628,13 @@ core.fsyncMethod::
>  * `writeout-only` issues pagecache writeback requests, but depending on the
>    filesystem and storage hardware, data added to the repository may not be
>    durable in the event of a system crash. This is the default mode on macOS.
> +* `batch` enables a mode that uses writeout-only flushes to stage multiple
> +  updates in the disk writeback cache and then does a single full fsync of
> +  a dummy file to trigger the disk cache flush at the end of the operation.

I think adding a \n\n here would help make this more readable & break
the flow a bit. I.e. just add a "+" on its own line, followed by
"Currently...

> +  Currently `batch` mode only applies to loose-object files. Other repository
> +  data is made durable as if `fsync` was specified. This mode is expected to
> +  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
> +  and on Windows for repos stored on NTFS or ReFS filesystems.
