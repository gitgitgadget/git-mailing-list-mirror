Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC93C7EE29
	for <git@archiver.kernel.org>; Thu, 25 May 2023 16:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjEYQJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 12:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjEYQJl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 12:09:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6C198
        for <git@vger.kernel.org>; Thu, 25 May 2023 09:09:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5655d99da53so16690937b3.0
        for <git@vger.kernel.org>; Thu, 25 May 2023 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685030951; x=1687622951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITRmyS/7jr6j+wk4XWZF+5UqEHUwEbJ+0/JgqrBXKY8=;
        b=cIwkQnjRGkwDTMJaIt+2Mf1K4K5txPpQ9Sw+rKiscvgZPg0AnQ7y563mFnCa7ByjGU
         iMnX8/7PeJUPr8L+dT1xUvaLklIp3z+qVAM2m784173uT2PkibXlahBHsgn3mIhIl89k
         bHb35WcNYoHO9f6tUJAqEm0p87uS3HsTxxwelxu6JG3ePmDbrrNXPWX3xD78fPcX9cx8
         8AWB5o+IZjaJt4pdSvCxzBX4L7QhpwZQ1YFt5lCU1oH6p0S3ealtB34zZzF4klEgYdiC
         FO/edf4zDPV9AazAT3EIYBCZAFU9KvIk4Nb1elGQFfKII77VXJKdS0pi+YH+Uod5Vgnm
         3hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030951; x=1687622951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITRmyS/7jr6j+wk4XWZF+5UqEHUwEbJ+0/JgqrBXKY8=;
        b=WLBa9VGgjONwY/j4cSjnSewZY9FgKvaeZott9gclQlfGtc6k0jka5RQRQgb456o2LK
         /kN9ACdt/SZ3dXVUbp3ZByy0sqDBvxr0p9/RaNOgj4VJZLdED+JybZvJrZuVhyhKCqD+
         2Fp41AmGR4XNisXGi6C0t+GcHJHAovW3/2vt6OyxZnC0bHIm5lVelIZzarZpydyttHc8
         MLcmqOstmKy7u+9XeYqcmTTcfOKbbBHak2RP4cLawNIzIrqyj6wmVaSiUs6y71EA6LIW
         F4687Nck1P51q3cg9zYnNPpqE8kBXHk6tMh1p68z2W7bItASdrcR+88mY+dil9711n1+
         Pd+Q==
X-Gm-Message-State: AC+VfDyOdreW5DxXpcujPmiw5AYmY+7dq7M0zNdiMQgGy1cJjV6H9JYC
        5GYcrDVnAaGl/vp6ijPBOF8iXZwGymtmHw==
X-Google-Smtp-Source: ACHHUZ56x3jiWJ3/qYdKpUwQywVL/js9IYu3/nY4vmDLpth50e/z0xNPgnT3/7Y0rMY9/AyLjbuF+Bak/ItoSw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:690c:3142:b0:561:ec3e:62fd with SMTP
 id fc2-20020a05690c314200b00561ec3e62fdmr36112ywb.5.1685030951347; Thu, 25
 May 2023 09:09:11 -0700 (PDT)
Date:   Thu, 25 May 2023 09:09:09 -0700
In-Reply-To: <kl6lv8ghxkpc.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <5ed9100a7707a529b309005419244d083cdc85ba.1684883872.git.gitgitgadget@gmail.com>
 <kl6lv8ghxkpc.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6lsfbkxuje.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/2] repository: move 'repository_format_worktree_config'
 to repo scope
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I think it would be better to pass a "struct repository" arg to
> config_with_options() instead of mocking a config_source to hold a .repo
> member.

The flipside is that this would be redundant with an existing use of
git_config_source.repo, so for consistency, we should probably remove
git_config_source.repo. There's only one user of git_config_source.repo
- reading .gitmodules from a blob. It probably made sense to add .repo
the time, but now that we have a second, different use of "struct
repository", accepting an arg is probably better.
