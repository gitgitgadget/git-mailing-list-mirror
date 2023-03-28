Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A5BC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 07:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjC1HEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 03:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC1HEo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 03:04:44 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A432681
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 00:04:43 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id k17so13787411ybm.11
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679987082;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fvyzk6NeyW7CJ4gPgyPOurqIRRC/dbwTKy3HksAo8BU=;
        b=cARcpj7p1qBNO4aqVrca4obObmnhcXjhqECiN8v0UVugOdFyJJg79bXrhqPb8ukgJU
         lup8OUXfClRUA57eluLP+UvSM3T8uDOYRyyuv6/0AAzV7MbcGOBpTJyqBFW2EOKB7wkO
         9CCCzFVgGLZtDllRmWa+Rd8npXya0Kr/7DVFnXVEz8TDJaEx4gC8FVDfRMVtP9whvRPH
         4QjH/lYC41N9WZCMDqRYd9CLdnoNnf2Y0UnsJ/2su+RVMeCHWJrz9/AZcMHwEEImRShz
         ETx6jJKTxpkRTTf6LnWvyVbjXo0BcbYuyJi9B4mCUFVLAkMkn2AAzG6vlwWpycRDAA8n
         JFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679987082;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvyzk6NeyW7CJ4gPgyPOurqIRRC/dbwTKy3HksAo8BU=;
        b=FY95TdBLIhiQOi+uaUk55VqlAAhC0I7O8WzGah8mrUag2EIMYhCcB+Hw9xsMB2xBxg
         qqAU2HhDMOIvgrZzBYHOjcUHFkEE1DBuJCXnG17brUXxIytQeLnnJ7pyrwiRQCPoV+L3
         W7ZzE/L4OfZZ/tZvIvip9ER2Lg152kHfpgwKiFQBeRRKMGHjFzMyMURFk4T0FhTqwMu9
         KFWxDBlAQ9hSW+JS7TVNdlaceOnvMCrFWhQBML5AXHjFapVnhJ07KmpKw2qiUOx3zycl
         ZwxwgqNWuG8CtDrM9LxIYUxfffSBd8UtCKn6zmlqs6FC/Z4c8L0uVNMueG3osQ9EbyGT
         AqPQ==
X-Gm-Message-State: AAQBX9fG8Z8eUrlMVJaScWUVdFsk8GvDfGcBHrwo4pD9fXIjWrIpL+28
        j172rEOFB14okdAKvzvn7T/Yh+rmb+hz1xMkLa34idwyzcE=
X-Google-Smtp-Source: AKy350ZTsgSZFnw/ncfbt4q1iY0OVNk+R1qd1XLhAGGLLfTXBGORyycJAF52TDVHb2uzfKrqFSuR4txpUu3NCiImPnk=
X-Received: by 2002:a05:6902:1101:b0:b76:126b:5aa1 with SMTP id
 o1-20020a056902110100b00b76126b5aa1mr7282851ybu.8.1679987082152; Tue, 28 Mar
 2023 00:04:42 -0700 (PDT)
MIME-Version: 1.0
From:   peregineme <peregineme@gmail.com>
Date:   Tue, 28 Mar 2023 10:04:30 +0300
Message-ID: <CAO_O05BjFve4=xXaqf7xX8Ls9h0jPHzx6stDLuEFvODyqcRiqw@mail.gmail.com>
Subject: Git submodule update on rebase or merge
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why don't git rebase and merge have a --recurse-submodules option so
that it updates the submodules when the operation is completed
successfully?

The submodule.recurse configuration will thus affect the rebase and
merge commands so that the submodules are automatically updated when
running rebase or merge, after all, this configuration is supposed to
make working with submodules automatic, especially when one is not
making changes in the submodule, but just referencing it.

This seems very intuitive since commands like checkout and especially
reset have the --recurse-submodules option, and even on the git rebase
page it describes part of the git rebase process ass effectively
running reset:

The current branch is reset to <upstream> or <newbase> if the --onto
option was supplied. This has the exact same effect as git reset
--hard <upstream> (or <newbase>). ORIG_HEAD is set to point at the tip
of the branch before the reset.

I expected that at least the git `submodule.recurse` configuration
will affect the rebase and merge.
