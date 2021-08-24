Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8101C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 12:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93916103A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 12:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhHXMCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbhHXMCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 08:02:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3449BC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 05:01:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o10so44971311lfr.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tGcpR/x5TMWP/7r5uXNgvi/miInOCYwGNQfPcrkbYDI=;
        b=JXHLDdb+tsk7sGsFH3DSalzIYHo/O3Vn1o8RfyjpNR7vCxgdaPpnaijsK3yncBX8O4
         OVFGBmQ3++F/05MJTEAiNk2Y5pZGHlIm8yTwdE9H1aMz0MZmDLrQgB/iDKuFRLmx+8ac
         RFxM+ObHTTw8KOATwwAJ42RlGWQpYUBUo3ZXqCi/0SASYZeWs9Mk1qb0gNpVEniC7y2z
         2lOK+vUaDwRsJKqN+os7fymecWQHnHLlOK0EoRMIZcVk7x1yi7JWXtLE0IcXABF3Xoqz
         wdA3Qdi7Ia5yh7P2e2O6Xk2sWgOafyforj2rG3o/CedJsSgo39IFmlJMlNV6PMSKHE0f
         i2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=tGcpR/x5TMWP/7r5uXNgvi/miInOCYwGNQfPcrkbYDI=;
        b=l4H7wNykego4FI6gqkZPydWaL9bhwhZJtHvbQo2zFgGVTf6dre1SCjbsxi6yaUrRqn
         UErnyGKhw9kodag2PS9v4BbQxnIwuDKDRWmjYwjoYe/qFTk2aS9lITE9uBjSuJbnYxnP
         B7N3s6aYIK/8HT2QxOwjQxTNw0bCSTzVAZDR1xyO/jr5wJ50KwgUjcU0a7iHuIicEYVV
         coYC6Wfx+GrRfU1TUD86F8UsgStIs6o5EXTP2J4OOp/minYd00SW9sTXswCMdEoXYGzZ
         zPLJ2a2wpddbWMpsmJCLnkqGIa0JVz1wvMAwN0qccqsM/mNVl5HafhUSpBEqdkwmbAJ7
         VrRg==
X-Gm-Message-State: AOAM533MZpfzBzvhkdwC3/yciZNWyMdW4JX4HB1zYkETb53VkItuVFMR
        QQcz+XpgyPfhNbW0TpFOhWikVkj/oU81R0ySQLa4bDs9NV4=
X-Google-Smtp-Source: ABdhPJziXYHnLH/kgyqgOKje9w3C2Iw4ovsCghWkhILEq48M7BIjHvCCCRbI66JYXajJdGOB+O2AC3kCwOy82tVfcQw=
X-Received: by 2002:ac2:4c2f:: with SMTP id u15mr28067885lfq.294.1629806483412;
 Tue, 24 Aug 2021 05:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <CALH-JHvNHVvPWap8eiMaQ6HAJOBa4W5xuA9V_s7zPLubgwaRow@mail.gmail.com>
In-Reply-To: <CALH-JHvNHVvPWap8eiMaQ6HAJOBa4W5xuA9V_s7zPLubgwaRow@mail.gmail.com>
From:   Bryce Glover <randomdsdevel@gmail.com>
Date:   Tue, 24 Aug 2021 08:00:00 -0400
Message-ID: <CALH-JHvKjK7KU+Z_R7kG291DQKyb3f=LwxcbP4fn-qL2eeosBQ@mail.gmail.com>
Subject: Automatically Handling Using/Checking Out Branches With One or More
 Different Contained Submodules?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Note:  If this question would fit better on the git-users Google
Group, I apologize, but I saw that, unlike there=E2=80=89=E2=80=94=E2=80=89=
unless I overlooked
something?=E2=80=89=E2=80=94, you could send messages here even if you were=
n't a list
subscriber.)

To whom it may concern,

     Currently, the only method I've seen that you can reliably use to
switch between different branches when they don't all have the same
contained submodules comes from the Stack Overflow answer at
<https://stackoverflow.com/a/64690495/3319611>.  I'll reproduce the
Bash snippet it presents as a solution here for completeness's sake:

```
export TARGET_BRANCH=3D"my-branch-name"
export CURRENT_BRANCH=3D$(git rev-parse --abbrev-ref HEAD)
if [ -f ".gitmodules" ]; then
  git submodules deinit --all
  mkdir -p .git/git-tools/modules
  mv .git/modules .git/git-tools/modules/$CURRENT_BRANCH
fi

git checkout $TARGET_BRANCH

if [ -f ".gitmodules" ]; then
  if [ -f ".git/git-tools/modules/$TARGET_BRANCH" ]; then
    git mv .git/git-tools/modules/$TARGET_BRANCH .git/modules
  fi

  git submodule sync && git submodule update --init
fi
```

This involves invoking some actions before '`git checkout`,' so I
couldn't have a couple of Git hooks handle this since, per '`git help
hooks`,' Git doesn't implement a 'pre-checkout' hook, only a
post-checkout one.  That wouldn't be enough of a use case to motivate
adding that, though, would it?  Alternatively, '`git checkout`'
would, ideally, handle this automatically, perhaps when requested by
flag if it wouldn't make sense for this behavior to be the default
one.  I don't know if I'd personally be up to contributing either one
or both of either of those approaches, at least not right away, but,
hypothetically, how involved might that turn out to be?

Curious,
     Bryce Glover, an amateur Git user
     RandomDSdevel@gmail.com
