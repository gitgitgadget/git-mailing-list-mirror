Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61403C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 23:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3AA2076A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 23:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N6R8siAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCYXip (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:38:45 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:37682 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgCYXip (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 19:38:45 -0400
Received: by mail-qt1-f177.google.com with SMTP id z24so2595607qtu.4
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=DYpwvNWX0wCaW3Rv1wucR3dVcop0i/lcmTzAaWy8/ZI=;
        b=N6R8siAgOwMNpGa/ba5CVuwMGdTkHiNs2YuneSNsS2Hb/b5lHUo6vaKHlP4BbXuuQ5
         LUGZn5BCh0Ud/cYspgoJhxWIpv+pUWh6TBzo9TB7Nj9F4ERPHYwCHEJplgnN/oX+86hy
         hBbb4y6xAuvdFUi3RkvIrUl5OLO7CYrPyCv4SLXWdEzrXpTol9Cde7n7LoTytxUzJnQw
         QXM2ovtmkq9zPglV3IsJamw502pOEkOCffJqML0FhTrxVRrDfRP/FsIvLADvvNEwNDSy
         tpl4SdEdDHMknyrTyrH8XJUczBdBEA3TVsveDdnbkx+oph4Xp5eVunzE/IMrjut4Po21
         dBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=DYpwvNWX0wCaW3Rv1wucR3dVcop0i/lcmTzAaWy8/ZI=;
        b=KT3Xd17x9bk79YdyfvNeZ2YfKGHtv/XWn2Wl5qGHgcmgHHvAcZtws3iiPzgGl1tXB5
         u4g68JH7im9a6vZ7XFLv4mSWohRaB5Sh30E7luS6Xh5IrtI6PeWxF8dSoGhyIUhg2HbA
         BIu58MZ1lGDAOh+US6gVtyYYeekUoC1inhhTWZW9JmWCtFNS7m640Fmi7yipDSoGA1kI
         mqTriCjp1Gm5cqm9Xf3PfKnU2z43+8rl8eKtBs/2eix/4k/IM2tuZHeg2Nw4NDkqCQYf
         Ek+ByExgq8ADKHjCSAcaaIR2zQIn7tSfIbM8QTccikvGBf3pQqwfT9rHbYCvLALYpX7I
         SI5A==
X-Gm-Message-State: ANhLgQ2L+SuGS11usF0OMINptTq3kdfc8PZpYqf3cG47CTxw9KITXz87
        hLhJbcgLHH7JhLznoG8e4d8kF2dbvdI=
X-Google-Smtp-Source: ADFU+vtML7Um4dsbw9Buj3DxIbzDpy7qi0l9VHfr4casizwwZSaOo42GgmBZeAir0OwLLGJYlTvEug==
X-Received: by 2002:aed:200f:: with SMTP id 15mr5538955qta.152.1585179522265;
        Wed, 25 Mar 2020 16:38:42 -0700 (PDT)
Received: from [192.168.2.21] ([142.118.142.146])
        by smtp.googlemail.com with ESMTPSA id n21sm407456qtn.17.2020.03.25.16.38.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 16:38:41 -0700 (PDT)
From:   Daniel Malendez <dmalendez@googlemail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Git doesn't support symlinks
Message-Id: <CA8EDABA-A41C-4177-A149-51DCD07C319C@googlemail.com>
Date:   Wed, 25 Mar 2020 19:38:37 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I use `Ubuntu 18.04` with filesystem `ext` and `git 2.26.0`. I want to =
add a macOS Framework to my git repo, which fails with the following =
error message:

    $ git add -f /var/opt/project1/Foo.framework/Headers/Interior.h
    fatal: pathspec '/var/opt/project1/Foo.framework/Headers/Interior.h' =
is beyond a symbolic link

If I use `$ git add .` it works fine. Is this a bug? This is what `ls` =
returns

    Foo.framework $ ls -l
    lrwxr-xr-x  Headers -> Versions/Current/Headers
    lrwxr-xr-x  Resources -> Versions/Current/Resources
    drwxr-xr-x  Versions

This sounds like a bug, correct? If not, I am thankful for any advice! =
Thanks!




Best Regards,
Daniel=
