Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D092C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 03:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2421E64DDE
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 03:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBADGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 22:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhBADGG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 22:06:06 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80DC061573
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 19:05:25 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id g7so13168075iln.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 19:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1NymW9v2bZ62tWekb/9PHAIbcu73lO3+tb6tF0kSQVk=;
        b=WfE/aJNmK+65maLWa7eOU6eehTCRQhB8vbPXecnN6sxK7oEtYzE4GcFtfSIVPAYPff
         NXXKFCGJn8cJ8iU53/Q75ecWBpnzmYsFbDwFjJlilOW3hR+ptUK6Yzr3T6XYTpHWV5Ij
         H8gmgr5webkroTsYwHQXnvhNz6iRGSuduSL2Oi2j9xWdqJYOGkR3Pl5SQLVmaKprbPGD
         jJXzYx1ZczUk36k2a/h2LizWuDLc+juWmqw8s/Hr2/5hAthgfaWKs29rBRxCBjo29GjA
         m8D3ewJkkGg51wJ5+JJKj4YVt2qX135E+PRNOhjuFG+STVHv/bHqSpHQq9cIjGRozidd
         zw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1NymW9v2bZ62tWekb/9PHAIbcu73lO3+tb6tF0kSQVk=;
        b=h3Kx3mpLAs46iEGhXr5ntWJX7uqY73yAL6sActQASPVeDuJV/nP4ZtGotUp7EQ2Oso
         D/qrlBJeu2/sQnkvTJwjJCX3cUWwrtCMEnNY+n/v5+0bquSi2INXRtMVC2HgQX+eqmnh
         xLz1rfaKQwBfnszCDGdJGG8kkR1XvMPy4T3AGaoB0uRqh1F47MEn4wACJ6OzU0WrhTHs
         XvjRKiTBaMgne1l1t0tHp0ii56dAhuOjd8jXtCntchNuT1rKdI9+z1p2f/A8lNbBQdgR
         /jZ8VpyRbuytROoCbpnVI7fiMYSk2PF62EaGswDM/qRupvkGCyDZLsG6TcwUYWDmsqpv
         /oiw==
X-Gm-Message-State: AOAM531BS4+0VV6zX5vnffGkV2FAq1J9fdIunWLYqMXcVj3lcWsNbBGP
        xVdZ5xEsKH+s4fYY8SCqm8UmXBip5BJ31zc0aMM0NaD60wk=
X-Google-Smtp-Source: ABdhPJwX/ksB6xyFPqkjmY/aZJBUWkoLQuxpD964zqtZHcveGmLnsgVb1g6MEEBSc5dCaGJcVUVmIegBhRS3BdmZBh4=
X-Received: by 2002:a05:6e02:b25:: with SMTP id e5mr10910984ilu.37.1612148724619;
 Sun, 31 Jan 2021 19:05:24 -0800 (PST)
MIME-Version: 1.0
From:   SURA <surak8806@gmail.com>
Date:   Mon, 1 Feb 2021 11:05:13 +0800
Message-ID: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
Subject: I've noticed the command `git --git-dir=<path> shortlog`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone

OS: manjaro 20.2.1
git version: 2.30.0

I've noticed the command `git --git-dir=<path> shortlog`

It gives me some interesting output

$ git --git-dir=<path> shortlog --summary --email --numbered
--committer HEAD --end-of-options | wc -l

When run it, it will tell me how many committers on repo of <path>

But when run it on git repo dir, something interesting happened

$ git clone --bare https://github.com/gitlabhq/gitlabhq.git
$ git clone https://gitlab.com/gitlab-org/gitaly.git

$ git --git-dir=./gitlabhq.git shortlog --summary --email --numbered
--committer HEAD --end-of-options | wc -l
> 2592

Ok, we can known the gitlab have 2592 committers on HEAD (refs/heads/master) ref

Then something magical happened

$ cd gitaly
$ git --git-dir=../gitlabhq.git shortlog --summary --email --numbered
--committer HEAD --end-of-options | wc -l
> 2587

Obviously these two outputs are inconsistent, and the second command
was affected by the `gitaly repo`

Shouldn't I use `--git-dir` to point to a bare repo? Or something else
went wrong?

Thank u!
