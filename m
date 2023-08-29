Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9E3C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 19:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjH2TMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 15:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbjH2TMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 15:12:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880095
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 12:12:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so72676471fa.3
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=planitar.com; s=planitar; t=1693336323; x=1693941123; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SRVRKMW+qtjXlY2MVzEHuQvZYLNMACtV6Af+Zc/mG5g=;
        b=JZ+mRHI2zHduzFPUOlJr1xNRQOrrlN5Whi7mJzZ13Itv/T3HK7/Tek3lOVUnS9k7JJ
         j+iID9dAQcNbJ7srYImDAbYgwYro5cWuQ2Tm33FDuRpyNYBOSI6PkY29Sv/7EEhmayTf
         r7E3TH0/MrRP0c2lJ8C7gu3VXZKMp6hm4UfdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693336323; x=1693941123;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRVRKMW+qtjXlY2MVzEHuQvZYLNMACtV6Af+Zc/mG5g=;
        b=UHpLD7uQs+W1UF4Fp28EJKg/z199q5FxkMbTXGWvuTnZRfqEWfiN/uaCPig3jySIbJ
         GBmTzoI+9+SrM7JqaDpbM0SM/ZQb/ES2IutJ88A2N/cXWwPweKDcivpdzMMIKlUhy4tk
         O9IfQoVjB1YBkcR1KBzj/7M3NW2TAqopqgzTJ0u5TV1yQTu5cAu8RQ5BdNr5nlNRgXvY
         K0l6/vd1owWPppKNh0EpkX+NDiq5csVQOhqWCRNeJJZ/zw3mjIdstHhCLkEmoEQ0bcVf
         VgxMprLcOVrukQBPPn3LmJMao/3BMSCBqdfzVF2okva0yixpN9KRiX8mXsveEs2+6zbb
         VaKw==
X-Gm-Message-State: AOJu0YyzIyuCFmTztpJFn1FbGG8e/AmjmnkfYeiyfXpb+nRRawaXKz22
        FZCALT8rKjwmviZSvpYkV82KUs0VE6wfjJ6n40R1+I0PPI5JmuXEElE=
X-Google-Smtp-Source: AGHT+IF7q6HOboRoliWAPmGpH4JRxluF4cXuetyTqHXziar11mCebJYV9atZL1TXZnSgh9V7ZmDxRLh46KtWm3it52g=
X-Received: by 2002:a2e:924e:0:b0:2bc:d404:fa22 with SMTP id
 v14-20020a2e924e000000b002bcd404fa22mr153777ljg.11.1693336323248; Tue, 29 Aug
 2023 12:12:03 -0700 (PDT)
MIME-Version: 1.0
From:   Eugen Konkov <ekonkov@planitar.com>
Date:   Tue, 29 Aug 2023 15:11:52 -0400
Message-ID: <CAHKPvkYtC88pEfACTXKM3a2CkbtMRjne9ZmAtF_+3K0KFZDXKw@mail.gmail.com>
Subject: Can not `git stash push -- .`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried to stash staged files with the command above, but got an
error. I even change directory to the top level (where .git is
located) and try to provide pathspec. Same result :(
```
$ git stash push -S -m "core -> ubuntu Migration" -- tools/ec2.tf
tools/init.conf
Saved working directory and index state On branch/xxx: core -> ubuntu Migration
error: patch failed: state.d/terraform.tfstate.backup:2
error: state.d/terraform.tfstate.backup: patch does not apply
Cannot remove worktree changes
```

Is there a way to stash only selected staged files from current
subdirectory, eg. `git diff --staged .`

Thank you.
