Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9234EC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D4B22B51
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbhAZE7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbhAYMuG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 07:50:06 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA86CC061222
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 04:37:43 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id x21so26114486iog.10
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 04:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XXa5GTXHjXSYm3HNrIFixUHdrl524cQYYGYOoqAsqeE=;
        b=nIdqTgaNk2hhkj3kP+0ousG47bMq1kDhiXQypsnIJ4yU9o2cGS4FMQecU4D3TPnn4h
         SmjsAwZD7k+rhum4WnpbO+onLXaDV6PeOVzMuqwBiDam1KVZASiaBUplk20OE+4KOh5+
         68xGdGnE2lFxA6673CpP3Hc2mF0MbArrBpLzKOy+xzkTIhO6kGrdqI5rC8TK6BIANbWl
         dOBjrimB1fHX/XMEiVydjnZa2J9MvZ1GSGvO34KJiRjH9DFyW1sB6Ro7043QSySgqI/4
         vD4ez3vTLnkTJiuJT70ZQu6jnVKMxRjBOvYndrh52gCtY/lj2Wb2ZM6khazK0KIRKRtI
         1beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XXa5GTXHjXSYm3HNrIFixUHdrl524cQYYGYOoqAsqeE=;
        b=XbB+ZgSSl2zMtMHDK6HgdxOUVXyRylsLK/ANOmcSh6Y5ullI/Yx/DGEI8WENM60CyM
         C0AQmZlsBJ/NAS4L31fNvhsL1Ay9upIpgoWa2AO/76fwtWci4wQX3gYEwEdrhaZ5zXLu
         sKhz/mPG6SD2llmENRExbkl/brsRn62f7gCxGPXKaLSl/dCDhvwb6Ee7pdFiyOtqkPZ5
         3bywFwynEgGd4ItYb2KIyPbj8mmiOtKE0lmvK5ZkldCG3IiZ/Sn/YyAe+q3utjvk/nrG
         5Q3ep+VoNccxa1nOgCUbbN41/YgopdGnBF0uu9oPwot8sJC9jzpQiONHOy1YGy1eDEEW
         TasQ==
X-Gm-Message-State: AOAM530kMsAeceNbNeGBx435WKDbmU6GQuIoL5ErFJerOe2ON4DH0dyh
        x3rQoHnQCHahtgrJXqkG7pbgyhNrMKZnXpIz1ne0naE/0eH5CQ==
X-Google-Smtp-Source: ABdhPJwOrMRzfLOPC879+BYO2fts9vWWImporqZYvAmUc/QUZZQtBge8E5G7fgJCD9TMgHbiz8vQENdtTwePhe50Kg8=
X-Received: by 2002:a05:6e02:14ce:: with SMTP id o14mr78246ilk.9.1611578263100;
 Mon, 25 Jan 2021 04:37:43 -0800 (PST)
MIME-Version: 1.0
From:   Gil Haim Tichon <gil.tichon@gmail.com>
Date:   Mon, 25 Jan 2021 14:37:32 +0200
Message-ID: <CAOLA93k+x_d1ZwUkHv87+JJM1u0qh=3dLo4o-UsWVmaNSSSoqQ@mail.gmail.com>
Subject: Cannot list untracked changes stashed with the --include-untracked flag
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

After stashing changes using `git stash save --include-untracked` you
can not see new files when listing the stash using `git stash list
--numstat`
There is no flag to allow such behavior.

This discussion started at: https://github.com/FredrikNoren/ungit/issues/1459

Thanks,
Gil Tichon.
