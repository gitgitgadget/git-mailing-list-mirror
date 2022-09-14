Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D1BECAAD3
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 06:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiING5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiING5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 02:57:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F443ED54
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 23:57:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x94so3481481ede.11
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=i4vByyniqYziOk0ZCemkA0oNiGcj7+oQ2uYjlLxtVVA=;
        b=c8J+dH96tA/sF8jEtt5pa8XsHbzCrUAUqVDI9OtTVG9MBIgbe0sWY4P+A+0shz3aA8
         X5UgRryVHcEzIc4G1bJRQKtkD5fEEnNW3xdsNw+YWc8C0YTGcNtv0ivJKnz297GDCd4P
         LuWW+ZNgg73K7FS5NwlJP/AoZrO/nj4lUOzGvgqVDnRQY1TY430xIBSruJTtsOuqehFt
         rAfu4Rgy0E0izR3mKCRdudkBdqOfS6IAfRasaBNeYZSYb4M5wMUHqWpjsrwUSlZB1hGH
         nXlinLrAvjbtr/0kC3oDQF1v8f8fNXYfqyrGnSaWdVK9i6C2CKwroB8Jgjb9qHT8sNkE
         BMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=i4vByyniqYziOk0ZCemkA0oNiGcj7+oQ2uYjlLxtVVA=;
        b=4JvdSM3lZW8a3aF3RAmUjleW4dJL9lRwyJ8sPEKeYt2P1OHcJmJlJvtZgs9LB9+s0q
         qcIEwkKN8DCi+SjfC1G3BmSFdYiACnoBL+oVPhVfSb3SWBjcqWZ5QmhCvKhT23O9tgb+
         f7W0ODDUUFTsMIy+TbOf7PJfPhb2+uvZ220JsqrqFmPsdm7P761WAg3rPKGddCoorsxA
         JSxhB6KThoYY1qG4Ry5i9wHJWI01LE0lnrAx8wetCQwDn6Xeh1UQrmT1dY2kVzvuRDaM
         p1tu/gnv45qMAhNKmC6XCSZKNNwUMLTWqtZ7wJgtyeFYZHYoMZXcGRznWtvM4kGQygHn
         9Nqw==
X-Gm-Message-State: ACgBeo2dSyVkwSYsvFfBvMBPet9liUXzKLHfMax58ayYIyjNYu+YyA+p
        qbT2C46akXw+sruPj3/mR/TdOedm9E96f7M+q+xM5ZTjdBjzcg==
X-Google-Smtp-Source: AA6agR4NV7G+HMauN36IcPOVMSHeVf5/WrWFIEfg2KI8u9asg6YflrtHJxA8iuaS41S4vqu51h6L8OmaWZyCFK//qjg=
X-Received: by 2002:a05:6402:3550:b0:451:473a:5ca3 with SMTP id
 f16-20020a056402355000b00451473a5ca3mr16784323edd.48.1663138622640; Tue, 13
 Sep 2022 23:57:02 -0700 (PDT)
MIME-Version: 1.0
From:   David Plumpton <david.plumpton@gmail.com>
Date:   Wed, 14 Sep 2022 18:56:49 +1200
Message-ID: <CAJXaddZwqGabdjmgc22eCYCdBw6nxcPbPfom26PwG3xvKEN93w@mail.gmail.com>
Subject: Small bug report in git restore -p prompt
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
git restore -p -s <hash>

What did you expect to happen? (Expected behavior)
Prompt should say "Apply this hunk to worktree..."

What happened instead? (Actual behavior)
Prompt said "Apply this hunk to index and worktree..."

What's different between what you expected and what actually happened?
For git restore the prompt should not mention applying hunk to index.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.3
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Aug 22 20:17:10
PDT 2022; root:xnu-8020.140.49~2/RELEASE_X86_64 x86_64
compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]


-- 
David P.
