Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD387C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 02:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiDGCYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 22:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiDGCYM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 22:24:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0FA12F161
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 19:22:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t4so3786439pgc.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 19:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MoNo5oiLjALqqRc8+3tmHHSbIUUavoFyhG9OZH7mPFI=;
        b=Ac2BNMMt5P3vgGiz1OXb4SuI7z559CP8oW3gwQRoBWYgj3pXuYqM4+ZGy8io3wvtqn
         GIbNofyGZaq2mFMEO+w+aWBQBbfnY83lOIVoadb/o6Rlm4xJ5gDiV1raXnLyqhHxJe9n
         Ak+yUCjDiLz6gTqK9Hgs9HBTr6NK+aW6gnG+243ORt+t9bXaaTS8Xzf3Fpzan5+IOAuO
         gQL6R6Bl2F8grAPPVKxUQgq6adwNy/9Kk3dc3tJZTstauIjCUIzhaerVfA3D6yzAeDtR
         XMZQD7YPiSpaMFNomvndJe71oiQPA+wvKtxZ++wCVtKXNP3XRZ3alMDLL8UVJJ6qJRZB
         4WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MoNo5oiLjALqqRc8+3tmHHSbIUUavoFyhG9OZH7mPFI=;
        b=KFIsbGYVC4lOima+7RRX7L4joudALq8jfBk3alTEmTyJW+nxJK0BKFSEJ0rfVfuFcf
         UNMoafmHPkTZD3yLESGM9aMbhsxpdrkzOQFjQ5tjlhTs5Gn47WvL61x6XkLjlhGG7Duf
         1rHitdk9Cl9RyNDZzLwKOJsPSGUaBB5GkQUmXlVkFYSQ90AiIU3BjzPXg1kelBy8E8oz
         rJId8Iw81tAAXayllJQyQk+no5DuZOZM/NC3ewBSzOeap0Bt/6Lhog76E6Wp8wR+44kj
         7UlTu/lPhzsozZ3rBY6iN7OspTDzM5i0cdjoLt//uZmVk5Oke2bPY7jisLHge7bgfOla
         1mOw==
X-Gm-Message-State: AOAM532P9Vqe4GSxd9NihYa0zpB4iLOQtZ/28YkNxnvMZDOxEW3N39eH
        ZYNrH4pb6OnBYVRiB6BqFh4uuzvd+M2vxtI7
X-Google-Smtp-Source: ABdhPJw0uV5ZPl9mMQIaFOxvdDTHsJbmqOOjufp0AH3B5DN0h8o/J/+vSLGmZM9GFW8+0Xz4QlbJ8w==
X-Received: by 2002:a05:6a00:2386:b0:4fa:e772:ebac with SMTP id f6-20020a056a00238600b004fae772ebacmr12027763pfc.75.1649298132383;
        Wed, 06 Apr 2022 19:22:12 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a00198900b004fafdb88076sm20590443pfl.117.2022.04.06.19.22.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2022 19:22:12 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     bturner@atlassian.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org
Subject: Re: Git 2.36, ls-tree submodule regression?
Date:   Thu,  7 Apr 2022 10:22:07 +0800
Message-Id: <20220407022207.12542-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.583.ge72900576d
In-Reply-To: <CAGyf7-FjqrGYTUwdS=a6nsUnbn0qD9=Pf2Nx=gy6g8KGVRJivw@mail.gmail.com>
References: <CAGyf7-FjqrGYTUwdS=a6nsUnbn0qD9=Pf2Nx=gy6g8KGVRJivw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Bisecting the error selects:
> 
> $ git bisect good
> 9c4d58ff2c385f49585197c8650356955e1fa02e is the first bad commit
> commit 9c4d58ff2c385f49585197c8650356955e1fa02e
> Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Date:   Wed Mar 23 17:13:15 2022 +0800
> 
>     ls-tree: split up "fast path" callbacks
> 
>     Make the various if/else in the callbacks for the "fast path" a lot
>     easier to read by just using common functions for the parts that are
>     common, and have per-format callbacks for those parts that are
>     different.
> 
>     Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>     Signed-off-by: Teng Long <dyroneteng@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
>  builtin/ls-tree.c | 199 ++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 125 insertions(+), 74 deletions(-)
> 
> (I've CC'd Ævar and Teng on this message.)
> 
> Looking at the changes in that commit I see differences in the
> handling for long listings, so I tried removing the -l. At that point,
> the command works again:

Yes, it's a bug but already found and fixed by Ævar Arnfjörð Bjarmason.

> Given the command works without -l, and all -l is supposed to do is
> add sizes to blobs, it seems like something has regressed in the logic
> that decides whether to continue recursing or move on to the next
> sibling?

As you described blow, I almost comfirmed it's the problem that
found in [1] and Junio C Hamano already replied it in [2]
 
> Can someone else whose C is a little less rusty check this and see if
> it's a bug? It almost seems like it _has_ to be, though. Bitbucket
> Server manages bare repositories which often include submodules, but
> none of those submodules (even assuming they're valid, which is not
> always the case for repositories in the wild) are ever _fetched_ into
> that bare repository. That implies this would always fail in any
> repository that contains submodules referencing other repositories.

Sorry for the trouble.

Thank you for debugging this and reporting this problem. 

Links:

  1. https://public-inbox.org/git/YktP0LltNKq7JZZs@google.com/
  2. https://public-inbox.org/git/xmqq8rsi1ap4.fsf@gitster.g/
