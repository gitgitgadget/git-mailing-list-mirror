Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C04C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 00:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017232137B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 00:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGxZWhkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIHA3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 20:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgIHA33 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 20:29:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338C5C061573
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 17:29:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w3so17806701ljo.5
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 17:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oqDLBChWRgkE0l81JOOVM2H1kXCG4O2V69NnUy99PWM=;
        b=ZGxZWhkG+0sVbG0dFtE0mzteh+YWXQxUsi9r01CE/EkZ6A/53ICBZw0XuboahUCUZm
         cgpeh7Jfq1rScsy8mcK1U/6Y00sK9WYJ8b3203h53BR0sxNPloAk0LdZQSC8VPpDlsI3
         UGnWIfAhVDBbkWMneovp6yJcqpZ6yXqRknl+Azb0UJRomR5YrHXWwsGJvyOeFVT/2Ama
         B50DzhDvBkTeWBy3lNeZK8yU5IaHPk8oFaUR7A9g2xo/dNebtlIOZyEzX3n/l5xv5Hyr
         imuLYnnF+5Y88QDICqNaRd0nqRi3s1VsEt6u1Y1e5Qw03NqtSZmWKLyBvMzphwDd49T1
         LTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oqDLBChWRgkE0l81JOOVM2H1kXCG4O2V69NnUy99PWM=;
        b=O7OWnOcWObXUl1Wo50xxqXcPfqAfF7mfH4gqceE5FLOqmfhedT0RVAFwGKtbUCxgTb
         ui5o3RZINXQywXhY3d+cauOi81GNuqgwQ//2Oo2Kc0djTx8688MLhydAYYHfENf07LFw
         cUgILCnRWmUcLq0X6f5UlbngkEW2qyBEd/+vooDkRyk6qtLkoKSOzuNpbulrVz+aNCbH
         fqZF5Tjg7m++rev5HvV13WZbwiHIaexUUYt/YD6GA1EF1SrIyreeBE/VIfjA983U+QMD
         NZgnplPA3YkSOf9j43WTNAQzc4hYL8Xe4gq3BJJ9vhS92G4eIr/mR9A5qEXAblZ7wQhy
         hmSg==
X-Gm-Message-State: AOAM532aM4CFYh5L0Quhy2Mb+T/vLPVyg2ka1epDMElOqW+X7iVHemer
        KX5pO9lciJU4JOQhQ6f7o+dQKDpK9qkC9p5VCnkxBfgExMpfDA==
X-Google-Smtp-Source: ABdhPJxMzVsAfJ6wISK3JpYo6CJ9TR2C4xgRB7I0MzZSuihWCA0Hwwbb5lZR+ZcJ9d7XisVFPu48rcaoTH41mRITRh0=
X-Received: by 2002:a2e:9d19:: with SMTP id t25mr10982878lji.222.1599524963192;
 Mon, 07 Sep 2020 17:29:23 -0700 (PDT)
MIME-Version: 1.0
From:   Patrick Fong <patrickf3139@gmail.com>
Date:   Mon, 7 Sep 2020 17:28:57 -0700
Message-ID: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
Subject: [Bug report] git status doesn't escape paths of untracked files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
touch "this is escaped"
touch "this is not escaped"
git add "this is escaped"
git status --short

What did you expect to happen? (Expected behavior)
I expected that git status --short would string escape both "this is
escaped" and "this is not escaped" since they both contain spaces that
need escaping.

What happened instead? (Actual behavior)
git status did not string escape "this is not escaped" but it does if
you add it to the index.

What's different between what you expected and what actually happened?

Anything else you want to add:
Once you add "this is not escaped", git status will output it with
quotes. git status --short seems to change its behavior of escaping
based on whether the path is tracked or untracked.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.5.0 Darwin Kernel Version 19.5.0: Tue May 26 20:41:44
PDT 2020; root:xnu-6153.121.2~2/RELEASE_X86_64 x86_64
compiler info: clang: 11.0.3 (clang-1103.0.32.62)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/fish


[Enabled Hooks]
