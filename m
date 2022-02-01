Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12961C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiBARnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbiBARni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:43:38 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458FCC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 09:43:38 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 125-20020a630383000000b0035d88cc4fedso10751157pgd.20
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VmCvKyAcQaxV56k7vfLc7xY0wqQPZw7JfxtrqKZWFoQ=;
        b=Rbb9VXq/RQq2MoZ81my9dPGqSzSFJhIeZcLWuCFAfPWS/sUjtHc/rPAbJde+lOQO5h
         WV6nSd5XLqUbOFr8+7Hc82u0KFINn5NSjsYnWKWGiL7yMuA7LV3/3db+qT0w43A5HgHM
         7xRAkrOGANcJk78g6gQFIe1Q0uVNd4yA5DmTPW8c8F+48yTbm/gr/kT4HvX2RWCe4DoW
         8uT2R+gcDHSS1lasyBwczluhHIQrebWljU8dpyHSQpCCory5lrEQdgHd549lup8YrUQi
         mD2/EE87UhKnasFb23g7+6Eo0X7TrgEtsyC8E76IVyQl0nab5LFsqMXb2clX8NjvoaIT
         S/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VmCvKyAcQaxV56k7vfLc7xY0wqQPZw7JfxtrqKZWFoQ=;
        b=gAkQdlaDHxQnqWYCB3Pbe2FfttOxsMYLXLxm1o4WdipXXSwq7FFJvchehY8MM/573P
         5/isa34nhql8gvUeNjBU9UwsKScTIBnjoAZPD33Nz6T5jaBx6fZYDQ8ye/omS8g0JwdQ
         DRsxXd7CdvZfIK6DIubr5Xmym+5lJVB/tXQZPR3zpvKAyT4QmBOLggs/pFx/9uU58BCh
         xtIhW9YT6+3FdmTVuFyf3t2Enzu5CrSGXZ6XkW+b3ZyLZQtFZfoAsgL45gOa2mKFWMxs
         nLiPh3oJU/R8kxOv9UwrWiRaweDtkwZs25u4BzZZXTC0Lat9MdPHIQGRygGfGJW2SjIl
         /RdA==
X-Gm-Message-State: AOAM530knmas/qzWnnb+zob2BSYu6ZkzSyEM5a6Yqr9RYtGGD3MOW8TY
        XwQdxyIm1NCYTR7QMqgtcwdchUlX7yJ//lPusEUs
X-Google-Smtp-Source: ABdhPJzuNtRbBLSBmsgy2+W8NdKzwCEegDo2SN/bjUe3Mndmlc6pzfrjeRZlI65aWWbTfR9hQJ2ebYze9pdFqk1TnPDL
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:28c:: with SMTP id
 j12mr26579323plr.6.1643737417701; Tue, 01 Feb 2022 09:43:37 -0800 (PST)
Date:   Tue,  1 Feb 2022 09:43:35 -0800
In-Reply-To: <20220129000446.99261-1-chooglen@google.com>
Message-Id: <20220201174335.1578352-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220129000446.99261-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: Re: [PATCH v8 0/6] implement branch --recurse-submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> Changes since v7:
> * Reword patch 5's commit message
> * In comments and Documentation/git-branch.txt, clarify how branch
>   --recurse-submodules behaves and rename a parameter to better reflect
>   this behavior
> * In t3207, always assert on error messages when using test_must_fail
> * In t3207, assert on config values using test_cmp_config. This avoids
>   the silent failures discouraged by t/README:671.
> * In patch 6, be more explicit about freeing the stack-allocated
>   variable.

I had minor comments [1] which have been addressed, so:

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

I'm OK with 6/6 being included or not being included.
