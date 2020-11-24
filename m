Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD2C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 23:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C661720BED
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 23:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INYDi/10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbgKXXYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 18:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgKXXYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 18:24:04 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EBAC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 15:24:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j205so497639lfj.6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 15:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6qv6BA4QIaTRbCFjnnbXcU4C/zufmU9ahlnBhop//WU=;
        b=INYDi/10Kq3E/ytzRGi5wTa6ilud7qArN1sHw+7WilVcfbzOxBbqphBXjKEXkHgnP7
         ZmcnjtGIe8CafGyKrrbJ6v79BpBKmiyWZGLqpxvjAwIGVNTvDDSFV0mWFXW39xQTThjn
         DELgJ/I5bAyNc3H1PoViCGrOivVNDiTe2En/EpzSnsUL5klHnZswd1mosUiQHphaGTro
         Fwg2r+bxWPpcF5/s1wW+kZ2J8Odj7U70kHQGxuRSNpYBrAEm/V7y92usErDluY616dyV
         vfD4WTRJfFO5ehrUWkKrdDts6tLii6/cUqYwVC7Ln1hbbDiPt02eXX9m0SrjEqcOQFzY
         t/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qv6BA4QIaTRbCFjnnbXcU4C/zufmU9ahlnBhop//WU=;
        b=t4LerJwG3vO+QncbBueagJahayRpXZ8/HEiM+dKRlsJIZZQwX/HaYmgVYJ6sGC9pLo
         Ao5HPyrvMp929r4SeEkohQjauqP32rnVnuwFDVIFBg6hHLaVLIO5/Ou06FjSWoPuauKB
         DlK59HmwjhgQUhkHhye75EWE99QwKPO9TrG01HIhDFe0WZ8GflkmzO74w6YGMGkh7hsP
         jbfqIcPNKUcJWsVezxJ+HRCj5397kGn6TFqf6UwafwqVNxRy52JpdFUEU4fa/6gkQQHm
         RFJzurka3LvVXzcfLw+cRE8MqmH27/grYi5hmNqI+QTXX1A6N04r8/ALZflA614iMD5P
         Hqxg==
X-Gm-Message-State: AOAM531Gesg/eI+1rOcAKcwX6ZRB2c5k9nttoCnhoKfyvlG/6pJ9590i
        6e8hcuQ0Mx/4UPQFUrDEZoJkzp/p+flqFxVZJ49jnzR/JRE=
X-Google-Smtp-Source: ABdhPJwXaSR4lbdP5DDCl7gLHn5Nar0aeQRzfNGY8kli/kpF2l57bNvex8lYJOmkGgS3KmfFzABYA4FE2UC851k9SrY=
X-Received: by 2002:ac2:5475:: with SMTP id e21mr182970lfn.153.1606260242617;
 Tue, 24 Nov 2020 15:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20201123191355.GA132317@mit.edu> <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu> <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net> <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net> <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
 <X7xgow4pchnhf2iY@coredump.intra.peff.net> <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
 <X7xw0xb9UnGKbS8m@coredump.intra.peff.net> <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
 <CAMMLpeSoGtqeCm6u-zrHqvPhW7brvNk_kwde3uqmbPcP1JgMHg@mail.gmail.com> <CAMP44s2z3vv2LwoMesydVL3qWrJh0VvHSUy+FpnqguoipRRD9g@mail.gmail.com>
In-Reply-To: <CAMP44s2z3vv2LwoMesydVL3qWrJh0VvHSUy+FpnqguoipRRD9g@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 24 Nov 2020 16:23:49 -0700
Message-ID: <CAMMLpeQvofhPjcJ19JrqJs1W3YoQSP+hOainuZJa=QeJzYc+5w@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 3:11 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Before making "pull.ff=only" the default, we need a transitional
> period in which if it's unset, a warning is printed when pulling a
> non-fast-forward branch. This is what my patch did several years ago.

We'd only need a warning if both pull.ff and pull.rebase are unset,
since that's the only situation where the behavior would change. And
providentially, we already have a warning in that exact case, although
we should probably tweak it to explain what the new behavior is going
to be :-)

> And yes, it should be possible to do what you suggest, but have you
> tried? I suspect both the code and the documentation would be quite
> convoluted.

Yes, I have written a very simple patch that implements the behavior
that I am suggesting. I will send it to the mailing list later
tonight.

-Alex
