Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F5DC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD86561157
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhEFQsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhEFQsb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:48:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B724C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:47:33 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d201-20020ae9efd20000b02902e9e9d8d9dcso3880506qkg.10
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IhWub3wQ23RTdw09gO0cSJ2VGppPgjMAEx14sul5pY0=;
        b=U7lHZhPvvRXib+cILi3jfQgE7uZywzZTvW97Z6bTodIyrfMizoy6shLeYuDExNDeLw
         9nsI1xW/Cwd1XYd4H430vM+gpcDRxhNjZqTl8lVFpPrgOe+kOAQ2c7VxtOvo1yaEMrer
         mOjvMa/VDKqNOQi9uQY9vU5i4H1rq7X3B8vdZ8n3LP76Jnr2IfqkCsB1v2xuWREmAw1b
         dJ24TW558lAhPqksRGPyzUIzlAHZXUZY9TNQqcVDAw5ZTmoqDJK9dD0r+aF4g4cOLSSt
         iV6ihTJRSjZ+10HVfOxOayRr8hZI3RZmAEqjjsGNI3iqUnnuxptHCuDelW+k8aKEr6hc
         kelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IhWub3wQ23RTdw09gO0cSJ2VGppPgjMAEx14sul5pY0=;
        b=FAQ+/vSW935AbKyo7BZYqWA4eSxdhX4ydo+lRiJU7ssKsKOwqB7M6pEyilLQIQP19L
         YgLAjJETUeQM34vHtnjWuS+5ANvwMgyXwoQW11vn7I3ba+7ku8DOvY4gscXb1KKL5zqR
         J0PT7HsgaJoS41efLX9ZOPGtWI1Hbt9sYPneJEKYhfibTs9AmLN7PzWRcgf+o6XUiJqh
         r5SZkj63E33J67AHUjc4XPYBUQmK4zwe86kpzAt4PuUn7w5SFHD3mxv4VTXBZlgn8OZq
         2DKBj7hXqMk3ISxnze+X0iJCyjNSsehmADoNnZCYsWvcVbYTOa4JWtf7kNhkbls2r23K
         5snA==
X-Gm-Message-State: AOAM533E2MHxGM7BR5CJLvvJpHwNMdUndWtBFNsBri8C58pDSNKh+gJU
        YLrZ8Zl4RxqjjHsnv72o6LUjq/j7Ejmr87XObpKX
X-Google-Smtp-Source: ABdhPJyGEdBpUGP8Jx71syTMJvyrzlo6GOAvDpecf2hYOpD4iZHPfvxY4ncOjw3IsvRjX0qw6ZQVOMnnwt/BsI8F/j/C
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:55ab:: with SMTP id
 f11mr5420798qvx.49.1620319652436; Thu, 06 May 2021 09:47:32 -0700 (PDT)
Date:   Thu,  6 May 2021 09:47:28 -0700
In-Reply-To: <20210506073354.27833-1-dyroneteng@gmail.com>
Message-Id: <20210506164728.336409-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210506073354.27833-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: Re: [PATCH] Optimize the description of the configuration in
 packfile-uris doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> There is a description problem in the document about packfile-uris. This
> patch describes the configuration format of `uploadpack.blobPackfileUri`
> more accurately.

Thanks for noticing this. The diff itself is correct, of course.

As for the commit message, limit the title to 50 characters or fewer if
possible. Maybe something like "packfile-uri.txt: fix blobPackfileUri
description" or something like that.

Also in the commit message, maybe mention that the correct format can be
seen in t5702.
