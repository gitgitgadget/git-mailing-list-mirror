Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABD1C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 19:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiBFTip (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbiBFTio (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 14:38:44 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7409AC0401C7
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 11:38:41 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id r8so19838528uaj.0
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yguXfSXlM9k/wf7AiDaLB+YFMGC1mjMKOMPb6hE7Gqc=;
        b=kiHLdnm0KFsZFyaR66A8SDCIBBeuVEmXCHnmUFig5dSJKXPEHhBaRDkWURkUteQ85+
         KzYqrrb9JGLN0k6TL8hH5Bwm+8aSwDGXdT+iRkBcPzB4Z4ezoiKBdHh2V0IUJrnOmmu5
         fZT++OVfr1Pe7X214UmiIAj1Ux9ZUbYOjNCLRqBNHPVzBPhRHHVgZgaEgw7UwvT5K37o
         LbJUdByvO6NYgttTAn/h6TgpB5GzxRwZ7dHzUrw1fXA92JT66hP5BSzYc+OiYvUNoOon
         SEYq41n2uVmUYTU6DAbS2mBLGhxYx+A9iCNGTePUOO+cLzuEdI3xP6B0w76fEwKmDSj5
         rInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yguXfSXlM9k/wf7AiDaLB+YFMGC1mjMKOMPb6hE7Gqc=;
        b=dSo5GMffJlUAJHaEJYYVFew1QFPTqPwtoxPFWa/QWlDIUnMmgntgeDuVjRdUMmvFPo
         1PxV9Ad12BcC3PyJtyaHrhWTjLWpP35qUK9KqVqVK1ogFfU9bMOeyGG1OGxIUwgjoK4v
         1TY5QSGXVpkyvZMLWNJgb0w7d7Hnw23jJaSApNG2mDAkqpLjQV/Ont0HpvyEpsuaaCYY
         aUdUOtOCJRpedzim6W/bqgtr4lehGGo2vTX6SKDRTEfdDvbaNZv8l+MLeUdLjrnZlDyh
         HMUP/55mp6Nv5PReHM8MDiPgmQqjPlAaI9ZdFmSyvJvYcmiz9SbNvfRl4Ml0sjmRxV+T
         DFQQ==
X-Gm-Message-State: AOAM530k9fzpqKttDlsbasPo8a01gXo6q76z/skZJ7woZ67zpvJ8w3XF
        ERzAK39SQvAE/rgKS9hg7yrwEbWufFjB3m91mbv22OL4FVU=
X-Google-Smtp-Source: ABdhPJyPjFS5VUPWzB03vnu5C7/nECpfmzZI4mXc+OHNBTvNtFGh/HaPgPRiBMzQL4WjH0/aHDfkzwN5VDkKxoLivR0=
X-Received: by 2002:ab0:7646:: with SMTP id s6mr1737447uaq.75.1644176320489;
 Sun, 06 Feb 2022 11:38:40 -0800 (PST)
MIME-Version: 1.0
References: <CAO8o=D7LKUp_Bf54hbVNumhpNKnDO3UKgyOMU_0d0Er87a2zJQ@mail.gmail.com>
In-Reply-To: <CAO8o=D7LKUp_Bf54hbVNumhpNKnDO3UKgyOMU_0d0Er87a2zJQ@mail.gmail.com>
From:   Noam Raphael <noamraph@gmail.com>
Date:   Sun, 6 Feb 2022 21:38:29 +0200
Message-ID: <CAO8o=D4yuKheOO1UL7o0u89i=yp3c4KjhLjKPGBptE3-NXObEg@mail.gmail.com>
Subject: Fwd: $LOCAL and $REMOTE swapped for rebase mergetool
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When using `git mergetool` with `git merge`, the variables $BASE,
$REMOTE, $LOCAL and $MERGED behave as I would expect.

However, when using `git rebase` instead of `git merge`, $LOCAL and
$REMOTE are swapped - instead of $LOCAL being the local content before
the commit and $REMOTE being the content being rebased, it's the other
way round. This doesn't seem consistent with the git-mergetool man
page.

This causes 3-way diff tools to swap the meaning of what's on the left
pane and what's on the right pane. I had to work around this with the
new 4-way diff tool that I wrote (https://github.com/noamraph/meld,
check it out!) since it assumes the diff between BASE and REMOTE
should be applied to LOCAL, and this doesn't hold.

I think that at least the documentation should be updated. Or perhaps
the behavior should change - this actually seems to me like a bug.

Cheers,
Noam
