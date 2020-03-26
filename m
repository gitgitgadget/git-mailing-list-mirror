Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC069C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 01:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8798920714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 01:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf/L27O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZBqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:46:52 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43730 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZBqw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 21:46:52 -0400
Received: by mail-ot1-f41.google.com with SMTP id a6so4226545otb.10
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 18:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZWn8WLAopn805wclLQ8AmkGVfaMePNECx13L1JaBCI=;
        b=gf/L27O5eAVdrKbuOYCQj6lnMuTZfHGmJCd1gNSGQ7Q3o/+Y+UJ20Z96or+DLkMKRK
         bE9NJVqGpiC3f1CTM2YYcH3vF3Hpe7N77aDSs+XLzxYrFO+s5AishG4nPtXA50FzfGx+
         gI+kNkArqMcMB1rmx1zW9WE7aRMNgTKbW9fC+/zlVh6eFOZun6u7DCKSiXVHMBWnsU2x
         wq+4RyzqpBBMhmlFIpq2Kkt7TzWXguFhrAks0zuZOES66YCa/jbBxjNoEHbyTsIXdgdq
         bwOGQ4jLD7GHWc6vTkwi0bALMge+XKQFY6TnWTF8lUODCOIZtZcs4iZPt7IN9FAnRlOq
         Pwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZWn8WLAopn805wclLQ8AmkGVfaMePNECx13L1JaBCI=;
        b=emIN1Le2v9dl9nM6a+I5fI3vmFpRvvHdrKwrX9hcG2pTe44HYRxeJSWLlcHk2EoB9+
         wLKpQotMzhA/f+u2EMYZHaPxunjj6wdqXBFgSf1xLQzTSn/OgJJZCP8QHl/L5vpLkMNc
         i/5efFwlXc0TLSCOWVt+LOIyuJU1liBlKoti2ubA9M11WZnoQ1m2ikVaG0Rhrgv/V/pY
         lAYkFltH9UFWkElu3SJAnTTZyWxl5VwDdfJQawLxYpUH8HQgdlLOaFGlZjTpfItA/5Ed
         5bNi7Smd5FB9ycGpqEtiQKPGC+ecgPSutqPfrx5ZAXhui3bpI67q0skVkrIipkpj49JX
         NChQ==
X-Gm-Message-State: ANhLgQ0y5F+iksNBabquB4Kx8ifQ7/4EmC1SaLgUsmFbfUOOVHwFXD5/
        +V5hYxtoUPriRNLKhCvBc+t2YHHaf8CWo9R5fEE+n4mMDsc=
X-Google-Smtp-Source: ADFU+vuvHOH/5MJ9spxqOTUzA5p86E1ZJNYgyW1a+YVPuSa2hvXxqviCGDf6ZSQTB1g877myI58fagdgKjEECuymKxI=
X-Received: by 2002:a4a:919b:: with SMTP id d27mr3581358ooh.76.1585187211584;
 Wed, 25 Mar 2020 18:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
 <20200325053908.GC651138@coredump.intra.peff.net> <CABPp-BF9LDfaw8=S4yqtuZ5U70Jcj_yZHq17Y7SUa17DwRqMSA@mail.gmail.com>
 <CAM+g_NtHC5ukU3jchVfud_H_m_h29UQ8vmwQoND8s_Q9Hv70Fg@mail.gmail.com> <CAM+g_Nvt3X4d5cjKajzDOcoDgNS4bVkj3a0KvVm4yDEW-J7v2w@mail.gmail.com>
In-Reply-To: <CAM+g_Nvt3X4d5cjKajzDOcoDgNS4bVkj3a0KvVm4yDEW-J7v2w@mail.gmail.com>
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Wed, 25 Mar 2020 18:46:39 -0700
Message-ID: <CAM+g_NsUfw6zDRj8H1VNdheKFSHgC9gz7nVy0vbtpTKkYzjjtA@mail.gmail.com>
Subject: Re: "git rebase" behavior change in 2.26.0
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a concrete example:

lt-nkiesel:~Platform(nextrelease)% git -c rebase.backend=merge -c
pull.rebase=false -c branch.nextrelease.rebase=true pull
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (1/1), 279 bytes | 279.00 KiB/s, done.
From msgit.rnd.metricstream.com:platform/Platform7
   d008080d3f2..db4042856da  nextrelease -> origin/nextrelease
Updating d008080d3f2..db4042856da
Fast-forward
 modules/bpcsfw/src/main/java/com/metricstream/systemi/client/servlet/servant/BaseViewController.java
| 54 +++++++++++++++++++++++++-----------------------------
 modules/bpcsfw/src/main/java/com/metricstream/util/HttpUtils.java
                               |  5 +++++
 2 files changed, 30 insertions(+), 29 deletions(-)
Successfully rebased and updated refs/heads/nextrelease.
lt-nkiesel:~Platform(nextrelease)% git rev-parse ORIG_HEAD
db4042856da8338f183c831fca92cf63da7988bd
lt-nkiesel:~Platform(nextrelease)% git rev-parse HEAD
db4042856da8338f183c831fca92cf63da7988bd
lt-nkiesel:~Platform(nextrelease)%

As you can see, git said "Fast-forward" (i.e. no need to rebase) but
nevertheless after that pull ORIG_HEAD is identical to HEAD
