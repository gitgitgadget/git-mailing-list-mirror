Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28647C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 05:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244203AbiBPFG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 00:06:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiBPFG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 00:06:29 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED62BD2FE
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 21:06:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p15so1887815ejc.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 21:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3eK5UfgPLfSi/PjfeY+9uKYRKQW1yyZ0ZxkFVeiNrWw=;
        b=I80Z5BiIt0NxQW0Zo9HXkcBJcxzXCbDA7VyLj0VFxaWmdQanqM/ViEkmpVVOVka+GS
         zj8mIufF8f6HptKDJ3o6JNWx0nT1f0m1E3KdwZtRijEEDNIPA4XmzhFeKoeAQ3y4TNa8
         kSC5log9l1nv6d3GI8MZ4eyeXhFdogeRYTwramin9kD06w0jEFUgMgL4MyKTavrY69Nn
         Q2YafixNd49SpX+p7ERLZgc8d6DiB3SQOy6jHasyqjwscr75DB3xdy/8ezjjqr49nNOc
         rUIZ1E2JDvxdTtdvJOOSN7dx8Yn9194wrC1pCv499TV2OJkUCf6R86gYjBwy27ljqZom
         jEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3eK5UfgPLfSi/PjfeY+9uKYRKQW1yyZ0ZxkFVeiNrWw=;
        b=wKNaHvcNnY+ooqSRV2vntRUe18EHbErOP7N0+yRVMKN6Ia9p0xxBiPzZUK76N6Dpkd
         7BYfDqSE8Et9S3EjmJau9dGoPD7Fz5V9Qj0xiEgXM+ig/JeHuz2iGombzblThECSbcjr
         lkYqATeaI5JDkvcTN+QY/TXd9q4gEpH9tf7ev3PRPzumYbzADNQT9oEeCGPmJYQBKPc9
         wUqKi0bJemFei/A3hAnpJY+ayI97Flzqq302vlFgbfV4eqNUxS6CWuCWqekPek82dyTC
         nBKKl/WfYuPe//7i/w0BXYYdjqA4rlistXQXttdPw7+KZ5lHKdUxa5z5Q3tjNOIuz5Bn
         Egcw==
X-Gm-Message-State: AOAM531NxpcTVQkuNxmoRhcOv9/e/U8R8UsJ329ZBXMGEch7v67L9UdX
        hltkYHssVAjzraZ0+6Q8nMGahG6IT0GxGgTufvc=
X-Google-Smtp-Source: ABdhPJxsGyv7ZaUQ8dyBf1c47YxwR7DInDUDUtjKVaZ+OQm6+atefYnzbNRlAjK39B3LDTaY2nbZEEmchY9mBFBO04g=
X-Received: by 2002:a17:906:350d:b0:6b9:5871:8f34 with SMTP id
 r13-20020a170906350d00b006b958718f34mr905694eja.493.1644987975889; Tue, 15
 Feb 2022 21:06:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0dwyrcv.fsf@gitster.g>
In-Reply-To: <xmqqk0dwyrcv.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Feb 2022 21:06:04 -0800
Message-ID: <CABPp-BHxg+KE7W0jLfHC+DfjRyNoigv4qSEgJyehnUZNLUzZCg@mail.gmail.com>
Subject: ds/sparse-checkout-requires-per-worktree-config (Was: Re: What's
 cooking in git.git (Feb 2022, #04; Tue, 15))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 12:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * ds/sparse-checkout-requires-per-worktree-config (2022-02-08) 6 commits
>  - config: make git_configset_get_string_tmp() private
>  - worktree: copy sparse-checkout patterns and config on add
>  - sparse-checkout: set worktree-config correctly
>  - config: add repo_config_set_worktree_gently()
>  - worktree: create init_worktree_config()
>  - Documentation: add extensions.worktreeConfig details
>
>  "git sparse-checkout" wants to work with per-worktree configration,
>  but did not work well in a worktree attached to a bare repository.
>
>  Will merge to 'next'?
>  cf. <20220204081336.3194538-1-newren@gmail.com>
>  cf. <CAPig+cRrRxuTeByhKkLs_KDaWY8-r4+jrwT83A-r+sBQsmebMw@mail.gmail.com>
>  source: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>

With v6, Eric seems to also be happy with the series (cf.
<CAPig+cQTRGuuspz2g5LZr4Oh8bQCr4FUDV0tirs+ZPwhtAaJVw@mail.gmail.com>).
So, I think it's ready to merge down.
