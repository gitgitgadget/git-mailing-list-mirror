Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457AC2BAEE
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 16:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB74720737
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 16:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh9mHsox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgCKQ4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 12:56:19 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:37706 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgCKQ4T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 12:56:19 -0400
Received: by mail-lj1-f181.google.com with SMTP id r24so3165224ljd.4
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=iJy6K5roEB9KDvwsmDCzXPo2hjDFIcudS5DkQA8nbsw=;
        b=Vh9mHsox16xphYrSCB1gEkj3eaHXUYmKHFjrEBEweptZUVOu5rcH4giegHV8uAF6Kp
         UsXQCruli60r5G08A8DHMWGh/Bl7BBfmB4n3NU+I8LtkbyUdC/LEjNl9Z7lt2TfPnup/
         LqisiZbrOX3o6q0cNdElf1dOHqv5Ng+Ud+BRY+dzHpojyhCpPg7soAejaNXJGfF3TTB+
         Iw3ljbMktV4AmOzAIGybjKuIBkq0ePNA2mYtMMSVrg3wuvYYJBxpSYK4SdvFilVzK6TD
         WyVO7+jQZO5jg8Yikg8XVFbpZ9MG9fDJjib6ugR1JaMeAikH5xqxAeVhBiZ7kAp38yFL
         NhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=iJy6K5roEB9KDvwsmDCzXPo2hjDFIcudS5DkQA8nbsw=;
        b=KvVO4ynx8YtRCEqlHoJ0IUKjqbmlET3IhwNDHRec0BkvTskxK+In+EScLO+7ZXQ5hB
         Ykt4juhQs3UaF4JrkRx/zV5jynwwJh/4Us6w1tES6yneLGkCxQwjcbYBGaPpbO6Fezux
         OctlMtFK3H/82D1nPQfsbkF3lBsZJ/Kj2D+ciFPI++/32b+jCYzLgZnaFlZtpJuye7oL
         bGa7F8KLWR42Syxg6kzW3xk/H4teEE4nWNCf+i1FxW4YwuvbIzPmYyT3ko0ntNiLjl/5
         EQm1g2r4zMJPWtqMesPkvnC5dB8P/r5UEtA7WpZ8k7ozbMri48FuoyZgiaFiWhaoDkRM
         uwSA==
X-Gm-Message-State: ANhLgQ0MVDuAPADMX3kruG8Lwr7qmepmiVxguLGvMtFDM2zZ3wJJfG5a
        D2set5JBVpU2ac98zHUknGyg5KoY74ffF5qMOlw=
X-Google-Smtp-Source: ADFU+vs+VUkBl6QVzfysc5MBWVk6a3uNCsOI2c8pZeQLWe7nL2VwhmSED/bG14Zz7qllehItK+EeZqcQk8kywLgIPIg=
X-Received: by 2002:a05:651c:30d:: with SMTP id a13mr2674386ljp.272.1583945776906;
 Wed, 11 Mar 2020 09:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BhLe0xF_k2ASV=ZuM7LVvxui_cxzB9UrJ2MDCyyNUmtw@mail.gmail.com>
 <20200311162517.GA27893@coredump.intra.peff.net>
In-Reply-To: <20200311162517.GA27893@coredump.intra.peff.net>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 11 Mar 2020 11:56:05 -0500
X-Google-Sender-Auth: xCvTWRI7DmX5ee1pXhs3foNaf2w
Message-ID: <CAHd499AGQ5k7ON+YY84b6LY1sh9MOw8fsrE2shOibujX1iKeiQ@mail.gmail.com>
Subject: Re: Using push.default with push.remote.push
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 11, 2020 at 11:25 AM Jeff King <peff@peff.net> wrote:
> > The current behavior seems to be working as designed, but not as
> > desired. The first push command pushes *all* branches under
> > `refs/heads/*`, instead of just the current branch as it normally
> > would via `push.default` setting. It sort of feels like if a resolved,
> > explicitly defined `push.<remote>.push` config is found *and* it
> > includes wildcards, the `push.default` setting should still be
> > respected.
>
> Then when would remote.*.push with a wildcard ever do anything?

Maybe this is where a potential disconnect is, but I've always viewed
the wildcard refspec as a mapping, rather than an all-inclusive "Push
all the things". In other words, I view it as more of a structural
guide than a behavioral one. I recognize I probably have this wrong,
but it probably speaks to how some users view it, or at least, some
valid use cases to have more of a structural mechanism to map branches
to remote repositories, with `git push --all` being a supplement to
say "Push all branches using this mapping".
