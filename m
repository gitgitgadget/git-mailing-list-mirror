Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93990C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 02:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFED61263
	for <git@archiver.kernel.org>; Thu, 13 May 2021 02:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhEMCqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 22:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhEMCqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 22:46:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F039C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 19:45:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y32so19936259pga.11
        for <git@vger.kernel.org>; Wed, 12 May 2021 19:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UFQyt+/ygfrk7HKGRbTg86BABij+ZCSGrWdIzlDepbc=;
        b=Z8Hou1hQlIpXAVsqaovo+ycF5jOAB0XmmvOUHcV9mEa90e4+BNVrh/vU2aCGIpBmKM
         c83+etHpMnXJVNhMKGSugshpN2aGxEYm2g1AHS5vI6UxwG6n3AsPl6J5DSFZaVZInCUY
         tZTIsNlgQkxxuJELLkq89TxdNSJtZ7HyqzXBBHFiKmOtr8yrwL1tetxSET1Y/oL1NgP1
         FbwkJ/qA4x7N5P9dJEfALltAmfr4h2IM1ZlOaJjUopQpXwBqqnD+KHR0Eez7AZh4gMfC
         xhg4hAOULa66TDcEv1Lm1MfAxzx4xm64y/ErmTGfNXDvIls0tSp0n4Y5hdwwFxNWz6bv
         E7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UFQyt+/ygfrk7HKGRbTg86BABij+ZCSGrWdIzlDepbc=;
        b=oZOAA7lWX6wgDcaHBP3ZKmalkNSCz0R6cF9gCVzZ0rdFLb9Nw6gsypQPU3cn9zH0JG
         WEIuFUaYFAE37rpbg+bKaxtbi8kml8FC1uOa9hTj8modGLbxpCzqqC7iFb/VwTKfAHoW
         63tkEBWDJlaD0UrUQrn6zO9A6jr4FnFl0fHfZEmY+CBQDgGz+saDAEsAnnLG6AePfr7Q
         9vgt3jmysQdzRbxic7VfUKp2MG/1sFhFMoKm6flNrR6mrrfdUggJO5HUjyEd9ZBI83oP
         MqylcWEjBW+my0DNpLM8QfuowYxrdE5T7j4NhP24E0cP244/F2MjXuAepwx3KRcUwo95
         ofSA==
X-Gm-Message-State: AOAM531cktdrvfCSni6KfsTd9NtuWnhfRkvzMrGXWw8PFSwpeWPdVAGL
        SDEU0OP1v0POZnx9NiWlg8Rnbv64oDXJgiE7zc3/oCE5syL0NiRioUiSng==
X-Google-Smtp-Source: ABdhPJwu6KkRQBZ/+m1jMxKfzTOcYYZVz5aluyvnIuKWCgYxat3mK+N6pJUNHfbtdxi/DXKphQWIOWNSHeiUMgkdu/Y=
X-Received: by 2002:a63:7703:: with SMTP id s3mr39492496pgc.339.1620873935646;
 Wed, 12 May 2021 19:45:35 -0700 (PDT)
MIME-Version: 1.0
From:   Teng Long <dyroneteng@gmail.com>
Date:   Thu, 13 May 2021 10:45:24 +0800
Message-ID: <CADMgQSQyn7MvzqYSbou=N3ArYATtr7JP=sqS1PNS1Tr0sO2s8Q@mail.gmail.com>
Subject: Re: [PATCH] Optimize the description of the configuration in
 packfile-uris doc
To:     jonathantanmy@google.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>As for the commit message, limit the title to 50 characters or fewer if
>possible. Maybe something like "packfile-uri.txt: fix blobPackfileUri
>description" or something like that.

Thanks for mention this, "packfile-uri.txt: fix blobPackfileUri
description" is good and meets the "50 characters" requirement.

So, you are right and the title will be changed in the next patch.

>Also in the commit message, maybe mention that the correct format can be
>seen in t5702.

Because I am implementing another patch[1] about supporting the commit
object in packfile-uri, so I noticed the `configure_exclusion` function in
t5702.

Agree and will include it in the next patch.

Thanks.

[1] https://public-inbox.org/git/20210507021140.31372-1-dyroneteng@gmail.com
