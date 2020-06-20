Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F80C433DF
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D18D23E1D
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu3DExoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgFTQKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFTQKI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 12:10:08 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F61C06174E
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 09:10:07 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so2217593ejq.6
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKTQBOB6lCchBHAylF8QzipWJvmrosVPJLg3ZhKOszU=;
        b=Pu3DExoZEEQ4MTJ2eqvana+laeIqKz+B51qF6sySRSylXOz6mSZdBA4bqi8IzHwJLs
         Qpf+dMXUTLZvOKi22cX2fYzprXhb2aQza2E8i1NofU1iRhHTndgPzia+sICFFTKJy4Dc
         2JjB2vbtqoF63d4tcys355+7LByZOeHTPe3fVV89NWeQABF8QJ8tnm3Wi179lSyFjsju
         jsmc9RF5Uibk8HXW+2IJUHpA54DeuGrJS+B8BGZ2d8U+YL98N3nab9g6PiR4tU3whsjb
         LsHmz7g7mrwL8qTx/zPE83mM+Vy5W+frAN0iaDzCzjvCKwnRHQPtT3j5QFtLA6gXUStn
         2rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKTQBOB6lCchBHAylF8QzipWJvmrosVPJLg3ZhKOszU=;
        b=FFER9C6IYR/XZEeVgeRF66fVXPuxjwpgNC59x3dP+aiHkW3YFS36zEzub0yl6RvGU0
         flPS+KKFHZMSqdTmfBt3a0XMAJ/agMeE7bed7aigu0RL5x4Zu/3sFiGyC+X1K8xjhz4u
         rCeceAXTinFQoef3yGhPNSVXsiYvcKaDC9duCPqIsWK3F62XP4xpw3cOE+jwlRocIKcr
         8bNh4iPnLch8ChwpdYNYwpz/zFg3cbwhmOuUbM+LVspJy40+7v+kP7VEAd1X6GnkBUKQ
         OAqih/eZPc5ID2QKEtQIbAftLSEcIMdMnjWbCOxl3nRSMi/1aUWPlJXnCb+tcTTXV/sq
         D9xA==
X-Gm-Message-State: AOAM530807mWg6EQecZM9C4J94o8/TBwZ0iYah83sKpBUqJWPzoSO4ao
        zdscBAl8TVe+rc7PMlTY+7HcRXwx1rJmB8hlLEw=
X-Google-Smtp-Source: ABdhPJy+I+BvrhdqIao1rB32gA4DD2pn6Iwd2hFPC3qfzO414VdXiji6EBha7EbwM9tqbGi8rHCUdoAUWNoP9yfT2ag=
X-Received: by 2002:a17:907:2069:: with SMTP id qp9mr3094119ejb.160.1592669405630;
 Sat, 20 Jun 2020 09:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CANgJU+WfW4mKotMwFS+2Kaq1pDysgJutJ2NhUvyvGgowk8JXsg@mail.gmail.com>
 <BY5PR19MB3400CD5482C8837E41DFEAF2909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <BY5PR19MB34004D9F72F6B66376F8E986909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CANgJU+V7MUC85n-=_yQG05w6MOmSG_ZvmQBJVTk2qRyk=7giZQ@mail.gmail.com> <BY5PR19MB34000FB239B2B7BD996A17C790980@BY5PR19MB3400.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB34000FB239B2B7BD996A17C790980@BY5PR19MB3400.namprd19.prod.outlook.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 20 Jun 2020 18:09:54 +0200
Message-ID: <CAP8UFD2t6OVFWjm76oy=+Fgo1UUepwHTpOWM8vmCYzs9hSy_ug@mail.gmail.com>
Subject: Re: Collaborative conflict resolution feature request
To:     "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     demerphq <demerphq@gmail.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 11:17 AM Curtin, Eric <Eric.Curtin@dell.com> wrote:

> Would it be reasonable if anyone could push a partial resolution but the book
> stops there (once a user hits a conflict of a conflict is must be solved
> locally)? I agree it doesn't make sense in most cases to support pushing
> recursive conflict resolutions (even though the other part of me says if the
> users wants to go down that path why stop them? You could even have a config
> setting to allow N levels of conflicts to be pushed, the default setting being
> exactly the way things are, none or 0!).
>
> I know in my project we already "fake" this functionality like pointed out in
> the first email, it's just unclean the way we do it, leaves broken commits
> in the repo, you can no longer use difftools, etc.
>
> Should I even consider this as a research idea for my thesis? Or another way
> of wording this is, if someone sent the code to the git maintainers Junio, etc.
> would it be merged into git?

I think it could be an interesting feature to add to Git, as I agree
that some people often have this kind of issues with conflicts.

What could perhaps work is to develop a new command, maybe called `git
conflict` with subcommands for example to load, save and maybe push,
fetch and resolve partial resolutions of conflicts. The conflicts
could perhaps be stored as commits in the "refs/conflicts/" ref
namespace.
