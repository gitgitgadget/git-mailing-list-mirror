Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D6FC6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 21:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjCJVsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjCJVsi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 16:48:38 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741B14DA02
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:45:46 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id l16-20020a9d4c10000000b006944b17058cso3713008otf.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678484719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjK2CaQW2Nox3Cp4BB0gYmRbowTkNT1iMa+2TsDhoPw=;
        b=gsqH9Fjkw8UpCpAII+5e1EfQCzfOh+9OiNuEq1ouVCV0m4Uz4NIvHOBFCz9wKyb2GG
         k4SR/3bTjmKzcYoQYKDjgoTJOYfbDpeGvhTycwULmqoZ7m1jvxyrow4zZSKhiiwCaSkc
         /RDOv7QPkbjpdGNJFoYjzwGfJclXeG3DW1/xfbURoTtq4ydvDuS07nbdVP5RwdWuAaAG
         +25wZon6Uv6QQ/r+e0ibjWymHM/sGas3b5Fhhw9PLF8qRZK9z/DGBrJF4LDimO+lv8jl
         uvg3/XwRO0LjCgIBclC+eIxIUpHB5ewpvQi1vUQBw2em9sdpbwU6aHEIMyJMBRFINMZa
         kAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjK2CaQW2Nox3Cp4BB0gYmRbowTkNT1iMa+2TsDhoPw=;
        b=xseqTgUjv59s6DvufDNblzK0HCuzof94tynZN7kebWzVcaXVK5A9LqbtwLgSafqDkF
         oQZ9F2LsaE6djqKNb2QqVj18/G9VAZV5/xsGFtJfHwEM5R63mYrH0jgD7Zyb1w3KYegq
         EPTa2spjPC8Dkk/ynCUkH4muh+s/H3n1xSunr9bt9fewNiU5l4Vg2A+bwYMJ/2K0mFwG
         Y9f+DiCvbXjgv+T6ED5zAYqt9O5CzvL7XhaGpvkpJlbEVp/ijdW9SA3ktzg73TD5ha7l
         kjXWbVKSd/yFXtvFuBgW2Pb2QOp32TLv2U7jkjAUttXAuOsBoOFxAb18+vQlyreV9TaZ
         6vQA==
X-Gm-Message-State: AO0yUKViIlGfziC+XNIiExQmKELqox+0b6vTwggnzCNRDOyMbpwH8EK6
        ZDFcsOn2upUxqQvfmVWd/v2SorDFzHQ=
X-Google-Smtp-Source: AK7set9rQPuIF7d8612qtyEyhZxH/oULETVMlWoVGYYXSI04mE7MuY8kFw81zzLGXkKKAdfLVK3yZA==
X-Received: by 2002:a05:6830:3141:b0:693:c3bb:863f with SMTP id c1-20020a056830314100b00693c3bb863fmr13624576ots.36.1678484718998;
        Fri, 10 Mar 2023 13:45:18 -0800 (PST)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r17-20020a056830237100b00684bcc9e204sm495895oth.78.2023.03.10.13.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:45:17 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 0/3] Support for tail (branch point) experiment
Date:   Fri, 10 Mar 2023 15:45:12 -0600
Message-Id: <20230310214515.39154-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.1.gf652911b76.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is *not* meant a serious proposal, it's just an exploration of an
idea.

The topic of finding the actual point a branch started to fork has been
discussed for decades [1] and yet no clear solution is in sight. That's
why this idea I had in 2013 keeps coming back.

The idea is simple: add the concept of a branch tail (e.g.
`master@{tail}`.

The motivation is that Git's main competitor--Mercurial--does have the
ability to tell with 100% accuracy where a branch started, Git does not.

Many hacks have been proposed, such as parsing the commit messages for
"Merge branch", using the reflog, adding options like
--exclude-first-parent-only. All these clever solutions fail in one way
or another.

If we stopped trying to be clever we could go for the easy solution:
simply add a tail marker.

This has many advantages:

 * `git rebase` can simply use that
 * `git send-email` can use that
 * `git range-diff` can use that
 * `git name-rev` will now be accurate

I know most of my tools (`git send-seriels`, `git related`, and `git
smart-list`) would greatly benefit from this information.

Moreover, for one the most important commands of git, it makes much more
sense semantically:

    git rebase --onto branch@{upstream} branch@{tail} branch

Than the current:

    git rebase --onto something branch@{upstream} branch

I'm not expecting this to be seriously considered (given the track
record of my proposals), but now the idea is on the record, so it can be
referenced in future discussions (which are likely not going to just
stop).

Cheers.

[1] https://stackoverflow.com/questions/1527234/finding-a-branch-point-with-git/71193866#71193866

Felipe Contreras (3):
  branch: add new 'tail' concept
  sha1-name: add @{tail} helpers
  rebase: update branch tail after rebasing

 branch.c                  | 12 ++++++++++++
 branch.h                  |  1 +
 builtin/clone.c           |  1 +
 builtin/rebase.c          | 15 +++++++++++++++
 object-name.c             | 30 +++++++++++++++++++++++++++++-
 t/t1514-rev-parse-tail.sh | 39 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100755 t/t1514-rev-parse-tail.sh

-- 
2.40.0.rc2.1.gf652911b76.dirty

