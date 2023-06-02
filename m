Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA792C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 06:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjFBGmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 02:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjFBGmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 02:42:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9BEB
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 23:42:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51494659d49so2469187a12.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685688133; x=1688280133;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n4dps6NGy1Pv65fVAl2EwCdtGHminGybVjwrNiQk/Jg=;
        b=J0Mpm5mvH522+IiDDHQlZtDCulJhySzpGyK3+JmUr16z9dHzwwHbrg6muOdrWj8qcL
         dfwLRL5TicKGrN73ltC9YuvZRtJUnfMQ/2PBSARI306dHDtX0pQMmBgkHp74mk/CWTh+
         I7PdibxaH3c0tUM0nYdmCEIYV9IAiXe7JoHvg0O8i7ECab+R80sEkZBzRx/g6rO0dDbS
         yt7cK3j52xk29awicc0RwPrFxm2/nnFwols3JVm8RGLLmGDKIAuECqZ9Jj+e6goRNC+o
         9iwlVA3OWLs5BR4J0wHOgjtHYYZv7G/2QUMatRzS+xnbLwHN6VXV3o2qaF5o5LuZnVE/
         PzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685688133; x=1688280133;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4dps6NGy1Pv65fVAl2EwCdtGHminGybVjwrNiQk/Jg=;
        b=kZiFcInnQy79sn6ul39HArlWUfUyzF/x4HCVOpaq4B6pUA9UP73RCz01IEMORzupWd
         QeRmAE6ZOG+eIAqvKIw/LK52z3jvX2JLVYdVUnyQBtMJDzEDSx1lSXHy/kbYEalhfvbV
         pOF3CnUil4LibeDb9oKR4RdGOi0rzOTNBed3o8EhijP6yZktCmh2G+N/UL7JRN+f1KpB
         uZbBIoCEQ3SqVXa/NHoAZAr2Qv5vF9Gse60UpM3i9266ZGt6u5oAJ5NXgHZPA/52VYn6
         VXnx0azwgS2JduXHhMk2NhNQ1TniQN7M4qmWKpW+Lktz8QlGLril6x9EiYXMrKimvOkV
         eyOA==
X-Gm-Message-State: AC+VfDxwh++sZUjMy4t35rs2WCEwBYtr43kkhFbKTO/r4wV1x/2QjP+r
        maqQUTOGLwPq9EyalZtoMS7dl8C2cewat+aiNgGrvGtZtQw=
X-Google-Smtp-Source: ACHHUZ4a+jNxUrCI8uwpz7UWf3KAN3p3ZoDOpKk0MleCnW+AuRSsXl2Q1w/F0RAENRiZ7v1CDRFRVXGe/jfjilI9koM=
X-Received: by 2002:aa7:ccd6:0:b0:514:961d:beab with SMTP id
 y22-20020aa7ccd6000000b00514961dbeabmr1346965edt.7.1685688132573; Thu, 01 Jun
 2023 23:42:12 -0700 (PDT)
MIME-Version: 1.0
From:   Shahin Dohan <shahin.dohan@gmail.com>
Date:   Fri, 2 Jun 2023 09:42:01 +0300
Message-ID: <CAHsf_F2CgyTWr82htsyg8aiA-WhrKa4zJQUc_wJwF0pfRYR7yQ@mail.gmail.com>
Subject: Bug: Git bash slow after update
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
Updated Git to 2.41.0

What did you expect to happen? (Expected behavior)
Same performance in Git bash as before

What happened instead? (Actual behavior)
Every operation is significantly slower. CD is slower, git pull is a
lot slower, etc...

What's different between what you expected and what actually happened?
Git bash performance is significantly worse

[System Info]
git version:
git version 2.41.0.windows.1
cpu: x86_64
built from commit: ff94e79c4724635915dbb3d4ba38f6
bb91528260
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22621
compiler info: gnuc: 13.1
