Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F20CC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 10:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0954E207C4
	for <git@archiver.kernel.org>; Wed, 20 May 2020 10:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3ekX8T6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgETKgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETKgh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 06:36:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA70C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 03:36:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d7so3142291eja.7
        for <git@vger.kernel.org>; Wed, 20 May 2020 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pjYiTBqkwsYUplSR4dnaAaoVAZ5uDNKXGZBp/e56O4Q=;
        b=O3ekX8T6zWti83g/7lijUjcL7/LIhhyQdcghhPUtZygt2tpK1CdYlqdpKWDx288cYs
         lcabodklyui6QUn6FKPWSKBlU9Pgq481Z1PGrcGfxtUR3ivkg4dC2TUz4sR6lSUUVhWg
         ngsVW9wnC7eIqBKJR1irBhLedWUroHLtAscpvS5QI5SGdXcc8jI1pPbfNcz2f0E7tgFz
         gVu/ccpLL6kJvyRKiKHZnWaMjlZR8Dy/NnhfefbddXKw6WYfyduNvd7OZqkL8OTh7+hA
         1+Bo7U4e389gLL0OAnKLNE0uuClqN3PVafpvuQ9qar+pbT/v6vERGTfMBPN/7zwUrhzV
         +sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pjYiTBqkwsYUplSR4dnaAaoVAZ5uDNKXGZBp/e56O4Q=;
        b=tmmeN5/7hSqYnTcveplHGr5oBh5QjTDQf+NdzWlGP3NSuTLXNaVTOzMj8+VmVLWcIo
         lSCALD0ZRZa9seLV+7jcarNewa697dCiiK3iEfyA4VtcjaiarbdNnHNBrnLQwpJLkMQ7
         RtJEOf6RX4xj8oTxxtYh+pFc0VpQkbGdoNFCcz0SV3xK7vxsT4VcsNnZVRnPpOfoWEsR
         1390PvkjbvjOI69qNZIMMGoXjq/QWqHiqzvjs2VRysil3k0GOA4AUC6/Eei5lO5OZpwf
         on1UpylnEMGmf7temfeo+zmLH+7lRj2Ox/YSAHEwLhN6QbHFlccaYDSr3qINbeJk/sx9
         nvBg==
X-Gm-Message-State: AOAM533XP4dLjjZYXx2U0cpk9FtbqosiOI4KDnaaWDT5blEGplECcVbX
        UKbncZ8UmOXDaU3sn3vYdvS2QKFr
X-Google-Smtp-Source: ABdhPJwv77HzSlqaw/Ff7njMDOC1Av0iwVfgP67LgZe6bTqwW2fM2b/5+p/C++MW3hbtTY+ljY0MpQ==
X-Received: by 2002:a17:906:1fd6:: with SMTP id e22mr3319373ejt.190.1589970995522;
        Wed, 20 May 2020 03:36:35 -0700 (PDT)
Received: from ?IPv6:2a00:6020:22ff:ae00:d228:1423:c030:9e9? ([2a00:6020:22ff:ae00:d228:1423:c030:9e9])
        by smtp.gmail.com with ESMTPSA id c20sm1448291edy.41.2020.05.20.03.36.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 03:36:34 -0700 (PDT)
From:   =?UTF-8?Q?Jonathan_M=c3=bcller?= <jonathanmueller.dev@gmail.com>
Subject: Bug: git worktree remove and overwritten directory
To:     git@vger.kernel.org
Message-ID: <89526b3a-297d-591d-6e12-48580d697ed5@gmail.com>
Date:   Wed, 20 May 2020 12:36:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies, if this has already been reported.

It seems to be impossible to remove a git worktree whose location has 
been replaced by the main working tree (don't ask how I found out). 
Steps to reproduce:

```
git init test
cd test
git commit --allow-empty -m"Initial commit"
git branch some-branch
git worktree add ../test2 some-branch
cd ../
rm -rf test2  # Remove the worktree folder
mv test test2 # Main git repository now located where the worktree used 
to be
```

Afterwards, `git worktree list` reports:

/home/foonathan/test2  e7bb748 [master]
/home/foonathan/test2  e7bb748 [some-branch]

And both `git worktree remove .` and `git worktree remove ../test2` 
report an error `fatal: '../test2' is a main working tree`. I had to 
manually remove the corresponding folder from `.git/worktree` to get rid 
of it. The issue is especially annoying, because you can't check out 
`some-branch` anymore (as it's already checked out in the worktree).

I've tested it with git version 2.26.2 and also the version currently on 
the next branch.

Thank you,
Jonathan
