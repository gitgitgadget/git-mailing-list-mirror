Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FEC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA11D60F22
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhGWSPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSPS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 14:15:18 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D5CC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:55:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s16-20020a170902b190b029011aafb8fbadso608218plr.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wwhig0yjO8dE1/Wg0hM5URBO+STsqzsSUPZ70I0nNOc=;
        b=qef3QuSL1SSTM068vTukSC36TqHipm7Pl0qEag6G12TJ30EITJ7YUuaJ/FQmhdJyzU
         YNdFgUK+c8bbSaY8QQd1r+/Qv3GS0V9BAqxngnCibIGDGlk+wD55ckLA0aTXF06JQIpu
         67BjPwd2MR9u8scDVYsx/n3S4CYAUTQdFUhyE/DLFRnxp/sh5ATN+eb+QFtsRSB4QneY
         4LgY6R1joph7krQROVebMerrOSq7hk1MYgYtUEqUV4T/q7mEP/QKz8QzDuYs0eII0zGt
         Em/LpBAsH5llpjk6ycyyaULkh9V3c/Ml5crYmCn7M4GZ1BVOmTmPrvj8xDu1PGuRmB5d
         CY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wwhig0yjO8dE1/Wg0hM5URBO+STsqzsSUPZ70I0nNOc=;
        b=ces8Z/X7cJ5ReViu5NcKEwe0TC8M5vGGEzyv62OBRQRo8v9w1AjKSjkTrBcFLOlR+Q
         gzd7nzMokWbGkh/Y+DpFx6rEFgz3ubKWUHcMs7COs2/0KT8UpfAvWIKaS9XJWUh7nl0g
         ECvJo7CY7WEhIdHHO/gDIWzQWzKWUXEZrjf4Mh/6Wad0TOEdxncGV6GsbTjDDY1Ihsyk
         wfsbx4mhVs+n310xOH0vzWdC6Gau9kAtymzv4AdWTJEljTtLAvfus8RikOuIlpfpWTtU
         2WowBxz6WoXw+UgdnFd2oNxO4n3nr1aF4B1YoMZVmXquZhPgEwDGxKjxRkBokQjcORIL
         XYvg==
X-Gm-Message-State: AOAM533cClrz1GKTslMuIjwVxv0IxFpASEOjA1yXbqZusTqPYCruV2sq
        aJZjFVom09nJI5VVnYaxA7Q5wqShF3l0hpR3vShM
X-Google-Smtp-Source: ABdhPJwWom6pWW3o6bIfuntkSMAX4vKlLlCwyKF1znxuTuHcDbwXLsc0XjqHfTiMlWnkg1LMkuQRDAXKrB4iAV75J+gm
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e291:b029:12b:b872:2e2c with
 SMTP id o17-20020a170902e291b029012bb8722e2cmr3740507plc.80.1627066550966;
 Fri, 23 Jul 2021 11:55:50 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:55:48 -0700
In-Reply-To: <f4881b7455b9d33c8a53a91eda7fbdfc5d11382c.1627066238.git.jonathantanmy@google.com>
Message-Id: <20210723185548.1784350-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <f4881b7455b9d33c8a53a91eda7fbdfc5d11382c.1627066238.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [PATCH 2/2] cache-tree: prefetch in partial clone read-tree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "git read-tree" checks the existence of the blobs referenced by the
> given tree, but does not bulk prefetch them. Add a bulk prefetch.
> 
> The lack of prefetch here was noticed at $DAYJOB during a merge
> involving some specific commits, but I couldn't find a minimal merge
> that didn't also trigger the prefetch in check_updates() in
> unpack-trees.c (and in all these cases, the lack of prefetch in
> cache-tree.c didn't matter because all the relevant blobs would have
> already been prefetched by then). This is why I used read-tree here to
> exercise this code path.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

Forgot to mention: the $DAYJOB case is the same case as in [1]. In [1] I
noticed that the object wasn't actually being used, so I disabled the
object existence check. But that's probably the wrong approach - if the
caller really didn't want the object's existence to be checked, they
could have used WRITE_TREE_MISSING_OK when calling cache_tree_update().

[1] https://lore.kernel.org/git/cover.1627066238.git.jonathantanmy@google.com/
