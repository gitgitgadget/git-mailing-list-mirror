Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C956C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B45A2469F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgB0RjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:39:16 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37211 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbgB0RjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 12:39:16 -0500
Received: by mail-il1-f195.google.com with SMTP id a6so311940ilc.4
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 09:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4K2olsbJd/ogjrRUgROU1qk0S7wzt7Cn6mcPp+rAfRg=;
        b=BfLKc7jtrZIeGtVOxJOI0NxkyMLZRtKJcGp4FCEaJiwExcCQq9tUUl4V5huAjDDIoI
         lvq65oPT7Py/P+rLCaAbXjDNOMP5KKEJ+n5OLD98hGD/wUtf+Tc6qrr1MUvUxubmRjNb
         FWZlbzm6G4agnU9BLeyzzYpZdF9ZNy1F+f6fgw0c8Xwd2eIU0mL9sSu3/BsCFMCpYy7Y
         3UtKGmnyVz5uJ76dQDaSFZ/r+/kfP5uKEMIF5JLYx04zmEgCBht/rxAikY2XPkKdg3HP
         d+MqlH+VCKERzQzNDRsCmIYhz63PpSXUqarnNhVzvIPJ15vEc34YPFQ21VSIoYIJVxy0
         0wgA==
X-Gm-Message-State: APjAAAW5pm+1ckzV6GRHummitOiBV/9n5oPwUKhAGxo9OjgKD9jL7ve0
        3cEwvRyqnApXw84aOHKX4BkNtgglUlJL8Jo2CfcbXDzO5/w=
X-Google-Smtp-Source: APXvYqw+8T8P10oMiozvVlppySMOkneS5c8vzM+nIp9taOg0Gnch+7DHjK7CsYDUclsDO56QjKykrCo9aw5bvE9DNPs=
X-Received: by 2002:a92:9a02:: with SMTP id t2mr389700ili.11.1582825155535;
 Thu, 27 Feb 2020 09:39:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
 <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com>
 <CAPyFy2ArnEFe33GFLsbcOEV37DZ=VJpF-Sckn-V_tJUrToir=w@mail.gmail.com> <nycvar.QRO.7.76.6.2002271640320.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2002271640320.46@tvgsbejvaqbjf.bet>
From:   Ed Maste <emaste@freebsd.org>
Date:   Thu, 27 Feb 2020 12:39:01 -0500
Message-ID: <CAPyFy2BZoJAuugAbmgsrbzjM1pNu7o9Wzusz1qV7No8Hr+T4ww@mail.gmail.com>
Subject: Re: [PATCH 1/3] t/lib-httpd: avoid using BSD's sed
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 27 Feb 2020 at 10:40, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> My bad. I looked at StackOverflow and there the claim was that all BSD
> seds behave that way.
>
> Of course, SO always lags behind by a couple years (although even such old
> threads are often very useful), so it is possible that _old_ BSD sed
> behaved that way.

Yeah, I wondered about the different behaviour, and asked on Twitter
about it. You're right, it is historical BSD behaviour and NetBSD at
least still appends the newline. FreeBSD changed this in 2014 -
http://bugs.freebsd.org/160745.

> Related, I saw that Cirrus CI offers FreeBSD builds, maybe you'd be
> interested in supporting that out of the box in
> https://github.com/git/git?

Indeed - there is a .cirrus.yml in git now which builds and runs tests
(on FreeBSD 12.1). I'll look into working with the GitHub organization
owners for git and gitgitgadget to see about allowing Cirrus to access
the repositories.
