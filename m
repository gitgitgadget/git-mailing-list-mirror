Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DADC64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 15:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC3620758
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Y25z9piE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391805AbgLAPY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 10:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390252AbgLAPYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 10:24:55 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C22C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 07:24:09 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t22so3574664ljk.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 07:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:from:date:message-id:subject:to;
        bh=jCJzuj/ZZiz/Q1LEHTr2r8ONAz14QqM2U6hStZWEYCQ=;
        b=Y25z9piE34fovAblUfpzZhOPK94pgcbzVJFoS0OjMX2RCZ1C6srvh+7CleZ1Y3jW7v
         yQa76VY1enlRmj6BkGq5lF/exFeYflLb/eZYjDIi4UvsLCtj8o9aGKidJtmHRweE8wJd
         BLzFzsnF1zAMVozieUT9Iqghf9748KBMf4CQPSL0B4rGHNSYusEzsFHxqPjElGQlRCDL
         adTlKVTyFesGKNvR6eB1k9xdxq5q4gAvRAe9oQGlUFdbp/BLut0vUlP1PjwxG2A7yUXX
         P9u0nCLjGEha0g7TRUFoMsGN/2EA5nfCXjszUYT4nUZpjcjWYG5UPf1XplTZygBB1ltU
         uGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jCJzuj/ZZiz/Q1LEHTr2r8ONAz14QqM2U6hStZWEYCQ=;
        b=VIU63/duOsvyEpOCmvkzLP4FYWFfsyKIAdrHYnZFjbB9EkxdRRKgYByPMB5p7Jwrbj
         zsB6EoucwKWDV8qwnPRgGqrqVwgLqfcGUneDKDu9wr2Tfj+Ju23PKyl1N6M+x/rR6Dyh
         2nh1iY+E7K7DuPpMxSdgVrGCkHMPq2r16TOyHwSJvDHPAbu6/gcaB2oK9tK671sz611V
         BPV3OoCCSmiazSyTQfxBZn9PUbs/s8McriMRc6TiRvgxTNJAzjKymaAN35BBCJZ2FmEY
         13zM1AW2dUvJulDxkm+PbYqf0SzRi+m2/rPA9B/Woo/cJ0Iwbqheh9FQmyfjPL616YZO
         p/YA==
X-Gm-Message-State: AOAM531kbQCUODAQ97f5IML25FPCTaLh6wXOuGODe75vWcakiO8rkrvl
        /4bndMWDcSeR9HcCTdg1RHvc8SVtUsYKR87KcuPjMfi+km3lfQ==
X-Google-Smtp-Source: ABdhPJzJFPhBjacwPqfHJWIwcJl1tPmOUl55a05ykd9ax4mxTuHgeKtsUjX9vfxFDg/umHyyldJl7F/GVwdsHh9MdgA=
X-Received: by 2002:a2e:95d4:: with SMTP id y20mr1484457ljh.74.1606836247438;
 Tue, 01 Dec 2020 07:24:07 -0800 (PST)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 1 Dec 2020 12:23:55 -0300
Message-ID: <CAHd-oW4yHSTYr0Gwn60tu2c7VY=PJbSbg23Z5Bd_11Do-+juGA@mail.gmail.com>
Subject: Is git-am expected to honor core.sharedRepository?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I'm not very familiar with this setting, but to my understanding it
should only affect files in $GIT_DIR not $GIT_WORK_TREE, is that
correct? Nevertheless, apply and am (which uses apply) end up
adjusting the permissions of created directories based on the setting.
To give an example:

We first commit the directory 'd':
$ mkdir d
$ touch d/f
$ git add d
$ git commit -m d
$ ls -l
drwxr-xr-x 2 matheus matheus 60 dez  1 11:29 d

Then we create a patch and use am to apply it:
$ git format-patch -1
$ git reset --hard HEAD~
$ git config core.sharedRepository 0700
$ git am *.patch

The setting was honored by am:
$ ls -l
drwx--S--- 2 matheus matheus 60 dez  1 11:30 d

And if we delete 'd' and check it out again, the setting is ignored:
$ rm -rf d
$ git checkout d
$ ls -l
drwxr-xr-x 2 matheus matheus 60 dez  1 11:31 d

Is this expected?

If not, the place to be changed is probably the
safe_create_leading_directories() call in apply.c. This function
internally calls adjust_shared_perm() to modify the permissions
according to core.sharedRepository, so we could probably pass a flag
to skip this step. But this function has at least 15 callers, so
should we introduce a wrapper for the non-shared case, instead?

(For some background, I stumbled across this while considering using
safe_create_leading_directories() for a parallel-checkout patch. But
then I noticed it adjusts the directories' permissions based on the
setting and I was worried whether it could be user for checkout.)

Thanks,
Matheus
