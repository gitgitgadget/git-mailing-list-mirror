Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82DCC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 23:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EE460F38
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 23:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhHJXuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhHJXuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 19:50:11 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46229C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 16:49:49 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id i1so349529vsk.8
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 16:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mdY8zl4cUMDo5bMQ8c2IkAg/ylORjrX/brXt11WjFUg=;
        b=p73bmoqFrBgp+IHIeQeLz7X2oZ0KsLzRdiLjlGbQBlnbQq1QQNrCppgzz2SfNuL097
         qqF6oo54Gk8NRiwC818KgwDzfnyc8jS1iV2qHm7dicluSR6Ji75BlbsGjjL5rKJdfkbP
         /XobgnwVE0VQgVnZETQWC81rtEq5APQHzZ5I01oFQtl6tFU2UphypZuYgeuGLLcrBgck
         OyRgXhu/WPpdkvY3ms1O0hJFH1LmbVCFwpJkAqubETs9CLeRJXNc+GZR3yM0QIMib1WD
         3TcV0TI9NCuxOlqXPIRlRnaeJJ13Irhuqm6rzz719h1iqUR4Ub2mcAgcrfWQ6OwPC2AS
         pCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mdY8zl4cUMDo5bMQ8c2IkAg/ylORjrX/brXt11WjFUg=;
        b=Z0BlEKxI+h1GQsHU0eSEcXd5MzOEMaHRRYpRqyKvVIQtH3FCQm33OkzNHW0LZTi07z
         bkBlpqADrh6tJEmCnSSCP7koM8ffWLrgwOQyZsvvkNOXZbfL+02sw00vHYCT4vs/Vraa
         qE4NHCcc9WQrj9JEU/89ItemAWg/ureYFCwxdvDBSgALoEs5exb8lEsS8HHIZ+1DMtOs
         GtKOelzGWiX5+3jpQjjEnsAExB45V17O+h9cEM2dIVwbMsMyLFsF5Ry2b6H0oSAvgz0K
         Nyfk+wMU/Swn1VMuYWUBb8UsdGo4OlFUH1Q1DkbgTIbUPMdQm6BYXIYeYN4ZByILYAuH
         s6kg==
X-Gm-Message-State: AOAM530VRx0zVE1EADYuwn9Svpsh0xp+/w50fgV6f/VAZpnr2/pTQbja
        daQEDgMDLepIbb+TQTmHS4vLG4RRLnhgw/RV/vw=
X-Google-Smtp-Source: ABdhPJw+Uqa0oOkO0p0bY8FIOmb32L8hmRE8F4i3Zk/mSIK1kng6QD61ISdvYH2GgRNCxXDFkH+o7GYD2dRnZX3SoNY=
X-Received: by 2002:a05:6102:11e3:: with SMTP id e3mr1640411vsg.49.1628639387042;
 Tue, 10 Aug 2021 16:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com> <xmqqtujyftzx.fsf@gitster.g>
 <YRIZsOaguDW0HaeI@carlos-mbp.lan> <0b973579-748e-ce2f-20aa-a967765cce83@web.de>
In-Reply-To: <0b973579-748e-ce2f-20aa-a967765cce83@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 10 Aug 2021 16:49:36 -0700
Message-ID: <CAPUEspiWdGRQoBnpn_uwjkqV7ffMm+MkzbNVU1rZ6yCwkpmNaA@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] pedantic errors in next
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        e@80x24.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 12:30 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Those are different issues and they should be addressed by separate patch=
es,
> I think.  That's why I submitted a patch for the second one in
> http://public-inbox.org/git/bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de/.

agree, and that is why I mentioned not to merge mine but use your
whole series instead when it is published (mine was just a stopgap to
see if I could get SANITIZE=3Dundefined to behave meanwhile, but that I
thought would be worth making public so anyone else affected might
have something to start with)

would at least the two included in the chunks above be safe enough for
RC2 as I hope?, is the one with the additional int too hacky to be
considered for release?; FWIW hadn't been able to reproduce that issue
you reported in t3301 even with an Apple M1 with macOS 11.5.1 (I use
NO_GETTEXT=3D1 though, not sure that might be why)

Anything I can help with?

Carlo
