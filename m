Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E44C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA302222B9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 14:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sathyasays-com.20150623.gappssmtp.com header.i=@sathyasays-com.20150623.gappssmtp.com header.b="BP6sMABy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgKBOAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 09:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBOAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 09:00:40 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E9C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 06:00:38 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 126so17562602lfi.8
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 06:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sathyasays-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=xc013e4y9WsJFK2ZUZtb01gf/RhWVdL3aEKEOAsnBYI=;
        b=BP6sMAByZSEZVG2inio29pfqEu2wiFjaEUlv3j8GliZDwbmzyNiIM35VzwhkzVlsqT
         JGHJ42Ao3oU0WDcPL/zWTheG0TuFUb7hGstr6qjVwJrFq3fti6x+dbez3Wf1anrr3VmW
         C4zZqLD8cJfSNywxlfhskk0RQ1uLTy5nstYAc9uQf3zTJbw0+1FyrZfFcc0duH8QsfVp
         qiodPqxyf1edwwAeoPI+/CXRwdl1zSJhj9mWcPxDk+pQ78kco0qPcRyeBLNqQT0Bxfl7
         LTTRQikIodwqEyndvasfMMKIa6IIQb1NTmnMZH56Lv1ZhtEiY0fHofdnwctdh5SiaCZF
         OmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xc013e4y9WsJFK2ZUZtb01gf/RhWVdL3aEKEOAsnBYI=;
        b=AIQVbN3PWOsFSL015L5tEKmJh380lOD3NOEXHliSlbmLkhDcetkVnBkJACbd/WExj9
         9uMfoOM/bwFGkVvxny7e+DhCnX3KcianERpXRhNlzPUFFVEHaweO3rjbW07KWtHnUUpE
         IB23bqEdqd6kq/GqasKlr+WHDXuXY+1DbBihh53WzkmKlkdqptl+Ihx420IIrClMVbAu
         sHfvP4KyGuIR5/oA/fo2rentyak2L31KmTrASA/oP/KpQdOW1Ykiq+Ps6MWGj2uIca+q
         hDoHWJGfjfzpA1R2cHxo4ZV0Q+F6fC1z7RYdy9PNoP/9vRGj2jK2/lbtt/NMHhW0RJu+
         mTVg==
X-Gm-Message-State: AOAM533Y/Vqgwdwh3Kjc0F9ueJFL2OhZx1jsXR1vcKydI6sRQ6CwrdU5
        BDe+LKQ6/dGZXY6D9otme9Q3IczTRlhonMaZ2UbYSqPPLrvZsla1sB4=
X-Google-Smtp-Source: ABdhPJzLnEzxRNSfI7UjlqkkGjQme36+9lKSrJeR+mQy3qSg6HUdMw0OQqYISezId9bRfmeSoeJ+sRFc0kcZJ1WCVcE=
X-Received: by 2002:ac2:4c8a:: with SMTP id d10mr5395448lfl.75.1604325636191;
 Mon, 02 Nov 2020 06:00:36 -0800 (PST)
MIME-Version: 1.0
From:   Sathyajith Bhat <sathya@sathyasays.com>
Date:   Mon, 2 Nov 2020 15:59:59 +0200
Message-ID: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
Subject: Segfault in git when using git logs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

My code editor kept crashing repeatedly and when poked in syslogs, I
found that git was segfaulting. I can repro this easily (steps below).
This is the first time I'm reporting a bug here so I apologize if I've
gotten anything wrong.

Below is the output from git bugreport

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Try to find commit logs for a file. I can repro this on a new repo as
well as an existing repo.

Simple repro steps

        mkdir git_segfault_test && cd git_segfault_test && echo
"Hello" > hello.log
        git init && git add hello.log && git commit -m "init commit"

Now, use git log to show commit logs using command

        git log  --follow -L 1,1:hello.log -- hello.log

What did you expect to happen? (Expected behavior)
Git should not segfault

What happened instead? (Actual behavior)
Git segfaulted

What's different between what you expected and what actually happened?

Anything else you want to add:
Note that I am not calling the git log commands directly, my editor VS
Code was repeatedly crashing and I searched in syslog and found this
error.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.9.2-arch1-1 #1 SMP PREEMPT Thu, 29 Oct 2020 17:01:28 +0000 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.32
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]



 -- Sathya
http://sathyabh.at | http://sbhat.me
Author, Practical Docker with Python & AWS Community Hero
