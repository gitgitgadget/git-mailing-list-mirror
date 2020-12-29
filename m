Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F27FC433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AA621D94
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgL2IcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2IcW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 03:32:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55290C0613D6
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 00:31:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h16so11891149edt.7
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 00:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76bG+/vHwjp7tkcIPEDB0m0YU3AeYe86231D+1kqV1U=;
        b=QKHUrAWPBuZE/dS43wbUWu09phxJWJY1qvefp52b/JwISGdd4tqWmIWHB5RVs6UQLY
         e4mNcyQKPtJGo35AL4a/440RE4IvnzrLeo/X/sM0mFYeQ6ANJE+S6WgHvg+YoG1fokUh
         JsDrwoVaxwHq2emLerZaNtTum6BEvx0xJ5E803c4zf9SqWb/v2NXyGvvnn6a8PnpYJNY
         w0e282w4/AQU+vfGLFWGBOUGDG9Fj+k3ZuHLkglYMYwvoIhm7MDhDAgMNDb5x89E+X4w
         cHmcRKxd+bJwYnr9XkWYtJV1+6qrreG4yOLY3A1PRspb746oS408JHpgxjSz5nw+i3b9
         lprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76bG+/vHwjp7tkcIPEDB0m0YU3AeYe86231D+1kqV1U=;
        b=RWyG3ycQW4ERKz0zw0zZwVa3X66R4Peub4rRpqGEKtiBWIkmVrAr6Fhg9jrzAS9Jz+
         2QCuwK59meGp/KGqve3JvGtusDHpPJQIxUI74I7uh1UmPxdXiMIa2VsWAwpHZy8zlXwH
         KY+Qrxmlg0uGoTYxwI9XbdQJudQ5OhcEi8UItQY2l6iBDDDN4ATvDqPd86tL6I8lZq+M
         D8Dchy6Sy26tXA/aViId/fGgboaVIQvV6H2NLsqRjz3heg0P8flAiRczvsRwicjSOYb9
         IoJEcE36tmlY2+0x+gWzmD4FVb+ZlAzNky4VcwdgXPAKPSfWb7Rtrwq7iJS5SF9nqT1l
         989Q==
X-Gm-Message-State: AOAM531fFttlhfz0alpkOzZTsQTQxwrNHKFdqOuvcu4ylYXEe6O7UiLr
        4rO7AH6DxM2pw9NsWxpYDz+09tBC068cINE6Zq0=
X-Google-Smtp-Source: ABdhPJw7/Jt5/nCctRqJRZpvKC/f14i49DqmxaZDeMjNlTdkF500BYq0b/XdF7t0EBR02cqiUMdoVec0Qlt2r2Fgb64=
X-Received: by 2002:aa7:ca03:: with SMTP id y3mr46013501eds.87.1609230701009;
 Tue, 29 Dec 2020 00:31:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com> <af256b1c534e3fe103bb01bd673ac3a2ec467de4.1607677728.git.gitgitgadget@gmail.com>
In-Reply-To: <af256b1c534e3fe103bb01bd673ac3a2ec467de4.1607677728.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 29 Dec 2020 09:31:29 +0100
Message-ID: <CAP8UFD0r1RvbtOcHTbREcC4v33S-m_gS4e=fSq0OFEHr82K9nQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] diffcore-rename: remove unneccessary duplicate
 entry checks
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About the subject:

s/unneccessary/unnecessary/
