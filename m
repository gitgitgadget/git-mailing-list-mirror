Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B92DC43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 02:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiGHCtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 22:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiGHCtp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 22:49:45 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43474781
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 19:49:44 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e5so2858956iof.2
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 19:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malalta-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cWagZ8wiy+yCr9DpWmtkFQZ7nzZu6e7DLh1gQu0nMGU=;
        b=3zBSFh4cPVrqND5sstqinSzHuiicdFjuEN6x/ayX7/b8P+RMy/H8mGjbVaYBz8jG8T
         sd6BGslHpAqKo5a9kGp+ECNleHbGLIimrTWd2ap/9DnxBE0LXuMB82d6dK9N1WafPw95
         SyW4/rSfqHi2d2uMphEudILaUOYzG5R2r+sD3gBiZNkXJcwFxueeeZn20pnKsabqMH1V
         feQLbnMo/HhI4972mkyMVs0DjQl0Kf7uaUWW2A4oqLW1silnT/aq29FSzAZytmAt7mo1
         G9itzVGuwl6+QIqZS5SX5rAC4OohcS1XBmEWGKMQslCgiWxfesSMNOu7bnruQjdL2t4S
         3gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cWagZ8wiy+yCr9DpWmtkFQZ7nzZu6e7DLh1gQu0nMGU=;
        b=uDu6bMz+30OZHx0gKkdbBzwzhP1UQtvYJzYTdAXP27m1+Kp6h6PPIu22n/RoKWKOi6
         trO5+cL/Z/Eg3XaihzmATHr4gKnvUZA67VjR2IdsRkF1XRZWZxHzHCB2UU9TBtZ6X81S
         pELIxOHMStLKOMSIRVGbLqSXiTxcGXG8xZwneGjSRDvfVa0903TbVXFJDC0uzMJRTe/S
         6jdKqUKU7ZVyydI38s1Qu1zffUNdX4VdiPCzvK01FdQYTtkqyEJLsZtnBfoJMe4lhwUf
         Ph2pv7uWwvDQ5DO9lXoLlRfUZyvIK3fNEKVddb6NLwyMbFnt5Y/bzIozilKomS2vdbai
         ksEw==
X-Gm-Message-State: AJIora+I2atC+Yw3zK4BFZBrQrTWutHner4xwwhXRQ9+K+6taVovng6Z
        G5lG/y7EKIcLo8tT3+28rHEQwCpD4ewH4wlrFLh/9yAnFXC6Vw==
X-Google-Smtp-Source: AGRyM1uqbVOTRgzEEDq28+0tc6m/1YCO4MWGDhPKjYbbPPO5L8g+QBKW3WbFGb7aoYCcZQhqHaTYmdFRUxDxyp+Otvc=
X-Received: by 2002:a6b:5f11:0:b0:678:ec56:2fd2 with SMTP id
 t17-20020a6b5f11000000b00678ec562fd2mr722609iob.43.1657248583159; Thu, 07 Jul
 2022 19:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHFgaav+7MV_SB3J9c92HrQOMF87nCw7LwihZbps03h5yfPzjw@mail.gmail.com>
 <CAHFgaauzSmtFhSe5bd1CEuu3L6pv8MLv05K=-6HyJQvLf8eejA@mail.gmail.com>
In-Reply-To: <CAHFgaauzSmtFhSe5bd1CEuu3L6pv8MLv05K=-6HyJQvLf8eejA@mail.gmail.com>
From:   Andrew Tennikoff <andrew@malalta.com>
Date:   Fri, 8 Jul 2022 12:49:07 +1000
Message-ID: <CAHFgaasgJHXaPTLT9M_U0JAc+=cM40oA0noVr64vEYKRAMPnag@mail.gmail.com>
Subject: Re: Bug report: git status suggests the old "-a" flag on git add
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry - ignore this. I can't read. It suggests "git commit -a" ...not "add -a".
Andrew.




On Fri, 8 Jul 2022 at 12:44, Andrew Tennikoff <andrew@malalta.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> `git status` suggests using `git add -a`
>
> What did you expect to happen? (Expected behavior)
> `git status` suggests using `git add -A` as per the documentation of `git add`
>
> What happened instead? (Actual behavior)
> The old `git add -a` flag was suggested
>
> What's different between what you expected and what actually happened?
> See above
>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.33.1
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 21.5.0 Darwin Kernel Version 21.5.0: Tue Apr 26 21:08:29
> PDT 2022; root:xnu-8020.121.3~4/RELEASE_ARM64_T8101 arm64
> compiler info: clang: 13.0.0 (clang-1300.0.29.3)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
>
> ----
>
> Regards,
> Andrew.
