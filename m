Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82824C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 21:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhLIWCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhLIWCu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:02:50 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F10C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 13:59:16 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m17-20020a170902db1100b001421cb34857so3036882plx.15
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yVuA/AskfchH4VZ4mn4MUTCoUSG23/Pc4TsXY/RdtKc=;
        b=eQfEZ9rL/IHXu9RwyiOngJy8GbPM3O3YfmdBX3XUYiNvVb/JH3PjNZCDx0mJR+S3Ue
         j3k2pbp2bONHhadu0LwZrJ9fjwFMhFTdnh1Z6+tubyjpyidtCcWf79mNL5LSpSxiK8h9
         pmsvB8YjquhmPCQd87j2eIafSnhabdP+x1xesjReb55nPnPO3xYude4vsYWIgyEz7GfP
         s1NKluJpTEQoC5r8DJ0MDtqLFd6J+a7Y7cXnatc08rDrp9iK9lZKJp4fS3d5Ah5UD9Jb
         htYMJs59RVQJ9HVK2MPsLi/DQQ5C/UJCGISz3lSJiK23+nqBtjWZORjMKqaQlEi3LAIJ
         VtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yVuA/AskfchH4VZ4mn4MUTCoUSG23/Pc4TsXY/RdtKc=;
        b=RGH+8UZwQWvFvCgLsc4mlwHRzLO/VZvkbe5yuyt8DufLtdOeb8jpCydQoy5eeoRX5L
         qR28cleaWVLubTMFgh8uvdPm2zBXcZ5nGdHq9kQNCyFJ+dlhrHJ6UPXvK8eog2BPLQBA
         zsfdP9nmMtYov7Jh7gB3rK5TjJCbPcQHRMuKE5xUwjPE3c52R05R900JW6oWn+9gk+oA
         pUDbweSIKAeL5gdWgJ15ttMnmwI6E4VEuJoFdp+K9n3+V7cwagW+WUPSO7kPMuxtNEqp
         52iaChCaDOOqcBZkRVi3va9r38XmdPDn+1Wd6HZiq3oHOmUc3kSH5NHbBrHlDFNJcu10
         l+9g==
X-Gm-Message-State: AOAM531MEBDTk6nRB+9NWoJcDKaxvQTdDkIISkFtxsHakReQXZm73F3d
        lLJq56Om2ysIuvpUNM1sa6hMVqU8DwP5dCDAZnZq
X-Google-Smtp-Source: ABdhPJwDu1CtmZZh+oIVdmtkEEfuxyiHXVZhpln1rRLYDnUZH2K4kETEb5ONANl9sYyfLYv6O/O6teHofgPpalPgdO4h
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:1919:: with SMTP id
 25mr19364137pjg.154.1639087155656; Thu, 09 Dec 2021 13:59:15 -0800 (PST)
Date:   Thu,  9 Dec 2021 13:59:12 -0800
In-Reply-To: <20211209184928.71413-1-chooglen@google.com>
Message-Id: <20211209215912.506354-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211209184928.71413-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH v3 0/5] implement branch --recurse-submodules
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
> This version is functionally identical to v2. I've only addressed
> feedback around code organization, i.e. the the merge conflict with
> js/branch-track-inherit and making patch 1 easier to review. Thus, some
> discussions on [1] are still unaddressed.

I do notice that some of my comments on "add --recurse-submodules option
for branch creation" are still unaddressed so I'll hold off review until
they are.
