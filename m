Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24769C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 09:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AF520640
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 09:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="Bhm4/OSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfLCJbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:31:07 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:35739 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJbH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 04:31:07 -0500
Received: by mail-il1-f169.google.com with SMTP id g12so2559814ild.2
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHxORqjL0fkYIjRjXkp30HXKzBM5odY3mnkAtUGiuYw=;
        b=Bhm4/OSiMXpdBeAtldmAZWV8HApFEB6RNh+Goacr9MMLMOIrTdkvHXqjEIaS4EvbBR
         mbdEZxDTIx2h9vbaBd7P2/mGs8RIzMEDSQZkJcDT25j6bWHSqtBPSeq+zW3P8gfqDq2C
         eC6b+p7cBSbiLjxk7iyKN4ZVUE5wjHm/HUAC20L871PwlYu96KtjB7WcCLd+tyR+qFsU
         Es3B58rdanyoa2MUGlZfYkD+dPYrgioLDtgScrHkOB3Jpj+9G0kWmbHbLkLD/6A4ZFCK
         8e2pqjBWnLkmltOxH4RgGDuCcVXxNRzQD3rjzjsTVd6IekCSobnFv+DwKHEYIM/yMbka
         QMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHxORqjL0fkYIjRjXkp30HXKzBM5odY3mnkAtUGiuYw=;
        b=ld68u5HUBHbNjTQabQoYB6Kh9kbycrPpHpS8BXoaRcj+tiM9ONrhj4aaS6yE11wriI
         +6B8LWh1jF3SwN1RGD/dG4QdpVidSH2RfsDWmMzymrW5Pm5fJ1jH66Lg5dZ7QX8Wd57r
         jZ4td9rZaFKobGDLoar5dhJFwt+7iRnYFwZpNLHfRBR+rcXmsaBIwh1PAwrZnDBj2ow8
         FGxXAlHLOPjiJc6GgqrhNFyJh+1etlc2B0w7dYh2PxP5CJIs29zUsfGETg8dk6YGLeBY
         8uewx2RjrkDl+L7SR0jHRNCQhAqk3jQpHH9dW3KM5laQHBpWjn6p0V0FYBLbTc9zdE1f
         rDoA==
X-Gm-Message-State: APjAAAWSALteG+CruNXykf2zcoI2U4rG/e0oxEJ7yg2ntkoCssmP/34a
        dTQN8QCykR2oen5t4czR/U897KbCktuEczTCGaoVcQ==
X-Google-Smtp-Source: APXvYqwK770zBeUS09MSfqObfGhY1wbkaYk/w9Rd2R9ijhIuLR6+Q616B5iQtZ+a95Ijel0/WLr6bNRtHUWYBjuIq2M=
X-Received: by 2002:a92:6611:: with SMTP id a17mr3604265ilc.148.1575365466405;
 Tue, 03 Dec 2019 01:31:06 -0800 (PST)
MIME-Version: 1.0
References: <defeb7be75f54e8483ce529b2571478d@nokia-sbell.com>
 <5e27e2a9f6374742859b4b87d85c56e9@nokia-sbell.com> <1af00173f96243bea760baaddeb15777@nokia-sbell.com>
 <CAGyf7-FW_8RjVPEtmKiNFnF5QNZ4f+kqZ_BAGnGu76QcR=F25Q@mail.gmail.com>
 <a755356230794fb58bdd48dd74714aee@nokia-sbell.com> <CAGyf7-Fn-XRQhGCLdr+WxBAWKywQH2_s8XCsNUG7Vpgyu2jjUg@mail.gmail.com>
 <0b2bd41ca3b34369ba0504e3bd7254ae@nokia-sbell.com> <CAGyf7-HmACw1im7C-RfkO5YLf0t+11LmqwPqMOjSTN5a4y7-hg@mail.gmail.com>
In-Reply-To: <CAGyf7-HmACw1im7C-RfkO5YLf0t+11LmqwPqMOjSTN5a4y7-hg@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 3 Dec 2019 01:30:56 -0800
Message-ID: <CAGyf7-FWF_-H=z9jozeoC05XDKTmzU2N4K5cH0WCdZnKBF8Osg@mail.gmail.com>
Subject: Re: one bug on git
To:     "Lou, Pengfei (NSB - CN/Hangzhou)" <pengfei.lou@nokia-sbell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Dec 3, 2019 at 1:25 AM Lou, Pengfei (NSB - CN/Hangzhou) <pengfei.lou@nokia-sbell.com> wrote:
>
> I think it should be like below
> [pelou@hzling29 try_des]$ git log --raw -1 --no-walk=unsorted 57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15^ 57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15
> commit 57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15
> Author: pelou <pengfei.lou@nokia-sbell.com>
> Date:   Tue Dec 3 17:00:47 2019 +0800
>
>     3
>
> :100644 100644 9a7456b... 8148ef7... M  lpf

So you always want to see the child before the parent?

Try " git log --raw -1 --date-order
57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15^
57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15"

(Replacing --no-walk=unsorted with --date-order)

Bryan

P.S. Again, please don't top-post on the list.
