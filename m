Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E9EC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 19:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbiBJTAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:00:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbiBJTAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 14:00:35 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE710B7
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:00:36 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z7-20020a170903018700b0014d964cd10dso2017576plg.21
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=IV3Qu3v1+KTY7poY7amRKn0HM2tDUXwF7jyI+jaVLiA=;
        b=UKqLD3jhfOw8FoNWZzxr3zGZP2lxEy7R3Sm3l+mTTsXq05dfSpznHP5tvH8eiPb9Hl
         85SOgcOUtKssIcDM1uBbAA0LXNWUXnHhBGO5mTV/Ufggs/vz4HsrFBTjOJ/LXKcNf7fl
         vqNJ7ub30dH0OHEk9Bc3K9agdadJg/CqAYVZRb9bQYFqnlfsfNL/LTJvdudYgIkIIAFk
         /t8euNipdyvvT7mhOcEkkRbsg1BEQvnV64PlSsxEOGkz3fpCZKyTdznR5p76eC1OivJb
         OKhXGE1aGGcSeECUKi6zOy65sbsN50wGd4ksd3hYyUrKPv3Qg54j+7VlyAPkI0ZX7koY
         rtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=IV3Qu3v1+KTY7poY7amRKn0HM2tDUXwF7jyI+jaVLiA=;
        b=eCfWi7gRDf35dL8WuiibEVslQ6xp/j5zBCOtTaXegoEhvZR0Kkq3ZRQdkTyfEOp4LH
         nya/B9znBW+HzZHOuJ5cCHUvT/PTAAmuj/mZ7FDWvQ07c0/L1oyUvmh5UyV+S/zAEvw8
         XI6l0qoh7mJrfLYW3DXOOURDRpVz7trzmQDILFutTAA/QEuuA2MvzFfKhu2jol9+26JH
         44QcuMjHM0wVhvvGtVDfY3mTdQ/7zDx8qsUj4HivUDlhr6TqWsE/I7xRwLWOwNbjL+2a
         nKvb2aRH/iUNgSLqIHwCDNY3cF3flyZQiyud1j+A3esKJxmOZUhg85RoD4ZKNvzoR0aZ
         JuRg==
X-Gm-Message-State: AOAM530lgCpdNKDHUkNGiCt+asagAF8O79SbYP3ytekNDQGhCv/5ugbt
        iDiExL2/nChKicv9Hd+2/AlegWI94/RWh2+R1jfh
X-Google-Smtp-Source: ABdhPJy9KXJlZ+CDgSTyzp2UCMHkMK7caFUPLyXasn3TWEQGuYYIM0+2UrZ6vx+WuWqHtCy4ElfBR+HsPqDxIzuDvFhH
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4c8e:: with SMTP id
 my14mr115210pjb.0.1644519635953; Thu, 10 Feb 2022 11:00:35 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:00:15 -0800
In-Reply-To: <20220210044152.78352-3-chooglen@google.com>
Message-Id: <20220210190015.657085-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 2/8] submodule: store new submodule commits oid_array in a struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> +/*
> + * Holds relevant information for a changed submodule. Used as the .util
> + * member of the changed submodule string_list_item.
> + */
> +struct changed_submodule_data {
> +	/* The submodule commits that have changed in the rev walk. */
> +	struct oid_array *new_commits;
> +};

Overall this change is straightforward and looks good, except that I
think that the struct oid_array can be embedded directly instead of
through a pointer.
