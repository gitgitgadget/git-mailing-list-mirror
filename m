Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8464C4320A
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF3D600CD
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhHKND3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhHKND3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 09:03:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED3FC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 06:03:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k9so3589315edr.10
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5NkeLFKJt2iCXOzG0EwL6JWBXBpZfdjpJ5FdJ6XiLHM=;
        b=EcKpEC1j9o3CMBkEhwHDrXinsyM2lsS8VDpUWq4yy3zz4GwOrf5bMbA3mzeGgadaZn
         3Q1Mb+qNWrm8imGVO5I23t0fhGh7RuJ3sjpE9zVQsVRKr100TwcfrNz1IHlkPRpGLQlH
         RWMSvX0oDDxzYFw9MWSBYIfcrcn4Wlj4Hfj3xbrJmYLEcgYU2XW9ZXZW+HU7N5ZNVnH8
         lL08Cpj0AiRYdwdOMw2vOm5tr84V7k4OSD/my3WuaLP1hECYZjDQtFG7F8FTLndu7zif
         WJPsn8Oz29iIZrsGO/RC8D1NTTtuse31Ac/7ts4gpA24LgRDTZnuzolC9Dq7u6TR/pV7
         SPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5NkeLFKJt2iCXOzG0EwL6JWBXBpZfdjpJ5FdJ6XiLHM=;
        b=HIpnM7bKzCglx/a2ZF/MuX1ywpMxqj+l7Lp794zSV6lSb004uJ+iIMX6RfaNpeQ6jv
         01VKRDL2goeRjAkPBDtagQAkXGVVNSRuwPTepuWupT8NTYu2tUimTAHcW1t94RysnAGw
         PlvlufgRYUtuyBVyuSY2m84jCouaZwUOhB4XEAsEOYOHVp24Ym+NyEK7NZ1zKEu/m1Kz
         lOlrqUxYepTGvcdG249dUT+w9NXRkWECn9sfHKn/DkrwOhCPeNblTx076MuqXNeh+g4G
         tsiIG1TYgee2gseBLownbnegroUxcZjL0BG28lSQCTdLUL1g26wN6q1qnZZi7ABeIHJ/
         7qbg==
X-Gm-Message-State: AOAM5323FwiuM0xTrm4sr7TBFm0r0tY7Ck6tCmz4zfXkgyeJqw5y7GUs
        B+bHlO7xb7BxYDgKlt8GW/eEV1uDthutTZN4Y1dpB7TJh+EbxQ==
X-Google-Smtp-Source: ABdhPJyQnsV7iIDt5frMN8+UbaJwf19dhYZQPvRwv+XVCFPv08cid+D8u4gl+GUsEgJwJRJxY/CZEjgj/1fdKkYOIfc=
X-Received: by 2002:a05:6402:1515:: with SMTP id f21mr2768928edw.45.1628686983795;
 Wed, 11 Aug 2021 06:03:03 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Wed, 11 Aug 2021 15:02:52 +0200
Message-ID: <CAL3xRKcMAkfaoAWo5VfQ_Q6nYkR94spSN4Ko6xfpSRKa1cEuAg@mail.gmail.com>
Subject: t5607 fail with GIT_TEST_FAIL_PREREQS enabled
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Our internal CI spotted a failing test when build from 'next' and
'master' branch

    git/t% GIT_TEST_FAIL_PREREQS=1 ./t5607-clone-bundle.sh
    ok 1 - setup
    ok 2 - "verify" needs a worktree
    ok 3 - annotated tags can be excluded by rev-list options
    ok 4 - die if bundle file cannot be created
    ok 5 - bundle --stdin
    ok 6 - bundle --stdin <rev-list options>
    ok 7 - empty bundle file is rejected
    not ok 8 - ridiculously long subject in boundary
    #
    #               >file4 &&
    #               test_tick &&
    #               git add file4 &&
    #               printf "%01200d\n" 0 | git commit -F - &&
    #               test_commit fifth &&
    #               git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
    #               cat >expect <<-EOF &&
    #               $(git rev-parse main) HEAD
    #               EOF
    #               git bundle list-heads long-subject-bundle.bdl >actual &&
    #               test_cmp expect actual &&
    #
    #               git fetch long-subject-bundle.bdl &&
    #
    #               if ! test_have_prereq SHA1
    #               then
    #                       echo "@object-format=sha256"
    #               fi >expect &&
    #               cat >>expect <<-EOF &&
    #               -$(git log --pretty=format:"%H %s" -1 HEAD^)
    #               $(git rev-parse HEAD) HEAD
    #               EOF
    #
    #               if test_have_prereq SHA1
    #               then
    #                       head -n 3 long-subject-bundle.bdl
    #               else
    #                       head -n 4 long-subject-bundle.bdl
    #               fi | grep -v "^#" >actual &&
    #
    #               test_cmp expect actual
    #
    ok 9 - prerequisites with an empty commit message
    ok 10 - failed bundle creation does not leave cruft
    ok 11 - fetch SHA-1 from bundle
    ok 12 - git bundle uses expected default format
    ok 13 - git bundle v3 has expected contents
    ok 14 - git bundle v3 rejects unknown capabilities
    # failed 1 among 14 test(s)
    1..14

Cheers,
Son Luong.
