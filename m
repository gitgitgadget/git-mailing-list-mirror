Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE991C2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 09:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E630206F5
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 09:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcXNgVYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgDHJ3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:29:51 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36846 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDHJ3v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 05:29:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id nu11so932192pjb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CLECi7J87UZwcAyTHIS6JJoOxYbjCvXD61OmS4nOzj8=;
        b=NcXNgVYYCoNYBFFJK+8qbM3bl83DTzvt1WsjseO/YbHiXJrSh7O1tc7Ztipc/Vve7P
         AB8AJcY6LK+GzOO/hYtezfg+CmlyJMwTOy6AgiEQNNCOK3Adws0mgbglpXCq8USH93ew
         J9gRSuKyoPX69qMb9F6Bn2ETmI77dzo1+CVG7bem0eWtEStj8WpUC0XDVjy2v4U/SQ3O
         a+6pvIKGjAcil7BJvNM855g1L6Gkk07n368Z/AmFaDNUtcDLI/Qj4MzER1QPcCnkQxZf
         V0XyZAGFV/0/iV3EWSsJH+aIFyHV1bjEDwTw+aIqRb1yWmhlJMLy8fVM7gLK7chlLIaQ
         LaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CLECi7J87UZwcAyTHIS6JJoOxYbjCvXD61OmS4nOzj8=;
        b=ASU6Z+uI5uktSExZD/5HZeYCEIZi44jdLAHMQX8CRRGEfKdF1laNK0DxuYUsnIfspY
         x3igViQgWnuw6sV6sewzyd7gSfPWMhnTMUNizEWklgEuvuYJAuupKWsdjZQLt6dAzeAq
         PLbqLOKcMGc+Ce0i5gp8OU7KPipHLJJ7HuUKK6VJo81Kc6uR3Khgo0VuusWkDytdbxf5
         vr2dvNl/NNPmFrud5wkfLc8MsbEUdI5Ba8es1end6O5Ja3J7cu2qKjL5xO7vP3gXdib7
         I7fRhTJcMfFeLCDkyIHaEBwDJW+GAq6M1afZWfebBfQAkIE0LUkF67krv/hZxbzhXaLa
         Eh3Q==
X-Gm-Message-State: AGi0PuYrwmM31AfkF6JpPDlFkDPcEihPAYREuqfYVfDbcX8roOGP71X2
        HWm323MbGedHf7FCK+HO8Kz8etTKyvJcPZkq0Y7q/DPw3PQ=
X-Google-Smtp-Source: APiQypIoVaBg1Kgx6zSSp5rcPkv9rBh3E0CMxfzj4NLr4yI7wziBOND2U5RLZPVBFw0lWBJm8ndJWxGpuuit97oENUA=
X-Received: by 2002:a17:90a:e982:: with SMTP id v2mr4355883pjy.1.1586338190458;
 Wed, 08 Apr 2020 02:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200407184823.GA3932679@smile.fi.intel.com> <20200408011830.GA6549@camp.crustytoothpaste.net>
In-Reply-To: <20200408011830.GA6549@camp.crustytoothpaste.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Apr 2020 12:29:43 +0300
Message-ID: <CAHp75Vfuuth05wn-0x_AZa_LFSmQMHB6LGM5b4KNMoaxce1S-g@mail.gmail.com>
Subject: Re: subtle bug in git-am
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        git@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 8, 2020 at 4:19 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-04-07 at 18:48:23, Andy Shevchenko wrote:
> > Hi!
> >
> > What I would like to do is to apply patch from one repository to another with
> > same files but *different directory structure*.
> >
> > When I try to change directory in the target repo to the folder of files, I run
> > git-am -p5 my_cool_patch.patch.
> >
> > Instead of the expected result (files and their contents is the same!) I got
> > fileXXX is not in index.
> >
> > So, I think this is a bug, because -p<n> use in git-am makes little to no sense
> > without above feature.
>
> So if I understand correctly, you're expecting git am to apply relative
> to the current directory in the repository.  I have also expected that
> behavior in the past, and found it surprising when it did not.
>
> What git am does is apply relative to the root of the repository.  If
> you'd instead like to apply to a specific subdirectory of the
> repository, you can use the --directory option to specify to which
> directory your patch should apply.
>
> This is the behavior of git apply, which underpins git am.  However,
> outside of a repository, it _does_ apply relative to the current
> directory, since there's no repository root to consider.  I, at least,
> found this confusing, but that's how it works.

Thank you for the prompt reply with useful information. I will try it
whenever I will need similar flow again.


-- 
With Best Regards,
Andy Shevchenko
