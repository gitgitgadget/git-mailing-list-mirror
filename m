Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64BEC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9885C61052
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhIRAXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 20:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhIRAXY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 20:23:24 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DE9C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 17:22:02 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id z62so11031584vsz.9
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 17:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cSvBOEwSEr7V1wC3/4ZrdTI7L+zRNtzZmy4nH7NyGMo=;
        b=CD1AoyByZSyTJrgcoXsU7f5hvto6NDlSvUOFeenJqtkee1ADDtoJj3zZyj6Acs3FsU
         +PgNWeVgpTVrhxfsyZd8zcpaiJ8yqowKaoEhLtHzOou34yS/G1wJ80G+eJFostqH2kSB
         Xlwcpvzy61Lh5//BbEVhgaZnTGSHZJEf6A7snKDmDSp/F0o2i5Ms/T6B1sVI3rGI5J0j
         4/SDp9RpEwWRHAJH2qvvZsaicc5uAROfVEO/Ktryy0OvYn1OFXJKpQfOIXdxT7QWVYSd
         HZmzXZzouUghG519OTBVMsuaVyXt/B4CV5zm3jGjuj3UZuXvXdPzeplZiOmErfNlY+eK
         yPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cSvBOEwSEr7V1wC3/4ZrdTI7L+zRNtzZmy4nH7NyGMo=;
        b=tH3rKEWQeSMpJ7eV8c11V3QCbipuQfXr+ts76wiwYFbHUfheHno6YGPwCk9bM0zp9u
         Tlp+3gSOp8nINgsqzrk/KS35HREpyQL9zePzZbwAuGKJHT8yn/czLmLgG5Q9nYJHyUUW
         NiXL0bSMzTRiuPJQuCEM7sT6xYRIqyliF2rJlsdYdOm7ak0rtdsyWqYqhsuxy/fy/oyJ
         H6u2yHvfkT8+IT5Kdkup/uaOTPESZkwY6pP3xG48dPkfGnJDOK5FrOR6YeZzTsjYlVuQ
         1EuZwdm60CHCFY1lEkv9J5eecuXY1IxsSxJT5p8/ERn06e4gfry4kzOQIveEKvs66nlB
         bLYQ==
X-Gm-Message-State: AOAM532FUsfUa0dx6XZDJng1pi6mWloA9DkM5cRuk2Ucn8YhucvDhLHF
        6ADevOIphaWI3G1puho5pD7qlq9Yl7X+Mny1lLA=
X-Google-Smtp-Source: ABdhPJznGWbRyrQQXTTomR2NlPVy08kbpcSfZS2f0EcOU7IntW2HwJZnHLusZwf2S6UrcMP4vxGdmu0KUNcjVLSiIz0=
X-Received: by 2002:a05:6102:1d4:: with SMTP id s20mr10780235vsq.3.1631924520294;
 Fri, 17 Sep 2021 17:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net> <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
 <xmqq4kaihqjj.fsf@gitster.g> <YUUM5VqTEtjhnfjj@coredump.intra.peff.net>
 <YUUdjNDkL7Uy5erG@carlos-mbp.lan> <xmqqr1dmg5uq.fsf@gitster.g>
In-Reply-To: <xmqqr1dmg5uq.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 17 Sep 2021 17:21:49 -0700
Message-ID: <CAPUEspg3982Wk7vdO-vFimvyApzYwUtsryZdLt1=sLfrrYngyg@mail.gmail.com>
Subject: Re: Should `@` be really a valid git tag name?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, gitmailinglist.bentolor@xoxy.net,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 4:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>
> > I was leaning towards something like that plus a Documentation update, =
but
> > noticed that the current behaviour was inconsistent, and the confusion
> > pointed out by Junio seems to indicate it is better if fully restricted=
.
>
> That is a bad move, as existing repositories may have a ref with
> such a name.

but if they do, it is currently "ambiguous" as you pointed out, and my
patch still allows the use of @ when it is not ambiguous :

  $ git branch @/1 @

so Stefano[1] is safe, and anyone that has such a ref is better of
renaming it anyway (which is something I agree we have to add code to
my patch to allow somehow)

> If we tighten anything retroactively, we probably should forgid '@'
> short-hand that stands for HEAD, I would think.

regardless of the merits of that feature, it has been in git since
~v1.8.4, so its removal will also be breaking the user experience
IMHO.

Carlo

[1] https://lore.kernel.org/git/520BC017.7050907@gmail.com/
