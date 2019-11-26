Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ECEC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 17:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA44D2068E
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 17:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfKZRSW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 26 Nov 2019 12:18:22 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39625 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfKZRSV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 12:18:21 -0500
Received: by mail-il1-f193.google.com with SMTP id a7so18311394ild.6
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 09:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=clmbmc4fTbPIT95RFie6cqIeeggkkKIVOcfwhLUW5nw=;
        b=ddQBLgXOxaykJCPvb2JmhGtGuoZyDE5oYS/DXb9OCX8kPq2Xyta1UQdBX9lom8UEvE
         RLFnon1Pay9wDzRbyN7qjqUN0qqYzrXCxudn9vEHQGBdc94TF407IEzMLPzD/YYB2S85
         oYcfyDjI+cdm3GfSu/zIVsIQuG9dhPN2mxuRhv6J25Dox4M0dXRBIenUnc5xffcRJzod
         h0VKyUeQpmWYzw4lrFGX35uG20GVMNJXoqwQB4H/DjTrslsvJHT3rVzNdLIIiqzx6wqu
         Gsv9cDuz8RKiK+xMCQTgJkQBp1mWdBU6vhzPv/WdsGHRpLBVLKmgKn4Im3ETI4gqTWUg
         cSCw==
X-Gm-Message-State: APjAAAXv9HYuCn9dJOo9g9Gmt5WswKIrjSfLUfvgmEgal8IhA+PER0Lp
        QO93jto6rTfDSfO/hdGec/xH3xn6YUyoZr7HepFSkm/KLe0=
X-Google-Smtp-Source: APXvYqx/u147iOLDBmN+ojL+SPVl344beeB01ZlliKrFtE4irReHeI7hnvP1bUabFY3JwMfPZ/0h2jA8+EmE6CDJl7I=
X-Received: by 2002:a92:2450:: with SMTP id k77mr38653972ilk.120.1574788700713;
 Tue, 26 Nov 2019 09:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20191125203740.72249-1-emaste@freefall.freebsd.org> <20191126004419.GE2404748@camp.crustytoothpaste.net>
In-Reply-To: <20191126004419.GE2404748@camp.crustytoothpaste.net>
From:   Ed Maste <emaste@freebsd.org>
Date:   Tue, 26 Nov 2019 08:31:46 -0500
Message-ID: <CAPyFy2A8x99fa3ti1E9Fqkcpw8RQBn5AJaL+u5g=e0qeMeyf2A@mail.gmail.com>
Subject: Re: [PATCH] ci: add Cirrus-CI config for FreeBSD CI
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 25 Nov 2019 at 19:44, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2019-11-25 at 20:37:40, Ed Maste wrote:
> > From: Ed Maste <emaste@freebsd.org>
> >
> > Cirrus-CI is relatively unique among hosted CI providers in supporting
> > FreeBSD (in addition to Linux, Windows, and macOS).  Add a Cirrus-CI
> > config to facilitate building and testing on FreeBSD.
> >
> > Signed-off-by: Ed Maste <emaste@freebsd.org>
>
> I'm all for automated testing on FreeBSD, but we would need someone to
> triage and address any failures reasonably quickly.  Is that something
> you'd be okay with doing, or is there someone else who would be okay
> with doing that?

We're currently experimenting with a migration of the FreeBSD repo
from Subversion to git, so long term there will be many with a vested
interest in triaging and addressing failures. In the near term though
I'd be able to take this on.

> > 6 i18n tests are currently failing and need investigation.
> > Example result: https://cirrus-ci.com/task/5394512637067264
> > Test log: https://api.cirrus-ci.com/v1/task/5394512637067264/logs/test.log
>
> Could we fix these issues first so we don't have CI suddenly start
> failing?

Indeed, that makes sense. I think the failures may be an issue with
the test though; here's the first failure:

expecting success of 4210.6 '-c grep.patternType=fixed log --grep does not find
non-reencoded values (latin1 + locale)':
                cat >expect <<-\EOF &&
                latin1
                utf8
                EOF
                LC_ALL="is_IS.UTF-8" git -c grep.patternType=fixed log
--encoding=ISO-8859-1 --format=%s --grep="_" >actual &&
                test_cmp expect actual

fatal: command line, '_': illegal byte sequence

This was added in 4e2443b1813 with this note in the commit message:

| It's possible that this
| test breaks the "basic" and "extended" backends on some systems that
| are more anal than glibc about the encoding of locale issues with
| POSIX functions that I can remember, but PCRE is more careful about
| the validation.

I've CC'd Ævar Arnfjörð Bjarmason for advice on this.
